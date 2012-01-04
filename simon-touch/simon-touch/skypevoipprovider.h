#ifndef SKYPEVOIPPROVIDER_H
#define SKYPEVOIPPROVIDER_H

class Skype;

#include "voipprovider.h"
#include <QHash>

class SkypeVoIPProvider : public VoIPProvider
{
    Q_OBJECT
private:
    QHash<QString /*callId*/, QString /*user*/> calls;
    Skype *s;
    bool dropVoiceMail;

private slots:
    void voiceMailActive(int id);
    void voiceMessageSent();

    void newCall(const QString& callId, const QString& userId);
    void callStatus(const QString& callId, const QString& status);

public:
    SkypeVoIPProvider();
    void newCall(const QString& userId);
    void hangUp();
    void pickUp();
    void sendSMS(const QString& userId, const QString& message);
};

#endif // SKYPEVOIPPROVIDER_H
