import QtQuick 1.1
import "parts"

TabPage {
    id: mainInformationNews
    objectName: "MainInformationNews"

    /* Grid for the Mainbuttons */
    Page {
        title: qsTr("News")
        Grid {
            rows: 2
            columns: 2
            anchors.centerIn: parent
            spacing: 20

            MainButton {
                objectName: "btInformationNewsRss1"
                buttonText: qsTr("RSS 1")
                buttonNumber: "1"
                buttonImage: ("../img/Button_Kommunikation_Telefon.png")
    //            onButtonClick: mainInformationNews.showScreen("MainInformation")
            }
            MainButton {
                objectName: "btInformationNewsRss2"
                buttonText: qsTr("RSS 2")
                buttonNumber: "2"
                buttonImage: ("../img/Button_Kommunikation_Email.png")
    //            onButtonClick: mainInformationNews.showScreen("MainCommunication")
            }
            MainButton {
                objectName: "btInformationNewsNews1"
                buttonText: qsTr("News 1")
                buttonNumber: "3"
                buttonImage: ("../img/Button_Kommunikation_Sms.png")
    //            onButtonClick: mainInformationNews.showScreen("MainOrders")
            }
            MainButton {
                objectName: "btInformationNewsNews2"
                buttonText: qsTr("News 2")
                buttonNumber: "4"
                buttonImage: ("../img/Button_Anfragen.png")
    //            onButtonClick: mainInformationNews.showScreen("MainRequests")
            }
        }
    }
}
