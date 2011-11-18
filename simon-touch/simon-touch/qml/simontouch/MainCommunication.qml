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

        ListModel {
            id: lvContactsModel
            ListElement {
                prettyName: "Stieger Franz"
                phoneNumber: "0664/4034321"
                email: "stiegerf@noemail.com"
                skype: "franz.stieger"
                image: "/home/mathias/Bilder/franz_01.jpg"
                existingMessages: true
            }
            ListElement {
                prettyName: "Stieger Mathias"
                phoneNumber: "0664/3841266"
                email: ""
                skype: ""
                image: "/home/mathias/Bilder/mathias_01.jpg"
                existingMessages: false
            }
            ListElement {
                prettyName: "Stieger Franz"
                phoneNumber: ""
                email: "stiegerf@noemail.com"
                skype: "franz.stieger"
                image: "/home/mathias/Bilder/franz_01.jpg"
                existingMessages: false
            }
            ListElement {
                prettyName: "Stieger Mathias"
                phoneNumber: "0664/3841266"
                email: ""
                skype: ""
                image: "/home/mathias/Bilder/mathias_01.jpg"
                existingMessages: true
            }
            ListElement {
                prettyName: "Stieger Franz"
                phoneNumber: "0664/4034321"
                email: ""
                skype: "franz.stieger"
                image: "/home/mathias/Bilder/franz_01.jpg"
                existingMessages: true
            }
            ListElement {
                prettyName: "Stieger Mathias"
                phoneNumber: ""
                email: "stiegerm@noemail.com"
                skype: ""
                image: "/home/mathias/Bilder/mathias_01.jpg"
                existingMessages: true
            }
        }

        ListModel {
            id: lvMessageList
            ListElement {
                icon: ""
                subject: "Das ist ein Testsubjekt"
                text: "Das ist ein Testtext."
                datetime: "11/11/2011 11:11"
            }
        }

        Component {
            id: contactsDelegate
            Item {
                height: 100
                width: lvContactsView.width
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
                            text: prettyName
                            font.family: "Arial"
                            font.pointSize: 16
                        }
                        Text {
                            text: qsTr("Phone: ") + phoneNumber
                            font.family: "Arial"
                            font.pointSize: 10
                        }
                        Text {
                            text: qsTr("E-Mail: ") + email
                            font.family: "Arial"
                            font.pointSize: 10
                        }
                        Text {
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
            model: lvContactsModel
            delegate: contactsDelegate
            onCurrentItemChanged: parent.changeSelection();
        }

        function changeSelection() {
            mainCommunicationReadMessages.prettyName = lvContactsModel.get(lvContactsView.currentIndex).prettyName
            mainCommunicationSendMessage.prettyName = lvContactsModel.get(lvContactsView.currentIndex).prettyName

            if (lvContactsModel.get(lvContactsView.currentIndex).phoneNumber != "") {
                mainCommunicationSendMessage.smsAvailable = 1
            } else {
                mainCommunicationSendMessage.smsAvailable = 0
            }
            if (lvContactsModel.get(lvContactsView.currentIndex).email != "") {
                mainCommunicationSendMessage.mailAvailable = 1
            } else {
                mainCommunicationSendMessage.mailAvailable = 0
            }

            if (lvContactsModel.get(lvContactsView.currentIndex).phoneNumber != "") {
                callPhone.opacity = true
            } else {
                callPhone.opacity = false
            }
            if (lvContactsModel.get(lvContactsView.currentIndex).phoneNumber != "" || lvContactsModel.get(lvContactsView.currentIndex).email != "") {
                sendMessage.opacity = true
            } else {
                sendMessage.opacity = false
            }
            if (lvContactsModel.get(lvContactsView.currentIndex).existingMessages != false) {
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
            onButtonClick: setScreen("MainCommunicationReadMessages")
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
