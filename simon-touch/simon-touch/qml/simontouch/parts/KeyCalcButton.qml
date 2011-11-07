import QtQuick 1.1

Item {
    id: btKeyCalcButton
    property alias btKeyCalcButtonText: btInternal.buttonText
    property alias btKeyCalcButtonImage: btInternal.buttonImage
    property alias spokenText: btInternal.spokenText

    property alias shortcut: btInternal.shortcut

    signal buttonClick()
    state: "collapsed"

    states: [
        State {
            name: "collapsed"
            PropertyChanges {
                target: btKeyCalcButton
                width: 242
                height: 90
            }
        },
        State {
            name: "open"
            PropertyChanges {
                target: btKeyCalcButton
                width: 800
                height: 350
                x: 112
            }
        }
    ]

    transitions: Transition {
        NumberAnimation { properties: "x,width,height"; easing.type: Easing.InOutBounce }
    }

    SideButton {
        id: btInternal
        x: 0
        y: 1
        width: parent.width - 2
        height: parent.height + 10
        onButtonClick: {
            btKeyCalcButton.state = (btKeyCalcButton.state == "collapsed") ? "open" : "collapsed";
            btKeyCalcButton.buttonClick()
        }
    }
}
