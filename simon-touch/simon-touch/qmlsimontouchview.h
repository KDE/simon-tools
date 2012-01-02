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
private:
    QScopedPointer<QmlApplicationViewer> viewer;

public:
    QMLSimonTouchView(SimonTouch *logic);
    ~QMLSimonTouchView();

public slots:
    void setState(const QString& state);
    QString componentName(QDeclarativeItem* object);

    void callSkype(const QString& user);
    void callPhone(const QString& user);
    void hangUp();
    void fetchMessages(const QString& user);
    void sendSMS(const QString& user, const QString& message);
    void sendMail(const QString& user, const QString& message);

    void readMessage(int messageIndex);
};

#endif // QMLSIMONTOUCHVIEW_H
