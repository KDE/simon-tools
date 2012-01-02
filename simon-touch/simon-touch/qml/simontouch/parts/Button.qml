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
    property bool extraSpokenText: true
    property int buttonLayout: Qt.Vertical
    signal buttonClick()
    property bool horizontalMiddleText:  true
    property string horizontalIconAlign: "left"

    width: 240
    height: 250
    radius: 10
    smooth: true
    color: normalColor
    border.color: "#8A8A8A"
    border.width: 1
    Text {
        id: mainButtonText
        text: buttonText

        font.family: "Arial"
        font.pointSize: 16
        anchors.bottom: (buttonLayout == Qt.Vertical) ? parent.bottom : undefined
        anchors.left: (buttonLayout == Qt.Horizontal && horizontalMiddleText == true && horizontalIconAlign == "left") ? mainButtonImage.right : undefined
        anchors.verticalCenter: (buttonLayout == Qt.Horizontal && horizontalMiddleText == true) ? parent.verticalCenter : undefined
        anchors.top: (buttonLayout == Qt.Horizontal && horizontalMiddleText == false) ? parent.top : undefined
        anchors.margins: 9
//        anchors.topMargin: 6
//        anchors.leftMargin: 6
//        anchors.rightMargin: 6
//        anchors.bottomMargin: 0
        color: (spokenText == true) ? "#000099" : "#000000"

        /*
        anchors.leftMargin: 50
        anchors.left: parent.left*/
        anchors.horizontalCenter: parent.horizontalCenter
    }
    Text {
        id: mainButtonNumber
        text: buttonNumber
        x: 5
        anchors.bottom: (buttonLayout == Qt.Vertical) ? parent.bottom :undefined
        anchors.verticalCenter: (buttonLayout == Qt.Horizontal) ? parent.verticalCenter : undefined
        anchors.right: (buttonLayout == Qt.Horizontal) ? parent.right : undefined
        anchors.margins: (buttonLayout == Qt.Horizontal) ? 9 : 0
        font.family: "Arial"
        font.pointSize: (buttonLayout == Qt.Horizontal) ? 16 : 44
        color: "#000099"
        visible: (buttonNumber == "" || extraSpokenText == false) ? 0 : 1
    }
    Image {
        id: mainButtonImage
        source: buttonImage
        anchors.leftMargin: (buttonLayout == Qt.Vertical) ? 37 : 10
        anchors.rightMargin: (buttonLayout == Qt.Vertical) ? 38 : 10
        anchors.topMargin: (buttonLayout == Qt.Vertical) ? 25 : 10
        anchors.left: (buttonLayout == Qt.Horizontal && horizontalIconAlign != "right") ? parent.left : undefined
        anchors.right: (buttonLayout == Qt.Horizontal && horizontalIconAlign == "right") ? parent.right : undefined
        anchors.verticalCenter: (buttonLayout == Qt.Horizontal && horizontalMiddleText == true) ? parent.verticalCenter : undefined
        anchors.horizontalCenter: (buttonLayout == Qt.Vertical && horizontalIconAlign != "right") ? parent.horizontalCenter : undefined
        anchors.top: (buttonLayout == Qt.Horizontal && horizontalMiddleText == false) ? parent.top : undefined
        height: (buttonLayout == Qt.Horizontal) ? parent.height - 20 : parent.height * 0.7

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
        anchors.fill: parent
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
