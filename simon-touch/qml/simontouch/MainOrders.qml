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
    objectName: "MainOrders"
    stateName: "Orders"

    function checkOn(target) {
        moCheck.target = target
        setScreen("MainOrdersCheck")
        simonTouch.checkOn(target)
    }

    onOpacityChanged: if (opacity == 0) setScreen("MainScreen")

    Page {
        stateName: parent.stateName
        title: i18nc("Tell the robot to check the environment","Check")

        PageGrid {
            id: pageGrid
            Button {
                objectName: "btOrdersWater"
                buttonText: i18nc("Check the water pipe","Water control")
                buttonNumber: "1"
                buttonImage: ("../img/Button_Auftraege_Wasser.png")
                width: screen.width / 4
                height: screen.height / 3
                shortcut: Qt.Key_1
                onButtonClick: checkOn(i18n("Kitchen"))
            }
            Button {
                objectName: "btOrdersDoors"
                buttonText: i18nc("Check the entrance","Doors control")
                buttonNumber: "2"
                buttonImage: ("../img/Button_Auftraege_Tueren.png")
                width: screen.width / 4
                height: screen.height / 3
                shortcut: Qt.Key_2
                onButtonClick: checkOn(i18n("Kitchen"))
            }
            Button {
                objectName: "btOrdersCooker"
                buttonText: i18nc("Check the cooker","Cooker control")
                buttonNumber: "3"
                buttonImage: ("../img/Button_Auftraege_Herd.png")
                width: screen.width / 4
                height: screen.height / 3
                shortcut: Qt.Key_3
                onButtonClick: checkOn(i18n("Kitchen"))
            }
            Button {
                objectName: "btOrdersGas"
                buttonText: i18nc("Check the gas pipe","Gas control")
                buttonNumber: "4"
                buttonImage: ("../img/Button_Auftraege_Gas.png")
                width: screen.width / 4
                height: screen.height / 3
                shortcut: Qt.Key_4
                onButtonClick: checkOn(i18n("Kitchen"))
            }
        }
    }

    MainOrdersCheck {
        id: moCheck
        objectName: "MainOrdersCheck"
    }
}
