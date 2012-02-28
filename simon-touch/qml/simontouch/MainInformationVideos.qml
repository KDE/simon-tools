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
    objectName: "MainInformationVideos"
    stateName: "Videos"

    function playVideo(path) {
        playVideos.source = path
        videoFlip.flipped = true

        console.debug("Really playing "+path)
        playVideos.play()
    }

    onOpacityChanged: {
        if (opacity == 0) playVideos.stop()
        else lvVideos.focus = (opacity == 1)
    }

    Page {
        stateName: parent.stateName
        title: i18n("Videos")
        id: videoPage


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
                    Component {
                        id: highlight
                        Rectangle {
                                color: "#FEF57B" // "lightsteelblue"
                                radius: 5
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
                            PropertyChanges {
                                target: btStopFullScreen
                                opacity: 0
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
                            PropertyChanges {
                                target: btStopFullScreen
                                opacity: 1
                            }
                        }
                    ]
                    transitions: Transition {
                        NumberAnimation { properties: "width,height,x,y"; easing.type: Easing.InOutQuad }
                    }

                    Button {
                        id: btStopFullScreen
                        anchors.top: videoWrapper.top
                        anchors.horizontalCenter: videoWrapper.horizontalCenter
                        objectName: "btStopFullScreen"
                        buttonText: i18n("Full-screen")
                        buttonNumber: ""
                        buttonImage: ("../img/go-down.svgz")
                        shortcut: Qt.Key_F
                        spokenText: true
                        height: 50
                        width: 200
                        buttonLayout: Qt.Horizontal
                        onButtonClick: buttonRectangle.toggleFullScreen();
                        Behavior on opacity {
                            NumberAnimation {properties: "opacity"; duration: 500}
                        }
                    }

                    Video {
                        id: playVideos

                        anchors.fill: parent

                        onStatusChanged: {
                            console.debug("State changed: " + status)
                        }

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
                            lbStatus.text = msToStr(playVideos.position)+ " / " + msToStr(playVideos.duration)
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: buttonRectangle.toggleFullScreen()
                        }
                    }

            }
        }
        Rectangle {
            id: buttonRectangle
            anchors.top: videoFlip.bottom
            anchors.topMargin: 10
            x: (btFullScreen.opacity == 1) ? screen.width / 2 - ((700 + lbStatus.width + 40)/2) : screen.width / 2 - ((530 + lbStatus.width + 40)/2)

            function toggleFullScreen() {
                if (videoWrapper.state == "windowed") {
                    videoWrapper.state = "fullscreen"
                } else {
                    videoWrapper.state = "windowed"
                }
            }


            Button {
                id: btVideosUp
                objectName: "btVideosUp"
                buttonText: i18n("Up")
                buttonNumber: ""
                buttonImage: ("../img/go-up.svgz")
                shortcut: Qt.Key_Up
                spokenText: true
                height: 50
                width: 120
                buttonLayout: Qt.Horizontal
                onButtonClick: if (lvVideos.currentIndex > 0) lvVideos.currentIndex -= 1
            }

            Button {
                id: btVideosPlay
                anchors.left: btVideosUp.right
                anchors.leftMargin: 10
                objectName: "btPlay"
                buttonText: i18n("Play")
                buttonNumber: "Ok"
                buttonImage: ("../img/play.png")
                shortcut: Qt.Key_Return
                spokenText: false
                height: 50
                width: 170
                buttonLayout: Qt.Horizontal
                onButtonClick: {
                    videoFlip.flipped = true
                    playVideos.play()
                }

            }


            Text {
                id: lbStatus
                anchors.verticalCenter: btVideosPlay.verticalCenter
                anchors.left: btVideosPlay.right
                anchors.leftMargin: 10
                text: "00:00:00 / 00:00:00"
                font.family: "Arial"
                font.pointSize: 16
            }

            Button{
                id:btFullScreen
                anchors.left: lbStatus.right
                anchors.leftMargin: 10
                buttonText: i18n("Full-screen")
                buttonNumber: ""
                buttonImage: ("../img/fullscreen.png")
                shortcut: Qt.Key_F
                spokenText: true
                height: 50
                width: 170
                buttonLayout: Qt.Horizontal
                opacity: videoFlip.flipped ? 1 : 0
                onButtonClick: parent.toggleFullScreen();
            }

            Button{
                id: btStop
                anchors.left: lbStatus.right
                anchors.leftMargin: (btFullScreen.opacity == 1) ? 20 + btFullScreen.width : 10
                buttonText: i18n("Stop")
                buttonNumber: ""
                buttonImage: ("../img/stop.png")
                shortcut: Qt.Key_S
                spokenText: true
                height: 50
                width: 120
                buttonLayout: Qt.Horizontal
                onButtonClick: {
                    playVideos.stop()
                    videoFlip.flipped = false
                }
            }

            Button {
                id: btVideosDown
                anchors.left: btStop.right
                anchors.leftMargin: 10
                objectName: "btMusicDown"
                buttonText: i18n("Down")
                buttonNumber: ""
                buttonImage: ("../img/go-down.svgz")
                shortcut: Qt.Key_Down
                spokenText: true
                height: 50
                width: 120
                buttonLayout: Qt.Horizontal
                onButtonClick: if (lvVideos.currentIndex + 1 < lvVideos.count) lvVideos.currentIndex += 1
            }
        }
    }
}
