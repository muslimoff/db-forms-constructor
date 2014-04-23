/*--
Copyright © 1998, 2009, Oracle and/or its affiliates.  All rights reserved.
--*/


var appOpened = true;
var oPopup;
var oPopBody;
var i = 0; 
var constPad = 8;
var popHeight = 400;
var popWidth = 275;
var currentPos=0;
var MainTopPos;
var MainLeftPos;
var newwindow = '';
var isIE = (navigator.appName.indexOf("Microsoft") != -1) ? true : false;
var popupVersion = false;

var pss = document.location.hash.substring(1);
var pstrArgs = pss.split("&");
if (pstrArgs.length == 0 || pstrArgs[0] == "") {
    pss = document.location.search.substring(1);
    pstrArgs = pss.split("&");
}
if (pstrArgs.length == 1) {
    if (pstrArgs[0].toLowerCase().substr(0, 3) == "su=") {
        safeUriMode = true;
        var ps = Gkod.Escape.SafeUriUnEscape(pstrArgs[0].substr(3));
        pstrArgs = ps.split("&");
    }
}

for (var i = 0; i < pstrArgs.length; i++) {
    if (pstrArgs[i].substr(0, 6).toLowerCase() == "popup=") {
        popupVersion = true;
    }
}
var isIE55;
var TopPos;
var LeftPos;
if (isIE && popupVersion) {
    TopPos = screen.availHeight - popHeight - constPad;
    LeftPos = screen.availWidth - popWidth - constPad;
}
else {
    TopPos = window.screenTop != undefined ? window.screenTop : window.screenY;
    LeftPos = window.screenLeft != undefined ? window.screenLeft : window.screenX;
}
var TaskBarHeight = 0;
var idPostFix = '';
var eventTarget = null;

//Detects the IE version
if (isIE && popupVersion) {
	var appVerArray = navigator.appVersion.split(";");
	var appVer = appVerArray[1];
	appVer = appVer.substr(6)
	appVer = parseFloat(appVer);
	isIE55 = (appVer>=5.5) ? true : false;
}
else{
	isIE55 = false;
	constPad = 12;
	TaskBarHeight = 25;
	TopPos = TopPos  - TaskBarHeight
}

//Creates the popup if IE 5.5 or higher
if (isIE && popupVersion) oPopup = window.createPopup();
else oPopup = window;

if (!(isIE && popupVersion)) idPostFix = 'FF';

//used to grab elements regardless of browser
function getID(ID){
	if(document.all){
		return document.all(ID);
	}
	else{
		return document.getElementById(ID);
	}
}

function oPopup_show(l,t,w,h,hide) {
    if (!popHidden && isIE && popupVersion)
	{
		oPopup.show(l,t,w,h);
		if(fatPlayer)
		{
			var s = "X="+ l + "&Y=" + t + "&W=" + w + "&H=" +h;
			FatPlayerCommand("WINDOW_MOVED",s);
		}
		if(!hide)
		{
			LeftPos = oPopup.document.parentWindow.screenLeft;
			TopPos = oPopup.document.parentWindow.screenTop;
		}

	}
}

