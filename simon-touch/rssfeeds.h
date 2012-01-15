#ifndef RSSFEEDS_H
#define RSSFEEDS_H

#include <QStringList>

class RSSFeeds
{
private:
    QStringList m_names;
    QStringList m_urls;
    QStringList m_icons;
public:
    RSSFeeds(const QStringList& names, const QStringList& urls, const QStringList& icons);
    QString name(int i) const;
    QString url(int i) const;
    QStringList names() const;
    QStringList icons() const;
    int count() const;
};

#endif // RSSFEEDS_H
