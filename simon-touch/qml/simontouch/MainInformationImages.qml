/*
 *   Copyright (C) 2011-2012 Mathias Stieger <m.stieger@cyber-byte.at>
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
                anchors.fill: parent

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
                buttonText: (state == "slideshowDisabled") ? qsTr("Slideshow") : qsTr("Stop slideshow")
//                disableImage: true
                spokenText: false
                buttonNumber: "Ok"
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

            Button {
                id: stopSlideshow
                anchors.horizontalCenter: parent.horizontalCenter
                visible: (parent.state =="windowed") ? 0 : 1
                height: 50
                width: 300
                z: 1
                buttonImage: "../img/go-down.svgz"
                buttonText: qsTr("Stop slideshow")
                shortcut: Qt.Key_Down
                spokenText: false
                buttonNumber: qsTr("Stop")
                buttonLayout: Qt.Horizontal
                onButtonClick: if (lvImages.currentIndex + 1 < lvImages.count) lvImages.currentIndex += 1
            }

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