//Used by the popup only.  Reloads the Popup if it is hidden
function RePop() {
    if (window.screenLeft >= -1000 && window.screenTop >= -1000 && isIE && popupVersion) {
		if(!popHidden&&!oPopup.isOpen&&appOpened){
			oPopup_show(LeftPos, TopPos, popWidth, popHeight);
		}
	}
}
//Initializes all of the popups Attributes
function InitPopUp() {
    if (isIE && popupVersion) {
        oPopBody = oPopup.document.body;
        oPopBody.innerHTML = getID("oContextHTML0").innerHTML;
        oPopBody.ondragstart = EventCancel;
    }
    else {
        oPopBody = document.body;
        document.getElementById("noPopupFF").style.display = "inline";
        if (isIE) {
            oPopBody.onmousedown = EventCancel
            oPopBody.ondragstart = EventCancel;
            Get_Element("cameraFF").onmousedown = function() { SSEH(this); }
            Get_Element("giSplitter").onmousedown = function() { GGGSplitD(this); }
            window.onresize = GICloseAction;
        }
        else {
        oPopBody.addEventListener("mousedown", function(event) { EventCancel(event); }, false);
        window.addEventListener("resize", GICloseAction, true);
            Get_Element("cameraFF").addEventListener("mousedown", SSEH, true);
            Get_Element("giSplitter").addEventListener("mousedown", GGGSplitD, true);
        }
        window.onbeforeunload = closeAp;
    }
	oPopBody.oncontextmenu = EventCancel;
	if (GIbgcolor) oPopBody.style.backgroundColor = GIbgcolor;
	else oPopBody.style.backgroundColor ="#FEFECE";
	oPopBody.style.color = "black";
	if (isIE && popupVersion) {
	    oPopBody.style.border = "solid black 3px";
	    oPopBody.style.borderBottomWidth = "2px";
	}
	oPopBody.aLink = "blue";
	oPopBody.vLink = "blue";
	if (isIE && popupVersion) {
	    oPopBody.attachEvent("onmousemove", BodyMove);
	    oPopBody.attachEvent("onmousedown", GISizePopup);
	}
	SendEventToHemiFFButtonPlugin();
	oPopup_show(LeftPos, TopPos, popWidth, popHeight);
}
//This will load the initial page
var PopIV = null;
var noStart = false;
function Load() {
    //	GetCorrectImage();

    if (!Sound_Init(PlaySound, UserPrefs.PlayAudio, "GIClosePlayer()")) {
        noStart = true;
        return;
    }
    GINoCookieSave = false;

	InitPopUp();
	if (isIE && popupVersion) {
	    PopIV = setInterval(RePop, 250);
	}
//	window.blur();

}

var resizdir = 0;
var resizbdown = false;
function BodyMove()
{
//alert("hello")
	var e = oPopBody.document.parentWindow.event;
//	GIInfoFrame.innerHTML=GICamera.scrollLeft + ",,," + GICamera.scrollTop
	if(e.srcElement.id=="movePopup" && !resizbdown)
	{
		resizdir="move"
		return;
	}
	if((e.srcElement.id=="resizeSE" || ((e.clientX>=popWidth-3 && e.y>=popHeight-15) || (e.clientX>=popWidth-15 && e.y>=popHeight-3))) && !resizbdown)
	{
		oPopBody.style.cursor="se-resize";
		resizdir="se"
		return;
	}
	if(((e.clientX <=3 && e.clientY<=15) || (e.clientY <=3 && e.clientX<=15)) && !resizbdown)
	{
		oPopBody.style.cursor="nw-resize";
		resizdir="nw"
		return;
	}
	if(((e.clientX <=3 && e.clientY>=popHeight-15) || (e.clientY >=popHeight-3 && e.clientX<=15)) && !resizbdown)
	{
		oPopBody.style.cursor="sw-resize";
		resizdir="sw"
		return;
	}
	if(((e.clientX >=popWidth-15 && e.clientY<=3) || (e.clientY <=15 && e.clientX>=popWidth-3)) && !resizbdown)
	{
		oPopBody.style.cursor="ne-resize";
		resizdir="ne"
		return;
	}
	if(e.clientY >=popHeight-3 && !resizbdown)
	{
		oPopBody.style.cursor="s-resize";
		resizdir="s"
		return;
	}
	if(e.clientX >=popWidth-3 && !resizbdown)
	{
		oPopBody.style.cursor="e-resize";
		resizdir="e"
		return;
	}
	if(e.clientX <=3 && !resizbdown)
	{
		oPopBody.style.cursor="w-resize";
		resizdir="w"
		return;
	}
	if(e.clientY <=3 && !resizbdown)
	{
		oPopBody.style.cursor="n-resize";
		resizdir="n"
		return;
	}
	oPopBody.style.cursor="auto";
	if(!resizbdown)
	{
		resizdir = 0;
//			oPopBody.detachEvent("onmousedown",GISizePopup);
//			window.status="detach"
	}
	
}

