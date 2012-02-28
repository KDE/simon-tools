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
    objectName: "MainRequestsShoppingMedicine"
    stateName: "RequestsShoppingMedicine"

    onOpacityChanged: {
        lvShoppingMedicine.focus = (opacity == 1)
    }

    Page {
        stateName: parent.stateName
        title: i18n("Medicine")
        anchors.fill: parent
/*
############## JS Functions
*/

        function selectCurrentItem (inputModel, outputModel, inputLv, outputLv) {
            outputModel.append({"name":inputModel.get(inputLv.currentIndex).name,"amount":inputModel.get(inputLv.currentIndex).amount,"price":inputModel.get(inputLv.currentIndex).price,"category":inputModel.get(inputLv.currentIndex).category});
            inputModel.remove(inputLv.currentIndex);
        }

        function addAmount () {
            if (lvShoppingMedicine.activeFocus) {
                lvShoppingMedicineSelectionModel.append({"name":lvShoppingMedicineModel.get(lvShoppingMedicine.currentIndex).name,"amount":lvShoppingMedicineModel.get(lvShoppingMedicine.currentIndex).amount,"price":lvShoppingMedicineModel.get(lvShoppingMedicine.currentIndex).price,"category":lvShoppingMedicineModel.get(lvShoppingMedicine.currentIndex).category, "index":lvShoppingMedicine.currentIndex});
                lvShoppingMedicineModel.remove(lvShoppingMedicine.currentIndex);
            } else {
                if(lvShoppingMedicineSelection.activeFocus) {
                    lvShoppingMedicineSelectionModel.set(lvShoppingMedicineSelection.currentIndex, {"amount": ++lvShoppingMedicineSelectionModel.get(lvShoppingMedicineSelection.currentIndex).amount})
                }
            }
        }

        function decreaseAmount () {
            if (lvShoppingMedicine.activeFocus){
                return;
            } else {
                if (lvShoppingMedicineSelectionModel.get(lvShoppingMedicineSelection.currentIndex).amount > 1) {
                    lvShoppingMedicineSelectionModel.set(lvShoppingMedicineSelection.currentIndex, {"amount": --lvShoppingMedicineSelectionModel.get(lvShoppingMedicineSelection.currentIndex).amount})
                } else {
                    lvShoppingMedicineModel.insert(lvShoppingMedicineSelectionModel.get(lvShoppingMedicineSelection.currentIndex).index, {"name": lvShoppingMedicineSelectionModel.get(lvShoppingMedicineSelection.currentIndex).name, "amount": lvShoppingMedicineSelectionModel.get(lvShoppingMedicineSelection.currentIndex).amount, "price": lvShoppingMedicineSelectionModel.get(lvShoppingMedicineSelection.currentIndex).price, "category": lvShoppingMedicineSelectionModel.get(lvShoppingMedicineSelection.currentIndex).category});
                    lvShoppingMedicineSelectionModel.remove(lvShoppingMedicineSelection.currentIndex);
                }
            }
        }

        function setActiveFocus(listView) {
            listView.forceActiveFocus();
        }

        function moveUp() {
            if (lvShoppingMedicine.activeFocus && lvShoppingMedicine.currentIndex >= 1) {
                --lvShoppingMedicine.currentIndex
            } else if (lvShoppingMedicineSelection.activeFocus && lvShoppingMedicineSelection.currentIndex >= 1){
                --lvShoppingMedicineSelection.currentIndex
            } else { return; }
        }

        function moveDown() {
            if (lvShoppingMedicine.activeFocus && lvShoppingMedicine.currentIndex < lvShoppingMedicineModel.count-1) {
                ++lvShoppingMedicine.currentIndex
            } else if (lvShoppingMedicineSelection.activeFocus && lvShoppingMedicineSelection.currentIndex >= lvShoppingMedicineSelectionModel.count-1){
                ++lvShoppingMedicineSelection.currentIndex
            } else { return; }
        }

/*
############## Items
*/

        ListModel {
            id: lvShoppingMedicineModel
            ListElement {
                name: "Aspirin";
                amount: "1";
                price: "0.89";
                category: "Medicine";
            }
            ListElement {
                name: "cough syrup";
                amount: "1";
                price: "0.89";
                category: "Medicine";
            }
            ListElement {
                name: "Voltaren";
                amount: "1";
                price: "0.89";
                category: "Medicine";
            }
            ListElement {
                name: "Neocitran";
                amount: "1";
                price: "0.89";
                category: "Medicine";
            }
            ListElement {
                name: "cough drops";
                amount: "1";
                price: "0.89";
                category: "Medicine";
            }
        }

        ListModel {
            id: lvShoppingMedicineSelectionModel
        }

        Component {
            id: medicineModelDelegate
            Text {
                text: name
                font.family: "Arial"
                font.pointSize: 16
                width: parent.width
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        lvShoppingMedicine.currentIndex = index;
                    }
                }
            }
        }

        Component {
            id: sectionDelegate
            Item {
                width: parent.width
                height: sectionText.height
                Text {
                    id: sectionText
                    text: section
                    font.family: "Arial"
                    font.pointSize: 16
                    color: "#777777"
                    anchors.right: parent.right
                    font.bold: true
                }
            }
        }

        SelectionListView {
            id: lvShoppingMedicine
            objectName: "lvShoppingMedicine"
            anchors {
                top: parent.top
                bottom: parent.bottom
                leftMargin: 0
                rightMargin: 0
                topMargin: 160
                bottomMargin: 160
            }
            width: screen.width / 3
            model: lvShoppingMedicineModel
            x: screen.width / 2 - lvShoppingMedicine.width + 10

            delegate: medicineModelDelegate
            section.property: "category"
            section.criteria: ViewSection.FullString
            section.delegate: sectionDelegate
        }

        Button {
            width: lvShoppingMedicine.width
            height: 50
            id: itemLabel
            buttonText: i18n("Articles")
            activeHover: false
            active: lvShoppingMedicine.activeFocus
            anchors {
                bottom: lvShoppingMedicine.top
                left: lvShoppingMedicine.left
                bottomMargin: 10
            }
            onButtonClick: parent.setActiveFocus(lvShoppingMedicine)
        }

