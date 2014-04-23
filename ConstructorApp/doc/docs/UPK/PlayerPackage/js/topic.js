/*--
Copyright © 1998, 2009, Oracle and/or its affiliates.  All rights reserved.
--*/
//	V: 47 LM: 10/23/2002 by lw
//	V: 52 LM: 10/28/2002 by gh
//	Aladdin closed...
//	V: 123 LM: 11/04/2003 by gh
//	Barbary Coast closed...
//	V: 173 LM: 01/10/2005 by gh 

///////// User defined area for knowit mode ///////////

// variables
var ShowScoreNeeded = true; // false -> scoring requirements are suppressed

var KnowIt_Validated_StringInput = true;
var TryIt_Validated_StringInput = false;

var PreloadScreen_Enabled = true;

var Hide_Click_Mark = false;

//variables for tracking
var trackArgList;        // An array of strings contains the parameter list of the url
var trackScoreCompleted; // A number contains the result in percent
var trackScoreRequired;  // A number contains the required result defined by database in percent
var trackFeedBack = true;   // If false, scoring screen doesn`t appear in the end of topic
// user can define additional variables (called track...) used by following functions e.q. trackTime

//JZ - Start
var SpecMode = "N";
var AICC_STORM_Completed = false;
//JZ - End

function trackOnBegin()
// called by the begin of the track in Knowit mode
// trackArgList is reachable -> user can parse and interpret his own parameters, init variables etc.
{
    // KP related code ///////////////////
    for (var i = 0; i < trackArgList.length; i++) {
        strArg = trackArgList[i];
        if (strArg.substr(0, 9) == "kpfeedbk=") {
            trackFeedBack = (strArg.substr(9) == "0" ? false : true);
            ShowScoreNeeded = trackFeedBack;
            // trackFeedBack is able to suppress the ShowScoreNeeded setting!!!
        }
    };
    // End of KP related code ////////////	
};

function trackComplete()
// called by the end of the track in Knowit mode after the topic is complete
// trackArgList, trackScoreCompleted, trackScoreRequired are reachable
{
    // KP related code ///////////////////
    var kpnextpage = "";
    for (var i = 0; i < trackArgList.length; i++) {
        strArg = trackArgList[i];
        if (strArg.substr(0, 11) == "kpnextpage=") {
            kpnextpage = strArg.substr(11);
        }
    };
    if (kpnextpage.length > 0) {
        var answer = "" + trackScoreCompleted + "%";
        var score = 0;
        if (trackScoreCompleted >= trackScoreRequired)
            score = 1;
        var newloc = "";
        if ((kpnextpage.indexOf("?") >= 0) || (kpnextpage.indexOf("#") >= 0)) {
            newloc = kpnextpage + "&score=" + score + "&answer=" + answer;
        }
        else {
            newloc = kpnextpage + "?score=" + score + "&answer=" + answer;
        }
        if (window.parent.opener)
            window.parent.opener.location.href = newloc;
    };
    // End of KP related code ////////////	
};

function trackIncomplete()
// called by the end of the track in Knowit mode by mid topic exit
// trackArgList, trackScoreCompleted, trackScoreRequired are reachable
{
    // KP related code ///////////////////
    // End of KP related code ////////////	
};

///////// End of the User defined area ////////////////

var guidedParent = null;
if (top.window.opener) {
    try {
        if (!top.window.opener.closed) {
            if (top.window.opener.GIPlayer) {
                guidedParent = top.window.opener.GIPlayer;
            }
        }
    }
    catch (e) { };
}

var playMode = "S"
var fatPlayer = ""
var param_frame = ""
var param_ctx = ""
var param_ecid = ""
var param_printitname = "";
var param_windowed = false;

var screenshotPath = "";

var DEF_KWARNINGSCORELEVEL = 1; // defines the level where the step not accepted
var KWarningLevel = 0;
var KScoreNeeded = 80;
var KTopicFinished = false;
var soundIsExported = false;
var KWrongScreens = new Array();
var KScoringScreen = false;
var KConfirmDemo = false;
var KConfirmCheckBox = true;
var KFinishClose = false;
var KContinueFlag = 0; // 1, after guest demo playing
var KGuestDemoMode = 0;
var tutorialMode = false;
var KRemediation1 = true;
var KRemediation2 = true;
var KRemediation3 = true;

var binterf = 0;
var def_PLAYER_CLOSE = "PLAYER_CLOSE"
var def_TMP_BEGIN = "###TMP_BEGIN###";
var def_TMP_END = "###TMP_END###";

var NS4 = (navigator.appName == "Netscape" && parseInt(navigator.appVersion) == 4)

var screens = new Array()
var screenNames = new Array()
var currentScreenObj
var currentscreenName
var FirstScreenName = ""
var showLeadIn = 2; // 0 -> hide, 1 -> show, other -> defined by cookies
var firsthemialternativeindex = 0;

var concepts = new Array()
var preloadImages = new Array();

var showScreen = ""
var showAct = 0

var moduleName = "";
var topicName = unescape(document.title);
var topicShowBubbles = "";

var StartAction = 0;

var Rem1_minimum = 200;
var Rem2_minimum = 250;
var Rem4_width = 300;

function DummyObj() {
    this.type = "";
};
var showActObj = new DummyObj();

var showActInpObj
var showHistory = new Array()
var historyActionMap = new Array()
//var isTabbed = false
var isPaused = false

var DELAY_MOUSE = 100
var DELAY_BULLSEYE = 150
var DELAY_INPUT = 200
var DELAY_DOUBLECLICK = 300
var DELAY_WHEEL = 500
var DELAY_PAUSED = 500

var DELAY_INFINITE = 999
var MOUSE_STEP = 25

var scrH = 0;
var scrW = 0;

var animTimeout;
var bullsTimeout;
var animPhase = ""
var animCmd = ""
var animSteps = 0
var animStepOriginal = 0
var anim_x, anim_y
var anim_to_x, anim_to_y

var screenshot = new Image();
var event_blocked;

var animObject;

function InputOnFocus() {
    if (showActInpObj)
        showActInpObj.hasfocus = true;
}

function InputOnBlur() {
    if (showActInpObj)
        showActInpObj.hasfocus = false;
}

function FocusMe() {
    try {
        window.focus();
    }
    catch (e) { };
};

function FocusInpObj() {
    if (showActInpObj) {
        try {
            showActInpObj.focus();
        }
        catch (e) { };
        var cObjID = showActInpObj.id;
        var cObj = document.getElementById(cObjID);
        var txt = cObj.text;
        cObj.text = txt;
        /*
        var txtRange=showActInpObj.createTextRange()
        var txt=txtRange.text;
        txtRange.text=txt;
        */
        try {
            showActInpObj.select();
        }
        catch (e) { };
    };
}

function OnFocus() {
    if (!showActObj)
        return;
    if (showActObj.type) {
        if (showActObj.type == 'Input') {
            if (showActInpObj)
                setTimeout("FocusInpObj()", 10);
        };
    };
};

function OnBubbleMoved() {
    OnFocus();
};

function OnBubbleClicked() {
    if (actionMenu) {
        if (actionMenu.IsOnScreen()) {
            actionMenu.Close();
        };
    }
};

function AnimObject(cmd, timeout, phase) {
    this.cmd = cmd;
    this.timeout = timeout;
    this.phase = phase;
};

function IsLeadIn(o) {
    if (o == null)
        o = showActObj;
    return (screens["start"].actions[0].id == o.id);
};

function IsLeadOut(o) {
    if (o == null)
        o = showActObj;
    return (o.nextFrame == "end");
};

function IsDecision(o) {
    if (o == null)
        o = showActObj;
    return (o.type == "Decision");
};

function IsExplanation(o) {
    if (o == null)
        o = showActObj;
    if (IsLeadIn(o) || IsLeadOut(o))
        return false;
    return (o.type == "None");
};

function IsActionFrame(o) {
    if (o == null)
        o = showActObj;
    return (o.type == "Normal");
}

function StoredEvent(x, y, shiftState, buttonID) {
    this.storedEvent = true;
    this.pX = x;
    this.pY = y;
    this.pShState = shiftState;
    this.pButton = buttonID;
};

function AddToWrongScreens(id) {
    for (var i = 0; i < KWrongScreens.length; i++) {
        if (KWrongScreens[i] == id)
            return;
    };
    KWrongScreens[KWrongScreens.length] = id;
};

function GetResultInPercent(unfinished) {
    var allsteps = showHistory.length - 2;
    var wrongsteps = KWrongScreens.length;
    if (!unfinished) {
    }
    else {
        if (!IsLeadOut()) {
            var myscr = screens[showScreen];
            var id = myscr.actions[0].nextFrame;
            while (id != "end") {
                if (myscr.type != "decision" && myscr.type != "none") {
                    allsteps++;
                    wrongsteps++;
                };
                myscr = screens[id];
                id = myscr.actions[0].nextFrame;
            };
        };
    };
    if (allsteps == 0)
        return 100;
    return Math.round(100 - ((wrongsteps / allsteps) * 100));
};

function StartDemoInKnowIt() {
    if (!IsDragBegin)
        AddToWrongScreens(showScreen);
    KGuestDemoMode = 1;
    binterf.SetMoveable(false);
    setTimeout("ShowScreen(showScreen)", 200);
};

function HLink(s) {
    if (playMode == "T")	// 0 -> leadin, 1 -> leadout, 2 -> explanation
    {
        if (s == 0 || s == 1 || s == 2) {
            HLinkStart = true;
            TeacherForward(true);
        }
        else if (s == 13)		// typingcomplete
        {
            if (AssessStringInput(true)) {
                TeacherForward(true);
            }
            else {
                TeacherWrong();
            };
        }
        else if (s == 130) {
            UpdateDoneTyping(false);
        }
        else if (s == 131) {
            UpdateDoneTyping(true);
        };
    }
    else if (playMode == "S") // 0 -> leadin, 1 -> leadout
    {
        if (s == 0 || s == 1 || s == 2) {
            DemoForward();
        }
        else if (s == 600)	// pause/resume link pressed in seeit
        {
            PauseToggle();
        }
    }
    else	// playMode=="K"	
    {
        if (s == 0 || s == 1)	// leadin, leadout
        {
            HLinkStart = true;
            TeacherForward(true);
        }
        else if (s == 2)	// nextstep
        {
            if (KWarningLevel < DEF_KWARNINGSCORELEVEL && KConfirmCheckBox) {
                HideAction();
                KConfirmDemo = true;
                ShowAction();
                return;
            }
            else if (KWarningLevel < DEF_KWARNINGSCORELEVEL && !KConfirmCheckBox) {
                AddToWrongScreens(showScreen);
            };
            StartDemoInKnowIt();
        }
        else if (s == 10)		// ok button on level 4 panel
        {
            StartDemoInKnowIt(); ;
        }
        else if (s == 11)		// yes on confirm panel
        {
            KConfirmDemo = false;
            AddToWrongScreens(showScreen);
            StartDemoInKnowIt();
        }
        else if (s == 110) {
            UpdateYesNo(false, false);
            //document.images["bbyes"].src="yes0.gif";
        }
        else if (s == 111) {
            UpdateYesNo(true, false);
            //document.images["bbyes"].src="yes1.gif";
        }
        else if (s == 12)		// no on confirm panel
        {
            HideAction();
            KConfirmDemo = false;
            ShowAction();
        }
        else if (s == 120) {
            UpdateYesNo(false, false);
            //document.images["bbno"].src="no0.gif";
        }
        else if (s == 121) {
            UpdateYesNo(false, true);
            //document.images["bbno"].src="no1.gif";
        }
        else if (s == 13)		// typingcomplete
        {
            if (AssessStringInput(true)) {
                TeacherForward(true);
            }
            else {
                TeacherWrong();
            };
        }
        else if (s == 130) {
            UpdateDoneTyping(false);
        }
        else if (s == 131) {
            UpdateDoneTyping(true);
        }
        else if (s == 125) {
            KConfirmCheckBox = !KConfirmCheckBox;
            /*		
            if (document.all["KConfCB"].checked)
            {
            KConfirmCheckBox=false;
            }
            else
            {
            KConfirmCheckBox=true;
            }
            */
        }
        else if (s == 20)		// finish
        {
            ClosePlayer(1);
        }
        else if (s == 30)		// drag&drop start
        {
            StartDemoInKnowIt(); ;
        }
        else if (s == 400)	// print site
        {
            if (trackSent)
                return;
            var passed = GetResultInPercent();

            var moduledesc = R_module + moduleName;
            //			var topicdesc= R_topic + escape(document.title);
            //			var topicdesc= R_topic + encodeURIComponent(document.title);
            //			var topicdesc= R_topic + document.title;

            if (fatPlayer == "FS" || fatPlayer == "WEB") {
                var topicdesc = encodeURIComponent(R_topic + topicName);
                var s = "ModuleDesc=" + encodeURIComponent(moduledesc);
                s += "&TopicDesc=" + topicdesc;
                s += "&PctComplete=" + passed;
                s += "&PctNeeded=" + KScoreNeeded;
                s += "&w=800&h=600&l=147&t=131";
                FatPlayerCommand("CERTIFICATION_START", s);
            }
            else {
                page = window.open("../../certificate/certificate.html" +
							"#ModuleDesc=1" +
							"&TopicDesc=1" +
							"&PctComplete=" + passed +
							"&PctNeeded=" + KScoreNeeded,
							'print',
							'toolbar=1,scrollbars=0,location=0,statusbar=0,menubar=0,resizable=0,width=800,height=600,left=147,top=131');
            };
        }
        else if (s == 500)	// exit on finish/close panel
        {
            ClosePlayer();
        }
        else if (s == 501)	// remain on finish/close panel
        {
            HideAction();
            KFinishClose = false;
            ShowAction();
        }
        else if (s == 600)	// pause/resume link pressed in seeit
        {
            PauseToggle();
        }
    };
};

function Certification_GetModuleName() {
    return (R_outline + moduleName);
}

function Certification_GetTopicName() {
    return (R_topic + topicName);
}

function OnClose() {
    if (playMode == "K") {
        if (IsLeadOut()) {
            if (KScoringScreen) {
                ClosePlayer(1);
            }
            else {
                HLink(1);
            };
            return;
        };
        HideAction();
        KFinishClose = true;
        ShowAction();
    }
    else {
        ClosePlayer();
    };
};

var actionMenu = 0;
var closedbyEnter = false;

function OnAction() {
    if (closedbyEnter) {
        closedbyEnter = false;
        return;
    };
    if (actionMenu) {
        if (actionMenu.IsOnScreen()) {
            actionMenu.Close();
            return true;
        };
    }
    if (playMode == "T" || (playMode == "K" && KGuestDemoMode == 0)) {
        if (actionMenu == 0)
            actionMenu = new ActionMenu();
        actionMenu.Open();
        RefreshActionMenu();
    };
    if (playMode == "S" || (playMode == "K" && KGuestDemoMode > 0)) {
        if (!isPaused)
            PauseToggle();
        if (actionMenu == 0)
            actionMenu = new ActionMenu();
        actionMenu.Open();
        RefreshActionMenu();
    };
};

function OnAlternative() {
    TeacherAlter();
};

function RefreshActionMenu(changeconcept, changeinfo, frompref) {
    if (actionMenu) {
        var next = (showActObj.nextFrame != "end" && showActObj.type != "Decision");
        if (!UserPrefs.TryIt.EnableSkipping)
            next = false;
        var prev = (showHistory.length > 1);
        var alt = (screens[showScreen].actions.length > 1 && showActObj.type != "Decision");
        var printit = param_printitname.length > 0;
        actionMenu.Refresh(next, prev, prev, alt, changeconcept, changeinfo, frompref, printit);
    };
};

function OnMenuAlternative(s, p1, p2, p3, p4) {
    CloseAction();
    if (p1 != null && p2 == null) {
        LaunchHelp(p1);
    }
    else {
        eval(s);
    }
};

function LaunchHelp(s) {
    onHelp(s);
    return;
    var fat = (fatPlayer == "FS" || fatPlayer == "WEB");
    OpenHelp(s, fat);
};

function CloseAction(notfocus) {
    if (actionMenu)
        actionMenu.Close();
    if (!notfocus)
        FocusMe();
};

function ShowPrintit() {
    if (param_printitname.length > 0)
        window.open("../../printit/" + param_printitname, "", "fullscreen=0");
}

////////////////////////////////////////////////////////////////////////

function LaunchTutorial() {
    //setTimeout("RunTutorialDialog(playMode,1,'../../')",350);
};

function OpenPreferences() {
    var s = window.location;
    var nosound = !SoundPlayerObj.IsAvailable();
    OpenPreferencesDialog("../..", nosound);
};

function Menu_Resume() {
    if (isPaused)
        PauseToggle();
}

function InsertStart() {
    var c = new Array();
    for (var i = 0; i < showHistory.length; i++)
        c[c.length] = showHistory[i];
    showHistory = new Array();
    showHistory[0] = "start";
    for (var i = 0; i < c.length; i++)
        showHistory[showHistory.length] = c[i];
};

function DeleteStart() {
    var c = new Array();
    for (var i = 0; i < showHistory.length; i++)
        c[c.length] = showHistory[i];
    showHistory = new Array();
    for (var i = 1; i < c.length; i++)
        showHistory[showHistory.length] = c[i];
};

function OnUpdatePreferences(userpref) {
    UserPrefs.Copy(userpref);
    if ((showLeadIn == 1) || (userpref.ShowLeadIn == "all" && showLeadIn != 0)) {
        if (showHistory.length > 0) {
            if (showHistory[0] != "start") {
                // insert
                InsertStart();
            };
        };
    }
    else {
        if (showHistory.length > 0) {
            if (showHistory[0] == "start") {
                // delete
                DeleteStart();
            };
        };
    };
    try {
        if (opener.OnUpdatePreferences)
            opener.OnUpdatePreferences(userpref);
    }
    catch (e) { };
    //	RefreshActionMenu(false,false,true);
    //	SetActionColor();
};

//////////////////////////////////////////////////////
// DownloadImage function

function DownloadImage_(image, url, vfnRet) {
    image.user_url = Format(url);
    image.user_retFn = vfnRet;
    image.onload = Loaded_;
    image.onerror = LoadError_;
    image.src = url;
};

function Loaded_() {
    var s;
    s = this.user_retFn + '("' + this.user_url + '",true)';
    eval(s);
};

function LoadError_() {
    var s;
    s = this.user_retFn + '("' + this.user_url + '",false)';
    eval(s);
};

function Format(s) {
    var ss = "";
    for (i = 0; i < s.length; i++) {
        var c = s.charAt(i);
        if (c == "\\") {
            ss += "\\\\";
        }
        else {
            ss += c;
        };
    };
    return ss;
};

function GetImage(image, url) {
    if (preloadImages[url])
        image.src = preloadImages[url].src;
};

function DownloadImage(url, vfnret) {
    if (!preloadImages[url]) {
        PreloadImage(url);
    };
    WaitForImage(url, vfnret);
};

