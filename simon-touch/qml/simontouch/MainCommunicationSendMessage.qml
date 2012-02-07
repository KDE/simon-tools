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
    objectName: "MainCommunicationSendMessage"
    stateName: "CommunicationSendMessage"
    property string prettyName: ""
    property string recipientUid: ""
    property alias smsAvailable: sendSMS.opacity
    property alias mailAvailable: sendMail.opacity

    onOpacityChanged: {
        if (screen.opacity == 1) {
            keyboardButton.state = "open"
            keyboardButton.buttonClick()
            messageInput.forceActiveFocus()
        } else {
            keyboardButton.state = "collapsed"
            keyboardButton.buttonClick()
            messageInput.text = ""
        }
    }

    Page {
        title: qsTr("Send message to ") + parent.prettyName
        stateName:parent.stateName
        id: sendMessagePage
        opacity: 0

        Column {
            id:sendMessageColumn
            spacing: 10
            anchors {
                left: parent.left
                top: parent.top
                bottom: parent.bottom
                margins: 160
                topMargin: 130
                rightMargin: 0
            }
            width: screen.width - 320
            Column {
                spacing: 10
                width: parent.width
                height: 150

                Text {
                    id: textLabel
                    text: qsTr("Message:")
                    font.family: "Arial"
                    font.pointSize: 16
                }

                Rectangle {
                    width: parent.width //- textLabel.width -10
                    height: parent.height - textLabel.height - 10
                    color: "Lightsteelblue"
                    TextEdit {
                         id: messageInput
                         text: ""
                         focus: true
                         font.family: "Arial"
                         font.pointSize: 16
//                        MouseArea {
//                           anchors.fill: parent
//                           onClicked: {
//                               if (!messageInput.activeFocus) {
//                                   messageInput.forceActiveFocus();
//                                   messageInput.openSoftwareInputPanel();
//                               } else {
//                                   messageInput.focus = false;
//                               }
//                           }
//                           onPressAndHold: textInput.closeSoftwareInputPanel
//                        }
                    }
                }
            }
            Item {
                width: parent.width
                height: sendMail.height
//                spacing: 20
                Button {
                    id: sendMail
                    anchors.topMargin: 10
                    width: sendMessageColumn.width / 2 -10
                    height: 50
                    buttonImage: "../img/go-down.svgz"
                    buttonText: qsTr("Send to computer")
                    shortcut: Qt.Key_Down
                    spokenText: false
                    buttonLayout: Qt.Horizontal
                    anchors.left: parent.left
//                    buttonNumber: "1"
                    onButtonClick: {
                        simonTouch.sendMail(recipientUid, messageInput.text)
                        back()
                    }
                }

                Button {
                    id: sendSMS
                    anchors.topMargin: 10
                    width: sendMessageColumn.width / 2 -10
                    height: 50
                    buttonImage: "../img/go-down.svgz"
                    buttonText: qsTr("Send to mobile phone")
                    shortcut: Qt.Key_Down
                    spokenText: false
                    buttonLayout: Qt.Horizontal
                    anchors.right: parent.right
//                    buttonNumber: "2"
                    onButtonClick: {
                        simonTouch.sendSMS(recipientUid, messageInput.text)
                        back()
                    }
                }
            }
        }
    }
}
