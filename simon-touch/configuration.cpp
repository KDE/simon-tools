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

#include "configuration.h"
#include <KGlobal>
#include <KConfigGroup>
#include <KStandardDirs>
#include <KCmdLineArgs>

Configuration::Configuration()
{
    KCmdLineArgs *parsedArgs = KCmdLineArgs::parsedArgs();

    KConfigGroup information(KGlobal::config(), "information");

    if (parsedArgs->isSet("images"))
        m_imagePath = parsedArgs->getOption("images");
    else
        m_imagePath = information.readEntry("images", ".");

    if (parsedArgs->isSet("videos"))
        m_videosPath = parsedArgs->getOption("videos");
    else
        m_videosPath = information.readEntry("videos", ".");

    if (parsedArgs->isSet("music"))
        m_musicPath = parsedArgs->getOption("music");
    else
        m_musicPath = information.readEntry("music", ".");

    if (parsedArgs->isSet("groups"))
        m_groups = parsedArgs->getOption("groups");
    else
        m_groups = information.readEntry("groups", ",,");

    if (parsedArgs->isSet("feeds"))
        m_feeds = parsedArgs->getOption("feeds");
    else
        m_feeds = information.readEntry("feeds", ",,,");

    KConfigGroup requests(KGlobal::config(), "requests");
    m_householdMailAddress = requests.readEntry("householdMailAddress", "");
    m_medicineMailAddress = requests.readEntry("medicineMailAddress", "");
    m_taxiNumber = requests.readEntry("taxiNumber", "");
    m_ambulanceNumber = requests.readEntry("ambulanceNumber", "");
    m_privateTransportNumber = requests.readEntry("privateTransportNumber", "");
    m_doctorNumber = requests.readEntry("doctorNumber", "");
    m_carerNumber = requests.readEntry("carerNumber", "");
    m_knownPersonNumber = requests.readEntry("knownPersonNumber", "");
}
