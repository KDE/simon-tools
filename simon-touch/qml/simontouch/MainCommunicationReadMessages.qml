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

import QtQuick 1.1
import "parts"

TabPage {
    id: screen
    objectName: "MainCommunicationReadMessages"
    stateName: "CommunicationReadMessages"
    property string prettyName: ""

    onOpacityChanged: {
        if (opacity == 0)
            simonTouch.interruptReading()
    }

    Page {
        title: i18n("Read messages from ") + parent.prettyName
        stateName:parent.stateName
        id: readMessagePage

        SelectionListView {
            id: lvMessagesView
            objectName: "lvMessagesView"

            property int listViewItemHeight: 60

            anchors {
                left: parent.left
                top: parent.top
                bottom: parent.bottom
                margins: 160
                rightMargin: 0
            }
            width: screen.width - 320
            model: messagesModel
            delegate: MessagesListDelegate {}

            onCurrentItemChanged: {
                if (!currentItem) return;
                simonTouch.interruptReading()
                simonTouch.readAloud(currentItem.heading)
                if (currentItem.content != i18n("Please wait..."))
                    simonTouch.readAloud(currentItem.content)
            }
        }

        Button {
            id: lvImagesUp
            anchors.bottom: lvMessagesView.top
            anchors.left: lvMessagesView.left
            anchors.bottomMargin: 10
            width: lvMessagesView.width
            height: 50
            buttonImage: "../img/go-up.svgz"
            buttonText: i18n("Up")
            shortcut: Qt.Key_Up
            spokenText: true
            buttonLayout: Qt.Horizontal
            onButtonClick: if (lvMessagesView.currentIndex > 0) lvMessagesView.currentIndex -= 1
        }

        Button {
            id: lvImagesDown
            anchors.top: lvMessagesView.bottom
            anchors.left: lvMessagesView.left
            anchors.topMargin: 10
            width: lvMessagesView.width
            height: 50
            buttonImage: "../img/go-down.svgz"
            buttonText: i18n("Down")
            shortcut: Qt.Key_Down
            spokenText: true
            buttonLayout: Qt.Horizontal
            onButtonClick: if (lvMessagesView.currentIndex + 1 < lvMessagesView.count) lvMessagesView.currentIndex += 1
        }
    }
}
