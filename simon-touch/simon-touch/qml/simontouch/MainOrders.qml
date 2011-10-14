import QtQuick 1.1
import "parts"

TabPage {
    id: screen
    objectName: "MainOrders"

    /* Grid for the Mainbuttons */
    Page {
        title: qsTr("Orders")
        Grid {
            rows: 2
            columns: 2
            anchors.centerIn: parent
            spacing: 20

            MainButton {
                objectName: "btOrdersWater"
                buttonText: qsTr("Water control")
                buttonNumber: "1"
                buttonImage: ("../img/Button_Auftraege_Wasser.png")
    //            onButtonClick: screen.showScreen("MainOrderWater")
            }
            MainButton {
                objectName: "btOrdersDoors"
                buttonText: qsTr("Doors control")
                buttonNumber: "2"
                buttonImage: ("../img/Button_Auftraege_Tueren.png")
    //            onButtonClick: screen.showScreen("MainOrdersDoors")
            }
            MainButton {
                objectName: "btOrdersCooker"
                buttonText: qsTr("Cooker control")
                buttonNumber: "3"
                buttonImage: ("../img/Button_Auftraege_Herd.png")
    //            onButtonClick: screen.showScreen("MainOrdersCooker")
            }
            MainButton {
                objectName: "btOrdersGas"
                buttonText: qsTr("Gas control")
                buttonNumber: "4"
                buttonImage: ("../img/Button_Auftraege_Gas.png")
    //            onButtonClick: screen.showScreen("MainOrdersGas")
            }
        }
    }
}
