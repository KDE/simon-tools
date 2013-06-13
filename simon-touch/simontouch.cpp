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

#include "simontouch.h"
#include "configuration.h"
#include "imagesmodel.h"
#include "musicmodel.h"
#include "videosmodel.h"
#include "rssgroups.h"
#include "rssfeeds.h"
#include "rssfeed.h"
#include "communicationcentral.h"
#include <QDebug>
#include <QtXml/QDomDocument>
#include <QtXml/QDomElement>
#include <QtNetwork/QNetworkAccessManager>
#include <QtNetwork/QNetworkReply>
#include <QDBusConnection>
#include <QDBusMessage>
#include <QDBusInterface>
#include <KLocalizedString>
#include <KStandardDirs>
#include <kio/job.h>
#include <kio/jobuidelegate.h>

SimonTouch::SimonTouch(Configuration *cfg, ImagesModel *img, MusicModel *music,
                       VideosModel *videos, RSSFeeds* feeds, RSSGroups* groups) :
    m_cfg(cfg),
    m_images(img), m_music(music), m_videos(videos), m_rssFeeds(feeds), m_rssGroups(groups),
    m_currentRssFeed(new RSSFeed()), m_communicationCentral(new CommunicationCentral(this)),
    //m_rssLoader(new QNetworkAccessManager(this)),
    m_keyboardProcess(new QProcess(this))
{
    setupCommunication();
    connect(m_communicationCentral, SIGNAL(activeCall(QString,QString,bool)), this, SIGNAL(activeCall(QString,QString,bool)));
    connect(m_communicationCentral, SIGNAL(callEnded()), this, SIGNAL(callEnded()));
    connect(m_communicationCentral, SIGNAL(videoAvailable()), this, SIGNAL(videoAvailable()));
    connect(m_communicationCentral, SIGNAL(videoEnded()), this, SIGNAL(videoEnded()));
}

SimonTouch::~SimonTouch()
{
    delete m_currentRssFeed;
}

QStringList SimonTouch::rssFeedGroupNames() const
{
    return m_rssGroups->groupnames();
}

QStringList SimonTouch::rssFeedGroups() const
{
    return m_rssFeeds->groups();
}

QStringList SimonTouch::rssFeedGroupIcons() const
{
    return m_rssGroups->groupicons();
}

QStringList SimonTouch::rssFeedGroupHandles() const
{
    return m_rssGroups->grouphandles();
}

QStringList SimonTouch::rssFeedNames() const
{
    return m_rssFeeds->names();
}

QStringList SimonTouch::rssFeedIcons() const
{
    return m_rssFeeds->icons();
}

void SimonTouch::fetchRssFeed(int id)
{
    m_currentRssFeed->clear();

    KUrl url = KUrl(m_rssFeeds->url(id));
    KIO::FileCopyJob *job = KIO::file_copy(url, KStandardDirs::locateLocal("tmp", "simontouch-feed-"+url.fileName()), -1, KIO::Overwrite);

    connect(job, SIGNAL(result(KJob*)), this, SLOT(rssFetchJobFinished()));
    if (!job->exec()) {
      rssFeedError();
    }
}

void SimonTouch::rssFetchJobFinished()
{
    KIO::FileCopyJob *job = static_cast<KIO::FileCopyJob*>(sender());

    if (job->error()) {
        rssFeedError();
    } else
        parseRss(job->destUrl().path());
}

void SimonTouch::enteredState(const QString& state)
{
    qDebug() << "Entered state: " << state;
    emit currentStatus(state);
}

void SimonTouch::parseRss(const QString& path)
{
    QFile f(path);
    if (!f.open(QIODevice::ReadOnly)) rssFeedError();

    QDomDocument doc;
    QByteArray xml = f.readAll();
    doc.setContent(xml);
    QDomElement rssElem = doc.firstChildElement("rss");
    QDomElement channelElem = rssElem.firstChildElement("channel");
    QDomElement item = channelElem.firstChildElement("item");
    while (!item.isNull()) {
        m_currentRssFeed->feed(item.firstChildElement("title").text(),
                               item.firstChildElement("description").text());
        item = item.nextSiblingElement("item");
    }

    emit rssFeedReady();
}

