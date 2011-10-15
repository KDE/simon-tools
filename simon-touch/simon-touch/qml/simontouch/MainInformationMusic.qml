import QtQuick 1.1
import QtMultimediaKit 1.1
import "parts"

TabPage {
    objectName: "MainInformationMusic"

    onOpacityChanged: {
        playMusic.stop()
        lvMusic.focus = (opacity == 1)
    }

    Page {
        title: qsTr("Music")
        anchors.fill: parent

        SelectionListView {
            id: lvMusic
            objectName: "lvMusic"
            anchors {
                left: parent.left
                right: parent.right
                top: parent.top
                bottom: parent.bottom
                margins: 100
                bottomMargin: 200
            }

            model: musicModel

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
                                lvMusic.currentIndex = index
                            }
                        }
                    }
            }
            onCurrentItemChanged: {
                var isPlaying = playMusic.playing;
                playMusic.source = currentItem.fullPath
                if (isPlaying)
                    playMusic.play()
            }
        }

        MainButton {
            id: pbPlay
            anchors.left: lvMusic.left
            anchors.top: lvMusic.bottom
            anchors.topMargin: 10
            objectName: "btPlay"
            buttonText: qsTr("Play")
            buttonNumber: ""
            buttonImage: ("../img/play.png")
            height: 90
            width: 90
            onButtonClick: playMusic.play()
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
            anchors.right: lvMusic.right
            anchors.top: lvMusic.bottom
            anchors.topMargin: 10
            objectName: "btPlay"
            buttonText: qsTr("Stop")
            buttonNumber: ""
            buttonImage: ("../img/stop.png")
            height: 90
            width: 90
            onButtonClick: playMusic.stop()
        }


        Audio {
            id: playMusic
            onPositionChanged: {
                function msToStr(time) {
                    var seconds = Math.floor(time / 1000)
                    var minutes = Math.floor(seconds / 60)
                    seconds = seconds - minutes*60

                    return minutes + ":" + seconds
                }
                lbStatus.text = msToStr(playMusic.position)+ " / " + msToStr(playMusic.duration)
                console.debug("Playing changed: "+position+ " "+duration)
                if (position == duration) {
                    nextTitle();
                }
            }
            onStatusChanged: {
                if (status == Audio.EndOfMedia) {
                    if (lvMusic.currentIndex + 1 < lvMusic.count) {
                        lvMusic.currentIndex++;
                        playMusic.play();
                        console.debug("Start playing...")
                    }
                }
                else console.debug("Other status: "+status)
            }

        }
    }
}
