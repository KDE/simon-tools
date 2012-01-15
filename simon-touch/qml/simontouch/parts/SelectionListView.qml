import QtQuick 1.1

ListView {
    id: lvImages
    Component {
        id: highlight
        Rectangle {
                color: "#FEF57B" // "lightsteelblue"
                radius: 5
                width: parent.width -2
                border.color: "#8A8A8A"
                border.width: 1
        }
    }
    Component {
        id: lowlight
        Rectangle {
                color: "#FFFBC7"
                radius: 5
                width: parent.width -2
                border.color: "#8A8A8A"
                border.width: 1
        }
    }


    clip: true
    highlight: (activeFocus) ? highlight : lowlight
    spacing: 10

    Keys.onPressed: {
        if (event.key == Qt.Key_PageUp) {
            currentIndex = (currentIndex >= 5) ? currentIndex - 5 : 0
        } else if (event.key == Qt.Key_PageDown) {
            currentIndex = (currentIndex + 5 < count) ? currentIndex + 5 : count -1
        }
    }
}
