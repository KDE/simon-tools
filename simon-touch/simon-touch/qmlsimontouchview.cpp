#include "qmlsimontouchview.h"
#include <QDeclarativeContext>
#include <QGraphicsObject>
#include <QMetaObject>
#include <QDebug>
#include <QDeclarativeComponent>
#include "qmlapplicationviewer.h"
#include "simontouch.h"
#include "imagesmodel.h"
#include "musicmodel.h"
#include "videosmodel.h"
#include "contactsmodel.h"
#include "messagemodel.h"
#include "rssfeed.h"
#include "declarativeimageprovider.h"

QMLSimonTouchView::QMLSimonTouchView(SimonTouch *logic) :
    SimonTouchView(logic), viewer(QmlApplicationViewer::create())
{
    viewer->engine()->addImageProvider("images", new DeclarativeImageProvider);
    viewer->rootContext()->setContextProperty("imagesModel", logic->images());
    viewer->rootContext()->setContextProperty("musicModel", logic->music());
    viewer->rootContext()->setContextProperty("videosModel", logic->videos());
    viewer->rootContext()->setContextProperty("rssFeed", logic->rssFeed());
    viewer->rootContext()->setContextProperty("contactsModel", logic->contacts());
    viewer->rootContext()->setContextProperty("messagesModel", logic->messages());
    viewer->rootContext()->setContextProperty("simonTouch", this);

    viewer->setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer->setMainQmlFile(QLatin1String("qml/simontouch/main.qml"));
    viewer->showExpanded();
//    viewer->showFullScreen();

    connect(logic, SIGNAL(rssFeedReady()),
            viewer->rootObject()->findChild<QObject*>("MainInformationNewsFeed"), SLOT(displayFeed()));
    connect(logic, SIGNAL(rssFeedError()),
            viewer->rootObject()->findChild<QObject*>("MainInformationNewsFeed"),
            SLOT(feedFetchError()));
    connect(logic, SIGNAL(activeCall(QString,QString,bool)),
            this, SLOT(activeCall(QString,QString,bool)));
    connect(logic, SIGNAL(callEnded()), this, SLOT(callEnded()));
}
void QMLSimonTouchView::callSkype(const QString& user)
{
    m_logic->callSkype(user);
}

void QMLSimonTouchView::callPhone(const QString& user)
{
    m_logic->callPhone(user);
}

void QMLSimonTouchView::hangUp()
{
    m_logic->hangUp();
}
void QMLSimonTouchView::pickUp()
{
    m_logic->pickUp();
}

void QMLSimonTouchView::fetchMessages(const QString& user)
{
    m_logic->fetchMessages(user);
}

void QMLSimonTouchView::sendSMS(const QString& user, const QString& message)
{
    m_logic->sendSMS(user, message);
}

void QMLSimonTouchView::sendMail(const QString& user, const QString& message)
{
    m_logic->sendMail(user, message);
}

void QMLSimonTouchView::readMessage(int messageIndex)
{
    m_logic->readMessage(messageIndex);
}

void QMLSimonTouchView::setState(const QString& state)
{
    emit enterState(state);
}

QString QMLSimonTouchView::componentName(QDeclarativeItem* object)
{
    return object->metaObject()->className();
}

void QMLSimonTouchView::activeCall(const QString& user, const QString& avatar, bool ring)
{
    qDebug() << "QML view: activeCall(): " << user << avatar << ring;
    QObject *activeCall = viewer->rootObject()->findChild<QObject*>("MainActiveCall");
    activeCall->setProperty("callImage", avatar);
    activeCall->setProperty("callName", user);
    activeCall->setProperty("visibleAccept", ring);

    qDebug() << "Main menu: " << viewer->rootObject()->findChild<QObject*>("mainMenu");
    viewer->rootObject()->findChild<QObject*>("mainMenu")->setProperty("current", "MainActiveCall");
}

void QMLSimonTouchView::callEnded()
{
    viewer->rootObject()->findChild<QObject*>("mainMenu")->setProperty("current", "MainScreen");
}

QMLSimonTouchView::~QMLSimonTouchView()
{
}
