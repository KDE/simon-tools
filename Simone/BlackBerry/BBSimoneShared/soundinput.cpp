/*
 *   Copyright (C) 2011 Peter Grasch <grasch@simon-listens.org>
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

#include "soundinput.h"
#include "settings.h"
#include <QDebug>
#include <QMutexLocker>

#define bzero(b,len) (memset((b), '\0', (len)), (void) 0)

SoundInput::SoundInput(int channels, int sampleRate, QObject *parent) :
    QIODevice(parent),
    m_input(SoundBackend::createObject()),
    m_channels(channels),
    m_sampleRate(sampleRate),
    m_currentTime(0),
    m_peak(0),
    m_average(0),
    m_absolutePeak(0),
    m_absoluteMinAverage(maxAmp()),
    m_clipping(false),
    lastLevel(0),
    lastTimeUnderLevel(0),
    lastTimeOverLevel(0),
    sampleStartTime(0),
    waitingForSampleToStart(true),
    waitingForSampleToFinish(false),
    currentlyRecordingSample(false)
{
    qRegisterMetaType<SimonSound::State>("SimonSound::State");

    connect(m_input, SIGNAL(errorOccured(SimonSound::Error)), this, SLOT(errorOccured(SimonSound::Error)));

    // krazy:exclude=syscalls
    open(QIODevice::ReadWrite|QIODevice::Unbuffered);
}
SoundInput::~SoundInput()
{
    delete m_input;
}

bool SoundInput::init()
{
    QString device = m_input->getDefaultInputDevice();
    qDebug() << "Default input device: " << device;
    if (!m_input->prepareRecording(device, m_channels, m_sampleRate)) {
        emit error(tr("Required audio format not supported by sound hardware"));
        return false;
    }

    emit microphoneLevel(0, 0, maxAmp());
    return true;
}

bool SoundInput::startRecording()
{
    return m_input->startRecording(this);
}

bool SoundInput::stopRecording()
{
    return m_input->stopRecording();
}

void SoundInput::errorOccured(SimonSound::Error err)
{
    switch (err) {
    case SimonSound::OpenError:
        //subtle error in messages to help debugging in case of bug reports
        emit error(tr("Required audio format not fully supported by sound hardware"));
        return;
    case SimonSound::IOError:
        emit error(tr("Input error while reading from audio device"));
        return;
    case SimonSound::FatalError:
        emit error(tr("Fatal error during recording"));
        return;
    case SimonSound::BackendBusy:
        Q_ASSERT(false); //this is a programming error
        return;
    case SimonSound::UnderrunError:
        //nothing to do here, might be a slow device...
        return;
    case SimonSound::NoError:
        //yes, gcc, I can here you
        break;
    }
}


void SoundInput::dropCache()
{
    QMutexLocker l(&bufferLock);
    localBuffer.clear();
}

qint64 SoundInput::readData(char* data, qint64 maxSize)
{
    QMutexLocker l(&bufferLock);
    int length = qMin((int) maxSize, localBuffer.count());
    memcpy(data, localBuffer.data(), length);
    localBuffer = localBuffer.mid(length);
    return length;
}

void SoundInput::analyzeSoundProperties(const QByteArray &data)
{
    const short* frames = (short*) data.constData();
    m_peak = 0;
    m_average = 0;

    m_clipping = false;
    unsigned int i;
    for (i=0; i < (data.size() / sizeof(short)); i++) {
        int frame = qAbs(frames[i]);
        m_peak = qMax(m_peak, frame);
        m_average += frame;
    }

    m_average = m_average / i;

    m_absolutePeak = qMax(m_peak, m_absolutePeak);
    m_absoluteMinAverage = qMin(m_peak, m_absoluteMinAverage);

    if (m_peak >= (maxAmp()-1))
        m_clipping = true;

    emit microphoneLevel(m_peak);
}

int SoundInput::lengthToBytes(int length)
{
    return length * getLengthFactor();
}

int SoundInput::bytesToLength(int bytes)
{
    return bytes / getLengthFactor();
}

int SoundInput::getLengthFactor()
{
    return m_channels * 2 /*16 bit*/ * (m_sampleRate / 1000);
}

void SoundInput::process(QByteArray& data)
{
    qint64 thisTime = bytesToLength(data.count());
    analyzeSoundProperties(data);

    if (!Settings::voiceActivityDetection())
        return;

    int levelThreshold = Settings::cutoffLevel();
    int headMargin = Settings::headMargin();
    int tailMargin = Settings::tailMargin();
    int shortSampleCutoff = Settings::minimumSampleLength();

    bool passDataThrough = false;
    bool doneRecording = false;

    currentSample += data;
    if (peak() > levelThreshold) {
      if (lastLevel > levelThreshold) {

        //stayed above level
        if (waitingForSampleToStart) {
          if (m_currentTime + thisTime - lastTimeUnderLevel > shortSampleCutoff) {
            waitingForSampleToStart = false;
            waitingForSampleToFinish = true;
            if (!currentlyRecordingSample) {
              emit listening();
              passDataThrough = true;
              currentlyRecordingSample = true;
            }
          }
        } else {
          passDataThrough = true;
        }
      } else {
        //crossed upward
	if (waitingForSampleToInit) {
	  sampleStartTime = lastTimeUnderLevel - headMargin;
	  waitingForSampleToInit = false;
	}
	if (waitingForSampleToFinish)
	  passDataThrough = true;
      }
      lastTimeOverLevel = m_currentTime + thisTime;
    } else {
      bool silentLongerThanTailMargin = (m_currentTime + thisTime - lastTimeOverLevel > tailMargin);

      if (waitingForSampleToFinish) {
	//still append data during tail margin
	passDataThrough = true;
	if (silentLongerThanTailMargin) {
	  currentlyRecordingSample = false;
	  waitingForSampleToFinish = false;
	  waitingForSampleToStart  = true;
	  waitingForSampleToInit = true;
          doneRecording = true;
	}
      } else if (waitingForSampleToInit) {
	//get a bit of data before the first level cross
	currentSample = currentSample.right(lengthToBytes(headMargin));
      } else if (waitingForSampleToStart && !waitingForSampleToInit) {
	if (silentLongerThanTailMargin) {
	  waitingForSampleToInit = true;
	  waitingForSampleToStart = true;
	  currentSample = currentSample.right(lengthToBytes(headMargin));
	}
     }

      lastTimeUnderLevel = m_currentTime + thisTime;
    }

    lastLevel = peak();

    if (passDataThrough) {
      data = currentSample;
      currentSample.clear();
    } else
        data.clear();

    if (doneRecording)
      emit complete(sampleStartTime, m_currentTime + thisTime);
    m_currentTime += thisTime;
}

qint64 SoundInput::writeData(const char* data, qint64 maxSize)
{
    QByteArray samples = QByteArray::fromRawData(data, maxSize);
    process(samples);

    bufferLock.lock();
    localBuffer.append(samples);
    bufferLock.unlock();
    emit readyRead();
    return maxSize;
}
