import QtQuick 1.1
import "parts"

TabPage {
    id: screen
    objectName: "MainCommunication"

    /* Grid for the Mainbuttons */
    Page {
        title: qsTr("Communication")
        Grid {
            rows: 2
            columns: 2
            anchors.centerIn: parent
            spacing: 20

            MainButton {
                objectName: "btCommunicationPhone"
                buttonText: qsTr("Information")
                buttonNumber: "1"
                buttonImage: ("../img/Button_Kommunikation_Telefon.png")
                onButtonClick: screen.showScreen("MainInformation")
            }
            MainButton {
                objectName: "btCommunicationEmail"
                buttonText: qsTr("Communication")
                buttonNumber: "2"
                buttonImage: ("../img/Button_Kommunikation_Email.png")
                onButtonClick: screen.showScreen("MainCommunication")
            }
            MainButton {
                objectName: "btCommunicationSms"
                buttonText: qsTr("Orders")
                buttonNumber: "3"
                buttonImage: ("../img/Button_Kommunikation_Sms.png")
                onButtonClick: screen.showScreen("MainOrders")
            }
    //        MainButton {
    //            objectName: "btRequests"
    //            buttonText: qsTr("Requests")
    //            buttonNumber: "4"
    //            buttonImage: ("../img/Button_Anfragen.png")
    //            onButtonClick: screen.showScreen("MainRequests")
    //        }
        }
    }
}
