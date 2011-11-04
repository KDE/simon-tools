import QtQuick 1.1

MainButton {
    property int index: 0
    buttonText: simonTouch.rssFeedTitle(index)
    buttonNumber: index+1
    buttonImage: simonTouch.rssFeedIcon(index)

    onButtonClick: {
        mainInformationNews.setScreen("MainInformationNewsFeed")
        simonTouch.fetchRSSFeed(index)
    }
}
