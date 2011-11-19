#ifndef SIMONTOUCH_H
#define SIMONTOUCH_H

#include <QObject>
#include "simontouchstate.h"

class ImagesModel;
class VideosModel;
class MusicModel;

class RSSFeeds;
class RSSFeed;
class QNetworkAccessManager;
class CommunicationCentral;
class ContactsModel;

class QProcess;

class SimonTouch : public QObject
{
Q_OBJECT

signals:
    void rssFeedReady();
    void rssFeedError();
    void currentStatus(SimonTouchState::State);

private:
    ImagesModel *m_images;
    MusicModel *m_music;
    VideosModel *m_videos;
    RSSFeeds *m_rssFeeds;
    RSSFeed *m_currentRssFeed;

    CommunicationCentral *m_communicationCentral;

    QNetworkAccessManager *m_rssLoader;

    QProcess *m_calculatorProcess;
    QProcess *m_keyboardProcess;

private slots:
    void parseRss();

public slots:
    void enteredState(SimonTouchState::State state);

public:
    SimonTouch(ImagesModel *img, MusicModel *music, VideosModel *videos, RSSFeeds* rssFeeds);
    ImagesModel* images() const { return m_images; }
    MusicModel* music() const { return m_music; }
    VideosModel* videos() const { return m_videos; }
    RSSFeed *rssFeed() const { return m_currentRssFeed; }
    ContactsModel *contacts() const;
    QStringList rssFeedNames() const;
    QStringList rssFeedIcons() const;

    void fetchRssFeed(int id);

    void showKeyboard();
    void showCalculator();
    void hideKeyboard();
    void hideCalculator();

    ContactsModel *getContacts();

    void setupCommunication();

    ~SimonTouch();
};

#endif // SIMONTOUCH_H
