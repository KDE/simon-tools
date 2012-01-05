import QtQuick 1.1

import "parts"

TabPage {
    id: screen
    objectName: "MainActiveCall"
    stateName: "MainActiveCall"
    focus: true
    property alias callImage: callImage.source
    property alias callName: callItemView.callName
    property alias callNumber: callItemView.callNumber
    property alias visibleAccept: acceptCall.visible

    onOpacityChanged: changeButtonVisibility(screen.opacity < 0.5)

    Page {
        stateName: parent.stateName
        title: ""
        Item {
            id: callItemView
            width: parent.width / 2
            height: parent.height / 2
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            property string callName: ""
            property string callNumber: ""
            Rectangle {
                width: screen.width / 2
                anchors.centerIn: parent.Center
                Row {
                    spacing: 10
                    height: 150
                    id: activeCallRow

                    Image {
                        id: callImage
                        height: parent.height
                        fillMode: Image.PreserveAspectFit
                    }

                    Column {

                        Text {
                            id: callName
                            text: callItemView.callName
                            font.family: "Arial"
                            font.pointSize: 20
                        }
                    }
                }
                Button {
                    id: acceptCall
                    buttonText: qsTr("Accept")
                    height: 50
                    buttonImage: "../img/go-down.svgz"
                    spokenText: true
                    buttonLayout: Qt.Horizontal
                    anchors.left: parent.left
                    anchors.top: activeCallRow.bottom
                    anchors.topMargin: 10
                    onButtonClick: simonTouch.pickUp()
                }
                Button {
                    id: declineCall
                    buttonText: qsTr("Hang up")
                    height: 50
                    buttonImage: "../img/go-down.svgz"
                    spokenText: true
                    buttonLayout: Qt.Horizontal
                    anchors.right: parent.right
                    anchors.top: activeCallRow.bottom
                    anchors.topMargin: 10
                    onButtonClick: simonTouch.hangUp()
                }
            }
        }
    }
}
