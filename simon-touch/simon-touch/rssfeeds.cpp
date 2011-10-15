#include "rssfeeds.h"
#include <QStringList>

RSSFeeds::RSSFeeds(const QStringList& names, const QStringList& urls, const QStringList& icons) :
    m_names(names), m_urls(urls), m_icons(icons)
{
    Q_ASSERT(m_names.count() == m_urls.count());
    Q_ASSERT(m_names.count() == m_icons.count());
}

QStringList RSSFeeds::names()
{
    return m_names;
}

QStringList RSSFeeds::icons()
{
    return m_icons;
}

QString RSSFeeds::name(int i)
{
    return m_names[i];
}

QString RSSFeeds::url(int i)
{
    return m_urls[i];
}

int RSSFeeds::count()
{
    return m_urls.count();
}
