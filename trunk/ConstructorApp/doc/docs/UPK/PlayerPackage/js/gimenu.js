/*--
Copyright © 1998, 2009, Oracle and/or its affiliates.  All rights reserved.
--*/



var popupMenu = 0;
var aPopBody = 0;
var innerBody = 0;

function ActionMenu()
{
	this.Open=_AOpen;
	this.Close=_AClose;
	this.Refresh=_ARefresh;
	this.IsOnScreen=_AIsOnScreen;
	this.onScreen = false;
	this.created = false;
};

function _AOpen(left, top)
{
    if (isIE && popupVersion) {
        if (!popupMenu) {
            popupMenu = oPopup.document.parentWindow.createPopup();
            popupMenuBody = popupMenu.document.body;
        };
        aPopBody = popupMenu.document.body;

        aPopBody.style.borderStyle = "solid";
        aPopBody.style.borderWidth = "1px";
        aPopBody.style.borderColor = "gray";
        aPopBody.style.backgroundColor = "#f7f7e7";
        aPopBody.style.marginTop = "8px";
        aPopBody.style.marginBottom = "8px";
        aPopBody.style.marginLeft = "8px";
        aPopBody.style.marginRight = "8px";

        aPopBody.aLink = "0000FF";
        aPopBody.link = "0000FF";
        aPopBody.vLink = "0000FF";
        aPopBody.text = "black";
        aPopBody.ondragstart = EventCancel;
        aPopBody.oncontextmenu = EventCancel;
    }
    else {
        if (!this.created) {
            popupMenu = window;
            aPopBody = document.createElement("div");
            aPopBody.id = "actMenu";
            aPopBody.style.borderStyle = "solid";
            aPopBody.style.borderWidth = "1px";
            aPopBody.style.borderColor = "gray";
            aPopBody.style.backgroundColor = "#f7f7e7";
            aPopBody.aLink = "0000FF";
            aPopBody.link = "0000FF";
            aPopBody.vLink = "0000FF";
            aPopBody.text = "black";

            innerBody = document.createElement("div");
            aPopBody.appendChild(innerBody);
            innerBody.style.marginTop = "8px";
            innerBody.style.marginBottom = "8px";
            innerBody.style.marginLeft = "8px";
            innerBody.style.marginRight = "8px";

            aPopBody.style.position = "absolute";
            aPopBody.style.display = "block"
            aPopBody.style.zIndex = 6;
            aPopBody.style.overflow = "auto";
            aPopBody.style.maxWidth = (document.getElementById("noPopupFF").clientWidth - 40) + "px";
            //            document.getElementById("giTitlebarInnerFF").appendChild(aPopBody);
            document.body.appendChild(aPopBody);
            this.created = true;
        }
        else {
            aPopBody.style.maxWidth = (document.getElementById("noPopupFF").clientWidth - 40) + "px";
            aPopBody.style.display = "block";
        }
    }
    //	popupMenu.show(left, top, 200,300);
    this.onScreen = true;
};

function _AClose()
{
	if(this.onScreen)
	{
	    if (isIE && popupVersion) popupMenu.hide();
	    else {
	        aPopBody.style.display = "none";
	        var ldiv = Get_Element("EventListenerDIV");
	        ldiv.style.zIndex = -1;
            if (isIE) ldiv.onmousedown = null;
            else ldiv.removeEventListener("mousedown", GICloseAction, true);
	    }
		this.onScreen=false;
	}
};

