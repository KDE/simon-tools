import QtQuick 1.1
import QtMultimediaKit 1.1
import "parts"

TabPage {
    objectName: "MainInformationVideos"
    stateName: "Videos"

    onOpacityChanged: {
        playVideos.stop()
        lvVideos.focus = (opacity == 1)
    }

    Page {
        stateName: parent.stateName
        title: qsTr("Videos")


        AutoFlippable {
            id: videoFlip
            z: 100

            anchors {
                left: parent.left
                right: parent.right
                top: parent.top
                bottom: parent.bottom
                margins: 100
                bottomMargin: 200
            }
            front:
                SelectionListView {
                    id: lvVideos
                    objectName: "lvVideos"
                    anchors.fill: parent

                    model: videosModel

                    delegate: Item {
                            height: 50
                            width: parent.width
                            property string fullPath: filePathRole
                            Text {
                                id: delegate;
                                width: parent.width
                                text: niceFileName
                                anchors.verticalCenter: parent.verticalCenter

                                font.family: "Arial"
                                font.pointSize: 16

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        lvVideos.currentIndex = index
                                    }
                                }
                            }
                    }
                    onCurrentItemChanged: {
                        playVideos.source = currentItem.fullPath
                    }
                }
            back:
                Rectangle {
                    id: videoWrapper

                    state: "windowed"
                    x: 0
                    y: 0

                    color: "black"

                    states: [
                        State {
                            name: "windowed"
                            PropertyChanges {
                                target: videoWrapper
                                width: parent.width
                                height: parent.height
                            }
                        },
                        State {
                            name: "fullscreen"
                            PropertyChanges {
                                target: videoWrapper
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

                    Video {
                        id: playVideos

                        anchors.fill: parent

                        onPositionChanged: {
                            function msToStr(time) {
                                var seconds = Math.floor(time / 1000)
                                var minutes = Math.floor(seconds / 60)
                                seconds = seconds - minutes*60

                                return minutes + ":" + seconds
                            }
                            lbStatus.text = msToStr(playVideos.position)+ " / " + msToStr(playVideos.duration)
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: videoWrapper.state = "windowed"
                        }
                    }

            }
        }


        MainButton {
            id: pbPlay
            anchors.left: videoFlip.left
            anchors.top: videoFlip.bottom
            anchors.topMargin: 10
            objectName: "btPlay"
            buttonText: qsTr("Play")
            buttonNumber: ""
            buttonImage: ("../img/play.png")
            height: 90
            width: 90
            onButtonClick: {
                playVideos.play()
                videoFlip.flipped = true
            }

        }


        Text {
            id: lbStatus
            anchors.verticalCenter: pbPlay.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            text: "00:00 / 00:00"
            font.family: "Arial"
            font.pointSize: 16
        }

        MainButton {
            anchors.right: btStop.left
            anchors.top: btStop.top
            anchors.rightMargin: 10
            buttonText: qsTr("Fullscreen")
            buttonNumber: ""
            buttonImage: ("../img/fullscreen.png")
            height: 90
            width: 130
            opacity: videoFlip.flipped ? 1 : 0
            onButtonClick: videoWrapper.state = "fullscreen"
        }

        MainButton {
            id: btStop
            anchors.right: videoFlip.right
            anchors.top: videoFlip.bottom
            anchors.topMargin: 10
            buttonText: qsTr("Stop")
            buttonNumber: ""
            buttonImage: ("../img/stop.png")
            height: 90
            width: 90
            onButtonClick: {
                playVideos.stop()
                videoFlip.flipped = false
            }
        }


    }
}
