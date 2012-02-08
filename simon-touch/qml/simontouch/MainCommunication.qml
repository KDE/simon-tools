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
    objectName: "MainCommunication"
    stateName: "Communication"
    onOpacityChanged: {
        lvContactsView.currentIndex = 0
    }

    Page {
        stateName: parent.stateName
        title: qsTr("Communication")
        state: "noCall"
        id: mainCommunication
        Component {
            id: contactsDelegate
            Item {
                property alias name: lbPrettyName.text
                property bool hasPhone: (lbPhoneNumber.text != qsTr("Phone: -"))
                property bool hasSkype: (lbSkype.text != qsTr("Skype: -"))
                property bool hasMail: lbMail.text != qsTr("Mail: -")
                property alias contactId: uidWrapper.objectName

                height: 100
                width: lvContactsView.width

                Item { //dirty hack
                    id: uidWrapper
                    objectName: uid
                }

                Row {
                    spacing: 10
                    Column {
                        height: 100
                        Image {
                            source: image
                            height: parent.height
                            fillMode: Image.PreserveAspectFit
                        }
                    }

                    Column {
                        Text {
                            id: lbPrettyName
                            text: prettyName
                            font.family: "Arial"
                            font.pointSize: 16
                        }
                        Text {
                            id: lbPhoneNumber
                            text: qsTr("Phone: ") + phoneNumber
                            font.family: "Arial"
                            font.pointSize: 10
                        }
                        Text {
                            id: lbMail
                            text: qsTr("Mail: ") + email
                            font.family: "Arial"
                            font.pointSize: 10
                        }
                        Text {
                            id: lbSkype
                            text: qsTr("Skype: ") + skype
                            font.family: "Arial"
                            font.pointSize: 10
                        }
                    }
                }


                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        lvContactsView.currentIndex = index;
                    }
                }
            }
        }

        SelectionListView {
            id: lvContactsView
            objectName: "lvContactsView"

            Component {
                id: highlight
                Rectangle {
                        color: "#FEF57B" // "lightsteelblue"
                        radius: 5
                        width: parent.width -2
                        border.color: "#8A8A8A"
                        border.width: 1
                }
            }
            highlight: highlight

            anchors {
                left: parent.left
                top: parent.top
                bottom: parent.bottom
                margins: 160
                topMargin: 160
                rightMargin: 0
            }
            width: screen.width / 2 - 210
            model: contactsModel
            delegate: contactsDelegate
            onCurrentItemChanged: parent.changeSelection();
        }

        function changeSelection() {
            mainCommunicationReadMessages.prettyName = lvContactsView.currentItem.name
            mainCommunicationSendMessage.prettyName = lvContactsView.currentItem.name
            mainCommunicationSendMessage.recipientUid = lvContactsView.currentItem.contactId

            if (lvContactsView.currentItem.hasPhone) {
                mainCommunicationSendMessage.smsAvailable = 1
            } else {
                mainCommunicationSendMessage.smsAvailable = 0
            }
            if (lvContactsView.currentItem.hasSkype) {
                callSkype.opacity = 1
            } else {
                callSkype.opacity = 0
            }

            if (lvContactsView.currentItem.hasMail) {
                mainCommunicationSendMessage.mailAvailable = 1
            } else {
                mainCommunicationSendMessage.mailAvailable = 0
            }

            if (lvContactsView.currentItem.hasPhone) {
                callTelephone.opacity = true
            } else {
                callTelephone.opacity = false
            }
            if (lvContactsView.currentItem.hasPhone || lvContactsView.currentItem.hasMail) {
                sendMessage.opacity = true
            } else {
                sendMessage.opacity = false
            }
        }

        Button {
            id: lvImagesUp
            anchors.bottom: lvContactsView.top
            anchors.left: lvContactsView.left
            anchors.bottomMargin: 10
            width: lvContactsView.width
            height: 50
            buttonImage: "../img/go-up.svgz"
            buttonText: qsTr("Up")
            shortcut: Qt.Key_Up
            spokenText: true
            buttonLayout: Qt.Horizontal
            onButtonClick: if (lvContactsView.currentIndex > 0) lvContactsView.currentIndex -= 1
        }

        Button {
            id: lvImagesDown
            anchors.top: lvContactsView.bottom
            anchors.left: lvContactsView.left
            anchors.topMargin: 10
            width: lvContactsView.width
            height: 50
            buttonImage: "../img/go-down.svgz"
            buttonText: qsTr("Down")
            shortcut: Qt.Key_Down
            spokenText: true
            buttonLayout: Qt.Horizontal
            onButtonClick: if (lvContactsView.currentIndex + 1 < lvContactsView.count) lvContactsView.currentIndex += 1
        }

        Button {
            id: callSkype
            anchors.top: lvImagesUp.top
            anchors.left: lvContactsView.right
            anchors.leftMargin: 20
            buttonText: qsTr("Call on computer")
            width: lvContactsView.width
            height: 50
            buttonImage: "../img/go-down.svgz"
            spokenText: false
            buttonLayout: Qt.Horizontal
            opacity: 1
            buttonNumber: "1"
            shortcut: Qt.Key_1
            Behavior on opacity {
                NumberAnimation {properties: "opacity"; duration: 500}
            }
            onButtonClick: if (opacity == 1) simonTouch.callSkype(lvContactsView.currentItem.contactId)
        }

        Button {
            id: callTelephone
            anchors.top: callSkype.bottom
            anchors.left: callSkype.left
            anchors.topMargin: 10
            buttonText: qsTr("Call on phone")
            width: lvContactsView.width
            height: 50
            buttonImage: "../img/go-down.svgz"
            spokenText: false
            buttonLayout: Qt.Horizontal
            opacity: 1
            buttonNumber: "2"
            shortcut: Qt.Key_2
            Behavior on opacity {
                NumberAnimation {properties: "opacity"; duration: 500}
            }
            onButtonClick: if (opacity == 1) simonTouch.callPhone(lvContactsView.currentItem.contactId)
        }
        Button {
            id: sendMessage
            anchors.top: callTelephone.bottom
            anchors.left: callSkype.left
            buttonText: qsTr("Send message")
            width: lvContactsView.width
            anchors.topMargin: 10
            height: 50
            buttonImage: "../img/go-down.svgz"
            spokenText: false
            buttonLayout: Qt.Horizontal
            onButtonClick: if (opacity == 1) setScreen("MainCommunicationSendMessage")
            buttonNumber: "3"
            shortcut: Qt.Key_3
            Behavior on opacity {
                NumberAnimation {properties: "opacity"; duration:500}
            }
        }
        Button {
            id: readMessages
            anchors.top: sendMessage.bottom
            anchors.left: callSkype.left
            buttonText: qsTr("Read messages")
            width: lvContactsView.width
            anchors.topMargin: 10
            height: 50
            buttonImage: "../img/go-down.svgz"
            spokenText: false
            buttonLayout: Qt.Horizontal
            onButtonClick: {
                simonTouch.fetchMessages(lvContactsView.currentItem.contactId)
                setScreen("MainCommunicationReadMessages")
            }
            buttonNumber:"4"
            shortcut: Qt.Key_4
            Behavior on opacity {
                NumberAnimation {properties: "opacity"; duration: 500}
            }
        }
        states: [
            State {
                name: "openCall"
                PropertyChanges {
                    target: callSkype
                    opacity: 0
                }
                PropertyChanges {
                    target: callTelephone
                    opacity: 0
                }
                PropertyChanges {
                    target: sendMessage
                    anchors.topMargin: 70
                }
            },
            State {
                name: "noCall"
            }

        ]

        transitions: [
            Transition {
                to: "openCall"
                SequentialAnimation {
                    PropertyAnimation { properties: "anchors.topMargin"; duration: 250; easing.type: Easing.InOutCubic }
                    PropertyAnimation { properties: "opacity"; duration: 250; easing.type: Easing.InOutCubic }
                }
            },
            Transition {
                from: "openCall"
                SequentialAnimation {
                    PropertyAnimation { properties: "opacity"; duration: 250; easing.type: Easing.InOutCubic }
                    PropertyAnimation { properties: "anchors.topMargin"; duration: 250; easing.type: Easing.InOutCubic }
                }
            }
        ]

    }
    MainCommunicationReadMessages {
        objectName: "MainCommunicationReadMessages"
        id: mainCommunicationReadMessages
    }
    MainCommunicationSendMessage {
        objectName: "MainCommunicationSendMessage"
        id: mainCommunicationSendMessage
    }
}
