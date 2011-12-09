import QtQuick 1.1
import "parts"

TabPage {
    id: screen
    objectName: "MainCommunication"
    stateName: "Communication"

    Page {
        stateName: parent.stateName
        title: qsTr("Communication")
        state: "noCall"
        id: mainCommunication
/*
        ListModel {
            id: contactsModel
            ListElement {
                prettyName: "Stieger Franz"
                phoneNumber: "0664/4034321"
                email: "stiegerf@noemail.com"
                skype: "franz.stieger"
                image: "img/franz_01.jpg"
                existingMessages: true
            }
            ListElement {
                prettyName: "Stieger Mathias"
                phoneNumber: "0664/3841266"
                email: ""
                skype: ""
                image: "img/mathias_01.jpg"
                existingMessages: false
            }
            ListElement {
                prettyName: "Stieger Franz"
                phoneNumber: ""
                email: "stiegerf@noemail.com"
                skype: "franz.stieger"
                image: "img/franz_01.jpg"
                existingMessages: false
            }
            ListElement {
                prettyName: "Stieger Mathias"
                phoneNumber: "0664/3841266"
                email: ""
                skype: ""
                image: "img/mathias_01.jpg"
                existingMessages: true
            }
            ListElement {
                prettyName: "Stieger Franz"
                phoneNumber: "0664/4034321"
                email: ""
                skype: "franz.stieger"
                image: "img/franz_01.jpg"
                existingMessages: true
            }
            ListElement {
                prettyName: "Stieger Mathias"
                phoneNumber: ""
                email: "stiegerm@noemail.com"
                skype: ""
                image: "img/mathias_01.jpg"
                existingMessages: true
            }
        }
        */
        /*
        ListModel {
            id: lvMessageList
            ListElement {
                icon: ""
                subject: "Das ist ein Testsubjekt"
                text: "Das ist ein Testtext."
                datetime: "11/11/2011 11:11"
            }
        }
        */

        Component {
            id: contactsDelegate
            Item {
                property alias name: lbPrettyName.text
                property bool hasPhone: (lbPhoneNumber.text != qsTr("Phone: -")) || (lbSkype.text != qsTr("Skype: -"))
                property bool hasMail: lbMail.text != qsTr("Mail: -")
                property alias contactId: uidWrapper.objectName
                property bool hasMessages: true

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

            anchors {
                left: parent.left
//                right: parent.right
                top: parent.top
                bottom: parent.bottom
                margins: 160
                topMargin: 160
                rightMargin: 0
//                bottomMargin: 200
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
            if (lvContactsView.currentItem.hasMail) {
                mainCommunicationSendMessage.mailAvailable = 1
            } else {
                mainCommunicationSendMessage.mailAvailable = 0
            }

            if (lvContactsView.currentItem.hasPhone) {
                callPhone.opacity = true
            } else {
                callPhone.opacity = false
            }
            if (lvContactsView.currentItem.hasPhone || lvContactsView.currentItem.hasMail) {
                sendMessage.opacity = true
            } else {
                sendMessage.opacity = false
            }
            if (lvContactsView.currentItem.hasMessages) {
                readMessages.opacity = true
            } else {
                readMessages.opacity = false
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
            id: callPhone
            anchors.top: lvImagesUp.top
            anchors.left: lvContactsView.right
            anchors.leftMargin: 20
//            anchors.topMargin: 160
            buttonText: qsTr("Call")
            width: lvContactsView.width
            height: 50
            buttonImage: "../img/go-down.svgz"
            spokenText: true
            buttonLayout: Qt.Horizontal
            onButtonClick: (mainCommunication.state == "noCall") ? mainCommunication.state = "openCall" : mainCommunication.state = "noCall"
            Behavior on opacity {
                NumberAnimation {properties: "opacity"; duration: 500}
            }
        }

        Button {
            id: callSkype
            anchors.top: callPhone.bottom
            anchors.left: callPhone.left
//            anchors.leftMargin: 20
            anchors.topMargin: 10
            buttonText: qsTr("Skype")
            width: lvContactsView.width / 2 -5
            height: 50
            buttonImage: "../img/go-down.svgz"
            spokenText: true
            buttonLayout: Qt.Horizontal
            opacity: 0
            Behavior on opacity {
                NumberAnimation {properties: "opacity"; duration: 500}
            }
            onButtonClick: simonTouch.callSkype(lvContactsView.currentItem.contactId)
        }

        Button {
            id: callTelephone
            anchors.top: callPhone.bottom
            anchors.right: callPhone.right
//            anchors.leftMargin: 20
            anchors.topMargin: 10
            buttonText: qsTr("Phone")
            width: lvContactsView.width /2 - 5
            height: 50
            buttonImage: "../img/go-down.svgz"
            spokenText: true
            buttonLayout: Qt.Horizontal
            opacity: 0
            Behavior on opacity {
                NumberAnimation {properties: "opacity"; duration: 500}
            }
            onButtonClick: simonTouch.callPhone(lvContactsView.currentItem.contactId)
        }
        Button {
            id: sendMessage
            anchors.top: /*(callPhone.opacity == 1) ? */callPhone.bottom /*: lvImagesUp.top*/
            anchors.left: callPhone.left
            buttonText: qsTr("Send message")
            width: lvContactsView.width
            anchors.topMargin: 10
            height: 50
            buttonImage: "../img/go-down.svgz"
            spokenText: true
            buttonLayout: Qt.Horizontal
            onButtonClick: setScreen("MainCommunicationSendMessage")
            Behavior on opacity {
                NumberAnimation {properties: "opacity"; duration:500}
            }
        }
        Button {
            id: readMessages
            anchors.top: sendMessage.bottom
            anchors.left: callPhone.left
            buttonText: qsTr("Read messages")
            width: lvContactsView.width
            anchors.topMargin: 10
            height: 50
            buttonImage: "../img/go-down.svgz"
            spokenText: true
            buttonLayout: Qt.Horizontal
            onButtonClick: {
                simonTouch.fetchMessages(lvContactsView.currentItem.contactId)
                setScreen("MainCommunicationReadMessages")
            }
            Behavior on opacity {
                NumberAnimation {properties: "opacity"; duration: 500}
            }
        }
        Button {
            anchors.top: readMessages.bottom
            anchors.left: readMessages.left
            buttonText: qsTr("Hang up (!FIXME!)")
            width: lvContactsView.width
            anchors.topMargin: 10
            height: 50
            buttonImage: "../img/go-down.svgz"
            spokenText: true
            buttonLayout: Qt.Horizontal
            onButtonClick: {
                simonTouch.hangUp()
            }
            Behavior on opacity {
                NumberAnimation {properties: "opacity"; duration: 500}
            }
        }

        states: [
            State {
                name: "openCall"
                PropertyChanges {
                    target: callSkype
                    opacity: 1
                }
                PropertyChanges {
                    target: callTelephone
                    opacity: 1
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
