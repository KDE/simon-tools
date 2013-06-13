import QtQuick 1.1


AnimatedItem {
    property alias title: teTitle.text
    property alias text: teBody.text
    id: dialog
    inverted: true

    Rectangle {
        anchors.fill: parent
        border.color: "darkgrey"
        border.width: 1
        color: "darkred"
        opacity: 0.8

        Text {
            id: teTitle
            anchors.verticalCenter: btnClose.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.topMargin: 10
            font.pointSize: 16
            color: "white"
        }
        Button {
            id: btnClose
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.rightMargin: 20
            anchors.topMargin: 10
            width: 200
            text: qsTr("Close")
            onClicked: {
                dialog.state = "hidden"
            }
        }

        Text {
            id: teBody
            anchors.left: teTitle.left
            anchors.top: btnClose.bottom
            anchors.topMargin: 5
            color: "white"

        }
    }
}
