import QtQuick 1.1

Rectangle {
    id: btSideButton
    property string buttonText: qsTr("SideButtonText")
    property string buttonImage: "../img/demo.png"
    property color normalColor: "#FEF57B"
    width: 240
    height: 100
    radius: 10
    smooth: true
    color: "#FEF57B"
    border.color: "#8A8A8A"
    border.width: 1
    Item {
//        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        x: 10
        Text {
            id: mainButtonText
            text: buttonText
            anchors.left: sideButtonImage.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.margins: 5
            font.family: "Arial"
            font.pointSize: 16
        }
//        Image {
//            id: spacer
//            width: 25
//            height: parent.height
//        }
        Image {
            id: sideButtonImage
            source: buttonImage
            width: 65
            height: 65
            anchors.verticalCenter: parent.verticalCenter
        }
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
        onClicked: console.log(mainButtonText.text + " clicked" )
    }
    signal buttonClick()
    onButtonClick: {
        console.log(buttonLabel.text + " clicked" )
    }
}