/*
############## Shopping cart
*/

        Component {
            id: medicineModelDelegateSelection
            Item {
                width: parent.width
                height: 25
                Text {
                    text: name
                    font.family: "Arial"
                    font.pointSize: 16
                    anchors.left: parent.left
                }
                Text {
                    text: amount
                    font.family: "Arial"
                    font.pointSize: 16
                    anchors.right: parent.right
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        lvShoppingMedicineSelection.currentIndex = index
                    }
                }
            }
        }

        SelectionListView {
            id: lvShoppingMedicineSelection
            objectName: "lvShoppingMedicineSelection"
            anchors {
                left: lvShoppingMedicine.right
                top: parent.top
                bottom: parent.bottom
                topMargin: 160
                leftMargin: 10
            }
            width: lvShoppingMedicine.width
            model: lvShoppingMedicineSelectionModel
            delegate: medicineModelDelegateSelection
        }


        Button {
            width: lvShoppingMedicineSelection.width
            height: 50
            id: cartLabel
            buttonText: i18n("Shopping cart")
            activeHover: false
            active: lvShoppingMedicineSelection.activeFocus
            anchors {
                bottom: lvShoppingMedicineSelection.top
                left: lvShoppingMedicineSelection.left
                bottomMargin: 10
            }
            onButtonClick: parent.setActiveFocus(lvShoppingMedicineSelection)
        }

/*
############## Buttons
*/


        Button {
            id: lvCursorUp
            anchors.top: lvShoppingMedicine.bottom
            anchors.topMargin: 10
            x: screen.width / 2 - ((5*150)+100+60) / 2
            anchors.rightMargin: 10
            width: 150
            height: 50
            buttonImage: "../img/go-up.svgz"
            buttonText: i18n("Up")
            shortcut: Qt.Key_Up
            spokenText: true
            buttonLayout: Qt.Horizontal
            onButtonClick: parent.moveUp()
        }

        Button {
            id: lvCursorDown
            anchors.top: lvShoppingMedicine.bottom
            anchors.left: lvCursorUp.right
            anchors.leftMargin: 10
            anchors.topMargin: 10
            width: lvCursorUp.width
            height: 50
            buttonImage: "../img/go-down.svgz"
            buttonText: i18n("Down")
            shortcut: Qt.Key_Down
            spokenText: true
            buttonLayout: Qt.Horizontal
            horizontalIconAlign: "right"
            onButtonClick: parent.moveDown()
        }

        Button {
            id: categoryLeft
            width: lvCursorUp.width
            height: 50
            buttonText: i18n("Left")
            spokenText: true
            shortcut: Qt.Key_Left
            buttonLayout: Qt.Horizontal
            buttonImage: "../img/go-previous.svgz"
            horizontalIconAlign: "left"
            anchors {
                top: lvShoppingMedicine.bottom
                left: lvCursorDown.right
                leftMargin: 10
                topMargin: 10
            }
            onButtonClick: lvShoppingMedicine.activeFocus ? lvShoppingMedicineSelection.forceActiveFocus() : lvShoppingMedicine.forceActiveFocus()
        }
        Button {
            id: categoryRight
            width: lvCursorUp.width
            height: 50
            buttonText: i18n("Right")
            spokenText: true
            shortcut: Qt.Key_Right
            buttonLayout: Qt.Horizontal
            horizontalIconAlign: "right"
            buttonImage: "../img/go-next.svgz"
            anchors {
                top: lvShoppingMedicine.bottom
                left: categoryLeft.right
                leftMargin: 10
                topMargin: 10
            }
            onButtonClick: lvShoppingMedicine.activeFocus ? lvShoppingMedicineSelection.forceActiveFocus() : lvShoppingMedicine.forceActiveFocus()
        }
        Button {
            width: 50
            height: 50
            id: decreaseAmount
            buttonText: i18n("-")
            shortcut: Qt.Key_Minus
            spokenText: true
            anchors {
                top: lvShoppingMedicine.bottom
                left: categoryRight.right
                leftMargin: 10
                topMargin: 10
            }
            onButtonClick: parent.decreaseAmount();
        }
        Button {
            width: 50
            height: 50
            id: addAmount
            buttonText: i18n("+")
            shortcut: Qt.Key_Plus
            spokenText: true
            anchors {
                top: lvShoppingMedicine.bottom
                left: decreaseAmount.right
                leftMargin: 10
                topMargin: 10
            }
            onButtonClick: parent.addAmount()
        }
        Button {
            width: lvCursorUp.width
            height: 50
            id: medicineDeselect
            buttonText: i18n("Order")
            spokenText: true
            shortcut: Qt.Key_Enter
            buttonLayout: Qt.Horizontal
            buttonImage: "../img/Button_Anfragen_Bestellung.png"
            horizontalIconAlign: "left"
            anchors {
                top: lvShoppingMedicine.bottom
                left: addAmount.right
                leftMargin: 10
                topMargin: 10
            }
            onButtonClick: {
                var list="";
                for (i=0; i<lvShoppingMedicineSelectionModel.count; i++)
                    list += lvShoppingMedicineSelectionModel.get(i).amount + "x " + lvShoppingMedicineSelectionModel.get(i).name + "\n"
                simonTouch.sendMedicineShoppingOrder(list)
                //TODO: clear selection
                back()
            }
        }
    }
}
