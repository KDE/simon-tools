import QtQuick 1.1

AnimatedItem {
    property alias mode : itSpeakControl.state
    Item {
        id: itSpeakControl
        anchors.centerIn: parent
        state: "pushToTalk"
        width: Math.max(btSpeak.width, lbSpeak.width)
        height: Math.max(btSpeak.height, lbSpeak.height)

        onStateChanged: console.debug("State has changed: " + state)
        states: [
            State {
                name: "pushToTalk"
                PropertyChanges {
                    target: btSpeak
                    visible: true
                }
                PropertyChanges {
                    target: lbSpeak
                    visible: false
                }
            },
            State {
                name: "vad"
                PropertyChanges {
                    target: btSpeak
                    visible: false
                }
                PropertyChanges {
                    target: lbSpeak
                    visible: true
                }
            }
        ]
        Button {
            id: btSpeak
            objectName: "btSpeak"
            anchors.centerIn: parent
            text: isPressed ? qsTr("Please speak") : qsTr("Push to talk")
            width: 500
            height: 150
            font.pointSize: 18

            onPressed: simoneView.startRecordingRequested();
            onReleased: simoneView.commitRecordingRequested();

        }
        Text {
            id: lbSpeak
            objectName: "lbSpeak"
            anchors.centerIn: parent
            text: qsTr("Please speak...")
            font.pointSize: 18
        }
    }

    ProgressBar {
        id: pbVUMeter
        objectName: "pbVUMeter"
        width: 500
        height: 80
        anchors.top: itSpeakControl.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 20
    }

    Text {
        id: recognitionResultBanner
        objectName: "recognitionResultBanner"
        anchors.centerIn: pbVUMeter
        font.pointSize: 16
        Timer {
            id: resultTimer
            interval: 2500
            repeat: false
            onTriggered: recognitionResultBanner.text = ""
        }

        function recognized(result) {
            text = result
            resultTimer.restart()
        }
    }
}
