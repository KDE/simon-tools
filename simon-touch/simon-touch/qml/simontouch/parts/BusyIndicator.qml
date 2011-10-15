import QtQuick 1.0


Image {
    id: indicator
    source: "../img/busy.png";
    width: 184
    height: 184

    NumberAnimation on rotation {
        running: visible;
        from: 0;
        to: 360;
        loops: Animation.Infinite;
        duration: 1500
    }
}