function OnActionSelection(v1,v2,v3)
{
    if (isIE && popupVersion) popupMenu.hide();
	this.onScreen=false;
	if (v1=="Alt")
	{
		GIPlayer.GINextAlt();
	};
	if (v1=="Next")
	{
		GIPlayer.GINextStep();
	};
	if (v1=="Prev")
	{
		GIPlayer.GIPrevStep();
	};
	if (v1=="Restart")
	{
		GIPlayer.GIRestart();
	};
	if (v1=="Conc")
	{
		setTimeout(concepts[v2].url,20);
	};
	if (v1=="Info")
	{
		setTimeout(GIFrames[v3].infoblocks[v2].url,20);
	};
	if (v1=="PlayT")
	{
		GIPlayer.openTM();
	};
	if (v1=="PlayD")
	{
		GIPlayer.openDM();
	};
	if (v1=="Prefs")
	{
		GIPlayer.GIOpenPreferences();
	};
	if (v1=="Help")
	{
		GIPlayer.GIOpenHelp();
	};
	if (v1=="Tutorial")
	{
		GIPlayer.GIOpenTutorial();
	};
	if (v1=="CloseT")
	{
		GIPlayer.GIClosePlayer();
	};
	if (v1=="ViewOutline")
	{
		GIPlayer.GIClosePlayer(true);
	};
	if (v1=="CloseW")
	{
		GIPlayer.GICloseAction();
	};
	if (v1=="Printit")
	{
		GIPlayer.GIShowPrintit();
	}
	GICloseAction();
};

function CorrectPopup()
{
    if (isIE && popupVersion) {
        popupMenu.show(0, 0, 0, 0);
    }
    sp = popupMenu.document.getElementById("actionspan");
    hsp = sp.offsetHeight;
    wsp = sp.offsetWidth;
    obj = oPopup.document.getElementById("pgiaction" + idPostFix);
    objh = obj.offsetHeight;
    if (isIE && popupVersion) {
        popupMenu.show(-(wsp - 20), objh, wsp + 20, hsp + 20, obj);
    }
    else {
        aPopBody.style.left = (obj.offsetLeft + obj.offsetWidth - wsp - 20) + "px";
        aPopBody.style.top = (obj.offsetTop + objh + 6) + "px";
    }
    ActMenu.onScreen = true;
}

function PopupToggle(div)
{
    if (popupMenu.document.getElementById(div).style.display == "none")
        popupMenu.document.getElementById(div).style.display = "block";
	else
	    popupMenu.document.getElementById(div).style.display = "none";
	CorrectPopup()
};

