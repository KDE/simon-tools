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
        text: qsTr("Kommunikation")
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
            objectName: "btKommunikationTelefon"
            width: 240
            height: 250
            radius: 10
            buttonText: qsTr("Telefon")
            buttonNumber: "1"
            buttonImage: ("../img/Button_Kommunikation_Telefon.png")
        }
        MainButton {
            id: btMainButton2
            objectName: "btKommunikationEmail"
            width: 240
            height: 250
            radius: 10
            buttonText: qsTr("E-Mail")
            buttonNumber: "2"
            buttonImage: ("../img/Button_Kommunikation_EMail.png")
        }
        MainButton {
            id: btMainButton3
            objectName: "btKommunikationSms"
            width: 240
            height: 250
            radius: 10
            buttonText: qsTr("SMS")
            buttonNumber: "3"
            buttonImage: ("../img/Button_Kommunikation_Sms.png")
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
//            btKeyCalcButtonImage: ("img/calculator.png")
//        }
//        KeyCalcButton {
//            btKeyCalcButtonText: qsTr("Tastatur")
//            btKeyCalcButtonImage: ("img/keyboard.png")
//        }
//    }
}
