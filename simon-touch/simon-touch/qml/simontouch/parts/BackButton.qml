import QtQuick 1.1

Rectangle {
    id: btBackButton
    width: 242
    height: 90
    clip: true
    color: "#FFFBC7"

    SideButton {
        id:backSideButton
        x: 0
        y: -11
        width: 240
        height: 100
        buttonText: qsTr("Zurück")
        buttonImage: ("../img/back.png")
    }
    MouseArea{
        id: buttonMouseArea
        x: 0
        y: 0
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        anchors.fill: parent //anchor all sides of the mouse area to the rectangle's anchors
        //onClicked handles valid mouse button clicks
        onClicked: buttonClick()
    }
    signal buttonClick()
    onButtonClick: {
        console.log(backSideButton.buttonText + " clicked" )
    }
}
