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
    ImagesModel* images() { return m_images; }
    MusicModel* music() { return m_music; }
    VideosModel* videos() { return m_videos; }
    RSSFeed *rssFeed() { return m_currentRssFeed; }
    QStringList rssFeedNames();
    QStringList rssFeedIcons();
    void fetchRssFeed(int id);

    void showKeyboard();
    void showCalculator();
    void hideKeyboard();
    void hideCalculator();

    void test();

    ~SimonTouch();
};

#endif // SIMONTOUCH_H
