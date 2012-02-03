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

#ifndef VOIPPROVIDER_H
#define VOIPPROVIDER_H

#include <QObject>
#include <QMetaType>


class VoIPProvider : public QObject
{
    Q_OBJECT

public:
    VoIPProvider();
    virtual ~VoIPProvider() {}
    virtual void newCall(const QString& userId)=0;
    virtual void hangUp()=0;
    virtual void pickUp()=0;
    virtual void sendSMS(const QString& userId, const QString& message) = 0;

    virtual QWidget *videoWidget() = 0;

    enum CallState {
        RingingRemotely=1,
        RingingLocally=2,
        Connected=3
    };

signals:
    void activeCall(const QString& userId, VoIPProvider::CallState state);
    void callEnded();
    void videoAvailable();
    void videoEnded();
};

Q_DECLARE_METATYPE(VoIPProvider::CallState);

#endif // VOIPPROVIDER_H
