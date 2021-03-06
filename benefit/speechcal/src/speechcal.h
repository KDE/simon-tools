/*   Copyright (C) 2010 Grasch Peter <grasch@simon-listens.org>
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

#ifndef SIMON_SPEECHCAL_H_4002119636CC42C68FE07273F9000A73
#define SIMON_SPEECHCAL_H_4002119636CC42C68FE07273F9000A73

#include <QObject>
#include <QList>
#include <QStringList>
#include <KDateTime>

#include <akonadi/collection.h>
#include <akonadi/item.h>
#include <akonadi/monitor.h>

class SpeechCalView;
class KJob;
class CalendarModel;

class SpeechCal : public QObject
{
Q_OBJECT
  public:
    SpeechCal();
    virtual ~SpeechCal();
    void exec();
    void nextDay();
    void previousDay();
    void quit();
    
  private slots:
    void collectionJobFinished(KJob*);
    void itemJobFinished(KJob*);
    void setupCollections();
    void retrieveEvents();
    
  private:
    QStringList ignoredEventsPrefixes;

    SpeechCalView* view;
    CalendarModel *calendar;
    KDateTime displayDate;
    Akonadi::Collection::List collectionList;
    Akonadi::Monitor *monitor;
    
    void updateView();
    
    void collectionsReceived(Akonadi::Collection::List);
    void itemsReceived(Akonadi::Item::List);

};

#endif // SPEECHCAL_H
