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
    objectName: "MainMusic"
    stateName: "Music"

    function nextTitle() {
        if (lvMusic.currentIndex + 1 < lvMusic.count) {
            lvMusic.currentIndex += 1
            return true;
        } else
            return false;
    }

    onOpacityChanged: {
        playMusic.stop()
        lvMusic.focus = (opacity == 1)
    }

    Page {
        id: pageMusic
        stateName: parent.stateName
        title: i18n("Music")
        anchors.fill: parent

        Rectangle {
            id: rectMenu
            width: screen.width/6
            height: 600
            anchors.verticalCenter: parent.verticalCenter
            color: "#FFFBC7"

            Image {
                id: menuImage
                source: ("../simontouch/img/Button_Music.png")
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
                width: screen.width/6
                anchors.left: parent.left
                anchors.top: parent.top
                shortcut: Qt.Key_Return
                anchors.topMargin: 150
                buttonText: i18n("UP")
                onButtonClick: if (lvMusic.currentIndex > 0) lvMusic.currentIndex -= 1
            }

            ListButton{
                id: lbtRunter
                width: screen.width/6
                anchors.left: parent.left
                anchors.top: lbtRauf.bottom
                buttonText: i18n("DOWN")
                onButtonClick: nextTitle()
            }

            ListButton{
                id: lbtHinauf
                width: screen.width/6
                anchors.left: parent.left
                anchors.top: lbtRunter.bottom
                buttonText: i18n("UPWARDS")
                onButtonClick: if (lvMusic.currentIndex > 4) lvMusic.currentIndex -= 5
            }

            ListButton{
                id: lbtHinunter
                width: screen.width/6
                anchors.left: parent.left
                anchors.top: lbtHinauf.bottom
                buttonText: i18n("DOWNWARDS")
                onButtonClick: if (lvMusic.currentIndex + 5 < lvMusic.count) lvMusic.currentIndex += 5
            }

            ListButton{
                id: lbtOk
                width: screen.width/6
                anchors.left: parent.left
                anchors.top: lbtHinunter.bottom
                buttonText: "OK"
                onButtonClick: playMusic.play()
            }

            ListButton{
                id: lbtStopp
                width: screen.width/6
                anchors.left: parent.left
                anchors.top: lbtOk.bottom
                buttonText: i18n("STOP")
                onButtonClick: playMusic.stop()
            }
            ListButton{
                id: lbtLauter
                width: screen.width/6
                anchors.left: parent.left
                anchors.top: lbtStopp.bottom
                buttonText: i18n("LOUDER")
                onButtonClick: {
                    if(playMusic.volume < 1)
                    {
                        playMusic.volume += 0.2
                    }
                }
            }
            ListButton{
                id: lbtLeiser
                width: screen.width/6
                anchors.left: parent.left
                anchors.top: lbtLauter.bottom
                buttonText: i18n("QUIETER")
                onButtonClick: {
                    if(playMusic.volume > 0)
                    {
                        playMusic.volume -= 0.2
                    }
                }
            }
            ListButton{
                id: lbtZurueck
                width: screen.width/6
                anchors.left: parent.left
                anchors.top: lbtLeiser.bottom
                buttonText: i18n("BACK")
                onButtonClick: back()
            }
        }
        ListButton{
            id: lbtSchlafen
            width: screen.width/6
            anchors.left: parent.left
            anchors.bottom: lbtAufwachen.top
            anchors.topMargin: 80
            buttonText: i18n("Simon sleep")
        }
        ListButton{
            id: lbtAufwachen
            width: screen.width/6
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            buttonText: i18n("Simon wake up")
        }

        SelectionListView {
            id: lvMusic
            objectName: "lvMusic"
            anchors {
                left: rectMenu.right
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
        Rectangle {
            id: rectMusic
            anchors.top: lvMusic.bottom
            x: screen.width / 2 - ((680 + lbStatus.width + 40)/2)

            Text {
                id: lbStatus
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.left: parent.left
                anchors.leftMargin: 150
                anchors.rightMargin: 10
                text: "00:00:00 / 00:00:00"
                font.family: "Arial"
                font.pointSize: 14
            }
        }

        Audio {
            id: playMusic
            volume: 0.6
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
            }
            onStatusChanged: {
                if (status == Audio.EndOfMedia) {
                    if (nextTitle()) {
                        playMusic.play();
                        console.debug("Start playing...")
                    }
                }
                else console.debug("Other status: "+status)
            }

        }
    }
}
