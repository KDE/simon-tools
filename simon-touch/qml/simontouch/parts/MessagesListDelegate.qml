/*
 *   Copyright (C) 2011-2012 Mathias Stieger <m.stieger@simon-listens.org>
 *   Copyright (C) 2011-2012 Peter Grasch <grasch@simon-listens.org>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License version 2,
 *   or (at your option) any later version, as published by the Free
 *   Software Foundation
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details
 *
 *   You should have received a copy of the GNU General Public
 *   License along with this program; if not, write to the
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

import Qt 4.7

// Delegate for the detail list
Item {
    property alias content: messageText.text
    id: delegateItem
    width: parent.width
    height: 30

    property int fontHeight: 30

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
        text: delegateItem.state == "current" ? message : qsTr("Please wait...")
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
