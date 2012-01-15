import QtQuick 1.1
import "parts"

TabPage {
    id: screen
    objectName: "MainCommunicationReadMessages"
    stateName: "CommunicationReadMessages"
    property string prettyName: ""

    Page {
        title: qsTr("Read messages from ") + parent.prettyName
        stateName:parent.stateName
        id: readMessagePage

        Component {
            id: messagesDelegate
            Item {
                height: 30
                width: lvContactsView.width
                Row {
                    spacing: 20
                    height: parent.height
                    width: parent.width
                    Image {
                        source: icon
                        height: parent.height
                        fillMode: Image.PreserveAspectFit
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Text {
                        text: subject
                        font.family: "Arial"
                        font.pointSize: 10
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Text {
                        text: datetime
                        font.family: "Arial"
                        font.pointSize: 10
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
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
            id: lvMessagesView
            objectName: "lvMessagesView"

            property int listViewItemHeight: 60

            anchors {
                left: parent.left
//                right: parent.right
                top: parent.top
                bottom: parent.bottom
                margins: 160
//                topMargin: 210
                rightMargin: 0
//                bottomMargin: 200
            }
            width: screen.width - 320
            model: messagesModel
            delegate: MessagesListDelegate {}
        }

        Button {
            id: lvImagesUp
            anchors.bottom: lvMessagesView.top
            anchors.left: lvMessagesView.left
            anchors.bottomMargin: 10
            width: lvMessagesView.width
            height: 50
            buttonImage: "../img/go-up.svgz"
            buttonText: qsTr("Up")
            shortcut: Qt.Key_Up
            spokenText: true
            buttonLayout: Qt.Horizontal
            onButtonClick: if (lvMessagesView.currentIndex > 0) lvMessagesView.currentIndex -= 1
        }

        Button {
            id: lvImagesDown
            anchors.top: lvMessagesView.bottom
            anchors.left: lvMessagesView.left
            anchors.topMargin: 10
            width: lvMessagesView.width
            height: 50
            buttonImage: "../img/go-down.svgz"
            buttonText: qsTr("Down")
            shortcut: Qt.Key_Down
            spokenText: true
            buttonLayout: Qt.Horizontal
            onButtonClick: if (lvMessagesView.currentIndex + 1 < lvMessagesView.count) lvMessagesView.currentIndex += 1
        }
    }
}