var captobj = null;
var doresize = false;
var rIV = null;
function GIResize()
{
	doresize = true;
}

function GISizePopup()
{
	if(!resizdir) return;
	var e = oPopup.document.parentWindow.event;
	if (e.button != 1) return;
	var s = e.type;
	if (s == "mousedown" && e.button == 1) 
	{
		captobj = e.srcElement;
		resizeStartPos = { left: LeftPos - e.screenX, width: popWidth + e.screenX, width2: popWidth - e.screenX, right: LeftPos + popWidth, top: TopPos - e.screenY, height: popHeight + e.screenY, height2: popHeight - e.screenY, bottom: TopPos + popHeight}
		resizbdown = true;
		captobj.setCapture();
		rIV = setInterval(GIResize,15)
		captobj.attachEvent("onmousemove",GISizePopup);
		captobj.attachEvent("onmouseup",GISizePopup);
		return;
	}
	if (s == "mouseup") {
		if(systemEnableCookies && GICookie && GICookie != null)
		{
			GICookie["Cleft"]=LeftPos;
			GICookie["Ctop"]=TopPos;
			GICookie["Cwidth"]=popWidth;
			if(ScreenshotVisible) GICookie["Cheight"]=popHeight;
			else GICookie["Cheight"]=popHeight + SavedSSHeight;
//			GICookie["s1"]=oPopup.document.getElementById("split1").style.height;
//			GICookie["s2"]=oPopup.document.getElementById("split2").style.height;
			GICookie["Csss"]=ScreenshotVisible+1;
			GICookie.Store()
		}

		resizbdown = false;
		clearInterval(rIV);
		captobj.detachEvent("onmousemove",GISizePopup);
		captobj.detachEvent("onmouseup",GISizePopup);
		captobj.releaseCapture();
//			window.status="up"
		resizeStartPos = null;
		return;
	}
	if (!resizeStartPos || !doresize)
		return;

	doresize = false;
	switch (resizdir)
	{
		case "move":
			LeftPos = resizeStartPos.left + e.screenX;
			TopPos = resizeStartPos.top + e.screenY;
			break;
		case "se":
			popHeight = resizeStartPos.height2 + e.screenY;
			popWidth = resizeStartPos.width2 + e.screenX;
			if (LeftPos + popWidth > screen.width) popWidth = screen.width - LeftPos;
			if (TopPos + popHeight > screen.height) popHeight = screen.height - TopPos;
			break;
		case "ne":
			popHeight = resizeStartPos.height - e.screenY;
			popWidth = resizeStartPos.width2 + e.screenX;
			TopPos = resizeStartPos.top + e.screenY;
			if(TopPos < 0) popHeight = resizeStartPos.bottom;
			if(TopPos + 200 > resizeStartPos.bottom) TopPos = resizeStartPos.bottom - 200;
			if (LeftPos + popWidth > screen.width) popWidth = screen.width - LeftPos;
			break;
		case "nw":
			popWidth = resizeStartPos.width - e.screenX;
			LeftPos = resizeStartPos.left + e.screenX;
			popHeight = resizeStartPos.height - e.screenY;
			TopPos = resizeStartPos.top + e.screenY;
			if(LeftPos < 0) popWidth = resizeStartPos.right;
			if(TopPos < 0) popHeight = resizeStartPos.bottom;
			if(LeftPos + 150 > resizeStartPos.right) LeftPos = resizeStartPos.right - 150;
			if(TopPos + 200 > resizeStartPos.bottom) TopPos = resizeStartPos.bottom - 200;
			break;
		case "sw":
			popHeight = resizeStartPos.height2 + e.screenY;
			popWidth = resizeStartPos.width - e.screenX;
			LeftPos = resizeStartPos.left + e.screenX;
			if (TopPos + popHeight > screen.height) popHeight = screen.height - TopPos;
			if(LeftPos + 150 > resizeStartPos.right) LeftPos = resizeStartPos.right - 150;
			if(LeftPos < 0) popWidth = resizeStartPos.right;
			break;
		case "w":
			popWidth = resizeStartPos.width - e.screenX;
			LeftPos = resizeStartPos.left + e.screenX;
			if(LeftPos + 150 > resizeStartPos.right) LeftPos = resizeStartPos.right - 150;
			if(LeftPos < 0) popWidth = resizeStartPos.right;
			break;
		case "n":
			popHeight = resizeStartPos.height - e.screenY;
			TopPos = resizeStartPos.top + e.screenY;
			if(TopPos + 200 > resizeStartPos.bottom) TopPos = resizeStartPos.bottom - 200;
			if(TopPos < 0) popHeight = resizeStartPos.bottom;
			break;
		case "e":
			popWidth = resizeStartPos.width2 + e.screenX;
			if (LeftPos + popWidth > screen.width) popWidth = screen.width - LeftPos;
			break;
		case "s":
			popHeight = resizeStartPos.height2 + e.screenY;
			if (TopPos + popHeight > screen.height) popHeight = screen.height - TopPos;
			break;
	}
	if (ScreenshotVisible) 
	{
		if (popHeight < 200)
			popHeight = 200;
	}
	else
	{
		if (popHeight < 129)
			popHeight = 129;
	}	
	if (popWidth < 150)
		popWidth = 150;

	if(ScreenshotVisible)
	{
		var s1 = oPopup.document.getElementById("split1");
		var s2 = oPopup.document.getElementById("split2");
		var yd = s1.clientHeight;
		if(yd < 78) yd = 78;
		var sy = s1.clientHeight + s2.clientHeight;
		yd /= sy;
		if (yd < 0.1)
			yd = 0.1;
		if (yd > 0.9)
			yd = 0.9;
		s1.style.height = (yd * 100) + "%";
		s2.style.height = ((1 - yd) * 100) + "%";
	}
//	window.status = s + LeftPos + ", " + TopPos;
//	oPopup.document.parentWindow.event.returnValue = false;
	oPopup_show(LeftPos, TopPos, popWidth, popHeight);	
//	LeftPos = oPopup.document.parentWindow.screenLeft;
//	TopPos = oPopup.document.parentWindow.screenTop;
	GITextFrame.style.width = popWidth - 29;
}

