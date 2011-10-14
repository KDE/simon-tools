import QtQuick 1.1

Item {
    objectName: "MainScreen"
    property alias title: lbTitle.text
    anchors.fill: parent

    signal showScreen(string msg)

    Text {
        id: lbTitle
        font.pointSize: 20
        font.bold: true
        anchors.horizontalCenter: parent.horizontalCenter
        y: 40
    }
}
