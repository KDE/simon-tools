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

Rectangle {
    id: main
    width: 1024
    height: 768
    color: "#FFFBC7"

    function changeButtonVisibility(visibility) {
            keyboardButton.opacity = visibility;
            calculatorButton.opacity = visibility;
    }
    function activeCall() {
        console.debug("Receiving active call...");
        showScreen("MainActiveCall");
    }
    function callEnded() {
        console.debug("Active call ended...");
        showScreen("MainScreen");
    }

    TabPage {
        objectName: "mainMenu"
        opacity: 1
        id: tabs
        z: ((keyboardButton.state == "collapsed") && (calculatorButton.state == "collapsed")) ? 5 : 0
        backAvailable: false

        MainScreen {
            objectName: "MainScreen"
            backAvailable: false
        }

        MainInformation {
            objectName: "MainInformation"
        }

        MainActiveCall {
            objectName: "MainActiveCall"
            backAvailable: false
        }

        MainCommunication {
            objectName: "MainCommunication"
        }
        MainOrders {
            objectName: "MainOrders"
        }
        MainRequests {
            objectName: "MainRequests"
        }
    }

    Keys.onPressed: {
        if (calculatorButton.handleKey(event.key)) return true;
        if (keyboardButton.handleKey(event.key)) return true
    }

    KeyCalcButton {
        id: calculatorButton
        z: (keyboardButton.state == "collapsed") ? 1 : 0
        anchors.bottom: parent.bottom
        x: (parent.width / 2) - (calculatorButton.width + 10)
        btKeyCalcButtonText: (state == "collapsed") ? i18n("Calculator") : i18n("Close calculator")
        btKeyCalcButtonImage: ("../img/calculator.png")
        spokenText: true
        shortcut: Qt.Key_0
        onButtonClick: {
            if (state == "collapsed")
                simonTouch.hideCalculator()
            else
                simonTouch.showCalculator()
        }
        width: main.width / 4
    }
    KeyCalcButton {
        id: keyboardButton
        z: (calculatorButton.state == "collapsed") ? 1 : 0
        anchors.bottom: parent.bottom
        x: (parent.width / 2) + 10
        btKeyCalcButtonText: (state == "collapsed") ? i18n("Keyboard") : i18n("Close keyboard")
        btKeyCalcButtonImage: ("../img/keyboard.png")
        spokenText: true
        shortcut: Qt.Key_9
        onButtonClick: {
            if (state == "collapsed")
                simonTouch.hideKeyboard()
            else
                simonTouch.showKeyboard()
        }
        width: main.width / 4
    }
    Rectangle {
        id: closebutton
        anchors.top: parent.top
        anchors.right: parent.right
        width: 75
        height: 50
        color: Qt.darker("#FFFBC7", 1.1)
        Text {
            anchors.centerIn: parent
            text: "Quit"

        }

        MouseArea{
            id: buttonMouseArea
            x: 0
            y: 0
            anchors.rightMargin: 0
            anchors.bottomMargin: 0
            anchors.leftMargin: 0
            anchors.topMargin: 0
            anchors.fill: parent
            onClicked: Qt.quit()
        }
    }
}

