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
    //QStringList m_groups;
    void init();

public:
    RSSFeed();
    RSSFeed(const RSSFeed& other);

    void clear();
    void feed(const QString& heading, const QString& article);

    int count() const;
    QString heading(int i) const;
    QString article(int i) const;
    //QString group(int i) const;

    virtual QVariant data (const QModelIndex & index, int role = Qt::DisplayRole) const;
    QModelIndex parent(const QModelIndex &child) const {
        Q_UNUSED(child);
        return QModelIndex();
    }
    int rowCount(const QModelIndex &parent=QModelIndex()) const;
};

#endif // RSSFEED_H
