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
        title: qsTr("Drinks")
        anchors.fill: parent
/*
############## JS Functions
*/

        function selectCurrentItem (inputModel, outputModel, inputLv, outputLv) {
//            console.debug(inputModel.currentIndex);
//            console.debug(inputModel+" : " + outputModel);
            outputModel.append({"name":inputModel.get(inputLv.currentIndex).name,"amount":inputModel.get(inputLv.currentIndex).amount,"price":inputModel.get(inputLv.currentIndex).price,"category":inputModel.get(inputLv.currentIndex).category});
            inputModel.remove(inputLv.currentIndex);
        }

        /*
          lvShoppingDrinksModel
          lvShoppingDrinksSelectionModel
          lvShoppingDrinks
          lvShoppingDrinksSelection
          */

        function addAmount () {
            if (lvShoppingDrinks.activeFocus) {
                lvShoppingDrinksSelectionModel.append({"name":lvShoppingDrinksModel.get(lvShoppingDrinks.currentIndex).name,"amount":lvShoppingDrinksModel.get(lvShoppingDrinks.currentIndex).amount,"price":lvShoppingDrinksModel.get(lvShoppingDrinks.currentIndex).price,"category":lvShoppingDrinksModel.get(lvShoppingDrinks.currentIndex).category, "index":lvShoppingDrinks.currentIndex});
                lvShoppingDrinksModel.remove(lvShoppingDrinks.currentIndex);
            } else {
                if(lvShoppingDrinksSelection.currentIndex) {
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

            if (model.get(modelLv.currentIndex).amount > 1) model.set(modelLv.currentIndex, {"amount": --model.get(modelLv.currentIndex).amount})
        }

        function setActiveFocus(listView) {
            listView.forceActiveFocus()

        }

        function moveUp() {
            if (lvShoppingDrinks.activeFocus) {
                --lvShoppingDrinks.currentIndex
            } else {
                --lvShoppingDrinksSelection.currentIndex
            }
        }

        function moveDown() {
            if (lvShoppingDrinks.activeFocus) {
                ++lvShoppingDrinks.currentIndex
            } else {
                ++lvShoppingDrinksSelection.currentIndex
            }
        }

/*
############## Categories
*/

//        ListModel {
//            id: lvShoppingCategoryModel
//            ListElement {
//                category: "Drinks"
//            }
//            ListElement {
//                category: "Food"
//            }
//            ListElement {
//                category: "Hygiene"
//            }
//        }

//        Component {
//            id: categoryModelDelegate
//            Text {
//                text: category
//                font.family: "Arial"
//                font.pointSize: 16
//                width: parent.width
//                MouseArea {
//                    anchors.fill: parent
//                    onClicked: {
//                        lvShoppingCategory.currentIndex = index;
//                    }
//                }
//            }
//        }

//        SelectionListView {
//            id: lvShoppingCategory
//            objectName: "lvShoppingCategory"

//            anchors {
//                left: parent.left
//                top: parent.top
//                bottom: parent.bottom
//                margins: 160
//                leftMargin: 0
//                rightMargin: 0
//            }
//            width: screen.width / 2 - 310
//            model: lvShoppingCategoryModel
//            delegate: categoryModelDelegate
//            Keys.onPressed: {
//                if (activeFocus){
//                    if (event.key == Qt.Key_Right) {
//                        lvShoppingDrinks.forceActiveFocus();
//                    } else if (event.key == Qt.Key_Left) {
//                        lvShoppingDrinksSelection.forceActiveFocus();
//                    }
//                }
//            }
//        }

//        Button {
//            width: lvShoppingCategory.width
//            height: 50
//            id: categoryLabel
//            buttonText: qsTr("Category")
//            activeHover: false
//            active: lvShoppingCategory.activeFocus
//            anchors {
//                bottom: lvShoppingCategory.top
//                left: lvShoppingCategory.left
//                bottomMargin: 10
//            }
//            onButtonClick: parent.setActiveFocus(lvShoppingCategory)
////            onActiveChanged: console.debug("CategoryActive: " + categoryLabel.active)
//        }

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

//            anchors {
//                left: lvShoppingCategory.right
//                top: parent.top
//                bottom: parent.bottom
//                topMargin: 160
//                leftMargin: 10
//                rightMargin: 0
//                bottomMargin: 200
//            }
            anchors {
//                left: parent.left
                top: parent.top
                bottom: parent.bottom
//                margins: 160
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

//            Keys.onPressed: {
//                if (activeFocus){
//                    if (event.key == Qt.Key_Right) {
//                        lvShoppingDrinksSelection.forceActiveFocus();
//                    } else if (event.key == Qt.Key_Left) {
//                        lvShoppingDrinksSelection.forceActiveFocus();
//                    }
//                }
//            }
        }

        Button {
            width: lvShoppingDrinks.width
            height: 50
            id: itemLabel
            buttonText: qsTr("Articles")
            activeHover: false
            active: lvShoppingDrinks.activeFocus
            anchors {
                bottom: lvShoppingDrinks.top
                left: lvShoppingDrinks.left
                bottomMargin: 10
            }
            onButtonClick: parent.setActiveFocus(lvShoppingDrinks)
//            onActiveChanged: console.debug("ItemActive: " + itemLabel.active)
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
//            Keys.onPressed: {
//                if (activeFocus){
//                    if (event.key == Qt.Key_Right) {
//                        lvShoppingDrinks.forceActiveFocus();
//                    } else if (event.key == Qt.Key_Left) {
//                        lvShoppingDrinks.forceActiveFocus();
//                    }
//                }
//            }
        }


        Button {
            width: lvShoppingDrinksSelection.width
            height: 50
            id: cartLabel
            buttonText: qsTr("Shopping cart")
            activeHover: false
            active: lvShoppingDrinksSelection.activeFocus
            anchors {
                bottom: lvShoppingDrinksSelection.top
                left: lvShoppingDrinksSelection.left
                bottomMargin: 10
            }
            onButtonClick: parent.setActiveFocus(lvShoppingDrinksSelection)
//            onActiveChanged: console.debug("CartActive: " + cartLabel.active)
        }

/*
############## Buttons
*/


        Button {
            id: lvCursorUp
            anchors.top: lvShoppingDrinks.bottom
//            anchors.left: lvShoppingDrinks.left
            anchors.topMargin: 10
            x: screen.width / 2 - 760 / 2
            anchors.rightMargin: 10
            width: 120
            height: 50
            buttonImage: "../img/go-up.svgz"
            buttonText: qsTr("Up")
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
            buttonText: qsTr("Down")
            shortcut: Qt.Key_Down
            spokenText: true
            buttonLayout: Qt.Horizontal
            onButtonClick: parent.moveDown()
        }

        Button {
            id: categoryLeft
            width: lvCursorUp.width
            height: 50
            buttonText: qsTr("Left")
            spokenText: true
            shortcut: Qt.Key_Left
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
            buttonText: qsTr("Right")
            spokenText: true
            shortcut: Qt.Key_Right
            anchors {
                top: lvShoppingDrinks.bottom
                left: categoryLeft.right
                leftMargin: 10
                topMargin: 10
            }
            onButtonClick: lvShoppingDrinks.activeFocus ? lvShoppingDrinksSelection.forceActiveFocus() : lvShoppingDrinks.forceActiveFocus()
        }
//        Button {
//            id: selectItem
//            width: 100
//            height: 50
//            buttonText: qsTr("Select")
//            spokenText: true
//            shortcut: Qt.Key_Return
//            anchors {
//                top: lvShoppingDrinks.bottom
//                left: categoryRight.right
//                leftMargin: 10
//                topMargin: 10
//            }
//        }
        Button {
            width: 50
            height: 50
            id: decreaseAmount
            buttonText: qsTr("-")
            shortcut: Qt.Key_Minus
            spokenText: true
            anchors {
                top: lvShoppingDrinks.bottom
                left: categoryRight.right
                leftMargin: 10
                topMargin: 10
            }
            onButtonClick: parent.decreaseAmount(lvShoppingDrinksSelectionModel, lvShoppingDrinksSelection);
        }
        Button {
            width: 50
            height: 50
            id: addAmount
            buttonText: qsTr("+")
            shortcut: Qt.Key_Plus
            spokenText: true
            anchors {
                top: lvShoppingDrinks.bottom
                left: decreaseAmount.right
                leftMargin: 10
                topMargin: 10
            }
            onButtonClick: parent.addAmount(lvShoppingDrinksSelectionModel, lvShoppingDrinksSelection)
        }
        Button {
            width: lvCursorUp.width
            height: 50
            id: drinkDeselect
            buttonText: qsTr("Order")
            spokenText: true
            shortcut: Qt.Key_Backspace
            anchors {
                top: lvShoppingDrinks.bottom
                left: addAmount.right
                leftMargin: 10
                topMargin: 10
            }
        }
    }
}
