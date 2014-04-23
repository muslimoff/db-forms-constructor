/*--
Copyright © 1998, 2009, Oracle and/or its affiliates.  All rights reserved.
--*/

var lastExpressionF = "";
var lastExpressionH = "";

var viewApplicable = false;
var viewSearch = false;
var selectorMode = "A";
var actuallySelected;

var playerwindow;

// ODS variables
var toc_safeUriMode = false;
var tutorialMode = false;
var playMode = "P";
var odsTopicID;

var _goToFlatMode = false;
var _lastSearchResultIsEmpty = false;

function InitRoles(roleexpression) {
    if (roleexpression == "NOROLES") {
        setTimeout("Init1();", 10);
        return;
    }
    QueryParser.Parse("URI", roleexpression);
    if (QueryParser.ev) {
        QueryProcessor.Start(QueryParser.ev, Init0);
    }
}

function SetRoles(roleexpression) {
    SearchProcess_Show(true);

    o = this.frames["mytreeframe"];
    o.modeDescA.treeCreated = false;
    o.modeDescF.treeCreated = false;
    o.modeDescH.treeCreated = false;
    o.modeDescFH.treeCreated = false;

    if (roleexpression != "NOROLES") {
        QueryParser.Parse("URI", roleexpression);
        if (QueryParser.ev) {
            QueryProcessor.Start(QueryParser.ev, result_Roles_Search);
        }
    }
    else {
        o.SetTopicList("NOROLES", null, "parent.result_Search2");
    }
}

function Trim(s) {
    if (s.length == 0)
        return "";
    while (s.substr(0, 1) == " ") {
        s = s.substr(1);
        if (s.length == 0)
            return "";
    }
    while (s.substr(s.length - 1, 1) == " ") {
        s = s.substr(0, s.length - 1);
    }
    return s;
}

function IsFilteredChar(s) {
    var filters = ".,;:!?(){}[]\\\'\"";
    for (var i = 0; i < filters.length; i++) {
        if (s == filters.substr(i, 1))
            return " ";
    }
    return s;
}

function SearchStringFilter(s) {
    var sret = "";
    for (var i = 0; i < s.length; i++) {
        sret += IsFilteredChar(s.substr(i, 1));
    }
    return sret;
}

function Select(k) {
    SearchProcess_Show(true);
    if (k == 0)		// All view
    {
        if (viewApplicable && viewSearch) {
            selectorMode = "FH";
            setTimeout("ShowFilteredHemi()", 5);
        }
        else if (viewApplicable) {
            selectorMode = "H";
            setTimeout("ShowHemi()", 5);
        }
        else if (viewSearch) {
            selectorMode = "F";
            setTimeout("ShowFiltered()", 5);
        }
        else {
            selectorMode = "A";
            setTimeout("ShowAll()", 5);
        }
    }
    else if (k == 1)	// Filtered view
    {
        o = this.frames["mytreeframe"];
        o._lastChangeIsFilterOnly = false;
        var sb = getObjectById("searchbox");
        var stext = sb.value;
        stext = Trim(SearchStringFilter(stext));
        sb.value = stext;
        if (stext.length == 0) {
            SearchProcess_Show(false);
            return;
        }
        ks = stext.indexOf("\'");
        if (ks >= 0) {
            SearchProcess_Show(false);
            return;
        }
        selectorMode = "F";
        if (lastExpressionF != stext) {
            o.modeDescF.treeCreated = false;
            o.modeDescFH.treeCreated = false;
            lastExpressionF = stext;
            datasourceroot = "/querydb/";
            QueryParser.Parse("EXPR", stext);
            if (QueryParser.ev) {
                QueryProcessor.Start(QueryParser.ev, result_Search);
            }
        }
        else {
            if (viewApplicable)
                setTimeout("ShowFilteredHemi()", 5);
            else
                setTimeout("ShowFiltered()", 5);
        }
        return;
    }
    else if (k == 2)	// Hemi view
    {
        o = this.frames["mytreeframe"];
        var stext = hemiParam;
        if (stext.length == 0) {
            SearchProcess_Show(false);
            return;
        }
        selectorMode = "H";
        if (lastExpressionH != stext) {
            o.modeDescH.treeCreated = false;
            o.modeDescFH.treeCreated = false;
            lastExpressionH = stext;
            ss = 'e' + stext;
            datasourceroot = "/querydb/";
            QueryParser.Parse("URI", ss);
            if (QueryParser.ev) {
                QueryProcessor.Start(QueryParser.ev, result_Search);
            }
        }
        else {
            if (viewApplicable)
                setTimeout("ShowFilteredHemi()", 5);
            else
                setTimeout("ShowHemi()", 5);
        }
        return;
    }
    else if (k == 3)	//Filtered Hemi view part 1
    {
        o = this.frames["mytreeframe"];
        var sb = getObjectById("searchbox");
        var stext = Trim(sb.value);
        stext = SearchStringFilter(stext);
        o.modeDescF.treeCreated = false;
        lastExpressionF = stext;
        selectorMode = "FH1";
        datasourceroot = "/querydb/";
        QueryParser.Parse("EXPR", stext);
        if (QueryParser.ev) {
            QueryProcessor.Start(QueryParser.ev, result_Search);
        }
        return;
    }
    else if (k == 4)	// Filtered Hemi view part 2
    {
        o = this.frames["mytreeframe"];
        var stext = hemiParam;
        o.modeDescH.treeCreated = false;
        lastExpressionH = stext;
        ss = 'e' + stext;
        selectorMode = "FH2";
        datasourceroot = "/querydb/";
        QueryParser.Parse("URI", ss);
        if (QueryParser.ev) {
            QueryProcessor.Start(QueryParser.ev, result_Search);
        }
        return;
    }
    else if (k == 5)	// generic mode
    {
        selectorMode = "H";
        onTocLoaded = true;
    }
}

