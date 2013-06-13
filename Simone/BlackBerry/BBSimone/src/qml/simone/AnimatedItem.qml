import QtQuick 1.1

Item {
    property bool inverted : false

    id: animatedItem
    anchors.margins: 30
    state: "hidden"
    width: 300
    states: [
        State {
            name: "hidden"
            PropertyChanges {
                target: animatedItem
                opacity: 0
                anchors.topMargin: inverted ? 10 : -20
            }
        },
        State {
            name: "shown"
            PropertyChanges {
                target: animatedItem
                opacity: 1
                anchors.topMargin: inverted ? -20 : 10
            }
        }

    ]

    transitions: [
        Transition {
            from: "*"
            to: "*"
            NumberAnimation { target: animatedItem; properties: "opacity,anchors.topMargin"; duration: 200; easing.type: Easing.InOutQuad }
        }
    ]
}
