import QtQuick 1.1
import "parts"

TabPage {
    id: screen
    objectName: "MainOrders"
    stateName: "Orders"

    /* Grid for the Mainbuttons */
    Page {
        stateName: parent.stateName
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
            }
            MainButton {
                objectName: "btOrdersDoors"
                buttonText: qsTr("Doors control")
                buttonNumber: "2"
                buttonImage: ("../img/Button_Auftraege_Tueren.png")
            }
            MainButton {
                objectName: "btOrdersCooker"
                buttonText: qsTr("Cooker control")
                buttonNumber: "3"
                buttonImage: ("../img/Button_Auftraege_Herd.png")
            }
            MainButton {
                objectName: "btOrdersGas"
                buttonText: qsTr("Gas control")
                buttonNumber: "4"
                buttonImage: ("../img/Button_Auftraege_Gas.png")
            }
        }
    }
}
