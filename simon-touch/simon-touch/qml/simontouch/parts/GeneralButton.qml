import QtQuick 1.1

Button {
    id: btGeneral1Button
    property alias buttonText: mainButtonText.text
    property string buttonImage: "../img/demo.png"
    property color onHoverColor: "#FEF57B"
    property color normalColor: "#FFFBC7"
    property bool spokenText: false
    property bool toggleFunction: false
    property bool disableImage: false

    width: 240
    height: 50
    radius: 10
    smooth: true
    color: "#FFFBC7"
    border.color: "#8A8A8A"
    border.width: 1
    Text {
        id: mainButtonText
        font.family: "Arial"
        font.pointSize: 16
        anchors {
            verticalCenter: parent.verticalCenter
            horizontalCenter: parent.horizontalCenter
        }
        visible: true
        color: (spokenText == true) ? "#0066ff" : "Black"
    }
    Image {
        id: mainButtonImage
        source: buttonImage
//        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.rightMargin: 20
        height: parent.height - 20
        fillMode: Image.PreserveAspectFit
        smooth: true
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: 10
        visible: (disableImage == true) ? 0 : 1
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
        onEntered: (toggleFunction == false && toggleFunction == false) ? parent.color = onHoverColor : parent.color = normalColor
        onExited: (toggleFunction == false && toggleFunction == false) ? parent.color = normalColor : parent.color = normalColor
    }
    onButtonClick: {
        console.log(mainButtonText.text + " clicked" )
    }
}
