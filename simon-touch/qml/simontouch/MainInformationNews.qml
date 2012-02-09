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
    id: mainInformationNews
    objectName: "MainInformationNews"
    stateName: "News"

    Page {
        stateName: parent.stateName
        title: i18n("News")

        Component.onCompleted: {
            var count = simonTouch.availableRssFeedsCount();
            console.debug("Available feeds: "+count)
            if (count < 4)
                feed4.opacity = 0
            if (count < 3)
                feed3.opacity = 0
            if (count < 2)
                feed2.opacity = 0
            if (count < 1)
                feed1.opacity = 0
        }

        PageGrid {
            id: pageGrid
            RSSButton {
                id: feed1
                index: 0
                shortcut: Qt.Key_1
            }
            RSSButton {
                id: feed2
                index: 1
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
        }
    }
    Page {
        id: feedPage
        title: i18n("News")
        objectName: "MainInformationNewsFeed"
        anchors.fill: parent

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
        }

        AutoFlippable {
            id: rssFlip
            anchors.fill: parent
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
                anchors.margins: 100
                anchors.fill: parent
                spacing: 20
                model: rssFeed
                flickableDirection: Flickable.HorizontalFlick
                onModelChanged: {
                    currentIndex = 0
                }

                onCurrentIndexChanged: {
                    if (currentItem) {
                        simonTouch.interruptReading()
                        simonTouch.readAloud(currentItem.article)
                    }
                }
                snapMode: ListView.SnapToItem
                delegate: RSSArticle {
                    id: rssArticle
                    height: lvFeed.height - 75
                    width: feedPage.width - 200
                    heading: header
                    article: "<link rel=\"stylesheet\" type=\"text/css\" href=\"/home/simon/simon-touch/simon-touch/qml/simontouch/parts/style.css\"><div class=\"article\">" + content +"</div>"
                    MouseArea {
                        anchors.fill: parent
                        onClicked: lvFeed.currentIndex = index
                    }
                }
            }
        }

        Button {
            id: lvRssPrevious
            anchors.bottom: rssFlip.bottom
            anchors.left: rssFlip.left
            anchors.leftMargin: 100
            anchors.bottomMargin: 115
            width: 200
            height: 50
            buttonImage: "../img/go-previous.svgz"
            buttonText: i18n("Left")
            shortcut: Qt.Key_Left
            spokenText: true
            buttonLayout: Qt.Horizontal
            onButtonClick: if (lvFeed.currentIndex > 0) lvFeed.currentIndex -= 1
        }

        Button {
            id: lvRssNext
            anchors.bottom: rssFlip.bottom
            anchors.right: rssFlip.right
            anchors.leftMargin: 100
            anchors.bottomMargin: 115
            anchors.rightMargin: 100
            horizontalIconAlign: "right"
            width: 200
            height: 50
            buttonImage: "../img/go-next.svgz"
            buttonText: i18n("Right")
            shortcut: Qt.Key_Right
            spokenText: true
            buttonLayout: Qt.Horizontal
            onButtonClick: if (lvFeed.currentIndex < lvFeed.count) lvFeed.currentIndex += 1
        }

    }
}
