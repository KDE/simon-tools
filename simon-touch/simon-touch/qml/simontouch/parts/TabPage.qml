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

     onCurrentChanged: setOpacities()
     Component.onCompleted: {
         for (var i = 2; i < tabWidget.children.length; ++i) /*skip text*/
             tabWidget.children[i].showScreen.connect(setScreen)

         setOpacities()
     }

     function setOpacities() {
         for (var i = 0; i < tabWidget.children.length; ++i) {
             if (tabWidget.children[i] == btBack)
                 continue;

             if (tabWidget.children[i].objectName == current) {
                 tabWidget.children[i].opacity = 1

                 tabWidget.title = tabWidget.children[i].title
             } else {
                 tabWidget.children[i].opacity = 0
             }
         }
     }


     BackButton {
         id: btBack
         x: 1
         y: 0
         opacity: backAvailable && tabWidget.opacity
         onButtonClick: back()
     }


     Keys.onPressed: {
         if (event.key == Qt.Key_Escape) {
             back()
             event.accepted = true
         }
     }
 }
