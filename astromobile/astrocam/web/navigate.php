<?php
$dbus = new Dbus(Dbus::BUS_SYSTEM);
$proxy = $dbus->createProxy("info.echord.Astromobile.AstroLogic",
				"/AstroLogic",
				"info.echord.Astromobile.AstroLogic");

if (($_POST['location'] == "User") && ($proxy->navigateToUser()) || 
      ($proxy->navigateTo($_POST['location'])))
  echo "OK";
else
  echo "FAILED";
?>

