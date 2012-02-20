<?php
$content = implode(file("ui.html"), "");

//tell astrologic to start streaming
$dbus = new Dbus(Dbus::BUS_SYSTEM);
$proxy = $dbus->createProxy("info.echord.Astromobile.AstroLogic",
				"/AstroLogic",
				"info.echord.Astromobile.AstroLogic");
$proxy->startWebVideo();

//display locations for navigation requests
$locations = $proxy->getLocations();

$locationSelector = '<select name="location" id="locationSelector">';
foreach ($locations->getData() as $loc) 
  $locationSelector .= '<option value="'.$loc.'" >'.$loc.'</option>';

$locationSelector .= '</select>';

$content = preg_replace("/{{locationselector}}/i", $locationSelector, $content);
echo $content;
?>
