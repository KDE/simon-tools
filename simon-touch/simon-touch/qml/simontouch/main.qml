import QtQuick 1.1
import "parts"

Rectangle {
    id: main
    width: 1024
    height: 768
    color: "#FFFBC7"

    function changeButtonVisibility(visibility) {
            keyboardButton.opacity = visibility;
            calculatorButton.opacity = visibility;
            console.debug("changeButtonVisibility: " + visibility);
    }

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

        MainIncomingCall {
            objectName: "MainIncomingCall"
            callInImage: "img/franz.jpg"
            callInName: "Franz Stieger"
            callInNumber: "+43 664 3841266"
            backAvailable: false
        }

        MainOutgoingCall {
            objectName: "MainOutgoingCall"
            callOutImage: "img/franz.jpg"
            callOutName: "Franz Stieger"
            callOutNumber: "+43 664 3841266"
            backAvailable: false
        }

        MainActiveCall {
            objectName: "MainActiveCall"
            callImage: "img/franz.jpg"
            callName: "Franz Stieger"
            callNumber: "+43 664 3841266"
            backAvailable: false
            visibleAccept: false
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
        spokenText: true
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
        spokenText: true
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
        anchors.top: parent.top
        anchors.right: parent.right
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

