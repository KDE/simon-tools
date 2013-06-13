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
    objectName: "MainScreen"
    stateName: "Main"
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.leftMargin: 50
    anchors.rightMargin: 50

    function playVideo(path) {
        setScreen("MainVideos")
        pgMainVideos.playVideo(path)
    }

    Page {
        stateName: parent.stateName
        title: simonTouch.date() ; //Qt.formatDateTime(new Date(), "dddd, dd. MMMM yyyy")
        PageGrid {
            id: pageGrid
            Button {
                id: btButton1
                objectName: "btWeather"
                buttonText: i18n("Weather")
                buttonNumber: "1"
                shortcut: Qt.Key_1
                buttonImage: ("../img/Button_Weather.png")
                width: screen.width / 4.2
                height: screen.height / 3
            }
            Button {
                id: btButton2
                objectName: "btImages"
                buttonText: i18n("Images")
                buttonNumber: "2"
                shortcut: Qt.Key_2
                buttonImage: ("../img/Button_Images.png")
                onButtonClick: setScreen("MainImages")
                width: screen.width / 4.2
                height: screen.height / 3
            }
            Button {
                id: btButton3
                objectName: "btVideo"
                buttonText: i18n("Videos")
                buttonNumber: "3"
                shortcut: Qt.Key_3
                buttonImage: ("../img/Button_Videos.png")
                onButtonClick: setScreen("MainVideos")
                width: screen.width / 4.2
                height: screen.height / 3
            }
            Button {
                id: btButton4
                objectName: "btMusic"
                buttonText: i18n("Music")
                buttonNumber: "4"
                shortcut: Qt.Key_4
                buttonImage: ("../img/Button_Music.png")
                onButtonClick: setScreen("MainMusic")
                width: screen.width / 4.2
                height: screen.height / 3
            }
            Button {
                id: btButton5
                objectName: "btNews"
                buttonText: i18n("News")
                buttonNumber: "5"
                shortcut: Qt.Key_5
                buttonImage: ("../img/Button_News.png")
                onButtonClick: setScreen("MainNews")
                width: screen.width / 4.2
                height: screen.height / 3
            }
            Button {
                id: btButton6
                objectName: "btCommunication"
                buttonText: i18n("Communication")
                buttonNumber: "6"
                shortcut: Qt.Key_6
                buttonImage: ("../img/Button_Communication.png")
                onButtonClick: setScreen("MainCommunication")
                width: screen.width / 4.2
                height: screen.height / 3
            }
            Button {
                id: btButton7
                objectName: "btCalendar"
                buttonText: i18n("Calendar")
                buttonNumber: "7"
                shortcut: Qt.Key_7
                buttonImage: ("../img/Button_Calendar.png")
                onButtonClick: { simonTouch.showCalendar() }
                width: screen.width / 4.2
                height: screen.height / 3
            }
            Button {
                id: btButton8
                objectName: "btRequest"
                buttonText: i18n("Requests")
                buttonNumber: "8"
                shortcut: Qt.Key_8
                buttonImage: ("../img/Button_Control.png")
                onButtonClick: setScreen("MainRequests")
                width: screen.width / 4.2
                height: screen.height / 3
            }
        }
    }
    MainImages {
        objectName: "MainImages"
    }
    MainMusic {
        objectName: "MainMusic"
    }
    MainVideos {
        objectName: "MainVideos"
        id: pgMainVideos
    }
    MainNews {
        objectName: "MainNews"
    }
    MainNewsFeeds{
        objectName: "MainNewsFeeds"
    }

    MainCommunication {
        objectName: "MainCommunication"
    }
    MainRequests {
        objectName: "MainRequests"
    }
}
