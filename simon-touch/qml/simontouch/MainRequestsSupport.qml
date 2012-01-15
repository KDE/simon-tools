import QtQuick 1.1
import "parts"

TabPage {
    id: screen
    objectName: "MainRequestsSupport"
    stateName: "RequestsSupport"

    Page {
        stateName: parent.stateName
        title: qsTr("Support")
        PageGrid {
            id: pageGrid
            Button {
                objectName: "btRequestsSupportDoctor"
                buttonText: qsTr("Doctor")
                buttonNumber: "1"
                shortcut: Qt.Key_1
                buttonImage: ("../img/Button_Anfragen_Unterstuetzung.png")
            }
            Button {
                objectName: "btRequestsSupportAmbulance"
                buttonText: qsTr("Ambulance")
                buttonNumber: "2"
                shortcut: Qt.Key_2
                buttonImage: ("../img/Button_Anfragen_Unterstuetzung.png")
            }
            Button {
                objectName: "btRequestsSupportCarer"
                buttonText: qsTr("Carer")
                buttonNumber: "3"
                shortcut: Qt.Key_3
                buttonImage: ("../img/Button_Anfragen_Unterstuetzung.png")
            }
            Button {
                objectName: "btRequestsSupportPrivate"
                buttonText: qsTr("Known person")
                buttonNumber: "4"
                shortcut: Qt.Key_4
                buttonImage: ("../img/Button_Anfragen_Unterstuetzung.png")
            }
        }
    }
}
