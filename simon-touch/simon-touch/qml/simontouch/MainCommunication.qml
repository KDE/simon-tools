import QtQuick 1.1
import "parts"

TabPage {
    id: screen
    objectName: "MainCommunication"
    stateName: "Communication"

    Page {
        stateName: parent.stateName
        title: qsTr("Communication")
        state: "selectTarget"

        ListModel {
            id: lvContactsModel
            ListElement {
                name: "Stieger Franz"
                tel: "0664/4034321"
                skype: "franz.stieger"
                email: "stiegerf@noemail.com"
                image: "/home/simon/franz_01.jpg"
            }
        }

        Component {
            id: contactsDelegate
            Item {
                Text {
                    text: name
                    font.family: "Arial"
                    font.pointSize: 16
                    font.weight: Font.Bold
                    anchors.left: parent.left
    //                anchors.verticalCenter: parent.verticalCenter
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            lvContactsView.currentIndex = index;
                        }
                    }
                }
                Text {
                    text: tel
                    font.family: "Arial"
                    font.pointSize: 16
                    font.weight: Font.Bold
                    anchors.right: parent.right
    //                anchors.verticalCenter: parent.verticalCenter
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            lvContactsView.currentIndex = index;
                        }
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
                rightMargin: 0
//                bottomMargin: 200
            }
            width: screen.width / 2 - 210
            model: lvContactsModel
            delegate: contactsDelegate
        }

        states: [
            State {
                name: "selectTarget"
            },
            State {
                name: "enterMessage"
            }

        ]

    }
}
