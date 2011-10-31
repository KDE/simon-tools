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
    Grid {
//        y: 678
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        columns: 2
        spacing: 20

        KeyCalcButton {
            btKeyCalcButtonText: qsTr("Calculator")
            btKeyCalcButtonImage: ("../img/calculator.png")
        }
        KeyCalcButton {
            btKeyCalcButtonText: qsTr("Keyboard")
            btKeyCalcButtonImage: ("../img/keyboard.png")
        }
    }
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
//    //    Backbutton
//        BackButton {
//            id: btBack
//            x: 1
//            y: 0
//            onButtonClick: screen.showScreen("main.qml")
//        }
}

