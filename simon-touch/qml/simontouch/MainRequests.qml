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
    objectName: "MainRequests"
    stateName: "Requests"

    Page {
        stateName: parent.stateName
        title: qsTr("Requests")
        PageGrid {
            id: pageGrid
            Button {
                objectName: "btRequestsShopping"
                buttonText: qsTr("Shopping")
                buttonNumber: "1"
                shortcut: Qt.Key_1
                buttonImage: ("../img/Button_Anfragen_Bestellung.png")
                onButtonClick: setScreen("MainRequestsShopping")
            }
            Button {
                objectName: "btRequestsTransport"
                buttonText: qsTr("Transport")
                buttonNumber: "2"
                shortcut: Qt.Key_2
                buttonImage: ("../img/Button_Anfragen_Transport.png")
                onButtonClick: setScreen("MainRequestsTransport")
            }
            Button {
                objectName: "btRequestsSupport"
                buttonText: qsTr("Support")
                buttonNumber: "3"
                shortcut: Qt.Key_3
                buttonImage: ("../img/Button_Anfragen_Unterstuetzung.png")
                onButtonClick: setScreen("MainRequestsSupport")
            }
    //        Button {
    //            objectName: "btOrdersGas"
    //            buttonText: qsTr("Gas control")
    //            buttonNumber: "4"
    //            shortcut: Qt.Key_4
    //            buttonImage: ("../img/Button_Auftraege_Gas.png")
    //        }
        }
    }
    MainRequestsShopping {
        objectName: "MainRequestsShopping"
    }
    MainRequestsTransport {
        objectName: "MainRequestsTransport"
    }
    MainRequestsSupport {
        objectName: "MainRequestsSupport"
    }
}
