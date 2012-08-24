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

#include "rssfeeds.h"
#include <QStringList>

RSSFeeds::RSSFeeds(const QStringList& names, const QStringList& urls, const QStringList& icons, const QStringList& groups) :
    m_names(names), m_urls(urls), m_icons(icons), m_groups(groups)
{
    Q_ASSERT(m_names.count() == m_urls.count());
    Q_ASSERT(m_names.count() == m_icons.count());
    Q_ASSERT(m_names.count() == m_groups.count());
}

QStringList RSSFeeds::names() const
{
    return m_names;
}

QStringList RSSFeeds::icons() const
{
    return m_icons;
}

QStringList RSSFeeds::groups() const
{
    return m_groups;
}

QString RSSFeeds::name(int i) const
{
    return m_names[i];
}

QString RSSFeeds::url(int i) const
{
    return m_urls[i];
}

QString RSSFeeds::group(int i) const
{
    return m_groups[i];
}

int RSSFeeds::count() const
{
    return m_urls.count();
}
