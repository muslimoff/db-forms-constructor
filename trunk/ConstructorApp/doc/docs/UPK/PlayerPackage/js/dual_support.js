/*--
Copyright © 1998, 2009, Oracle and/or its affiliates.  All rights reserved.
--*/

var dual_monitor_supported = false;

//defines
var SM_CYCAPTION=19;
var SM_CXFRAME=4;
var SM_CYFRAME=4;
var SM_CYHSCROLL=16;
var SM_CXVSCROLL=16;


function GetDualMonitor()
{
	primarydisplay=true;

	if (dual_monitor_supported)
	{
		var testwindow=window.open("","","width=10,height=10");
		twscreenX=(testwindow.screenX!=null ? testwindow.screenX : testwindow.screenLeft)
		twscreenY=(testwindow.screenY!=null ? testwindow.screenY : testwindow.screenTop)
		if (twscreenX<0 || twscreenX>this.screen.width)
			primarydisplay=false;
		if (twscreenY<0 || twscreenY>this.screen.height)
			primarydisplay=false;
		testwindow.close();
	}

	var features="";
	if (primarydisplay)
	{
		features="fullscreen=1";
	}
	else
	{
		sw=window.screen.availWidth-2*SM_CYFRAME;				// screen width
		sh=window.screen.availHeight-2*SM_CYFRAME-SM_CYCAPTION;	// screen height
		features="top=0,left=0,width="+sw+",height="+sh;
	}
	return features;
}