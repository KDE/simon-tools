import QtQuick 1.1
import "parts"

TabPage {
    id: screen
    objectName: "MainRequests"
    stateName: "Requests"

    /* Grid for the Mainbuttons */
    Page {
        stateName: parent.stateName
        title: qsTr("Requests")
        Grid {
            rows: 2
            columns: 2
            anchors.centerIn: parent
            spacing: 20

            MainButton {
                objectName: "btRequestsShopping"
                buttonText: qsTr("Shopping")
                buttonNumber: "1"
                buttonImage: ("../img/Button_Anfragen_Bestellung.png")
            }
            MainButton {
                objectName: "btRequestsTransport"
                buttonText: qsTr("Transport")
                buttonNumber: "2"
                buttonImage: ("../img/Button_Anfragen_Transport.png")
            }
            MainButton {
                objectName: "btRequestsSupport"
                buttonText: qsTr("Support")
                buttonNumber: "3"
                buttonImage: ("../img/Button_Anfragen_Unterstuetzung.png")
            }
    //        MainButton {
    //            objectName: "btOrdersGas"
    //            buttonText: qsTr("Gas control")
    //            buttonNumber: "4"
    //            buttonImage: ("../img/Button_Auftraege_Gas.png")
    //        }
        }
    }
}
