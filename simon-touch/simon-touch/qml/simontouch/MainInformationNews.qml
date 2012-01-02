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

                snapMode: ListView.SnapToItem
                delegate: RSSArticle {
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
//            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: rssFlip.bottom
            anchors.left: rssFlip.left
            anchors.leftMargin: 100
            anchors.bottomMargin: 115
            width: 200
            height: 50
            buttonImage: "../img/go-previous.svgz"
            buttonText: qsTr("Left")
            shortcut: Qt.Key_Left
            spokenText: true
            buttonLayout: Qt.Horizontal
            onButtonClick: if (lvFeed.currentIndex > 0) lvFeed.currentIndex -= 1
        }

        Button {
            id: lvRssNext
//            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: rssFlip.bottom
            anchors.right: rssFlip.right
            anchors.leftMargin: 100
            anchors.bottomMargin: 115
            anchors.rightMargin: 100
            horizontalIconAlign: "right"
            width: 200
            height: 50
            buttonImage: "../img/go-next.svgz"
            buttonText: qsTr("Right")
            shortcut: Qt.Key_Right
            spokenText: true
            buttonLayout: Qt.Horizontal
            onButtonClick: if (lvFeed.currentIndex < lvFeed.count) lvFeed.currentIndex += 1
        }

    }
}
