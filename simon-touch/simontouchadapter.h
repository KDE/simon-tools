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

#ifndef SIMONTOUCHADAPTER_H
#define SIMONTOUCHADAPTER_H

#include <QtDBus/QtDBus>

class SimonTouch;

class SimonTouchAdapter : public QDBusAbstractAdaptor
{
    Q_OBJECT
    Q_CLASSINFO("D-Bus Interface", "local.SimonTouch")
    Q_CLASSINFO("D-Bus Introspection", ""
                "<interface name=\"local.SimonTouch\">\n"
                "<signal name=\"statusChanged\" />\n"
                "<method name=\"currentStatus\">\n"
                   "<arg type=\"s\" direction=\"out\"/>\n"
                "</method>\n"
                "<method name=\"playVideo\">\n"
                   "<arg name=\"path\" type=\"s\" direction=\"in\"/>\n"
                "</method>\n"
                "</interface>\n"
                )
signals:
    void statusChanged();

private:
    SimonTouch *m_logic;
    QString m_status;

public:
    SimonTouchAdapter(SimonTouch *parent);

private slots:
    void relayStatus(const QString&);

public slots:
    QString currentStatus();
    void playVideo(QString path);
};

#endif // SIMONTOUCHADAPTER_H
