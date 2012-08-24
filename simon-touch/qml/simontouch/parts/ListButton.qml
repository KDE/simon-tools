// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {
    id: listButton
    property string buttonText: ""
    property string buttonImage: ""
    property color onHoverColor: "#FFFFFF"
    property color normalColor: "#DEE9F1"
    property string buttonNumber: ""
    property int buttonKey: 0
    property bool spokenText: false
    property int shortcut
    property bool extraSpokenText: true
    property int buttonLayout: Qt.Vertical
    property bool horizontalMiddleText:  true
    property string horizontalIconAlign: "left"
    property bool active : false
    property bool activeHover: true
    signal buttonClick()

    width: 200
    height: 40
    radius: 0
    smooth: true

    color: (active || buttonMouseArea.isHovering) ? onHoverColor : normalColor
    border.width: 5
    border.color: "#FFFBC7"
    Text {
        id: mainButtonText
        text: buttonText

        font.family: "Arial"
        font.pointSize: 16
        anchors.bottom: (buttonLayout == Qt.Vertical) ? parent.bottom : undefined
        anchors.verticalCenter: (buttonLayout == Qt.Horizontal && horizontalMiddleText == true) ? parent.verticalCenter : undefined
        anchors.top: (buttonLayout == Qt.Horizontal && horizontalMiddleText == false) ? parent.top : undefined
        anchors.margins: 9
        color: "#000099"
        anchors.horizontalCenter: parent.horizontalCenter
    }
    MouseArea{
        property bool isHovering : false
        id: buttonMouseArea
        x: 0
        y: 0
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        anchors.fill: parent
        onClicked: buttonClick()
        hoverEnabled: parent.activeHover
        onEntered: isHovering = true
        onExited: isHovering = false
    }
    onButtonClick: {
        console.log(mainButtonText.text + " clicked" )
    }

    function registerInPage(page) {
        if (simonTouch.componentName(page).indexOf("Page") === 0)
            page.registerButton(listButton)
        else {
            if (page.parent)
                registerInPage(page.parent)
        }
    }

    function handleKey(key) {
        if ((key == shortcut) && (button.opacity == 1)) {
            buttonClick()
            return true
        }
        return false
    }

    Component.onCompleted: {
        registerInPage(parent)
    }
}
