import QtQuick 1.1
import "parts"

TabPage {
    id: screen
    objectName: "MainIncomingCall"
    stateName: "MainIncomingCall"
    focus: true
    property alias callInImage: callInImage.source
    property alias callInName: callItemView.callInName
    property alias callInNumber: callItemView.callInNumber

    onOpacityChanged: changeButtonVisibility(screen.opacity < 0.5)

    Page {
        stateName: parent.stateName
        title: ""
        ListModel {
            id: lvCallInModel
            ListElement {
                prettyName: "Stieger Franz"
                phoneNumber: "+43/664/4034321"
                email: "f.stieger@cyber-byte.at"
                skype: "stieger.franz"
                image: "img/franz.jpg"
                existingMessages: true
            }
        }
        Item {
            id: callItemView
            width: parent.width / 2
            height: parent.height / 2
            anchors.centerIn: parent
            property string callInName: "Mathias Stieger"
            property string callInNumber: "+43 664 3841266"
            Column {
                anchors.verticalCenter: parent.verticalCenter
                spacing: 10
                Row {
                    spacing: 10
                    height: 150

                    Image {
                        id: callInImage
                        height: parent.height
                        fillMode: Image.PreserveAspectFit
                    }

                    Column {

                        Text {
                            id: callInName
                            text: callItemView.callInName + " calls"
                            font.family: "Arial"
                            font.pointSize: 20
                        }
                        Text {
                            text: qsTr("Telephone: ") + callItemView.callInNumber
                            font.family: "Arial"
                            font.pointSize: 10
                        }
                    }
                }
                Row {
                    spacing: 10
                    Button {
                        id: acceptCall
                        buttonText: qsTr("Accept call")
                        height: 50
                        buttonImage: "../img/go-down.svgz"
                        spokenText: true
                        buttonLayout: Qt.Horizontal
                    }
                    Button {
                        id: declineCall
                        buttonText: qsTr("Decline call")
                        height: 50
                        buttonImage: "../img/go-down.svgz"
                        spokenText: true
                        buttonLayout: Qt.Horizontal
                    }
                }
            }
        }
    }
}
