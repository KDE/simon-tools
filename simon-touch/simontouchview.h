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

signals:
    void rssFeedReady();
    void rssFeedError();
    void enterState(const QString& state);

protected:
    SimonTouch *m_logic;

public:
    SimonTouchView(SimonTouch *logic);

public slots:
    int availableRssFeedsCount();
    QString rssFeedTitle(int id);
    QString rssFeedIcon(int id);
    void fetchRSSFeed(int id);
    void showKeyboard();
    void showCalculator();
    void hideKeyboard();
    void hideCalculator();
};

#endif // SIMONTOUCHVIEW_H
