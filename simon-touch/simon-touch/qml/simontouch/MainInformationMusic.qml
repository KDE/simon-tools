import QtQuick 1.1
import QtMultimediaKit 1.1
import "parts"

TabPage {
    objectName: "MainInformationMusic"
    stateName: "Music"

    onOpacityChanged: {
        playMusic.stop()
        lvMusic.focus = (opacity == 1)
    }

    Page {
        stateName: parent.stateName
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
                margins: 160
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

        Button {
            id: btMusicUp
            anchors.left: lvMusic.left
            anchors.top: lvMusic.bottom
            anchors.topMargin: 10
            objectName: "btMusicUp"
            buttonText: qsTr("Up")
            buttonNumber: ""
            buttonImage: ("../img/go-up.svgz")
            spokenText: true
            shortcut: Qt.Key_Up
            height: 90
            width: 90
            onButtonClick: if (lvMusic.currentIndex > 0) lvMusic.currentIndex -= 1
        }

        Button {
            id: btMusicPlay
            anchors.left: btMusicUp.right
            anchors.top: lvMusic.bottom
            anchors.topMargin: 10
            anchors.leftMargin: 10
            objectName: "btPlay"
            buttonText: qsTr("Play")
            buttonNumber: ""
            buttonImage: ("../img/play.png")
            spokenText: true
            height: 90
            width: 90
            shortcut: Qt.Key_P
            onButtonClick: playMusic.play()
        }


        Text {
            id: lbStatus
            anchors.verticalCenter: btMusicPlay.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            text: "00:00:00 / 00:00:00"
            font.family: "Arial"
            font.pointSize: 16
        }

        Button {
            anchors.right: btMusicDown.left
            anchors.top: lvMusic.bottom
            anchors.topMargin: 10
            anchors.rightMargin: 10
            objectName: "btStop"
            buttonText: qsTr("Stop")
            buttonNumber: ""
            buttonImage: ("../img/stop.png")
            shortcut: Qt.Key_S
            spokenText: true
            height: 90
            width: 90
            onButtonClick: playMusic.stop()
        }

        Button {
            id: btMusicDown
            anchors.right: lvMusic.right
            anchors.top: lvMusic.bottom
            anchors.topMargin: 10
            objectName: "btMusicDown"
            buttonText: qsTr("Down")
            buttonNumber: ""
            buttonImage: ("../img/go-down.svgz")
            shortcut: Qt.Key_Down
            spokenText: true
            height: 90
            width: 90
            onButtonClick: if (lvMusic.currentIndex + 1 < lvMusic.count) lvMusic.currentIndex += 1
        }


        Audio {
            id: playMusic
            onPositionChanged: {
                function msToStr(time) {
                    var seconds = Math.floor(time / 1000)
                    var minutes = Math.floor(seconds / 60)
                    var hours = Math.floor(minutes / 60)
                    minutes = minutes - hours*60
                    seconds = seconds - minutes*60

                    if (hours < 10) hours = "0" + hours
                    if (minutes < 10) minutes = "0" + minutes
                    if (seconds < 10) seconds = "0" + seconds

                    return hours + ":" + minutes + ":" + seconds
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
