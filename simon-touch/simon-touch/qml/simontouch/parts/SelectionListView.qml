import QtQuick 1.1

ListView {
    id: lvImages

    clip: true
    highlight: Rectangle { color: "lightsteelblue"; radius: 5 }

    spacing: 10

    Keys.onPressed: {
        if (event.key == Qt.Key_PageUp) {
            currentIndex = (currentIndex >= 5) ? currentIndex - 5 : 0
        } else if (event.key == Qt.Key_PageDown) {
            currentIndex = (currentIndex + 5 < count) ? currentIndex + 5 : count -1
        }
    }
}
