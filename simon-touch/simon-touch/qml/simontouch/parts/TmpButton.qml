import QtQuick 1.1

Rectangle {
    id: button
    property string buttonText: qsTr("DemoButtonText")
    property string buttonImage: ""
    property color onHoverColor: "#FEF57B"
    property color normalColor: "#FFFBC7"
    property string buttonNumber: ""
    property int buttonKey: 0
    property bool spokenText: false
    property int shortcut
    property int buttonLayout: Qt.Vertical
    signal buttonClick()

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

        font.family: "Arial"
        font.pointSize: 16
        anchors.bottom: (buttonLayout == Qt.Vertical) ? parent.bottom : undefined
        anchors.verticalCenter: (buttonLayout == Qt.Horizontal) ? parent.verticalCenter : undefined
        anchors.margins: 6
        color: (spokenText == true) ? "#0066ff" : "#000000"

        /*
        anchors.leftMargin: 50
        anchors.left: parent.left*/
        anchors.horizontalCenter: parent.horizontalCenter
    }
    Text {
        id: mainButtonNumber
        text: buttonNumber
        x: 5
        anchors.bottom: parent.bottom
        font.family: "Arial"
        font.pointSize: 40
        color: "#0066ff"
        visible: (buttonNumber == "" || buttonLayout == Qt.Horizontal) ? 0 : 1
    }
    Image {
        id: mainButtonImage
        source: buttonImage
        anchors.leftMargin: (buttonLayout == Qt.Vertical) ? 37 : 10
        anchors.rightMargin: (buttonLayout == Qt.Vertical) ? 38 : 10
        anchors.topMargin: (buttonLayout == Qt.Vertical) ? 25 : 0
        anchors.left: (buttonLayout == Qt.Vertical) ? parent.left : parent.left
        anchors.verticalCenter: (buttonLayout == Qt.Horizontal) ? parent.verticalCenter : undefined
        anchors.horizontalCenter: (buttonLayout == Qt.Vertical) ? parent.horizontalCenter : undefined
        height: (buttonLayout == Qt.Horizontal) ? parent.height - 20 : parent.height * 0.8

        visible: (buttonImage == "") ? 0 : 1

        fillMode: Image.PreserveAspectFit
        smooth: true
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
    onButtonClick: {
        console.log(mainButtonText.text + " clicked" )
    }

    function registerInPage(page) {
        if (simonTouch.componentName(page).indexOf("Page") === 0)
            page.registerButton(button)
        else {
            if (page.parent)
                registerInPage(page.parent)
        }
    }

    function handleKey(key) {
//        console.debug("Handling key: "+key+shortcut)
        if (key == shortcut) {
            buttonClick()
            return true
        }
        return false
    }

    Component.onCompleted: {
        registerInPage(parent)
    }
}