function result_Search2() {
    if (selectorMode == "F") {
        if (viewApplicable)
            setTimeout("ShowFilteredHemi()", 5);
        else
            setTimeout("ShowFiltered()", 5);
    }
    else if (selectorMode == "H") {
        if (viewSearch)
            setTimeout("ShowFilteredHemi()", 5);
        else
            setTimeout("ShowHemi()", 5);
    }
    else if (selectorMode == "FH1") {
        setTimeout("Select(4)", 5);
    }
    else if (selectorMode == "FH2" || selectorMode == "FH") {
        setTimeout("ShowFilteredHemi()", 5);
    }
    else {
        setTimeout("ShowAll()", 5);
    }
}

function result_Roles_Search(topiclist) {
    o = window.frames["mytreeframe"];       /////
    o.SetTopicList("ROLES", topiclist, "parent.result_Search2");
}

function result_Search(topiclist) {
    _lastSearchResultIsEmpty = (topiclist.length == 0);
    if (genericMode_SearchHemi == true) {
        ShowGenToc2(topiclist);
        return;
    }
    o = window.frames["mytreeframe"];   /////
    if (selectorMode == "F") {
        o.SetTopicList("FILTERED", topiclist, "parent.result_Search2");
    }
    else if (selectorMode == "H") {
        o.SetTopicList("HEMI", topiclist, "parent.result_Search2");
    }
    else if (selectorMode == "FH1") {
        o.SetTopicList("FILTERED", topiclist, "parent.result_Search2");
    }
    else if (selectorMode == "FH2") {
        o.SetTopicList("HEMI", topiclist, "parent.result_Search2");
    }
}

function ShowAll() {
    o = this.frames["mytreeframe"];
    if (!o)
        return;
    dA = o.document.getElementById("treeControlHostForAll");
    dS = o.document.getElementById("treeControlHostForFiltered");
    dSf = o.document.getElementById("flatControlHostForFiltered");
    dH = o.document.getElementById("treeControlHostForHemi");
    dHf = o.document.getElementById("flatControlHostForHemi");
    dFH = o.document.getElementById("treeControlHostForFilteredHemi");
    dFHf = o.document.getElementById("flatControlHostForFilteredHemi");
    dA.style.display = "block";
    dS.style.display = "none";
    dSf.style.display = "none";
    dH.style.display = "none";
    dHf.style.display = "none";
    dFH.style.display = "none";
    dFHf.style.display = "none";
    o.treeViewMode = "ALL";
    o.createTreeControl(o.titles[0], false);
    SearchResult_Show(false);
}

