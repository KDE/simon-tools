import QtQuick 1.1
import "parts"

TabPage {
    id: screen
    objectName: "MainCommunication"
    stateName: "Communication"

    Page {
        stateName: parent.stateName
        title: qsTr("Communication")
        PageGrid {
            id: pageGrid
            Button{
                objectName: "btCommunicationPhone"
                buttonText: qsTr("Phone")
                buttonNumber: "1"
                buttonImage: ("../img/Button_Kommunikation_Telefon.png")
//                onButtonClick: showScreen("MainInformation")
            }
            Button{
                objectName: "btCommunicationEmail"
                buttonText: qsTr("E-Mail")
                buttonNumber: "2"
                buttonImage: ("../img/Button_Kommunikation_EMail.png")
//                onButtonClick: showScreen("MainCommunication")
            }
            Button {
                objectName: "btCommunicationSms"
                buttonText: qsTr("SMS")
                buttonNumber: "3"
                buttonImage: ("../img/Button_Kommunikation_Sms.png")
                onButtonClick: showScreen("MainOrders")
            }
    //        Button {
    //            objectName: "btRequests"
    //            buttonText: qsTr("Requests")
    //            buttonNumber: "4"
    //            buttonImage: ("../img/Button_Anfragen.png")
    //        }
        }
    }
}
