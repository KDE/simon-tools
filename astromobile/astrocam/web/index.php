<?php
echo implode(file("ui.html"), "");
//tell vlc to start streaming
system("qdbus --system info.echord.Astromobile.AstroLogic /AstroLogic info.echord.Astromobile.AstroLogic.startWebVideo");
?>
