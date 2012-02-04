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

ListView {
    id: lvImages
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
    Component {
        id: lowlight
        Rectangle {
                color: "#FFFBC7"
                radius: 5
                width: parent.width -2
                border.color: "#8A8A8A"
                border.width: 1
        }
    }


    clip: true
    highlight: (activeFocus) ? highlight : lowlight
    spacing: 10

    Keys.onPressed: {
        if (event.key == Qt.Key_PageUp) {
            currentIndex = (currentIndex >= 5) ? currentIndex - 5 : 0
        } else if (event.key == Qt.Key_PageDown) {
            currentIndex = (currentIndex + 5 < count) ? currentIndex + 5 : count -1
        }
    }
}
