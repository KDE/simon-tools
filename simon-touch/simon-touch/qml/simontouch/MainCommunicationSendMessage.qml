import QtQuick 1.1
import "parts"

TabPage {
    id: screen
    objectName: "MainCommunicationSendMessage"
    stateName: "CommunicationSendMessage"
    property string prettyName: ""
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
//                right: parent.right
                top: parent.top
                bottom: parent.bottom
                margins: 160
                topMargin: 130
                rightMargin: 0
//                bottomMargin: 200
            }
            width: screen.width - 320

//            Row {
//                spacing: 10
//                width: parent.width

//                Text {
//                    id: subjectLabel
//                    text: qsTr("Subject:")

//                }

//                Rectangle {
//                    width: parent.width - subjectLabel.width -10
//                    height: parent.height
//                    color: "Lightblue"
//                    TextInput {
//                        id: textInput
//                        text: ""
//                        activeFocusOnPress: false
//                        color: "Black"
//                        width: parent.width
//                        MouseArea {
//                           anchors.fill: parent
//                           onClicked: {
//                               if (!textInput.activeFocus) {
//                                   textInput.forceActiveFocus();
//                                   textInput.openSoftwareInputPanel();
//                               } else {
//                                   textInput.focus = false;
//                               }
//                           }
//                           onPressAndHold: textInput.closeSoftwareInputPanel
//                        }
//                    }
//                }
//            }
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
                    color: "Lightblue"
                    TextEdit {
                         id: messageInput
                         text: ""
                         focus: true
                         font.family: "Arial"
                         font.pointSize: 16
//                        text: "testtext"
//                        activeFocusOnPress: false
//                        color: "Black"
//                        width: parent.width
//                        height: parent.height
//                        wrapMode: TextEdit.Wrap
//                        focus: true
                        MouseArea {
                           anchors.fill: parent
                           onClicked: {
                               if (!messageInput.activeFocus) {
                                   messageInput.forceActiveFocus();
                                   messageInput.openSoftwareInputPanel();
                               } else {
                                   messageInput.focus = false;
                               }
                           }
                           onPressAndHold: textInput.closeSoftwareInputPanel
                        }
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
                    width: (sendSMS.opacity = 1) ? sendMessageColumn.width / 2 -10 : sendMessageColumn.width
                    height: 50
                    buttonImage: "../img/go-down.svgz"
                    buttonText: qsTr("Send to computer")
                    shortcut: Qt.Key_Down
                    spokenText: true
                    buttonLayout: Qt.Horizontal
                    onOpacityChanged: {
                        if (sendMail.opacity = 1) {
                            sendSMS.width = sendMessageColumn.width / 2 -10
                        } else {
                            sendSMS.width = sendMessageColumn.width
                        }
                    }

        //            onButtonClick: if (lvMessagesView.currentIndex + 1 < lvMessagesView.count) lvMessagesView.currentIndex += 1
                }
                Button {
                    id: sendSMS
                    anchors.topMargin: 10
                    width: (sendMail.opacity = 1) ? sendMessageColumn.width / 2 -10 : sendMessageColumn.width
                    height: 50
                    buttonImage: "../img/go-down.svgz"
                    buttonText: qsTr("Send to mobile phone")
                    shortcut: Qt.Key_Down
                    spokenText: true
                    buttonLayout: Qt.Horizontal
                    anchors.right: parent.right
                    onOpacityChanged: {
                        if (sendSMS.opacity = 1) {
                            sendMail.width = sendMessageColumn.width / 2 -10
                        } else {
                            sendMail.width = sendMessageColumn.width
                        }
                    }
        //            onButtonClick: if (lvMessagesView.currentIndex + 1 < lvMessagesView.count) lvMessagesView.currentIndex += 1
                }
            }
        }
    }
}
