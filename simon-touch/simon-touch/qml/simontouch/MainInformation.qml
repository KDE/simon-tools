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
        text: qsTr("Information")
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
            objectName: "btInformationVideo"
            width: 240
            height: 250
            radius: 10
            buttonText: qsTr("Video")
            buttonNumber: "1"
        }
        MainButton {
            id: btMainButton2
            objectName: "btInformationMusik"
            width: 240
            height: 250
            radius: 10
            buttonText: qsTr("Musik")
            buttonNumber: "2"
        }
        MainButton {
            id: btMainButton3
            objectName: "btInformationBilder"
            width: 240
            height: 250
            radius: 10
            buttonText: qsTr("Bilder")
            buttonNumber: "3"
        }
        MainButton {
            id: btMainbutton4
            objectName: "btInformationZeitungen"
            width: 240
            height: 250
            radius: 10
            buttonText: qsTr("Zeitungen")
            buttonNumber: "4"
            buttonImage: ("../img/rss.png")
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
