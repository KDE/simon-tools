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

#ifndef RSSFEEDS_H
#define RSSFEEDS_H

#include <QStringList>

class RSSFeeds
{
private:
    QStringList m_names;
    QStringList m_urls;
    QStringList m_icons;
    QStringList m_groups;
public:
    RSSFeeds(const QStringList& names, const QStringList& urls, const QStringList& icons, const QStringList& groups);
    QString name(int i) const;
    QString url(int i) const;
    QString group(int i) const;
    QStringList names() const;
    QStringList icons() const;
    QStringList groups() const;
    int count() const;
};

#endif // RSSFEEDS_H
