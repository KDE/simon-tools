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

#include "simontouchview.h"
#include "simontouch.h"
#include <QStringList>

SimonTouchView::SimonTouchView(SimonTouch *logic) :
    m_logic(logic)
{
}

int SimonTouchView::availableRssFeedsCount()
{
    return m_logic->rssFeedNames().count();
}

QString SimonTouchView::rssFeedTitle(int id)
{
    if (id >= availableRssFeedsCount())
        return QString();

    return m_logic->rssFeedNames()[id];
}

QString SimonTouchView::rssFeedIcon(int id)
{
    if (id >= availableRssFeedsCount())
        return QString();

    return m_logic->rssFeedIcons()[id];
}

void SimonTouchView::fetchRSSFeed(int id)
{
    m_logic->fetchRssFeed(id);
}

void SimonTouchView::showKeyboard()
{
    m_logic->showKeyboard();
}

void SimonTouchView::showCalendar()
{
    m_logic->showCalendar();
}

void SimonTouchView::showCalculator()
{
    m_logic->showCalculator();
}

void SimonTouchView::hideCalculator()
{
    m_logic->hideCalculator();
}

void SimonTouchView::hideKeyboard()
{
    m_logic->hideKeyboard();
}
