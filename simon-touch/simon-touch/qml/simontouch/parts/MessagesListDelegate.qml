import Qt 4.7

// Delegate for the detail list
Component {

    Item {
        id: delegateItem
        width: parent.width
        height: 30

        property int fontHeight: 30
//        property int itemMargin: 10

        Image {
            id: messageIcon
            source: msgIcon
            width: 20
            anchors.top: parent.top
            fillMode: Image.PreserveAspectFit
        }
        Text {
            id: messageSubject
            text: subject
            font.family: "Arial"
            font.pointSize: 14
            anchors.top: parent.top
            anchors.left: messageIcon.right
            anchors.leftMargin: 20
            anchors.verticalCenter: messageIcon.verticalCenter
        }
        Text {
            text: datetime
            font.family: "Arial"
            font.pointSize: 10
            anchors.right: parent.right
            anchors.top: parent.top
        }
        Text {
            id: messageText
            text: message
            font.family: "Arial"
            font.pointSize: 10
            anchors.left: messageSubject.left
            anchors.top: messageIcon.bottom
            anchors.topMargin: 10
            opacity: 0
            width: parent.width - 50
            wrapMode: Text.Wrap
        }

        MouseArea {
           id: listViewMouseArea
           anchors.fill: parent

           onClicked: {
               lvMessagesView.currentIndex = index
           }
        }
        onStateChanged: {
            if (state == "current")
                simonTouch.readMessage(lvMessagesView.currentIndex)
        }

        states: [
            // When item is current, make the item higher and show photo+number
            State {
                name: "current"
                when: lvMessagesView.currentIndex == index
                PropertyChanges {
                    target: messageText
                    opacity: 1
                }
                PropertyChanges {
                    target: delegateItem
                    height: messageText.height + 40
                }
//                PropertyChanges {
//                    target: imagePhoto
//                    x: itemMargin
//                }
//                AnchorChanges {
//                    // Don't center the name vertically when in expanded state
//                    target: textName
//                    anchors.verticalCenter: undefined
//                }
            }
        ]

        // When moving to "current" state, first enlarge the item and scroll everything into
        // place, only after this make the phone number visible. When leaving the state do the
        // same effects but backwards.
        transitions: [
            Transition {
                to: "current"
                SequentialAnimation {
                    PropertyAnimation { properties: "height,x"; duration: 200; easing.type: Easing.InOutCubic }
                    PropertyAnimation { properties: "opacity"; duration: 200; easing.type: Easing.InOutCubic }
                }
            },
            Transition {
                from: "current"
                SequentialAnimation {
                    PropertyAnimation { properties: "opacity"; duration: 200; easing.type: Easing.InOutCubic }
                    PropertyAnimation { properties: "height,x"; duration: 200; easing.type: Easing.InOutCubic }
                }
            }
        ]
    }
}
