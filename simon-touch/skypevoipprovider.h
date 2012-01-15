#ifndef SKYPEVOIPPROVIDER_H
#define SKYPEVOIPPROVIDER_H

class Skype;

#include "voipprovider.h"
#include <QHash>

#ifdef Q_OS_LINUX
class QX11EmbedContainer;
#endif


class SkypeVoIPProvider : public VoIPProvider
{
    Q_OBJECT

public:
    SkypeVoIPProvider();
    ~SkypeVoIPProvider();
    void newCall(const QString& userId);
    void hangUp();
    void pickUp();
    void sendSMS(const QString& userId, const QString& message);
    QWidget *videoWidget();

private:
    QHash<QString /*callId*/, QString /*user*/> calls;
    Skype *s;
    bool dropVoiceMail;

#ifdef Q_OS_LINUX
    QX11EmbedContainer *videoContainer;
#endif

private slots:
    void voiceMailActive(int id);
    void voiceMessageSent();

    void newCall(const QString& callId, const QString& userId);
    void callStatus(const QString& callId, const QString& status);

    void processVideo();
    void realVideoProcessing();

    void startVideoStream();
};

#endif // SKYPEVOIPPROVIDER_H
