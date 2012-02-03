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
    objectName: "MainScreen"
    stateName: "Main"
    focus: true

    Page {
        stateName: parent.stateName
        title: Qt.formatDateTime(new Date(), "dddd, dd. MMMM yyyy")
        PageGrid {
            id: pageGrid
            Button {
                id: btButton1
                objectName: "btInformation"
                buttonText: qsTr("Information")
                buttonNumber: "1"
                shortcut: Qt.Key_1
                buttonImage: ("../img/Button_Information.png")
                onButtonClick: showScreen("MainInformation")
            }
            Button {
                id: btButton2
                objectName: "btCommunication"
                buttonText: qsTr("Communication")
                buttonNumber: "2"
                shortcut: Qt.Key_2
                buttonImage: ("../img/Button_Kommunikation.png")
                onButtonClick: showScreen("MainCommunication")
            }
            Button {
                id: btButton3
                objectName: "btOrders"
                buttonText: qsTr("Orders")
                buttonNumber: "3"
                shortcut: Qt.Key_3
                buttonImage: ("../img/Button_Auftraege.png")
                onButtonClick: showScreen("MainOrders")
            }
            Button{
                id: btButton4
                objectName: "btRequests"
                buttonText: qsTr("Requests")
                buttonNumber: "4"
                shortcut: Qt.Key_4
                buttonImage: ("../img/Button_Anfragen.png")
//                onButtonClick: showScreen("MainIncomingCall")
//                onButtonClick: showScreen("MainOutgoingCall")
//                onButtonClick: showScreen("MainActiveCall")
                onButtonClick: showScreen("MainRequests")
            }
        }
    }
}
