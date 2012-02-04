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
import QtWebKit 1.0

Item {
    property string heading: ""
    property string article: ""

    Text {
        id: headingText
        text: heading

        font.family: "Arial"
        font.pointSize: 20
        anchors.top: parent.top
        anchors.margins: 6
        anchors.horizontalCenter: parent.horizontalCenter
    }
    FlickableWebView {
        smooth: true
        anchors {
            left: parent.left
            right: parent.right
            top: headingText.bottom
            topMargin: 20
            bottom: parent.bottom
        }

        html: article
    }

}
