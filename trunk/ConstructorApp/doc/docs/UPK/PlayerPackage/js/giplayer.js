/*--
Copyright © 1998, 2009, Oracle and/or its affiliates.  All rights reserved.
--*/



var GIFrames = new Object;
var GIState = null;
var GIFrameCC =null;
var GIActionCC =null;
var GIAdvText = null;
var GIScreenshot = null;
var GIHighlight = null;
var GICamera = null;
var GITextFrame = null;
var GIInfoFrame = null;
var GIFirstFrame = null;
var GIPlayer = null;
var GIActAction	= null;
var GIPrevType = null;
var GINextState = null;
var GIAltIndex = 0;
var GIOnLoad = false;
var GINoCookieSave = true;
var ActMenu = null;
var concepts = new Array();
var GIHistory = new Array();
var PlaySound = false;
var SoundAvail = false;
var AudioAction = null;
var P_GIRESOURCES = "";
var GITMEnabled = false;
var GIDMEnabled = false;
var GITemplateSet = null;
var isPrevTemplate = false;
var GIbgcolor = null;
var playMode = "D"

var fatSSPath = "";
var fatTSPath = "";
var fatPlayer = null;
var param_ctx = "";
var param_ecid = "";
var param_printitname="";
var param_fastdoit= false;
var gicontextID = null;
var screenNames = new Array();

var tutorialMode = false;
var safeUriMode = false;
var mViewOutline = false;


P_GIRESOURCES =	"../../img/";

//defines
var SM_CYCAPTION=19;
var	SM_CXFRAME=4;
var SM_CYFRAME=4;
var SM_CYHSCROLL=16;
var SM_CXVSCROLL=16;

//-----   Frame types: "normal", "decision", "start", "end"
function GIFrame(id,sspath,type,header)
{
    if (header) header = header.replace(/&amp;/g, '&');
	GIFrameCC = { actions: new Array, infoblocks: new Array, sspath: sspath, type: type, header: header };
	screenNames[screenNames.length] = id;
	GIFrames[id] = GIFrameCC;
}

function GIAction(id, next, ctx, ecidarray, text, dn, icon, bcolor, input)
{
	GIActionCC = {id: id, next: next, ctx: ctx, ecidarray: ecidarray, text: text, dn: dn, icon: icon, bcolor:bcolor, input:(fixInputString(input)), hotspots: new Array};
	if (GIActionCC.ecidarray)
	{
		for (var i=0;i<GIActionCC.ecidarray.length;i++)
		{
			s=GIActionCC.ecidarray[i];
			var k=s.indexOf('$');
			sapp=s.substr(0,k+1);
			sctx=MyEscape(s.substr(k+1));
			s=sapp+sctx;
			GIActionCC.ecidarray[i]=s;
		}
	}
	GIFrameCC.actions.push(GIActionCC);
}