void SimonTouch::showKeyboard()
{
    m_keyboardProcess->start("onboard");
}

void SimonTouch::showCalendar()
{
    QProcess::startDetached("speechcal", QStringList() << "--stylesheet" << "/opt/astro/astro.qss");
}

void SimonTouch::showCalculator()
{
    QDBusMessage m = QDBusMessage::createMethodCall("org.simon-listens.ActionManager",
                                                    "/ActionManager",
                                                    "local.ActionManager",
                                                    "triggerCommand");
    m.setArguments(QList<QVariant>() << i18n("Calculator") << i18n("Calculator"));
    QDBusConnection::sessionBus().send(m);
}

void SimonTouch::hideKeyboard()
{
    m_keyboardProcess->terminate();
}

void SimonTouch::hideCalculator()
{
    QDBusMessage m = QDBusMessage::createMethodCall("org.simon-listens.ActionManager",
                                                    "/ActionManager",
                                                    "local.ActionManager",
                                                    "triggerCommand");
    m.setArguments(QList<QVariant>() << i18n("Calculator") << i18n("Cancel"));
    QDBusConnection::sessionBus().send(m);
    QDBusConnection::sessionBus().send(m); //cancel popup if necessary
}
void SimonTouch::readAloud(const QString& message)
{
    QDBusMessage m = QDBusMessage::createMethodCall("org.simon-listens.SimonTTS",
                                                    "/SimonTTS",
                                                    "local.SimonTTS",
                                                    "say");
    m.setArguments(QList<QVariant>() << message);
    QDBusConnection::sessionBus().send(m);
}

void SimonTouch::interruptReading()
{
    QDBusMessage m = QDBusMessage::createMethodCall("org.simon-listens.SimonTTS",
                                                    "/SimonTTS",
                                                    "local.SimonTTS",
                                                    "interrupt");
    QDBusConnection::sessionBus().send(m);
}

void SimonTouch::setupCommunication()
{
    m_communicationCentral->setupContactCollections();
}

ContactsModel* SimonTouch::contacts() const
{
    return m_communicationCentral->getContacts();
}

MessageModel* SimonTouch::messages() const
{
    return m_communicationCentral->getMessageModel();
}

void SimonTouch::callHandle(const QString& user)
{
    m_communicationCentral->callHandle(user);
}

void SimonTouch::callSkype(const QString& user)
{
    m_communicationCentral->callSkype(user);
}

void SimonTouch::callPhone(const QString& user)
{
    m_communicationCentral->callPhone(user);
}

void SimonTouch::hangUp()
{
    m_communicationCentral->hangUp();
}
void SimonTouch::pickUp()
{
    m_communicationCentral->pickUp();
}

void SimonTouch::fetchMessages(const QString& user)
{
    m_communicationCentral->getMessages(user);
}

void SimonTouch::sendSMS(const QString& user, const QString& message)
{
    m_communicationCentral->sendSMS(user, message);
}

void SimonTouch::sendMail(const QString& user, const QString& message)
{
    m_communicationCentral->sendMail(user, message);
}

void SimonTouch::readMessage(int messageIndex)
{
    m_communicationCentral->readMessage(messageIndex);
}

QWidget* SimonTouch::getVideoCallWidget()
{
    return m_communicationCentral->getVideoCallWidget();
}

void SimonTouch::requestVideoPlayback(const QString& path)
{
    qDebug() << "Requesting video playback for path: " << path;
    emit playVideo(path);
}

void SimonTouch::checkOn(const QString& target)
{
    QDBusMessage m = QDBusMessage::createMethodCall("info.echord.Astromobile.AstroLogic",
                                                    "/AstroLogic",
                                                    "info.echord.Astromobile.AstroLogic",
                                                    "checkup");
    m.setArguments(QList<QVariant>() << target);
    QDBusConnection::systemBus().send(m);
}

void SimonTouch::order(OrderType type, const QString& items)
{
    QString recipient;
    switch (type) {
      case Household:
        recipient = m_cfg->householdMailAddress();
        break;
    case Medicine:
        recipient = m_cfg->medicineMailAddress();
        break;
    }
    m_communicationCentral->sendMailToHandle(recipient, items);
}
