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

#ifndef SIMON_QSABACKEND_H_BAC60651BE6A419EA6156220815A2AAD
#define SIMON_QSABACKEND_H_BAC60651BE6A419EA6156220815A2AAD

#include <cpp/c/ctime>
#include <QMutex>
#include "../soundbackend.h"
#include <sys/asoundlib.h>

class QSALoop;
class QSACaptureLoop;
class QSAPlaybackLoop;

class QSABackend : public SoundBackend
{
  friend class QSAPlaybackLoop;
  friend class QSACaptureLoop;

  private:
    QMutex m_deviceListLock;

    snd_pcm_t *m_handle;
    QSALoop *m_loop;

    int m_bufferSize;
    QStringList getDevices(SimonSound::SoundDeviceType type);

    snd_pcm_t* openDevice(SimonSound::SoundDeviceType type, 
        const QString& device, int channels, int samplerate);

  protected:
    void errorRecoveryFailed();
    bool stop();
    bool closeSoundSystem();

  public:
    QSABackend();
    ~QSABackend();

    QStringList getAvailableInputDevices();
    QStringList getAvailableOutputDevices();
    bool check(SimonSound::SoundDeviceType type, const QString& device, int channels, int samplerate);

    QString getDefaultInputDevice();
    QString getDefaultOutputDevice();

    bool prepareRecording(const QString& device, int& channels, int& samplerate);
    bool startRecording(SoundBackendClient *client);
    bool stopRecording();

    bool preparePlayback(const QString& device, int& channels, int& samplerate);
    bool startPlayback(SoundBackendClient *client);
    bool stopPlayback();

    int bufferSize();
};

#endif


