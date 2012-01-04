#ifndef VOIPPROVIDER_H
#define VOIPPROVIDER_H

#include <QObject>
#include <QMetaType>


class VoIPProvider : public QObject
{
    Q_OBJECT

public:
    VoIPProvider();
    virtual ~VoIPProvider() {}
    virtual void newCall(const QString& userId)=0;
    virtual void hangUp()=0;
    virtual void pickUp()=0;
    virtual void sendSMS(const QString& userId, const QString& message) = 0;


    enum CallState {
        RingingRemotely=1,
        RingingLocally=2,
        Connected=3
    };

signals:
    void activeCall(const QString& userId, VoIPProvider::CallState state);
    void callEnded();
};

Q_DECLARE_METATYPE(VoIPProvider::CallState);

#endif // VOIPPROVIDER_H
