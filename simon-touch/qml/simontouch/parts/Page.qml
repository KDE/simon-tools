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
import "button.js" as ButtonEngine

Item {

    function registerButton(btn) {
        ButtonEngine.addButton(btn)
    }

    id: page
    objectName: "MainScreen"
    property alias title: lbTitle.text
    property string stateName: "Undefined"

    anchors.fill: parent
    opacity:0

    signal showScreen(string msg)

    Text {
        id: lbTitle
        font.pointSize: 20
        font.bold: true
        anchors.horizontalCenter: parent.horizontalCenter
        y: 40
    }

    Behavior on opacity {
        NumberAnimation {properties: "opacity"; duration: 500}
    }

    function handleKey(key) {
        if (key == Qt.Key_Escape && current != "MainScreen") {
            back()
            return true
        }

        if (key == Qt.Key_Q) Qt.quit()

        return ButtonEngine.relayKey(key);
    }


    Keys.onPressed: {
        if (handleKey(event.key)) {
            event.accepted = true
            return
        }
    }
}
