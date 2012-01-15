var buttons = new Array;
//console.debug("Initializing array")

function addButton(btn) {
//    console.debug("Adding button: "+btn + " " + buttons.length + " "+buttons)
    buttons.push(btn)
}

function relayKey(key) {
//    console.debug("Relaying key: "+key+" buttons length: "+buttons.length)
    for (var i=0; i < buttons.length; i++)
        if (buttons[i].handleKey(key))
            return true
    return false
}
