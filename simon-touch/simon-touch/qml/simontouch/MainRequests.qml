import QtQuick 1.1
import "parts"

TabPage {
    id: screen
    objectName: "MainRequests"

    /* Grid for the Mainbuttons */
    Page {
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
    //            onButtonClick: screen.showScreen("MainRequestsShopping")
            }
            MainButton {
                objectName: "btRequestsTransport"
                buttonText: qsTr("Transport")
                buttonNumber: "2"
                buttonImage: ("../img/Button_Anfragen_Transport.png")
    //            onButtonClick: screen.showScreen("MainRequestsTranport")
            }
            MainButton {
                objectName: "btRequestsSupport"
                buttonText: qsTr("Support")
                buttonNumber: "3"
                buttonImage: ("../img/Button_Anfragen_Unterstuetzung.png")
    //            onButtonClick: screen.showScreen("MainRequestsSupport")
            }
    //        MainButton {
    //            objectName: "btOrdersGas"
    //            buttonText: qsTr("Gas control")
    //            buttonNumber: "4"
    //            buttonImage: ("../img/Button_Auftraege_Gas.png")
    ////            onButtonClick: screen.showScreen("MainOrdersGas")
    //        }
        }
    }
}
