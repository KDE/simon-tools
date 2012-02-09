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
    objectName: "MainInformation"
    stateName: "Information"

    Page {
        stateName: parent.stateName
        title: i18n("Information")
        PageGrid {
            id: pageGrid
            Button {
                id: btButton1
                objectName: "btInformationImages"
                buttonText: i18n("Images")
                buttonNumber: "1"
                shortcut: Qt.Key_1
                buttonImage: ("../img/Button_Information_Bilder.png")
                onButtonClick: setScreen("MainInformationImages")
                width: screen.width / 4
                height: screen.height / 3
            }
            Button {
                id: btButton2
                objectName: "btInformationMusic"
                buttonText: i18n("Music")
                buttonNumber: "2"
                shortcut: Qt.Key_2
                buttonImage: ("../img/Button_Information_Musik.png")
                onButtonClick: setScreen("MainInformationMusic")
                width: screen.width / 4
                height: screen.height / 3
            }
            Button {
                id: btButton3
                objectName: "btInformationVideo"
                buttonText: i18n("Videos")
                buttonNumber: "3"
                shortcut: Qt.Key_3
                buttonImage: ("../img/Button_Information_Video.png")
                onButtonClick: setScreen("MainInformationVideos")
                width: screen.width / 4
                height: screen.height / 3
            }
            Button {
                id: btButton4
                objectName: "btInformationNews"
                buttonText: i18n("News")
                buttonNumber: "4"
                shortcut: Qt.Key_4
                buttonImage: ("../img/Button_Information_Zeitung.png")
                onButtonClick: setScreen("MainInformationNews")
                width: screen.width / 4
                height: screen.height / 3
            }
        }
    }

    MainInformationImages {
        objectName: "MainInformationImages"
    }
    MainInformationMusic {
        objectName: "MainInformationMusic"
    }
    MainInformationVideos {
        objectName: "MainInformationVideos"
    }
    MainInformationNews {
        objectName: "MainInformationNews"
    }
}
