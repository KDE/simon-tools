import QtQuick 1.1
import "parts"

TabPage {
    id: screen
    objectName: "MainRequestsShopping"
    stateName: "RequestsShopping"

    Page {
        stateName: parent.stateName
        title: qsTr("Shopping")
        PageGrid {
            id: pageGrid
            Button {
                objectName: "btRequestsShoppingHousehold"
                buttonText: qsTr("Household")
                buttonNumber: "1"
                shortcut: Qt.Key_1
                buttonImage: ("../img/Button_Anfragen_Bestellung.png")
                onButtonClick: setScreen("MainRequestsShoppingHousehold")
            }
            Button {
                objectName: "btRequestsShoppingMedic"
                buttonText: qsTr("Medic")
                buttonNumber: "2"
                shortcut: Qt.Key_2
                buttonImage: ("../img/Button_Anfragen_Unterstuetzung.png")
            }
//            Button {
//                objectName: "btRequestsShoppingFood"
//                buttonText: qsTr("Food")
//                buttonNumber: "3"
//                shortcut: Qt.Key_3
//                buttonImage: ("../img/Button_Anfragen_Transport.png")
//            }
//            Button {
//                objectName: "btOrdersGas"
//                buttonText: qsTr("Gas control")
//                buttonNumber: "4"
//                shortcut: Qt.Key_4
//                buttonImage: ("../img/Button_Auftraege_Gas.png")
//            }
        }
    }
    MainRequestsShoppingHousehold {
        objectName: "MainRequestsShoppingHousehold"
    }
}
