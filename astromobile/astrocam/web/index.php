<?xml version="1.0" ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Astromobile streaming server</title>


</head>
<body onload="enqueueURL()">
<p>
<?php
//tell vlc to start streaming
system("qdbus --system info.echord.Astromobile.AstroLogic /AstroLogic info.echord.Astromobile.AstroLogic.startWebVideo");
?>


<script type="text/javascript">
function enqueueURL() {
	var vlc = document.getElementById("vlc");
	if (vlc != null) {
		vlc.playlist.stop();
	}
	setTimeout("startPlayback()",3000)
}
function startPlayback() {
	var vlc = document.getElementById("vlc");
	if (vlc != null) {
		vlc.playlist.play();
	}
	var wmp = document.getElementById("movie");
	if (wmp != null) {
		wmp.controls.play();
	}
}
</script>

<!--[if IE]>
<object classid="clsid:6BF52A52-394A-11d3-B153-00C04F79FAA6"
          type="application/x-oleobject" width="640" height="480" id="movie">
<param name="uiMode" value="none"/>
<param name="autostart" value="0"/>
<param name="scale" value="tofit"/>
<param name="URL" value="mms://192.168.0.102:8080/webcam"/>
</object>
<![endif]-->

<!--[if !IE]><!-->
<div style="height:480px; overflow: hidden">
<object type="application/x-vlc-plugin" pluginspage="http://www.videolan.org"
	version="VideoLAN.VLCPlugin.2" id="vlc" width="640" height="513" events="True" >
<param name="volume" value="50" />
<param name="autoplay" value="true" />
<param name="loop" value="true" />
<param name="fullscreen" value="false" />
<param name="mrl" value="mmsh://192.168.0.102:8080/webcam" />
</object>
</div>

<!--<![endif]-->
</p>

</body>
<html>
