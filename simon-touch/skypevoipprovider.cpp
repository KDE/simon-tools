/*
 *   Copyright (C) 2011-2012 Peter Grasch <grasch@simon-listens.org>
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

#include "skypevoipprovider.h"
#include "libskype/skype.h"
#include <simon/eventsimulation/eventhandler.h>
#include <QKeySequence>
#include <QStringList>
#include <QDebug>

#ifdef Q_OS_LINUX
#include <QX11EmbedContainer>
#include <QTimer>

#include <KWindowSystem>
#include <KWindowInfo>
#endif

#include <KLocalizedString>

SkypeVoIPProvider::SkypeVoIPProvider() : s(new Skype), dropVoiceMail(false)
{
#ifdef Q_OS_LINUX
    videoContainer = new QX11EmbedContainer();
    videoContainer->setMinimumHeight(280);
    videoContainer->setMaximumHeight(280);
    videoContainer->setMinimumWidth(347);
    videoContainer->setMaximumWidth(347);
#endif

    connect(s, SIGNAL(newCall(QString,QString)), this, SLOT(newCall(QString,QString)));
    connect(s, SIGNAL(callStatus(QString,QString)), this, SLOT(callStatus(QString,QString)));
    connect(s, SIGNAL(voiceMailActive(int)), this, SLOT(voiceMailActive(int)));
    connect(s, SIGNAL(voiceMessageSent()), this, SLOT(voiceMessageSent()));
    connect(s, SIGNAL(videoEnabled(QString)), this, SLOT(processVideo()));

    qDebug() << "Setting up skype connection";
    s->setOnline();
    qDebug() << "Done";
}

QWidget* SkypeVoIPProvider::videoWidget()
{
#ifdef Q_OS_LINUX
    return videoContainer;
#else
    return 0;
#endif
}

void SkypeVoIPProvider::processVideo()
{
#ifdef Q_OS_LINUX
    QTimer::singleShot(1500, this, SLOT(realVideoProcessing()));
#endif
}

void SkypeVoIPProvider::realVideoProcessing()
{
#ifdef Q_OS_LINUX
    QList<WId> windows = KWindowSystem::windows();
    QList<WId>::ConstIterator it;

    for ( it = windows.begin();
          it != windows.end(); ++it ) {

        //skype window "Call with..."
        KWindowInfo info = KWindowSystem::windowInfo(*it, KWindowSystem::WMName);
        if (info.valid()) {
            if (info.name().contains(QRegExp(i18nc("Regular expression that is supposed to match the skype window title for an active call", " \\\\| Call with ")))) {
                videoContainer->embedClient(*it);
                emit videoAvailable();
                return;
            }
            qDebug() << "Window: " << info.name();
        }
    }
    // not found this time, try again in a second
    QTimer::singleShot(1000, this, SLOT(realVideoProcessing()));
#endif
}

SkypeVoIPProvider::~SkypeVoIPProvider()
{
#ifdef Q_OS_LINUX
    delete videoContainer;
#endif
}

void SkypeVoIPProvider::newCall(const QString& callId, const QString& userId)
{
    if (dropVoiceMail) {
        s->hangUp(callId);
        dropVoiceMail = false;
        return;
    }
    calls.insert(callId, userId);

    emit activeCall(userId, s->isCallIncoming(callId) ? VoIPProvider::RingingLocally : VoIPProvider::RingingRemotely);
}

void SkypeVoIPProvider::callStatus(const QString &callId, const QString &status)
{
  qDebug() << "CALL STATUS: " << status;
  if ((status == "MISSED") || (status == "REFUSED") || (status == "FINISHED") || (status == "CANCELLED") || (status == "FAILED")) {
      emit callEnded();
      emit videoEnded();
  }
  if (status == "INPROGRESS") {
    emit activeCall(calls.value(callId), VoIPProvider::Connected);
    QTimer::singleShot(500, this, SLOT(startVideoStream()));
  }
}

void SkypeVoIPProvider::startVideoStream()
{
    foreach (const QString& callId, s->searchActiveCalls())
        s->startSendingVideo(callId);
}

void SkypeVoIPProvider::newCall(const QString& userId)
{
    s->makeCall(userId);
}

void SkypeVoIPProvider::hangUp()
{
    if (s->searchActiveCalls().count() > 0)
        foreach (const QString& call, s->searchActiveCalls())
          s->hangUp(call);
    else
        dropVoiceMail = true;
    calls.clear();
}

void SkypeVoIPProvider::pickUp()
{
    foreach (const QString& c, s->searchActiveCalls())
        s->acceptCall(c);
}

void SkypeVoIPProvider::sendSMS(const QString& userId, const QString& message)
{
    s->sendSMS(userId, message);
}


void SkypeVoIPProvider::voiceMessageSent()
{
  qDebug() << "Sent voice message!";
  EventHandler::getInstance()->sendShortcut(QKeySequence("Meta+Shift+C"));
}

void SkypeVoIPProvider::voiceMailActive(int id)
{
  if (!dropVoiceMail) return;
  s->stopVoiceMail(id);
}
