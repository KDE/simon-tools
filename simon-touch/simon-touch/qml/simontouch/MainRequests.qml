import QtQuick 1.1
import "parts"

TabPage {
    id: screen
    objectName: "MainRequests"
    stateName: "Requests"

    Page {
        stateName: parent.stateName
        title: qsTr("Requests")
        PageGrid {
            id: pageGrid
            Button {
                objectName: "btRequestsShopping"
                buttonText: qsTr("Shopping")
                buttonNumber: "1"
                shortcut: Qt.Key_1
                buttonImage: ("../img/Button_Anfragen_Bestellung.png")
                onButtonClick: setScreen("MainRequestsShopping")
            }
            Button {
                objectName: "btRequestsTransport"
                buttonText: qsTr("Transport")
                buttonNumber: "2"
                shortcut: Qt.Key_2
                buttonImage: ("../img/Button_Anfragen_Transport.png")
                onButtonClick: setScreen("MainRequestsTransport")
            }
            Button {
                objectName: "btRequestsSupport"
                buttonText: qsTr("Support")
                buttonNumber: "3"
                shortcut: Qt.Key_3
                buttonImage: ("../img/Button_Anfragen_Unterstuetzung.png")
                onButtonClick: setScreen("MainRequestsSupport")
            }
    //        Button {
    //            objectName: "btOrdersGas"
    //            buttonText: qsTr("Gas control")
    //            buttonNumber: "4"
    //            shortcut: Qt.Key_4
    //            buttonImage: ("../img/Button_Auftraege_Gas.png")
    //        }
        }
    }
    MainRequestsShopping {
        objectName: "MainRequestsShopping"
    }
    MainRequestsTransport {
        objectName: "MainRequestsTransport"
    }
    MainRequestsSupport {
        objectName: "MainRequestsSupport"
    }
}
