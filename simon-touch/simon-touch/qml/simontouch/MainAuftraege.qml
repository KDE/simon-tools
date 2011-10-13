import QtQuick 1.1

import "parts"

Rectangle {
    id: screen
    width: main.width
    height: main.height
    color: "#FFFBC7"

    signal showScreen(string msg)

    Text {
        font.pointSize: 20
        font.bold: true
        text: qsTr("Aufträge")
        anchors.horizontalCenter: parent.horizontalCenter
        y: 40
    }

    /* Grid for the Mainbuttons */
    Grid {
        rows: 2
        columns: 2
        anchors.centerIn: parent
        spacing: 20

        MainButton {
            id: btMainButton1
            objectName: "btAuftraegeWasser"
            width: 240
            height: 250
            radius: 10
            buttonText: qsTr("Wasser")
            buttonNumber: "1"
            buttonImage: ("../img/Button_Auftraege_Wasser.png")
        }
        MainButton {
            id: btMainButton2
            objectName: "btAuftraegeTueren"
            width: 240
            height: 250
            radius: 10
            buttonText: qsTr("Türen")
            buttonNumber: "2"
            buttonImage: ("../img/Button_Auftraege_Tueren.png")
        }
        MainButton {
            id: btMainButton3
            objectName: "btAuftraegeHerd"
            width: 240
            height: 250
            radius: 10
            buttonText: qsTr("Herd")
            buttonNumber: "3"
            buttonImage: ("../img/Button_Auftraege_Herd.png")
        }
        MainButton {
            id: btMainbutton4
            objectName: "btAuftraegeGas"
            width: 240
            height: 250
            radius: 10
            buttonText: qsTr("Gas")
            buttonNumber: "4"
            buttonImage: ("../img/Button_Auftraege_Gas.png")
        }
    }

//    Backbutton
    BackButton {
        id: btBack
        x: 1
        y: 0
        onButtonClick: screen.showScreen("Mainscreen.qml")
    }

////    Keyboard and Calculator
//    Grid {
////        y: 678
//        anchors.horizontalCenterOffset: 0
//        anchors.horizontalCenter: parent.horizontalCenter
//        anchors.bottom: parent.bottom
//        columns: 2
//        spacing: 20

//        KeyCalcButton {
//            btKeyCalcButtonText: qsTr("Taschenrechner")
//            btKeyCalcButtonImage: ("img/calculator.png")
//        }
//        KeyCalcButton {
//            btKeyCalcButtonText: qsTr("Tastatur")
//            btKeyCalcButtonImage: ("img/keyboard.png")
//        }
//    }
}
