import QtQuick 1.1
import "parts"

Rectangle {
    id: main
    width: 1024
    height: 768
    color: "#FFFBC7"

    TabPage {
        opacity: 1
        id: tabs
        z: ((keyboardButton.state == "collapsed") && (calculatorButton.state == "collapsed")) ? 5 : 0
        backAvailable: false

        MainScreen {
            objectName: "MainScreen"
            backAvailable: false
        }

        MainInformation {
            objectName: "MainInformation"
        }
        MainCommunication {
            objectName: "MainCommunication"
        }
        MainOrders {
            objectName: "MainOrders"
        }
        MainRequests {
            objectName: "MainRequests"
        }

    }
    KeyCalcButton {
        id: calculatorButton
        z: (keyboardButton.state == "collapsed") ? 1 : 0
        anchors.bottom: parent.bottom
        x: (parent.width / 2) - 250
        btKeyCalcButtonText: (state == "collapsed") ? qsTr("Calculator") : qsTr("Close calculator")
        btKeyCalcButtonImage: ("../img/calculator.png")
        onButtonClick: {
            if (state == "collapsed")
                simonTouch.hideCalculator()
            else
                simonTouch.showCalculator()
        }
    }
    KeyCalcButton {
        id: keyboardButton
        z: (calculatorButton.state == "collapsed") ? 1 : 0
        anchors.bottom: parent.bottom
        x: (parent.width / 2) + 10
        btKeyCalcButtonText: (state == "collapsed") ? qsTr("Keyboard") : qsTr("Close keyboard")
        btKeyCalcButtonImage: ("../img/keyboard.png")
        onButtonClick: {
            if (state == "collapsed")
                simonTouch.hideKeyboard()
            else
                simonTouch.showKeyboard()
        }
    }
    //}
    Rectangle {
        id: closebutton
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        width: 75
        height: 50
        color: Qt.darker("#FFFBC7", 1.1)
        Text {
            anchors.centerIn: parent
            text: "Quit"

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
            onClicked: Qt.quit()
        }
    }
}

