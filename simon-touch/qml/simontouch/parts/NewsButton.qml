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

Rectangle {
    id: newsButton
    property string buttonText: ""
    property string buttonImage: ""
    property color onHoverColor: "#FEF57B"
    property color normalColor: "#FFFBC7"
    property string buttonNumber: ""
    property int buttonKey: 0
    property bool spokenText: false
    property int shortcut
    property bool extraSpokenText: true
    property int buttonLayout: Qt.Vertical
    property bool horizontalMiddleText:  true
    property string horizontalIconAlign: "left"
    property bool active : false
    property bool activeHover: true
    signal buttonClick()

    width: (screen.width / 4.3) - 75
    height: screen.height / 3
    radius: 10
    smooth: true
    color: (active || buttonMouseArea.isHovering) ? onHoverColor : normalColor
    border.color: "#8A8A8A"
    border.width: 1
    Text {
        id: mainButtonText
        text: buttonText

        font.family: "Arial"
        font.pointSize: 30
        anchors.bottom: (buttonLayout == Qt.Vertical) ? parent.bottom : undefined
        anchors.left: (buttonLayout == Qt.Horizontal && horizontalMiddleText == true && horizontalIconAlign == "left") ? mainButtonImage.right : undefined
        anchors.verticalCenter: (buttonLayout == Qt.Horizontal && horizontalMiddleText == true) ? parent.verticalCenter : undefined
        anchors.top: (buttonLayout == Qt.Horizontal && horizontalMiddleText == false) ? parent.top : undefined
        anchors.margins: 9
        color: (spokenText == true) ? "#000099" : "#000000"
        anchors.horizontalCenter: parent.horizontalCenter
    }
    Text {
        id: mainButtonNumber
        text: buttonNumber
        x: 5
        anchors.bottom: (buttonLayout == Qt.Vertical) ? parent.bottom :undefined
        anchors.verticalCenter: (buttonLayout == Qt.Horizontal) ? parent.verticalCenter : undefined
        anchors.right: (buttonLayout == Qt.Horizontal) ? parent.right : undefined
        anchors.margins: (buttonLayout == Qt.Horizontal) ? 9 : 0
        font.family: "Arial"
        font.pointSize: (buttonLayout == Qt.Horizontal) ? 55 : 40
        color: "#000099"
        visible: (buttonNumber == "" || extraSpokenText == false) ? 0 : 1
    }
    Image {
        id: mainButtonImage
        source: buttonImage
        anchors.leftMargin: (buttonLayout == Qt.Vertical) ? 37 : 10
        anchors.rightMargin: (buttonLayout == Qt.Vertical) ? 38 : 10
        anchors.topMargin: (buttonLayout == Qt.Vertical) ? 25 : 10
        anchors.left: (buttonLayout == Qt.Horizontal && horizontalIconAlign != "right") ? parent.left : undefined
        anchors.right: (buttonLayout == Qt.Horizontal && horizontalIconAlign == "right") ? parent.right : undefined
        anchors.verticalCenter: (buttonLayout == Qt.Horizontal && horizontalMiddleText == true) ? parent.verticalCenter : undefined
        anchors.horizontalCenter: (buttonLayout == Qt.Vertical && horizontalIconAlign != "right") ? parent.horizontalCenter : undefined
        anchors.top: (buttonLayout == Qt.Horizontal && horizontalMiddleText == false) ? parent.top : undefined
        height: (buttonLayout == Qt.Horizontal) ? parent.height - 20 : parent.height * 0.7
        width: (buttonLayout == Qt.Vertical) ? parent.width * 0.7 : undefined

        visible: (buttonImage == "") ? 0 : 1

        fillMode: Image.PreserveAspectFit
        smooth: true
    }
    MouseArea{
        property bool isHovering : false
        id: buttonMouseArea
        x: 0
        y: 0
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        anchors.fill: parent
        onClicked: buttonClick()
        hoverEnabled: parent.activeHover
        onEntered: isHovering = true
        onExited: isHovering = false
    }
    onButtonClick: {
        console.log(mainButtonText.text + " clicked" )
    }

    function registerInPage(page) {
        if (simonTouch.componentName(page).indexOf("Page") === 0)
            page.registerButton(newsButton)
        else {
            if (page.parent)
                registerInPage(page.parent)
        }
    }

    function handleKey(key) {
        if ((key == shortcut) && (button.opacity == 1)) {
            buttonClick()
            return true
        }
        return false
    }

    Component.onCompleted: {
        registerInPage(parent)
    }
}