function InfoBlock(buttonfile,url,tooltip,infotype,infokey)
{
    if (!tooltip) tooltip = "undefined";
    else {
        tooltip = tooltip.replace(/"/g, '&quot;');
        tooltip = tooltip.replace(/&amp;/g, '&');
    }
	_buttonfile=buttonfile;
	_img="infobitmapimage.gif";
	_sb=buttonfile.toLowerCase();
	if (_sb.substr(_sb.length-_img.length)==_img)
	{
		_buttonfile=buttonfile.substr(0,_sb.length-_img.length) + _img;
	}
	GIFrameCC.infoblocks.push({buttonfile: _buttonfile,url: url,tooltip: tooltip,infotype: infotype,infokey: infokey})
};

function GIInfoBlock(src,icon,alt)
{
	GIFrameCC.infoblocks.push({src: src, icon: icon, alt: alt});
}

function GIHotspot(left, top, right, bottom, explanation)
{
	left = left - 3;
	top = top -3;
	var width = right - left - 3;
	var height = bottom - top - 3;
	GIActionCC.hotspots.push({left:left, top:top, width:width, height:height, explanation:explanation})
}


function ConceptInfo(buttonfile,url,tooltip,infotype,infokey)
{
	concepts[concepts.length]=new Object({buttonfile: buttonfile,url: url,tooltip: tooltip,infotype: infotype,infokey: infokey});
};

function MyEscape(s)
{
	var snew="";

	for (var i=0;i<s.length;i++)
	{
		ss=s.substr(i,1);
		if ((ss>='0' && ss<='9') ||
			(ss>='a' && ss<='z') ||
			(ss>='A' && ss<='Z'))
		{
			snew+=ss;
		}
		else
		{
			ss=s.charCodeAt(i);		
			a="0000"+ss.toString(16).toUpperCase();
			snew+="$"+a.substr(a.length-4);		
		}
	}

	return snew;
}

function EventCancel(event)
{
    if (!isIE) {
        var e = event;
        e.preventDefault();
    }
	return false;
}

function TeacherModeEnabled()
{
	GITMEnabled = true	
}

function DemoModeEnabled()
{
	GIDMEnabled = true	
}

function DisableTutorial()
{
	Disable_Tutorial=true;
}

function SetScreenshotPath(path)
{
	if(path != "")
	{
		fatSSPath = path + "/";
		SoundPlayerObj.SetSoundPath(path);
	}
	else
	{
		fatSSPath = document.location.href;
		while (fatSSPath.indexOf('\\')!=-1)
			fatSSPath=fatSSPath.replace('\\','/');
		fatSSPath=fatSSPath.substr(0,fatSSPath.lastIndexOf('/')+1);
	}
}

function SetTemplateRootPath(path)
{
	if(path)
	{
		if(SoundPlayerObj) SoundPlayerObj.SetTemplateRootPath(path);
	}
}

function SetTemplateSet(tset)
{
	if(SoundPlayerObj) SoundPlayerObj.SetTemplateSet(tset);
}

function startTopic() {

    if (noStart) {
        this.close();
        return;
    }
	if(window.opener) {
	    var bi = new BrowserInfo();
	    GetBrowserInfo(bi);
	    try {
	        if (bi.name!="Firefox")
    	        window.opener.blur();
	    }
	    catch (e) {};
	}

	Init()
	startTopic2()
}								  

function startTopic2()
{
	if(!GIOnLoad)
	{
		setTimeout(startTopic2, 50)
		return;
	}
	BuildBackActions();
	GIState = GIFirstFrame;
	
	if(GIS2)
	{
		var s2p = GIS2 / (popHeight - 60)

		if (s2p < 0.1)
			s2p = 0.1;
		if (s2p > 0.9)
			s2p = 0.9;
        if (isIE && popupVersion && (GIS2.indexOf("%")==-1) ) {
		    oPopup.document.getElementById("split1").style.height = ((1 - s2p) * 100) + "%";
		    oPopup.document.getElementById("split2").style.height = (s2p * 100) + "%";
		}
		else if (GIS2.indexOf("%") >= 0) {
		    oPopup.document.getElementById("split1" + idPostFix).style.height = GIS2;
		    oPopup.document.getElementById("split2" + idPostFix).style.top = GIS2;
		    oPopup.document.getElementById("split2" + idPostFix).style.height = (100 - Number(GIS2.substring(0, GIS2.indexOf("%")))) + "%";
		}
	}
	if(GISSS == 1) toggleScreenshot(true);

	var ss=document.location.hash.substring(1);
	var strArgs = ss.split("&");
	if(strArgs.length == 0 || strArgs[0] == "")
		ss=document.location.search.substring(1);
		strArgs = ss.split("&");

	if (strArgs.length==1)
	{
		if (strArgs[0].toLowerCase().substr(0,3)== "su=")
		{
			safeUriMode=true;
			var s=Gkod.Escape.SafeUriUnEscape(strArgs[0].substr(3));
			strArgs=s.split("&");
		}
	}

	for(var i=0;i<strArgs.length;i++)
	{
		if (strArgs[i].substr(0,6).toLowerCase()=="frame=")
		{
			GIState=strArgs[i].substr(6);
		}
		if (strArgs[i].substr(0,10)=="FATPLAYER=")
		{
			fatPlayer=strArgs[i].substr(10);
		}
		if (strArgs[i].substr(0,4).toLowerCase()=="Ctx=")
		{
			param_ctx=strArgs[i].substr(4);
			if(param_ctx)
			{
				FatPlayerCommand("GETPARAMCTX");
			}
		}
		if (strArgs[i].substr(0,6).toLowerCase()=="ctxex=")
		{
			param_ecid=ecidStr(strArgs[i].substr(6));
		}
		if (strArgs[i].substr(0,9).toLowerCase()=="fastdoit=")
		{
			param_fastdoit=true;
		}
		if (strArgs[i].substr(0,12).toLowerCase()=="printitname=")
		{
			param_printitname=strArgs[i].substr(12);
		}
	}
	if(SoundPlayerObj) SoundAvail = SoundPlayerObj.IsAvailable()
	SetStartEcid(param_ecid);

	if(fatPlayer) FatPlayerCommand("PLAYER_LOADED");
	//ODS
	ODSOpenEvGroup();
	//ODS


	RefreshStep();
}

function ecidStr(s) {
    return replaceString("%27", "'", s);
}

function SetStartEcid(ecidexpression)
{
	if (ecidexpression.length==0)
		return;
	EcidComparer.Init(ecidexpression);
	for (var i=0;i<screenNames.length;i++)
	{
		scrName=screenNames[i];
		scr=GIFrames[scrName];
		for (var j=0;j<scr.actions.length;j++)
		{
			act=scr.actions[j];
			if (EcidComparer.Compare(act.ecidarray))
			{
				SetStartFrame(scrName);
				GIAltIndex = j;
				StartFrameCorrection(GIState);
				return;
			};
		};			
	};
};

function SetParamCtx(ctxlist)
{
	gicontextID = ctxlist;
	SetStartContext();
}

var bBackActionsBuilded=false;

function BuildBackActions()
{
	if (!bBackActionsBuilded)
	{
		var scr = null;
		for (var i=0;i<screenNames.length;i++)
		{
			scr=GIFrames[screenNames[i]];
			scr.backActions=new Array();
		};
		for (i=0;i<screenNames.length;i++)
		{
			scr=GIFrames[screenNames[i]];
			for (var j=0;j<scr.actions.length;j++)
			{
				scr.actions[j].prevFrame=screenNames[i];
				s=scr.actions[j].next;
				if(s)
				{
					if (GIFrames[s].type!="end")
						GIFrames[s].backActions[GIFrames[s].backActions.length]=scr.actions[j];
				}
			};
		};
	};
	bBackActionsBuilded=true;
};

function StartFrameCorrection(frameID)
{
	var frmPos=frameID;
	if (GIFrames[frameID].backActions.length==0)
	{
		StartScreen="Start";
		return;
	};
	var fID="";
	for (var i=0;i<GIFrames[frameID].backActions.length;i++)
	{
		if (i==0)
			fID=GIFrames[frameID].backActions[0].prevFrame;
		else
		{
			if (fID!=GIFrames[frameID].backActions[0].prevFrame)
			{
				GIState=frameID;
				return;
			};
		};
	};
	frmPos=GIFrames[frmPos].backActions[0].prevFrame;
	while (true)
	{
		if (GIFrames[frmPos].backActions.length==0)
		{
			GIState="Start";
			return;
		};
		if (GIFrames[frmPos].type=="decision")
		{
			GIState=frmPos;
			return;
		};
		GIState=frameID;
		return;
	};
};

function SetStartFrame(frameID)
{
	if (frameID.length==0)
		return;
	if (GIFrames[frameID])
		GIState=frameID;
};

function SetStartContext()
{
	if (gicontextID.length==0)
		return;
	var ctxArray=new Array();
	ctxArray=gicontextID.split("+");		

	for (var i=0;i<ctxArray.length;i++)
	{
		ctxItem=ctxArray[i];
		for (var j=0;j<screenNames.length;j++)
		{
			scrName=screenNames[j];
			scr=GIFrames[scrName];
			for (var k=0;k<scr.actions.length;k++)
			{
				act=scr.actions[k];
				if (act.ctx==ctxItem)
				{
					SetStartFrame(scrName);
					StartFrameCorrection(GIState);
					return;
				};
			};			
		};
	};
};

function OnClose()
{
	top.GIPlayer.closeAp();
}

function SetSound(s)
{
	if(s) PlaySound = s;
}

var KeyHookUp = 1;
var KeyHookTimer = 0;

function StartKeyHook()
{
	StopKeyHook();
	PGIKeyHook.onclick = KeyHookHandler;
	KeyHookTimer = setInterval(KeyHookCallback, 50);
}

function StopKeyHook()
{
	clearInterval(KeyHookTimer);
}

function KeyHookCallback()
{
	PGIKeyHook.click();
}

function KeyHookHandler()
{
	if(UserPrefs.DoIt.HotKey.Ctrl == "N" && UserPrefs.DoIt.HotKey.Shift == "N" && UserPrefs.DoIt.HotKey.Alt == "N") return;
	var nextact = true;
	switch(UserPrefs.DoIt.HotKey.Ctrl)
	{
		case "L":
			if(!event.ctrlLeft) nextact = false;
		break;
		case "R":
			if(!event.ctrlKey || event.ctrlLeft) nextact = false;
		break;
	}
	switch(UserPrefs.DoIt.HotKey.Shift)
	{
		case "L":
			if(!event.shiftLeft) nextact = false;
		break;
		case "R":
			if(!event.shiftKey || event.shiftLeft) nextact = false;
		break;
	}
	switch(UserPrefs.DoIt.HotKey.Alt)
	{
		case "L":
			if(!event.altLeft) nextact = false;
		break;
		case "R":
			if(!event.altKey || event.altLeft) nextact = false;
		break;
	}

	if (nextact) {
		if (KeyHookUp) {
			KeyHookUp = 0;
			GINextStep();
		}
	} else
		KeyHookUp = 1;
}

function GIHilite(ssid)
{
	GIHighlight.innerHTML = '';
	if (!ssid) {
		GIHighlight.style.display = "none";
		return;
	} else {
		var col = UserPrefs.MarqueeColor;
		for(var i=0;i<SSAList[ssid].a.hotspots.length;i++) {

			GIHighlight.innerHTML += '<DIV id="gihotspot" style="position:absolute;left:' + SSAList[ssid].a.hotspots[i].left
				+ 'px;top:' + SSAList[ssid].a.hotspots[i].top + 'px;z-index:2">'
				+ '<img id="gihotspotimg" src="'+P_GIRESOURCES+'spacer.gif" width="' + SSAList[ssid].a.hotspots[i].width
				+ '" height="' + SSAList[ssid].a.hotspots[i].height
				+ '" class="Area" border="3" style="border-color:' + col + '"/></DIV>'

		}
		GIHighlight.style.display = "inline";
	}
}

var hpos = null;
function GICenterHL()
{
	if(!hpos) return;
	var cx = GICamera.clientWidth / 2;
	var cy = GICamera.clientHeight / 2;
	var ox = hpos.left - cx;
	if (ox < 0)
		ox = 0;
	ox = ox - GICamera.scrollLeft;
	var oy = hpos.top - cy;
	if (oy < 0)
		oy = 0;
	oy = oy - GICamera.scrollTop;
	vl = Math.sqrt(ox * ox + oy * oy);
	if (vl < 5) {
		clearInterval(IV);
		IV = null;
		GICamera.scrollLeft = hpos.left - (GICamera.clientWidth / 2);
		GICamera.scrollTop = hpos.top - (GICamera.clientHeight / 2);
		return;
	}
	ox = ox * 3 / vl;
	oy = oy * 3 / vl;
	GICamera.scrollLeft = GICamera.scrollLeft + ox;
	GICamera.scrollTop = GICamera.scrollTop + oy;
}

var contCHL = false;
function GIStopCHL()
{
	if(fatPlayer)
	{
		if(IV)
		{
			clearInterval(IV);
			IV = null;
			contCHL = true;
		}
	}
}

var SSAList = null; // ScreenShotList
var IV = null;
function GILoadSS(ssid)
{
	hpos = null;
	GIHighlight.innerHTML = '';
	if(ssid)
	{
		GIScreenshot.src = fatSSPath + SSAList[ssid].sspath;
		if(SSAList[ssid].imgid)
		{
			for(var n in SSAList)
			{
			    oPopup.document.getElementById(SSAList[n].imgid).src = "../../img/stepdispl0.gif"
			}
			oPopup.document.getElementById(SSAList[ssid].imgid).src = "../../img/stepdispl1.gif"
		}
		if(SSAList[ssid].a.hotspots.length > 0)
		{
			hpos = {left: SSAList[ssid].a.hotspots[0].left, top: SSAList[ssid].a.hotspots[0].top}
			if(!SSAList[ssid].a.hotspots[0].explanation)
			{
				GIHilite(ssid);
			}
			setTimeout(GIStartIV, 500);
		}
	}
}
function GIStartIV()
{
	if(!IV) 
	IV = setInterval(GICenterHL, 10);
}

function OnUpdatePreferences(userpref)
{
	UserPrefs.Copy(userpref);
	setTimeout('RefreshStep()',100);
}

function RefreshStep()
{
	GITextFrame.style.overflow = "visible";
	if(GIState) GIStep(GIState);
	GITextFrame.style.overflow = "auto";
}

function GIStep(newState)
{
//	SoundPlayerObj.Play("01000002.ASX");
    if (isIE) {
        GITextFrame.style.overflow = "visible";
        StopKeyHook();
    }
	GIHighlight.innerHTML = '';
	GIAdvText.innerHTML = '';
	AudioAction = null;
	SSAList = null;
	hpos = null;
	var text=""
	if(newState==null)
	{
		GIClosePlayer();
		return
	}
	if (isIE && popupVersion) GICamera.style.width = popWidth - 18;

	GIState=newState

	var advkeytext = "";
	if (isIE) {
	    switch (UserPrefs.DoIt.HotKey.Ctrl) {
	        case "L":
	            advkeytext += "[" + R_interface_left + R_interface_ctrl + "]";
	            break;
	        case "R":
	            advkeytext += "[" + R_interface_right + R_interface_ctrl + "]";
	            break;
	    }
	    switch (UserPrefs.DoIt.HotKey.Shift) {
	        case "L":
	            if (advkeytext != "") advkeytext += " + ";
	            advkeytext += "[" + R_interface_left + R_interface_shift + "]";
	            break;
	        case "R":
	            if (advkeytext != "") advkeytext += " + ";
	            advkeytext += "[" + R_interface_right + R_interface_shift + "]";
	            break;
	    }
	    switch (UserPrefs.DoIt.HotKey.Alt) {
	        case "L":
	            if (advkeytext != "") advkeytext += " + ";
	            advkeytext += "[" + R_interface_left + R_interface_alt + "]";
	            break;
	        case "R":
	            if (advkeytext != "") advkeytext += " + ";
	            advkeytext += "[" + R_interface_right + R_interface_alt + "]";
	            break;
	    }
	}
//	window.open("../../../toc/noscroll.html?Topic.htm#Mode=T", "tplayer", "toolbar=0,scrollbars=0,location=0,statusbar=0,menubar=0,resizable=0, fullscreen");
	
	if(GIFrames[GIState].type == "start" || GIFrames[GIState].type == "end")
	{
		GIClearAll();
		if(!GIAltIndex) GIAltIndex = 0;
		GIActAction = GIFrames[GIState].actions[GIAltIndex]

		if(GIFrames[GIState].type == "start")
		{
			ODSFrameView("D",GIState);
			if(UserPrefs.ShowLeadIn!="all")
			{
				GINextState = GIActAction.next;
				GINextStep()
				return false;
			}
			GIAdvText.innerHTML = '<span style="cursor:pointer" onclick="top.GIPlayer.GINextStep(); return false"><img src="../../img/nextstep.gif" width="22" height="22" border="0" title="'+R_interface_nextstep+(advkeytext=="" ? "" : R_interface_nextstep2+advkeytext)+R_interface_nextstep3+'"/></span>';
		}
		else
		{
			if(GIHistory.length > 0)
				GIAdvText.innerHTML = '<span style="cursor:pointer" onclick="top.GIPlayer.GIPrevStep(); return false"><img src="../../img/prevstep.gif" width="22" height="22" border="0" title="'+R_menu_prevstep+'"/></span><img SRC="' + P_GIRESOURCES + 'spacer.gif" style="border:0;width:3px;height:1px"/>'
			GIAdvText.innerHTML += '<span style="cursor:pointer" onclick="top.GIPlayer.closeAp(); return false"><img src="../../img/nextstepclose.gif" width="22" height="22" border="0" title="'+R_bubble_closeondemand+'"/></span>';
		}

		GILoadInfoBlocks(GIInfoFrame);

		text +=	GIgetActionText(GIActAction)
		GITextFrame.innerHTML=text;
		
		if(ScreenshotVisible)
		{
			if (GIState == "Start")
			{
				SSAList[GIActAction.id].a = GIActAction;
				SSAList[GIActAction.id].sspath = GIFrames[GIState].sspath;
				GILoadSS(GIActAction.id)
			}
			else
				GIScreenshot.src = fatSSPath + GIState.substr(1, GIState.length - 1) + "g.png";
			GIHilite(null);
		}
		if (isIE) StartKeyHook();
	}
  
	if(GIFrames[GIState].type == "decision")
	{
		GIAltIndex = 0;
		GIActAction = GIFrames[GIState].actions[GIAltIndex]
		if(GIHistory.length > 0)
			GIAdvText.innerHTML = '<span style="cursor:pointer" onclick="top.GIPlayer.GIPrevStep(); return false"><img src="../../img/prevstep.gif" width="22" height="22" border="0" title="'+R_menu_prevstep+'"/></span><img SRC="' + P_GIRESOURCES + 'spacer.gif" style="border:0;width:3px;height:1px"/><img src="../../img/giftrk1.gif" style="border:0;width:22;height:22"/>'
		GILoadInfoBlocks(GIInfoFrame);
		text += GIGetDecisionText(GIState)
		GITextFrame.innerHTML = text;
		if(ScreenshotVisible)
		{
			GIScreenshot.src = fatSSPath + GIState.substr(1, GIState.length - 1) + "g.png";
			GIHilite(null);
		}
}
  
	if(GIFrames[GIState].type == "normal")
	{
//		GIAdvText.innerHTML = '<a href="#" onclick="top.GIPlayer.GINextStep(); return false">' + R_menu_nextstep + '</a>'
		if(GIHistory.length > 0)
			GIAdvText.innerHTML = '<span style="cursor:pointer" onclick="top.GIPlayer.GIPrevStep(); return false"><img src="../../img/prevstep.gif" width="22" height="22" border="0" title="'+R_menu_prevstep+'"/></span><img SRC="' + P_GIRESOURCES + 'spacer.gif" style="border:0;width:3px;height:1px">'

		GIAdvText.innerHTML += '<span style="cursor:pointer" onclick="top.GIPlayer.GINextStep(); return false"><img src="../../img/nextstep.gif" width="22" height="22" border="0" title="'+R_interface_nextstep+(advkeytext=="" ? "" : R_interface_nextstep2+advkeytext)+R_interface_nextstep3+'"/></span>'
		GIClearAll();
		if(GIFrames[GIState].actions.length>1)
		{
			for(var aa=1;aa<GIFrames[GIState].actions.length;aa++)
			{
				var bt = GetTextWT(GIFrames[GIState].actions[aa].text)
				if(bt != "")
					GIShowAltsPic()
			}
		}
//		alert(GIState)
		if(!GIAltIndex) GIAltIndex = 0;
		GIActAction = GIFrames[GIState].actions[GIAltIndex]

		GILoadInfoBlocks(GIInfoFrame);

		text +=	GIgetActionText(GIActAction)
		GITextFrame.innerHTML=text;
		
		if(ScreenshotVisible)
		{
			var GA = GIActAction;
			SSAList[GA.id].a = GIActAction;
			SSAList[GA.id].sspath = GIFrames[GIState].sspath;
	//		GGGGShowActions = new Array();
	//		GGGGShowActions.push( {f: GIState, a: GIActAction} );
			while(GA.dn && GIFrames[GA.next].type != "decision")
			{
				SSAList[GIFrames[GA.next].actions[0].id].a = GIFrames[GA.next].actions[0];
				SSAList[GIFrames[GA.next].actions[0].id].sspath = GIFrames[GA.next].sspath;
				GA = GIFrames[GA.next].actions[0];
			}
			GILoadSS(GIActAction.id)
		}

//		GGGSA(oPopup.document.getElementById("camera"), 0);

		if (isIE) StartKeyHook();
	}

	GIRefreshActionMenu()

	bubbc = GIActAction.bcolor;
	GIbgcolor = bubbc.toString(16);
	while (GIbgcolor.length < 6) GIbgcolor = "0" + GIbgcolor;
	GIbgcolor = "#" + GIbgcolor;
	//	if (GIbgcolor) oPopBody.style.backgroundColor = ("#" + GIbgcolor.toString(16));
	if (GIbgcolor) oPopBody.style.backgroundColor = GIbgcolor;
	else oPopBody.style.backgroundColor = "#FEFECE"

//	var loc = window.location.href
//	loc = loc.substring(0,loc.lastIndexOf("/")+1);

	if(GITMEnabled)
	{
//			getID("GIST").innerHTML='<a href="#" onclick='
//				+'"top.window.open(\'../../../toc/noscroll.html?'+escape(loc + 'Topic.htm#Mode=T&Frame='+GIState)+'\', \'tplayer\', \'toolbar=0,scrollbars=0,location=0,statusbar=0,menubar=0,resizable=0, fullscreen\'); return false"><IMG SRC="' + P_GIRESOURCES + 'playtpc.gif" border="0" title=""></a> '

			/* getID("GIST") @ */
//			oPopup.document.getElementById("GIST").innerHTML='<a href="#" onclick="top.GIPlayer.openTM()"'
//				+'><IMG SRC="' + P_GIRESOURCES + 'playtpc.gif" border="0" title="' + R_tooltip_viewtryit + '"></a> '

//			oPopBody = oPopup.document.body;
//			oPopBody.innerHTML = getID("oContextHTML0").innerHTML;
//			oPopBody.ondragstart = EventCancel ;
	}

	AudioAction = GIActAction;
	if(SoundAvail && PlaySound && UserPrefs.PlayAudio=="all")
	{
		PlayAudio()
	}
//	alert(GIInfoFrame.innerHTML)
//	alert(text)
//	window.blur()
	if (isIE && popupVersion) GITextFrame.style.width = popWidth - 29;
	if(fatPlayer) FatPlayerCommand("ACTIVATE_APPLICATION");
	if (isIE) GITextFrame.style.overflow = "auto";
}

function GITMClosed()
{
//	alert("csukva")
	ShowPopup();
//	InitPopUp();
//	GIStep(GIState);
//	RePop()
}

function IsPrimaryDisplay()
{
	primarydisplay=true;
	var testwindow=window.open("","","width=10,height=10");
	if (testwindow.screenLeft<0 || testwindow.screenLeft>this.screen.width)
		primarydisplay=false;
	if (testwindow.screenTop<0 || testwindow.screenTop>this.screen.height)
		primarydisplay=false;
	testwindow.close();
	return primarydisplay;
}

function openTM()
{
	if(SoundPlayerObj && SoundAvail && PlaySound) SoundPlayerObj.Stop();
	if(fatPlayer)
	{
		HidePopup()
		var s = "Mode=T&Frame=" + GIState;
		FatPlayerCommand("START_SIMULATEDMODE",s)
	}
	else
	{
		HidePopup()
		var loc = window.location.href
		loc = loc.substring(0,loc.lastIndexOf("/")+1);

		var params="toolbar=0,scrollbars=0,location=0,statusbar=0,menubar=0,resizable=0,";
		if (IsPrimaryDisplay())
		{
			params+="fullscreen=1";
		}
		else
		{
			sw=window.screen.availWidth-2*SM_CYFRAME;				// screen width
			sh=window.screen.availHeight-2*SM_CYFRAME-SM_CYCAPTION;	// screen height
			params+="top=0,left=0,width="+sw+",height="+sh;
		}

		var p='mode=T&frame='+GIState;
		if (safeUriMode)
		{
			var s=Gkod.Escape.SafeUriEscape(p);
			p="su="+s;
		}

		top.window.open('topic.html?'+p, 'tplayer', params);
	}
//	alert(tplayer)
}

function OpenTutorial(link,name,params)
{
	HidePopup();
	var ss = "../toc/noscroll.html#" + link
	top.window.open(ss, name, params);
}

function openDM()
{
	if(SoundPlayerObj && SoundAvail && PlaySound) SoundPlayerObj.Stop();
	if(fatPlayer)
	{
		HidePopup()
		var s = "Mode=S&Frame=" + GIState;
		FatPlayerCommand("START_SIMULATEDMODE",s)
	}
	else
	{
		HidePopup()
		var loc = window.location.href
		loc = loc.substring(0,loc.lastIndexOf("/")+1);

		var params="toolbar=0,scrollbars=0,location=0,statusbar=0,menubar=0,resizable=0,";
		if (IsPrimaryDisplay())
		{
			params+="fullscreen=1";
		}
		else
		{
			sw=window.screen.availWidth-2*SM_CYFRAME;				// screen width
			sh=window.screen.availHeight-2*SM_CYFRAME-SM_CYCAPTION;	// screen height
			params+="top=0,left=0,width="+sw+",height="+sh;
		}

		var p='mode=S&frame='+GIState;
		if (safeUriMode)
		{
			var s=Gkod.Escape.SafeUriEscape(p);
			p="su="+s;
		}

		top.window.open('topic.html?'+p, 'dplayer', params);
	}
//	alert(tplayer)
}

function PlayTemplate()
{
//	alert("template")
	isPrevTemplate = true;
	var path=template_then_wav;
	if(SoundPlayerObj) SoundPlayerObj.Play(path,false,true);
}

function PlayAudio()
{
	isPrevTemplate = false;
//	SoundPlayerObj.Stop();
	if(SoundPlayerObj)
	{
		SoundPlayerObj.Play(AudioAction.id.substring(1)+".ASX");
	}
//	SoundPlayerObj.Play("../../../TEMPLATE/Default/standard/g_then.wav");
}

function OnEndPlaySound()
{
	if(SoundPlayerObj) SoundPlayerObj.Stop();
//	alert("joo")
	if(isPrevTemplate) setTimeout(PlayAudio,300)
	else
	{
		if(AudioAction.dn && GIFrames[AudioAction.next].type != "decision")
		{
			AudioAction = GIFrames[AudioAction.next].actions[0]
			setTimeout(PlayTemplate,300);
		}
	}
}

function OnErrorPlaySound(code,descr)
{
	if(SoundPlayerObj) SoundPlayerObj.Stop();
//	alert(descr)
	if(isPrevTemplate) setTimeout(PlayAudio,300)
	else
	{
		if(AudioAction.dn && GIFrames[AudioAction.next].type != "decision")
		{
			AudioAction = GIFrames[AudioAction.next].actions[0]
			setTimeout(PlayTemplate,300);
		}
	}
}

function GIGetDecisionText(newState)
{
//	var tt = "<span style='font: Arial 9pt'>Choose one of the options below:<BR><BR>";
	var tt = "<span style='font: 9pt Arial'>" + GIFrames[GIState].header + "<BR><BR>";
	if (!popupVersion) {
	    tt += "<ul style='padding: 0 0 0 18px; margin: 0;'>";
	}
	for (var i = 0; i < GIFrames[newState].actions.length; i++)
	{
	    var a = GIFrames[newState].actions[i]
	    var at = a.text.replace(/&amp;/g, '&');
//		var at = escape(GetTextWT(a.text))
//		tt += '<a href="#" onclick="top.GIPlayer.GINextStep(\'' + a.next + '\',\'' + at + '\'); return false">';
		tt += "<li><a href='#' onclick='top.GIPlayer.GINextStep(\"" + a.next + "\"); return false'>";
		tt += at;
		tt += '</a><BR></li>'
    }
    if (!popupVersion) {
        tt += "</ul>";
    }
    tt += '</span>';
//	alert(tt);
	return tt
}

function Replace(str,s,r)
{
	var k=str.indexOf(s);
	if (k<0)
		return str;
	var s1=str.substr(0,k);
	var s2=str.substr(k+6);
	return (s1+r+s2);	
};

function GIgetActionText(action)
{
	var tt = '';
	SSAList = new Array();
	SSAList[action.id] = {fid: null, a: null, imgid: null}
	if(action.icon)
	{
	    tt += '<img style="float:left;margin-right:5px;margin-bottom:5px" align="left" border="0" src="' + P_GIRESOURCES + action.icon + '"/> '
	}
	if(action.text==null) tt +=	'';
	else {
//		tt += "<div>";
		if(action.input)
		{
			action.text = BuildInputText(action.input, action.text);
		}
		if (action.dn && GIFrames[action.next].type != "decision")
		{
			if(ScreenshotVisible)
			{
				tt += "<img id='lss" + action.id + "' title='"+R_interface_filmstrip+"' style='cursor:pointer' align='right' src='../../img/stepdispl1.gif' onclick='parent.GILoadSS(\"" + action.id + "\");'/>";
				var id1 = 'lss' + action.id
				SSAList[action.id].imgid = id1;
			}
			else
			{
				tt += "<img style='width:13px;height:9px' align='right' src='../../img/s.gif'/>";
			}
		}
		tt += "<span>" + action.text + "</span>";
	}
	var a = action
	while(a.dn && GIFrames[a.next].type != "decision")
	{
		a = GIFrames[a.next].actions[0]
		if(a.input)
		{
			a.text = BuildInputText(a.input, a.text);
		}
		tt += '<br/><div style="clear:both"></div><B style="font-family:Arial;font-size:9pt"/>' + R_bubletext_then + '</B><BR>'

		if(a.icon)
		{
		    tt += '<img  style="float:left;margin-right:5px;margin-bottom:5px" align="left" border="0" src="' + P_GIRESOURCES + a.icon + '"/> '
		}
		if(ScreenshotVisible)
		{
			tt += "<img id='lss" + a.id + "' title='"+R_interface_filmstrip+"' style='cursor:pointer' align='right' src='../../img/stepdispl0.gif' onclick='parent.GILoadSS(\"" + a.id + "\");'/>";
			var id1 = 'lss' + a.id
			SSAList[a.id] = {fid: null, a: null, imgid: id1}
		}
		else
		{
		    tt += "<img style='width:13px;height:9px' align='right' src='../../img/s.gif'/>";
		}
		tt += "<span>" + a.text + "</span>"

//		tt += "<div>" + a.text + "</div>";
	}
//		alert(tt)
	GINextState=a.next;

	return tt;
}

function DisplayInputTextPart(templatetext, part, disp) {
    var p1 = '<DIV id=' + part + ' style="DISPLAY: inline">';
    var k1 = templatetext.indexOf(p1);
    if (k1 < 0) {
        p1 = '<div id="' + part + '" style="display: inline;">';
        k1 = templatetext.indexOf(p1);
        if (k1 < 0) {
            p1 = '<div id="' + part + '" style="display:inline">';
            k1 = templatetext.indexOf(p1);
            if (k1 < 0) {
                p1 = '<DIV style="DISPLAY: inline" id=' + part + '>';
                k1 = templatetext.indexOf(p1);
                if (k1 < 0)
                    return templatetext;
            }
        }
    }
    var t1 = templatetext.substr(k1 + p1.length);
    var k2 = t1.indexOf('</DIV>');
    if (k2 < 0)
        k2 = t1.indexOf('</div>');
    if (disp == true)
        return templatetext.substr(0, k1) + t1.substr(0, k2) + t1.substr(k2 + 6);
    return templatetext.substr(0, k1) + t1.substr(k2 + 6);
}

function BuildInputText(aobj,templatetext)
{
	var display_anything = false;
	var display_example = false;
	var display_inputtext = false;
	var display_inputalt = false;
	var display_blank = false;

// something	

	if (aobj[0]=="S")
	{
		display_anything = true;
		if (template_strinp_suppress_example=="0")
		{
			display_example = true;
			display_inputtext = true;
		}
	}

// anything

	else if (aobj[0]=="A")
	{
		display_anything = true;
		display_blank = true;
		if (template_strinp_suppress_example=="0")
		{
			display_example = true;
			display_inputtext = true;
		}
	}

// nothing

	else if (aobj[0]=="N")
	{
		display_inputtext = true;
		display_inputalt = true;
		display_blank = true;
	}

// 1 vagy tobb konkret alternativa

	else
	{
		display_inputtext = true;
		display_inputalt = true;
	}

// beiras a templatetextbe

	var s = templatetext;
	s = DisplayInputTextPart(s, "anything", display_anything);
	s = DisplayInputTextPart(s, "example", display_example);
	s = DisplayInputTextPart(s, "inputtext", display_inputtext);
	s = DisplayInputTextPart(s, "inputalt", display_inputalt);
	s = DisplayInputTextPart(s, "blank", display_blank);

	// begin 22282 hack
	s = s.replace(new RegExp("<SPAN></SPAN>", "g"), "<SPAN> </SPAN>");
	s = s.replace(new RegExp("\r", "g"), "");
	s = s.replace(new RegExp("\n", "g"), "");
	// end 22282 hack
	
	return s;
};


function GIClearAll()
{
	GITextFrame.innerHTML="";
	GIInfoFrame.innerHTML="";
	GIInfoFrame .innerHTML += '<span id="GIST"></span>'
	GIInfoFrame.innerHTML += '<span id="GIAlts' + idPostFix + '"></span>';
}

function GIRestart()
{
	var firstFrame = GIHistory[0].frame;
	GIHistory = null;
	GIHistory = new Array();
	GINextStep(firstFrame,true);
}

function GIPrevStep()
{
	var GIHistItem = GIHistory[GIHistory.length-1];
	GIRHist(GIHistory.length-1);
	GINextStep(GIHistItem.frame,true,GIHistItem.altindex);
}

function GINextStep(newStep, prev, altindex)
{
	if(newStep)
	{		  
		//ODS
		ODSFrameView("D",newStep);
//		alert(GIState+"   " + text)
		if(!prev) GIHistory.push({frame:GIState, type:GIFrames[GIState].type, altindex:GIAltIndex})
		if(altindex) GIAltIndex = altindex
		else GIAltIndex = null

		GIClearAll()
		GIStep(newStep)
	}
	else
	{
		//ODS
		ODSFrameView("D",GINextState);
//		alert(GIState+"   " + GIActAction.text)
		if(!prev) GIHistory.push({frame:GIState, type:GIFrames[GIState].type, altindex:GIAltIndex})
		if(altindex) GIAltIndex = altindex
		else GIAltIndex = null

		GIClearAll()
		GIStep(GINextState)
	}
}

function GetTextWT(text)
{
	var pos,pos2;
	while(text.indexOf("<") != -1)
	{
		pos = text.indexOf("<")
		var bef=text.substring(0,pos)
		pos2 = text.indexOf(">",pos)
		var intext = text.substring(pos+1,pos2)
//		alert(intext)
		if(intext=="/P" || intext=="/p" || intext.substr(0,1)=="p" || intext.substr(0,1)=="P" || intext=="BR" || intext=="br")
		{
			bef += "&nbsp";
		}
		var aft = text.substring(pos2+1)
		text = bef + aft;
	}
	return text;
}

function GILoadInfoBlocks(frame)
{
	var iState = GIState
	var iAction = GIFrames[iState].actions[GIAltIndex]
	var donext = true
	var donext2 = true
//	GIClearAll()
	
	while(donext)
	{
		if(GIFrames[iState].infoblocks.length>0)
		{
			donext = false
			var htmltext='';
	//		frame .innerHTML += '<IMG border="0" style="background-color:black; width:1; height:20">&nbsp &nbsp'

			if (GIFrames[GIState].actions.length > 1 && GIFrames[GIState].type != "decision") htmltext = '<img SRC="' + P_GIRESOURCES + 'spacer.gif" style="border:0;width:3px;height:1px"><IMG SRC="' + P_GIRESOURCES + 'spacer.gif" border="0" style="background-color:black; width:1px; height:20px"/>'
			var span = oPopup.document.createElement("span");
			frame.appendChild(span);
			span.innerHTML = htmltext;
//			frame.insertAdjacentHTML("beforeEnd", htmltext);
			while(donext2)
			{
				for(var i=0;i<GIFrames[iState].infoblocks.length;i++)
				{
					var inf = GIFrames[iState].infoblocks[i]
	
					htmltext = "<img SRC='" + P_GIRESOURCES + "spacer.gif' style='border:0;width:3px;height:1px'><span style='cursor:pointer' onclick=\"" + inf.url + "\""
						+ '/>'
						+ '<IMG SRC="' + P_GIRESOURCES + inf.buttonfile + '" border="0" title="' + inf.tooltip + '"/></span>'
					var span2 = oPopup.document.createElement("span");
					frame.appendChild(span2);
					span2.innerHTML = htmltext;
					//					frame.insertAdjacentHTML("beforeEnd", htmltext);
				}
				if(iAction.dn && GIFrames[iAction.next].type != "decision")
				{
					iState = iAction.next
					iAction = GIFrames[iState].actions[0]
				}
				else donext2 = false
			}
		}
		else
		{
			if(iAction.dn && GIFrames[iAction.next].type != "decision")
			{
				iState = iAction.next
				iAction = GIFrames[iState].actions[0]
			}
			else donext = false
		} 
	}
}

function GINextAlt()
{
	GIAltIndex += 1;
	if(GIAltIndex >= GIFrames[GIState].actions.length)
		GIAltIndex = 0;

	var bt = GetTextWT(GIFrames[GIState].actions[GIAltIndex].text)
	if(bt == "")
	{
		GINextAlt()
		return false;
	}

	RefreshStep();
}

function GIShowAltsPic()
{
	/* getID("GIAlts") @ */
    oPopup.document.getElementById("GIAlts" + idPostFix).innerHTML = '<span style="cursor:pointer" onclick="top.GIPlayer.GINextAlt(); return false"><IMG SRC="' + P_GIRESOURCES + 'alternatives.gif" border="0" title="' + R_menu_alternatives + '"/></span>'
}

function GIOpenAction(o)
{
    if (isIE) {
        for (var ii = 0; ii < oPopup.document.all.length; ii++) {
            oPopup.document.all[ii].detachEvent("onclick", GICloseAction)
        }
    }
    else {
        var ldiv = Get_Element("EventListenerDIV");
        ldiv.style.cursor = "default";
        ldiv.style.zIndex = -1;
        ldiv.removeEventListener("mousedown", GICloseAction, true);
    }
	var pleft=100;
	var ptop=100;
/*	if(TopPos == constPad &&LeftPos == constPad )
	{
		pleft=300;
		ptop=300;
	}*/
/*	if (o) {
		var r = o.getBoundingClientRect();
		pleft = oPopup.document.parentWindow.screenLeft + r.right - 196;
		ptop = oPopup.document.parentWindow.screenTop + r.bottom;
	}*/
	pleft = LeftPos + popWidth - 234;
	ptop = TopPos + 30;
	if(ActMenu) ActMenu.Open(pleft,ptop);
	GIRefreshActionMenu()

	setTimeout(GIAttachEvent,100)
}

function GIAttachEvent()
{
    if (isIE && popupVersion) {
        for (var ii = 0; ii < oPopup.document.all.length; ii++) {
            oPopup.document.all[ii].attachEvent("onclick", GICloseAction)
        }
    }
    else {
        var ldiv = Get_Element("EventListenerDIV");
        ldiv.style.cursor = "default";
        ldiv.style.zIndex = 4;
        if (isIE) ldiv.onmousedown = GICloseAction;
        else ldiv.addEventListener("mousedown", GICloseAction, true);
    }
}

function GICloseAction()
{
	if(ActMenu) ActMenu.Close()
}

function GIRHist(index)
{
//	alert(index)
	var arr = new Array()
	for(var i=0;i<index;i++)
	{
		arr[i] = GIHistory[i]
	}
	GIHistory = new Array()
	for(var i=0;i<arr.length;i++)
	{
		GIHistory[i] = arr[i]
	}
}

function GIRefreshActionMenu()
{
	if(ActMenu)
	{
		var his = false;
		if(GIHistory.length>0)
			his = true;
		var alt = false;
		if(GIFrames[GIState].actions.length>1 && GIFrames[GIState].type != "decision")
			alt = true;
		var next = false;
		if(GIFrames[GIState].type != "decision" && GIFrames[GIState].type != "end")
			next = true;
		var prefs =	UserPrefs.EnablePreferences
		if(!systemEnableCookies) prefs = false;
		var printit=param_printitname.length>0;
		ActMenu.Refresh(prefs,his,alt,next,GITMEnabled,GIDMEnabled,Disable_Tutorial,printit,param_fastdoit)
	}
}

function GIShowPrintit()
{
    if (param_printitname.length>0)
        window.open("../../printit/"+param_printitname);
}

function GIOpenHelp()
{
	onHelp("../../")
}

function GIOpenTutorial()
{
//	if(!Disable_Tutorial) RunTutorialDialog("D",1,"../../");
}

function GIClosePlayer(viewoutline)
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
    if (fatPlayer)
	{
		FatPlayerCommand("PLAYER_CLOSE");
	}
	else
	{
//		CloseTutorialDialog()
	    GICloseAction();
		if (GIPlayer)
    		GIPlayer.close();
		if(window.opener)
		{
		    try
		    {
				if(viewoutline || mViewOutline)
				{
					mViewOutline = true;
					window.opener.DoItFinished(false);
				}
				else window.opener.DoItFinished(param_fastdoit);
		    }
		    catch (e) {};
		}
	}
}

