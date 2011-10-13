import QtQuick 1.1

Rectangle {
    id: btMainButton
    property string buttonText: qsTr("DemoButtonText")
    property string buttonImage: "../img/demo.png"
    property color onHoverColor: "#FEF57B"
    property color normalColor: "#FFFBC7"
    property string buttonNumber: qsTr("1")
    width: 240
    height: 250
    radius: 10
    smooth: true
    color: "#FFFBC7"
    border.color: "#8A8A8A"
    border.width: 1
    Text {
        id: mainButtonText
        text: buttonText
        x: 50
        font.family: "Arial"
        font.pointSize: 16
        anchors.bottom: parent.bottom
        anchors.margins: 6
    }
    Text {
        id: mainButtonNumber
        text: buttonNumber
        x: 5
        anchors.bottom: parent.bottom
        font.family: "Arial"
        font.pointSize: 40
        color: "#0066ff"
    }
    Image {
        id: mainButtonImage
        source: buttonImage
        width: 165
        height: 165
        anchors.rightMargin: 25
        anchors.topMargin: 25
        anchors.right: parent.right
        anchors.top: parent.top
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
        hoverEnabled: true
        onEntered: parent.color = onHoverColor
        onExited: parent.color = normalColor
    }
    signal buttonClick()
    onButtonClick: {
        console.log(mainButtonText.text + " clicked" )
    }
}
