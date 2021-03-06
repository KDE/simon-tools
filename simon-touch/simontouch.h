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

#ifndef SIMONTOUCH_H
#define SIMONTOUCH_H

#include <QObject>

class Configuration;

class ImagesModel;
class VideosModel;
class MusicModel;

class RSSGroups;
class RSSFeeds;
class RSSFeed;
class QNetworkAccessManager;
class CommunicationCentral;
class ContactsModel;
class MessageModel;

class QProcess;

class SimonTouch : public QObject
{
Q_OBJECT

signals:
    void rssFeedReady();
    void rssFeedError();
    void currentStatus(const QString&);
    void activeCall(const QString& user, const QString& avatar, bool ring);
    void callEnded();
    void videoAvailable();
    void videoEnded();
    void playVideo(const QString& path);

private:
    Configuration *m_cfg;
    ImagesModel *m_images;
    MusicModel *m_music;
    VideosModel *m_videos;
    RSSGroups *m_rssGroups;
    RSSFeeds *m_rssFeeds;
    RSSFeed *m_currentRssFeed;

    CommunicationCentral *m_communicationCentral;

    //QNetworkAccessManager *m_rssLoader;

    QProcess *m_keyboardProcess;
    void parseRss(const QString& path);

private slots:
    void rssFetchJobFinished();

public slots:
    void enteredState(const QString& state);

public:
    enum OrderType {
        Household=1,
        Medicine=2
    };

    SimonTouch(Configuration *cfg, ImagesModel *img, MusicModel *music, VideosModel *videos, RSSFeeds* rssFeeds, RSSGroups* rssGroups);
    ImagesModel* images() const { return m_images; }
    MusicModel* music() const { return m_music; }
    VideosModel* videos() const { return m_videos; }
    RSSFeed *rssFeed() const { return m_currentRssFeed; }
    ContactsModel *contacts() const;
    MessageModel *messages() const;
    QStringList rssFeedNames() const;
    QStringList rssFeedIcons() const;
    QStringList rssFeedGroups() const;
    QStringList rssFeedGroupNames() const;
    QStringList rssFeedGroupHandles() const;
    QStringList rssFeedGroupIcons() const;

    Configuration* config() const { return m_cfg; }

    void fetchRssFeed(int id);

    void showKeyboard();
    void showCalendar();
    void showCalculator();
    void hideKeyboard();
    void hideCalculator();

    ContactsModel *getContacts();

    void setupCommunication();

    void requestVideoPlayback(const QString& path);

    void callHandle(const QString& user);
    void callSkype(const QString& user);
    void callPhone(const QString& user);
    void pickUp();
    void hangUp();
    void fetchMessages(const QString& user);
    void sendSMS(const QString& user, const QString& message);
    void sendMail(const QString& user, const QString& message);
    void readMessage(int messageIndex);

    void readAloud(const QString& message);
    void interruptReading();

    QWidget *getVideoCallWidget();

    void checkOn(const QString& target);

    void order(OrderType type, const QString& items);

    ~SimonTouch();
};

#endif // SIMONTOUCH_H
