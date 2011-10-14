import QtQuick 1.1
import "parts"

TabPage {
    id: mainInformation
    objectName: "MainInformation"

    /* Grid for the Mainbuttons */
    Page {
        title: qsTr("Information")
        Grid {
            rows: 2
            columns: 2
            anchors.centerIn: parent
            spacing: 20

            MainButton {
                objectName: "btInformationImages"
                buttonText: qsTr("Images")
                buttonNumber: "1"
                buttonImage: ("../img/Button_Information_Bilder.png")
                onButtonClick: setScreen("MainInformationImages")
            }
            MainButton {
                objectName: "btInformationMusic"
                buttonText: qsTr("Music")
                buttonNumber: "2"
                buttonImage: ("../img/Button_Information_Musik.png")
    //            onButtonClick: mainInformation.showScreen("MainInformationMusic")
            }
            MainButton {
                objectName: "btInformationVideo"
                buttonText: qsTr("Orders")
                buttonNumber: "3"
                buttonImage: ("../img/Button_Information_Video.png")
    //            onButtonClick: mainInformation.showScreen("MainInformationVideo")
            }
            MainButton {
                objectName: "btInformationNews"
                buttonText: qsTr("News")
                buttonNumber: "4"
                buttonImage: ("../img/Button_Information_Zeitung.png")
                onButtonClick: setScreen("MainInformationNews")
            }
        }
    }

    MainInformationImages {
        objectName: "MainInformationImages"
    }
    MainInformationNews {
        objectName: "MainInformationNews"
    }
}