function ShowFiltered() {
    o = this.frames["mytreeframe"];
    if (!o)
        return;
    dA = o.document.getElementById("treeControlHostForAll");
    dS = o.document.getElementById("treeControlHostForFiltered");
    dSf = o.document.getElementById("flatControlHostForFiltered");
    dH = o.document.getElementById("treeControlHostForHemi");
    dHf = o.document.getElementById("flatControlHostForHemi");
    dFH = o.document.getElementById("treeControlHostForFilteredHemi");
    dFHf = o.document.getElementById("flatControlHostForFilteredHemi");
    // hide other divs
    dA.style.display = "none";
    dH.style.display = "none";
    dHf.style.display = "none";
    dFH.style.display = "none";
    dFHf.style.display = "none";
    // determine view
    var _fm = o.GetActualFlatView();
    if (_goToFlatMode == true)
        _fm = true;
    // set filtered view
    dS.style.display = (_fm ? "none" : "block");
    dSf.style.display = (_fm ? "block" : "none");

    _goToFlatMode = false;
    o.treeViewMode = "FILTERED";
    o.createTreeControl(o.titles[0], _fm);
    SearchResult_Show(true);
    document.getElementById("resulttext").innerHTML = filterHTML(lastExpressionF);
}

function filterHTML(s) {
    s = replaceString("&", "&amp;", s);
    s = replaceString("<", "&lt;", s);
    s = replaceString(">", "&gt;", s);
    return s;
}

function ShowHemi() {
    o = this.frames["mytreeframe"];
    if (!o)
        return;
    dA = o.document.getElementById("treeControlHostForAll");
    dS = o.document.getElementById("treeControlHostForFiltered");
    dSf = o.document.getElementById("flatControlHostForFiltered");
    dH = o.document.getElementById("treeControlHostForHemi");
    dHf = o.document.getElementById("flatControlHostForHemi");
    dFH = o.document.getElementById("treeControlHostForFilteredHemi");
    dFHf = o.document.getElementById("flatControlHostForFilteredHemi");
    // hide other divs
    dA.style.display = "none";
    dS.style.display = "none";
    dSf.style.display = "none";
    dFH.style.display = "none";
    dFHf.style.display = "none";
    // determine view
    var _fm = o.GetActualFlatView();
    if (_goToFlatMode == true)
        _fm = true;
    // set hemi view
    dH.style.display = (_fm ? "none" : "block");
    dHf.style.display = (_fm ? "block" : "none");
    _goToFlatMode = false;
    o.treeViewMode = "HEMI";
    o.createTreeControl(o.titles[0], _fm);
    SearchResult_Show(false);
}

function ShowFilteredHemi() {
    o = this.frames["mytreeframe"];
    if (!o)
        return;
    dA = o.document.getElementById("treeControlHostForAll");
    dS = o.document.getElementById("treeControlHostForFiltered");
    dSf = o.document.getElementById("flatControlHostForFiltered");
    dH = o.document.getElementById("treeControlHostForHemi");
    dHf = o.document.getElementById("flatControlHostForHemi");
    dFH = o.document.getElementById("treeControlHostForFilteredHemi");
    dFHf = o.document.getElementById("flatControlHostForFilteredHemi");

    // hide other divs
    dA.style.display = "none";
    dS.style.display = "none";
    dSf.style.display = "none";
    dH.style.display = "none";
    dHf.style.display = "none";
    // determine view
    var _fm = o.GetActualFlatView();
    if (_goToFlatMode == true)
        _fm = true;
    // set filtered hemi view
    dFH.style.display = (_fm ? "none" : "block");
    dFHf.style.display = (_fm ? "block" : "none");
    _goToFlatMode = false;
    o.treeViewMode = "FILTEREDHEMI";
    _goToFlatMode = false;
    o.createTreeControl(o.titles[0], _fm);
    SearchResult_Show(true);
    document.getElementById("resulttext").innerHTML = filterHTML(lastExpressionF);
}

function EmptyContent() {
    return '<div style="text-align: center; color: red;">' + R_toc_emptycontent + "</div>";
}

function FastDoIt() {
    p = topicDescriptorCache[actuallySelected];
    if (p.playmodes.indexOf("D") >= 0) {
        HideToc();
        PlayTopic("D");
    }
    bypassToc = false;
}

