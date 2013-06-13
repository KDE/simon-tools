import QtQuick 1.1

Rectangle {
    id: button
    property color buttonColor: "steelblue"
    property alias textColor: btnText.color
    property alias text: btnText.text
    property alias isPressed: buttonMouseArea.pressed
    property alias font: btnText.font

    signal clicked()
    signal pressed()
    signal released()

    border.color: Qt.darker(buttonColor, 1.5)
    border.width: 1


    height: btnText.height + 20
    color: buttonMouseArea.pressed ? Qt.darker(buttonColor, 1.5) : buttonColor


    MouseArea{
        id: buttonMouseArea
        onClicked: button.clicked()
        onPressed: button.pressed()
        onReleased: button.released()
        hoverEnabled: true
        onEntered: parent.border.color =  Qt.lighter(buttonColor,0.5)
        onExited:  parent.border.color = Qt.darker(buttonColor, 1.5)
        anchors.fill: parent
    }

    Text {
        id: btnText
        anchors.centerIn: parent
        color: "white"
    }

}
