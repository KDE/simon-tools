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
    objectName: "MainRequests"
    stateName: "Requests"

    Page {
        stateName: parent.stateName
        title: i18n("Requests")
        PageGrid {
            id: pageGrid
            Button {
                objectName: "btRequestsShopping"
                buttonText: i18n("Shopping")
                buttonNumber: "1"
                shortcut: Qt.Key_1
                buttonImage: ("../img/Button_Anfragen_Bestellung.png")
                onButtonClick: setScreen("MainRequestsShopping")
                width: screen.width / 4
                height: screen.height / 3
            }
            Button {
                objectName: "btRequestsTransport"
                buttonText: i18n("Transport")
                buttonNumber: "2"
                shortcut: Qt.Key_2
                buttonImage: ("../img/Button_Anfragen_Transport.png")
                onButtonClick: setScreen("MainRequestsTransport")
                width: screen.width / 4
                height: screen.height / 3
            }
            Button {
                objectName: "btRequestsSupport"
                buttonText: i18n("Support")
                buttonNumber: "3"
                shortcut: Qt.Key_3
                buttonImage: ("../img/Button_Anfragen_Unterstuetzung.png")
                onButtonClick: setScreen("MainRequestsSupport")
                width: screen.width / 4
                height: screen.height / 3
            }
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