function TreeFinished(mode, isEmpty) {
    SetSelectionViewText();

    var FDI_called = false;
    if (bypassToc == true) {
        ooo = this.frames["mytreeframe"];
        if (ooo.treeViewMode == "HEMI") {
            if (ooo.GetActualFlatView() == true) {
                if (ooo.GetActualFlatItemCounter() == 1) {
                    FDI_called = true;
                    setTimeout("FastDoIt()", 100);
                }
            }
        }
    }
    if (FDI_called == false)
        bypassToc = false;

    if (!isEmpty) {
        //    	SetSelectionViewText(true);
        EnableSelectionViewText(true);
        return;
    }
    var d;
    dA = o.document.getElementById("treeControlHostForAll");
    dS = o.document.getElementById("treeControlHostForFiltered");
    dSf = o.document.getElementById("flatControlHostForFiltered");
    dH = o.document.getElementById("treeControlHostForHemi");
    dHf = o.document.getElementById("flatControlHostForHemi");
    dFH = o.document.getElementById("treeControlHostForFilteredHemi");
    dFHf = o.document.getElementById("flatControlHostForFilteredHemi");
    if (mode == "ALL") {
        dA.innerHTML = EmptyContent();
    }
    else if (mode == "FILTERED") {
        dS.innerHTML = EmptyContent();
        dSf.innerHTML = EmptyContent();
    }
    else if (mode == "HEMI") {
        dH.innerHTML = EmptyContent();
        dHf.innerHTML = EmptyContent();
    }
    else if (mode == "FILTEREDHEMI") {
        dFH.innerHTML = EmptyContent();
        dFHf.innerHTML = EmptyContent();
    }
    EnableSelectionViewText(false);

    //	SetSelectionViewText(true,true);
    Refresh(null);
}

var _tocHidden = false;

function HideToc() {
    return;
    _tocHidden = true;
    window.moveBy(-2000, 0);
}

function ResumeToc() {
    return;
    if (_tocHidden == true) {
        window.moveBy(2000, 0);
    }
    _tocHidden = false;
}

function DoItFinished(closeToc) {
    window.focus();
    ResumeToc();
    if (closeToc == true) {
        opener = null;
        window.open('', '_self');
        window.close();
    }
}

var topicDescriptorCache = new Array();

function topicDescriptorObj(title, type, tpc, playmodes, jumpInArray, leadin, concept, printitname) {
    this.title = title;
    this.type = type;
    this.tpc = tpc;
    this.playmodes = playmodes;
    this.jumpInArray = jumpInArray;
    this.leadin = leadin;
    this.concept = concept;
    this.printitname = encodeURIComponent(printitname);
}

function JumpInPoint(label, frameid) {
    this.label = label;
    this.frame_id = frameid;
}

var _playConceptSound = true;

function PlayConceptSound() {
    return _playConceptSound;
}

function TreeItemSelected(tpc, mode) {
    if (tpc == null && mode == null)
        SetSelectionViewText(null, true);
    else
        SetSelectionViewText();

    EnableSelectionViewText(!_lastSearchResultIsEmpty);
    if (mode == "HIDE") {
        SearchProcess_Show(false);
        return;
    }
    FocusToSearchField();
    if (tpc == null) {
        //    	SetSelectionViewText(true,true);
        Refresh(null);
        return;
    }
    guid = tpc.substr(0, 36);
    actuallySelected = guid;
    _playConceptSound = true;
    if (topicDescriptorCache[guid]) {
        Refresh(guid);
    }
    else {
        var s = "tpc/" + guid + "/descriptor.xml";
        LoadXMLDoc(s, "TreeItemSelected_Returned_Descriptor", "", guid);
    }
}

function TreeItemDoubleSelected() {
    tdc = topicDescriptorCache[actuallySelected];

    try {
        var t = tdc.type;
    }
    catch (e) {
        setTimeout("TreeItemDoubleSelected()", 100);
        return;
    }

    if (tdc.type == "Topic") {
        UserPrefs.LoadCookie();
        mode = UserPrefs.DefaultPlayMode;
        _playConceptSound = false;
        if (tdc.playmodes.indexOf(mode) >= 0) {
            PlayTopic(mode);
        }
        else {
            modestr = R_mode_seeit;
            switch (mode) {
                case "T":
                    modestr = R_mode_tryit;
                    break;
                case "K":
                    modestr = R_mode_knowit;
                    break;
                case "D":
                    modestr = R_mode_doit;
                    break;
                case "P":
                    modestr = R_mode_printit;
                    break;
                default:
                    modestr = R_mode_seeit;
                    break;
            }
            alert(R_not_playable1 + modestr + R_not_playable2);
        }
    }
}

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

