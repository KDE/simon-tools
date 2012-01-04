#ifndef QMLSIMONTOUCHVIEW_H
#define QMLSIMONTOUCHVIEW_H

class RSSFeed;

#include "simontouchview.h"
#include "qmlapplicationviewer.h"
#include <QScopedPointer>

class SimonTouch;

class QDeclarativeItem;

class QMLSimonTouchView : public SimonTouchView
{
Q_OBJECT

public:
    QMLSimonTouchView(SimonTouch *logic);
    ~QMLSimonTouchView();

public slots:
    void setState(const QString& state);
    QString componentName(QDeclarativeItem* object);

    void callSkype(const QString& user);
    void callPhone(const QString& user);
    void hangUp();
    void pickUp();
    void fetchMessages(const QString& user);
    void sendSMS(const QString& user, const QString& message);
    void sendMail(const QString& user, const QString& message);

    void readMessage(int messageIndex);


private:
    QScopedPointer<QmlApplicationViewer> viewer;

private slots:
    void activeCall(const QString& user, const QString& avatar, bool ring);
    void callEnded();
};

#endif // QMLSIMONTOUCHVIEW_H
