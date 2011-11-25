#ifndef SKYPEVOIPPROVIDER_H
#define SKYPEVOIPPROVIDER_H

class Skype;

#include "voipprovider.h"

class SkypeVoIPProvider : public VoIPProvider
{
private:
    Skype *s;
    bool dropVoiceMail;

private slots:
    void voiceMailActive(int id);
    void voiceMessageSent();

    void incomingCall(const QString& callId, const QString& userId);
    void callStatus(const QString& callId, const QString& status);

public:
    SkypeVoIPProvider();
    void newCall(const QString& userId);
    void hangUp();
    void sendSMS(const QString& userId, const QString& message);
};

#endif // SKYPEVOIPPROVIDER_H