function TreeItemSelected_Returned_Descriptor(req, id) {
    var playmodes = "";
    nodes = req.responseXML.getElementsByTagName("PlayModes");
    if (nodes.length > 0) {
        n = nodes[0];
        if (n.textContent != null)
            playmodes = n.textContent;
        else if (n.text != null)
            playmodes = n.text;
        else if (n.firstChild.data != null)
            playmodes = n.firstChild.data;
    }
    jumpInArray = new Array();
    nodes = req.responseXML.getElementsByTagName("JumpIn");
    for (var i = 0; i < nodes.length; i++) {
        n = nodes[i];
        if (n.textContent)
            label = n.textContent;
        else if (n.text)
            label = n.text;
        else if (n.firstChild.data)
            label = n.firstChild.data;
        a = n.attributes[0];
        frameid = a.nodeValue;
        jumpInArray[jumpInArray.length] = new JumpInPoint(fixHTMLString(label), frameid);
    }
    _leadIn = "./toc/empty.html";
    nodes = req.responseXML.getElementsByTagName("Leadin");
    if (nodes.length > 0) {
        _leadIn = "./tpc/" + id + "/leadin.html";
    }
    _concept = "";
    nodes = req.responseXML.getElementsByTagName("Concept");
    if (nodes.length > 0) {
        n = nodes[0];
        if (n.textContent)
            _concept = n.textContent;
        else if (n.text)
            _concept = n.text;
        else if (n.firstChild.data)
            _concept = n.firstChild.data;
    }
    _title = "";
    nodes = req.responseXML.getElementsByTagName("Title");
    if (nodes.length > 0) {
        n = nodes[0];
        if (n.textContent)
            _title = n.textContent;
        else if (n.text)
            _title = n.text;
        else if (n.firstChild.data)
            _title = n.firstChild.data;
    }
    _type = "";
    nodes = req.responseXML.getElementsByTagName("Type");
    if (nodes.length > 0) {
        n = nodes[0];
        if (n.textContent)
            _type = n.textContent;
        else if (n.text)
            _type = n.text;
        else if (n.firstChild.data)
            _type = n.firstChild.data;
    }
    _printitname = "";
    nodes = req.responseXML.getElementsByTagName("PrintItName");
    if (nodes.length > 0) {
        n = nodes[0];
        if (n.textContent)
            _printitname = n.textContent;
        else if (n.text)
            _printitname = n.text;
        else if (n.firstChild.data)
            _printitname = n.firstChild.data;
    }

    topicDescriptorCache[id] = new topicDescriptorObj(_title, _type, id, playmodes, jumpInArray, _leadIn, _concept, _printitname);
    Refresh(id);
}

var lastConcept = "";

var rcTimeout = null;

var nextConcept = "";

function EmptyHtmlLoaded() {
    this.frames["myconceptframe"].location.replace(nextConcept);
}

function SetConceptLocation(s) {
    nextConcept = AbsUrl(s);
    this.frames["myconceptframe"].location.replace(AbsUrl("./toc/empty.html?callback"));
}

function _RefreshConcept(noplaysound) {
    if (!noplaysound)
        noplaysound == false;
    if (lastConcept != "") {
        if (lastConcept.indexOf(".htm") > 0) {
            if (noplaysound == true)
                _playConceptSound = false;
            SetConceptLocation(lastConcept);
        }
    }
}

function RefreshConcept() {
    try {
        clearTimeout(rcTimeout);
    }
    catch (e) {
    }
    //    rcTimeout = setTimeout("_RefreshConcept();", 300);
}

function OnUpdatePreferences() {
    _RefreshConcept(true);
}

var psInit = null;

function PlaySound_Init() {
    try {
        this.frames["myconceptframe"].PlaySound_Init();
    }
    catch (e) {};
}

function ShowConcept(s) {
    if (s == lastConcept) {
        try {
            if (_playConceptSound == true)
                psInit = setTimeout("PlaySound_Init()", 500);
            else
                clearTimeout(psInit);
        }
        catch (e) { };
        return;
    }
    lastConcept = s;
    SetConceptLocation(s);
}

