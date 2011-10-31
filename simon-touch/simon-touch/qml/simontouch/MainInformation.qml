import QtQuick 1.1
import "parts"

TabPage {
    id: mainInformation
    objectName: "MainInformation"
    stateName: "Information"

    /* Grid for the Mainbuttons */
    Page {
        stateName: parent.stateName
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
                onButtonClick: setScreen("MainInformationMusic")
            }
            MainButton {
                objectName: "btInformationVideo"
                buttonText: qsTr("Videos")
                buttonNumber: "3"
                buttonImage: ("../img/Button_Information_Video.png")
                onButtonClick: setScreen("MainInformationVideos")
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
    MainInformationMusic {
        objectName: "MainInformationMusic"
    }
    MainInformationVideos {
        objectName: "MainInformationVideos"
    }
    MainInformationNews {
        objectName: "MainInformationNews"
    }
}
