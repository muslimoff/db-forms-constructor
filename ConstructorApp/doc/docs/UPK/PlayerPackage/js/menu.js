/*--
Copyright © 1998, 2009, Oracle and/or its affiliates.  All rights reserved.
--*/

var popupMenu = 0;
showAttachments = false;
var fullength = 0;

function ActionMenu() {
    this.Open = _AOpen;
    this.Close = _AClose;
    this.Refresh = _ARefresh;
    this.IsOnScreen = _AIsOnScreen;
    this.PopupIsOpened = _APopupIsOpened;
    this.onScreen = false;
};


function setAOpener(e) {
    if (document.all) {
        popupOpener = event.srcElement;
    }
    else {
        event = e;
        popupOpener = event.target;
    }
    OnAction();
}

function _AOpen() {

    /*	IE FÜGGŐ HÍVÁS	

	if (!popupMenu)
    {
    popupMenu=createPopup();
    };
    */

    //HELYETTE DIV

    if (!popupMenu) {
        popupMenu = document.createElement('DIV');
        document.body.appendChild(popupMenu);
        myspan = document.createElement('SPAN');
        myspan.setAttribute("id", "_myspan_");
        myspan.setAttribute("style", "font:8pt Arial;");
        document.body.appendChild(myspan);
    };

    //LEKÉRDEZZÜK A NYITÓ POZÍCIÓJÁT
    nextNode = popupOpener;
    popupOpener.positionTop = 0;
    popupOpener.positionLeft = 0;
    while (nextNode.nodeName != 'BODY') {
        popupOpener.positionTop += nextNode.offsetTop;
        popupOpener.positionLeft += nextNode.offsetLeft;
        nextNode = nextNode.parentNode;
    }

    popupOpenerHeight = popupOpener.offsetHeight;

    //BELŐJÜK A MENÜ POZÍCIÓJÁT	
    popupMenu.style.zIndex = 10000;
    popupMenu.style.position = "absolute";

    var _top_correction = (IsFF3() || IsSafari() ? 16 : 0);

    popupMenu.style.top = (popupOpener.positionTop + popupOpenerHeight) - _top_correction - 6 + 'px';
    if (document.all) {
        popupMenu.style.left = (popupOpener.positionLeft - 65) + 'px';
    }
    else {
        popupMenu.style.left = (popupOpener.positionLeft - 80) + 'px';
    }

    //aPopBody = popupMenu.document.body;	NEM KELL

    //NEM KELLENEK A DOCUMENT.BODY -K, margin, helyett padding

    //EZ KAPCSOLJA BE A MENÜ MEGJELENÍTÉSÉT
    popupMenu.style.display = "block";
    popupMenu.style.width = "140px";

    popupMenu.style.borderStyle = "solid";
    popupMenu.style.borderWidth = "1px";
    popupMenu.style.borderColor = "gray";
    popupMenu.style.backgroundColor = "f7f7e7";
    popupMenu.style.paddingTop = "8px";
    popupMenu.style.paddingBottom = "8px";
    popupMenu.style.paddingLeft = "8px";
    popupMenu.style.paddingRight = "8px";

    popupMenu.aLink = "0000FF";
    popupMenu.link = "0000FF";
    popupMenu.vLink = "0000FF";
    popupMenu.text = "black";

    //aPopBody.ondragstart = EventCancel ;
    //aPopBody.oncontextmenu = EventCancel ;

    this.onScreen = true;
};

function _APopupIsOpened() {
    if (popupMenu == 0) {
        return false;
    }
    return popupMenu.isOpen;
}

function _AClose() {
    //popupMenu.hide();
    window.setTimeout("popupMenuHide()", 200);
    this.onScreen = false;
};