function OnClosingPreferences()
{
	ShowPopup();
	setTimeout('RefreshStep()',100);
}

function GIOpenPreferences()
{
	HidePopup();
	OpenPreferencesDialog("../..",!SoundAvail);
	if(fatPlayer) ShowPopup();
}

function Init()
{
	ActMenu = new ActionMenu();
	Init2()
}

function Init2()
{
//	if(!document.frames("GITextFrame").document.getElementsByTagName('body')[0])
    oPopup.document.getElementById("GITwisty" + idPostFix).title = R_interface_graphic;

    oPopup.document.getElementById("gititle" + idPostFix).innerHTML = "&nbsp " + R_mode_doit;
    closebtn = oPopup.document.getElementById("gicloseod" + idPostFix);
    if (closebtn) closebtn.title = R_bubble_closeondemand;
    GIInfoFrame = oPopup.document.getElementById("PGIInfoFrame" + idPostFix);
    GITextFrame = oPopup.document.getElementById("PGITextFrame" + idPostFix);
    oPopup.document.getElementById("pgiaction" + idPostFix).innerHTML = '<span title="' + R_interface_action_alt + '" style="CURSOR:pointer;TEXT-DECORATION:underline;FONT-SIZE:9pt;COLOR:#ccffff;FONT-WEIGHT:normal;FONT-FAMILY:Arial,Helvetica,sans-serif" onclick="top.GIPlayer.GIOpenAction(this);">' + R_interface_action + '</span>';
    GIAdvText = oPopup.document.getElementById("PGIAdvText" + idPostFix);
    GIScreenshot = oPopup.document.getElementById("PGIScreenshot" + idPostFix);
	GIScreenshot.title = R_interface_graphic_alt;
	GIHighlight = oPopup.document.getElementById("PGIHighlight" + idPostFix);
	GICamera = oPopup.document.getElementById("camera" + idPostFix)

	GIPlayer = self;
	document.title=R_mode_doit;


	GIOnLoad = true;
	
}

