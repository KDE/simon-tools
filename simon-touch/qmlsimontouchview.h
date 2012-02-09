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

#ifndef QMLSIMONTOUCHVIEW_H
#define QMLSIMONTOUCHVIEW_H

#include "simontouchview.h"
#include "qmlapplicationviewer.h"
#include <QScopedPointer>

class RSSFeed;
class SimonTouch;
class KDeclarative;

class QDeclarativeItem;

class QMLSimonTouchView : public SimonTouchView
{
Q_OBJECT

public:
    QMLSimonTouchView(SimonTouch *logic);
    ~QMLSimonTouchView();

public slots:
    void setState(const QString& state);
    QString componentName(QDeclarativeItem* object);

    void callSkype(const QString& user);
    void callPhone(const QString& user);
    void hangUp();
    void pickUp();
    void fetchMessages(const QString& user);
    void sendSMS(const QString& user, const QString& message);
    void sendMail(const QString& user, const QString& message);

    void readMessage(int messageIndex);

    void readAloud(const QString& message);
    void interruptReading();

private:
    QWidget *dlg;
    KDeclarative *decl;
    QmlApplicationViewer *viewer;

private slots:
    void activeCall(const QString& user, const QString& avatar, bool ring);
    void callEnded();
    void videoEnabled();
    void videoEnded();
};

#endif // QMLSIMONTOUCHVIEW_H
