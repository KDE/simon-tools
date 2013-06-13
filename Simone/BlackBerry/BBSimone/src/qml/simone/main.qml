/*
 *   Copyright (C) 2011 Peter Grasch <grasch@simon-listens.org>
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
    id: mainView
    objectName: "mainView"
    width: 1024
    height: 600
    //width: 600
    //height: 1024
    Component.onCompleted: state = "disconnected"

    states: [
        State {
            name: "disconnected"
            PropertyChanges {
                target: teConnectionStatus
                text: qsTr("Disconnected from Simon Server")
            }
        },
        State {
            name: "connected"
            PropertyChanges {
                target: teConnectionStatus
                text: qsTr("Connected to Simon Server")
            }
        },
        State {
            name: "activated"
            PropertyChanges {
                target: teConnectionStatus
                text: qsTr("Recognition Active")
            }
        }
    ]


    Text {
        id: teConnectionStatus
        x: 50
        y: 50
        font.pixelSize: 25
    }

    AnimatedItem {
        id: disconnectConsole
        state: mainView.state == "disconnected" ? "hidden" : "shown"

        //don't fade out initially
        visible: false
        Timer {
            interval: 500
            running: true
            repeat: false
            onTriggered: disconnectConsole.visible = true
        }

        anchors.verticalCenter: teConnectionStatus.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: (mainView.width > 750) ? mainView.width - width - 15 : 50
        anchors.verticalCenterOffset: (mainView.width > 750) ? -15 : 25

        Behavior on anchors.leftMargin {
            NumberAnimation { duration: 200 }
        }
        Behavior on anchors.verticalCenter {
            NumberAnimation { duration: 200 }
        }
        Button {
            id: btDisconnect
            objectName: "btDisconnect"
            width: 250
            text: qsTr("Disconnect")
        }
    }

    ConnectionSettings {
        id: connectionSettings
        objectName: "connectionSettings"
        state: mainView.state == "disconnected" ? "shown" : "hidden"
        x: 150
        anchors.margins: 30
        width: 300
        anchors.top: teConnectionStatus.bottom
    }


    ActiveConsole{
        anchors.fill: parent
        state: mainView.state == "activated" ? "shown" : "hidden"
        mode: connectionSettings.mode
    }


    // status indicators & fluff
    Text {
        id: lbStatus
        objectName: "lbStatus"
        visible:  false // debug mode?
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        text: qsTr("Status")
    }

    Item {
        width: 600
        height: 80
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 0

        Dialog {
            id: errorDialog
            anchors.fill: parent
            anchors.bottomMargin: 0
            objectName: "errorDialog"
            title: qsTr("Error")
            clip: false

            function show(error) {
                if (errorDialog.state == "shown") {
                    // append error message
                    errorDialog.text = errorDialog.text + "\n" + error;
                } else {
                    //replace text and show
                    errorDialog.text = error
                    errorDialog.state = "shown"
                }
            }
        }
    }

}