var ScreenshotVisible = 1;
var SavedSSHeight = 0;
var SavedSSHeight2 = 0;

function toggleScreenshot(o)
{
//	alert(popHeight+" 1: "+oPopup.document.getElementById("split1").clientHeight+" 2: "+oPopup.document.getElementById("split2").clientHeight)
//	alert(" 1: "+oPopup.document.getElementById("split1").style.height+" 2: "+oPopup.document.getElementById("split2").style.height)
	if (ScreenshotVisible) {
	    oPopup.document.getElementById("GITwisty" + idPostFix).src = '../../img/twistydown' + (o ? '0' : '1') + '.gif';
	    if (isIE && popupVersion) {
	        var s2 = oPopup.document.getElementById("split2");
	        var h = s2.getBoundingClientRect().top;
	        SavedSSHeight = popHeight - h;
	        SavedSSHeight2 = s2.clientHeight;
	        popHeight = h;
	        oPopup.document.getElementById("sstoggle1").style.display = "none";
	        oPopup.document.getElementById("sstoggle2").style.display = "none";
	        oPopup.document.getElementById("sstoggle3").style.display = "none";
	    }
	    else {
	        SavedSSHeight = oPopup.document.getElementById("split1" + idPostFix).style.height;
	        oPopup.document.getElementById("split2" + idPostFix).style.display = "none";
	    }
	    oPopup.document.getElementById("split1" + idPostFix).style.height = "100%";
		ScreenshotVisible = 0;
		oPopup_show(LeftPos, TopPos, popWidth, popHeight);	
	} else {
	    oPopup.document.getElementById("GITwisty" + idPostFix).src = '../../img/twistyup1.gif';
	    if (isIE && popupVersion) {
	        if (!SavedSSHeight2) SavedSSHeight2 = 100;
	        popHeight += SavedSSHeight;

	        oPopup.document.getElementById("sstoggle1").style.display = "inline";
	        oPopup.document.getElementById("sstoggle2").style.display = "inline";
	        oPopup.document.getElementById("sstoggle3").style.display = "inline";

	        var s2p = SavedSSHeight2 / (popHeight - 60)

	        if (s2p < 0.1)
	            s2p = 0.1;
	        if (s2p > 0.9)
	            s2p = 0.9;
	        oPopup.document.getElementById("split1").style.height = ((1 - s2p) * 100) + "%";
	        oPopup.document.getElementById("split2").style.height = (s2p * 100) + "%";
	        if (popHeight > screen.height)
	            popHeight = screen.height;
	        oPopup_show(LeftPos, TopPos, popWidth, popHeight);
	        LeftPos = oPopup.document.parentWindow.screenLeft;
	        TopPos = oPopup.document.parentWindow.screenTop;
	    }
	    else {
	        oPopup.document.getElementById("split1" + idPostFix).style.height = SavedSSHeight;
	        oPopup.document.getElementById("split2" + idPostFix).style.top = SavedSSHeight;
	        oPopup.document.getElementById("split2" + idPostFix).style.height = (100 - Number(SavedSSHeight.substring(0, SavedSSHeight.indexOf("%")))) + "%";
	        oPopup.document.getElementById("split2" + idPostFix).style.display = "block";
	    }
		ScreenshotVisible = 1;
	}
	if(systemEnableCookies && GICookie && GICookie != null)
	{
		GICookie["Cleft"]=LeftPos;
		GICookie["Ctop"]=TopPos;
		GICookie["Cwidth"]=popWidth;
		if(ScreenshotVisible) GICookie["Cheight"]=popHeight;
		else GICookie["Cheight"]=popHeight + SavedSSHeight;
		GICookie["Csss"]=ScreenshotVisible+1;
		GICookie["Cs2"] = (isIE && popupVersion) ? SavedSSHeight2 : SavedSSHeight;
		GICookie.Store()
	}

	RefreshStep();
}

