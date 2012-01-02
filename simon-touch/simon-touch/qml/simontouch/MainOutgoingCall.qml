import QtQuick 1.1
import "parts"

TabPage {
    id: screen
    objectName: "MainIncomingCall"
    stateName: "MainIncomingCall"
    focus: true
    property alias callOutImage: callOutImage.source
    property alias callOutName: callItemView.callOutName
    property alias callOutNumber: callItemView.callOutNumber

    onOpacityChanged: changeButtonVisibility(screen.opacity < 0.5)

    Page {
        stateName: parent.stateName
        title: ""
        Item {
            id: callItemView
            width: parent.width / 2
            height: parent.height / 2
            anchors.centerIn: parent
            property string callOutName: "Mathias Stieger"
            property string callOutNumber: "+43 664 3841266"
            Column {
                anchors.verticalCenter: parent.verticalCenter
                spacing: 10
                Row {
                    spacing: 10
                    height: 150
                    width: 500
                    Image {
                        id: callOutImage
                        height: parent.height
                        fillMode: Image.PreserveAspectFit
                    }
                    Column {
                        Text {
                            id: callOutName
                            text: "Calling " + callItemView.callOutName
                            font.family: "Arial"
                            font.pointSize: 20
                        }
                        Text {
                            text: qsTr("Telephone: ") + callItemView.callOutNumber
                            font.family: "Arial"
                            font.pointSize: 10
                        }
                    }
                }
                Row {
                    spacing: 10
                    width: 500
                    Button {
                        id: cancelCall
                        buttonText: qsTr("Cancel call")
                        height: 50
                        buttonImage: "../img/go-down.svgz"
                        spokenText: true
                        buttonLayout: Qt.Horizontal
                        width: callItemView.width
                        onButtonClick: ;
                    }
                }
            }
        }
    }
}
