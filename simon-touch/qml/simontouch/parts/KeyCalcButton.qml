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

Item {
    id: btKeyCalcButton
    property alias btKeyCalcButtonText: btInternal.buttonText
    property alias btKeyCalcButtonImage: btInternal.buttonImage
    property alias spokenText: btInternal.spokenText

    property alias shortcut: btInternal.shortcut

    signal buttonClick()
    state: "collapsed"

    states: [
        State {
            name: "collapsed"
            PropertyChanges {
                target: btKeyCalcButton
                width: 242
                height: 90
            }
        },
        State {
            name: "open"
            PropertyChanges {
                target: btKeyCalcButton
                width: 800
                height: 350
                x: 112
            }
        }
    ]

    transitions: Transition {
        NumberAnimation { properties: "x,width,height"; easing.type: Easing.InOutBounce }
    }

    Behavior on opacity {
        NumberAnimation {properties: "opacity"; duration: 500}
    }

    SideButton {
        id: btInternal
        x: 0
        y: 1
        width: parent.width - 2
        height: parent.height + 10
        onButtonClick: {
            btKeyCalcButton.state = (btKeyCalcButton.state == "collapsed") ? "open" : "collapsed";
            btKeyCalcButton.buttonClick()
        }
    }
}
