/*
 *   Copyright (C) 2011-2012 Mathias Stieger <m.stieger@simon-listens.org>
 *   Copyright (C) 2011-2012 Peter Grasch <grasch@simon-listens.org>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License version 2,
 *   or (at your option) any later version, as published by the Free
 *   Software Foundation
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details
 *
 *   You should have received a copy of the GNU General Public
 *   License along with this program; if not, write to the
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */


import QtQuick 1.1
import QtMultimediaKit 1.1
import "parts"

TabPage {
    objectName: "MainVideos"
    stateName: "Videos"
    id: screen
    anchors.fill: parent

    function playVideo(path) {
        playVideos.source = path
        videoFlip.flipped = true

        playVideos.play()
    }

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
    function updateTime() {
        var max;
        if (playVideos.status >= 3)
            max = msToStr(playVideos.duration)
        else
            max = "00:00:00"
        lbStatus.text = msToStr(playVideos.position)+ " / " + max
    }

    onOpacityChanged: {
        if (opacity == 0) {
            playVideos.stop()
            videoFlip.flipped = false
        }
        else lvVideos.focus = (opacity == 1)
    }

    Page {
        stateName: parent.stateName
        title: i18n("Videos")
        id: videoPage


        Rectangle {
            id: rectMenu
            width: screen.width/6
            height: 500
            anchors.verticalCenter: parent.verticalCenter
            color: "#FFFBC7"


            Image {
                id: menuImage
                source: ("../simontouch/img/Button_Videos.png")
                anchors{
                    bottom: menuHeader.top
                    bottomMargin: 0
                    horizontalCenter: parent.horizontalCenter
                }
                width: 100
                height: 100

                fillMode: Image.PreserveAspectFit
                smooth: true
            }

            Text {
                id: menuHeader
                text: i18n("Voice Commands")
                anchors{
                    bottom: lbtRauf.top
                    horizontalCenter: parent.horizontalCenter
                }
                x: 20
                font.family: "Arial"
                font.pointSize: 20
                font.bold: true
            }

            ListButton {
                id: lbtRauf
                anchors.left: parent.left
                anchors.top: parent.top
                shortcut: Qt.Key_Return
                anchors.topMargin: 150
                buttonText: i18n("UP")
                onButtonClick: if (lvVideos.currentIndex > 0) lvVideos.currentIndex -= 1
                width: screen.width/6
            }

            ListButton{
                id: lbtRunter
                anchors.left: parent.left
                anchors.top: lbtRauf.bottom
                buttonText: i18n("DOWN")
                onButtonClick: if (lvVideos.currentIndex + 1 < lvVideos.count) lvVideos.currentIndex += 1
                width: screen.width/6
            }

            ListButton{
                id: lbtHinauf
                anchors.left: parent.left
                anchors.top: lbtRunter.bottom
                buttonText: i18n("UPWARDS")
                onButtonClick: if (lvVideos.currentIndex > 4) lvVideos.currentIndex -= 5
                width: screen.width/6
            }

            ListButton{
                id: lbtHinunter
                anchors.left: parent.left
                anchors.top: lbtHinauf.bottom
                buttonText: i18n("DOWNWARDS")
                onButtonClick: if (lvVideos.currentIndex + 5 < lvVideos.count) lvVideos.currentIndex += 5
                width: screen.width/6
            }

            ListButton{
                id: lbtOk
                anchors.left: parent.left
                anchors.top: lbtHinunter.bottom
                buttonText: "OK"
                width: screen.width/6
                onButtonClick: {
                    videoFlip.flipped = true
                    playVideos.source = lvVideos.currentItem.fullPath
                    playVideos.play()
                }
            }

            ListButton{
                id: lbtStopp
                anchors.left: parent.left
                anchors.top: lbtOk.bottom
                width: screen.width/6
                buttonText: i18n("STOP")
                onButtonClick: {
                    playVideos.stop()
                    videoFlip.flipped = false
                }
            }
            ListButton{
                id: lbtLauter
                anchors.left: parent.left
                anchors.top: lbtStopp.bottom
                width: screen.width/6
                buttonText: i18n("LOUDER")
                onButtonClick: {
                    if(playVideos.volume < 1)
                    {
                        playVideos.volume += 0.2
                    }
                }
            }
            ListButton{
                id: lbtLeiser
                anchors.left: parent.left
                anchors.top: lbtLauter.bottom
                width: screen.width/6
                buttonText: i18n("QUIETER")
                onButtonClick: {
                    if(playVideos.volume > 0)
                    {
                        playVideos.volume -= 0.2
                    }
                }
            }
            ListButton{
                id: lbtVollbild
                anchors.left: parent.left
                anchors.top: lbtLeiser.bottom
                width: screen.width/6
                buttonText: i18n("FULLSCREEN")
                onButtonClick: statusRectangle.toggleFullScreen();
            }

            ListButton{
                id: lbtZurueck
                anchors.left: parent.left
                anchors.top: lbtVollbild.bottom
                width: screen.width/6
                buttonText: i18n("BACK")
                onButtonClick: back()
            }
        }

        ListButton{
            id: lbtSchlafen
            anchors.left: parent.left
            anchors.bottom: lbtAufwachen.top
            anchors.topMargin: 80
            buttonText: i18n("Simon sleep")
            width: screen.width/6
        }
        ListButton{
            id: lbtAufwachen
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            buttonText: i18n("Simon wake up")
            width: screen.width/6
        }


        AutoFlippable {
            id: videoFlip
            z: 100

            anchors {
                left: rectMenu.right
                right: parent.right
                top: parent.top
                bottom: parent.bottom
                margins: 160
                bottomMargin: 200
            }
            front:
                SelectionListView {
                id: lvVideos
                objectName: "lvVideos"
                anchors.fill: parent

                model: videosModel
                Component {
                    id: highlight
                    Rectangle {
                        color: "#FEF57B"
                        radius: 0
                        width: parent.width -2
                        border.color: "#8A8A8A"
                        border.width: 1
                    }
                }
                highlight: highlight

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
                    playVideos.stop()
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
                            x: screen.width/6 - 50- parent.x
                            y: - parent.y
                            width: main.width
                            height: main.height
                        }
                        PropertyChanges {
                            target: lbtVollbild
                            opacity: 1
                        }
                    }
                ]
                transitions: Transition {
                    NumberAnimation { properties: "width,height,x,y"; easing.type: Easing.InOutQuad }
                }


                Video {
                    id: playVideos
                    volume: 0.6

                    anchors.fill: parent

                    onStatusChanged: {
                        console.debug("State changed: " + status)
                        //updateTime()
                    }

                    onPositionChanged: {
                        console.debug("Pos: "+playVideos.position)
                        updateTime()

                        console.debug("Position changed: " + lbStatus.text)
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: statusRectangle.toggleFullScreen()
                    }
                }

            }
        }
        Rectangle {
            id: statusRectangle
            anchors.top: videoFlip.bottom
            anchors.horizontalCenter: videoFlip.horizontalCenter
            anchors.topMargin: 10

            function toggleFullScreen() {
                if (videoWrapper.state == "windowed") {
                    videoWrapper.state = "fullscreen"
                } else {
                    videoWrapper.state = "windowed"
                }
            }

            Text {
                id: lbStatus
                anchors.horizontalCenter: parent.horizontalCenter
                text: "00:00:00 / 00:00:00"
                font.family: "Arial"
                font.pointSize: 16
            }
        }
    }
}
