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
import "parts"

TabPage {
    id: screen
    objectName: "MainImages"
    stateName: "Images"
    anchors.fill: parent

    Page {
        stateName: parent.stateName
        title: i18n("Images")
        anchors.fill: parent
        id: imageWindow
        width: parent.width

        Rectangle {
            id: rectMenu
            width: screen.width/6
            height: 500
            anchors.verticalCenter: parent.verticalCenter
            color: "#FFFBC7"

            Image {
                id: menuImage
                source: ("../simontouch/img/Button_Images.png")
                anchors{
                    top: rectMenu.top
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
                text: i18n("Voice Command")
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
                anchors.topMargin: 150
                buttonText: i18n("UP")
                onButtonClick: if (lvImages.currentIndex > 0) lvImages.currentIndex -= 1
                width: screen.width/6
            }

            ListButton{
                id: lbtRunter
                anchors.left: parent.left
                anchors.top: lbtRauf.bottom
                buttonText: i18n("DOWN")
                onButtonClick: if (lvImages.currentIndex + 1 < lvImages.count) lvImages.currentIndex += 1
                width: screen.width/6
            }

            ListButton{
                id: lbtHinauf
                anchors.left: parent.left
                anchors.top: lbtRunter.bottom
                buttonText: i18n("UPWARDS")
                onButtonClick: if (lvImages.currentIndex > 4) lvImages.currentIndex -= 5
                width: screen.width/6
            }

            ListButton{
                id: lbtHinunter
                anchors.left: parent.left
                anchors.top: lbtHinauf.bottom
                buttonText: i18n("DOWNWARDS")
                onButtonClick: if (lvImages.currentIndex + 5 < lvImages.count) lvImages.currentIndex += 5
                width: screen.width/6
            }

            ListButton{
                id: lbtOk
                anchors.left: parent.left
                anchors.top: lbtHinunter.bottom
                buttonText: ""
                width: screen.width/6
                state: "slideshowDisabled"
                states: [
                    State {
                        name: "slideshowDisabled"
                        PropertyChanges {
                            target: lbtOk
                        }
                    },
                    State {
                        name: "slideshowEnabled"
                        PropertyChanges {
                            target: lbtOk
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

                onButtonClick: imageWindow.showSlideshow()
            }

            Text {
                id: lbtOkMainText
                anchors{
                    left: lbtOk.left
                    bottom: lbtOk.bottom
                }
                text: "OK"

                font.family: "Arial"
                font.pointSize: 16
                anchors.margins: 9
                color: "#000099"
            }

            Text {
                id: lbtOkText
                color: "#000000"
                text: " = Diashow"
                font.family: "Arial"
                font.pointSize: 14
                anchors{
                    left: lbtOkMainText.right
                    bottom: lbtOk.bottom
                    bottomMargin: 10
                }
            }
            ListButton{
                id: lbtStopp
                anchors.left: parent.left
                anchors.top: lbtOk.bottom
                buttonText: ""
                width: screen.width/6
                onButtonClick: imageWindow.stopSlideshow()
            }
            Text {
                id: lbtStoppMainText
                anchors{
                    left: lbtStopp.left
                    bottom: lbtStopp.bottom
                }
                text: i18n("STOP")

                font.family: "Arial"
                font.pointSize: 16
                anchors.margins: 9
                color: "#000099"
            }

            Text {
                id: lbtStoppText
                color: "#000000"
                text: " (Diashow)"
                font.family: "Arial"
                font.pointSize: 14
                anchors{
                    left: lbtStoppMainText.right
                    bottom: lbtStopp.bottom
                    bottomMargin: 10
                }
            }

            ListButton{
                id: lbtZurueck
                anchors.left: parent.left
                anchors.top: lbtStopp.bottom
                buttonText: i18n("BACK")
                onButtonClick: back()
                width: screen.width/6
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

        Item {
            id: leftColumn
            width: screen.width/6
            height: 100
            anchors {
                left: rectMenu.right
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
                anchors.fill: parent

                model: imagesModel
                Component {
                    id: highlight
                    Rectangle {
                        color: "#8A8A8A" // "lightsteelblue"
                        opacity: 0.3
                        radius: 5
                        width: parent.width -2
                        border.color: "#8A8A8A"
                        border.width: 1
                    }
                }
                highlight: highlight

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
        }

        function showSlideshow() {
            if (lbtOk.state == "slideshowDisabled") {
                slideshowTimer.start();
                imageWrapper.state = "fullscreen"
                lbtOk.state = "slideshowEnabled";
            }
        }
        function stopSlideshow(){
            if(lbtOk.state == "slideshowEnabled")
            {
                slideshowTimer.stop();
                imageWrapper.state = "windowed"
                lbtOk.state = "slideshowDisabled";
            }
        }

        Rectangle {
            id: imageWrapper
            color: "#FFFBC7"
            state: "windowed"

            Button {
                id: stopSlideshow
                anchors.horizontalCenter: parent.horizontalCenter
                opacity: (parent.state =="windowed") ? 0 : 1
                height: 55
                width: 500
                z: 1
                buttonImage: "../img/go-down.svgz"
                buttonText: i18n("Stop slideshow")
                shortcut: Qt.Key_S
                spokenText: false
                buttonLayout: Qt.Horizontal
                onButtonClick: imageWindow.stopSlideshow()
                Behavior on opacity {
                    NumberAnimation {properties: "opacity"; duration: 500}
                }
            }

            Image {
                id: imImage
                anchors.fill: parent
                fillMode: Image.PreserveAspectFit
                smooth: true
                MouseArea {
                    anchors.fill: parent
                    onClicked: imageWindow.stopSlideshow()
                }
            }

            states: [
                State {
                    name: "windowed"
                    PropertyChanges {
                        target: imageWrapper
                        x: leftColumn.x + leftColumn.width + 20
                        y: leftColumn.y
                        width:  parent.width - leftColumn.width - leftColumn.x - 70
                        height: leftColumn.height
                    }
                },
                State {
                    name: "fullscreen"
                    PropertyChanges {
                        target: imageWrapper
                        x: screen.x - 50
                        y: screen.y
                        width: main.width
                        height: main.height
                        color: "black"
                    }
                }
            ]

            transitions: Transition {
                ParallelAnimation {
                    NumberAnimation { properties: "width,height,x,y"; easing.type: Easing.InOutQuad }
                    ColorAnimation { duration: 200 }
                }
            }

        }
    }
}
