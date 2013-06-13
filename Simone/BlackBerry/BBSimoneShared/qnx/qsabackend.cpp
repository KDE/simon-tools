/*
 *   Copyright (C) 2011 Peter Grasch <peter.grasch@bedahr.org>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License version 2,
 *   or (at your option) any later version, as published by the Free
 *   Software Foundation
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details
 *
 *   You should have received a copy of the GNU General Public
 *   License along with this program; if not, write to the
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

#include "qsabackend.h"
#include <unistd.h>

#include <QThread>
#include <QDebug>
#include <QMutexLocker>
#include "../soundbackendclient.h"

//Basic functions to set up QSA
static int set_params(SimonSound::SoundDeviceType type, snd_pcm_t *handle,
                             int* bufferSize, int channels, unsigned int& samplerate);

class QSALoop : public QThread {
  protected:
    QSABackend *m_parent;
    bool shouldRun;
  public:
    QSALoop(QSABackend *parent) : m_parent(parent),
      shouldRun(true)
    {}

    void start() {
      shouldRun = true;
      QThread::start();
    }
    void stop() {
      shouldRun = false;
    }
};

//Capture loop
class QSACaptureLoop : public QSALoop
{
  public:
    QSACaptureLoop(QSABackend *parent) : QSALoop(parent)
    {}

    void run()
    {
      int err = 0;
      snd_pcm_channel_status_t status;
      short* buffer = (short*) malloc(sizeof(short)*m_parent->m_bufferSize+1);

      while ((err >= 0) && shouldRun) {
        ssize_t readCount = snd_pcm_plugin_read(m_parent->m_handle, buffer, m_parent->m_bufferSize);

        if (readCount < m_parent->m_bufferSize) {
            err = 0;
            memset(&status, 0, sizeof(status));
            status.channel = SND_PCM_CHANNEL_CAPTURE;
            if (snd_pcm_plugin_status(m_parent->m_handle, &status) < 0) {
                qWarning() << "Playback channel status error";
                break;
            }

            if (status.status == SND_PCM_STATUS_READY ||
                status.status == SND_PCM_STATUS_UNDERRUN) {
                if (snd_pcm_plugin_prepare(m_parent->m_handle, SND_PCM_CHANNEL_PLAYBACK) < 0) {
                    qWarning() << "Could not recover from underrun. Exit now.";
                    break;
                }
            }
        }
        m_parent->m_client->writeData((char*) buffer, readCount);
      }
      if (err < 0)
        m_parent->errorRecoveryFailed();

      m_parent->closeSoundSystem();
      free(buffer);
      shouldRun = false;
    }
};


//Playback loop
class QSAPlaybackLoop : public QSALoop
{
  public:
    QSAPlaybackLoop(QSABackend *parent) : QSALoop(parent)
    {}

    void run()
    {
        //TODO
        // Example: https://github.com/blackberry/NDK-Samples/blob/master/PlayWav/main.c
    }
};





QSABackend::QSABackend() :
  m_handle(0),
  m_loop(0),
  m_bufferSize(1024)
{
}

int QSABackend::bufferSize()
{
  return m_bufferSize;
}

QStringList QSABackend::getAvailableInputDevices()
{
  return getDevices(SimonSound::Input);
}

QStringList QSABackend::getAvailableOutputDevices()
{
  return getDevices(SimonSound::Output);
}

QStringList QSABackend::getDevices(SimonSound::SoundDeviceType type)
{
  qDebug() << "Getting device: " << type << ((type == SimonSound::Input) ? SND_PCM_OPEN_CAPTURE : SND_PCM_OPEN_PLAYBACK);
  QMutexLocker l(&m_deviceListLock);
  QStringList devStrs;

  int cardSize = 16;
  int* cards = new int[cardSize];
  int* devices = new int[cardSize];
  int err = snd_pcm_find(SND_PCM_FMT_S16_LE, &cardSize, cards, devices,
                 ((type == SimonSound::Input) ? SND_PCM_CHANNEL_CAPTURE : SND_PCM_CHANNEL_PLAYBACK));
  if (err < 0) {
      qWarning() << "Couldn't list devices: " << err;
      return devStrs;
  }

  qDebug() << "Found devices: " << cardSize;
  for (int i = 0; i < cardSize; i++) {
      char* name = new char[256];
      err = snd_card_get_name(cards[i] + devices[i], name, 256);
      if (err >= 0) {
          QString nameStr(QString::fromUtf8(name));
          qDebug() << "Name: " << nameStr;
          if (!devStrs.contains(nameStr))
              devStrs << nameStr;
      }

      delete name;
  }
  delete[] cards;
  delete[] devices;

  // add internal default that will use snd_pcm_open_preferred()
  devStrs.insert(0, "pcmPreferred");
  qDebug() << "All devices: " << devStrs;

  return devStrs;
}

snd_pcm_t* QSABackend::openDevice(SimonSound::SoundDeviceType type, const QString& device, int channels, int samplerate)
{
  qDebug() << "Opening device: " << device << channels << samplerate << type;

  snd_pcm_t *handle;

  int err = 0;
  int mode = (type == SimonSound::Input) ? SND_PCM_OPEN_CAPTURE : SND_PCM_OPEN_PLAYBACK;
  if (device == "preferred") {
    qDebug() << "Opening preferred device";
    err = snd_pcm_open_preferred(&handle, 0, 0, mode);
  } else
    err = snd_pcm_open_name(&handle, device.toLocal8Bit().data(), mode);

  if (err < 0) {
    qWarning() << "Couldn't open audio device: " << device << " - "
               << snd_strerror(err);
    handle = 0;
  } else {
    unsigned int srate = static_cast<unsigned int>(samplerate);
    if (handle && (err = set_params(type, handle,
            &m_bufferSize, channels, srate)) < 0) {
      qWarning() << "Setting of hwparams failed: " << snd_strerror(err);
      snd_pcm_close(handle);
      handle = 0;
    }
  }

  if (!handle)
    emit errorOccured(SimonSound::OpenError);

  return handle;
}

bool QSABackend::check(SimonSound::SoundDeviceType type, const QString& device, int channels, int samplerate)
{
  snd_pcm_t *handle = openDevice(type, device, channels, samplerate);

  if (handle) {
    snd_pcm_close(handle);
    return true;
  }

  return false;
}

QString QSABackend::getDefaultInputDevice()
{
  const QStringList devices = getAvailableInputDevices();
  return devices.isEmpty() ? QString() : devices.first();
}

QString QSABackend::getDefaultOutputDevice()
{
  const QStringList devices = getAvailableOutputDevices();
  return devices.isEmpty() ? QString() : devices.first();
}

void QSABackend::errorRecoveryFailed()
{
  emit errorOccured(SimonSound::FatalError);
  stopRecording();
}

// stop playback / recording
bool QSABackend::stop()
{
  if (state() == SimonSound::IdleState)
    return true;

  Q_ASSERT(m_loop); //should be here if we are active

  m_loop->stop();
  m_loop->wait();
  delete m_loop;
  m_loop = 0;

  emit stateChanged(SimonSound::IdleState);

  return true;
}

bool QSABackend::closeSoundSystem()
{
  snd_pcm_close(m_handle);
  emit stateChanged(SimonSound::IdleState);
  m_handle = 0;
  return true;
}

///////////////////////////////////////
// Recording  /////////////////////////
///////////////////////////////////////

bool QSABackend::prepareRecording(const QString& device, int& channels, int& samplerate)
{
  if (m_handle || (m_loop && m_loop->isRunning())) {
    emit errorOccured(SimonSound::BackendBusy);
    return false;
  }

  m_handle = openDevice(SimonSound::Input, device, channels, samplerate);
  m_loop = (m_loop) ? m_loop : new QSACaptureLoop(this);
  emit stateChanged(SimonSound::PreparedState);

  return m_handle;
}

bool QSABackend::startRecording(SoundBackendClient *client)
{
  m_client = client;

  if (!m_handle || !m_loop) return false;

  //starting recording
  m_loop->start();
  emit stateChanged(SimonSound::ActiveState);
  return true;
}

bool QSABackend::stopRecording()
{

  return stop();
}

///////////////////////////////////////
// Playback  //////////////////////////
///////////////////////////////////////

bool QSABackend::preparePlayback(const QString& device, int& channels, int& samplerate)
{
  if (m_handle || (m_loop && m_loop->isRunning())) {
    emit errorOccured(SimonSound::BackendBusy);
    return false;
  }

  m_handle = openDevice(SimonSound::Output, device, channels, samplerate);
  m_loop = new QSAPlaybackLoop(this);
  emit stateChanged(SimonSound::PreparedState);

  return m_handle;
}

bool QSABackend::startPlayback(SoundBackendClient *client)
{
  m_client = client;

  if (!m_handle || !m_loop) return false;

  //starting playback
  m_loop->start();
  emit stateChanged(SimonSound::ActiveState);
  return true;
}

bool QSABackend::stopPlayback()
{
  return stop();
}

QSABackend::~QSABackend()
{
  if (state() != SimonSound::IdleState)
    stop();
}


static int set_params(SimonSound::SoundDeviceType type, snd_pcm_t *handle,
                             int* bufferSize, int channels, unsigned int& samplerate)
{
    qDebug() << "Setting parameters...";
    int err = 0;
    int mode = (type == SimonSound::Input) ? SND_PCM_CHANNEL_CAPTURE : SND_PCM_CHANNEL_PLAYBACK;
    snd_pcm_channel_info_t *info = new snd_pcm_channel_info_t;
    memset(info, 0, sizeof(snd_pcm_channel_info_t));
    info->channel = mode;
    err = snd_pcm_plugin_info(handle, info);
    if (err < 0) {
        delete info;
        qWarning() << "Failed to get device capabilities";
        return err;
    }
    qDebug() << "Device capabilities: Format: " << info->formats << " Min rate: " << info->min_rate <<
                " max rate: " << info->max_rate << " min channels: " << info->min_voices <<
                "max channels: " << info->max_voices;

    snd_pcm_channel_params_t *params = new snd_pcm_channel_params_t;
    memset(params, 0, sizeof(snd_pcm_channel_params_t));
    params->channel = mode;
    params->mode = SND_PCM_MODE_BLOCK;
    params->format.interleave = 1;
    params->format.format = SND_PCM_SFMT_S16_LE;
    params->format.rate = samplerate;
    params->format.voices = channels;
    params->start_mode = SND_PCM_START_DATA;
    params->stop_mode = SND_PCM_STOP_ROLLOVER;
    params->buf.block.frag_size = (info->min_fragment_size + info->max_fragment_size) / 2;
    //params->buf.block.frags_max = -1;
    params->buf.block.frags_min =  1;
    strcpy(params->sw_mixer_subchn_name, "Wave recording channel");

    err = snd_pcm_plugin_params(handle, params);
    if (err < 0) {
        qDebug() << "Failed to set plugin params..." << err;
        delete info;
        delete params;
        return err;
    }

    ///////////////////
    delete info;
    delete params;
    err = snd_pcm_plugin_prepare(handle, mode);
    if (err < 0) {
        qDebug() << "snd_pcm_plugin_prepare failed";
        return err;
    }

    snd_mixer_group_t group;
    snd_pcm_channel_setup_t setup;
    memset(&setup, 0, sizeof(setup));
    memset(&group, 0, sizeof(group));
    setup.channel = mode;
    setup.mixer_gid = &group.gid;
    err = snd_pcm_plugin_setup(handle, &setup);
    if (err < 0) {
        qDebug() << "snd_pcm_plugin_setup failed";
        return err;
    }

    *bufferSize = setup.buf.block.frag_size;

    return err;
}
