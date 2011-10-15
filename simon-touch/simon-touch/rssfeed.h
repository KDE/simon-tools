#ifndef RSSFEED_H
#define RSSFEED_H

#include <QStringList>
#include <QMetaType>
#include <QAbstractListModel>
#include <QtDeclarative>

class RSSFeed : public QAbstractListModel
{
    Q_OBJECT
private:
    QStringList m_headings;
    QStringList m_articles;
    void init();

public:
    RSSFeed();
    RSSFeed(const RSSFeed& other);

    void clear();
    void feed(const QString& heading, const QString& article);

    int count();
    QString heading(int i);
    QString article(int i);

    virtual QVariant data (const QModelIndex & index, int role = Qt::DisplayRole) const;
    QModelIndex parent(const QModelIndex &child) const {
        Q_UNUSED(child);
        return QModelIndex();
    }
    int rowCount(const QModelIndex &parent=QModelIndex()) const;
};

#endif // RSSFEED_H
