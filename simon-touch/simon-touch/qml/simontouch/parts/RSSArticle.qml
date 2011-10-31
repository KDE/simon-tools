import QtQuick 1.1
import QtWebKit 1.1

Item {
    property string heading: ""
    property string article: ""

    Text {
        id: headingText
        text: heading

        font.family: "Arial"
        font.pointSize: 16
        anchors.top: parent.top
        anchors.margins: 6
        anchors.horizontalCenter: parent.horizontalCenter
    }
    FlickableWebView {
        smooth: true
        anchors {
            left: parent.left
            right: parent.right
            top: headingText.bottom
            topMargin: 20
            bottom: parent.bottom
        }

        html: article
    }

}
