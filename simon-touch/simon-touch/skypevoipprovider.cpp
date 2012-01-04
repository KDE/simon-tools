#include "skypevoipprovider.h"
#include "libskype/skype.h"
#include <simon/eventsimulation/eventhandler.h>
#include <QKeySequence>
#include <QStringList>
#include <QDebug>

SkypeVoIPProvider::SkypeVoIPProvider() : s(new Skype), dropVoiceMail(false)
{
    connect(s, SIGNAL(newCall(const QString&, const QString&)), this, SLOT(newCall(const QString&, const QString&)));
    connect(s, SIGNAL(callStatus(const QString&, const QString&)), this, SLOT(callStatus(const QString&, const QString&)));
    connect(s, SIGNAL(voiceMailActive(int)), this, SLOT(voiceMailActive(int)));
    connect(s, SIGNAL(voiceMessageSent()), this, SLOT(voiceMessageSent()));

    qDebug() << "Setting up skype connection";
    s->setOnline();
    qDebug() << "Done";
}

void SkypeVoIPProvider::newCall(const QString& callId, const QString& userId)
{
    if (dropVoiceMail) {
        s->hangUp(callId);
        dropVoiceMail = false;
        return;
    }

    qDebug() << "Call: " << callId << userId;
    calls.insert(callId, userId);

    emit activeCall(userId, s->isCallIncoming(callId) ? VoIPProvider::RingingLocally : VoIPProvider::RingingRemotely);
}

void SkypeVoIPProvider::callStatus(const QString &callId, const QString &status)
{
  qDebug() << "CALL STATUS: " << status;
  if ((status == "MISSED") || (status == "REFUSED") || (status == "FINISHED") || (status == "CANCELLED"))
      emit callEnded();
  if (status == "INPROGRESS") {
    usleep(1000000);
    s->startSendingVideo(callId);
    emit activeCall(calls.value(callId), VoIPProvider::Connected);
  }
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
