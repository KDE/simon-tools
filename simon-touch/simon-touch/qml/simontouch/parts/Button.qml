import QtQuick 1.1

Rectangle {
    id: button
    property int shortcut

    signal buttonClick()

    function registerInPage(page) {
        if (simonTouch.componentName(page).indexOf("Page") === 0)
            page.registerButton(button)
        else {
            if (page.parent)
                registerInPage(page.parent)
        }
    }

    function handleKey(key) {
//        console.debug("Handling key: "+key+shortcut)
        if (key == shortcut) {
            buttonClick()
            return true
        }
        return false
    }

    Component.onCompleted: {
        registerInPage(parent)
    }
}
