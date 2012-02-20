<?php
echo implode(file("ui.html"), "");

//tell astrologic to start streaming
$dbus = new Dbus(Dbus::BUS_SYSTEM);
$proxy = $dbus->createProxy("info.echord.Astromobile.AstroLogic",
"/AstroLogic",
"info.echord.Astromobile.AstroLogic");

$proxy->startWebVideo();
// system("qdbus --system info.echord.Astromobile.AstroLogic /AstroLogic info.echord.Astromobile.AstroLogic.startWebVideo");
?>
