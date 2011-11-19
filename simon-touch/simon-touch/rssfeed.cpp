#include "rssfeed.h"
#include <QMetaType>
#include <QStringList>
#include <QHash>
#include <QDebug>

RSSFeed::RSSFeed()
{
    init();
}

RSSFeed::RSSFeed(const RSSFeed& other)
    : QAbstractListModel(),
      m_headings(other.m_headings), m_articles(other.m_articles)
{
    init();
}

void RSSFeed::feed(const QString& heading, const QString& article)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_headings << heading;
    m_articles << article;
    endInsertRows();
}

void RSSFeed::clear()
{
    m_headings.clear();
    m_articles.clear();

    reset();
}

void RSSFeed::init()
{
    QHash<int, QByteArray> names = roleNames();
    names.insert(Qt::UserRole, "header");
    names.insert(Qt::UserRole+1, "content");
    names.insert(Qt::UserRole+2, "index");
    setRoleNames(names);
}

int RSSFeed::count() const
{
    return m_headings.count();
}

QString RSSFeed::heading(int i) const
{
    return m_headings[i];
}

QString RSSFeed::article(int i) const
{
    return m_articles[i];
}


QVariant RSSFeed::data (const QModelIndex & index, int role) const
{
    if (role == Qt::UserRole)
        return m_headings[index.row()];
    if (role == Qt::UserRole+1)
        return m_articles[index.row()];
    if (role == Qt::UserRole+2)
        return index.row();

    return QVariant();
}

int RSSFeed::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return m_articles.count();
}

