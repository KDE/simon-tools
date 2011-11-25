#ifndef VOIPPROVIDER_H
#define VOIPPROVIDER_H

#include <QObject>

class VoIPProvider : public QObject
{
    Q_OBJECT

signals:
    void incomingCall(const QString& userId);

public:
    VoIPProvider();
    virtual ~VoIPProvider() {}
    virtual void newCall(const QString& userId)=0;
    virtual void hangUp()=0;
    virtual void sendSMS(const QString& userId, const QString& message) = 0;


};

#endif // VOIPPROVIDER_H
