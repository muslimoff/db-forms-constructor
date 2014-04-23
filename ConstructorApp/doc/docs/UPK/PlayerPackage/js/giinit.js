/*--
Copyright © 1998, 2009, Oracle and/or its affiliates.  All rights reserved.
--*/



var GICookie = null
var GISave = true;
var GIS1 = null;
var GIS2 = null;
var GISSS = null;

function setWindow()
{

    var isIE1 = (navigator.appName.indexOf("Microsoft") != -1) ? true : false;
    if (isIE1 && popupVersion) { 
        window.resizeTo(1, 1);
	    window.moveTo(4000,4000);
	}
	    
    if(systemEnableCookies)
    {
	    GICookie =	new Cookie(document,"GICookie",365,"/",null,null)
	    var left = screen.availWidth-popWidth-constPad;
	    var top = screen.availHeight-popHeight-constPad;
	    if(GICookie.Load())
	    {
    //		alert(GICookie["left"] + "," + GICookie["top"] + "," + GICookie["width"] + "," + GICookie["height"])
	        if (isIE1 && popupVersion && GICookie["Cleft"] >= 0 && GICookie["Ctop"] >= 0 && GICookie["Cleft"] < screen.availWidth && GICookie["Ctop"] < screen.availHeight) {
	            LeftPos = parseInt(GICookie["Cleft"]);
	            TopPos = parseInt(GICookie["Ctop"]);
	            popWidth = parseInt(GICookie["Cwidth"]);
	            popHeight = parseInt(GICookie["Cheight"]);
	            //				GIS1=GICookie["s1"];
	            //			oPopup_show(LeftPos,TopPos,popWidth,popHeight);
	        }
	        GIS2 = GICookie["Cs2"];
	        GISSS = GICookie["Csss"];
	    }
    }
}

setWindow();