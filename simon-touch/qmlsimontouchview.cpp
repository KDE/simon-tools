/*
 *   Copyright (C) 2011-2012 Peter Grasch <grasch@simon-listens.org>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License version 2,
 *   or (at your option) any later version, as published by the Free
 *   Software Foundation
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details
 *
 *   You should have received a copy of the GNU General Public
 *   License along with this program; if not, write to the
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

#include "qmlsimontouchview.h"
#include "qmlapplicationviewer.h"
#include "simontouch.h"
#include "imagesmodel.h"
#include "musicmodel.h"
#include "videosmodel.h"
#include "contactsmodel.h"
#include "configuration.h"
#include "messagemodel.h"
#include "rssfeed.h"
#include "declarativeimageprovider.h"
#include <QDeclarativeContext>
#include <QGraphicsObject>
#include <QMetaObject>
#include <QDebug>
#include <QDate>
#include <QDeclarativeComponent>
#include <kdeclarative.h>
#include <KLocalizedString>
#include <KGlobal>
#include <KLocale>

QMLSimonTouchView::QMLSimonTouchView(SimonTouch *logic) :
    SimonTouchView(logic), dlg(new QWidget()),
    decl(new KDeclarative),
    viewer(new QmlApplicationViewer())
{
    decl->setDeclarativeEngine(viewer->engine());
    decl->initialize();
    decl->setupBindings();

    viewer->engine()->addImageProvider("images", new DeclarativeImageProvider);
    viewer->rootContext()->setContextProperty("imagesModel", logic->images());
    viewer->rootContext()->setContextProperty("musicModel", logic->music());
    viewer->rootContext()->setContextProperty("videosModel", logic->videos());
    viewer->rootContext()->setContextProperty("rssFeed", logic->rssFeed());
    viewer->rootContext()->setContextProperty("contactsModel", logic->contacts());
    viewer->rootContext()->setContextProperty("messagesModel", logic->messages());
    viewer->rootContext()->setContextProperty("configuration", logic->config());
    viewer->rootContext()->setContextProperty("simonTouch", this);

    viewer->setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer->setMainQmlFile(QLatin1String("qml/simontouch/main.qml"));

    connect(logic, SIGNAL(rssFeedReady()),
            viewer->rootObject()->findChild<QObject*>("MainInformationNewsFeed"), SLOT(displayFeed()));
    connect(logic, SIGNAL(rssFeedError()),
            viewer->rootObject()->findChild<QObject*>("MainInformationNewsFeed"),
            SLOT(feedFetchError()));
    connect(logic, SIGNAL(activeCall(QString,QString,bool)),
            this, SLOT(activeCall(QString,QString,bool)));
    connect(logic, SIGNAL(callEnded()), this, SLOT(callEnded()));

    connect(logic, SIGNAL(videoAvailable()), this, SLOT(videoEnabled()));
    connect(logic, SIGNAL(videoEnded()), this, SLOT(videoEnded()));

    dlg->resize(viewer->size());
    QPalette p = dlg->palette();
    p.setColor(QPalette::Window, QColor(255,251,199));
    dlg->setPalette(p);

    QVBoxLayout *layout = new QVBoxLayout();
    layout->addWidget(viewer);
    layout->setSpacing(0);
    if (logic->getVideoCallWidget()) {
        QHBoxLayout *hBox = new QHBoxLayout();
        hBox->addStretch(1);
        hBox->addWidget(logic->getVideoCallWidget());
        hBox->addStretch(1);
        logic->getVideoCallWidget()->hide();
        layout->addLayout(hBox);
        hBox->setContentsMargins(0,0,0,0);
    }

    dlg->setLayout(layout);
    layout->setContentsMargins(0,0,0,0);

    dlg->show();
    connect(viewer->engine(), SIGNAL(quit()), dlg, SLOT(close()));
}

QString QMLSimonTouchView::date()
{
    return KGlobal::locale()->formatDate(QDate::currentDate(), KLocale::LongDate);
}

void QMLSimonTouchView::callHandle(const QString& number)
{
    qDebug() << "Calling handle: " << number;
    m_logic->callHandle(number);
}

void QMLSimonTouchView::sendHouseholdShoppingOrder(const QString& orderedItems)
{
    qDebug() << "Ordering household items: " << orderedItems;
    m_logic->order(SimonTouch::Household, i18n("Please bring me the following items:\n%1\n\nThank you!", orderedItems));
}

void QMLSimonTouchView::sendMedicineShoppingOrder(const QString& orderedItems)
{
    qDebug() << "Ordering medicine: " << orderedItems;
    m_logic->order(SimonTouch::Medicine, i18n("I require the following medicine:\n%1\n\nThank you!", orderedItems));
}

void QMLSimonTouchView::checkOn(const QString &target)
{
    qDebug() << "Checking: " << target;
    m_logic->checkOn(target);
}

void QMLSimonTouchView::readAloud(const QString& message)
{
    qDebug() << "Reading aloud " << message;
    m_logic->readAloud(message);
}

void QMLSimonTouchView::interruptReading()
{
    qDebug() << "Interrupting TTS";
    m_logic->interruptReading();
}

void QMLSimonTouchView::videoEnabled()
{
    qDebug() << "Showing video";
    QWidget *w = m_logic->getVideoCallWidget();
    if (w) {
        w->show();
        qDebug() << "Shown video widget";
    }
}

void QMLSimonTouchView::videoEnded()
{
    QWidget *w = m_logic->getVideoCallWidget();
    if (w) {
        w->hide();
        qDebug() << "Hidden video widget";
    }
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

void QMLSimonTouchView::playVideo(const QString &video)
{
    hangUp();
    QMetaObject::invokeMethod(viewer->rootObject(), "playVideo", Q_ARG(QVariant, video));
}

QMLSimonTouchView::~QMLSimonTouchView()
{
    delete viewer;
    delete decl;
}
