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
    objectName: "MainRequestsShoppingDrinks"
    stateName: "RequestsShoppingDrinks"

    onOpacityChanged: {
        lvShoppingDrinks.focus = (opacity == 1)
    }

    Page {
        stateName: parent.stateName
        title: i18n("Household")
        anchors.fill: parent
/*
############## JS Functions
*/

        function selectCurrentItem (inputModel, outputModel, inputLv, outputLv) {
            outputModel.append({"name":inputModel.get(inputLv.currentIndex).name,"amount":inputModel.get(inputLv.currentIndex).amount,"price":inputModel.get(inputLv.currentIndex).price,"category":inputModel.get(inputLv.currentIndex).category});
            inputModel.remove(inputLv.currentIndex);
        }

        function addAmount () {
            if (lvShoppingDrinks.activeFocus) {
                lvShoppingDrinksSelectionModel.append({"name":lvShoppingDrinksModel.get(lvShoppingDrinks.currentIndex).name,"amount":lvShoppingDrinksModel.get(lvShoppingDrinks.currentIndex).amount,"price":lvShoppingDrinksModel.get(lvShoppingDrinks.currentIndex).price,"category":lvShoppingDrinksModel.get(lvShoppingDrinks.currentIndex).category, "index":lvShoppingDrinks.currentIndex});
                lvShoppingDrinksModel.remove(lvShoppingDrinks.currentIndex);
            } else {
                if(lvShoppingDrinksSelection.activeFocus) {
                    lvShoppingDrinksSelectionModel.set(lvShoppingDrinksSelection.currentIndex, {"amount": ++lvShoppingDrinksSelectionModel.get(lvShoppingDrinksSelection.currentIndex).amount})
                }
            }
        }

        function decreaseAmount () {
            if (lvShoppingDrinks.activeFocus){
                return;
            } else {
                if (lvShoppingDrinksSelectionModel.get(lvShoppingDrinksSelection.currentIndex).amount > 1) {
                    lvShoppingDrinksSelectionModel.set(lvShoppingDrinksSelection.currentIndex, {"amount": --lvShoppingDrinksSelectionModel.get(lvShoppingDrinksSelection.currentIndex).amount})
                } else {
                    lvShoppingDrinksModel.insert(lvShoppingDrinksSelectionModel.get(lvShoppingDrinksSelection.currentIndex).index, {"name": lvShoppingDrinksSelectionModel.get(lvShoppingDrinksSelection.currentIndex).name, "amount": lvShoppingDrinksSelectionModel.get(lvShoppingDrinksSelection.currentIndex).amount, "price": lvShoppingDrinksSelectionModel.get(lvShoppingDrinksSelection.currentIndex).price, "category": lvShoppingDrinksSelectionModel.get(lvShoppingDrinksSelection.currentIndex).category});
                    lvShoppingDrinksSelectionModel.remove(lvShoppingDrinksSelection.currentIndex);
                }
            }

        }

        function setActiveFocus(listView) {
            listView.forceActiveFocus();
        }

        function moveUp() {
            if (lvShoppingDrinks.activeFocus && lvShoppingDrinks.currentIndex >= 1) {
                --lvShoppingDrinks.currentIndex
            } else if (lvShoppingDrinksSelection.activeFocus && lvShoppingDrinksSelection.currentIndex >= 1){
                --lvShoppingDrinksSelection.currentIndex
            } else { return; }
        }

        function moveDown() {
            if (lvShoppingDrinks.activeFocus && lvShoppingDrinks.currentIndex < lvShoppingDrinksModel.count-1) {
                ++lvShoppingDrinks.currentIndex
            } else if (lvShoppingDrinksSelection.activeFocus && lvShoppingDrinksSelection.currentIndex >= lvShoppingDrinksSelectionModel.count-1){
                ++lvShoppingDrinksSelection.currentIndex
            } else { return; }
        }

/*
############## Items
*/

        ListModel {
            id: lvShoppingDrinksModel
            ListElement {
                name: "Mineral water";
                amount: "1";
                price: "0.89";
                category: "Drinks";
            }
            ListElement {
                name: "orange juice";
                amount: "1";
                price: "0.89";
                category: "Drinks";
            }
            ListElement {
                name: "apple juice";
                amount: "1";
                price: "0.89";
                category: "Drinks";
            }
            ListElement {
                name: "milk";
                amount: "1";
                price: "0.89";
                category: "Drinks";
            }
            ListElement {
                name: "wine";
                amount: "1";
                price: "0.89";
                category: "Drinks";
            }
            ListElement {
                name: "beer";
                amount: "1";
                price: "0.89";
                category: "Drinks";
            }
            ListElement {
                name: "bread";
                amount: "1";
                price: "0.89";
                category: "Food";
            }
            ListElement {
                name: "rice";
                amount: "1";
                price: "0.89";
                category: "Food";
            }
            ListElement {
                name: "pasta";
                amount: "1";
                price: "0.89";
                category: "Food";
            }
            ListElement {
                name: "cheese";
                amount: "1";
                price: "0.89";
                category: "Food";
            }
            ListElement {
                name: "sausages";
                amount: "1";
                price: "0.89";
                category: "Food";
            }
            ListElement {
                name: "potatoes";
                amount: "1";
                price: "0.89";
                category: "Food";
            }
            ListElement {
                name: "meat";
                amount: "1";
                price: "0.89";
                category: "Food";
            }
            ListElement {
                name: "eggs";
                amount: "1";
                price: "0.89";
                category: "Food";
            }
            ListElement {
                name: "tomatoes";
                amount: "1";
                price: "0.89";
                category: "Food";
            }
            ListElement {
                name: "paprika";
                amount: "1";
                price: "0.89";
                category: "Food";
            }
            ListElement {
                name: "salad";
                amount: "1";
                price: "0.89";
                category: "Food";
            }
            ListElement {
                name: "apples";
                amount: "1";
                price: "0.89";
                category: "Food";
            }
            ListElement {
                name: "bananas";
                amount: "1";
                price: "0.89";
                category: "Food";
            }
            ListElement {
                name: "oranges";
                amount: "1";
                price: "0.89";
                category: "Food";
            }
            ListElement {
                name: "shower gel";
                amount: "1";
                price: "0.89";
                category: "Hygiene";
            }
            ListElement {
                name: "hair shampoo";
                amount: "1";
                price: "0.89";
                category: "Hygiene";
            }
            ListElement {
                name: "shaving foam";
                amount: "1";
                price: "0.89";
                category: "Hygiene";
            }
            ListElement {
                name: "deodorant";
                amount: "1";
                price: "0.89";
                category: "Hygiene";
            }
            ListElement {
                name: "hand lotion";
                amount: "1";
                price: "0.89";
                category: "Hygiene";
            }
            ListElement {
                name: "dish detergent";
                amount: "1";
                price: "0.89";
                category: "Household goods";
            }
            ListElement {
                name: "household detergent";
                amount: "1";
                price: "0.89";
                category: "Household goods";
            }
            ListElement {
                name: "washing powder";
                amount: "1";
                price: "0.89";
                category: "Household goods";
            }
            ListElement {
                name: "toilet paper";
                amount: "1";
                price: "0.89";
                category: "Household goods";
            }
            ListElement {
                name: "handkerchiefs";
                amount: "1";
                price: "0.89";
                category: "Household goods";
            }
        }

        ListModel {
            id: lvShoppingDrinksSelectionModel
        }

        Component {
            id: drinkModelDelegate
            Text {
                text: name
                font.family: "Arial"
                font.pointSize: 16
                width: parent.width
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        lvShoppingDrinks.currentIndex = index;
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
            id: lvShoppingDrinks
            objectName: "lvShoppingDrinks"
            anchors {
                top: parent.top
                bottom: parent.bottom
                leftMargin: 0
                rightMargin: 0
                topMargin: 160
                bottomMargin: 160
            }
            width: screen.width / 3
            model: lvShoppingDrinksModel
            x: screen.width / 2 - lvShoppingDrinks.width + 10

            delegate: drinkModelDelegate
            section.property: "category"
            section.criteria: ViewSection.FullString
            section.delegate: sectionDelegate
        }

        Button {
            width: lvShoppingDrinks.width
            height: 50
            id: itemLabel
            buttonText: i18n("Articles")
            activeHover: false
            active: lvShoppingDrinks.activeFocus
            anchors {
                bottom: lvShoppingDrinks.top
                left: lvShoppingDrinks.left
                bottomMargin: 10
            }
            onButtonClick: parent.setActiveFocus(lvShoppingDrinks)
        }

/*
############## Shopping cart
*/

        Component {
            id: drinkModelDelegateSelection
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
                        lvShoppingDrinksSelection.currentIndex = index
                    }
                }
            }
        }

        SelectionListView {
            id: lvShoppingDrinksSelection
            objectName: "lvShoppingDrinksSelection"
            anchors {
                left: lvShoppingDrinks.right
                top: parent.top
                bottom: parent.bottom
                topMargin: 160
                leftMargin: 10
            }
            width: lvShoppingDrinks.width
            model: lvShoppingDrinksSelectionModel
            delegate: drinkModelDelegateSelection
        }


        Button {
            width: lvShoppingDrinksSelection.width
            height: 50
            id: cartLabel
            buttonText: i18n("Shopping cart")
            activeHover: false
            active: lvShoppingDrinksSelection.activeFocus
            anchors {
                bottom: lvShoppingDrinksSelection.top
                left: lvShoppingDrinksSelection.left
                bottomMargin: 10
            }
            onButtonClick: parent.setActiveFocus(lvShoppingDrinksSelection)
        }

