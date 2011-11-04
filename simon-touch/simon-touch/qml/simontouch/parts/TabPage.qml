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

     function setOpacities() {
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

     SideButton {
         id: btBack
         x: 1
         y: -11
         width: 240
         height: 100
         buttonText: qsTr("Back")
         buttonImage: ("../img/back.png")
         opacity: backAvailable && tabWidget.opacity
         onButtonClick: back()
         spokenText: true
     }
 }
