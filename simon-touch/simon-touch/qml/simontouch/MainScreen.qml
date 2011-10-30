import QtQuick 1.1
import "parts"

TabPage {
    id: screen
    objectName: "MainScreen"
    stateName: "Main"

    /* Grid for the Mainbuttons */
    Page {
        stateName: parent.stateName
        title: Qt.formatDateTime(new Date(), "dddd, dd. MMMM yyyy")
        Grid {
            rows: 2
            columns: 2
            anchors.centerIn: parent
            spacing: 20

            MainButton {
                objectName: "btInformation"
                buttonText: qsTr("Information")
                buttonNumber: "1"
                buttonImage: ("../img/Button_Information.png")
                onButtonClick: showScreen("MainInformation")
            }
            MainButton {
                objectName: "btCommunication"
                buttonText: qsTr("Communication")
                buttonNumber: "2"
                buttonImage: ("../img/Button_Kommunikation.png")
                onButtonClick: showScreen("MainCommunication")
            }
            MainButton {
                objectName: "btOrders"
                buttonText: qsTr("Orders")
                buttonNumber: "3"
                buttonImage: ("../img/Button_Auftraege.png")
                onButtonClick: showScreen("MainOrders")
            }
            MainButton {
                objectName: "btRequests"
                buttonText: qsTr("Requests")
                buttonNumber: "4"
                buttonImage: ("../img/Button_Anfragen.png")
                onButtonClick: showScreen("MainRequests")
            }
        }
    }
}
