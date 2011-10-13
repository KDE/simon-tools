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
        text: qsTr("Anfrage")
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
            objectName: "btAnfrageBestellung"
            width: 240
            height: 250
            radius: 10
            buttonText: qsTr("Bestellung")
            buttonNumber: "1"
        }
        MainButton {
            id: btMainButton2
            objectName: "btAnfrageUnterstuetzung"
            width: 240
            height: 250
            radius: 10
            buttonText: qsTr("Unterstützung")
            buttonNumber: "2"
        }
        MainButton {
            id: btMainButton3
            objectName: "btAnfrageTransport"
            width: 240
            height: 250
            radius: 10
            buttonText: qsTr("Transport")
            buttonNumber: "3"
        }
//        MainButton {
//            id: btMainbutton4
//            width: 240
//            height: 250
//            radius: 10
//            buttonText: qsTr("Zeitungen")
//            buttonNumber: "4"
//            buttonImage: ("../img/rss.png")
//        }
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
//            btKeyCalcButtonImage: ("../img/calculator.png")
//        }
//        KeyCalcButton {
//            btKeyCalcButtonText: qsTr("Tastatur")
//            btKeyCalcButtonImage: ("../img/keyboard.png")
//        }
//    }
}
