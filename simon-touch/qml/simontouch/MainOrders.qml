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
    objectName: "MainOrders"
    stateName: "Orders"

    Page {
        stateName: parent.stateName
        title: qsTr("Orders")
        PageGrid {
            id: pageGrid
            Button {
                objectName: "btOrdersWater"
                buttonText: qsTr("Water control")
                buttonNumber: "1"
                buttonImage: ("../img/Button_Auftraege_Wasser.png")
            }
            Button {
                objectName: "btOrdersDoors"
                buttonText: qsTr("Doors control")
                buttonNumber: "2"
                buttonImage: ("../img/Button_Auftraege_Tueren.png")
            }
            Button {
                objectName: "btOrdersCooker"
                buttonText: qsTr("Cooker control")
                buttonNumber: "3"
                buttonImage: ("../img/Button_Auftraege_Herd.png")
            }
            Button {
                objectName: "btOrdersGas"
                buttonText: qsTr("Gas control")
                buttonNumber: "4"
                buttonImage: ("../img/Button_Auftraege_Gas.png")
            }
        }
    }
}