function Refresh(id) {
    SearchProcess_Show(false);
    ptable = getObjectById("playmodetable");
    cttable = getObjectById("concepttitletable");
    ctsep = getObjectById("conceptseparator");
    if (_conceptContainerObj == null)
        _conceptContainerObj = getObjectById("conceptcontainer");
    _conceptContainerObj.style.height = "0px";
    if (id == null) {
        setTimeout('ShowConcept("./toc/empty.html")', 1);
        ptable.style.display = "none";
        ctsep.style.display = "none";
        cttable.className = "cttablehide";
        pModesVisible = false;
        conceptVisible = false;
        Resize();
        return;
    }
    desc = topicDescriptorCache[id];
    concept = desc.concept;
    if (concept.length == 0)
        concept = desc.leadin;

    setTimeout('ShowConcept("' + concept + '")', 50);
    //	this.frames["myconceptframe"].location.href=AbsUrl(concept);
    conceptVisible = true;
    //	document.getElementById("concepttitle").innerHTML=desc.title;
    ptable = getObjectById("playmodetable");
    if (desc.playmodes.length == 0) {
        cttable.className = "cttablehide";
        ptable.style.display = "none";
        ctsep.style.display = "none";
        pModesVisible = false;
    }
    else {
        cttable.className = "cttableshow";
        ptable.style.display = "block";
        ctsep.style.display = "block";
        pModesVisible = true;
        showButtons[0] = false;
        showButtons[1] = desc.playmodes.indexOf('S') >= 0;
        showButtons[2] = desc.playmodes.indexOf('T') >= 0;
        showButtons[3] = desc.playmodes.indexOf('K') >= 0;
        showButtons[4] = false;
        //        if (document.all && !IsFF3()) {
        showButtons[4] = desc.playmodes.indexOf('D') >= 0;
        //        }

        showButtons[5] = false;
        showButtons[6] = false;

        if (desc.playmodes.indexOf('P') >= 0) {
            if (desc.printitname.length > 0) {
                k = desc.printitname.lastIndexOf('.');
                var ext = desc.printitname.substr(k + 1);
                if (ext == "pdf") {
                    showButtons[5] = true;
                }
                else {
                    showButtons[6] = true;
                }
            }
        }

    }
    RolesRemoved();

    Resize();
}

function Jumpin(mode) {
    var s = "";
    s += "<span class='textWindows'>" + R_jumpin_header + "</span>";
    s += "<br><br><ul><li>";
    s += "<a class='textWindows' href='javascript:PlayTopic(\"" + mode + "\")'>" + R_jumpin_beginning + "</a>";
    s += "</li>"
    var jpA = topicDescriptorCache[actuallySelected].jumpInArray;
    for (var i = 0; i < jpA.length; i++) {
        s += "<li>";
        s += "<a class='textWindows' href='javascript:PlayTopic(\"" + mode + "\",\"" + jpA[i].frame_id + "\")'>";
        s += jpA[i].label;
        s += "</a>";
        s += "</li>"
    }
    s += "</ul><br>";
    s += "<a class='textWindows' href='javascript:JumpIn_Show(null,null)'>" + R_certificate_close + "</a><span class='tocFrameText' this window</span>";
    s += "";
    JumpIn_Show(s, mode);
}

function GetBasePath() {
    base = this.location.href;
    k = base.indexOf('?');
    if (k < 0)
        k = base.indexOf('#');
    if (k >= 0)
        base = base.substr(0, k);
    k = base.lastIndexOf('/');
    b = base.substr(0, k);
    return b;
}

function ClosePlayer() {
    try {
        if (playerwindow) {
            if (!playerwindow.closed) {
                playerwindow.close();
            }
        }
    }
    catch (e) { };
}

function PlayTopic(mode, frame) {
    JumpIn_Show(null, null);

    if (this.frames["myconceptframe"].Sound_Stop) {
        this.frames["myconceptframe"].Sound_Stop();
    }
    var run = true;
    if (playerwindow) {
        if (!playerwindow.closed)
            run = false;
    }

    var features = "width=" + screen.width + ",height=" + screen.height + "resizable=0,toolbar=0,scrollbars=1,location=0,statusbar=0,menubar=0,";
    var params = "mode=" + mode;

    if (frame != null) {
        params += "&frame=" + frame;
    }
    if (viewApplicable == true) {
        if (lastExpressionH.length > 0) {
            params += "&ctxex=" + lastExpressionH;
        }
    }
    desc = topicDescriptorCache[actuallySelected];
    var k = desc.playmodes.indexOf("P");
    if (k >= 0 && desc.printitname.length > 0) {
        params += "&printitname=" + desc.printitname;
    }
    if (bypassToc == true) {
        params += "&fastdoit=true";
    }

    if (toc_safeUriMode == true) {
        params = "su=" + Gkod.Escape.SafeUriEscape(params);
    }

    if (run) {
        b = GetBasePath();
        if (mode == "D") {
            LaunchDoIt(b + "/tpc/" + actuallySelected + "/topicgc.html", params);
        }
        else if (mode == "P") {
            odsTopicID = actuallySelected;
            ODSOpenEvGroup();
            window.open("./printit/" + desc.printitname);
            ODSCloseEvGroup();
        }
        else {
            playerwindow = window.open(b + "/tpc/" + actuallySelected + "/topic.html?" + params, "", features + "fullscreen=1");
            setTimeout("playerwindow.moveTo(0, 0);", 100);
        }
    }
    else {
        alert(R_toc_doit_err);
    }
}
