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
        text: Qt.formatDateTime(new Date(), "dddd, dd. MMMM yyyy")
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
            objectName: "btInformation"
            width: 240
            height: 250
            radius: 10
            buttonText: qsTr("Information")
            buttonNumber: "1"
            buttonImage: ("../img/Button_Information.png")
            onButtonClick: screen.showScreen("MainInformation.qml")
        }
        MainButton {
            id: btMainButton2
            objectName: "btKommunikation"
            width: 240
            height: 250
            radius: 10
            buttonText: qsTr("Kommunikation")
            buttonNumber: "2"
            buttonImage: ("../img/Button_Kommunikation.png")
            onButtonClick: screen.showScreen("MainKommunikation.qml")
        }
        MainButton {
            id: btMainButton3
            objectName: "btAuftraege"
            width: 240
            height: 250
            radius: 10
            buttonText: qsTr("Aufträge")
            buttonNumber: "3"
            buttonImage: ("../img/Button_Auftraege.png")
            onButtonClick: screen.showScreen("MainAuftraege.qml")
        }
        MainButton {
            id: btMainbutton4
            objectName: "btAnfrage"
            width: 240
            height: 250
            radius: 10
            buttonText: qsTr("Anfrage")
            buttonNumber: "4"
            buttonImage: ("../img/Button_Anfragen.png")
            onButtonClick: screen.showScreen("MainAnfrage.qml")
        }
    }

//    Backbutton
//    BackButton {
//        x: 1
//        y: 0
//    }

//    Keyboard and Calculator
    Grid {
//        y: 678
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        columns: 2
        spacing: 20

        KeyCalcButton {
            btKeyCalcButtonText: qsTr("Taschenrechner")
            btKeyCalcButtonImage: ("../img/calculator.png")
        }
        KeyCalcButton {
            btKeyCalcButtonText: qsTr("Tastatur")
            btKeyCalcButtonImage: ("../img/keyboard.png")
        }
    }
}