var splitState = 0;

function GGGSplitD(o)
{
    var e = isIE ? oPopBody.document.parentWindow.event : o;
    if (isIE) {
        if (!popupVersion) {
            o.onmousemove = function() { GGGSplitM(o); }
            o.onmouseup = function() { GGGSplitU(o); } 
        }
        o.setCapture();
    }
    else {
        eventTarget = e.currentTarget;
        var ldiv = Get_Element("EventListenerDIV");
        ldiv.style.cursor = "n-resize";
        ldiv.style.zIndex = 4;
        ldiv.addEventListener("mousemove", function(event) { GGGSplitM(event); }, true);
        ldiv.addEventListener("mouseup", function(event) { GGGSplitU(event); }, true);
    }
	splitState = 1;
}

function GGGSplitM(o)
{
    var e = isIE ? oPopBody.document.parentWindow.event : o;

    if (splitState) {
        var yd = e.clientY;
        var s1 = oPopup.document.getElementById("split1" + idPostFix);
        var s2 = oPopup.document.getElementById("split2" + idPostFix);
        var sy = 0;
        if (isIE && popupVersion) {
            sy = s1.getBoundingClientRect().top;
            yd -= sy + 12;
        }
        else {
            sy = oPopup.document.getElementById("giTitlebarFF").clientHeight;
            if (isIE) yd -= sy + 27;
            else yd -= sy + 21;
        }
        
//		GIInfoFrame.innerHTML=yd + ",,," + sy
        if (yd < 78) yd = 78;
        sy = s1.clientHeight + s2.clientHeight;
        yd /= sy;
		if (yd < 0.1)
			yd = 0.1;
		if (yd > 0.9)
			yd = 0.9;
		s1.style.height = (yd * 100) + "%";
		s2.style.top = (yd * 100) + "%";
		s2.style.height = ((1 - yd) * 100) + "%";
	}
}

