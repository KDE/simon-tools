/*
 *   Copyright (C) 2011-2012 Peter Grasch <grasch@simon-listens.org>
 *   Copyright (c) 2012 Claus Zotter <claus.zotter@gmail.com>
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
#include <QList>
#include <QStringList>
#include <QDebug>
#include <KApplication>
#include <KLocalizedString>
#include <KCmdLineArgs>
#include <KAboutData>
#include <QtGui/QApplication>
#include <QtDBus/QDBusConnection>
#include <QApplication>
#include <QProcess>

SimonTouchView::SimonTouchView(SimonTouch *logic) :
    m_logic(logic)
{
}

void SimonTouchView::restart()
{
    qDebug() << qApp->arguments()[0];
    qApp->quit();
    QProcess::startDetached(qApp->arguments()[0]);
}

void SimonTouchView::setCurrentGroup(int id)
{
    rssFeedCurrentGroup = id;
}

int SimonTouchView::getCurrentGroup()
{
    return rssFeedCurrentGroup;
}

int SimonTouchView::availableRssFeedsCount()
{
    return m_logic->rssFeedNames().count();
}

int SimonTouchView::availableRssGroupCount()
{
    return m_logic->rssFeedGroupNames().count();
}

QList<int> SimonTouchView::getFeedsFromGroup(int id)
{
    QList<int> feeds;
    feeds.clear();

    int count = 0;

    for (int i = 0; i <= m_logic->rssFeedNames().count() -1; i++)
    {
        if(m_logic->rssFeedGroups()[i] == m_logic->rssFeedGroupHandles()[id])
        {
            feeds.append(i);
            count++;
        }
    }

    return feeds;
}

int SimonTouchView::availableRssFeedsInGroup(int id)
{
    int count = 0;
    // qWarning() << "availableRssFeedsInGroup()";
    for (int i = 0; i <= m_logic->rssFeedNames().count() - 1; i++)
    {
        if (m_logic->rssFeedGroups()[i] == m_logic->rssFeedGroupHandles()[id])
        {
            count++;
        }
    }
    return count;
}



QString SimonTouchView::rssGroupTitle(int id)
{
    if (id >= availableRssGroupCount())
        return QString();

    return m_logic->rssFeedGroupNames()[id];
}

QString SimonTouchView::rssGroupIcon(int id)
{
    if (id >= availableRssGroupCount())
        return QString();

    return m_logic->rssFeedGroupIcons()[id];
}

QString SimonTouchView::rssGroupHandle(int id)
{
    if (id >= availableRssGroupCount())
        return QString();

    return m_logic->rssFeedGroupHandles()[id];
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
