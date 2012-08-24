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
    objectName: "MainNews"
    stateName: "News"

    Page {
        stateName: parent.stateName
        title: i18n("News")

        Component.onCompleted: {
            var count = simonTouch.availableRssGroupCount()
            console.debug("Available groups: "+count)
            if (count < 8)
                group8.opacity = 0
            if (count < 7)
                group7.opacity = 0
            if (count < 6)
                group6.opacity = 0
            if (count < 5)
                group5.opacity = 0
            if (count < 4)
                group4.opacity = 0
            if (count < 3)
                group3.opacity = 0
            if (count < 2)
                group2.opacity = 0
            if (count < 1)
                group1.opacity = 0
        }

        Rectangle {
            id: rectMenu
            width: screen.width/6
            height: 500
            anchors.verticalCenter: parent.verticalCenter
            color: "#FFFBC7"

            Image {
                id: menuImage
                source: ("../simontouch/img/Button_News.png")
                anchors{
                    top: rectMenu.top
                    bottomMargin: 0
                    horizontalCenter: parent.horizontalCenter
                }
                width: 100
                height: 100

                fillMode: Image.PreserveAspectFit
                smooth: true
            }

            Text {
                id: menuHeader
                text: i18n("Voice Commands")
                anchors{
                    bottom: lbtZahl.top
                    horizontalCenter: parent.horizontalCenter
                }
                x: 20
                font.family: "Arial"
                font.pointSize: 20
                font.bold: true
            }

            ListButton {
                id: lbtZahl
                width: screen.width/6
                anchors.left: parent.left
                anchors.top: parent.top
                shortcut: Qt.Key_Return
                anchors.topMargin: 150
                buttonText: i18n("A NUMBER")

            }

            ListButton{
                id: lbtZurueck
                width: screen.width/6
                anchors.left: parent.left
                anchors.top: lbtZahl.bottom
                buttonText: i18n("BACK")
                onButtonClick: back()

            }
        }


        Rectangle {
            id: rectFeed
            anchors.left: rectMenu.right
            anchors.verticalCenter: parent.verticalCenter
            height: 300
            width: parent.width - screen.width/6 + 50
            color: "#FFFBC7"
            PageGrid {
                id: pageGrid
                anchors.centerIn: rectFeed
                RSSGroupButton {
                    id: group1
                    index: 0
                    shortcut: Qt.Key_1
                }
                RSSGroupButton {
                    id: group2
                    index: 1
                    shortcut: Qt.Key_2
                }
                RSSGroupButton {
                    id: group3
                    index: 2
                    shortcut: Qt.Key_3
                }
                RSSGroupButton {
                    id: group4
                    index: 3
                    shortcut: Qt.Key_4
                }
                RSSGroupButton {
                    id: group5
                    index: 4
                    shortcut: Qt.Key_5
                }
                RSSGroupButton {
                    id: group6
                    index: 5
                    shortcut: Qt.Key_6
                }
                RSSGroupButton {
                    id: group7
                    index: 6
                    shortcut: Qt.Key_7
                }
                RSSGroupButton {
                    id: group8
                    index: 7
                    shortcut: Qt.Key_8
                }
            }
        }
    }
    MainNewsFeeds {
        id: mainNewsFeeds
        objectName: "MainNewsFeeds"
    }
}