/*
############## Buttons
*/


        Button {
            id: lvCursorUp
            anchors.top: lvShoppingDrinks.bottom
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
            anchors.top: lvShoppingDrinks.bottom
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
                top: lvShoppingDrinks.bottom
                left: lvCursorDown.right
                leftMargin: 10
                topMargin: 10
            }
            onButtonClick: lvShoppingDrinks.activeFocus ? lvShoppingDrinksSelection.forceActiveFocus() : lvShoppingDrinks.forceActiveFocus()
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
                top: lvShoppingDrinks.bottom
                left: categoryLeft.right
                leftMargin: 10
                topMargin: 10
            }
            onButtonClick: lvShoppingDrinks.activeFocus ? lvShoppingDrinksSelection.forceActiveFocus() : lvShoppingDrinks.forceActiveFocus()
        }
        Button {
            width: 50
            height: 50
            id: decreaseAmount
            buttonText: "-"
            shortcut: Qt.Key_Minus
            spokenText: true
            anchors {
                top: lvShoppingDrinks.bottom
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
            buttonText: "+"
            shortcut: Qt.Key_Plus
            spokenText: true
            anchors {
                top: lvShoppingDrinks.bottom
                left: decreaseAmount.right
                leftMargin: 10
                topMargin: 10
            }
            onButtonClick: parent.addAmount()
        }
        Button {
            width: lvCursorUp.width
            height: 50
            id: drinkDeselect
            buttonText: i18n("Order")
            spokenText: true
            shortcut: Qt.Key_Enter
            buttonLayout: Qt.Horizontal
            buttonImage: "../img/Button_Anfragen_Bestellung.png"
            horizontalIconAlign: "left"
            anchors {
                top: lvShoppingDrinks.bottom
                left: addAmount.right
                leftMargin: 10
                topMargin: 10
            }
        }
    }
}
