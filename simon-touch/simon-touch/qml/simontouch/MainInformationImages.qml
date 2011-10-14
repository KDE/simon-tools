import QtQuick 1.1
import "parts"

TabPage {
    objectName: "MainInformationImages"
    Page {
        title: qsTr("Images")
        anchors.fill: parent

        Item {
            id: leftColumn
            width: 250
            height: 200
            anchors {
                left: parent.left
                top: parent.top
                bottom: parent.bottom
                topMargin: 120
                leftMargin: 50
                bottomMargin: 120
            }


            SelectionListView {
                id: lvImages
                objectName: "lvImages"

                model: imagesModel

                delegate:
                    Image {
                        id: delegate;
                        width: parent.width
                        height: 130
                        source: filePathRole
                        fillMode: Image.PreserveAspectFit
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                lvImages.currentIndex = index
                            }
                        }
                    }

                onCurrentItemChanged: imImage.source = currentItem.source

            }
        }

        Image {
            id: imImage
            anchors.left: leftColumn.right
            anchors.leftMargin: 20
            anchors.top: leftColumn.top
            anchors.right: parent.right
            anchors.bottom: leftColumn.bottom
            anchors.rightMargin: 50
            fillMode: Image.PreserveAspectFit
            smooth: true
        }
    }
}
