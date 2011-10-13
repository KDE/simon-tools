import QtQuick 1.1
import "parts"

Rectangle {
    id: main
    width: 1024
    height: 768

    Loader {
        id: loader
        source: "Mainscreen.qml"
    }

    Connections {
        target: loader.item
        onShowScreen: loader.source = msg;
    }
}
