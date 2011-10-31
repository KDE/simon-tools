#include "simontouch.h"
#include "imagesmodel.h"
#include "musicmodel.h"
#include "videosmodel.h"
#include "rssfeeds.h"
#include "rssfeed.h"
#include <QDebug>
#include <QtXml/QDomDocument>
#include <QtXml/QDomElement>
#include <QtNetwork/QNetworkAccessManager>
#include <QtNetwork/QNetworkReply>

SimonTouch::SimonTouch(ImagesModel *img, MusicModel *music, VideosModel *videos,
                       RSSFeeds* feeds) :
    m_images(img), m_music(music), m_videos(videos), m_rssFeeds(feeds),
    m_currentRssFeed(new RSSFeed()), m_rssLoader(new QNetworkAccessManager(this)),
    m_calculatorProcess(new QProcess(this)), m_keyboardProcess(new QProcess(this))
{
}

SimonTouch::~SimonTouch()
{
    delete m_currentRssFeed;
}

QStringList SimonTouch::rssFeedNames()
{
    return m_rssFeeds->names();
}

QStringList SimonTouch::rssFeedIcons()
{
    return m_rssFeeds->icons();
}

void SimonTouch::fetchRssFeed(int id)
{
    m_currentRssFeed->clear();

    QNetworkReply *reply = m_rssLoader->get(QNetworkRequest(m_rssFeeds->url(id)));
    connect(reply, SIGNAL(error(QNetworkReply::NetworkError)), this, SIGNAL(rssFeedError()));
    connect(reply, SIGNAL(finished()), this, SLOT(parseRss()));
}

void SimonTouch::enteredState(SimonTouchState::State state)
{
    qDebug() << "Entered state: " << state;
    emit currentStatus(state);
}

void SimonTouch::parseRss()
{
    QNetworkReply *reply = qobject_cast<QNetworkReply*>(sender());
    if (!reply) return;

    QDomDocument doc;
    QByteArray xml = reply->readAll();
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

void SimonTouch::showCalculator()
{
    m_calculatorProcess->start("gcalctool");
}

void SimonTouch::hideKeyboard()
{
    m_keyboardProcess->terminate();
}

void SimonTouch::hideCalculator()
{
    m_calculatorProcess->terminate();
}
