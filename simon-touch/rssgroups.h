/*
 *   Copyright (C) 2012 Claus Zotter <claus.zotter@gmail.com>
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

#ifndef RSSGROUP_H
#define RSSGROUP_H

#include <QStringList>
#include <QMetaType>
#include <QAbstractListModel>

class RSSGroups
{
private:
    QStringList m_grouphandles;
    QStringList m_groupnames;
    QStringList m_groupicons;

public:
    RSSGroups(const QStringList& grouphandles, const QStringList& groupnames, const QStringList& groupicons);

    int count() const;

    QString grouphandle(int i) const;
    QString groupname(int i) const;
    QString groupicon(int i) const;
    QStringList groupicons() const;
    QStringList grouphandles() const;
    QStringList groupnames() const;
};

#endif // RSSGROUP_H
