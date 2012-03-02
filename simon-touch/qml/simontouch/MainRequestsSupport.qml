/*
 *   Copyright (C) 2011-2012 Mathias Stieger <m.stieger@simon-listens.org>
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

import QtQuick 1.1
import "parts"

TabPage {
    id: screen
    objectName: "MainRequestsSupport"
    stateName: "RequestsSupport"

    Page {
        stateName: parent.stateName
        title: i18n("Support")
        PageGrid {
            id: pageGrid
            Button {
                objectName: "btRequestsSupportDoctor"
                buttonText: i18n("Doctor")
                buttonNumber: "1"
                shortcut: Qt.Key_1
                buttonImage: ("../img/doctor-icon.png")
                width: screen.width / 4
                height: screen.height / 3
                onButtonClick: {
                    back()
                    simonTouch.callHandle(configuration.doctorNumber())
                }
            }
            Button {
                objectName: "btRequestsSupportAmbulance"
                buttonText: i18n("Ambulance")
                buttonNumber: "2"
                shortcut: Qt.Key_2
                buttonImage: ("../img/ambulance-icon.png")
                width: screen.width / 4
                height: screen.height / 3
                onButtonClick: {
                    back()
                    simonTouch.callHandle(configuration.ambulanceNumber())
                }
            }
            Button {
                objectName: "btRequestsSupportCarer"
                buttonText: i18n("Carer")
                buttonNumber: "3"
                shortcut: Qt.Key_3
                buttonImage: ("../img/nurse-icon.png")
                width: screen.width / 4
                height: screen.height / 3
                onButtonClick: {
                    back()
                    simonTouch.callHandle(configuration.carerNumber())
                }
            }
            Button {
                objectName: "btRequestsSupportPrivate"
                buttonText: i18n("Known person")
                buttonNumber: "4"
                shortcut: Qt.Key_4
                buttonImage: ("../img/Button_Anfragen_Unterstuetzung.png")
                width: screen.width / 4
                height: screen.height / 3
                onButtonClick: {
                    back()
                    simonTouch.callHandle(configuration.knownPersonNumber())
                }
            }
        }
    }
}
