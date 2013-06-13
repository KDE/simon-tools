/*
 *   Copyright (C) 2012 Peter Grasch <grasch@simon-listens.org>
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

#ifndef CONFIGURATION_H
#define CONFIGURATION_H

#include <QString>
#include <QObject>

class Configuration : public QObject
{
    Q_OBJECT
public:
    Configuration();

public slots:
    QString imagePath() { return m_imagePath; }
    QString musicPath() { return m_musicPath; }
    QString videosPath() { return m_videosPath; }
    QString feeds() { return m_feeds; }
    QString groups() { return m_groups; }
    QString householdMailAddress() { return m_householdMailAddress; }
    QString medicineMailAddress() { return m_medicineMailAddress; }
    QString taxiNumber() { return m_taxiNumber; }
    QString ambulanceNumber() { return m_ambulanceNumber; }
    QString privateTransportNumber() { return m_privateTransportNumber; }
    QString doctorNumber() { return m_doctorNumber; }
    QString carerNumber() { return m_carerNumber; }
    QString knownPersonNumber() { return m_knownPersonNumber; }

private:
    QString m_imagePath;
    QString m_musicPath;
    QString m_videosPath;
    QString m_groups;
    QString m_feeds;
    QString m_householdMailAddress;
    QString m_medicineMailAddress;
    QString m_taxiNumber;
    QString m_ambulanceNumber;
    QString m_privateTransportNumber;
    QString m_doctorNumber;
    QString m_carerNumber;
    QString m_knownPersonNumber;
};

#endif // CONFIGURATION_H