function GGGSplitU(o)
{
	if(systemEnableCookies && GICookie && GICookie != null)
	{
		GICookie["Cleft"]=LeftPos;
		GICookie["Ctop"]=TopPos;
		GICookie["Cwidth"]=popWidth;
		if(ScreenshotVisible) GICookie["Cheight"]=popHeight;
		else GICookie["Cheight"]=popHeight + SavedSSHeight;
//		GICookie["s1"]=oPopup.document.getElementById("split1").style.height;
//		GICookie["s2"]=oPopup.document.getElementById("split2").style.height;
		GICookie["Cs2"] = (isIE && popupVersion) ? oPopup.document.getElementById("split2" + idPostFix).clientHeight : oPopup.document.getElementById("split1" + idPostFix).style.height;
		GICookie["Csss"] = ScreenshotVisible + 1;
		GICookie.Store()
	}
	splitState = 0;
	if(isIE) o.releaseCapture();
	eventTarget = null;
	if (!(isIE && popupVersion)) {
	    var ldiv = Get_Element("EventListenerDIV");
	    ldiv.style.zIndex = -1;
	    ldiv.style.cursor = "default";
	    if (isIE) {
	        ldiv.onmousemove = null;
	        ldiv.onmouseup = null;
	        ldiv.releaseCapture();
	    }
	    else {
	    ldiv.removeEventListener("mousemove", function(event) { SSEH(event); }, true);
	    ldiv.removeEventListener("mouseup", function(event) { SSEH(event); }, true);
	    }
	}
}

var startPos = null;
//----Event handler for screenshot
function SSEH(o)
{
    var e = isIE ? oPopBody.document.parentWindow.event : o;
	if(!isIE) e.preventDefault();
	if (e.type == "mousedown" && e.button == 2)
	{
		clearInterval(IV);
		IV = null;
		if(hpos)
		{
			GICamera.scrollLeft = hpos.left - (GICamera.clientWidth / 2);
			GICamera.scrollTop = hpos.top - (GICamera.clientHeight / 2);
		}
		else
		{
			GICamera.scrollLeft = 0;
			GICamera.scrollTop = 0;
		}
		return;
	}
    if (e.type == "mousedown" && ((!(isIE) && e.button == 0) || (isIE && e.button == 1))) {
        var srcElement = isIE ? o : e.currentTarget;
	    clearInterval(IV);
	    IV = null;
	    startPos = { top: srcElement.scrollTop + e.screenY, left: srcElement.scrollLeft + e.screenX }
	    eventTarget = srcElement;
	    var ldiv = Get_Element("EventListenerDIV");
	    ldiv.style.cursor = "move";
	    ldiv.style.zIndex = 4;
	    if (isIE) {
//	        alert("most")
	        ldiv.onmousemove = SSEH;
	        ldiv.onmouseup = SSEH;
	        ldiv.setCapture();
	    }
	    else {
	        ldiv.addEventListener("mousemove", function(event) { SSEH(event); }, true);
	        ldiv.addEventListener("mouseup", function(event) { SSEH(event); }, true);
	    }
	    return;
	}
	if (isIE && e.type == "mousedown" && e.button == 1)
	{
		clearInterval(IV);
		IV = null;
		startPos = { top: o.scrollTop + e.screenY, left: o.scrollLeft + e.screenX }
		o.setCapture();
		return;
	}
	if(e.type == "mouseup") {
//	    alert("fel")
	    startPos = null;
		if (isIE && popupVersion) o.releaseCapture();
		eventTarget = null;
		if (!(isIE && popupVersion)) {
		    var ldiv = Get_Element("EventListenerDIV");
		    ldiv.style.zIndex = -1;
		    ldiv.style.cursor = "default";
		    if (isIE) {
		        ldiv.onmousemove = null;
		        ldiv.onmouseup = null;
		        ldiv.releaseCapture();
		    }
		    else {
		        ldiv.removeEventListener("mousemove", function(event) { SSEH(event); }, true);
		        ldiv.removeEventListener("mouseup", function(event) { SSEH(event); }, true);
		    }
		}
		return;
	}
	if (!startPos) return;
	if (isIE && popupVersion) {
	    o.scrollTop = startPos.top - e.screenY;
	    o.scrollLeft = startPos.left - e.screenX;
	}
	else {
	    eventTarget.scrollTop = startPos.top - e.screenY;
	    eventTarget.scrollLeft = startPos.left - e.screenX;
	}
	
}

