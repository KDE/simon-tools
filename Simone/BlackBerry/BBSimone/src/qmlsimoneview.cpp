/*
 *   Copyright (C) 2011 Peter Grasch <grasch@simon-listens.org>
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

#include "qmlsimoneview.h"
#include "qmlapplicationviewer/qmlapplicationviewer.h"
#include "settings.h"
#include <QMetaObject>
#include <QGraphicsObject>
#include <QDeclarativeContext>
#include <QStringList>
#include <QDebug>

QMLSimoneView::QMLSimoneView(QObject *parent) :
    SimoneView(parent),
    viewer(new QmlApplicationViewer()), state(Unconnected),
    skipNonEssentialUIUpdates(false)
{
    viewer->setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer->rootContext()->setContextProperty("simoneView", this);
    viewer->setMainQmlFile(QLatin1String("app/native/res/qml/simone/main.qml"));

    connect(connectButton(), SIGNAL(clicked()),
                                 this, SLOT(connectClicked()));
    connect(disconnectButton(), SIGNAL(clicked()),
                                 this, SIGNAL(disconnectFromServer()));

    restoreConfiguration();

}

QMLSimoneView::~QMLSimoneView()
{
    delete viewer;
}

void QMLSimoneView::pauseUpdates()
{
    qDebug() << "Pause";
    skipNonEssentialUIUpdates = true;
}

void QMLSimoneView::resumeUpdates()
{
    qDebug() << "Resume";
    skipNonEssentialUIUpdates = false;
}

void QMLSimoneView::connectClicked()
{
    storeConfiguration();
    emit connectToServer();
}

void QMLSimoneView::startRecordingRequested()
{
    if (state != Active)
        return;
    emit startRecording();
}

void QMLSimoneView::commitRecordingRequested()
{
    if (state != Active)
        return;
    emit commitRecording();
}

void QMLSimoneView::displayStatus(const QString& status)
{
    qDebug() << "Display status" << status;
    QObject *lbStatus = viewer->rootObject()->findChild<QObject*>("lbStatus");
    lbStatus->setProperty("text", status);
}

void QMLSimoneView::displayError(const QString& error)
{
    qDebug() << "Error: " << error;
    QMetaObject::invokeMethod(viewer->rootObject()->findChild<QObject*>("errorDialog"),
                              "show", Q_ARG(QVariant, error));
}

void QMLSimoneView::displayExecutedAction(const QString& action)
{
    QMetaObject::invokeMethod(viewer->rootObject()->findChild<QObject*>("recognitionResultBanner"),
                              "recognized", Q_ARG(QVariant, tr("You said: \"%1\"").arg(action)));
}

void QMLSimoneView::displayConnectionState(ConnectionState state_)
{
    state = state_;
    //qDebug() << "State changed: " << state;

    QObject *cb = connectButton();
    switch (state) {
    case Unconnected:
        cb->setProperty("text", tr("Connect"));
        break;
    case Connecting:
        cb->setProperty("text", tr("Connecting..."));
        break;
    default:
        cb->setProperty("text", tr("Connected"));
    }


    QObject *db = disconnectButton();
    switch (state) {
    case ConnectedWaiting:
        db->setProperty("text", tr("Disconnect"));
        break;
    case Connected:
    case Active:
        db->setProperty("text", tr("Disconnect"));
        break;
    case Disconnecting:
        db->setProperty("text", tr("Disconnecting..."));
        break;
    default:
        db->setProperty("text", tr("Disconnected"));
        break;
    }

    viewer->rootObject()->setProperty("state",
        ((state == Unconnected) || (state == Connecting)) ? "disconnected" :
                        ((state == Active) ? "activated" : "connected"));
}

void QMLSimoneView::displayMicrophoneLevel(int level, int min, int max)
{
    if (skipNonEssentialUIUpdates)
        return;

    QObject *pbVUMeter = viewer->rootObject()->findChild<QObject*>("pbVUMeter");
    if (min != -1)
        pbVUMeter->setProperty("minimumValue", min);
    if (max != -1)
        pbVUMeter->setProperty("maximumValue", max);
    pbVUMeter->setProperty("value", level);
}

void QMLSimoneView::displayListening()
{
    speakLabel()->setProperty("text", tr("Listening..."));
}

void QMLSimoneView::displayRecognizing()
{
    speakLabel()->setProperty("text", tr("Please speak"));
}

void QMLSimoneView::restoreConfiguration()
{
    qDebug() << "Restoring configuration";
    QObject *rootObject = viewer->rootObject();
    rootObject->findChild<QObject*>("cbAutoConnect")->setProperty("checked", Settings::autoConnect());
    rootObject->findChild<QObject*>("teHost")->setProperty("text", Settings::host());
    rootObject->findChild<QObject*>("tePort")->setProperty("text", QString::number(Settings::port()));
    rootObject->findChild<QObject*>("teUserName")->setProperty("text", Settings::user());
    rootObject->findChild<QObject*>("tePassword")->setProperty("text", Settings::password());
    rootObject->findChild<QObject*>("cbPushToTalk")->setProperty("checked", !Settings::voiceActivityDetection());

    qDebug() << "Restoring configuration: Done";
}

void QMLSimoneView::storeConfiguration()
{
    qDebug() << "Storing configuration";
    QObject *rootObject = viewer->rootObject();
    Settings::setAutoConnect(rootObject->findChild<QObject*>("cbAutoConnect")->property("checked").toBool());
    Settings::setHost(rootObject->findChild<QObject*>("teHost")->property("text").toString());
    Settings::setPort(rootObject->findChild<QObject*>("tePort")->property("text").toInt());
    Settings::setUser(rootObject->findChild<QObject*>("teUserName")->property("text").toString());
    Settings::setPassword(rootObject->findChild<QObject*>("tePassword")->property("text").toString());
    Settings::setVoiceActivityDetection(!rootObject->findChild<QObject*>("cbPushToTalk")->property("checked").toBool());
    Settings::store();

    emit configurationChanged();
}

void QMLSimoneView::show()
{
#ifndef Q_OS_BLACKBERRY
    viewer->showNormal();
#else
    viewer->showFullScreen();
#endif
}

QObject* QMLSimoneView::connectButton()
{
    return viewer->rootObject()->findChild<QObject*>("btConnect");
}

QObject* QMLSimoneView::disconnectButton()
{
    return viewer->rootObject()->findChild<QObject*>("btDisconnect");
}

QObject* QMLSimoneView::speakButton()
{
    return viewer->rootObject()->findChild<QObject*>("btSpeak");
}

QObject* QMLSimoneView::speakLabel()
{
    return viewer->rootObject()->findChild<QObject*>("lbSpeak");
}

void QMLSimoneView::recognized(const RecognitionResultList& list)
{
    qDebug() << "Recognized: " << list.count();
    if (list.isEmpty())
        return;
    displayExecutedAction(list.first().sentence());
}
