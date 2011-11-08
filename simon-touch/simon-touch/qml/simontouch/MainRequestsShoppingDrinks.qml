import QtQuick 1.1
import "parts"

TabPage {
    id: screen
    objectName: "MainRequestsShoppingDrinks"
    stateName: "RequestsShoppingDrinks"

    Page {
        stateName: parent.stateName
        title: qsTr("Drinks")

        ListModel {
            id: drinkModel
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
        }

        Component {
            id: drinkModelDelegate
            Text {
                text: type
            }
        }

        SelectionListView {
            id: lvShoppingDrinks
            objectName: "lvShoppingDrinks"
            anchors {
                left: parent.left
                right: parent.right
                top: parent.top
                bottom: parent.bottom
                margins: 160
                bottomMargin: 200
            }
            model: drinkModel
            delegate: drinkModelDelegate
        }

    }
}