var popHidden = false;
function HidePopup()
{
    if (isIE && popupVersion) {
        oPopup_show(1, 1, 1, 1, true);
        clearInterval(PopIV);
    }
    else {
        document.title = "_" + document.title;
    }
    popHidden = true;
    GIStopCHL();
}

function ShowPopup()
{
	popHidden = false;
	oPopup_show(LeftPos, TopPos, popWidth, popHeight);
	if (isIE && popupVersion) PopIV = setInterval(RePop, 250);
	else if (document.title.indexOf("_") == 0) {
	    document.title = document.title.substr(1);
	}
	if (contCHL) top.GIPlayer.GIStartIV();
}

//Closes the Popup or window
function closeAp()
{
	if(appOpened)
	{
		//ODS
		ODSCloseEvGroup();
		//ODS
		//setTimeout(closeAp2,500);
		closeAp2();
	}
}

function closeAp2()
{
    if (systemEnableCookies && GICookie && GICookie != null) {
        if (!(isIE && popupVersion)) {
            TopPos = window.screenTop != undefined ? window.screenTop : window.screenY;
            LeftPos = window.screenLeft != undefined ? window.screenLeft : window.screenX;
            popWidth = document.getElementById("noPopupFF").clientWidth;
            popHeight = document.getElementById("noPopupFF").clientHeight;
        }
        if (!GINoCookieSave) {
        GICookie["Cleft"] = LeftPos;
        GICookie["Ctop"] = TopPos;
        GICookie["Cwidth"] = popWidth;
        if (ScreenshotVisible || !(isIE && popupVersion)) GICookie["Cheight"] = popHeight;
        else GICookie["Cheight"] = popHeight + SavedSSHeight;
        //			GICookie["s1"]=oPopup.document.getElementById("split1").style.height;
        //			GICookie["s2"]=oPopup.document.getElementById("split2").style.height;
        GICookie["Csss"] = ScreenshotVisible + 1;
        GICookie.Store()
        }
    }
    clearInterval(IV);
    if (isIE && popupVersion) {
	    clearInterval(PopIV);
	    StopKeyHook();
	    oPopup.hide();
	}
	appOpened = false;
	//window.moveTo(MainLeftPos,MainTopPos)
	if (top.GIPlayer)
	top.GIPlayer.GIClosePlayer();
	if(!fatPlayer) window.close();
}

//This function is used when the popup or 
//window is closed by the user and then requested again

function SendEventToHemiFFButtonPlugin() {

//    alert("1");
    var element = document.getElementById("HTML2HemiFFButtonData");
    if (!element) {
//        alert("2");
        element = document.createElement("HTML2HemiFFButtonData");
        element.setAttribute("id", "HTML2HemiFFButtonData");
        document.documentElement.appendChild(element);
    }

    if ("createEvent" in document) {
//        alert("4");
        element.setAttribute("paramTitle", "Do It! - Mozilla Firefox");

        var evt = document.createEvent("Events");
        evt.initEvent("KeepTopMostEvent", true, false);
        element.dispatchEvent(evt);
        element.removeAttribute("paramTitle");
    }
}
