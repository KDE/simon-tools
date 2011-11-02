import QtQuick 1.1
import "parts"

TabPage {
    id: screen
    objectName: "MainRequestsShopping"
    stateName: "RequestsShopping"

    /* Grid for the Mainbuttons */
    Page {
        stateName: parent.stateName
        title: qsTr("Shopping")
        PageGrid {
            id: pageGrid
            MainButton {
                objectName: "btRequestsShoppingDrinks"
                buttonText: qsTr("Drinks")
                buttonNumber: "1"
                buttonImage: ("../img/Button_Anfragen_Bestellung.png")
            }
            MainButton {
                objectName: "btRequestsShoppingFood"
                buttonText: qsTr("Food")
                buttonNumber: "2"
                buttonImage: ("../img/Button_Anfragen_Transport.png")
            }
            MainButton {
                objectName: "btRequestsShoppingMedic"
                buttonText: qsTr("Medic")
                buttonNumber: "3"
                buttonImage: ("../img/Button_Anfragen_Unterstuetzung.png")
            }
//            MainButton {
//                objectName: "btOrdersGas"
//                buttonText: qsTr("Gas control")
//                buttonNumber: "4"
//                buttonImage: ("../img/Button_Auftraege_Gas.png")
//            }
        }
    }
}
