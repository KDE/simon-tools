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
    id: mainNewsFeeds
    objectName: "MainNewsFeeds"
    stateName: "MainNewsFeeds"
    property int group: 9
    property variant feeds: new Array

    onGroupChanged:    {
        feed1.opacity = 1
        feed2.opacity = 2
        feed3.opacity = 3
        feed4.opacity = 4
        feed5.opacity = 5
        feed6.opacity = 6
        feed7.opacity = 7
        feed8.opacity = 8
        feeds = simonTouch.getFeedsFromGroup(group)
        var currentGroup = simonTouch.getCurrentGroup()
        console.debug("Current Group: "+currentGroup)
        var count = simonTouch.availableRssFeedsInGroup(group)
        console.debug("Available feeds: "+count)
        console.debug("Feeds[*] array: " + feeds[0])
        if (count < 8){
            feed8.opacity = 0
        }
        if (count < 7){
            feed7.opacity = 0
        }
        if (count < 6){
            feed6.opacity = 0
        }
        if (count < 5){
            feed5.opacity = 0
        }
        if (count < 4){
            feed4.opacity = 0
        }
        if (count < 3){
            feed3.opacity = 0
        }
        if (count < 2){
            feed2.opacity = 0
        }
        if (count < 1){
            feed1.opacity = 0
        }

        if (count > 0){
            feed1.index = feeds[0]
            feed1.buttonNumber = 1
        }
        if (count > 1){
            feed2.index = feeds[1]
            feed2.buttonNumber = 2
        }
        if (count > 2){
            feed3.index = feeds[2]
            feed3.buttonNumber = 3
        }
        if (count > 3){
            feed4.index = feeds[3]
            feed4.buttonNumber = 4
        }
        if (count > 4){
            feed5.index = feeds[4]
            feed5.buttonNumber = 5
        }
        if (count > 5){
            feed6.index = feeds[5]
            feed6.buttonNumber = 6
        }
        if (count > 6){
            feed7.index = feeds[6]
            feed7.buttonNumber = 7
        }
        if (count > 7){
            feed8.index = feeds[7]
            feed8.buttonNumber = 8
        }
    }

    Page {
        stateName: parent.stateName
        title: simonTouch.rssGroupTitle(group)


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
                RSSButton {
                    id: feed1
                    shortcut: Qt.Key_1
                }
                RSSButton {
                    id: feed2
                    shortcut: Qt.Key_2
                }
                RSSButton {
                    id: feed3
                    index: 2
                    shortcut: Qt.Key_3
                }
                RSSButton {
                    id: feed4
                    index: 3
                    shortcut: Qt.Key_4
                }
                RSSButton {
                    id: feed5
                    shortcut: Qt.Key_5
                }
                RSSButton {
                    id: feed6
                    shortcut: Qt.Key_6
                }
                RSSButton {
                    id: feed7
                    shortcut: Qt.Key_7
                }
                RSSButton {
                    id: feed8
                    shortcut: Qt.Key_8
                }
            }
        }
    }
    Page {
        id: feedPage
        title: simonTouch.rssGroupTitle(group)
        objectName: "MainNewsFeed"
        anchors.fill: parent
        stateName: "MainNewsFeed"

        onOpacityChanged: {
            if (opacity == 0) {
                rssFlip.flipped = false
                simonTouch.interruptReading()
            }

            lvFeed.focus = (opacity == 1)
        }

        function feedFetchError()
        {
            back()
        }

        function displayFeed()
        {
            rssFlip.flipped = true
            lvFeed.currentIndex = 0
        }

        AutoFlippable {
            id: rssFlip
            anchors {
                left: rectMenuFlip.right
                right: parent.right
                top: parent.top
                bottom: parent.bottom
                bottomMargin: 80
                topMargin: 80
            }
            onFlippedChanged: {
                if (!flipped)
                    simonTouch.interruptReading();
            }

            front: BusyIndicator {
                id: busyIndicator
                visible: true
                anchors.centerIn: parent
            }
            back: SelectionListView {
                id: lvFeed
                contentItem.anchors.margins: 0
                orientation: ListView.Horizontal
                clip:true
                anchors.margins: 40
                anchors.fill: parent
                spacing: 20
                model: rssFeed
                flickableDirection: Flickable.HorizontalFlick
                onModelChanged: {
                    currentIndex = 1
                }

                onCurrentIndexChanged: {
                    if (currentItem) {
                        simonTouch.interruptReading()
                        simonTouch.readAloud(currentItem.heading)
                        simonTouch.readAloud(currentItem.article)
                    }
                }
                snapMode: ListView.SnapToItem
                delegate: RSSArticle {
                    id: rssArticle
                    height: lvFeed.height - 75
                    width: feedPage.width - 280
                    heading: header
                    article: "<link rel=\"stylesheet\" type=\"text/css\" href=\"/home/simon/simon-touch/simon-touch/qml/simontouch/parts/style.css\"><div class=\"article\">" + content +"</div>"
                    MouseArea {
                        anchors.fill: parent
                        onClicked: lvFeed.currentIndex = index
                    }
                }
            }
        }

        Rectangle {
            id: rectMenuFlip
            width: screen.width/6
            height: 500
            anchors.verticalCenter: parent.verticalCenter
            color: "#FFFBC7"

            Image {
                id: menuImageFlip
                source: ("../simontouch/img/Button_News.png")
                anchors{
                    top: rectMenuFlip.top
                    bottomMargin: 0
                    horizontalCenter: parent.horizontalCenter
                }
                width: 100
                height: 100

                fillMode: Image.PreserveAspectFit
                smooth: true
            }

            Text {
                id: menuHeaderFlip
                text: i18n("Voice Commands")
                anchors{
                    bottom: lbtLinksFlip.top
                    horizontalCenter: parent.horizontalCenter
                }
                x: 20
                font.family: "Arial"
                font.pointSize: 20
                font.bold: true
            }

            ListButton {
                id: lbtLinksFlip
                width: screen.width/6
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.topMargin: 150
                buttonText: i18n("LEFT")
                onButtonClick: if (lvFeed.currentIndex > 0) lvFeed.currentIndex -= 1
                shortcut: Qt.Key_Left
            }

            ListButton{
                id: lbtRechtsFlip
                width: screen.width/6
                anchors.left: parent.left
                anchors.top: lbtLinksFlip.bottom
                buttonText: i18n("RIGHT")
                onButtonClick: if (lvFeed.currentIndex < lvFeed.count) lvFeed.currentIndex += 1
                shortcut: Qt.Key_Right

            }


            ListButton{
                id: lbtZurueckFlip
                width: screen.width/6
                anchors.left: parent.left
                anchors.top: lbtRechtsFlip.bottom
                buttonText: i18n("BACK")
                onButtonClick: back()

            }
        }
    }
}
