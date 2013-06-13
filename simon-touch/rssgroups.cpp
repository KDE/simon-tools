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

#include "rssgroups.h"
#include <QStringList>

RSSGroups::RSSGroups(const QStringList& grouphandles, const QStringList& groupnames, const QStringList& groupicons) :
    m_grouphandles(grouphandles), m_groupnames(groupnames), m_groupicons(groupicons)
{
    Q_ASSERT(m_grouphandles.count() == m_groupnames.count());
}

QStringList RSSGroups::grouphandles() const
{
    return m_grouphandles;
}

QStringList RSSGroups::groupnames() const
{
    return m_groupnames;
}

QStringList RSSGroups::groupicons() const
{
    return m_groupicons;
}

QString RSSGroups::groupname(int i) const
{
    return m_groupnames[i];
}

QString RSSGroups::grouphandle(int i) const
{
    return m_grouphandles[i];
}

QString RSSGroups::groupicon(int i) const
{
    return m_groupicons[i];
}
