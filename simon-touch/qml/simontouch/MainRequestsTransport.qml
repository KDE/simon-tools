/*
 *   Copyright (C) 2011-2012 Mathias Stieger <m.stieger@cyber-byte.at>
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
    objectName: "MainRequestsTransport"
    stateName: "RequestsTransport"

    Page {
        stateName: parent.stateName
        title: qsTr("Transport")
        PageGrid {
            id: pageGrid
            Button {
                objectName: "btRequestsTransportTaxi"
                buttonText: qsTr("Taxi")
                buttonNumber: "1"
                shortcut: Qt.Key_1
                buttonImage: ("../img/Button_Anfragen_Transport.png")
            }
            Button {
                objectName: "btRequestsTransportAmbulance"
                buttonText: qsTr("Ambulance")
                buttonNumber: "2"
                shortcut: Qt.Key_2
                buttonImage: ("../img/Button_Anfragen_Transport.png")
            }
            Button {
                objectName: "btRequestsTransportPrivate"
                buttonText: qsTr("Private tranport")
                buttonNumber: "3"
                shortcut: Qt.Key_3
                buttonImage: ("../img/Button_Anfragen_Transport.png")
            }
//            Button {
//                objectName: "btRequestsSupportPrivate"
//                buttonText: qsTr("Known person")
//                buttonNumber: "4"
//                buttonImage: ("../img/Button_Anfragen_Unterstuetzung.png")
//            }
        }
    }
}
