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

 Page {
     id: tabWidget
     property string current: "MainScreen"
     property bool backAvailable : true;

     function setScreen(screen) {
         current = screen
     }

     function back() {
         if (current == "MainScreen")
             parent.back()
         else
             setScreen("MainScreen")
     }

     function setOpacities(FFFBC7) {
         for (var i = 0; i < tabWidget.children.length; ++i) {
             if (tabWidget.children[i] == btBack)
                 continue;

             if (tabWidget.children[i].objectName == current) {
                 tabWidget.children[i].opacity = 1
                 tabWidget.children[i].focus = true
                 tabWidget.title = tabWidget.children[i].title
                 simonTouch.setState(tabWidget.children[i].stateName)
             } else {
                 tabWidget.children[i].opacity = 0
                 tabWidget.children[i].focus = false
             }
         }
     }

     onCurrentChanged: setOpacities()
     Component.onCompleted: {
         for (var i = 2; i < tabWidget.children.length; ++i) /*skip text*/
             tabWidget.children[i].showScreen.connect(setScreen)

         setOpacities()
     }


     Keys.onPressed: {
         for (var i = 0; i < tabWidget.children.length; ++i) {
             if (tabWidget.children[i] == btBack)
                 continue;
             if (tabWidget.children[i].objectName == current) {
                 if (tabWidget.children[i].handleKey(event.key)) {
                     event.accepted = true
                     return
                 }
             }
         }

     }

     Button {
         id: btBack
         x: 1
         y: -11
         width: 240
         height: 100
         buttonText: qsTr("Back")
         buttonImage: ("../img/back.png")
         buttonLayout: Qt.Horizontal
         normalColor: "#FEF57B"
         opacity: backAvailable && tabWidget.opacity
         onButtonClick: back()
         spokenText: true
     }
 }
