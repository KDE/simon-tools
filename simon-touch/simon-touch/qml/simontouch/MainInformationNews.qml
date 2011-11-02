import QtQuick 1.1
import "parts"

TabPage {
    id: mainInformationNews
    objectName: "MainInformationNews"
    stateName: "News"

    Page {
        stateName: parent.stateName
        title: qsTr("News")

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
            }
            RSSButton {
                id: feed2
                index: 1
            }
            RSSButton {
                id: feed3
                index: 2
            }
            RSSButton {
                id: feed4
                index: 3
            }
        }
    }
    Page {
        id: feedPage
        title: qsTr("News")
        objectName: "MainInformationNewsFeed"
        anchors.fill: parent

        onOpacityChanged: {
            if (opacity == 0) {
                rssFlip.flipped = false
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
            front: BusyIndicator {
                id: busyIndicator
                visible: true
                anchors.centerIn: parent
            }
            back: SelectionListView {
                id: lvFeed
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

                snapMode: ListView.SnapToItem
                delegate: RSSArticle {
                    height: lvFeed.height
                    width: feedPage.width - 300
                    heading: header
                    article: content
                    MouseArea {
                        anchors.fill: parent
                        onClicked: lvFeed.currentIndex = index
                    }
                }
            }
        }
    }
}
