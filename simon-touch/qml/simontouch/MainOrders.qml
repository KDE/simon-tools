import QtQuick 1.1
import "parts"

TabPage {
    id: screen
    objectName: "MainOrders"
    stateName: "Orders"

    Page {
        stateName: parent.stateName
        title: qsTr("Orders")
        PageGrid {
            id: pageGrid
            Button {
                objectName: "btOrdersWater"
                buttonText: qsTr("Water control")
                buttonNumber: "1"
                buttonImage: ("../img/Button_Auftraege_Wasser.png")
            }
            Button {
                objectName: "btOrdersDoors"
                buttonText: qsTr("Doors control")
                buttonNumber: "2"
                buttonImage: ("../img/Button_Auftraege_Tueren.png")
            }
            Button {
                objectName: "btOrdersCooker"
                buttonText: qsTr("Cooker control")
                buttonNumber: "3"
                buttonImage: ("../img/Button_Auftraege_Herd.png")
            }
            Button {
                objectName: "btOrdersGas"
                buttonText: qsTr("Gas control")
                buttonNumber: "4"
                buttonImage: ("../img/Button_Auftraege_Gas.png")
            }
        }
    }
}
