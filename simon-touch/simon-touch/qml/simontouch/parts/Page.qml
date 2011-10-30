import QtQuick 1.1

Item {

    id: page
    objectName: "MainScreen"
    property alias title: lbTitle.text
    property string stateName: "Undefined"
    anchors.fill: parent
    opacity:0

    signal showScreen(string msg)

    Text {
        id: lbTitle
        font.pointSize: 20
        font.bold: true
        anchors.horizontalCenter: parent.horizontalCenter
        y: 40
    }

    Behavior on opacity {
        NumberAnimation {properties: "opacity"; duration: 500}
    }
}
