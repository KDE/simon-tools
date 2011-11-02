import QtQuick 1.1

Item {

    id: page
    objectName: "MainScreen"
    property alias title: lbTitle.text
    property string stateName: "Undefined"
    anchors.fill: parent
    opacity:0

    signal showScreen(string msg)

    Text {
        id: lbTitle
        font.pointSize: 20
        font.bold: true
        anchors.horizontalCenter: parent.horizontalCenter
        y: 40
    }

    Behavior on opacity {
        NumberAnimation {properties: "opacity"; duration: 500}
    }


    Keys.onPressed: {
        if (event.key == Qt.Key_Escape && current != "MainScreen") {
            back()
            event.accepted = true
        }

        if (event.key == Qt.Key_1 && parent.visible == 1) {
            console.log('Key 1 was pressed')
            console.log('Länge: '+pageGrid.children.length)
            console.log(pageGrid.children[0].objectName)
            pageGrid.children[0].buttonClick()
            event.accepted = true
        }
        if (event.key == Qt.Key_2 && parent.visible == 1/* && pageGrid.children.length <= 2*/) {
            console.log('Key 2 was pressed')
            console.log(pageGrid.children[1].objectName)
            pageGrid.children[1].buttonClick()
            event.accepted = true
        }
        if (event.key == Qt.Key_3 && parent.visible == 1/* && pageGrid.children.length <= 3*/) {
            console.log('Key 3 was pressed')
            console.log(pageGrid.children[2].objectName)
            pageGrid.children[2].buttonClick()
            event.accepted = true
        }
        if (event.key == Qt.Key_4 && parent.visible == 1/* && pageGrid.children.length <= 4*/) {
            console.log('Key 4 was pressed')
            console.log(pageGrid.children[3].objectName)
            pageGrid.children[3].buttonClick()
            event.accepted = true
        }
        if (event.key == Qt.Key_P) {
            console.log('Key P was pressed')
            console.log('Currentz: '+current)
            if (current == "MainInformationMusic") {
                playMusic.play()
            }else if (current == "MainInformationVideos") {
                playVideos.play()
                videoFlip.flipped = true
            }

            event.accepted = true
        }

        if (event.key == Qt.Key_Q) Qt.quit()
    }
}