function OnActionSelection(v1, v2) {
    //popupMenu.hide();
    this.onScreen = false;
    if (v1 == "Next") {
        OnMenuAlternative("TeacherForward(false)");
    };
    if (v1 == "Prev") {
        OnMenuAlternative("TeacherBack()");
    };
    if (v1 == "Start") {
        OnMenuAlternative("TeacherFastBack()");
    };
    if (v1 == "Alt") {
        OnMenuAlternative("TeacherAlter()");
    };
    if (v1 == "Conc") {
        OnMenuAlternative(concepts[v2].url,
							concepts[v2].width,
							concepts[v2].height,
							concepts[v2].infotype,
							concepts[v2].infokey);
    };
    if (v1 == "Info") {
        OnMenuAlternative(screens[showScreen].infoblocks[v2].simpleurl,
							screens[showScreen].infoblocks[v2].width,
							screens[showScreen].infoblocks[v2].height,
							screens[showScreen].infoblocks[v2].infotype,
							screens[showScreen].infoblocks[v2].infokey);
    };
    if (v1 == "Prefs") {
        OnMenuAlternative("OpenPreferences()");
    };
    if (v1 == "Help") {
        OnMenuAlternative("LaunchHelp()", "../../");
    };
    if (v1 == "Tutorial") {
        OnMenuAlternative("LaunchTutorial()");
    };
    if (v1 == "CloseT") {
        OnClose();
    };
    if (v1 == "CloseW") {
        CloseAction();
    };
    if (v1 == "Resume") {
        OnMenuAlternative("Menu_Resume()");
    }
    if (v1 == "Printit") {
        OnMenuAlternative("ShowPrintit()");
    }
};


function CorrectPopup() {
    try {
        obj = binterf.GetActionLink();
        h = obj.offsetHeight;
        popupMenu.show(0, h, 0, 0, obj);
        sp = popupMenu.getElementById('actionspan');
        hsp = sp.offsetHeight;
        wsp = sp.offsetWidth;
        popupMenu.show(0, h, wsp + 20, hsp + 20, obj);
    } catch (e) { };
    this.onScreen = true;

}

function IsNotIE() {
    var bi = new BrowserInfo();
    GetBrowserInfo(bi);
    return bi.name != "MSIE";
}

function PopupToggle(div) {
    if (popupMenu.getElementsByTagName('DIV')[1].style.display == "none") {
        if (IsNotIE()) {
            if (fullength > 100)
                popupMenu.style.width = "" + (fullength + 40) + "px";
        }
        popupMenu.getElementsByTagName('DIV')[1].style.display = "block";
        showAttachments = true;
    }
    else {
        if (IsNotIE()) {
            popupMenu.style.width = "140px";
        }
        popupMenu.getElementsByTagName('DIV')[1].style.display = "none";
        showAttachments = true;
    }

    CorrectPopup();
};

