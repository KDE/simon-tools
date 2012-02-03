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
    id: mainInformation
    objectName: "MainInformation"
    stateName: "Information"

    Page {
        stateName: parent.stateName
        title: qsTr("Information")
        PageGrid {
            id: pageGrid
            Button {
                id: btButton1
                objectName: "btInformationImages"
                buttonText: qsTr("Images")
                buttonNumber: "1"
                shortcut: Qt.Key_1
                buttonImage: ("../img/Button_Information_Bilder.png")
                onButtonClick: setScreen("MainInformationImages")
            }
            Button {
                id: btButton2
                objectName: "btInformationMusic"
                buttonText: qsTr("Music")
                buttonNumber: "2"
                shortcut: Qt.Key_2
                buttonImage: ("../img/Button_Information_Musik.png")
                onButtonClick: setScreen("MainInformationMusic")
            }
            Button {
                id: btButton3
                objectName: "btInformationVideo"
                buttonText: qsTr("Videos")
                buttonNumber: "3"
                shortcut: Qt.Key_3
                buttonImage: ("../img/Button_Information_Video.png")
                onButtonClick: setScreen("MainInformationVideos")
            }
            Button {
                id: btButton4
                objectName: "btInformationNews"
                buttonText: qsTr("News")
                buttonNumber: "4"
                shortcut: Qt.Key_4
                buttonImage: ("../img/Button_Information_Zeitung.png")
                onButtonClick: setScreen("MainInformationNews")
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
