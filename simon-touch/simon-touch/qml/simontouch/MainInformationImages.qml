import QtQuick 1.1
import "parts"

TabPage {
    objectName: "MainInformationImages"
    stateName: "Images"
    anchors.fill: parent
    /*onOpacityChanged: {
        lvImages.focus = (opacity == 1)
    }*/

    Page {
        stateName: parent.stateName
        title: qsTr("Images")
        anchors.fill: parent
        id: imageWindow

        Item {
            id: leftColumn
            width: 250
            height: 100
            anchors {
                left: parent.left
                top: parent.top
                bottom: parent.bottom
                topMargin: 120
                leftMargin: 50
                bottomMargin: 120
            }


            SelectionListView {
                id: lvImages
                objectName: "lvImages"

                anchors {
                    bottomMargin: 60
                    topMargin: 60
                }

                model: imagesModel

                delegate:
                    Image {
                        id: delegate;
                        width: parent.width
                        height: 130
                        source: filePathRole
                        fillMode: Image.PreserveAspectFit
                        smooth: false
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                lvImages.currentIndex = index
                            }
                        }
                    }

                onCurrentItemChanged: imImage.source = currentItem.source

            }

            Button {
                id: lvImagesUp
                anchors.top: leftColumn.top
                anchors.left: leftColumn.left
                width: parent.width
                height: 50
                buttonImage: "../img/go-up.svgz"
                buttonText: qsTr("Up")
                shortcut: Qt.Key_Up
                spokenText: true
                buttonLayout: Qt.Horizontal
                onButtonClick: if (lvImages.currentIndex > 0) lvImages.currentIndex -= 1
            }

            Button {
                id: lvImagesDown
                anchors.bottom: leftColumn.bottom
                anchors.left: leftColumn.left
                height: 50
                buttonImage: "../img/go-down.svgz"
                buttonText: qsTr("Down")
                shortcut: Qt.Key_Down
                spokenText: true
                buttonLayout: Qt.Horizontal
                onButtonClick: if (lvImages.currentIndex + 1 < lvImages.count) lvImages.currentIndex += 1
            }
            Button {
                id: slideshowButton
                width: 200
                anchors.left: parent.left
                anchors.top: parent.bottom
                shortcut: Qt.Key_S
                anchors.topMargin: 10
                height: 50
                color: Qt.darker("#FFFBC7", 1.1)
                buttonText: (state == "slideshowDisabled") ? qsTr("Start slideshow") : qsTr("Stop slideshow")
//                disableImage: true
                spokenText: true
                buttonLayout: Qt.Horizontal
                state: "slideshowDisabled"
                states: [
                    State {
                        name: "slideshowDisabled"
                        PropertyChanges {
                            target: slideshowButton
                            color: "#FFFBC7"
                        }
                    },
                    State {
                        name: "slideshowEnabled"
                        PropertyChanges {
                            target: slideshowButton
                            color: "#FEF57B"
                        }
                    }
                ]

                Timer {
                    id: slideshowTimer
                    interval: 3000
                    running: false
                    repeat: true
                    onTriggered: (lvImages.currentIndex + 1 < lvImages.count) ? lvImages.currentIndex += 1 : lvImages.currentIndex = 0
                }

                onButtonClick: imageWindow.toggleSlideshow()
            }
        }

        function toggleSlideshow() {
            if (slideshowButton.state == "slideshowDisabled") {
                slideshowTimer.start();
                imageWrapper.state = "fullscreen"
                slideshowButton.state = "slideshowEnabled";
            } else {
                slideshowTimer.stop();
                imageWrapper.state = "windowed"
                slideshowButton.state = "slideshowDisabled";
            }
        }

        Rectangle {
            id: imageWrapper
            color: "#FFFBC7"
            state: "windowed"

            Image {
                id: imImage
                anchors.fill: parent
                fillMode: Image.PreserveAspectFit
                smooth: true
                MouseArea {
                    anchors.fill: parent
                    onClicked: imageWindow.toggleSlideshow()
                }
            }

            states: [
                State {
                    name: "windowed"
                    PropertyChanges {
                        target: imageWrapper
                        x: leftColumn.x + leftColumn.width + 20
                        y: leftColumn.y
                        width: parent.width - leftColumn.width - leftColumn.x - 70
                        height: leftColumn.height
                    }
                },
                State {
                    name: "fullscreen"
                    PropertyChanges {
                        target: imageWrapper
                        x: - parent.x
                        y: - parent.y
                        width: main.width
                        height: main.height
                    }
                }
            ]

            transitions: Transition {
                NumberAnimation { properties: "width,height,x,y"; easing.type: Easing.InOutQuad }
            }

        }
    }
}
