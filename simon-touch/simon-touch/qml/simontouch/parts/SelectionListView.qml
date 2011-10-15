import QtQuick 1.0

ListView {
    id: lvImages

    anchors.fill: parent
    clip: true
    highlight: Rectangle { color: "lightsteelblue"; radius: 5 }

    spacing: 20

    Keys.onPressed: {
        if (event.key == Qt.Key_PageUp) {
            currentIndex = (currentIndex >= 5) ? currentIndex - 5 : 0
        } else if (event.key == Qt.Key_PageDown) {
            currentIndex = (currentIndex + 5 < count) ? currentIndex + 5 : count -1
        }
    }
}