function _ARefresh(next, prev, first, alt, changeconcept, changeinfo, frompref, printit) {
    if (!this.onScreen)
        return;

    var s = "";
    if (alt)
        s += "<div id='actionspan' style='font:8pt Arial; width:160' nowrap=yes>";
    else
        s += "<div id='actionspan' style='font:8pt Arial; width:100' nowrap=yes>";
    s += "<a href='#'></a>";
    if (playMode == "T") {
        if (next) {
            s += "<li><a href='#' onclick='OnActionSelection(\"Next\");return false;'>";
            s += R_menu_nextstep;
            s += "</a></li>";
        };
        if (prev) {
            s += "<li><a href='#' onclick='OnActionSelection(\"Prev\");return false;'>";
            s += R_menu_prevstep;
            s += "</a></li>";
        };
        if (first) {
            s += "<li><a href='#' onclick='OnActionSelection(\"Start\");return false;'>";
            s += R_menu_start;
            s += "</a></li>";
        };
        if (alt) {
            s += "<li><a href='#' onclick='OnActionSelection(\"Alt\");return false;'>";
            s += R_menu_alternatives;
            s += "</a></li>";
            popupMenu.style.width = "170px";
        };

        var i = 0;
        if (concepts.length > 0) {
            s += "<li>";
            s += "<a href='#' onclick='OnActionSelection(\"Conc\",\"0\");return false;'>";
            s += R_menu_concepts;
            s += "</a></li>";
        };

        if (screens[showScreen].infoblocks.length > 0) {
            s += "<li><a href='#' onclick='PopupToggle(\"infodiv\")'>";
            s += R_menu_infoblocks;
            s += "</a></li>";
            s += "<div id='infodiv' style='display:none'>";
            if (IsNotIE()) {
                for (i = 0; i < screens[showScreen].infoblocks.length; i++) {
                    document.getElementById("_myspan_").innerHTML = fixHTMLString(screens[showScreen].infoblocks[i].tooltip);
                    var fw = document.getElementById("_myspan_").offsetWidth;
                    if (fullength < fw) {
                        fullength = fw;
                    }
                    document.getElementById("_myspan_").innerHTML = "";
                }
            }
            for (i = 0; i < screens[showScreen].infoblocks.length; i++) {
                if (IsNotIE())
                    s += "<li style='list-style-type:circle;text-indent:18px; width: " + (fullength + 40) + "px;'>";
                else
                    s += "<li style='list-style-type:circle;text-indent:18px; width: 140px;'>";
                s += "<a href='#' onclick='OnActionSelection(\"Info\",";
                s += "" + i;
                s += ");return false;'>";
                s += fixHTMLString(screens[showScreen].infoblocks[i].tooltip);
                s += "</a></li>";
            };
            s += "</div>";
        };
    };

    ///// works in seeit only

    if (playMode == "S") {
        s += "<li><a href='#' onclick='OnActionSelection(\"Resume\");return false;'>";
        s += R_interface_resume;
        s += "</a></li>";
    }

    if (playMode == "T" || playMode == "S") {
        if (printit) {
            s += "<li><a href='#' onclick='OnActionSelection(\"Printit\");return false;'>";
            s += R_interface_printit;
            s += "</a></li>";
        }
    }


    ///// works in tryit and knowit and seeit
    if (systemEnableCookies && UserPrefs.EnablePreferences) {
        s += "<li><a href='#' onclick='OnActionSelection(\"Prefs\");return false;'>";
        s += R_menu_preferences;
        s += "</a></li>";
    };
    s += "<li><a href='#' onclick='OnActionSelection(\"Help\");return false;'>";
    s += R_menu_help;
    s += "</a></li>";

    if (!Disable_Tutorial) {
        s += "<li><a href='#' onclick='OnActionSelection(\"Tutorial\");return false;'>";
        s += R_menu_tutorial;
        s += "</a></li>";
    }

    s += "<li><a href='#' onclick='OnActionSelection(\"CloseT\");return false;'>";
    s += R_menu_Close;
    s += "</a></li>";

    s += "</span>";


    //popupMenu.document.body.innerHTML=s;
    popupMenu.innerHTML = s;

    sH = document["screenshot"].clientHeight;
    if (popupMenu.offsetTop + popupMenu.clientHeight > sH) {
        popupMenu.style.top = "" + (sH - popupMenu.clientHeight) + "px";
    }

    sW = document["screenshot"].clientWidth;
    if (popupMenu.offsetLeft + popupMenu.clientWidth > sW) {
        popupMenu.style.left = "" + (sW - popupMenu.clientWidth) + "px";
    }

    setTimeout('try{popupMenu.document.all["actfocus"].focus();}catch(e){};', 100);
    //	obj=document.all('screen');
    //	popupMenu.show(100,150,230,360,obj);

    CorrectPopup();
};

function popupMenuHide() {
    if (showAttachments == true) {
        showAttachments = false
        actionMenu.onScreen = true;
    }
    else {
        popupMenu.style.display = 'none';
    }
}

function _AIsOnScreen() {
    return this.onScreen;
};