function WaitForImage(url, vfnret) {
    var s;
    if (preloadImages[url].loaded) {
        s = vfnret + '("' + preloadImages[url].user_url + '",true)';
        eval(s);
        return;
    };
    if (preloadImages[url].error) {
        s = vfnret + '("' + preloadImages[url].user_url + '",false)';
        eval(s);
        return;
    };
    s = "WaitForImage('" + url + "','" + vfnret + "');";
    setTimeout(s, 300);
};

function PreloadImage(url) {
    if (preloadImages[url])
        return;
    preloadImages[url] = new Image();
    preloadImages[url].loaded = false;
    preloadImages[url].error = false;
    DownloadImage_(preloadImages[url], url, "Preload_Return");
};

function Preload_Return(url, success) {
    if (success)
        preloadImages[url].loaded = true
    else
        preloadImages[url].error = true;
};

// DownloadImage end //////////////////////////////////////

//
// Topic object model
//

function ScreenObj(image, showBubble) {
    this.image = image;
    this.showBubble = showBubble;
    this.actions = new Array();
    this.infoblocks = new Array();
    this.emptyinfo = true;
}

function Screen(id, image, showBubble) {
    var scr = new ScreenObj(image, showBubble)
    screens[id] = scr
    currentScreenObj = scr
    screenNames[screenNames.length] = id;
    currentScreenName = id;
}

function FilterTryItText(text) {
    var ss = text;
    var s = ss.toLowerCase();

    var l = true;
    while (l) {
        l = false;
        var k1, k2;
        for (var i = 0; i < s.length; i++) {
            if (s.substr(i, 5) == "href=") {
                l = true;
                k1 = i;
                break;
            };
        };
        if (l) {
            k2 = 0
            for (var j = i; j < s.length; j++) {
                if (s.substr(j, 7) == "hrefend") {
                    k2 = j + 10;
                    break;
                };
            };
            if (k2 > 0) {
                var sss = ss;
                ss = sss.substr(0, k1) + sss.substr(k2);
                s = ss.toLowerCase();
            }
            else {
                l = false;
            }
        };
    };

    s = ss;

    l = true;
    while (l) {
        l = false;
        var k1, k2;
        for (var i = 0; i < s.length; i++) {
            if (s.substr(i, 6) == "title=") {
                l = true;
                k1 = i;
                break;
            };
        };
        if (l) {
            k2 = 0
            for (var j = i; j < s.length; j++) {
                if (s.substr(j, 8) == "titleend") {
                    k2 = j + 11;
                    break;
                };
            };
            if (k2 > 0) {
                var sss = ss;
                ss = sss.substr(0, k1) + sss.substr(k2);
                s = ss.toLowerCase();
            }
            else {
                l = false;
            }
        };
    };

    return ss;
};

function IsTextEmpty(s) {
    var status = true;
    for (var i = 0; i < s.length; i++) {
        var c = s.substr(i, 1);
        if (status == true) {
            if (c == "<")
                status = false
            else if (s.charCodeAt(i) != 13 && s.charCodeAt(i) != 10)
                return false;
        }
        else {
            if (c == ">")
                status = true;
        };
    };
    return true;
}

function Replace(str, s, r) {
    var l = s.length;
    var k = str.indexOf(s);
    if (k < 0)
        return str;
    var s1 = str.substr(0, k);
    var s2 = str.substr(k + l);
    return (s1 + r + s2);
};

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

