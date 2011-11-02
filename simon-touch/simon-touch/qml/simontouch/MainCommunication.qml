import QtQuick 1.1
import "parts"

TabPage {
    id: screen
    objectName: "MainCommunication"
    stateName: "Communication"

    /* Grid for the Mainbuttons */
    Page {
        stateName: parent.stateName
        title: qsTr("Communication")
        PageGrid {
            id: pageGrid
            MainButton {
                objectName: "btCommunicationPhone"
                buttonText: qsTr("Phone")
                buttonNumber: "1"
                buttonImage: ("../img/Button_Kommunikation_Telefon.png")
//                onButtonClick: showScreen("MainInformation")
            }
            MainButton {
                objectName: "btCommunicationEmail"
                buttonText: qsTr("E-Mail")
                buttonNumber: "2"
                buttonImage: ("../img/Button_Kommunikation_EMail.png")
//                onButtonClick: showScreen("MainCommunication")
            }
            MainButton {
                objectName: "btCommunicationSms"
                buttonText: qsTr("SMS")
                buttonNumber: "3"
                buttonImage: ("../img/Button_Kommunikation_Sms.png")
                onButtonClick: showScreen("MainOrders")
            }
    //        MainButton {
    //            objectName: "btRequests"
    //            buttonText: qsTr("Requests")
    //            buttonNumber: "4"
    //            buttonImage: ("../img/Button_Anfragen.png")
    //        }
        }
    }
}