function _ARefresh(prefs,his,alt,next,tmenabled,dmenabled,distut,printit,fastdoit)
{
	if (!this.onScreen)
		return;
	var s="";
	if (isIE && popupVersion) s = "<div id='actionspan' style='font:8pt Arial;width:100' nowrap='true'>";
	else if (isIE) s = "<div id='actionspan' style='font:8pt Arial;min-width:100' nowrap='true'>";
	else s = "<div id='actionspan' style='font:8pt Arial;width:100' nowrap='true'><ul style='padding-left:18px'>";
	
	if (alt)
	{
		s+="<li><a href='#' onclick='parent.parent.OnActionSelection(\"Alt\");return false;'>";
		s+=R_menu_alternatives;
		s+="</a></li>";
	};
	if (next)
	{
		s+="<li><a href='#' onclick='parent.parent.OnActionSelection(\"Next\");return false;'>";
		s+=R_menu_nextstep;
		s+="</a></li>";
	};
	if (his)
	{
		s+="<li><a href='#' onclick='parent.parent.OnActionSelection(\"Prev\");return false;'>";
		s+=R_menu_prevstep;
		s+="</a></li>";

		s+="<li><a href='#' onclick='parent.parent.OnActionSelection(\"Restart\");return false;'>";
		s+=R_menu_start;
		s+="</a></li>";
	};
	var i=0;
	if (concepts.length>0)
	{
		s+="<li>";
		s+="<a href='#' onclick='parent.parent.OnActionSelection(\"Conc\",\"0\");return false;'>";
		s+=R_menu_concepts;
		s+="</a></li>";
	};

	var iState = GIState
	var iAction = GIFrames[iState].actions[GIAltIndex]
	var donext = true
	var donext2 = true
	
	while(donext)
	{
		if (GIFrames[iState].infoblocks.length>0)
		{
			donext = false
			s+="<li><a href='#' onclick='parent.parent.PopupToggle(\"infodiv\")'>";
			s+=R_menu_infoblocks;
			s+="</a></li>";
			if (isIE) s += "<div id='infodiv' style='display:none'>";
			else s += "<div id='infodiv' style='display:none'><ul style='padding-left:18px'>";
			
			while(donext2)
			{
				for (i=0;i<GIFrames[iState].infoblocks.length;i++)
				{
				    s += "<li style='list-style-type:circle;" + (isIE ? "text-indent:18px" : "") + "'>";
				    s += "<a href='#' onclick='parent.parent.OnActionSelection(\"Info\",";
					s+=""+i;
					s+=",\"" + iState + "\");return false;'>";
					s+=GIFrames[iState].infoblocks[i].tooltip;
					s+="</a></li>";
				};
				if(iAction.dn && GIFrames[iAction.next].type != "decision")
				{
					iState = iAction.next
					iAction = GIFrames[iState].actions[0]
				}
				else donext2 = false
			}
			if (isIE) s += "</div>";
			else s += "</ul></div>";
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
	if (tmenabled || dmenabled || printit)
	{
		s+="<li><a href='#' onclick='parent.parent.PopupToggle(\"playdiv\")'>";
		s+=R_menu_play;
		s+="</a></li>";
		if (isIE) s += "<div id='playdiv' style='display:block'>";
		else s += "<div id='playdiv' style='display:block'><ul style='padding-left:18px'>";
		if (dmenabled)
		{
		    s += "<li style='list-style-type:circle;" + (isIE ? "text-indent:18px" : "") + "'>";
			s+="<a href='#' onclick='parent.parent.OnActionSelection(\"PlayD\"";
			s+=");return false;'>";
			s+=R_mode_seeit;
			s+="</a></li>";
		}
		if(tmenabled)
		{
		    s += "<li style='list-style-type:circle;" + (isIE ? "text-indent:18px" : "") + "'>";
		    s += "<a href='#' onclick='parent.parent.OnActionSelection(\"PlayT\"";
			s+=");return false;'>";
			s+=R_mode_tryit;
			s+="</a></li>";
		}
		if (printit)
		{
		    s += "<li style='list-style-type:circle;" + (isIE ? "text-indent:18px" : "") + "'>";
		    s += "<a href='#' onclick='parent.parent.OnActionSelection(\"Printit\"";
			s+=");return false;'>";
			s+=R_interface_printit;
			s+="</a></li>";
		}
		if (isIE) s += "</div>";
		else s += "</ul></div>";
};

	if (prefs)
	{
		s+="<li><a href='#' onclick='parent.parent.OnActionSelection(\"Prefs\");return false;'>";
		s+=R_menu_preferences;
		s+="</a></li>";
	};
	s+="<li><a href='#' onclick='parent.parent.OnActionSelection(\"Help\");return false;'>";
	s+=R_menu_help;
	s+="</a></li>";

	if(!distut)
	{
		s+="<li><a href='#' onclick='parent.parent.OnActionSelection(\"Tutorial\");return false;'>";
		s+=R_menu_tutorial;
		s+="</a></li>";
	}

	if (fastdoit)
	{
		s+="<li><a href='#' onclick='parent.parent.OnActionSelection(\"ViewOutline\");return false;'>";
		s+=R_menu_viewoutline;
		s+="</a></li>";
	};

	s+="<li><a href='#' onclick='parent.parent.OnActionSelection(\"CloseT\");return false;'>";
	s+=R_menu_Close;
	s+="</a></li>";

//	s+="<br>";
//	s+="<a href='#' onclick='parent.parent.OnActionSelection(\"CloseW\");return false;'>";
//	s+=R_gimenu_close;
//	s+="</a>";
	if (isIE) s += "</div>";
	else s += "</ul></div>"

	if (isIE && popupVersion) {
	    aPopBody.innerHTML = s;
	}
	else {
	    innerBody.innerHTML = s;
	}
//	obj=document.all('screen');
//	popupMenu.show(100,150,230,360,obj);
	CorrectPopup()
	this.onScreen=true;
};

function _AIsOnScreen()
{
	return this.onScreen;
};