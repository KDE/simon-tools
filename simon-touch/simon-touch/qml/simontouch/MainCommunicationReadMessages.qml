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

        ListModel {
            id: lvMessageList
            ListElement {
                icon: "../img/mail-unread.svgz"
                subject: "Das ist ein Testsubjekt"
                message: "Das ist ein Testtext."
                datetime: "11/11/2011 11:11"
            }
            ListElement {
                icon: "../img/mail-read.svgz"
                subject: "Das ist ein Testsubjekt 2"
                message: "Lorem <b>ipsum dolor sit amet</b>, consectetur adipiscing elit. Sed augue est, faucibus sed gravida sed, fermentum et dolor. Nam et tristique leo. Praesent tincidunt, massa semper pharetra convallis, diam dolor luctus diam, a euismod leo sem ut mi. Proin in est et nulla rhoncus rutrum. Cras at dui quis arcu vulputate vehicula quis ut velit. Quisque aliquam tempus dignissim. Vivamus mattis aliquet tempor. Ut ante metus, scelerisque nec hendrerit non, euismod vitae nisi. Nunc leo massa, aliquam dapibus consectetur et, tempor eget tortor. Morbi ligula leo, pharetra eget laoreet non, lobortis sed erat. Etiam porta posuere ultricies. Curabitur nisi tortor, euismod et fringilla elementum, iaculis in purus. Aenean consequat tempus nisi, et ultrices sapien feugiat rutrum. Fusce interdum magna facilisis metus cursus suscipit. Aenean tincidunt pharetra diam ut consectetur. Nulla facilisi. Fusce est lectus, condimentum vitae venenatis at, lobortis nec diam. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Phasellus urna sapien, venenatis ut dictum a, gravida non justo. Donec non sapien ut arcu cursus dapibus. Vivamus fermentum condimentum turpis vel tincidunt. Cras vel libero lacus. Ut a justo in lorem aliquam consequat. Sed libero nisi, pretium ac pulvinar a, condimentum pulvinar risus. Pellentesque et ante mi. Sed interdum tortor id dui malesuada vitae molestie magna molestie. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Ut pellentesque dapibus commodo. Morbi eget sapien dui, id mattis nibh. Sed tincidunt consectetur dapibus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus."
                datetime: "11/11/2011 11:11"
            }
            ListElement {
                icon: "../img/mail-read.svgz"
                subject: "Das ist ein Testsubjekt 3"
                message: "Das ist ein Testtext."
                datetime: "11/11/2011 11:11"
            }
            ListElement {
                icon: "../img/mail-read.svgz"
                subject: "Lorem Ipsum"
                message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ac erat arcu, porttitor feugiat nisl. Sed id ipsum arcu, a consectetur eros. Integer bibendum, nulla id aliquam tincidunt, leo quam euismod diam, quis tempor arcu quam eu purus. Cras ut enim nunc, id interdum nunc. Nulla sed velit magna. In hac habitasse platea dictumst. Duis suscipit, sapien eget pellentesque vestibulum, nibh felis imperdiet erat, sit amet pharetra orci turpis eu nunc. Ut nisl sapien, consequat et bibendum vel, sodales molestie nunc. Donec elit lorem, posuere non gravida a, tempor eu purus.

                Fusce quis enim nec nulla aliquam scelerisque sed eget metus. Maecenas adipiscing massa dignissim mi pharetra vitae ultricies elit auctor. Phasellus dictum imperdiet purus. Phasellus euismod arcu non ante facilisis non faucibus nunc feugiat. Curabitur eros est, rhoncus vitae ultrices id, posuere non arcu. Sed in posuere neque. Aliquam vitae diam turpis, viverra fermentum diam. Maecenas vel augue eu eros lobortis euismod vitae in nunc. Suspendisse quis venenatis enim. Nam in diam lacus. Mauris sit amet dolor ac velit mollis elementum ac nec est."
                datetime: "11/11/2011 11:11"
            }
            ListElement {
                icon: "../img/mail-read.svgz"
                subject: "Das ist ein Testsubjekt 3"
                message: "Das ist ein Testtext."
                datetime: "11/11/2011 11:11"
            }
        }

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
            model: lvMessageList
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
