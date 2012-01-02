#include "skypevoipprovider.h"
#include "libskype/skype.h"
#include <simon/eventsimulation/eventhandler.h>
#include <QKeySequence>
#include <QStringList>
#include <QDebug>

SkypeVoIPProvider::SkypeVoIPProvider() : s(new Skype)
{
    connect(s, SIGNAL(newCall(const QString&, const QString&)), this, SLOT(newCall(const QString&, const QString&)));
    connect(s, SIGNAL(callStatus(const QString&, const QString&)), this, SLOT(callStatus(const QString&, const QString&)));
    connect(s, SIGNAL(voiceMailActive(int)), this, SLOT(voiceMailActive(int)));
    connect(s, SIGNAL(voiceMessageSent()), this, SLOT(voiceMessageSent()));

    qDebug() << "Setting up skype connection";
    s->setOnline();
    qDebug() << "Done";
}

void SkypeVoIPProvider::incomingCall(const QString& callId, const QString& userId)
{
    if (dropVoiceMail) {
        s->hangUp(callId);
    }

    qDebug() << "Call: " << callId << userId;

    emit newCall(userId);
}

void SkypeVoIPProvider::callStatus(const QString &callId, const QString &status)
{
  if (status == "INPROGRESS") {
    usleep(1000000);
    s->startSendingVideo(callId);
  }
}

void SkypeVoIPProvider::newCall(const QString& userId)
{
    s->makeCall(userId);
}

void SkypeVoIPProvider::hangUp()
{
    dropVoiceMail = true;
    foreach (const QString& call, s->searchActiveCalls())
      s->hangUp(call);
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
