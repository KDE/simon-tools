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

        ListModel {
            id: lvShoppingDrinksModel
            ListElement {
                type: "Mineralwasser prickelnd"
                count: 1
            }
            ListElement {
                type: "Orangensaft"
                count: 1
            }
            ListElement {
                type: "Mineralwasser kohlensäurefrei"
                count: 1
            }
            ListElement {
                type: "Bier"
                count: 1
            }
            ListElement {
                type: "Wein"
                count: 1
            }
            ListElement {
                type: "Brot"
                count: 1
            }
        }

        ListModel {
            id: lvShoppingDrinksSelectionModel
        }

        Component {
            id: drinkModelDelegate
            Text {
                text: type
                font.family: "Arial"
                font.pointSize: 16
                width: parent.width
//                anchors.verticalCenter: parent.verticalCenter
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        lvShoppingDrinks.currentIndex = index;
                    }
                }
            }
        }

        SelectionListView {
            id: lvShoppingDrinks
            objectName: "lvShoppingDrinks"

            anchors {
                left: parent.left
//                right: parent.right
                top: parent.top
                bottom: parent.bottom
                margins: 160
                rightMargin: 0
//                bottomMargin: 200
            }
            width: screen.width / 2 - 210
            model: lvShoppingDrinksModel
            delegate: drinkModelDelegate
        }

        function selectCurrentItem (inputModel, outputModel, inputLv, outputLv) {
            console.debug(inputModel.currentIndex);
            console.debug(inputModel+" : " + outputModel);
            outputModel.append({"type":inputModel.get(inputLv.currentIndex).type,"count":inputModel.get(inputLv.currentIndex).count});
            inputModel.remove(inputLv.currentIndex);
        }

        function addAmount (model, modelLv) {
            model.set(modelLv.currentIndex, {"count": ++model.get(modelLv.currentIndex).count})
        }

        function decreaseAmount (model, modelLv) {
            if (model.get(modelLv.currentIndex).count > 1) model.set(modelLv.currentIndex, {"count": --model.get(modelLv.currentIndex).count})
            else drinkDeselect.buttonClick()
        }

        Component {
            id: drinkModelDelegateSelection
            Item {
                width: parent.width
                height: 30
                Text {
                    text: type
                    font.family: "Arial"
                    font.pointSize: 16
                    anchors.left: parent.left
                }
                Text {
                    text: count
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
            spacing: 10
            anchors {
//                left: parent.left
                right: parent.right
                top: parent.top
                bottom: parent.bottom
                margins: 160
                rightMargin: 0
//                bottomMargin: 200
            }
            width: screen.width / 2 - 210
            model: lvShoppingDrinksSelectionModel
            delegate: drinkModelDelegateSelection
        }
        Button {
            width: 200
            height: 50
            buttonText: qsTr("Select")
            anchors {
                top: lvShoppingDrinks.bottom
                left: lvShoppingDrinks.left
            }
            onButtonClick: parent.selectCurrentItem(lvShoppingDrinksModel, lvShoppingDrinksSelectionModel, lvShoppingDrinks, lvShoppingDrinksSelection)
        }
        Button {
            width: 200
            height: 50
            id: drinkDeselect
            buttonText: qsTr("Deselect")
            anchors {
                top: lvShoppingDrinks.bottom
                right: lvShoppingDrinksSelection.right
            }
            onButtonClick: parent.selectCurrentItem(lvShoppingDrinksSelectionModel, lvShoppingDrinksModel, lvShoppingDrinksSelection, lvShoppingDrinks)
        }
        Button {
            width: 50
            height: 50
            id: addAmount
            buttonText: qsTr("+1")
            anchors {
                top: lvShoppingDrinks.bottom
                right: drinkDeselect.left
                rightMargin: 10
            }
            onButtonClick: parent.addAmount(lvShoppingDrinksSelectionModel, lvShoppingDrinksSelection)
        }
        Button {
            width: 50
            height: 50
            id: decreaseAmount
            buttonText: qsTr("-1")
            anchors {
                top: lvShoppingDrinks.bottom
                right: addAmount.left
                rightMargin: 10
            }
            onButtonClick: parent.decreaseAmount(lvShoppingDrinksSelectionModel, lvShoppingDrinksSelection)
        }
    }
}
