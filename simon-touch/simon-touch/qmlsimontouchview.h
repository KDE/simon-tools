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
};

#endif // QMLSIMONTOUCHVIEW_H
