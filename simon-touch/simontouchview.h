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

#ifndef SIMONTOUCHVIEW_H
#define SIMONTOUCHVIEW_H

#include <QObject>

class SimonTouch;

class SimonTouchView : public QObject
{
    Q_OBJECT

private:
    int rssFeedCurrentGroup;

signals:
    void rssFeedReady();
    void rssFeedError();
    void enterState(const QString& state);

protected:
    SimonTouch *m_logic;

public:
    SimonTouchView(SimonTouch *logic);

public slots:
    void restart();
    QList<int> getFeedsFromGroup(int id);
    int availableRssFeedsInGroup(int id);
    int availableRssFeedsCount();
    int availableRssGroupCount();
    QString rssGroupTitle(int id);
    QString rssGroupIcon(int id);
    QString rssGroupHandle(int id);
    QString rssFeedTitle(int id);
    QString rssFeedIcon(int id);
    //int[] rssFeedsInGroup(int id);
    int getCurrentGroup();
    void setCurrentGroup(int id);
    void fetchRSSFeed(int id);
    void showKeyboard();
    void showCalendar();
    void showCalculator();
    void hideKeyboard();
    void hideCalculator();
    virtual void playVideo(const QString& video)=0;
};

#endif // SIMONTOUCHVIEW_H
