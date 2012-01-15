import QtQuick 1.1
import "button.js" as ButtonEngine

Item {

    function registerButton(btn) {
        ButtonEngine.addButton(btn)
    }

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

    function handleKey(key) {
        if (key == Qt.Key_Escape && current != "MainScreen") {
            back()
            return true
        }

        if (key == Qt.Key_Q) Qt.quit()

        return ButtonEngine.relayKey(key);
    }


    Keys.onPressed: {
        if (handleKey(event.key)) {
            event.accepted = true
            return
        }
    }
}
