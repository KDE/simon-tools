import QtQuick 1.1
import "parts"

TabPage {
    id: screen
    objectName: "MainCommunicationSendMessage"
    stateName: "CommunicationSendMessage"
    property string prettyName: ""

    Page {
        title: qsTr("Send message to ") + parent.prettyName
        stateName:parent.stateName
        id: sendMessagePage

        Column {
            id:sendMessageColumn
            spacing: 10
            anchors {
                left: parent.left
//                right: parent.right
                top: parent.top
                bottom: parent.bottom
                margins: 160
                topMargin: 110
                rightMargin: 0
//                bottomMargin: 200
            }
            width: screen.width - 320

            Row {
                spacing: 10
                width: parent.width

                Text {
                    id: subjectLabel
                    text: qsTr("Subject:")

                }

                Rectangle {
                    width: parent.width - subjectLabel.width -10
                    height: parent.height
                    color: "Lightblue"
                    TextInput {
                        id: textInput
                        text: ""
                        activeFocusOnPress: false
                        color: "Black"
                        width: parent.width
                        MouseArea {
                           anchors.fill: parent
                           onClicked: {
                               if (!textInput.activeFocus) {
                                   textInput.forceActiveFocus();
                                   textInput.openSoftwareInputPanel();
                               } else {
                                   textInput.focus = false;
                               }
                           }
                           onPressAndHold: textInput.closeSoftwareInputPanel
                        }
                    }
                }
            }
            Row {
                spacing: 10
                width: parent.width
                height: 150

                Text {
                    id: textLabel
                    text: qsTr("Subject:")

                }

                Rectangle {
                    width: parent.width - textLabel.width -10
                    height: parent.height
                    color: "Lightblue"
                    TextEdit{
                        id: messageInput
                        text: "testtext"
                        activeFocusOnPress: false
                        color: "Black"
                        width: parent.width
                        height: parent.height
                        wrapMode: TextEdit.Wrap
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
                    }
                }
            }
            Row {
                spacing: 20
                Button {
                    id: sendMail
                    anchors.top: sendMessageColumn.bottom
                    anchors.right: sendMessageColumn.right
                    anchors.topMargin: 10
                    width: sendMessageColumn.width / 2 -10
                    height: 50
                    buttonImage: "../img/go-down.svgz"
                    buttonText: qsTr("Send E-Mail")
                    shortcut: Qt.Key_Down
                    spokenText: true
                    buttonLayout: Qt.Horizontal
        //            onButtonClick: if (lvMessagesView.currentIndex + 1 < lvMessagesView.count) lvMessagesView.currentIndex += 1
                }
                Button {
                    id: sendSMS
                    anchors.top: sendMessageColumn.bottom
                    anchors.left: sendMessageColumn.left
                    anchors.topMargin: 10
                    width: sendMessageColumn.width / 2 -10
                    height: 50
                    buttonImage: "../img/go-down.svgz"
                    buttonText: qsTr("Send SMS")
                    shortcut: Qt.Key_Down
                    spokenText: true
                    buttonLayout: Qt.Horizontal
        //            onButtonClick: if (lvMessagesView.currentIndex + 1 < lvMessagesView.count) lvMessagesView.currentIndex += 1
                }
            }
        }
    }
}
