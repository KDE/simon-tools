import QtQuick 1.1

Rectangle {
    id: btKeyCalcButton
    property string btKeyCalcButtonText: "Test"
    property string btKeyCalcButtonImage: "../img/rss.png"
    width: 242
    height: 90
    clip: true
    color: "#FFFBC7"

    SideButton {
        x: 0
        y: 1
        width: 240
        height: 100
        buttonText: btKeyCalcButtonText
        buttonImage: btKeyCalcButtonImage
    }
}