function DecodeInputString(s)
{
	s = replaceString("&lt;","<", s);
	return s;
}

function replaceString(oldS,newS,fullS) {
// Replaces oldS with newS in the string fullS
   for (var i=0; i<fullS.length; i++) {
	   if (fullS.substring(i,i+oldS.length) == oldS) {
			fullS = fullS.substring(0,i)+newS+fullS.substring(i+oldS.length,fullS.length)
		}
	}
	return fullS
}

function fixInputString(strHTMLString) {
	if(strHTMLString)
	{
		for(var i=0; i<strHTMLString.length; i++)
		{
			strHTMLString[i] = replaceString("<","&lt;", strHTMLString[i]);
			strHTMLString[i] = replaceString(">","&gt;", strHTMLString[i]);
		}
	}
	
	return strHTMLString;
}

/*
function GGGFocus()
{
	
	RePop();
}

function GGGBlur()
{
	RePop();
}

window.onfocus=GGGFocus;
window.onblur=GGGBlur;
*/
if (Array.prototype.push == null)
	Array.prototype.push = function(e) { this[this.length] = e; return e};

if (typeof HTMLElement != "undefined" && !
HTMLElement.prototype.insertAdjacentElement) {
    HTMLElement.prototype.insertAdjacentElement = function
(where, parsedNode) {
        switch (where) {
            case 'beforeBegin':
                this.parentNode.insertBefore(parsedNode, this)
                break;
            case 'afterBegin':
                this.insertBefore(parsedNode, this.firstChild);
                break;
            case 'beforeEnd':
                this.appendChild(parsedNode);
                break;
            case 'afterEnd':
                if (this.nextSibling)
                    this.parentNode.insertBefore(parsedNode, this.nextSibling);
                else this.parentNode.appendChild(parsedNode);
                break;
        }
    }

    HTMLElement.prototype.insertAdjacentHTML = function
(where, htmlStr) {
        var r = this.ownerDocument.createRange();
        r.setStartBefore(this);
        var parsedHTML = r.createContextualFragment(htmlStr);
        this.insertAdjacentElement(where, parsedHTML)
    }


    HTMLElement.prototype.insertAdjacentText = function
(where, txtStr) {
        var parsedText = document.createTextNode(txtStr)
        this.insertAdjacentElement(where, parsedText)
    }
}
