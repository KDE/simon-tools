import QtQuick 1.1
import "parts"

TabPage {
    id: screen
    objectName: "MainRequestsTransport"
    stateName: "RequestsTransport"

    Page {
        stateName: parent.stateName
        title: qsTr("Transport")
        PageGrid {
            id: pageGrid
            Button {
                objectName: "btRequestsTransportTaxi"
                buttonText: qsTr("Taxi")
                buttonNumber: "1"
                shortcut: Qt.Key_1
                buttonImage: ("../img/Button_Anfragen_Transport.png")
            }
            Button {
                objectName: "btRequestsTransportAmbulance"
                buttonText: qsTr("Ambulance")
                buttonNumber: "2"
                shortcut: Qt.Key_2
                buttonImage: ("../img/Button_Anfragen_Transport.png")
            }
            Button {
                objectName: "btRequestsTransportPrivate"
                buttonText: qsTr("Private tranport")
                buttonNumber: "3"
                shortcut: Qt.Key_3
                buttonImage: ("../img/Button_Anfragen_Transport.png")
            }
//            Button {
//                objectName: "btRequestsSupportPrivate"
//                buttonText: qsTr("Known person")
//                buttonNumber: "4"
//                buttonImage: ("../img/Button_Anfragen_Unterstuetzung.png")
//            }
        }
    }
}