function BuildInputText(aobj, templatetext) {
    var display_anything = false;
    var display_example = false;
    var display_inputtext = false;
    var display_inputalt = false;
    var display_blank = false;

    if ((playMode == "S") || (playMode == "T" && !TryIt_Validated_StringInput) || (playMode == "K" && !KnowIt_Validated_StringInput))
        display_inputtext = true
    else if (aobj.par1[0] == "S") {
        display_anything = true;
        if (template_strinp_suppress_example == "<span>0</span>") {
            display_example = true;
            display_inputtext = true;
        }
    }
    else if (aobj.par1[0] == "A") {
        display_anything = true;
        display_blank = true;
        if (template_strinp_suppress_example == "<span>0</span>") {
            display_example = true;
            display_inputtext = true;
        }
    }
    else if (aobj.par1[0] == "N") {
        display_inputtext = true;
        display_inputalt = true;
        display_blank = true;
    }
    else {
        display_inputtext = true;
        display_inputalt = true;
    }

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

function ToHalfWidth(str) {
    var halfKatakanaSet = "ｦｧｨｩｪｫｬｭｮｯｰｱｲｳｴｵｶｷｸｹｺｻｼｽｾｿﾀﾁﾂﾃﾄﾅﾆﾇﾈﾉﾊﾋﾌﾍﾎﾏﾐﾑﾒﾓﾔﾕﾖﾗﾘﾙﾚﾛﾜﾝ";
    var fullKatakanaSet = "ヲァィゥェォャュョッーアイウエオカキクケコサシスセソタチツテトナニヌネノハヒフヘホマミムメモヤユヨラリルレロワン";

    var result = "";

    for (var i = 0; i < str.length; i++) {
        var k = fullKatakanaSet.indexOf(str.charAt(i));
        if (k != -1)
            result += halfKatakanaSet.charAt(k)
        else if (str.charCodeAt(i) >= 0xff01 && str.charCodeAt(i) <= 0xff5f)
            result += String.fromCharCode(str.charCodeAt(i) - 0xfee0)
        else
            result += str.charAt(i);
    }

    return result;
}

function StartsWith(s, prefix) {
    if (s.length < prefix.length)
        return false;
    var prlow = prefix.toLowerCase();
    var sp = s.substr(0, prefix.length);
    var slow = sp.toLowerCase();
    if (slow == prlow)
        return true;
    return false;
}

function RemoveNbsp(s)
// Remove &nbsp; characters from bubbletext, except the leadin characters in every paragraphs
{
    var status = 0;
    var output = "";
    var i = 0;
    while (i < s.length) {
        snext = s.substr(i);

        switch (status) {
            case 0: 		// search <p
                if (StartsWith(snext, "<P")) {
                    output += snext.substr(0, 2);
                    i += 2;
                    status = 1;
                }
                else {
                    output += snext.substr(0, 1);
                    i++;
                }
                break;
            case 1: 		// search first <font
                if (StartsWith(snext, "<font")) {
                    output += snext.substr(0, 5);
                    i += 5;
                    status = 2;
                }
                else {
                    output += snext.substr(0, 1);
                    i++;
                }
                break;
            case 2: 		// search > (close first font)
                if (StartsWith(snext, ">")) {
                    output += snext.substr(0, 1);
                    i += 1;
                    status = 3;
                }
                else {
                    output += snext.substr(0, 1);
                    i++;
                }
                break;
            case 3: 		// first npsb-s
                if (StartsWith(snext, "&nbsp;")) {
                    output += snext.substr(0, 6);
                    i += 6;
                }
                else {
                    output += snext.substr(0, 1);
                    i++;
                    status = 4;
                }
                break;
            case 4: 		// search </p
                if (StartsWith(snext, "&nbsp;")) {
                    output += " ";
                    i += 6;
                }
                else if (StartsWith(snext, "</p")) {
                    output += snext.substr(0, 3);
                    i += 3;
                    status = 5;
                }
                else {
                    output += snext.substr(0, 1);
                    i++;
                }
                break;
            case 5: 		// search > (close p)
                if (StartsWith(snext, ">")) {
                    output += snext.substr(0, 1);
                    i += 1;
                    status = 0;
                }
                else {
                    output += snext.substr(0, 1);
                    i++;
                }
                break;
        }

    }
    return output;
}

function DummyActionObj(id, nextFrame, hotspots, type, par1) {
    this.realAction = false;
    this.id = id;
    this.nextFrame = nextFrame;
    this.hotspots = hotspots;
    this.type = type;
    this.par1 = par1;
}

function AddDummyActions(actArray, a) {
    if (IsMacOs()) {
        if (IsFF()) {
            if (a.type == "RClick1" && a.par1 == "") { // mac ff
                actArray[actArray.length] = new DummyActionObj(a.id, a.nextFrame, a.hotspots, "RClick1", "c");
            }
            if (a.type == "LClick1" && a.par1 == "c") { // mac ff
                actArray[actArray.length] = new DummyActionObj(a.id, a.nextFrame, a.hotspots, "RClick1", "c");
            }
        }
        if (IsSafari()) {
            if (a.type == "RClick1" && a.par1 == "") { // mac safari
                actArray[actArray.length] = new DummyActionObj(a.id, a.nextFrame, a.hotspots, "LClick1", "c");
            }
            if (a.type == "RClick1" && a.par1 == "c") { // mac safari
                actArray[actArray.length] = new DummyActionObj(a.id, a.nextFrame, a.hotspots, "LClick1", "c");
            }
        }
    }
}

function ActionObj(id, nextFrame, hotspots, bubpos, xpos, ypos, width, height, kwidth, kheight, ctx, ecidarray, type, delay, par1, par2, par3, iconname,
					bubcolor, tryittext, knowittext, templatetext, fonttext,
					bubtextfirst, knowitflag)
// tryittext -> text for simulated modes
// knowittext -> text for knowit mode
// templatetext -> templatetext
// fonttext -> font information for every texts
// bubtextfirst -> use tryittext/knowittext before templatetext
// knowitflag -> show also templatetext on level 0, 1
{
    this.realAction = true;
    tryittext = RemoveNbsp(tryittext);
    knowittext = RemoveNbsp(knowittext);
    //	tryittext=replaceString("&nbsp;"," ",tryittext)
    //	knowittext=replaceString("&nbsp;"," ",knowittext)
    if (!knowittext)
        knowittext = "";
    if (IsTextEmpty(knowittext))
        knowittext = "";
    if (!templatetext)
        templatetext = "";
    this.id = id
    this.nextFrame = nextFrame
    this.hotspots = hotspots;
    this.bubpos = bubpos;
    this.xpos = xpos;
    this.ypos = ypos;
    this.width = width;
    this.height = height;
    this.kwidth = kwidth;
    this.kheight = kheight;
    this.ctx = ctx;
    this.ecidarray = ecidarray;

    if (this.ecidarray) {
        for (var i = 0; i < this.ecidarray.length; i++) {
            s = this.ecidarray[i];
            var k = s.indexOf('$');
            sapp = s.substr(0, k + 1);
            sctx = Gkod.Escape.MyEscape(s.substr(k + 1));
            s = sapp + sctx;
            this.ecidarray[i] = s;
        }
    }

    this.type = type
    this.delay = delay
    this.par1 = par1;
    try {
        this.par1[1] = DecodeTagElements(par1[1]);
    }
    catch (e) { }
    this.par2 = par2
    this.par3 = par3
    this.par4 = false	// input edit has been started
    this.lastIMEtext == "";
    this.par5 = ""	// input edit text
    this.iconname = iconname;
    this.bubcolor = bubcolor;

    var fontbegin = "<font " + fonttext + ">";
    var fontend = "</font>";

    this.fontbegin = fontbegin;
    this.fontend = fontend;

    var s;
    var ss;
    //////////////////////////	 text -> for simulated modes & K mode Level 2,3

    if (playMode == "S" && type != "Decision") {
        s = FilterTryItText(tryittext);
        tryittext = s;
    };

    if (this.type == "Input" && templatetext.length > 0) {
        templatetext = BuildInputText(this, templatetext);
    };

    if (tryittext.length == 0 && templatetext.length == 0) {
        s = "";
    }
    else if (tryittext.length == 0) {
        s = templatetext;
    }
    else if (templatetext == 0) {
        s = tryittext;
    }
    else {
        if (bubtextfirst)
        //			s=tryittext+"<br>"+templatetext
            s = tryittext + templatetext
        else
        //			s=templatetext+"<br>"+tryittext;
            s = templatetext + tryittext;
    };

    if (knowittext.length == 0 && templatetext.length == 0) {
        ss = "";
    }
    else if (knowittext.length == 0) {
        ss = templatetext;
    }
    else if (templatetext == 0) {
        ss = knowittext;
    }
    else {
        if (bubtextfirst)
        //			s=tryittext+"<br>"+templatetext
            ss = knowittext + templatetext
        else
        //			s=templatetext+"<br>"+tryittext;
            ss = templatetext + knowittext;
    };

    if (type == "None") {
        if (currentScreenName == "start" && playMode != "S") {
            s += "<br><p class='MsoNormal'>" + fontbegin + template_leadin + fontend + "</p>";
            if (ShowScoreNeeded)
                ss += "###KSCORE###";
            ss += "<br><p class='MsoNormal'>" + fontbegin + template_knowit_leadin + fontend + "</p>";
            this.delay = 999;
        }
        else if (nextFrame == "end" && playMode != "S") {
            s += "<br><p class='MsoNormal'>" + fontbegin + template_leadout + fontend + "</p>";
            ss += "<br><p class='MsoNormal'>" + fontbegin + template_knowit_leadout + fontend + "</p>";
            this.delay = 999;
        }
        else if (delay == 999) {
            if (playMode == "S")
                s += def_TMP_BEGIN + "<br><p class='MsoNormal'>" + fontbegin + template_explanation + fontend + "</p>" + def_TMP_END;
            else
                s += "<br><p class='MsoNormal'>" + fontbegin + template_explanation + fontend + "</p>";
            ss += "<br><p class='MsoNormal'>" + fontbegin + template_knowit_explanation + fontend + "</p>";
        }
        else if (!IsTextEmpty(s) && this.delay != 999 && playMode == "T") {
            s += "<br><p class='MsoNormal'>" + fontbegin + template_explanation + fontend + "</p>";
            this.delay = 999;
        };
    }
    else if (playMode == "S") {
        if (delay == 999) {
            if (type != "Decision") {
                s += def_TMP_BEGIN + "<br><p class='MsoNormal'>" + fontbegin + template_explanation + fontend + "</p>" + def_TMP_END;
            };
        };
    };
    //	this.text=fontbegin+s+fontend;
    if (IsTextEmpty(s))
        this.text = ""
    else
        this.text = s;
    this.emptytext = (this.text.length == 0);
    if (IsTextEmpty(ss))
        this.ktext = ""
    else
        this.ktext = ss;
    this.kemptytext = (this.ktext.length == 0);
    //////////////////////////	 knowittext -> for K mode Level 0,1
    s = "";
    if (!knowitflag)
        templatetext = "";
    if (knowittext.length == 0 && templatetext == 0) {
        s = "";
    }
    else if (knowittext.length == 0) {
        s = templatetext;
    }
    else if (templatetext == 0) {
        s = knowittext;
    }
    else {
        if (bubtextfirst)
        //			s=knowittext+"<br>"+templatetext
            s = knowittext + templatetext
        else
        //			s=templatetext+"<br>"+knowittext;
            s = templatetext + knowittext;
    };
    //	this.knowittext=fontbegin+s+fontend;
    this.knowittext = s;
}

function Action(id, nextFrame, hotspots, bubpos, xpos, ypos, width, height, kwidth, kheight, ctx, ecidarray, type, delay, par1, par2, par3, iconname, bubcolor,
					tryittext, knowittext, templatetext, fonttext, bubtextfirst, knowitflag) {
    // +++ add new params xpos,ypos
    if (currentScreenObj) {
        var actArray = currentScreenObj.actions;
        var a = new ActionObj(id, nextFrame, hotspots, bubpos, xpos, ypos, width, height, kwidth, kheight, ctx, ecidarray,
									type, delay,
									par1, par2, par3, iconname, bubcolor, tryittext, knowittext,
									templatetext, fonttext, bubtextfirst, knowitflag);
        actArray[actArray.length] = a;
        AddDummyActions(actArray, a);
    }
}

function InfoObj(buttonfile, url, tooltip, infotype, infokey) {
    this.buttonfile = buttonfile;
    this.url = url;
    this.tooltip = DecodeInputString(tooltip);
    if (isNaN(infotype))
        infotype = 999;
    this.infotype = infotype;
    this.infokey = infokey;
    this.simpleurl = url;
    this.width = 0;
    this.height = 0;
};

function InfoBlock(buttonfile, url, tooltip, infotype, infokey) {
    if (!tooltip)
        tooltip = "";
    if (currentScreenObj) {
        _buttonfile = buttonfile;
        _img = "infobitmapimage.gif";
        _sb = buttonfile.toLowerCase();
        if (_sb.substr(_sb.length - _img.length) == _img) {
            _buttonfile = buttonfile.substr(0, _sb.length - _img.length) + _img;
        }
        var infoArray = currentScreenObj.infoblocks;
        infoArray[infoArray.length] = new InfoObj(_buttonfile, url, tooltip, infotype, infokey);
        currentScreenObj.emptyinfo = false;
    };
};

function ConceptObj(url, width, height, text, infotype, infokey) {
    this.url = url;
    this.width = width;
    this.height = height;
    this.text = text;
    if (isNaN(infotype))
        infotype = 999;
    this.infotype = infotype;
    this.infokey = infokey;
};

function ConceptInfo(url, width, height, text, infotype, infokey) {
    concepts[concepts.length] = new ConceptObj(url, width, height, text, infotype, infokey);
};

//
// Demo mode animations
//

function Animate2(fname, demosound, cmd, timeout, phase) {
    animObject = new AnimObject(cmd, timeout, phase);
    if (KGuestDemoMode)
        Animate(cmd, timeout, phase)
    else {
        PlaySound(fname, demosound);
    };
};

function Animate(cmd, timeout, phase) {
    animCmd = cmd
    animPhase = phase
    if (timeout == DELAY_INFINITE * 100) {
        animPhase = "";
        return;
    };
    clearTimeout(animTimeout);
    animTimeout = setTimeout("AnimateTimer()", timeout)
}

function AnimateTimer() {
    if (animObject) {
        if (animObject.timeout == DELAY_INFINITE * 100) {
            animPhase = "";
            return;
        };
    };
    if (isPaused) {
        clearTimeout(animTimeout);
        animTimeout = setTimeout("AnimateTimer()", DELAY_PAUSED)
    }
    else
        eval(animCmd)
}

function AnimateKeyboard() {
    Animate2("stype.flv", true, "ShowScreen('" + showActObj.nextFrame + "')", DELAY_INPUT, "nostop")
};

function AnimateInput() {
    --animSteps

    Ds = DecodeInputString(showActObj.par1[1]);
    try {
        var a = Ds.length;
    }
    catch (e) {
        return;
    }
    //    if (IsSafari()) {
    //        showActInpObj.value = Ds.substr(0, Ds.length - animSteps);
    //        showActInpObj.original = showActInpObj.value;
    //        try {
    //            var txtRange = showActInpObj.createTextRange();
    //            txtRange.scrollIntoView(false);
    //        }
    //        catch (e) {
    //        }
    //    }
    //    else 
    {
        //LÉTREHOZOK EGY SZÁMLÁLÓT AZ ANIMÁLT SZTRING ELEJÉNEK VÁGÁSÁHOZ	
        if (typeof (trimAnimTxt) == 'undefined') {
            trimAnimTxt = 0;
        }

        if ((Ds.length - animSteps) == 1) {
            //AZ INPUT MEZŐRE ÁLLÁSKOR KINULLÁZOM A KEZDŐ STRINGET HELYÉT
            trimAnimTxt = 0;
            //KIOLVASOM A CSS FÁJLBÓL AZ INPUT MEZŐ FONT MÉRETÉT
            var dCss = document.styleSheets;
            for (var i in dCss) {
                if (dCss[i].cssRules) {
                    for (var j in dCss[i].cssRules) {
                        var selText1 = '.' + showActInpObj.className;
                        var selText2 = selText1.toLowerCase();
                        if (dCss[i].cssRules[j].selectorText == selText1 ||
                            dCss[i].cssRules[j].selectorText == selText2) {
                            iSDFontSize = dCss[i].cssRules[j].style.fontSize;
                            break;
                        }
                    }
                }
                else {
                    for (var j in dCss[i].rules) {
                        if (dCss[i].rules[j].selectorText == '.' + showActInpObj.className) {
                            iSDFontSize = dCss[i].rules[j].style.fontSize;
                            break;
                        }
                    }
                }
            }
        }

        showActInpObj.value = Ds.substr(trimAnimTxt, Ds.length - animSteps);
        showActInpObj.original = showActInpObj.value;

        //LÉTREHOZOK EGY OBJEKTUMOT A BEÍRT SZÖVEG VALÓDI HOSSZÁNAK ELLENŐRZÉSÉHEZ ÉS ÁTADOM NEKI AZ INPUT ÉRTÉKÉT
        try {
            iSD = document.getElementById('InpSizeDetect');
            iSD.innerHTML = showActInpObj.value
            iSD.style.fontSize = iSDFontSize;
        }
        catch (e) {
            var InpSizeDetect_ = document.createElement('SPAN');
            InpSizeDetect_.id = 'InpSizeDetect';
            InpSizeDetect_.style.fontFamily = 'arial';
            InpSizeDetect_.style.fontSize = iSDFontSize;
            InpSizeDetect_.style.paddingRight = '12px';
            InpSizeDetect_.style.visibility = 'hidden';
            document.body.appendChild(InpSizeDetect_);
            iSD = document.getElementById('InpSizeDetect');
        }

        //ELLENÖRZÖM , HOGY AZ ÚJ NODE - TARTALOMMAL NYÚLIK - SZÉLESSÉGE MEGHALADJA-E AZ INPUT MEZŐÉT
        //HA MEGHALADJA, AKKOR ELKEZDEM LEVÁGNI AZ STRING OBJEKTUM ELEJÉRŐL A KARAKTEREKET	
        if (iSD.offsetWidth >= showActInpObj.offsetWidth) {
            trimAnimTxt++;
        }
    }

    if ((DecodeInputString(showActObj.par1[1]).length - 1) == animSteps) {
        PlaySound_asyncron("strinput.flv");
    }

    if (animSteps > 0)
        Animate2("", true, "AnimateInput()", DELAY_INPUT, animPhase)
    else
        Animate2("", true, "ShowScreen('" + showActObj.nextFrame + "')", DELAY_INPUT, "nostop")
}

function ShowBullsEye() {
    if (Hide_Click_Mark != true)
        show("bullseye");
}

function HideBullsEye() {
    hide("bullseye");
}

function AnimateMouse() {
    var cx, cy

    animSteps--;
    if (animSteps >= 0) {
        cx = anim_to_x - animSteps * anim_x
        cy = anim_to_y - animSteps * anim_y
        if (!isNaN(cx) && !isNaN(cy)) {
            var sScreen = getDIV("screen");
            sx = sScreen.offsetLeft;
            sy = sScreen.offsetTop;
            shiftTo("cursor", cx, cy)
            shiftTo("bullseye", cx - sx - getObjWidth("bullseye") / 2, cy - sy - getObjHeight("bullseye") / 2)
        };
    };
    if (animSteps >= 0)
        Animate("AnimateMouse()", DELAY_MOUSE, animPhase)
    else {
        animSteps = parseInt(showActObj.type.substr(showActObj.type.length - 1, 1)) * 2
        if (animSteps > 0) {
            ShowBullsEye();
            if (animPhase != "")
                clearTimeout(animTimeout)
            Animate2("sclick.flv", true, "AnimateBullseye()", DELAY_BULLSEYE, "nostop")
        }
        else if (showActObj.type.indexOf("Down") != -1) {
            ShowBullsEye();
            Animate2("sclick.flv", true, "ShowScreen(\'" + showActObj.nextFrame + "\')", DELAY_MOUSE, "nostop")
            //			ShowScreen(showActObj.nextFrame)
        }
        else if (showActObj.type.indexOf("BeginDrag") != -1) {
            ShowBullsEye();
            clearTimeout(bullsTimeout);
            bullsTimeout = setTimeout("DragStart()", DELAY_BULLSEYE);
            //			Animate2("sclick.wav",true,"ShowScreen(\'"+showActObj.nextFrame+"\')",DELAY_MOUSE,"nostop")
            //			ShowScreen(showActObj.nextFrame)
        }
        else if (showActObj.type.indexOf("Up") != -1) {
            ShowBullsEye();
            clearTimeout(bullsTimeout);
            bullsTimeout = setTimeout("DragEnd()", DELAY_BULLSEYE);
            //			hide("bullseye")
            //			Animate2("sclick.wav",true,"ShowScreen(\'"+showActObj.nextFrame+"\')",DELAY_MOUSE,"nostop")
            //			ShowScreen(showActObj.nextFrame)
        }
        else if (showActObj.type.indexOf("Wheel") != -1) {
            ShowBullsEye();
            Animate2("swheel.flv", true, "ShowScreen(\'" + showActObj.nextFrame + "\')", DELAY_WHEEL, "nostop")
            //			ShowScreen(showActObj.nextFrame)
        }
        else
            ShowScreen(showActObj.nextFrame)
    }
}

function DragStart() {
    Animate2("sclick.flv", true, "ShowScreen(\'" + showActObj.nextFrame + "\')", DELAY_MOUSE, "nostop")
};

function DragEnd() {
    HideBullsEye();
    Animate2("sclick.flv", true, "ShowScreen(\'" + showActObj.nextFrame + "\')", DELAY_MOUSE, "nostop")
};

function AnimateBullseye() {
    --animSteps;

    if (Math.floor(animSteps / 2) == animSteps / 2) {
        HideBullsEye();
        if (animSteps > 0)
            Animate2("sclick.flv", true, "AnimateBullseye()", DELAY_BULLSEYE, animPhase)
        else
            ShowScreen(showActObj.nextFrame)
    }
    else {
        ShowBullsEye();
        if (animSteps > 0)
            Animate("AnimateBullseye()", DELAY_BULLSEYE, animPhase)
        else
            ShowScreen(showActObj.nextFrame)
    }
}

function DemoNext() {
    clearTimeout(animTimeout);
    clearTimeout(bullsTimeout);
    PlayStop();
    HideBullsEye();
    SeeItResume();
    ShowScreen(showActObj.nextFrame)
}

function DemoPrev() {
    clearTimeout(animTimeout);
    clearTimeout(bullsTimeout);
    PlayStop();
    HideBullsEye();

    l = showHistory.length;
    if (l == 0)
        return;
    if (l == 1) {
        s = showHistory[0];
        showHistory.length--;
    }
    else {
        s = showHistory[l - 2];
        showHistory.length -= 2;
    }
    SeeItResume();
    ShowScreen(s);
}

function DemoForward(gonext) {
    if (!gonext)
        gonext = false;
    if (gonext || (!gonext && isPaused)) {
        clearTimeout(animTimeout);
        clearTimeout(bullsTimeout);
        PlayStop();
        HideBullsEye();
        setTimeout("ShowScreen(\"" + showActObj.nextFrame + "\")", 10);
        return;
    };
    if (showActObj && animPhase == "mouse" && animSteps != animStepOriginal) {
        HideBullsEye();
        ShowScreen(showActObj.nextFrame)
    }
    else if (showActObj && animPhase != "nostop") {
        if (showActObj.type != "Input" && showActObj.type != "Key" && showActObj.type != "None" && showActObj.type != "Decision") {
            animObject.timeout = 50;
            PlaySound("dummy.flv");
        }
        else {
            ShowScreen(showActObj.nextFrame)
        }
    }
}

//
// Teacher mode
//

function TeacherFastBack() {
    if (showHistory.length > 1) {
        //    var firstID = showHistory[0]
        showHistory.length = 0
        //    ShowScreen(firstID)
    }
    FirstScreen(true);
}

function TeacherTestSkip(type) {
    return (type == "Drag" || type.indexOf("Up") != -1)
}

function TeacherBack() {
    if (showHistory.length > 1) {
        showHistory.length--;
        var prevID = showHistory[showHistory.length - 1];
        while (showHistory.length > 1 && TeacherTestSkip(screens[prevID].actions[0].type)) {
            showHistory.length--;
            prevID = showHistory[showHistory.length - 1];
        }
        showHistory.length--;
        HideAction();
        if (historyActionMap[prevID])
            ShowScreen(prevID, historyActionMap[prevID])
        else
            ShowScreen(prevID);
        //	binterf.SetErrorMessage("");
    }
}

function TeacherForward(noskip, id, actid) {
    if (event_blocked)
        return;

    if (KFinishClose)
        return

    KnowItForward();
    if (id == null)
        id = showActObj.nextFrame

    if (actid) {
        for (var i = 0; i < screens[showScreen].actions.length; i++) {
            if (actid == screens[showScreen].actions[i].id) {
                historyActionMap[showScreen] = i;
                break;
            };
        };
    };

    var count = 999

    if (id != "end") {
        while (!noskip && id != "end" && TeacherTestSkip(screens[id].actions[0].type) && count--) {
            showHistory[showHistory.length] = id
            id = screens[id].actions[0].nextFrame
        }
    }
    ///	binterf.SetErrorMessage("");
    ShowScreen(id)
}

function TeacherFastForward() {
    var id = showActObj.nextFrame
    var count = 999

    if (id != "end") {
        while (id != "end" && count--) {
            showHistory[showHistory.length] = id
            id = screens[id].actions[0].nextFrame
        }

        id = showHistory[showHistory.length - 1]
        showHistory.length--
        ShowScreen(id)
        ///	binterf.SetErrorMessage("");
    }
}

function TeacherAlter() {
    var k = true;
    while (k) {
        showAct++;
        if (showAct == screens[showScreen].actions.length)
            showAct = 0;
        k = screens[showScreen].actions[showAct].realAction == false;
        if (k == true)
            k = screens[showScreen].actions[showAct].emptybubble;
    };
    showHistory.length--
    ShowScreen(showScreen, showAct)
}

function TeacherWrong() {
    if (showActObj.type == "None")
        return;

    if (KFinishClose)
        return

    if (event_blocked)
        return;
    if (playMode == "K") {
        if (showActObj.type == "Input")
            showActObj.par2 = showActInpObj.value;
        if (!IsLeadIn() && !IsLeadOut())
            KnowItWrong();
        return;
    };
    var text

    if (showActObj.type == "Input")
        text = R_wrong_input
    else if (showActObj.type == "Key")
        text = R_wrong_key
    else if (showActObj.type == "Decision")
        text = R_wrong_decision
    else
        text = R_wrong_mouse

    if (showActObj.type == 'Input') {
        line = "FocusInpObj()";
    }
    else
        line = "";

    if (showHistory.length > 1 && TeacherTestSkip(showActObj.type)) {
        var prevID = showHistory[showHistory.length - 1]
        while (showHistory.length > 1 && TeacherTestSkip(screens[prevID].actions[0].type)) {
            showHistory.length--
            prevID = showHistory[showHistory.length - 1]
        }
        showHistory.length--
        line = "ShowScreen('" + prevID + "')"
    }

    if (_ShowBubble(showActObj)) {
        binterf.SetErrorMessage(text);
    }

    Animate2("ding.flv", true, "", "", "");
    if (line.length > 0)
        setTimeout(line, 0);
}

//
// Generic player functions
//

function Decision(num) {
    // Go down decision path #num (num is 1-based)
    OffLink();
    Menu_Resume();
    ShowScreen(screens[showScreen].actions[num - 1].nextFrame)
}

var trackSent = false;

function ClosePlayer(topicfinished) {
    if (trackSent)
        return;
    trackSent = true;
    //ODS
    ODSCloseEvGroup();
    //ODS
    if (param_windowed == false)
        setTimeout("TimedClosePlayer(" + topicfinished + ")", 500);
};

function TimedClosePlayer(topicfinished) {
    PlayStop();
    CloseAction();
    //CloseTutorialDialog();

    //JZ - Begin
    if (SpecMode == "Y") {
        //Currently running AICC/SCORM Mode - Pass tracking data back

        if (AICC_STORM_Completed) {
            if (playMode == "K") {
                var passed = GetResultInPercent();
                var kcorrect = 0;
                if (passed >= KScoreNeeded) {
                    kcorrect = 1;
                }
                top.window.opener.trackKnowitComplete(passed, kcorrect);
            }
            else {
                top.window.opener.trackSimComplete(playMode);
            }
        }
    }
    //JZ - End
    KTopicFinished = topicfinished;
    /*	
    if (playMode=="K")
    {
    trackScoreCompleted=GetResultInPercent(true);
    trackScoreRequired=KScoreNeeded;
    if (topicfinished)
    trackComplete()
    else
    trackIncomplete();
    };
    */
    this.blur();
    if (fatPlayer == "FS" || fatPlayer == "WEB") {
        FatPlayerCommand(def_PLAYER_CLOSE, "");
    }
    else {

        //	moved to onUnload
        //	if (guidedParent)
        //	{
        //		guidedParent.GITMClosed();
        //	}
        top.close();
        /*	
        if (top.window.opener)
        {
        if (!top.window.opener.closed)
        {
        if (top.window.opener.GITMClosed)
        top.window.opener.GITMClosed();
        }
        };
        top.close()
        */
    };
}

function HandleResize0() {
    if (param_windowed == true)
        SeeItPause();
    Scroll2Action(true);
    HandleResize();
}

function HandleResize() {
    if (scrW == 0)
        return;
    if (binterf) binterf.HandleRepos()
    if (NS4) {
        if (loadWidth != window.innerWidth || loadHeight != window.innerHeight) {
            history.go(0)
            return
        }
    }

    var x, y, py
    var wh, ww
    var sx, sy

    wh = getInsideWindowHeight()
    ww = getInsideWindowWidth()

    sx = getScrollLeft()
    sy = getScrollTop()

    x = Math.round((ww - scrW) / 2)
    if (x < 0) x = 0;

    y = Math.round((wh - scrH) / 2)
    if (y < 0) {
        y = Math.round((wh - scrH) / 2)
        if (y < 0)
            y = 0
    }
    ClearScrBorder();
    shiftTo("screen", x, y)
    if (StartScreen.length > 0)
        SetScrBorder(x, y, scrW, scrH, 1);

}

function ClearScrBorder() {
    var borderobj = document.getElementById("scrborder");
    if (!borderobj)
        return;
    hide("scrborder");
};

function SetScrBorder(x, y, w, h, b) {
    var borderobj = document.getElementById("scrborder");
    if (!borderobj)
        return;
    borderobj.style.left = x - b;
    borderobj.style.top = y - b;
    borderobj.style.width = w + 2 * b;
    borderobj.style.height = h + 2 * b;
    borderobj.style.borderWidth = String(b) + "px";
    show("scrborder");
};

function max(a, b) {
    return (a > b) ? a : b
}

function min(a, b) {
    return (a < b) ? a : b
}

function SetActionColor() {
    var bub = showActObj.id
    var color = UserPrefs.MarqueeColor;
    for (var i = 0; i < showActObj.hotspots; i++) {
        var hotp = "hot" + bub + "_" + i + "p";
        document.getElementById(hotp).style.borderColor = color;
    }
};

function KnowItWrong() {
    if (KWarningLevel == 4) {
        Animate2("ding.flv", true, "", "", "");
        return;
    };
    HideKnowItBubble()
    KWarningLevel++;
    if (KWarningLevel == 1 && KRemediation1 == false)
        KWarningLevel++;
    if (KWarningLevel == 2 && KRemediation2 == false)
        KWarningLevel++;
    if (KWarningLevel == 3 && KRemediation3 == false)
        KWarningLevel++;
    if (KWarningLevel >= DEF_KWARNINGSCORELEVEL)
        AddToWrongScreens(showScreen);
    Animate2("ding.flv", true, "", "", "");
    ShowKnowItBubble();
};

function KnowItForward() {
    KWarningLevel = 0;
};

function IsDragBegin(ss) {
    var s = showActObj.type;
    if (ss)
        s = ss;
    return (s == "LBeginDrag" || s == "RBBeginDrag" || s == "MBBeginDrag")
};

function IsDragSequence2(ss) {
    var s = showActObj.type;
    if (ss)
        s = ss;
    return (s == "Drag");
};

var nib_Positioned = false;
var nib_l, nib_t, nib_r, nib_b;
var nib_bCloseEnabled = true;

function DecodeTagElements(s) {
    s = replaceString("&lt;", "<", s);
    s = replaceString("&gt;", ">", s);
    return s;
}

function AddTopMargin(s) {
    if (s.substr(0, 17) == '<p align="right">') {
        ss = s.substr(0, 16) + ' style="margin-top: 10px;" ' + s.substr(16);
        return ss;
    }
    return s;
}

function ShowKnowItBubble() {
    binterf.m_bFFClearHeight = false;
    var s = "";
    nib_Positioned = false;
    nib_bCloseEnabled = true;
    if (KFinishClose) {
        binterf.m_bFFClearHeight = true;
        s = template_knowit_finish_close;
        nib_Positioned = true;
        nib_bCloseEnabled = false;
    }
    else if (KConfirmDemo) {
        binterf.m_bFFClearHeight = true;
        s = template_knowit_confirmdemo;
        nib_Positioned = true;
    }
    else if (IsLeadIn()) {
        s = DecodeTagElements(R_titleformat_begin) + topicName + DecodeTagElements(R_titleformat_end);
        s += showActObj.ktext;
        sscore = GetTemplate_knowit_leadin_score("" + KScoreNeeded);
        if (sscore.substr(0, 6) == '<span>')
            sscore = '<p id="scoretext" class="InstructText">' + sscore + '</p>';
        else
            sscore = sscore.substr(0, 2) + ' id="scoretext" ' + sscore.substr(3);
        s = replaceString("###KSCORE###", sscore, s);
        if (ShowScoreNeeded)
            binterf.m_bFFClearHeight = true;
        nib_Positioned = false;
    }
    else if (IsLeadOut()) {
        if (KScoringScreen) {
            binterf.m_bFFClearHeight = true;
            var passed = GetResultInPercent();
            var result = "";
            s = DecodeTagElements(R_titleformat_begin) + topicName + DecodeTagElements(R_titleformat_end);

            if (passed >= KScoreNeeded) {
                //ODS
                ODSKnowitScore(passed, 1);
                //ODS
                result = template_scoring_YES;
            }
            else {
                //ODS
                ODSKnowitScore(passed, 0);
                //ODS
                result = template_scoring_NO;
            };
            s += GetTemplate_scoring("" + passed, "" + KScoreNeeded, result);
        }
        else {
            s = DecodeTagElements(R_titleformat_begin) + topicName + DecodeTagElements(R_titleformat_end);
            s += showActObj.ktext;
        };
        nib_Positioned = false;
    }
    else if (IsExplanation()) {
        s = showActObj.knowittext + "<br><p class='MsoNormal'>" + showActObj.fontbegin + template_knowit_explanation + showActObj.fontend + "</p>";
        nib_Positioned = false;
        binterf.m_bFFClearHeight = true;
    }
    else {
        switch (KWarningLevel) {
            case 0:
                binterf.m_bFFClearHeight = true;
                if (IsDragBegin()) {
                    s = template_knowit_dragwarning;
                }
                else {
                    s = "";
                    if (KContinueFlag == 1) {
                        s = template_knowit_continue;
                        if (showActObj.knowittext.length > 0)
                            s += "<br><br>";
                    };
                    s += showActObj.knowittext;
                    if (showActObj.type == "Input")
                        s += template_typingcomplete;
                    s += AddTopMargin(template_knowit_nextstep);
                };
                break;
            case 1:
                binterf.m_bFFClearHeight = true;
                if (showActObj.knowittext.length > 0) {
                    s = template_knowit_warningL1 + "<hr>" + showActObj.knowittext;
                    if (showActObj.type == "Input")
                        s += template_typingcomplete;
                    s += AddTopMargin(template_knowit_nextstep);
                }
                else {
                    s = template_knowit_warningL1;
                    if (showActObj.type == "Input")
                        s += template_typingcomplete;
                    s += AddTopMargin(template_knowit_nextstep);
                };
                break;
            case 2:
                binterf.m_bFFClearHeight = true;
                s = template_knowit_warningL2 + showActObj.text;
                if (showActObj.type == "Input")
                    s += template_typingcomplete;
                s += AddTopMargin(template_knowit_nextstep);
                break;
            case 3:
                binterf.m_bFFClearHeight = true;
                if (showActObj.hotspots == 0) {
                    s = template_knowit_warningL3_0 + showActObj.text;
                    if (showActObj.type == "Input")
                        s += template_typingcomplete;
                    s += AddTopMargin(template_knowit_nextstep);
                }
                else {
                    s = template_knowit_warningL3_H + showActObj.text;
                    if (showActObj.type == "Input")
                        s += template_typingcomplete;
                    s += AddTopMargin(template_knowit_nextstep);
                    var bub = showActObj.id
                    SetActionColor();
                    for (var i = 0; i < showActObj.hotspots; i++) {
                        var hot = "hot" + bub + "_" + i;
                        if (getDIV(hot)) show(hot)
                    }
                };
                break;
            default: // level 4
                binterf.m_bFFClearHeight = true;
                s = template_knowit_warningL4;
        };
        nib_Positioned = true;
    };

    nib_l = nib_t = nib_r = nib_b = (-1);
    if (nib_Positioned) {
        if (showActObj.hotspots) {
            var d = "hot" + showActObj.id + "_0";
            nib_l = getObjLeft(d) + getObjLeft("screen");
            nib_t = getObjTop(d) + getObjTop("screen");
            nib_r = nib_l + getObjWidth(d);
            nib_b = nib_t + getObjHeight(d);
            if (showActObj.type == "Input") {
                //				nib_t+=16;
                nib_b -= 16;
            };
        }
    };
    nib_Positioned = !nib_Positioned;

    binterf.ResetContent();
    binterf.SetText(s);
    binterf.SetColor(showActObj.bubcolor);
    //binterf.Download("ShowKnowItBubble2");
    ShowKnowItBubble2();
};

function ShowKnowItBubble2(retOK, retError) {
    if (IsExplanation()) {
        binterf.SetPosition(-1, -1, -1, -1, true, false, showActObj.xpos, showActObj.ypos, showActObj.kwidth, showActObj.kheight);
    }
    else {
        w = (KWarningLevel < 2 ? showActObj.kwidth : showActObj.width);
        h = (KWarningLevel < 2 ? showActObj.kheight : showActObj.height);
        if (KWarningLevel == 1 || KConfirmDemo == true) {
            w = (w < Rem1_minimum ? Rem1_minimum : w);
        }
        if (KWarningLevel == 2 || KWarningLevel == 3) {
            w = (w < Rem2_minimum ? Rem2_minimum : w);
        }
        if (KWarningLevel == 4) {
            w = Rem4_width;
        }
        binterf.SetPosition(nib_l, nib_t, nib_r, nib_b, nib_Positioned, 0, 0, 0, w, h);
    }
    binterf.SetEnableCloseButton(nib_bCloseEnabled ? 1 : 0);
    binterf.Show();
    if (showActObj.type == "Input") {
        var bub = showActObj.id;
        SetActionColor();
        for (var i = 0; i < showActObj.hotspots; i++) {
            var hot = "hot" + bub + "_" + i;
            var hotdiv = getDIV(hot);
            if (hotdiv) {
                var inp = getDIV(hot + "p");
                if (KWarningLevel < 3 || KWarningLevel == 4 || KFinishClose) {
                    if (!hotdiv.LeftOriginal)
                        hotdiv.LeftOriginal = hotdiv.offsetLeft;
                    if (!hotdiv.TopOriginal)
                        hotdiv.TopOriginal = hotdiv.offsetTop;
                    hotdiv.style.left = "" + (hotdiv.LeftOriginal + 2) + "px";
                    hotdiv.style.top = "" + (hotdiv.TopOriginal + 2) + "px";

                    if (!inp.WidthOriginal)
                        inp.WidthOriginal = inp.offsetWidth;
                    if (!inp.HeightOriginal)
                        inp.HeightOriginal = inp.offsetHeight;
                    if (!inp.borderColorOriginal)
                        inp.borderColorOriginal = inp.style.borderColor;

                    inp.style.border = "0px";
                    inp.style.width = "" + (inp.WidthOriginal - 4) + "px";
                    inp.style.height = "" + (inp.HeightOriginal - 4) + "px";
                }
                else {
                    if (inp.borderColorOriginal) {
                        inp.style.border = "3px";
                        inp.style.borderColor = inp.borderColorOriginal;
                        inp.style.borderStyle = "solid";
                    };
                    if (inp.WidthOriginal)
                        inp.style.width = "" + inp.WidthOriginal + "px";
                    if (inp.HeightOriginal)
                        inp.style.height = "" + inp.HeightOriginal + "px";
                    if (hotdiv.LeftOriginal)
                        hotdiv.style.left = "" + hotdiv.LeftOriginal + "px";
                    if (hotdiv.TopOriginal)
                        hotdiv.style.top = "" + hotdiv.TopOriginal + "px";
                };
                show(hot)
            };
        }
        if (showActObj.par4) {
            // Preset input field
            showActObj.par4 = false;
            if (KWarningLevel == 0) {
                showActInpObj = document.layers ? document.layers.screen.document.layers["hot" + showActObj.id + "_0"].document["f" + showActObj.id]["inp" + showActObj.id] : document["f" + showActObj.id + "_0"]["inp" + showActObj.id + "_0"]
                showActInpObj.value = showActObj.par5
                showActInpObj.original = showActInpObj.value;
                showActInpObj.onkeyup = EventKeyUp
                showActInpObj.onkeypress = EventInputKey
                showActInpObj.onpropertychange = EventPropertyChange
                showActInpObj.onfocus = InputOnFocus;
                showActInpObj.onblur = InputOnBlur;
            }
            try {
                showActInpObj.focus()
            }
            catch (e) { };
        };
    };
    ShowScreen3();
};

function HideKnowItBubble() {
    var bub = showActObj.id
    for (var i = 0; i < showActObj.hotspots; i++) {
        var hot = "hot" + bub + "_" + i;
        if (getDIV(hot)) hide(hot)
    }
    binterf.ResetContent();
    binterf.Hide();
};

////////////////////////////////////////////////////////////////////////////////
// sound support

var soundplayed = false;

function PlayStop() {
    SoundPlayerObj.Stop();
};

function PlayPause() {
    SoundPlayerObj.Pause();
}

function PlayResume() {
    if (soundplayed) {
        SoundPlayerObj.Resume();
    }
};

function GetDecisionSound(actionfname) {
    return actionfname;
    if (showActObj.type != "Decision")
        return actionfname;
    for (var i = 0; i < screenNames.length; i++) {
        scrName = screenNames[i];
        scr = screens[scrName];
        for (var j = 0; j < scr.actions.length; j++) {
            act = scr.actions[j];
            if (act.id == showActObj.id) {
                return (scrName.substr(1) + ".ASX");
            };
        };
    };
    return actionfname;
};

function PlaySound_asyncron(fname) {
    var pa = UserPrefs.PlayAudio;
    if (pa != "none")
        SoundPlayerObj.Play(fname, true, false, true);
}

function PlaySound(fname, demosound, temp) {
    if (fname == "dummy.flv") {
        PlayStop();
        soundplayed = false;
        if (animObject) {
            if (animObject.cmd.length > 0) {
                Animate(animObject.cmd, animObject.timeout, animObject.phase);
            };
        };
        return;
    };
    var dname = GetDecisionSound(fname);
    fname = dname;
    if (!temp) {
        animObject.fname = fname;
        animObject.demosound = demosound;
    };
    var dmsound = true;
    if (!demosound)
        dmsound = false;

    var pa = UserPrefs.PlayAudio;
    if (playMode == "T") {
        if ((pa == "all" && soundIsExported) || (dmsound && (pa == "demo" || pa == "all"))) {
            soundplayed = true;
            SoundPlayerObj.Play(fname, dmsound, temp);
        }
        else if (animObject.cmd.length > 0)
            Animate(animObject.cmd, animObject.timeout, animObject.phase);
    };
    if (playMode == "S" || KGuestDemoMode) {
        if ((pa == "all" && soundIsExported) || (dmsound && (pa == "demo" || pa == "all"))) {
            soundplayed = true;
            SoundPlayerObj.Play(fname, dmsound, temp);
        }
        else if (animObject.cmd.length > 0)
            Animate(animObject.cmd, animObject.timeout, animObject.phase);
    };
    if (playMode == "K") {
        if (dmsound && (pa == "demo" || pa == "all")) {
            soundplayed = true;
            SoundPlayerObj.Play(fname, dmsound, temp);
        }
    };
};

function OnErrorPlaySound(v1, v2) {
    soundplayed = false;
    if (animObject) {
        if (animObject.cmd.length > 0 && playMode != "K") {
            Animate(animObject.cmd, animObject.timeout, animObject.phase);
        };
    };
};

function OnEndPlaySound(v1) {
    soundplayed = false;
    if (animObject) {
        if (animObject.cmd.length > 0 && playMode != "K") {
            animCmd = animObject.cmd;
            animPhase = animObject.phase;
            clearTimeout(animTimeout);
            animTimeout = setTimeout("AnimateTimer();", 100);
        };
    };
};

////////////////////////////////////////////////////////////////////////////////

function _HasSound(a) {
    if (UserPrefs.PlayAudio != "all")
        return false;
    ix = (a.id).substr(1) + ".ASX";
    if (sounds[ix]) {
        if (sounds[ix].fct == 0)
            return false;
        return (sounds[ix].flist[0].length > 0);
    }
    return false;
}

function _HasActionArea(a) {
    if (IsExplanation(a))
        return false;
    if (IsLeadIn(a))
        return false;
    if (IsLeadOut(a))
        return false;
    if (IsDecision(a))
        return false;
    return (a.hotspots > 0);
}

function _ShowBubble(a) {
    f = screens[a.prevFrame];
    if (playMode == "S" || playMode == "T") {
        if (a.type == "Decision")
            return true;
        if (topicShowBubbles == "Always")
            return true;
        if (topicShowBubbles == "Never")
            return false;
        return (f.showBubble == "true" ? true : false);
    }
    return true;
}

function _ShowActionArea() {
    return (topicShowBubbles != "Never");
}

function _SkipFrame(f) {
    a = f.actions[0];
    // only one decision branch
    if (f.actions.length == 1 && a.type == "Decision")
        return true;
    // explanation, start and end frame, null delay in S and T modes
    if (playMode == "S" && a.type == "None" && a.delay == 0)
        return true;
    if (playMode == "T" && a.type == "None" && a.delay == 0)
        return true;
    // decision frame and null delay in S mode
    if (playMode == "S" && a.type == "Decision" && a.delay == 0)
        return true;
    // all decision in K mode
    if (playMode == "K" && a.type == "Decision")
        return true;
    // explanation frame with empty text in K mode
    if (playMode == "K" && a.type == "None" && a.prevFrame != "start" && a.nextFrame != "end" && a.knowittext.length == 0)
        return true;

    if (playMode == "K")
        return false;

    _HasActionArea(a);

    if (!_ShowBubble(a)) {
        if (_HasSound(a)) {
            return false;
        }
        else {
            if (IsLeadIn(a))
                return true;
            if (IsLeadOut(a))
                return true;
            if (IsExplanation(a))
                return true;
            if (IsDecision(a))
                return false;
            if (a.delay == DELAY_INFINITE) {
                if (playMode == "S") {
                    return true;
                }
                else {
                    return false;
                }
            }
        }
    }
    return false;
}
function ShowAction() {
    binterf.m_bFFClearHeight = false;
    var pointerDirection = showActObj.bubpos;
    var pointerXpos = showActObj.xpos;
    var pointerYpos = showActObj.ypos;

    if (playMode == "K" && !KGuestDemoMode) {
        ShowKnowItBubble();
        if (IsDragBegin() && !KFinishClose)
            Animate2("ding.flv", true, "", "", "");
        return;
    };
    if (showActObj.type == "None" && showActObj.emptytext) {
        if (!IsLeadIn() && !IsLeadOut()) {
            ShowScreen3();
            return;
        };
    };
    var bub = showActObj.id
    binterf.ResetContent();
    var bubtext = showActObj.text;
    if (playMode == "T" && showActObj.type == "Input") {
        bubtext = showActObj.text + template_typingcomplete;
    }
    if (playMode == "S" || (playMode == "K" && KGuestDemoMode)) {
        bubtext += template_pauselink;
        binterf.m_bFFClearHeight = true;
    }
    binterf.SetText(bubtext);
    binterf.SetIcon(showActObj.iconname);
    binterf.SetColor(showActObj.bubcolor);
    if (playMode == "T") {
        binterf.SetAlternative(showActObj.showalternatives);
        for (var i = 0; i < screens[showScreen].infoblocks.length; i++) {
            var ib = screens[showScreen].infoblocks[i];
            binterf.AddInfoBlock(ib.buttonfile, ib.url, ib.tooltip);
        };
    };
    if (showActObj.type == "Decision" || showActObj.type == "Input")
        binterf.m_bFFClearHeight = true;
    if (showActObj.hotspots) {
        var d = "hot" + bub + "_0";

        l = getObjLeft(d) + getObjLeft("screen");
        if (l < 0) l = 0;
        t = getObjTop(d) + getObjTop("screen");
        if (t < 0) t = 0;
        r = l + getObjWidth(d);
        b = t + getObjHeight(d);
        if (showActObj.type == "Input") {
            //			t+=16;
            b -= 16;
        };
        if (showActObj.bubpos > 0) {
            binterf.SetPosition(l, t, r, b, true, pointerDirection, pointerXpos, pointerYpos, showActObj.width, showActObj.height);
        }
        else {
            if (showActObj.type == "None")
                binterf.SetPosition(-1, -1, -1, -1, true, pointerDirection, pointerXpos, pointerYpos, showActObj.width, showActObj.height)
            else
                binterf.SetPosition(l, t, r, b, false, pointerDirection, pointerXpos, pointerYpos, showActObj.width, showActObj.height);
        };
    }
    else {
        binterf.SetPosition(-1, -1, -1, -1, true, pointerDirection, pointerXpos, pointerYpos, showActObj.width, showActObj.height);
    };

    if (KGuestDemoMode == 0 && !showActObj.emptybubble)
    //binterf.Download("ShowAction2")
        ShowAction2()
    else
        ShowAction2();
}

function ShowAction2(retOK, retError) {
    if (KGuestDemoMode == 0 && !showActObj.emptybubble && _ShowBubble(showActObj))
        binterf.Show();

    if (showActObj.type != "None") {
        SetActionColor();
        var bub = showActObj.id
        for (var i = 0; i < showActObj.hotspots; i++) {
            if (i == 0 || showActObj.type != "Input") {
                var hot = "hot" + bub + "_" + i;
                var hotdiv = getDIV(hot);
                var hotp = hot + "p";

                w = getObjWidth("screen");
                h = getObjHeight("screen");

                if (!showActObj.areacorrected) {
                    bord1 = document.getElementById(hotp).border;

                    if (document.getElementById(hotp).type == "password") {
                        document.getElementById(hotp).style.fontFamily = "Arial";
                        document.getElementById(hotp).style.fontSize = "12px";
                    }

                    hl = hotdiv.offsetLeft;
                    if (hl < 0) {
                        hw = document.getElementById(hotp).clientWidth;
                        document.getElementById(hotp).style.width = "" + (hw + hl) + "px";
                        hotdiv.style.left = 0;
                    }
                    ht = hotdiv.offsetTop;
                    if (ht < 0) {
                        hh = document.getElementById(hotp).clientHeight;
                        document.getElementById(hotp).style.height = hh + ht;
                        hotdiv.style.top = 0;
                    }

                    bord = bord1 * 2;
                    hl = hotdiv.offsetLeft;
                    hw = document.getElementById(hotp).clientWidth + bord;
                    ht = hotdiv.offsetTop;
                    hh = document.getElementById(hotp).clientHeight + bord;

                    var c = bord1;
                    if (fatPlayer == "FS" || fatPlayer == "WEB")
                        c = 0;

                    if (hl + hw > w - c)
                        document.getElementById(hotp).style.width = "" + (hw - bord - 3 - c) + "px";
                    if (ht + hh > h)
                        document.getElementById(hotp).style.height = "" + (hh - bord - 3) + "px";
                    showActObj.areacorrected = true;
                }

                if (hotdiv) {
                    if (showActObj.type == "Input") {
                        var inp = getDIV(hot + "p");
                        if (inp.borderColorOriginal) {
                            inp.style.border = "3px";
                            inp.style.borderColor = inp.borderColorOriginal;
                            inp.style.borderStyle = "solid";
                        };
                        if (inp.WidthOriginal)
                            inp.style.width = "" + inp.WidthOriginal + "px";
                        if (inp.HeightOriginal)
                            inp.style.height = "" + inp.HeightOriginal + "px";
                        if (hotdiv.LeftOriginal)
                            hotdiv.style.left = "" + hotdiv.LeftOriginal + "px";
                        if (hotdiv.TopOriginal)
                            hotdiv.style.top = "" + hotdiv.TopOriginal + "px";

                        var noborder = (_ShowActionArea() == false);
                        var cstr = hotdiv.style.cssText.toLowerCase();
                        if (cstr.indexOf("marquee: false") >= 0)	// no border
                            noborder = true;
                        if (noborder == true) {
                            if (!showActObj.marqueecorrected) {
                                showActObj.marqueecorrected = true;
                                //hotdiv.style.left=""+(hotdiv.style.pixelLeft+3)+"px";
                                hotdiv.style.left = "" + Number(getObjLeft(hotdiv) + 3) + "px";
                                //hotdiv.style.top=""+(hotdiv.style.pixelTop+3)+"px";
                                hotdiv.style.top = "" + Number(getObjTop(hotdiv) + 3) + "px";
                                inp.style.border = "0px";
                                inp.style.width = "" + (inp.offsetWidth - 6) + "px";
                                inp.style.height = "" + (inp.offsetHeight - 6) + "px";
                            }
                        }
                        show(hot);
                    }
                    else {
                        if (_ShowActionArea())
                            show(hot);
                    }
                };
            };
        }
    };
    if (playMode == "S") {
        if (isPaused) {
            binterf.SetPRText(R_interface_resume);
        }
        else {
            binterf.SetPRText(R_interface_pause);
        }
    }
    ShowScreen3();
};

function _getBubbleTop(b) {
    k = b.GetBubbleTop(true) - 10;
    if (k < 0)
        k = 0;
    return k;
}

function _getBubbleLeft(b) {
    k = b.GetBubbleLeft(true) - 10;
    if (k < 0)
        k = 0;
    return k;
}

function _getObjTop(o) {
    k = getObjTop(o) - 10;
    if (k < 0)
        k = 0;
    return k;
}

function _getObjLeft(o) {
    k = getObjLeft(o) - 10;
    if (k < 0)
        k = 0;
    return k;
}

function ScrollToAction() {
    if (playMode == "K") {
        if (showScreen == "start")
            window.scrollTo(0, 0);
        if (showActObj.nextFrame == "end")
            window.scrollTo(0, 0);
        setTimeout("ShowScreen4()", 5);
        return;
    }
    Scroll2Action();
}

var Actionarea_left = 150;
var Actionarea_top = 32;
var Actionarea_right = 0;
var Actionarea_bottom = 0;

var Bubble_horizontal = 150
var Bubble_vertical = 32

function RectArea(x, y, dx, dy, bubpt) {
    this.x = x;
    this.y = y;
    this.dx = dx;
    this.dy = dy;
    this.bubpt = bubpt;
}

function combineRect(r1, r2) {
    if (r1.dx == 0 && r1.dy == 0) {
        return r2;
    }
    if (r2.dx == 0 && r2.dy == 0) {
        return r1;
    }
    var x = min(r1.x, r2.x);
    var y = min(r1.y, r2.y);
    var dx = max(r1.x + r1.dx, r2.x + r2.dx) - x;
    var dy = max(r1.y + r1.dy, r2.y + r2.dy) - y;
    var r = new RectArea(x, y, dx, dy, 0);
    return r;
}

function fitRectinRect(r1, r2) { // fits r1 IN r2
    if (r1.dx == 0 && r1.dy == 0)
        return true;
    if (r1.dx > r2.dx)
        return false;
    if (r1.dy > r2.dy)
        return false;
    return true;
}

function containRect(r1, r2) {  // is r1 IN r2
    if (r1.dx == 0 && r1.dy == 0)
        return true;
    if (r1.x < r2.x)
        return false;
    if (r1.y < r2.y)
        return false;
    if (r1.x + r1.dx > r2.x + r2.dx)
        return false;
    if (r1.y + r1.dy > r2.y + r2.dy)
        return false;
    return true;
}

function getArea(bubrect, hotspotrect, screenarea) {
    sdx = document.getElementById("screen").clientWidth;
    sdy = document.getElementById("screen").clientHeight;
    brect = new RectArea(0, 0, 0, 0, 0);
    brectnopadding = new RectArea(0, 0, 0, 0, 0);
    if (bubrect.dx > 0 && bubrect.dy > 0) {
        brect = new RectArea(bubrect.x, bubrect.y, bubrect.dx, bubrect.dy, bubrect.bubpt);
        brectnopadding = new RectArea(bubrect.x, bubrect.y, bubrect.dx, bubrect.dy, bubrect.bubpt);
        switch (brect.bubpt) {
            case BUBB07_NOPOINTER:
                break;
            case BUBB07_TOPLEFT:
            case BUBB07_TOPRIGHT:
                if (brect.y > Bubble_vertical) {
                    brect.y -= Bubble_vertical;
                    brect.dy += Bubble_vertical;
                }
                else {
                    brect.dy += brect.y;
                    brect.y = 0;
                }
                break;
            case BUBB07_BOTTOMLEFT:
            case BUBB07_BOTTOMRIGHT:
                if (brect.y + brect.dy < sdy) {
                    brect.dy += Bubble_vertical;
                }
                else {
                    brect.dy = sdy - brect.dy;
                }
                break;
            case BUBB07_LEFTTOP:
            case BUBB07_LEFTBOTTOM:
                if (brect.x > Bubble_horizontal) {
                    brect.x -= Bubble_vertical;
                    brect.dx += Bubble_vertical;
                }
                else {
                    brect.dx += brect.x;
                    brect.x = 0;
                }
                break;
            case BUBB07_RIGHTTOP:
            case BUBB07_RIGHTBOTTOM:
                if (brect.x + brect.dx < sdx) {
                    brect.dx += Bubble_horizontal;
                }
                else {
                    brect.dx = sdx - brect.dx;
                }
                break;
        }
    }
    hrect = new RectArea(0, 0, 0, 0, 0);
    hrectnopadding = new RectArea(0, 0, 0, 0, 0);
    if (hotspotrect.dx > 0 && hotspotrect.dy > 0) {
        hrect = new RectArea(hotspotrect.x, hotspotrect.y, hotspotrect.dx, hotspotrect.dy, hotspotrect.bubpt);
        hrectnopadding = new RectArea(hotspotrect.x, hotspotrect.y, hotspotrect.dx, hotspotrect.dy, hotspotrect.bubpt);
        if (hrect.x > Actionarea_left) {
            hrect.x -= Actionarea_left;
            hrect.dx += Actionarea_left;
        }
        else {
            hrect.dx += hrect.x;
            hrectx = 0;
        }
        if (hrect.y > Actionarea_top) {
            hrect.y -= Actionarea_top;
            hrect.dy += Actionarea_top;
        }
        else {
            hrect.dy -= hrect.y;
            hrect.y = 0;
        }
        if (hrect.x + hrect.dx < sdx) {
            hrect.dx += Actionarea_right;
        }
        else {
            hrect.dx = sdx - hrect.x;
        }
        if (hrect.y + hrect.dy < sdy) {
            hrect.dy += Actionarea_bottom;
        }
        else {
            hrect.dy = sdy - hrect.y;
        }
    }
    var r0 = combineRect(brect, hrect);
    if (fitRectinRect(r0, screenarea))       // bubble + hotspot with padding
        return r0;
    r1 = combineRect(brectnopadding, hrectnopadding);
    if (fitRectinRect(r1, screenarea))       // bubble + hotspot no padding
        return r1;
    if (fitRectinRect(brect, screenarea))   // bubble with padding (full)
        return brect;
    if (fitRectinRect(brectnopadding, screenarea))
        return brectnopadding;
    brectnopadding.dx = screenarea.dx;
    if (brectnopadding.x + brectnopadding.dx > sdx)
        brectnopadding.dx = sdx - brectnopadding.x;
    brectnopadding.dy = screenarea.dy;
    if (brectnopadding.y + brectnopadding.dy > sdy)
        brectnopadding.dy = sdy - brectnopadding.y;
    return brectnopadding;
}

function getHorizontalScrollPosition(r1, r2) {  // r1 is IN r2
    if (r1.x < r2.x) {
        return r1.x;
    }
    if (r1.x + r1.dx > r2.x + r2.dx) {
        return r1.x - (r2.dx - r1.dx);
    }
    return r2.x;
}

function getVerticalScrollPosition(r1, r2) {    // r1 is IN r2
    if (r1.y < r2.y) {
        return r1.y;
    }
    if (r1.y + r1.dy > r2.y + r2.dy) {
        return r1.y - (r2.dy - r1.dy);
    }
    return r2.y;
}

function getDefinedBubbleRect(r0) {
    switch (r0.bubpt) {
        case BUBB07_NOPOINTER:
            break;
        case BUBB07_TOPLEFT:
        case BUBB07_TOPRIGHT:
        case BUBB07_BOTTOMLEFT:
        case BUBB07_BOTTOMRIGHT:
            r0.dy += 40 + Bubble_vertical;
            break;
        case BUBB07_LEFTTOP:
        case BUBB07_LEFTBOTTOM:
        case BUBB07_RIGHTTOP:
        case BUBB07_RIGHTBOTTOM:
            r0.dx += 40 + Bubble_horizontal;
            break;
    }
    return r0;
}

function Scroll2Action(simplereturn) {
    if (showScreen == "start") {
        window.scrollTo(0, 0);
        if (!simplereturn)
            setTimeout("ShowScreen4()", 5);
        return;
    }
    if (showActObj.nextFrame == "end") {
        ScrollTo(0, 0);
        if (!simplereturn)
            setTimeout("ShowScreen4()", 5);
        return;
    }
    var wh = getInsideWindowHeight();
    var ww = getInsideWindowWidth();
    if (param_windowed == true) {
        wh -= 18;
        ww -= 18;
    }
    var scrX = getObjLeft("screen");
    var sx = getScrollLeft() - scrX;
    var scrY = getObjTop("screen");
    var sy = getScrollTop() - scrY;
    var srect = new RectArea(sx, sy, ww, wh, 0);

    var bub = showActObj.id;
    var brect = new RectArea(0, 0, 0, 0, 0);
    if (getDIV(bub)) {
        brect = new RectArea(binterf.GetBubbleLeft(true), binterf.GetBubbleTop(true),
                                binterf.GetBubbleWidth(true), binterf.GetBubbleHeight(true), binterf.GetBubblePointer());
        //        brect = new RectArea(_getObjLeft(bub), _getObjTop(bub), getObjWidth(bub), getObjHeight(bub), showActObj.bubpos);
        //        brect = new RectArea(showActObj.xpos, showActObj.ypos,showActObj.width,showActObj.height, showActObj.bubpos);
    }
    var hot = "hot" + bub + "_0";
    var hrect = new RectArea(0, 0, 0, 0, 0);
    if (getDIV(hot)) {
        hrect = new RectArea(_getObjLeft(hot), _getObjTop(hot), getObjWidth(hot), getObjHeight(hot), 0);
    }
    var r = getArea(brect, hrect, srect);
    if (containRect(r, srect)) {
        if (!simplereturn)
            setTimeout("ShowScreen4()", 5);
    }
    else {
        var nextObj = screens[showActObj.nextFrame].actions[0];
        var l = true;
        while (l) {
            var nbub = nextObj.id;
            var nbrect = new RectArea(0, 0, 0, 0, 0);
            if (getDIV(nbub)) {
                nbrect = getDefinedBubbleRect(new RectArea(nextObj.xpos, nextObj.ypos, nextObj.width, nextObj.height, nextObj.bubpos));
            }
            var nhot = "hot" + nbub + "_0";
            var nhrect = new RectArea(0, 0, 0, 0, 0);
            if (getDIV(nhot)) {
                nhrect = new RectArea(_getObjLeft(nhot), _getObjTop(nhot), getObjWidth(nhot), getObjHeight(nhot), 0);
            }
            var nextRect = getArea(nbrect, nhrect, srect);
            var cRect = combineRect(r, nextRect);
            if (fitRectinRect(cRect, srect)) {
                r = cRect;
            }
            else {
                l = false;
            }
            if (nextObj.nextFrame == "end")
                l = false;
            if (l)
                nextObj = screens[nextObj.nextFrame].actions[0];
        }

        ssx = getHorizontalScrollPosition(r, srect);
        ssy = getVerticalScrollPosition(r, srect);
        ScrollTo(ssx, ssy, simplereturn);
    }
}

function ScrollTo(x, y, nosmooth) {
    if (param_windowed) {
        if (nosmooth)
            window.scrollTo(x, y);
        else
            SmoothScroll(x, y);
    }
    else {
        y += 18;
        window.scrollTo(x, y);
        setTimeout("ShowScreen4()", 5);
    }
}

function TimerObj(x, y, currentx, currenty, targetx, targety, dx, dy) {
    this.x = x;
    this.y = y;
    this.currentx = currentx;
    this.currenty = currenty;
    this.targetx = targetx;
    this.targety = targety;
    this.dx = dx;
    this.dy = dy;
}
var timerObj = new TimerObj(0, 0, 0, 0, 0, 0, 0, 0, 0);

function SmoothScroll(targetx, targety) {
    currentx = getScrollLeft();
    currenty = getScrollTop();

    l = 5;
    dx = targetx - currentx;
    dy = targety - currenty;
    x = (dx > 0 ? l : 0 - l);
    y = (dy > 0 ? l : 0 - l);
    step = 0;
    if (Math.abs(dx) > Math.abs(dy)) {
        step = Math.abs(Math.round(dx / l)) + 1;
        y = Math.round(dy / step);
        if (y == 0) {
            y = (dy > 0 ? 1 : -1);
        }
    }
    else {
        step = Math.abs(Math.round(dy / l)) + 1;
        x = Math.round(dx / step);
        if (x == 0) {
            x = (dx > 0 ? 1 : -1);
        }
    }

    timerObj = new TimerObj(x, y, currentx, currenty, targetx, targety, dx, dy);
    setTimeout("SmoothScollTimed()", 5);
}

function SmoothScollTimed() {
    if (isPaused) {
        setTimeout("SmoothScollTimed()", 5);
        return;
    }
    if (timerObj.currentx == timerObj.targetx && timerObj.currenty == timerObj.targety) {
        setTimeout("ShowScreen4()", 5);
        return;
    }
    timerObj.currentx += timerObj.x;
    if (timerObj.dx > 0) {
        if (timerObj.targetx - timerObj.currentx < 0)
            timerObj.currentx = timerObj.targetx;
    }
    else {
        if (timerObj.targetx - timerObj.currentx > 0)
            timerObj.currentx = timerObj.targetx;
    }
    timerObj.currenty += timerObj.y;
    if (timerObj.dy > 0) {
        if (timerObj.targety - timerObj.currenty < 0)
            timerObj.currenty = timerObj.targety;
    }
    else {
        if (timerObj.targety - timerObj.currenty > 0)
            timerObj.currenty = timerObj.targety;
    }
    window.scrollTo(timerObj.currentx, timerObj.currenty);
    setTimeout("SmoothScollTimed()", 5);
}

function HideAction() {
    if (playMode == "K" && !KGuestDemoMode) {
        HideKnowItBubble();
        return;
    };
    var bub = showActObj.id

    binterf.ResetContent();
    binterf.Hide();

    for (var i = 0; i < showActObj.hotspots; i++) {
        var hot = "hot" + bub + "_" + i;
        if (getDIV(hot)) hide(hot)
    }
}

var myscr = "";

function ShowScreen(scr, act) {
    //ODS
    if (scr != "end") {
        if (screens[scr].actions[0].nextFrame == "end") {
            ODSFrameView(playMode, "end");
        }
        else {
            ODSFrameView(playMode, scr);
        }
    }

    //AICC_STORM mode completing verification
    if (scr != "end") {
        var ASmyscr = screens[scr];
        var l = 0;
        while (l == 0) {
            var ASid = ASmyscr.actions[0];
            var ASNext = ASid.nextFrame;
            if (ASNext == "end") {
                l = 1;
            }
            else if (ASid.delay == 0 || ASid.type == "None") {
                ASmyscr = screens[ASNext];
            }
            else {
                l = 2;
            };
        };
        if (l == 1)
            AICC_STORM_Completed = true;
    };

    if (act == null) {
        act = firsthemialternativeindex;
        firsthemialternativeindex = 0;
    }

    if (KGuestDemoMode == 2) {
        KGuestDemoMode = 0;
        KWarningLevel = 0;
        binterf.SetPosition(-1, -1, -1, -1, true, 0, 0, 0);
        binterf.SetMoveable(true);
        KContinueFlag = 1;
        //		if (showActObj.type!="Input")
        ShowScreen(scr, act);
        KContinueFlag = 2;
        return;
    };
    if (KGuestDemoMode == 1) {

        var myact = screens[scr].actions[0];
        if (IsDragBegin(myact.type) && showActObj.id == myact.id) {
        }
        else {
            if (!IsDragSequence2(myact.type))
                KGuestDemoMode = 2;
        };
    };
    if (KContinueFlag == 2)
        KContinueFlag = 0;

    if (scr == "end") {
        if (playMode == "K" && trackFeedBack) {
            HideAction();
            KScoringScreen = true;
            ShowAction();
            return;
        };
        ClosePlayer(1);
        return;
    }

    //  isTabbed = false

    // Bubble and Action Area
    if (showScreen != "") {
        if (showActObj.type == 'Input') {
            if (showActInpObj)
                showActInpObj.blur()
        }
        HideAction()
    }

    oldscr = scr;
    while (_SkipFrame(screens[scr]))
    //    ((screens[scr].actions.length == 1 && screens[scr].actions[0].type == "Decision") ||
    //	(playMode == "S" && screens[scr].actions[0].type == "None" && screens[scr].actions[0].delay == 0) ||
    //	(playMode == "T" && screens[scr].actions[0].type == "None" && screens[scr].actions[0].delay == 0) ||
    //	(playMode == "S" && screens[scr].actions[0].type == "Decision" && screens[scr].actions[0].delay == 0) ||
    //	(playMode == "K" && screens[scr].actions[0].type == "Decision") ||
    //	(playMode == "K" && screens[scr].actions[0].type == "None" && scr != "start" &&
    //				screens[scr].actions[0].nextFrame != "end" && screens[scr].actions[0].knowittext.length == 0) ||
    {
        scr = screens[scr].actions[0].nextFrame
        if (scr == "end") {
            setTimeout("ShowScreen(\"end\")", 10)
            return;
        };
        act = 0
    }
    if (scr != oldscr) {
        if (scr != "end") {
            if (screens[scr].actions[0].nextFrame == "end") {
                ODSFrameView(playMode, "end");
            }
            else {
                ODSFrameView(playMode, scr);
            }
        }

    }

    if (playMode == "S") {
        if (screens[scr] != null) {
            for (var i = 0; i < screens[scr].actions.length; i++) {
                var ca = screens[scr].actions[i];
                if (ca.delay == DELAY_INFINITE && ca.type != "Decision") {
                    var k1 = ca.text.indexOf(def_TMP_BEGIN);
                    var L1 = def_TMP_BEGIN.length;
                    var k2 = ca.text.indexOf(def_TMP_END);
                    var L2 = def_TMP_END.length;
                    var s = "";
                    if (_HasSound(ca)) {
                        ca.delay = 5000;
                        s = ca.text.substr(0, k1);
                        s += ca.text.substr(k2 + L2);
                    }
                    else {
                        s = ca.text.substr(0, k1);
                        s += ca.text.substr(k1 + L1, k2 - k1 - L1);
                        s += ca.text.substr(k2 + L2);
                    }
                    ca.text = s;
                }
            }
        }
    }

    showScreen = scr;
    if (!KGuestDemoMode) {
        showHistory[showHistory.length] = scr;
    };

    if (act)
        showAct = act
    else
        showAct = 0

    if (animPhase != "") {
        clearTimeout(animTimeout)
        animPhase = ""
    }

    showActObj = screens[showScreen].actions[showAct]

    if (showActObj == null) {
        showActObj = screens[showScreen].actions[0];
    }

    myscr = scr;
    url = screenshotPath + screens[showScreen].image;
    screenshot = new Image();
    event_blocked = true;
    DownloadImage(url, "Returned");
}

function Returned(url, success) {
    GetImage(screenshot, url);
    event_blocked = false;
    // Screenshot
    if (document.layers) {
        document.layers.screen.document.screenshot.src = screenshot.src;
    }
    else {
        document["screenshot"].src = screenshot.src;
        //    document.all["scrbg"].style.backgroundColor="black";
        //	if (IsLeadIn() || IsLeadOut() || IsDecision())
        //	{
        //	    document["screenshot"].style.filter='Alpha(opacity=80) gray()';
        //	}
        //	else
        //	{
        //	    document["screenshot"].style.filter='';
        //	}
    }
    ShowScreen2();
};

function GetDelay() {
    if (KGuestDemoMode)
        return 200;
    return showActObj.delay * 100;
};

function ShowScreen2() {
    scr = myscr;
    if (showActObj.type == "Input") {
        showActObj.par4 = false;
        showActObj.lastIMEtext = "";
    };
    ShowAction()
};

function ShowScreen3() {
    // Cursor
    if (playMode == "S" || KGuestDemoMode) {
        if (showScreen == "start" || showActObj.nextFrame == "end" || showActObj.type == "Decision")
            hide("cursor")
        else
            show("cursor")
    }
    if (playMode == "K" && !KGuestDemoMode)
        hide("cursor");

    // Preset input field
    if ((showActObj.type == 'Input' && playMode != "K") ||
	 (showActObj.type == 'Input' && playMode == "K" && !showActObj.par4)) {
        showActInpObj = document.layers ? document.layers.screen.document.layers["hot" + showActObj.id + "_0"].document["f" + showActObj.id]["inp" + showActObj.id] : document["f" + showActObj.id + "_0"]["inp" + showActObj.id + "_0"]
        //    showActInpObj.value = showActObj.par2
        showActInpObj.original = "";
        showActInpObj.onkeyup = EventKeyUp;
        // The onKeyPress handler is also assigned statically to the input element
        // to work around a Mozilla bug.
        showActInpObj.onkeypress = EventInputKey;
        //showActInpObj.onpropertychange = EventPropertyChange;
        EventPropertyChange();
        showActInpObj.onfocus = InputOnFocus;
        showActInpObj.onblur = InputOnBlur;
        try {
            showActInpObj.focus();
        }
        catch (e) { };
        //	var txtRange=showActInpObj.createTextRange()
        //	var txt=txtRange.text;
        //	txtRange.text=txt;
        setTimeout("showActInpObj.value=showActObj.par2;showActInpObj.original=showActInpObj.value;showActInpObj.select()", 50)
    }

    // Scroll to make action visible
    ScrollToAction()
}

function ShowScreen4() {
    // Panel up/down
    HandleResize()

    /*
    // Preload next screenshot(s)
    var preloadID = showActObj.nextFrame
    var preloadNext = true
    var count = 5
    preloadScreen = new Array()
    while(preloadID!="end" && preloadNext && count--)
    {
    preloadScreen[preloadScreen.length] = new Image()
    preloadScreen[preloadScreen.length-1].src = screenshotPath+screens[preloadID].image;
    preloadNext = TeacherTestSkip(screens[preloadID].actions[0].type)
    preloadID = screens[preloadID].actions[0].nextFrame
    }
    */
    PreloadImages();
    // Set buttons
    //	RefreshActionMenu()

    var hot = "hot" + showActObj.id + "_0"
    var asx = (showActObj.id).substr(1) + ".ASX";

    // Kick off timers and animations in Demo mode
    if (playMode == "S" || KGuestDemoMode) {
        if (showActObj.nextFrame == "end") {
            Animate2(asx, false, "ClosePlayer(1)", GetDelay(), "other");
        };

        if (showActObj.type == "Input") {
            animSteps = DecodeInputString(showActObj.par1[1]).length
            Animate2(asx, false, "AnimateInput()", GetDelay(), "input")
        }
        else if (showActObj.type == "Key") {
            Animate2(asx, false, "AnimateKeyboard()", GetDelay(), "keyboard")
        }
        else if (showActObj.type == "None" || showActObj.type == "Decision" || !getDIV(hot)) {
            Animate2(asx, false, "ShowScreen('" + showActObj.nextFrame + "')", GetDelay(), "other")
        }
        else {
            var cx, cy
            var dx, dy

            var sScreen = getDIV("screen");
            var sx = sScreen.offsetLeft;
            var sy = sScreen.offsetTop;

            anim_to_x = sx + getObjLeft(hot) + getObjWidth(hot) / 2
            anim_to_y = sy + getObjTop(hot) + getObjHeight(hot) / 2
            cx = getObjLeft("cursor")
            cy = getObjTop("cursor")
            dx = anim_to_x - cx
            dy = anim_to_y - cy

            animSteps = Math.round(Math.sqrt(dx * dx + dy * dy) / MOUSE_STEP)
            if (animSteps == 0) animSteps++;
            animStepOriginal = animSteps;

            anim_x = dx / animSteps
            anim_y = dy / animSteps

            if ((showActObj.type == "Drag" || showActObj.type.indexOf("Up") != -1)) {
                shiftTo("bullseye", cx - sx - getObjWidth("bullseye") / 2, cy - sy - getObjHeight("bullseye") / 2)
                HideBullsEye();
                //        show("bullseye")
            }
            else {
                HideBullsEye();
            }

            Animate2(asx, false, "AnimateMouse()", GetDelay(), "mouse")
        }
    }
    else {
        if (showActObj.emptybubble && showActObj.type == "None" && scr != "start") {
            Animate2(asx, false, "ShowScreen('" + showActObj.nextFrame + "')", GetDelay(), "other")
        }
        else {
            animObject = new AnimObject("", "", "");
            PlaySound(asx, false);
        };
    }
};

function PreloadImages() {
    if (!PreloadScreen_Enabled)
        return;
    // Preload next screenshot(s)
    var preloadID = showActObj.nextFrame
    var preloadNext = true
    var count = 3;
    while (preloadID != "end" && preloadNext && count--) {
        url = screenshotPath + screens[preloadID].image;
        PreloadImage(url);
        //		preloadNext = TeacherTestSkip(screens[preloadID].actions[0].type);
        preloadID = screens[preloadID].actions[0].nextFrame;
    }
    for (var i = 0; i < screens[showScreen].actions.length; i++) {
        preloadID = screens[showScreen].actions[i].nextFrame;
        if (preloadID != "end") {
            url = screenshotPath + screens[preloadID].image;
            PreloadImage(url);
        };
    };
}

function GetShiftState(event) {
    if (event == 0)
        event = window.event;
    if (event.storedEvent)
        return event.pShState;
    var alt = event.modifiers ? (event.modifiers & Event.ALT_MASK) : event.altKey;
    var ctrl = event.modifiers ? (event.modifiers & Event.CONTROL_MASK) : event.ctrlKey;
    var shift = event.modifiers ? (event.modifiers & Event.SHIFT_MASK) : event.shiftKey
    var ret = (shift ? "s" : "") + (ctrl ? "c" : "") + (alt ? "a" : "");
    return ret;
}

function GetButton(event) {
    if (event == 0)
        event = window.event;
    if (event.storedEvent)
        return event.pButton;
    if (event.button)
        return (event.button & 1) ? "L" : (event.button & 2) ? "R" : (event.button & 4) ? "M" : ""
    else
        return (event.which == 1) ? "L" : (event.which == 3) ? "R" : ""
}

function GetMouseX(event) {
    if (event == 0)
        event = window.event;
    if (event.storedEvent)
        return event.pX;
    if (event.pageX)
        if (event.type == "DOMMouseScroll")
        return event.screenX - getObjLeft("screen") + document.body.scrollLeft
    else
        return event.pageX - getObjLeft("screen")
    else if (event.x)
        return event.x - getObjLeft("screen") + getScrollLeft()
    else
        return event.layerX;
}

function GetMouseY(event) {
    if (event == 0)
        event = window.event;
    if (event.storedEvent)
        return event.pY;
    if (event.pageY)
        if (event.type == "DOMMouseScroll")
        return event.screenY - getObjTop("screen") + document.body.scrollTop
    else
        return event.pageY - getObjTop("screen")
    else if (event.y)
        return event.y - getObjTop("screen") + getScrollTop()
    else
        return event.layerY;
}

function MouseInObject(event, objID) {
    var hot = getDIV(objID)
    if (hot) {
        var mx = GetMouseX(event);
        var my = GetMouseY(event);
        var hx = getObjLeft(objID);
        var hy = getObjTop(objID);
        var hw = getObjWidth(objID);
        var hh = getObjHeight(objID);

        if (showActObj.type == "Input") {
            var s = showActInpObj.id.substr(0, 14);
            while (s.substr(s.length - 1, 1) == 'p' || s.substr(s.length - 1, 1) == 'x') {
                s = s.substr(0, s.length - 1);
            }
            if (s == objID) {
                hw = showActInpObj.offsetWidth;
                hh = showActInpObj.offsetHeight;
            }
        }
        if (mx >= hx && my >= hy && mx < hx + hw && my < hy + hh)
            return true
    }
    return false
}

function MouseInHotspot(event, action) {
    if (action == null)
        action = showActObj;
    for (var i = 0; i < action.hotspots; i++) {
        if (MouseInObject(event, "hot" + action.id + "_" + i) &&
									GetShiftState(event) == action.par1)
            return true;
    };
    return false;
}

function ActionControl(type, event, avoidinput) {
    if (avoidinput == null)
        avoidinput = false;
    if (event == null) {
        for (var i = 0; i < screens[showScreen].actions.length; i++) {
            var myAct = screens[showScreen].actions[i];
            if (myAct.type == type) {
                return myAct;
            };
        };
        return 0;
    };

    for (var i = 0; i < screens[showScreen].actions.length; i++) {
        var myAct = screens[showScreen].actions[i];
        if (myAct.type == type && MouseInHotspot(event, myAct)) {
            return myAct;
        };
    };

    if (avoidinput == true)
        return null;

    if (showActObj.type == "Input") {
        var nf = showActObj.nextFrame;
        for (var i = 0; i < screens[nf].actions.length; i++) {
            var myAct = screens[nf].actions[i];
            if (myAct.type == type && MouseInHotspot(event, myAct)) {
                return myAct;
            };
        };
    };

    return 0;
};

function ActionKeyControl(code, event, noShift) {
    if (!noShift)
        noShift = false;
    var code1 = code;
    if (code == 107 || code == 187)		// + key
        code1 = 43;
    var shState = GetShiftState(event);
    if (shState.length > 0) {
        if (noShift) {
            if (shState.substr(0, 1) == "s")
                shState = shState.substr(1);
        };
    };
    for (var i = 0; i < screens[showScreen].actions.length; i++) {
        var myAct = screens[showScreen].actions[i];
        if (myAct.type == "Key" &&
					code1 == myAct.par1 && shState == myAct.par2) {
            return myAct;
        };
    };
    return 0;
};

function IsDragSequence() {
    var k = screens[showScreen].actions.length;
    return (k == 1 && screens[showScreen].actions[0].type == "Drag");
};

///////////////////////////////////////////
// mouse global variables
var m_mouseStatus = 0;
var m_p1 = new StoredEvent(0, 0, "", "");
var m_p2 = new StoredEvent(0, 0, "", "");
var m_p3 = new StoredEvent(0, 0, "", "");
var m_buttonID;
var DOUBLECLICKTIME = 500;
var m_timer1 = 0;
var m_timer2 = 0;
var m_bClkEvent = false;
var m_begindragEvent = 0;
///////////////////////////////////////////

function BDown(point) {
    m_begindragEvent = 0;
    var act = ActionControl(m_buttonID + "BDown", point);
    if (showActObj.type == "Input") {
        if (AssessStringInput(true)) //complete
        {
            showHistory[showHistory.length] = showActObj.nextFrame;
            historyActionMap[showActObj.nextFrame] = 0;
            TeacherForward(true, act.nextFrame, act.id);
        }
        else {
            m_mouseStatus = 0;
            FalseEvent();
        };
        return;
    };
    if (act) {
        TeacherForward(true, act.nextFrame, act.id);
    }
    else {
        m_mouseStatus = 0;
        FalseEvent();
    };
};

function BBeginDrag(point) {
    var act = ActionControl(m_buttonID + "BeginDrag", point);
    if (showActObj.type == "Input") {
        if (AssessStringInput(true)) //complete
        {
            showHistory[showHistory.length] = showActObj.nextFrame;
            historyActionMap[showActObj.nextFrame] = 0;
            TeacherForward(true, act.nextFrame, act.id);
        }
        else {
            m_mouseStatus = 0;
            FalseEvent();
        };
        return;
    };
    if (act) {
        TeacherForward(true, act.nextFrame, act.id);
    }
    else {
        m_mouseStatus = 0;
        FalseEvent();
    };
};

function BUp(point) {
    if (isOnLink)
        return;
    m_begindragEvent = 0;
    var act = ActionControl(m_buttonID + "Up", point);
    if (act) {
        TeacherForward(true, act.nextFrame, act.id);
    }
    else {
        m_mouseStatus = 0;
        if (playMode == "K" && KScoringScreen)
            return
        else if (IsLeadIn() || IsLeadOut() || showActObj.type == "None")
            return
        else
            FalseMouseEvent();
    };
};

function BClk(point) {
    m_begindragEvent = 0;
    var act = ActionControl(m_buttonID + "Click1", point, false);
    if (showActObj.type == "Input") {
        if (AssessStringInput(true)) //complete
        {
            showHistory[showHistory.length] = showActObj.nextFrame;
            historyActionMap[showActObj.nextFrame] = 0;
            TeacherForward(true, act.nextFrame, act.id);
            return;
        }
    };
    if (act) {
        TeacherForward(true, act.nextFrame, act.id);
    }
    else {
        FalseEvent();
    };
};

function BDblClk(point) {
    m_begindragEvent = 0;
    var act = ActionControl(m_buttonID + "Click2", point, false);
    if (showActObj.type == "Input") {
        if (AssessStringInput(true)) //complete
        {
            showHistory[showHistory.length] = showActObj.nextFrame;
            historyActionMap[showActObj.nextFrame] = 0;
            TeacherForward(true, act.nextFrame, act.id);
            return;
        }
    };
    if (act) {
        TeacherForward(true, act.nextFrame, act.id);
    }
    else {
        FalseEvent();
    };
};

function BTrplClk(point) {
    m_begindragEvent = 0;
    var act = ActionControl(m_buttonID + "Click3", point, false);
    if (showActObj.type == "Input") {
        if (AssessStringInput(true)) //complete
        {
            showHistory[showHistory.length] = showActObj.nextFrame;
            historyActionMap[showActObj.nextFrame] = 0;
            TeacherForward(true, act.nextFrame, act.id);
            return;
        }
    };
    if (act) {
        TeacherForward(true, act.nextFrame, act.id);
    }
    else {
        FalseEvent();
    };
};

function BWheel(point) {
    var act = ActionControl("Wheel", point);
    if (showActObj.type == "Input") {
        if (AssessStringInput(true)) //complete
        {
            showHistory[showHistory.length] = showActObj.nextFrame;
            historyActionMap[showActObj.nextFrame] = 0;
            TeacherForward(true, act.nextFrame, act.id);
        }
        else {
            FalseEvent();
        };
        return;
    };
    if (act) {
        TeacherForward(true, act.nextFrame, act.id);
    }
    else {
        FalseEvent();
    };
};

function FalseMouseEvent() {
    if (showActObj.type == "Input") {
        if (AssessStringInput(true)) //complete
        {
            TeacherForward(true, showActObj.nextFrame, showActObj.id);
            setTimeout("FalseEvent();", 300);
        }
        else {
            FalseEvent();
        };
        return;
    };
    FalseEvent();
}

function FalseEvent() {
    TeacherWrong();
};

var g_x, g_y, g_shst;
var g_timer = 0;

function EventMouseMove(event) {
    if (event == null)
        event = window.event;
    if (playMode == "K") {
        g_x = GetMouseX(event);
        g_y = GetMouseY(event);
        g_shst = GetShiftState(event)
    };
    if (playMode == "K" && KGuestDemoMode)
        return false;
    if (playMode == "K" && IsDragBegin())
        return false;
    //	defaultStatus=GetMouseX(event)+","+GetMouseY(event);
    // begindrag
    if (m_begindragEvent) {
        if (!MouseInHotspot(event, m_begindragEvent)) {
            TeacherForward(true, m_begindragEvent.nextFrame, m_begindragEvent.id);
            m_begindragEvent = 0;
        };
    };
    // drag
    var act = ActionControl("Drag", event);
    if (act) {
        TeacherForward(true, act.nextFrame, act.id);
    };
    // point
    act = ActionControl("Move", event)
    if (act) {
        if (playMode == "K") {
            if (g_timer == 0) {
                g_timer = setTimeout("PointDelay();", 300);
            };
        }
        else
            TeacherForward(true, act.nextFrame, act.id);
    };
};

function PointDelay() {
    var myevent = new StoredEvent(g_x, g_y, g_shst);
    g_timer = 0;
    act = ActionControl("Move", myevent)
    if (act) {
        TeacherForward(true, act.nextFrame, act.id);
    };
};

function EventDblClk(event) {
    if (playMode == "S")
        return false;
    if (playMode == "K" && KGuestDemoMode)
        return false;
    if (playMode == "K" && IsDragBegin())
        return false;
    if (document.layers)
        return false;
    if (m_mouseStatus == 0)
        return false;
    EventMouseDown(event);
    return false;
};

function EventWheel(event) {
    if (playMode == "K" && KGuestDemoMode)
        return false;
    if (playMode == "K" && IsDragBegin())
        return false;
    if (playMode == "K" && (KConfirmDemo > 0))
        return false;
    if (playMode == "S")
        return false;
    if (m_mouseStatus != 0)
        return false;
    if (event == null)
        event = window.event;
    BWheel(event);
    return false;
};

function DocEventMouseDown(event) {
    if (!event)
        event = window.event;
    if (event.srcElement) {
        if (event.srcElement.id == "m_ActionText")
            return;
    }
    if (event.target) {
        if (event.target.id == "m_ActionText")
            return;
    }
    if (actionMenu) {
        if (actionMenu.IsOnScreen()) {
            actionMenu.Close();
            return true;
        };
    }
};

function EventMouseDown(event) {
    if (actionMenu) {
        if (actionMenu.IsOnScreen()) {
            actionMenu.Close();
            return true;
        };
    }
    if (playMode == "K" && KGuestDemoMode)
        return false;
    if (playMode == "K" && IsDragBegin())
        return false;
    if (playMode == "K" && (KConfirmDemo > 0))
        return false;
    if (playMode == "S") {
        if (isOnLink)
            return true;
        //		else if(showActObj.type!="Decision")
        //			DemoForward()
        //		else
        //			TeacherWrong()
        //		else if (IsLeadIn() || IsLeadOut())
        //			DemoForward();
        return false
    }

    if (event == null)
        event = window.event;
    var but = GetButton(event);
    if (!m_buttonID)
        m_buttonID = but;
    if (but == "")
        but = m_buttonID;
    if (playMode == "K" || playMode == "T") {
        if (showActObj.type == "Input") {
            for (var i = 0; i < showActObj.hotspots; i++) {
                if (MouseInObject(event, "hot" + showActObj.id + "_" + i)) {
                    return true;
                };
            };
        };
    };
    if (screens[showScreen].actions.length > 0) {
        if (screens[showScreen].actions[0].type == "Decision")
            return true;
    };
    var downEvent = ActionControl(but + "BDown", event);
    var begindragEvent = ActionControl(but + "BeginDrag", event);
    var clkEvent = ActionControl(but + "Click1", event);
    var dblclkEvent = ActionControl(but + "Click2", event);
    var trplclkEvent = ActionControl(but + "Click3", event);
    switch (m_mouseStatus) {
        case 0:
            // first down event arrived
            m_bClkEvent = false;
            m_mouseStatus = 1;
            m_p1 = new StoredEvent(GetMouseX(event), GetMouseY(event), GetShiftState(event), but);
            m_buttonID = but;
            m_begindragEvent = 0;
            if (clkEvent == 0 && dblclkEvent == 0 && trplclkEvent == 0) {
                if (downEvent)
                    BDown(m_p1);
                if (begindragEvent)
                    BBeginDrag(m_p1);
                break;
            };
            if (begindragEvent) {
                m_begindragEvent = begindragEvent;
            };
            if (dblclkEvent || trplclkEvent) {
                m_timer1 = setTimeout(Event_Mouse_Timer1, DOUBLECLICKTIME);
            };
            break;
        case 2:
            // doubleclick event arrived
            if (but != m_buttonID)
                break;
            if (m_timer1 > 0) {
                clearTimeout(m_timer1);
                m_timer1 = 0;
            };
            if (dblclkEvent && trplclkEvent == 0) {
                m_mouseStatus = 0;
                if (MouseInHotspot(m_p1, dblclkEvent)) {
                    BDblClk(event);
                }
                else {
                    FalseMouseEvent();
                };
                break;
            };
            m_mouseStatus = 3;
            m_p3 = new StoredEvent(GetMouseX(event), GetMouseY(event), GetShiftState(event), but);
            m_timer2 = setTimeout(Event_Mouse_Timer2, DOUBLECLICKTIME);
            break;
        case 3:
            // tripleclick event arrived
            if (but != m_buttonID)
                break;
            if (m_timer2 > 0) {
                clearTimeout(m_timer2);
                m_timer2 = 0;
            };
            m_mouseStatus = 0;
            if (trplclkEvent && MouseInHotspot(m_p1, trplclkEvent) &&
													MouseInHotspot(m_p3, trplclkEvent)) {
                BTrplClk(event);
            }
            else {
                FalseMouseEvent();
            };
            break;
        default:
            m_mouseStatus = 0;
            break;
    };
    return false;
};

function EventMouseUp(event) {
    if (playMode == "K" && KGuestDemoMode)
        return false;
    if (playMode == "K" && IsDragBegin())
        return false;
    if (playMode == "K" && (KConfirmDemo > 0))
        return false;
    if (event == null)
        event = window.event;
    var but = GetButton(event);
    if (but != m_buttonID)
        return false;
    if (screens[showScreen].actions.length > 0) {
        if (screens[showScreen].actions[0].type == "Decision")
            return true;
    };
    var clkEvent = ActionControl(but + "Click1", event);
    var dblclkEvent = ActionControl(but + "Click2", event);
    var trplclkEvent = ActionControl(but + "Click3", event);
    switch (m_mouseStatus) {
        case 1:
            // first up event arrived
            if (clkEvent == 0 && dblclkEvent == 0 && trplclkEvent == 0) {
                m_mouseStatus = 0;
                BUp(event);
                break;
            };
            if (clkEvent) {
                m_bClkEvent = MouseInHotspot(m_p1, clkEvent);
            };
            if (m_timer1 == 0) {
                if (clkEvent) {
                    m_mouseStatus = 0;
                    if (m_bClkEvent)
                        BClk(event)
                    else
                        BUp(event);
                }
                else {
                    m_mouseStatus = 0;
                    FalseMouseEvent();
                };
                break;
            };
            m_mouseStatus = 2;
            m_p2 = new StoredEvent(GetMouseX(event), GetMouseY(event), GetShiftState(event), but);
            break;
        default:
            break;
    };
    return false;
};

function Event_Mouse_Timer1() {
    m_timer1 = 0;
    if (m_mouseStatus == 2) {
        if (m_bClkEvent)
            BClk(m_p2)
        else
            BUp(m_p2);
        m_mouseStatus = 0;
    };
};

function Event_Mouse_Timer2() {
    m_timer2 = 0;
    if (m_mouseStatus == 3) {
        m_mouseStatus = 0;
        var dblEvent = ActionControl(m_buttonID + "Click2", m_p3);
        if (dblEvent) {
            if (MouseInHotspot(m_p1, dblEvent)) {
                BDblClk(m_p3);
            };
        }
        else {
            FalseMouseEvent();
        };
    };
};

var knowit_AltF4Pressed = false;

function BeforeUnload() {
    if (fatPlayer == "" && knowit_AltF4Pressed) {
        knowit_AltF4Pressed = false;
        try { event.returnValue = ""; } catch (e) { };
    };
    if (navigator.userAgent.indexOf("Firefox/3.6") > 0) {
        UnLoad();
    }
    if (navigator.userAgent.indexOf("Safari") > 0) {
        UnLoad();
    }
};

var getCode = false;
//var fromInput=false;

function EventKeyPress(event) {
    if (showActObj.type == "Input")
        return true;
    //	if (fromInput)
    //	{
    //		fromInput=false;
    //		return false;
    //	};
    if (!getCode)
        return true;

    if (event == null)
        event = window.event;
    var code = event.which ? event.which : event.keyCode
    //	if (!(code>=112 && code<=123))
    if (code >= 65 && code <= 90) {
        var codes = String.fromCharCode(code);
        var upcodes = codes.toUpperCase();
        code = upcodes.charCodeAt(0);
    };

    if (playMode == "T") {
        if (act = ActionKeyControl(code, event, true))
            TeacherForward(true, act.nextFrame, act.id)
        else if (!IsLeadIn() && !IsLeadOut())
            TeacherWrong();
    }
    else	// playMode==K
    {
        if (act = ActionKeyControl(code, event, true))
            TeacherForward(true, act.nextFrame, act.id)
        else
            TeacherWrong()
    };
    getCode = false;
    return false;
};

function EventKeyDown(event) {
    if (event == null) {
        event = window.event;
    }

    var code = event.which ? event.which : event.keyCode;

    // NS: Disable function keys in "See It" mode
    if ((playMode == "S") && (code >= 112) && (code <= 123)) {
        return false;
    }

    if (playMode == "K") {
        if (KFinishClose == true) {
            return false;
        }
    }

    if (showActObj.type == "Input") {
        if (playMode == "S" || (playMode == "K" && KGuestDemoMode)) {
            if (code == 13)
                DemoForward();
            if (code == 27)
                ClosePlayer();
            if (code == 32)
                PauseToggle();
            return false;
        }
        if (code == 9 && StringInput_LostFocus_Autoadvance_Enabled) {
            if (AssessStringInput(true)) //complete
            {
                TeacherForward(true);
            }
            else {
                TeacherWrong();
            };
        };
        if (code == 13) {
            if (playMode == "T" && UserPrefs.TryIt.EnableSkipping) {
                TeacherForward(true);
            }
            else if (AssessStringInput(true)) //complete
            {
                TeacherForward(true);
            }
            else {
                TeacherWrong();
            };
        }
        if (IsSafari() && code == 27) {
            OnClose();
            return false;
        }
        return true;
    }
    if (playMode == "K" && KGuestDemoMode)
        return false;
    if (playMode == "K" && IsDragBegin())
        return false;
    //	if (!(code>=112 && code<=123))
    if (code >= 65 && code <= 90) {
        var codes = String.fromCharCode(code);
        var upcodes = codes.toUpperCase();
        code = upcodes.charCodeAt(0);
    };
    if (code >= 16 && code <= 18)
        return true;
    if (code == 91 || code == 92)		//(windows key!)
        return true;

    if (code == 114 || code == 116 || code == 117 || code == 121)		// F3, F5, F6 and F10 keys
    {
        if (document.all && !IsFF3())
            event.keyCode = 0;
        if (playMode == "S")
            return false;
    };

    var act;
    if (playMode == "S") {
        if (code == 27) {
            ClosePlayer();
            return false;
        }
        else if (code == 32) {
            PauseToggle()
            return false;
        }
        else if (code == 13) {
            //			if(isTabbed)
            //				return true
            DemoForward(showActObj.delay != DELAY_INFINITE);
            return false;
        }
        //		else if(code==9)
        //		{
        //			isTabbed = true
        //			return false
        //		}
        return true;
    }
    else if (playMode == "T") {
        if (event.keyCode == 115 && event.altKey == true) {
            return false;
        };
        if (code == 13) {
            if (actionMenu) {
                if (actionMenu.IsOnScreen()) {
                    closedbyEnter = true;
                    actionMenu.Close();
                    return true;
                };
            }
            //			if (isTabbed)
            //				return true
            //			else
            if (act = ActionKeyControl(code, event)) {
                TeacherForward(true, act.nextFrame, act.id);
                return false;
            }
            else if (UserPrefs.TryIt.EnableSkipping) {
                TeacherForward(false)
                return false;
            }
            else if (screens[showScreen].actions[0].type == "None") {
                TeacherForward(true)
                return false;
            }
            if (!UserPrefs.TryIt.EnableSkipping) {
                TeacherWrong();
                return false;
            }
            else
                return true;
        }
        /*		
        else if(act=ActionKeyControl(code,event))
        TeacherForward(true,act.nextFrame)
        else if(code==9)
        {
        isTabbed = true;
        return true;
        }
        else if(code==27)
        ClosePlayer()
        else if((code>=16 && code<=18) || showActObj.type=="Input")
        return true
        else if (!IsLeadIn() && !IsLeadOut())
        TeacherWrong()
        */
        else if (code == 27) {
            if (act = ActionKeyControl(code, event))
                TeacherForward(true, act.nextFrame, act.id)
            else
                ClosePlayer();
            return false;
        }
        else if (code == 9) {
            if (act = ActionKeyControl(code, event)) {
                TeacherForward(true, act.nextFrame, act.id);
                return false;
            }
            else {
                TeacherWrong();
                return false;
            };
        }
        else if ((code >= 16 && code <= 18) || showActObj.type == "Input")
            return true
        else if (act = ActionKeyControl(code, event)) {
            TeacherForward(true, act.nextFrame, act.id);
            return false;
        }
        if (code >= 112 && code <= 123)	// function keys
        {
            TeacherWrong();
            return false;
        };
        getCode = true;
        return true;
    }
    else // playMode=="K"
    {
        if (event.keyCode == 115 && event.altKey == true)	// altF4
        {
            try { event.keyCode = 27; } catch (e) { };
            code = 27;
            knowit_AltF4Pressed = true;
        };
        if (code == 13) {
            if (KScoringScreen)
                ClosePlayer(1)
            else if (IsLeadIn() || IsLeadOut())
                TeacherForward(true)
            else if (act = ActionKeyControl(code, event))
                TeacherForward(true, act.nextFrame, act.id)
            else if (screens[showScreen].actions[0].type == "None") {
                TeacherForward(true, act.nextFrame, act.id)
            }
            else
                TeacherWrong()
            return true;
        };
        /*		
        if(act=ActionKeyControl(code,event))
        TeacherForward(true,act.nextFrame)
        else if(code==27)
        OnClose()
        else if((code>=16 && code<=18) || showActObj.type=="Input")
        return true
        else
        TeacherWrong()
        */
        //		if(code==9)
        //		{
        //			TeacherWrong();
        //			return false;
        //		}
        //		else if(code==27) !!!!!
        if (code == 27) {
            if (act = ActionKeyControl(code, event))
                TeacherForward(true, act.nextFrame, act.id)
            else
                OnClose();
            return false;
        }
        else if (code == 9) {
            if (act = ActionKeyControl(code, event)) {
                TeacherForward(true, act.nextFrame, act.id);
                return false;
            }
            else {
                TeacherWrong();
                return false;
            };
        }
        else if ((code >= 16 && code <= 18) || showActObj.type == "Input")
            return true
        else if (act = ActionKeyControl(code, event)) {
            TeacherForward(true, act.nextFrame, act.id)
            return false;
        };
        if (code >= 112 && code <= 123)	// function keys
        {
            TeacherWrong();
            return false;
        };
        getCode = true;
        return true;
    };
    return false;
}

////////////////////////////////////////////////////////////////////////////////////////

function matchCharacter(char1, char2) {
    var halfKatakanaSet = " ｦｧｨｩｪｫｬｭｮｯｰｱｲｳｴｵｶｷｸｹｺｻｼｽｾｿﾀﾁﾂﾃﾄﾅﾆﾇﾈﾉﾊﾋﾌﾍﾎﾏﾐﾑﾒﾓﾔﾕﾖﾗﾘﾙﾚﾛﾜﾝ";
    var fullKatakanaSet = "　ヲァィゥェォャュョッーアイウエオカキクケコサシスセソタチツテトナニヌネノハヒフヘホマミムメモヤユヨラリルレロワン";

    if (char1 == char2) {
        return true;
    }
    else if (halfKatakanaSet.indexOf(char1) > -1 && halfKatakanaSet.indexOf(char2) > -1) {
        return false;
    }
    else if (fullKatakanaSet.indexOf(char1) > -1 && fullKatakanaSet.indexOf(char2) > -1) {
        return false;
    }
    else if (halfKatakanaSet.indexOf(char1) > -1 || halfKatakanaSet.indexOf(char2) > -1) {
        return halfKatakanaSet.indexOf(char1) == fullKatakanaSet.indexOf(char2) || halfKatakanaSet.indexOf(char2) == fullKatakanaSet.indexOf(char1);
    }
    else {
        var diff = "Ａ".charCodeAt(0) - "A".charCodeAt(0);
        var charCode1 = char1.charCodeAt(0);
        var charCode2 = char2.charCodeAt(0);

        return (charCode1 - diff == charCode2) || (charCode2 - diff == charCode1);
    }
}

function replaceDotAndCircle(str) {
    var fullKatakanaSet1 = "ガギグゲゴザジズゼゾダヂヅデドバビブベボ";
    var newFullKatakanaSet1 = "カキクケコサシスセソタチツテトハヒフヘホ";
    var fullKatakanaSet2 = "パピプペポ"
    var newFullKatakanaSet2 = "ハヒフヘホ";
    var newStr = null;

    newStr = str.replace(new RegExp("ﾞ", "g"), "#");
    newStr = newStr.replace(new RegExp("ﾟ", "g"), "*");

    for (var i = 0; i < fullKatakanaSet1.length; i++) {
        newStr = newStr.replace(new RegExp(fullKatakanaSet1.charAt(i), "g"), newFullKatakanaSet1.charAt(i) + "#");
    }
    for (var i = 0; i < fullKatakanaSet2.length; i++) {
        newStr = newStr.replace(new RegExp(fullKatakanaSet2.charAt(i), "g"), newFullKatakanaSet2.charAt(i) + "*");
    }
    return newStr;
}

function matchString(s1, s2, casesensitive) {
    if (!s1)
        return false;
    if (!casesensitive)
        casesensitive = false;
    var sl1 = s1.length;
    var sl2 = s2.length;
    if (sl1 == 0 && sl2 == 0)
        return true;
    if (sl1 == 0 && sl2 != 0)
        return false;
    if (sl1 != 0 && sl2 == 0)
        return false;
    if (sl1 != sl2)
        return false;

    var ss1 = (casesensitive ? s1 : s1.toLowerCase());
    var ss2 = (casesensitive ? s2 : s2.toLowerCase());

    var newStr1 = replaceDotAndCircle(ss1);
    var newStr2 = replaceDotAndCircle(ss2);
    if (newStr1.length != newStr2.length)
        return false;

    for (var i = 0; i < newStr1.length; i++) {
        if (!matchCharacter(newStr1.substr(i, 1), newStr2.substr(i, 1)))
            return false;
    }
    return true;
}

////////////////////////////////////////////////////////////////////////////////////////

function StrongAssess(complete, primary) {
    if (!complete)
        complete = false;
    if (!primary)
        primary = false;
    var v = showActInpObj.value;
    if (primary) {
        var s = showActObj.par1[1];
        if (matchString(s, v, showActObj.par3))
            return true;
        var s = DecodeInputString(showActObj.par1[1]);
        return matchString(s, v, showActObj.par3)
    };

    if (complete) {
        if (showActObj.par1[0] == "N" && v == "")
            return true;
        if (showActObj.par1[0] == "A" && v == "")
            return true;
    }

    for (var i = 1; i < showActObj.par1.length; i++) {
        var s = showActObj.par1[i];
        if (matchString(s, v, showActObj.par3))
            return true;
        s = DecodeInputString(showActObj.par1[i]);
        if (matchString(s, v, showActObj.par3))
            return true;
    };
    return false;
};

function AssessStringInput(complete) {
    if (!complete)
        complete = false;

    var validatedoption = false;
    if (playMode == "T" && TryIt_Validated_StringInput)
        validatedoption = true;
    if (playMode == "K" && KnowIt_Validated_StringInput)
        validatedoption = true;

    if (!complete)
        return StrongAssess(false, !validatedoption);
    if (validatedoption) {
        if (showActObj.par1[0] == "N" || showActObj.par1[0] == "") {
            return StrongAssess(true, false);
        }
        else if (showActObj.par1[0] == "S") {
            return (showActInpObj.value.length > 0);
        }
        else {
            return true;
        };
    }
    else {
        return StrongAssess(complete, true);
    };

};

function EventInputKey(event) {
    if (playMode == "S") {
        var code = window.event ? window.event.keyCode : event.which ? event.which : event.keyCode;
        if (code == 27) {
            OnClose();
            return false;
        };
        setTimeout("showActInpObj.value=showActInpObj.original;", 10);
        return false;
    }
    if (playMode == "K" && KGuestDemoMode) {
        setTimeout("showActInpObj.value=showActInpObj.original;", 10);
        return false;
    };
    if (playMode == "K" && IsDragBegin()) {
        setTimeout("showActInpObj.value=showActInpObj.original;", 10);
        return false;
    };
    if (playMode == "T" || playMode == "K") {
        var code = window.event ? window.event.keyCode : event.which ? event.which : event.keyCode;
        if (code != 13)
            showActObj.par4 = true;
        if (code == 27) {
            showActInpObj.value = showActObj.par5;
            showActInpObj.original = showActInpObj.value;
            OnClose();
            return false;
        };
    }
    //return false;
    return true;
}

///////////////////////////////////////////////
// Trace for test
var tracewindow = null;

function Trace(s) {
    if (tracewindow == null) {
        tracewindow.open("", "", "");
    };
    tracewindow.document.writeln(s);
    tracewindow.document.writeln("<br>");
    tracewindow.scrollBy(0, 100);
}
///////////////////////////////////////////////

function EventPropertyChange()
// it works by non key based character input (japanese content, IME input)
{
    setTimeout("EventPropertyChange();", 10);
    if (showActObj.par4 == false) {
        return true;
    }
    if (playMode == "T" || playMode == "K") {
        if (StringInput_Autoadvance_Enabled) {
            if (AssessStringInput(false))			// implicit
            {
                TeacherForward(true, showActObj.nextFrame, showActObj.id);
                /*
                if(document.all){
                TeacherForward(true);
                }
                else 
                {
                if (typeof(HLinkStart)!='undefined' && HLinkStart==true)
                {
                TeacherForward(true);
                }
                else if(showActInpObj.value==showActInpObj.original)
                {

					    switch(typeof(showActInpObj.firstCall))
                {
                case 'undefined' :  showActInpObj.firstCall=true; 
                showActInpObj.value=showActInpObj.original+' ';
                showActInpObj.select();
                break;
                                  
                default :           showActInpObj.firstCall=false; break;
                }
                if(showActInpObj.firstCall==false) TeacherForward(true);
                }
                else
                {
                TeacherForward(true);
                }
                }
                */
            }
        }
    }
    return true;
}

function EventKeyUp(event) {
    return true
}

function EventCancel(event) {
    return false	// cancel popups
}

function UnLoad() {
    if (playMode == "K") {
        trackScoreCompleted = GetResultInPercent(true);
        trackScoreRequired = KScoreNeeded;
        if (KTopicFinished || KScoringScreen || showActObj.nextFrame == 'end')
            trackComplete()
        else
            trackIncomplete();
    };
    if (playMode == "S" || playMode == "T" || playMode == "K") {
        ClosePlayer();
    }
    if (guidedParent) {
        guidedParent.GITMClosed();
    }
};

function StartFrameCorrection(frameID) {
    var originalFrameID = frameID;
    var frmPos = frameID;
    if (screens[frameID].backActions.length == 0) {
        StartScreen = "start";
        if (StartScreen != originalFrameID)
            StartAction = 0;
        return;
    };
    var fID = "";
    for (var i = 0; i < screens[frameID].backActions.length; i++) {
        if (i == 0)
            fID = screens[frameID].backActions[0].prevFrame
        else {
            if (fID != screens[frameID].backActions[0].prevFrame) {
                StartScreen = frameID;
                if (StartScreen != originalFrameID)
                    StartAction = 0;
                return;
            };
        };
    };
    frmPos = screens[frmPos].backActions[0].prevFrame;
    while (true) {
        if (screens[frmPos].backActions.length == 0) {
            StartScreen = "start";
            if (StartScreen != originalFrameID)
                StartAction = 0;
            return;
        };
        if (screens[frmPos].actions[0].type == "None") {
            frmPos = screens[frmPos].backActions[0].prevFrame;
            continue;
        };
        if (screens[frmPos].actions[0].type == "Decision") {
            StartScreen = frmPos;
            if (StartScreen != originalFrameID)
                StartAction = 0;
            return;
        };
        StartScreen = frameID;
        if (StartScreen != originalFrameID)
            StartAction = 0;
        return;
    };
    if (StartScreen != originalFrameID)
        StartAction = 0;
};

function SetStartFrame(frameID) {
    if (frameID.length == 0)
        return;
    if (screens[frameID])
        StartScreen = frameID;
};

function SetStartContext(contextID) {
    if (contextID.length == 0)
        return;
    var ctxArray = new Array();
    ctxArray = contextID.split("+");

    for (var i = 0; i < ctxArray.length; i++) {
        ctxItem = ctxArray[i];
        for (var j = 0; j < screenNames.length; j++) {
            scrName = screenNames[j];
            scr = screens[scrName];
            for (var k = 0; k < scr.actions.length; k++) {
                act = scr.actions[k];
                if (act.ctx == ctxItem) {
                    SetStartFrame(scrName);
                    StartFrameCorrection(StartScreen);
                    return;
                };
            };
        };
    };
};

function SetStartEcid(ecidexpression) {
    if (ecidexpression.length == 0)
        return;
    EcidComparer.Init(ecidexpression);
    for (var i = 0; i < screenNames.length; i++) {
        scrName = screenNames[i];
        scr = screens[scrName];
        for (var j = 0; j < scr.actions.length; j++) {
            act = scr.actions[j];
            if (EcidComparer.Compare(act.ecidarray)) {
                SetStartFrame(scrName);
                StartAction = j;
                firsthemialternativeindex = j;
                StartFrameCorrection(StartScreen);
                return;
            };
        };
    };
};

function Skip() {
    return false;
};

function SetFlags() {
    for (var i = 0; i < screenNames.length; i++) {
        scrName = screenNames[i];
        var bcount = 0;
        for (var j = 0; j < screens[scrName].actions.length; j++) {
            var ie = screens[scrName].emptyinfo;
            var te = screens[scrName].actions[j].emptytext;
            var be = (ie && te);
            screens[scrName].actions[j].emptybubble = be;
            if (!be && screens[scrName].actions[j].realAction == true)
                bcount++;
        };
        for (var j = 0; j < screens[scrName].actions.length; j++) {
            screens[scrName].actions[j].showalternatives = (bcount > 1);
            if (screens[scrName].actions[j].type == "None" ||
				screens[scrName].actions[j].type == "Decision")
                screens[scrName].actions[j].showalternatives = false;
        };
    };
};

var bBackActionsBuilded = false;

function BuildBackActions() {
    if (!bBackActionsBuilded) {
        for (var i = 0; i < screenNames.length; i++) {
            scr = screens[screenNames[i]];
            scr.backActions = new Array();
        };
        for (i = 0; i < screenNames.length; i++) {
            scr = screens[screenNames[i]];
            for (var j = 0; j < scr.actions.length; j++) {
                scr.actions[j].prevFrame = screenNames[i];
                s = scr.actions[j].nextFrame;
                if (s != "end")
                    screens[s].backActions[screens[s].backActions.length] = scr.actions[j];
            };
        };
    };
    bBackActionsBuilded = true;
};

function FirstScreen(restart) {

    Sound_Init(soundIsExported, UserPrefs.PlayAudio, "top.close()");

    BuildBackActions();
    if (!restart) {
        //ODS
        ODSOpenEvGroup();
        //ODS
    };
    event_blocked = false;

    if (playMode != "K") {
        if (restart) {
            StartScreen = FirstScreenName;
        }
        else {
            SetStartFrame(param_frame);
            SetStartContext(param_ctx);
            SetStartEcid(param_ecid);
            FirstScreenName = StartScreen;
            SetFlags();
        };
        if (StartScreen == "start") {
            if (showLeadIn == 0) {
                StartScreen = screens["start"].actions[0].nextFrame;
            }
            else if (showLeadIn != 1) {
                if (UserPrefs.ShowLeadIn == "toc") {
                    StartScreen = screens["start"].actions[0].nextFrame;
                }
            }
        }
    }
    else {
        FirstScreenName = StartScreen;
        KWrongScreens = new Array();
    };

    var screenObj = getDIV("screen")

    scrH = getObjHeight("screen");
    scrW = getObjWidth("screen");

    window.onresize = HandleResize0;
    window.onscroll = HandleResize;

    document.body.oncontextmenu = EventCancel;

    window.onhelp = Skip;
    document.onhelp = Skip;
    screenObj.onhelp = Skip;

    // Safety net in case onresize/onscroll is not processed properly
    if (navigator.appName.substring(0, 9) != "Microsoft")
        setInterval("HandleResize()", 1000)

    if (document.layers) {
        document.captureEvents(Event.KEYDOWN)
        if (playMode == "T" || playMode == "K") screenObj.captureEvents(Event.MOUSEMOVE)
        screenObj.captureEvents(Event.MOUSEDOWN)
        if (playMode == "T" || playMode == "K") screenObj.captureEvents(Event.MOUSEUP)
        screenObj.captureEvents(Event.DBLCLICK)
    }

    if (playMode == "T" || playMode == "K") screenObj.onmousemove = EventMouseMove
    screenObj.onmousedown = EventMouseDown;
    document.onmousedown = DocEventMouseDown;
    if (playMode == "T" || playMode == "K") screenObj.onmouseup = EventMouseUp
    screenObj.ondblclick = EventDblClk;

    if (screenObj.addEventListener)
        screenObj.addEventListener('DOMMouseScroll', EventWheel, false)
    else
        screenObj.onmousewheel = EventWheel;

    // ondblclick is also assigned statically in the HTML text to avoid a
    // bug in current Mozilla betas (0.9.4 at the time of writing)
    screenObj.oncontextmenu = EventCancel
    screenObj.ondragstart = EventCancel
    document.ondragstart = EventCancel

    document.onkeydown = EventKeyDown;
    document.onkeypress = EventKeyPress;

    document.onstop = null
    if (parent)
        parent.document.onstop = null;
    window.onunload = UnLoad;
    window.onbeforeunload = BeforeUnload;
    window.onfocus = OnFocus;

    curH = getObjHeight("cursor");
    curW = getObjWidth("cursor");
    shiftTo("cursor", scrW - curW, scrH - curH);

    var StartScreenSaved = StartScreen;
    StartScreen = "";
    HandleResize();
    StartScreen = StartScreenSaved;
    if (!restart) {
        binterf = new JSBubbleInterface("bubb01");
    };

    binterf.SetEnableCloseButton(param_windowed ? 2 : 1);

    if (playMode == "T") {
        binterf.SetMode(R_mode_tryit);
        binterf.SetActionText(R_interface_action);
        binterf.SetMoveable(false);
    };
    if (playMode == "S") {
        binterf.SetMode(R_mode_seeit);
        //		binterf.SetActionText(R_interface_pause,true);
        if (!tutorialMode && param_windowed == false)
            binterf.SetActionText(R_interface_action);
        binterf.SetMoveable(false);
    };
    if (playMode == "K") {

        binterf.SetMode(R_mode_knowit);
        binterf.SetActionText(R_interface_action);
        binterf.SetPosition(-1, -1, -1, -1, true, 0, 0, 0);
        binterf.SetMoveable(true);
    };

    ShowScreen(StartScreen, StartAction)
    try {
        window.focus()
    }
    catch (e) { };
    if (!restart && !Disable_Tutorial) {
        //if (playMode=="T" || playMode=="K" || (playMode=="S" && !tutorialMode))
        //setTimeout('RunTutorialDialog(playMode,0,"../../");',1000);
        //			RunTutorialDialog(playMode,0,"../../");
    }
    //binterf.Show();
    //binterf.Create();

}

function SetSound(value) {
    soundIsExported = value;
};

function SetKScore(score) {
    KScoreNeeded = score;
};

function str_to_bool(s) {
    return (s == "true" ? true : false);
}

function SetStrInputVariables(knowit_validation, tryit_validation, autoadvance, lostfocus_autoadvance) {
    KnowIt_Validated_StringInput = knowit_validation;
    TryIt_Validated_StringInput = tryit_validation;
    StringInput_Autoadvance_Enabled = autoadvance;
    StringInput_LostFocus_Autoadvance_Enabled = lostfocus_autoadvance;
}

function SetParamCtx(s) {
    param_ctx = s;
};

function HexaToDec(hexa) {
    if (hexa.length == 0)
        return "";
    try {
        return hexa.substr(0, 1) + parseInt("0x" + hexa.substr(1));
    }
    catch (e) {
        return "";
    }
}

function ecidStr(s) {
    return replaceString("%27", "'", s);
}

function ParseArguments() {
    var strArgs;
    var strArg;

    // Call parameters can be seperated from the URL by either a "?"
    // or a "#" character...

    var ss = document.location.hash.substring(1);
    strArgs = ss.split("&");
    if (strArgs.length == 0 || strArgs[0] == "") {
        ss = document.location.search.substring(1);
        strArgs = ss.split("&");
    };

    if (strArgs.length == 1) {
        if (strArgs[0].toLowerCase().substr(0, 3) == "su=") {
            var s = Gkod.Escape.SafeUriUnEscape(strArgs[0].substr(3));
            strArgs = s.split("&");
        }
    }

    for (var i = 0; i < strArgs.length; i++) {
        strArg = (strArgs[i]);

        if (strArg.substr(0, 5).toLowerCase() == "mode=") {
            playMode = strArg.substr(5, 1);
        }
        if (strArg.substr(0, 9).toLowerCase() == "framehex=") {
            param_frame = HexaToDec(strArg.substr(9));
        }
        if (strArg.substr(0, 6).toLowerCase() == "frame=") {
            param_frame = strArg.substr(6);
        }
        if (strArg.substr(0, 4).toLowerCase() == "ctx=") {
            param_ctx = strArg.substr(4);
        }
        if (strArg.substr(0, 6).toLowerCase() == "ctxex=") {
            param_ecid = ecidStr(strArg.substr(6));
        }
        if (strArg.substr(0, 10).toLowerCase() == "fatplayer=") {
            fatPlayer = strArg.substr(10);
        }
        if (strArg.substr(0, 10).toLowerCase() == "tutorial=1") {
            tutorialMode = true;
        }
        if (strArg.substr(0, 8).toLowerCase() == "leadin=1") {
            showLeadIn = 1;
        }
        if (strArg.substr(0, 8).toLowerCase() == "leadin=0") {
            showLeadIn = 0;
        }
        if (strArg.substr(0, 12).toLowerCase() == "printitname=") {
            param_printitname = strArg.substr(12);
        }
        if (strArg.substr(0, 8).toLowerCase() == "windowed") {
            param_windowed = true;
        }
        //JZ - Start
        //parse the specmode parameter
        if (strArg.substr(0, 9).toLowerCase() == "specmode=") {
            var thevalue = strArg.substr(9);
            if (thevalue == "Y")
                SpecMode = thevalue;
        }
        //JZ - End				

    }
    if (playMode == "K") {
        trackArgList = strArgs;
        trackOnBegin();
    };
    if (fatPlayer == "FS" || fatPlayer == "WEB") {
        if (param_ctx == "1") {
            FatPlayerCommand("GETPARAMCTX");
        };
    };
    if (SpecMode == "Y")
        Disable_Tutorial = true;
}

var clicknum = 1

function SoundToggle() {
    clicknum = clicknum + 1
    if (Math.floor(clicknum / 2) == clicknum / 2) {
        document.imgS.src = "sound_isoff.gif";
    }
    else {
        document.imgS.src = "sound_ison.gif";
    }
}

function imgOn(imgName) {
    if (document.images) {
        var img = (document.layers ? document.layers.tpanel.document[imgName] : document[imgName])

        if (!imgEnabled[imgName])
            img.src = eval(imgName + "dis.src")
        else
            img.src = eval(imgName + "on.src");
    }
}

function imgOff(imgName) {
    if (document.images) {
        var img = (document.layers ? document.layers.tpanel.document[imgName] : document[imgName])

        if (!imgEnabled[imgName])
            img.src = eval(imgName + "dis.src")
        else
            img.src = eval(imgName + "off.src");
    }
}

function imgEnableDisable(imgName, state) {
    imgEnabled[imgName] = state
    imgOff(imgName)
}

function OpenDialog(URL) {
    day = new Date();
    id = day.getTime();
    eval("page" + id + " = window.open(MakeAbsolute(URL), '" + id + "', 'toolbar=1,scrollbars=0,location=0,statusbar=0,menubar=0,resizable=0,width=506,height=338,left = 147,top = 131');");
}

function PauseToggle() {
    isPaused = !isPaused;
    if (isPaused) {
        binterf.SetPRText(R_interface_resume);
        binterf.StartBlink();
        PlayPause();
    }
    else {
        binterf.EndBlink();
        binterf.SetPRText(R_interface_pause);
        PlayResume();
    }
    if (parent.setPauseStatus)
        parent.setPauseStatus(isPaused);
}

function SeeItPause() {
    if (playMode == "S" && !isPaused)
        PauseToggle();
}

function SeeItResume() {
    if (playMode == "S" && isPaused)
        PauseToggle();
}

function IsPaused() {
    return isPaused;
}

function SetScrollbars() {
    var div = getDIV("screen");
    var w = div.offsetWidth;
    //	var ww=window.screen.width;
    var ww = document.body.clientWidth + 2;
    var h = div.offsetHeight;
    //	var hh=window.screen.height;
    var hh = document.body.clientHeight;
    if (w > ww || h > hh) {
        document.body.scroll = "auto";
    };
};

function SetTemplateRootPath(s) {
    if (!s) {
        SetTemplateSet();
    }
};

function SetTemplateSet(s) {
};

function SetScreenshotPath(s) {
    if (!s)
        s = "";
    if (s == "")
        screenshotPath = MakeAbsolute("")
    else
        screenshotPath = s;
    if (s != "")
        SoundPlayerObj.SetSoundPath(s);
};

function DisableTutorial() {
    Disable_Tutorial = true;
}

function SetRemediationLevels(level1, level2, level3) {
    KRemediation1 = level1;
    KRemediation2 = level2;
    KRemediation3 = level3;
}

function SetModuleName(s) {
    // modulname comes from outline.js!!!
};

function SetTopicName(s) {
    if (!s)
        s = "";
    if (s.length > 0)
        topicName = unescape(s);
    if (param_windowed == true) {
        if (parent.SetTopicName)
            parent.SetTopicName(topicName);
    }
}

function SetTopicShowBubbles(s) {
    topicShowBubbles = s;
}

/*function replaceString(oldS,newS,fullS) {
// Replaces oldS with newS in the string fullS
for (var i=0; i<fullS.length; i++) {
if (fullS.substring(i,i+oldS.length) == oldS) {
fullS = fullS.substring(0,i)+newS+fullS.substring(i+oldS.length,fullS.length)
}
}
return fullS
}*/
function replaceString(oldString, newString, fullS) {
    if (fullS == null) return;
    var cReg = new RegExp(oldString, "g");
    var nString = fullS.replace(cReg, newString);
    return nString;
}

function fixHTMLString(strHTMLString) {
    strHTMLString = replaceString("<", "&lt;", strHTMLString);
    strHTMLString = replaceString(">", "&gt;", strHTMLString);
    strHTMLString = replaceString("'", "&#39;", strHTMLString);
    strHTMLString = replaceString('"', "&#34;", strHTMLString);

    return strHTMLString;
}

function DecodeInputString(s) {
    s = replaceString("&lt;", "<", s);
    s = replaceString("&amp;", "&", s);
    return s;
}

//
// Initialization and preloads
//

ParseArguments()

//
// Mode-specific styles
//

document.writeln("<STYLE>")
if (playMode == "S") {
    document.writeln("A.textLink {text-decoration:none; color:black}")
    document.writeln(".infoblocks {display:none}")
}
else {
    document.writeln("A.textLink {color:#0033cc}")
}
document.writeln("</STYLE>")

//
// Force reload when Netscape 4 resizes window
//

if (NS4) {
    var loadWidth = window.innerWidth
    var loadHeight = window.innerHeight
}



var __myLogWnd = null;

function MYLOGOpen() {
    if (__myLogWnd == null)
        __myLogWnd = window.open();
}

function MYLOG(o) {
    MYLOGOpen();
    __myLogWnd.document.write("<hr/>");
    __myLogWnd.document.write(o + "<br/><br/>");
    for (var name in o) {
        __myLogWnd.document.write(name + ": " + o[name] + "<br/>");
    }
    __myLogWnd.document.write("<hr/>");
}

function MYLOGSimple(s) {
    MYLOGOpen();
    __myLogWnd.document.write(s + "<br/>");
}
