//generic.js

/*--
Copyright © 1998, 2009, Oracle and/or its affiliates.  All rights reserved.
--*/

//<!--Version 9.6.0.22-->

//This file must be loaded into the TOC
Gkod.Trace.Write(Gkod.Trace.ID.LOAD, '[GENERIC] : generic.js is loaded into window.name = [' + window.name + '] URL = [' + window.location.href + ']', 3);
var debug = false;

var testdata = null;
var countsearchdb = false;
var adjusted_maxsearch = 0;

var maxhit = 0;
var maxsearch = 0;
var threshold = 0;
var minscore = 0;
var showtestpage = 0;

//defined in TOC
showscore = 0;

/// <reference path=./stdhemi/hemi/scripts/oddefs.js />

//function LoadScript(obj, src)
//{
//    var s1 = "void(z=document.getElementsByTagName('head')[0].appendChild(document.createElement('script')));";
//    var s2 = "void(z.language='javascript');";
//    var s3 = "void(z.type='text/javascript');";
//    var s4 = "void(z.src='" + src + "');";
//    obj.eval(s1 + s2 + s3 + s4);
//}

//LoadScript(window, script1);
//LoadScript(window, script2);

//oddefs.js is included in toc0.html

var Script =
{
    WriteScripts: function(obj) {
        for (var i = 0; i < this.scripts.length; i++) {
            var newScript = obj.document.createElement('script');
            newScript.type = 'text/javascript';
            newScript.src = this.scripts[i];
            var headID = obj.document.getElementsByTagName("head")[0];
            if (typeof (Gkod.Helper) != 'undefined' && typeof (Gkod.Helper.LoadText) != 'undefined') {
                Gkod.Helper.LoadText(this.scripts[i]);
            }
            else {
                Gkod.Trace.Write(Gkod.Trace.ID.GEN, "[GENERIC] : Script.WriteScript - Gkod.Helper is undefined", 3);
            }
            headID.appendChild(newScript);
        }
    },
    AddScript: function(src) {
        this.scripts.push(src);
    },
    AddFunction: function(src) {
        this.functions.push(src);
    },
    WriteFunctions: function(obj) {
        for (var i = 0; i < this.functions.length; i++) {
            var newScript = obj.document.createElement('script');
            newScript.type = 'text/javascript';
            newScript.text = this.functions[i];
            var headID = obj.document.getElementsByTagName("head")[0];
            headID.appendChild(newScript);
        }
    },
    Reset: function() {
        this.scripts.length = 0;
        this.functions.length = 0;
    },

    scripts: [],
    functions: []
}

//Script.AddFunction('CopyGenericVariablesFromRootNamespace();'); //does not work in IE
//Script.WriteFunctions(window);

function CopyGenericVariablesFromRootNamespace() {
    if (parseInt(Gkod.Variables.maxhit) > -1)
        maxhit = Gkod.Variables.maxhit;
    if (parseInt(Gkod.Variables.maxsearch) > -1)
        maxsearch = Gkod.Variables.maxsearch;
    if (parseInt(Gkod.Variables.threshold) > -1)
        threshold = Gkod.Variables.threshold;
    if (parseInt(Gkod.Variables.minscore) > -1)
        minscore = Gkod.Variables.minscore;
    if (parseInt(Gkod.Variables.showscore) > -1)
        showscore = Gkod.Variables.showscore;
    if (parseInt(Gkod.Variables.showtestpage) > -1)
        showtestpage = Gkod.Variables.showtestpage;
}

var Http =
{
    _workerFunction: "",
    _errorFunction: "",
    _extraInfo: "",
    _req: null,
    _url: "",

    AbsUrl: function(url) {
        for (var i = 0; i < url.length; i++) {
            c = url.substr(i, 1);
            if (c == ':')
                return url;
        }
        base = window.location.href;

        var k1 = base.indexOf('?');
        var k2 = base.indexOf('#');
        if (k1 >= 0 || k2 >= 0) {
            if (k1 >= 0 && k2 >= 0) {
                base = base.substr(0, (k1 < k2 ? k1 : k2));
            }
            else if (k1 >= 0) {
                base = base.substr(0, k1);
            }
            else {
                base = base.substr(0, k2);
            }
        }

        if (url.substr(0, 3) == "../") {
            var k = base.lastIndexOf('/');
            base = base.substr(0, k);
            while (url.substr(0, 3) == "../") {
                k = base.lastIndexOf('/');
                base = base.substr(0, k);
                url = url.substr(3);
            }
            base = base + "/" + url;
        }
        else {
            k = base.lastIndexOf('/');
            base = base.substr(0, k);
            base = base + "/" + url;
        }
        return (base);
    },
    
    IsFileExists: function(url, workerFunction, errorFunction, extraInfo) {
        Http._workerFunction = workerFunction;
        Http._errorFunction = errorFunction;
        Http._extraInfo = extraInfo;
        Http._url = this.AbsUrl(url);
        // code for Mozilla, etc.
        if (window.XMLHttpRequest) {
            Http._req = new XMLHttpRequest();
            Http._req.onreadystatechange = Http.state_Change;
            Http._req.open("HEAD", Http._url, true);
            Http._req.send(null);
        }
        // code for IE
        else if (window.ActiveXObject) {
            Http._req = new ActiveXObject("Microsoft.XMLHTTP");
            if (Http._req) {
                Http._req.onreadystatechange = Http.state_Change;
                Http._req.open("HEAD", Http._url, true);
                Http._req.send();
            }
        }
    },

    state_Change: function() {
        if (Http._req.readyState == 4) {
            if (Http._req.status == 200) {
                eval(Http._workerFunction + "(true)");
            }
            else {
                eval(Http._workerFunction + "(false)");
            }
        }
    },

    _returnFunction: "",
    _nodes: "",
    _nodesArray: [],

    LoadXMLDocArray: function(url, returnFunction, errorFunction, nodeName, xmlmode) {
        Http._returnFunction = returnFunction;
        Http._nodeName = nodeName;
        if (!xmlmode)
            Http.LoadXMLDoc(url, "XMLDocArrayWorker", errorFunction, nodeName);
        else
            Http.LoadXMLDoc(url, "XMLDocArrayWorker2", errorFunction, nodeName);
    },

    XMLDocArrayWorker: function(req, extraInfo) {
        Http._nodesArray = [];
        Http._nodes = req.responseXML.getElementsByTagName(extraInfo);
        for (var i = 0; i < Http._nodes.length; i++) {
            n = Http._nodes[i];
            s = (n.textContent ? n.textContent : n.text);
            if (!s)
                s = "";
            k = s.length;
            if (k >= 2) {
                if ((s.substr(0, 1) == '\"') && (s.substr(k - 1, 1) == '\"')) {
                    ss = s.substr(1, k - 2);
                    s = ss;
                }
            }
            Http._nodesArray[Http._nodesArray.length] = s;
        }
        sfn = Http._returnFunction + "(this._nodesArray)";
        setTimeout(sfn, 1);
    },

    XMLDocArrayWorker2: function(req, extraInfo) {
        Http._nodesArray = [];
        Http._nodes = req.responseXML.getElementsByTagName(extraInfo);
        for (var i = 0; i < Http._nodes.length; i++) {
            n = Http._nodes[i];
            xmlname = n.attributes[0].nodeValue;
            xmltext = "";
            for (var j = 0; j < n.childNodes.length; j++) {
                if (n.childNodes[j].xml) {
                    xmltext += n.childNodes[j].xml;
                } else {
                    var oSerializer = new XMLSerializer;
                    xmltext += oSerializer.serializeToString(n.childNodes[j]);
                }
            }
            Http._nodesArray[Http._nodesArray.length] = xmlname + "=" + xmltext;
        }
        sfn = Http._returnFunction + "(this._nodesArray)";
        setTimeout(sfn, 1);
    }
}

var GenericSearch =
{
    DbRoot: "../../querydb/topicmap/",
    DbSize: 0,
    DbSearchedSize: 0,
    EcidArray: [],
    SearchArray: {}, //speed up search when no testpage
    _EcidArray: function(expr, ctx) {
        this.Expr = expr || "";
        this.Ctx = ctx || null;
        this.List = [];
        this.Hits = 0;
    },
    FramesWithHits: [],
    AppName: "",
    AllTopics: 0,
    TopicsPerFile: 0,
    AllFiles: 0,
    CurrentFile: 0,
    CurrentIndex: 0,
    AllScore: 0,
    HighScore: 0,
    LowScore: 0,
    MinScore: 0,
    FilteredbyMaxHit: [],
    FilteredbyMaxSearch: [],
    //FilteredbyThreshold    : [],
    //FilteredbyMinScore    : [],
    SetAppName: function(app) {
        this.AppName = app;
    },
    TocWin: null,

    _Topic: function(_text) //framelist
    {
        this.index = -1;
        this.text = ""; //expression
        this.guid = ""; //topic guid
        this.name = ""; //topic name
        this.score = 0; //weighted score/
        this.ascore = 0; //absolut score/
        this.hits = 0;
        this.type = ""; //type
        this.frameid = -1;
        this.Process = function() {
            this.SetGuid();
            this.SetName();
        }
        this.SetGuid = function() {
            //a8e995ce-3937-4044-a3f7-f240cf9e4f35_2#ce9New TopicTopic#C1
            var k = this.text.indexOf('_');
            if (k > 0) {
                this.guid = this.text.substr(0, k);
            }
        }
        this.SetName = function() {
            var k = this.text.indexOf('#');
            var rbs = { s: this.text.substr(k + 3), p: 0 }; //a8e995ce-3937-4044-a3f7-f240cf9e4f35_2#ce9New TopicTopic#C1 9!
            var l = ReadBase64_32(rbs);
            var s2 = rbs.s.substr(rbs.p + l);
            this.name = rbs.s.substr(rbs.p, l);
            k = s2.indexOf('#');
            if (k >= 0) {
                this.frameid = parseInt(s2.substr(k + 2));
                s2 = s2.substr(0, k);
            }
            this.type = s2;
        }
        if (typeof _text == "string") {
            this.text = _text;
            this.Process();
        }
    },

    _TopicList: function() {
        this._tmap = [] //_topic
        this.Set = function(topic, index) {
            topic.index = index;
            this._tmap.push(topic);
        }

        this.Sort = function() {
            //Descending
            this._tmap.sort(this._Sort);
        }

        this._Sort = function(a, b) {
            var x = a.score;
            var y = b.score;
            var k = y - x;
            //Ascending
            //return ((x < y) ? -1 : ((x > y) ? 1 : 0));            
            //Descending
            //return ((x > y) ? -1 : ((x < y) ? 1 : 0));
            return k;
        }

        this.GetGuid = function(id) {
            return this._tmap[id].guid;
        }
        this.GetName = function(id) {
            return this._tmap[id].name;
        }
        this.GetFrameid = function(id) {
            return this._tmap[id].frameid;
        }
        this.GetIndex = function(id) {
            return this._tmap[id].index;
        }
        this.GetElementByIndex = function(id) {
            for (var i = 0; i < this._tmap.length; i++) {
                if (this._tmap[i].index == id)
                    return this._tmap[i];
            }
            return null;
        }
    },

    Ctx: [],
    CtxProcessor:
    {
        Counter: 1,
        _type: "",
        _count: 0,
        Hex: function() {
            return this.Counter.toString(16);
        },
        GetFile: function() {
            return "../../querydb/" + this._type + "/" + this.Hex() + ".xml";
        },
        Iterate: function(a) {
            GenericSearch.Ctx[this._type] = GenericSearch.Ctx[this._type].concat(a);
            this.Counter++;
            try {
                Http.IsFileExists(GenericSearch.CtxProcessor.GetFile(), "GenericSearch.CtxProcessor.IterateRet");
            }
            catch (e) {
                alert(e);
            }
        },
        _Iterate: function() {
            LoadXMLDocArray(GenericSearch.CtxProcessor.GetFile(), "GenericSearch.CtxProcessor.Iterate", "", "N");
        },
        IterateRet: function(a) {
            if (a == true)
                setTimeout(this._Iterate, 1);
            else {
                this._count++;
                if (this._count < 2)
                    this.Next("genctx");
                else {
                    //                    for (var i in this.Ctx)
                    //                        Gkod.Trace.Log("GenericSearch:IterateRet - done Ctx[" + i + "] = " + this.Ctx[i].length, 3);

                    setTimeout(GenericSearch.StartXMLProcessor, 1);
                }
            }
        },
        Start: function(type) {
            this._type = "ctxex";
            GenericSearch.Ctx[this._type] = [];
            Http.IsFileExists(GenericSearch.CtxProcessor.GetFile(), "GenericSearch.CtxProcessor.IterateRet");
        },
        Next: function(type) {
            this._type = type;
            GenericSearch.Ctx[this._type] = [];
            Http.IsFileExists(GenericSearch.CtxProcessor.GetFile(), "GenericSearch.CtxProcessor.IterateRet");
        }
    },

    StartXMLProcessor: function() {
        Gkod.Trace.Write(Gkod.Trace.ID.GEN, "[GENERIC] : GenericSearch:StartXMLProcessor - SEARCH is being prepared", 3);
        //What is the number of all topics
        if (showtestpage > 0)
            LoadXMLDoc(GenericSearch.DbRoot + "count.xml", "GenericSearch.TopicsCount", "", "");
        else
            GenericSearch._StartSearch();
    },

    TopicsCount: function(req) {
        Gkod.Trace.Write("GenericSearch:TopicsCount", 3);

        var nodes = req.responseXML.getElementsByTagName("Count");
        if (nodes.length > 0) {
            var n = nodes[0];
            GenericSearch.AllTopics = n.firstChild.data;
            //Gkod.Trace.Write("TopicsCount - AllTopics = " + GenericSearch.AllTopics ,3);
        }
        //What is the division number for splitting files
        LoadXMLDocArray(GenericSearch.DbRoot + "0.xml", "GenericSearch.MaxTopicsPerFile", "", "T");
    },
    MaxTopicsPerFile: function(retarray) {
        //Gkod.Trace.Write("GenericSearch:MaxTopicsPerFile", 3);
        //Gkod.Trace.Write("MaxTopicsPerFile - retarray[0] = " + retarray[0], 3);
        GenericSearch.TopicsPerFile = parseInt(retarray[0]);
        GenericSearch.AllFiles = Math.floor(GenericSearch.AllTopics / GenericSearch.TopicsPerFile) + ((GenericSearch.AllTopics % GenericSearch.TopicsPerFile) == 0 ? 0 : 1);
        Gkod.Trace.Write(Gkod.Trace.ID.GEN, "[GENERIC] : MaxTopicsPerFile - AllFiles = " + GenericSearch.AllFiles + " TopicsPerFile=" + GenericSearch.TopicsPerFile, 3);
        //Iterate through 0.xml, 1.xml, ...
        LoadXMLDocArray(GenericSearch.DbRoot + GenericSearch.CurrentFile + ".xml", "GenericSearch.IterateXMLFiles", "", "T");
    },
    IterateXMLFiles: function(retarray) {
        //Gkod.Trace.Write("GenericSearch:IterateXMLFiles", 3);
        retarray = DecodeTMapArray(retarray);

        if (debug) {
            for (var i = 0; i < retarray.length; i++) {
                Gkod.Trace.Log("IterateXMLFiles - decoded retarray [" + i + "] = " + retarray[i], 3);
            }
        }

        GenericSearch.CurrentFile++;
        //Start from 1
        for (var i = 1; i < retarray.length; i++) {
            var s = retarray[i];
            var k = s.indexOf('/');
            var ss = s;
            while (k >= 0) {
                ss = "" + s.substr(0, k);
                k = s.indexOf('/');
                ss = s.substr(k + 1);
                s = ss;
            }
            var temp = new GenericSearch._Topic(ss);
            var realindex = i + (GenericSearch.TopicsPerFile * (GenericSearch.CurrentFile - 1));
            GenericSearch.TopicList.Set(temp, realindex);
            //Gkod.Trace.Log("IterateXMLFiles - ss = " + ss + " [" + realindex + "]", 3);
        }
        //Gkod.Trace.Write("IterateXMLFiles - AllFiles " + CurrentFile + " GenericSearch.AllFiles " + GenericSearch.CurrentFile, 3);
        if (GenericSearch.AllFiles == GenericSearch.CurrentFile) {
            //Gkod.Trace.Write(Gkod.Trace.ID.GEN, "[GENERIC] : GenericSearch:IterateXMLFiles - SEARCH is beginning", 3);
            GenericSearch._StartSearch();
        }
        else {
            setTimeout(GenericSearch._IterateXMLFiles, 1);
        }
    },
    _IterateXMLFiles: function() {
        //Gkod.Trace.Write("GenericSearch:_IterateXMLFiles [" + GenericSearch.CurrentFile + "]", 3);
        LoadXMLDocArray(GenericSearch.DbRoot + GenericSearch.CurrentFile + ".xml", "GenericSearch.IterateXMLFiles", "", "T");
    },
    _StartSearch: function() {
        //Gkod.Trace.Log("_StartSearch", 3);
        if (this.EcidArray.length > 0) {
            /*GenericSearch.*/StartSearch(GenericSearch.EcidArray[GenericSearch.CurrentIndex].Expr);
        }
        else {
            GenericSearch.SearchDone();
        }
    },
    Search: function(topiclist) {
        Gkod.Trace.Log("Search Expr=" + GenericSearch.EcidArray[GenericSearch.CurrentIndex].Expr + " topiclist.length=" + topiclist.length, 3);
        var _topiclist = [];

        if (topiclist == "") {
            _topiclist.push(0);
        }
        else if (topiclist.length > maxhit) {
            _topiclist.push(-1);
            GenericSearch.EcidArray[GenericSearch.CurrentIndex].Hits = topiclist.length;
            if (showtestpage > 0)
                GenericSearch.FilteredbyMaxHit.push(GenericSearch.EcidArray[GenericSearch.CurrentIndex]);
        }
        else {
            for (var i = 0; i < topiclist.length; i++) {
                _topiclist.push(topiclist[i].index);
            }
        }

        if (debug) {
            Gkod.Trace.Log("Search Expr=" + GenericSearch.EcidArray[GenericSearch.CurrentIndex].Expr + " topiclist.length=" + topiclist.length + " [" + _topiclist.toString() + "]", 3);
        }
        GenericSearch.EcidArray[GenericSearch.CurrentIndex].List = _topiclist;

        GenericSearch.CurrentIndex++;
        if (GenericSearch.CurrentIndex < GenericSearch.EcidArray.length) {
            setTimeout(GenericSearch.IterateSearch, 1);
        }
        else {
            GenericSearch.SearchDone();
        }
    },
    SearchDone: function() {
        if (showtestpage > 0) {
            if (typeof (CDB) != 'undefined' && CDB != null && typeof (CDB.index) != 'undefined')
                GenericSearch.DbSearchedSize = CDB.index.length;
        }
        Gkod.Trace.Write(Gkod.Trace.ID.GEN, "[GENERIC] : GenericSearch:SearchDone() - SEARCH is done", 3);
        /*
        var z1 = {index : 10};
        var z2 = {index : 2};
        var z3 = {index : 3};
        var topiclist = [];
        topiclist.push(z1);
        topiclist.push(z2);
        topiclist.push(z3);
        ShowGenToc(topiclist);
        */

        GenericSearch.GetTopics();
        _window.showscore = showscore;
        _window.ShowGenToc(GenericSearch.GetTopicsList());
        //Gkod.Trace.Log("GenericSearch:SearchDone - ShowGenToc is called", 3);
        if (showtestpage > 0) {
            //var tabbed = (Gkod.GatewayUtility.GetIndexOfMainPlayer() != -1);
            var tabbed = (Gkod.Variables.GATEWAY_EMBED.length > 1); //temporary
            Gkod.Trace.Write(Gkod.Trace.ID.GEN, "[GENERIC] : GenericSearch:SearchDone() - opening test page, tabbed = " + tabbed, 3);
            if (!tabbed) {
                GenericSearch.Utility.TestWindow = window.open("generic/generic.html", "_odgeneric_");
            }
            if (GenericSearch.Utility.TestWindow) {
                GenericSearch.Utility.TestWindow.focus();
            }
            else {
                //Gkod.Trace.Write("GenericSearch:SearchDone - test page window is null", 3);
            }
        }
    },

    IterateSearch: function() {
        GenericSearch._StartSearch();
    },
    GetTopics: function() {
        this.HighScore = 0;
        if (GenericSearch.EcidArray.length == 0)
            return;

        for (var i = 0, n = GenericSearch.EcidArray.length, z; i < n, z = GenericSearch.EcidArray[i]; i++) {
            //Gkod.Trace.Log("GetTopics - i : " + i, 3);
            for (var j = 0; j < z.List.length; j++) {
                var item = z.List[j] - 1;
                //Gkod.Trace.Log("[i]="+i+"GetTopics - item : " + item, 3);
                if (showtestpage > 0) {
                    if (item > 0) {
                        //1-based index
                        GenericSearch.TopicList._tmap[item].score += z.Ctx.weight;
                        GenericSearch.TopicList._tmap[item].hits++;
                    }
                }
                else {
                    if (typeof (GenericSearch.SearchArray[z.List[j]]) != 'undefined')
                        GenericSearch.SearchArray[z.List[j]] += z.Ctx.weight;
                    else
                        GenericSearch.SearchArray[z.List[j]] = z.Ctx.weight;
                }
            }
            if (z.List.length > 0 && z.List[0] >= 0) {
                GenericSearch.AllScore += z.Ctx.weight;
            }
        }

        if (showtestpage > 0) {
            for (var i = 0, n = GenericSearch.TopicList._tmap.length, z; i < n, z = GenericSearch.TopicList._tmap[i]; i++) {
                //Get the array of hits
                if (typeof (z) == "object" && z != null) {
                    if (z.score > 0 && z.frameid != -1) {
                        GenericSearch.FramesWithHits.push(i + 1);
                    }
                }

                //Absolute score
                z.ascore = z.score;
                //Normalized score
                var temp = z.score;
                var norm = temp / GenericSearch.AllScore;
                norm = parseFloat(norm.toFixed(2));
                z.score = parseFloat(norm);
                if (this.HighScore < z.score)
                    this.HighScore = z.score;
                //Gkod.Trace.Log("GetTopics - tmap : " + z.text + " " + z.guid + " " + z.name + " " + z.type + " " + z.frameid + " " + z.score + " " + z.index, 3);
            }
        }
        else {
            for (var i in GenericSearch.SearchArray) {
                //Normalized score
                var z = GenericSearch.SearchArray[i];
                var norm = parseFloat((z / GenericSearch.AllScore).toFixed(2));
                //Gkod.Trace.Log("GenericSearch:GetTopics : ecid = " + i + " score = " + norm + " this.HighScore = " + this.HighScore, 3);
                GenericSearch.SearchArray[i] = norm;
                if (i > 0) {
                    if (this.HighScore < norm)
                        this.HighScore = norm;
                }
                //Gkod.Trace.Log("GenericSearch:GetTopics : i = " + i + " this.HighScore = " + this.HighScore, 3);
            }
        }
    },
    GetTopicsList: function() {
        this.LowScore = parseFloat((this.HighScore * threshold / 100).toFixed(2));
        this.MinScore = parseFloat((this.LowScore <= parseFloat((minscore / 100).toFixed(2))) ? parseFloat((minscore / 100).toFixed(2)) : this.LowScore);

        var _tlist = [];

        if (showtestpage > 0 && GenericSearch.EcidArray.length > 0) {
            for (var i = 0, n = GenericSearch.TopicList._tmap.length, z; i < n, z = GenericSearch.TopicList._tmap[i]; i++) {
                if (z.frameid != -1) //not topic
                {
                    if (z.score > 0) {
                        //Gkod.Trace.Write("GenericSearch:GetTopicsList - z.score="+z.score + " this.MinScore="+this.MinScore + " this.LowScore="+this.LowScore + " minscore=" + minscore, 3);
                        if (z.score >= this.MinScore /*&& z.score <= this.HighScore*/) {
                            var k = { index: 0, score: 0 };
                            k.index = z.index;
                            k.score = z.score;
                            _tlist.push(k);
                        }
                    }
                }
            }
        }
        else {
            for (var i in GenericSearch.SearchArray) {
                var z = GenericSearch.SearchArray[i];
                if (i > 0) {
                    if (z >= this.MinScore /*&& z.score <= this.HighScore*/) {
                        var k = { index: 0, score: 0 };
                        k.index = i;
                        k.score = z;
                        _tlist.push(k);
                        //Gkod.Trace.Log("GenericSearch:GetTopicsList : index = " + k.index + " score = " + z, 3);
                    }
                }
            }
        }
        return _tlist;
    },
    CallBack: function() {
        Gkod.Trace.Write(Gkod.Trace.ID.GEN, "[GENERIC] : GenericSearch:CallBack() - TestWindow is " + GenericSearch.Utility.TestWindow, 3);

        if (typeof (GenericSearch.Utility.TestWindow) == 'object') {
            if (showtestpage == 1) {
                this.Table1.Create();

                this.Table2.Create();
                this.Table3.Create();
                this.Table4.Create();
                this.Table5.Create();
            }
            else if (showtestpage == 2) {
                this.TableE.Create();
            }
        }
        else {
            //Gkod.Trace.Log("generic.js - CallBack - GenericSearch.Utility.TestWindow is " + typeof(GenericSearch.Utility.TestWindow), 3);
        }
        GenericSearch.Utility.TestWindow.sorttable.init();
    },
    Table1:
    {
        Heads: ["ECID PARTS", "MAXHIT", "REMOVED BY MAXHIT", "MAXSEARCH", "ECID PARTS SEARCHED", "ECID PARTS DROPPED", "THRESHOLD (%)"/*, "REMOVED BY THRESHOLD"*/, "HIGHEST SCORE", "LOWEST SCORE BY THRESHOLD", "MINSCORE"/*, "REMOVED BY MINSCORE"*/],
        TBody: "",
        TFoot: "",
        CreateHeaders: function() {
            var aHead = [];
            var stCellBegin = "<th>";
            var stCellEnd = "</th>";
            var stRowBegin = "<tr>";
            var stRowEnd = "</tr>";

            if (GenericSearch.DbSize > 0) {
                Heads.push("SEARCHED");
                Heads.push("SEARCH DB SIZE");
            }
            var _t = GenericSearch.Table1.Heads;
            aHead.push(stRowBegin);
            for (var i = 0; i < _t.length; i++) {
                aHead.push(stCellBegin + _t[i] + stCellEnd);
            }
            aHead.push(stRowEnd);

            var stHead = "<thead>" + aHead.join('') + "</thead>";
            GenericSearch.Table1.THead = stHead;
        },
        CreateRows: function() {
            var aBody = [];
            var stCellBegin = "<td>";
            var stCellEnd = "</td>";
            var stRowBegin = "<tr>";
            var stRowEnd = "</tr>";
            var ecidCountUnfiltered = GenericSearch.EcidArray.length + GenericSearch.FilteredbyMaxSearch.length;

            aBody.push(stRowBegin);
            aBody.push(stCellBegin + ecidCountUnfiltered + stCellEnd);
            aBody.push(stCellBegin + maxhit + stCellEnd);
            aBody.push(stCellBegin + GenericSearch.FilteredbyMaxHit.length + stCellEnd);
            aBody.push(stCellBegin + maxsearch + stCellEnd);
            aBody.push(stCellBegin + adjusted_maxsearch + stCellEnd);
            aBody.push(stCellBegin + GenericSearch.FilteredbyMaxSearch.length + stCellEnd);
            aBody.push(stCellBegin + threshold + stCellEnd);
            aBody.push(stCellBegin + GenericSearch.HighScore + stCellEnd);
            aBody.push(stCellBegin + GenericSearch.LowScore + stCellEnd);
            //aBody.push(stCellBegin + GenericSearch.FilteredbyThreshold.length + stCellEnd);            
            //aBody.push(stCellBegin + GenericSearch.FilteredbyMinScore.length + stCellEnd);            
            aBody.push(stCellBegin + (minscore / 100).toFixed(2) + stCellEnd);
            if (GenericSearch.DbSize > 0) {
                aBody.push(stCellBegin + GenericSearch.DbSearchedSize + stCellEnd);
                aBody.push(stCellBegin + GenericSearch.DbSize + stCellEnd);
            }

            aBody.push(stRowEnd);

            var stTable = "<tbody>" + aBody.join('') + "</tbody>";
            GenericSearch.Table1.TBody = stTable;
        },
        Create: function() {
            this.CreateHeaders();
            this.CreateRows();

            //Create table
            var div = GenericSearch.Utility.TestWindow.document.getElementById("opa1");
            div.innerHTML = "<table class=sortable1 border=1>" + GenericSearch.Table1.THead + GenericSearch.Table1.TBody + GenericSearch.Table1.TFoot + "</table>";

            //var div1f = GenericSearch.Utility.TestWindow.document.getElementById("opa1f"); 
            //div1f.innerHTML = "<span>A. MAXSEARCH = adjusted maxsearch</span>";
        }
    },
    Table2:
    {
        THead: "",
        Heads: ["PREFIX", "CAPTION", "VALUE", "WEIGHT"],
        TBody: "",
        Rows: [],
        TFoot: "",
        CreateHeaders: function() {
            var aHead = [];
            var stCellBegin = "<th>";
            var stCellEnd = "</th>";
            var stRowBegin = "<tr>";
            var stRowEnd = "</tr>";

            var _t = GenericSearch.Table2.Heads;
            aHead.push(stRowBegin);
            for (var i = 0; i < _t.length; i++) {
                aHead.push(stCellBegin + _t[i] + stCellEnd);
            }

            var _k = GenericSearch.FramesWithHits;
            for (var j = 0, n = _k.length; j < n; j++) {
                aHead.push(stCellBegin + _k[j] + stCellEnd);
            }

            aHead.push(stCellBegin + "HITS" + stCellEnd);
            aHead.push(stRowEnd);

            var stHead = "<thead>" + aHead.join('') + "</thead>";
            GenericSearch.Table2.THead = stHead;
        },
        CreateRows: function() {
            var aBody = [];
            var stCellBegin = "<td>";
            var stCellEnd = "</td>";
            var stRowBegin = "<tr>";
            var stRowEnd = "</tr>";
            var _t = GenericSearch.Table2.Rows;
            for (var i = 0; i < _t.length; i++) {
                if (_t[i].length > 0) {
                    aBody.push(stRowBegin);
                    for (var j = 0; j < _t[i].length; j++) {
                        aBody.push(stCellBegin + _t[i][j] + stCellEnd);
                    }
                    aBody.push(stRowEnd);
                }
            }
            var stTable = "<tbody>" + aBody.join('') + "</tbody>";
            GenericSearch.Table2.TBody = stTable;
        },
        CreateFooters: function() {
            var aHead = [];
            var stCellBegin = "<td>";
            var stCellEnd = "</td>";
            var stRowBegin = "<tr>";
            var stRowEnd = "</tr>";

            var _t = GenericSearch.Table2.Heads;
            aHead.push(stRowBegin);
            for (var i = 0; i < _t.length; i++) {
                aHead.push(stCellBegin);
                aHead.push(_t[i]);
                aHead.push(stCellEnd);
            }

            var _k = GenericSearch.FramesWithHits;
            for (var j = 0, n = _k.length; j < n; j++) {
                aHead.push(stCellBegin);
                aHead.push(_k[j]);
                aHead.push(stCellEnd);
            }

            aHead.push(stCellBegin);
            aHead.push("HITS");
            aHead.push(stCellEnd);

            aHead.push(stRowEnd);

            var st2ndFoot = this.AddSummaryRow();
            var stFoot = "<tfoot>" + aHead.join('') + st2ndFoot + "</tfoot>";
            GenericSearch.Table2.TFoot = stFoot;
        },
        AddSummaryRow: function() {
            var aHead = [];
            var stCellBegin = "<td>";
            var stCellEnd = "</td>";
            var stRowBegin = "<tr>";
            var stRowEnd = "</tr>";

            aHead.push(stRowBegin);
            for (var i = 0; i < 3; i++) {
                aHead.push(stCellBegin);
                aHead.push(stCellEnd);
            }

            aHead.push(stCellBegin);
            aHead.push(GenericSearch.AllScore.toString());
            aHead.push(stCellEnd);

            var col = 4;
            var _k = GenericSearch.FramesWithHits;
            for (var j = 0, n = _k.length; j < n; j++) {
                var _object = GenericSearch.TopicList._tmap[_k[j] - 1];
                if (typeof (_object) == "object" && _object != null) {
                    if (_object.score > 0 && _object.frameid != -1) {
                        aHead.push(stCellBegin);
                        aHead.push(_object.hits.toString());
                        aHead.push(stCellEnd);
                    }
                }
            }

            aHead.push(stRowEnd);
            var _ret = aHead.join("");

            return _ret;
        },
        CreateTableData: function() {
            for (var i = 0; i < GenericSearch.EcidArray.length; i++) {
                GenericSearch.Table2.Rows[i] = [];
                var item = GenericSearch.EcidArray[i];
                if (item.List.length > 0 && item.List[0] > -1) {
                    GenericSearch.Table2.Rows[i].push(GenericSearch.Utility.GetPrefix(item));
                    GenericSearch.Table2.Rows[i].push(GenericSearch.Utility.GetCaption(item));
                    GenericSearch.Table2.Rows[i].push(GenericSearch.Utility.GetEcid(item));
                    GenericSearch.Table2.Rows[i].push(GenericSearch.Utility.GetWeight(item));
                    var col = 4;
                    var allhits = 0;
                    for (var j = 0, n = GenericSearch.FramesWithHits.length; j < n; j++) {
                        //Gkod.Trace.Write("GenericSearch:CreateTableData - row[" + i + "] col[" + j + "]", 3);	    
                        var zero = true;
                        for (var k = 0; k < item.List.length; k++) {
                            //Gkod.Trace.Log("rows - item.Ctx.Expr="+item.Expr+" j="+j + " k="+k + " item.List[k]="+item.List[k]);
                            if (item.List[k] == GenericSearch.FramesWithHits[j] && item.List[k] > 0) {
                                zero = false;
                                break;
                            }
                        }
                        if (zero)
                            GenericSearch.Table2.Rows[i].push("0");
                        else {
                            GenericSearch.Table2.Rows[i].push("1");
                            allhits++;
                        }
                    }
                    GenericSearch.Table2.Rows[i].push(allhits.toString());
                }
            }
        },
        Create: function() {
            this.CreateTableData();

            this.CreateHeaders();
            this.CreateRows();
            this.CreateFooters();

            //Create table
            if (GenericSearch.Table2.Rows.length > 0) {
                var div = GenericSearch.Utility.TestWindow.document.getElementById("opa2");
                div.innerHTML = "<table class=sortable border=1>" + GenericSearch.Table2.THead + GenericSearch.Table2.TBody + GenericSearch.Table2.TFoot + "</table>";
            }
        }
    },
    Table3:
    {
        THead: "",
        Heads: ["TOPIC NAME", "ABSOLUTE SCORE", "NORMALIZED SCORE", "HITS", /*"FRAME ID",*/"SEARCH ID"],
        TBody: "",
        Rows: [],
        TFoot: "",
        CreateHeaders: function() {
            //this.Heads  = ["TOPIC NAME", /*"TOPIC GUID", */"A. SCORE", "W. SCORE", "HITS", "FRAME ID", "SEARCH ID"];
            var aHead = [];
            var stCellBegin = "<th>";
            var stCellEnd = "</th>";
            var stRowBegin = "<tr>";
            var stRowEnd = "</tr>";

            var _t = GenericSearch.Table3.Heads;
            aHead.push(stRowBegin);
            for (var i = 0; i < _t.length; i++) {
                aHead.push(stCellBegin + _t[i] + stCellEnd);
            }
            aHead.push(stRowEnd);
            var stHead = "<thead>" + aHead.join('') + "</thead>";
            GenericSearch.Table3.THead = stHead;
        },
        CreateTableData: function() {
            var item = 0;
            for (var i = 0, n = GenericSearch.TopicList._tmap.length, z; i < n, z = GenericSearch.TopicList._tmap[i]; i++) {
                if (z.frameid != -1 && z.score > 0) //not topic
                {
                    GenericSearch.Table3.Rows[item] = [];
                    GenericSearch.Table3.Rows[item].push(GenericSearch.TopicList.GetName(i));
                    //GenericSearch.Table3.Rows[item].push(GenericSearch.TopicList.GetGuid(i));                    
                    GenericSearch.Table3.Rows[item].push(z.ascore);
                    GenericSearch.Table3.Rows[item].push(z.score);
                    GenericSearch.Table3.Rows[item].push(z.hits);
                    //GenericSearch.Table3.Rows[item].push(GenericSearch.Utility.Dec2Hex(parseInt(GenericSearch.TopicList.GetFrameid(i))));
                    //GenericSearch.Table3.Rows[item].push("N/A");
                    GenericSearch.Table3.Rows[item].push(GenericSearch.TopicList.GetIndex(i));
                    item++;
                }
            }
        },
        CreateRows: function() {
            var aBody = [];
            var stCellBegin = "<td>";
            var stCellEnd = "</td>";
            var stRowBegin = "<tr>";
            var stRowEnd = "</tr>";
            //Gkod.Trace.Write("GenericSearch:_callBack - CreateRows - begin", 3);	
            var _t = GenericSearch.Table3.Rows;
            for (var i = 0; i < _t.length; i++) {
                aBody.push(stRowBegin);
                for (var j = 0; j < _t[i].length; j++) {
                    aBody.push(stCellBegin + _t[i][j] + stCellEnd);
                }
                aBody.push(stRowEnd);
            }
            var stTable = "<tbody>" + aBody.join('') + "</tbody>";
            GenericSearch.Table3.TBody = stTable;
        },
        Create: function() {
            this.CreateTableData();

            this.CreateHeaders();
            this.CreateRows();

            //Create table
            if (GenericSearch.Table3.Rows.length > 0) {
                var div = GenericSearch.Utility.TestWindow.document.getElementById("opa3");
                //Gkod.Trace.Write("GenericSearch:Table3.Create - div=" + typeof(div), 3);
                div.innerHTML = "<table id=opa3t class=sortable border=1>" + GenericSearch.Table3.THead + GenericSearch.Table3.TBody + GenericSearch.Table3.TFoot + "</table>";
                //var table = GenericSearch.Utility.TestWindow.document.getElementById("opa3t");
                //Gkod.Trace.Write("GenericSearch:Table3.Create - table=" + typeof(table), 3);
                //var div3f = GenericSearch.Utility.TestWindow.document.getElementById("opa3f"); 
                //div3f.innerHTML = "<span>A. SCORE = absolute score; N. SCORE = normalized score</span>";
                GenericSearch.Utility.TestWindow.Ready();
            }
        }
    },
    Table4:
    {
        Heads: ["PREFIX (FILTERED OUT BY MAXHIT)", "CAPTION", "VALUE", "WEIGHT", "HITS"],
        TBody: "",
        Rows: [],
        TFoot: "",
        CreateHeaders: function() {
            var aHead = [];
            var stCellBegin = "<th>";
            var stCellEnd = "</th>";
            var stRowBegin = "<tr>";
            var stRowEnd = "</tr>";

            var _t = GenericSearch.Table4.Heads;
            aHead.push(stRowBegin);
            for (var i = 0; i < _t.length; i++) {
                aHead.push(stCellBegin + _t[i] + stCellEnd);
            }
            aHead.push(stRowEnd);

            var stHead = "<thead>" + aHead.join('') + "</thead>";
            GenericSearch.Table4.THead = stHead;
        },
        CreateTableData: function() {
            for (var i = 0; i < GenericSearch.FilteredbyMaxHit.length; i++) {
                GenericSearch.Table4.Rows[i] = [];
                var item = GenericSearch.FilteredbyMaxHit[i];
                GenericSearch.Table4.Rows[i].push(GenericSearch.Utility.GetPrefix(item));
                GenericSearch.Table4.Rows[i].push(GenericSearch.Utility.GetCaption(item));
                GenericSearch.Table4.Rows[i].push(GenericSearch.Utility.GetEcid(item));
                GenericSearch.Table4.Rows[i].push(GenericSearch.Utility.GetWeight(item));
                GenericSearch.Table4.Rows[i].push(item.Hits);
            }
        },
        CreateRows: function() {
            var aBody = [];
            var stCellBegin = "<td>";
            var stCellEnd = "</td>";
            var stRowBegin = "<tr>";
            var stRowEnd = "</tr>";
            var _t = GenericSearch.Table4.Rows;
            for (var i = 0; i < _t.length; i++) {
                aBody.push(stRowBegin);
                for (var j = 0; j < _t[i].length; j++) {
                    aBody.push(stCellBegin + _t[i][j] + stCellEnd);
                }
                aBody.push(stRowEnd);
            }
            var stTable = "<tbody>" + aBody.join('') + "</tbody>";
            GenericSearch.Table4.TBody = stTable;
        },
        Create: function() {
            this.CreateTableData();

            this.CreateHeaders();
            this.CreateRows();

            //Create table
            if (GenericSearch.Table4.Rows.length > 0) {
                var div = GenericSearch.Utility.TestWindow.document.getElementById("opa4");
                div.innerHTML = "<table class=sortable border=1>" + GenericSearch.Table4.THead + GenericSearch.Table4.TBody + GenericSearch.Table4.TFoot + "</table>";
            }
        }
    },
    Table5:
    {
        Heads: ["PREFIX (DROPPED)", "CAPTION", "VALUE", "WEIGHT"],
        TBody: "",
        Rows: [],
        TFoot: "",
        CreateHeaders: function() {
            var aHead = [];
            var stCellBegin = "<th>";
            var stCellEnd = "</th>";
            var stRowBegin = "<tr>";
            var stRowEnd = "</tr>";

            var _t = GenericSearch.Table5.Heads;
            aHead.push(stRowBegin);
            for (var i = 0; i < _t.length; i++) {
                aHead.push(stCellBegin + _t[i] + stCellEnd);
            }
            aHead.push(stRowEnd);

            var stHead = "<thead>" + aHead.join('') + "</thead>";
            GenericSearch.Table5.THead = stHead;
        },
        CreateTableData: function() {
            for (var i = 0; i < GenericSearch.FilteredbyMaxSearch.length; i++) {
                GenericSearch.Table5.Rows[i] = [];
                var item = GenericSearch.FilteredbyMaxSearch[i];
                GenericSearch.Table5.Rows[i].push(GenericSearch.Utility.GetPrefix(item));
                GenericSearch.Table5.Rows[i].push(GenericSearch.Utility.GetCaption(item));
                GenericSearch.Table5.Rows[i].push(GenericSearch.Utility.GetEcid(item));
                GenericSearch.Table5.Rows[i].push(GenericSearch.Utility.GetWeight(item));
            }
        },
        CreateRows: function() {
            var aBody = [];
            var stCellBegin = "<td>";
            var stCellEnd = "</td>";
            var stRowBegin = "<tr>";
            var stRowEnd = "</tr>";
            var _t = GenericSearch.Table5.Rows;
            for (var i = 0; i < _t.length; i++) {
                aBody.push(stRowBegin);
                for (var j = 0; j < _t[i].length; j++) {
                    aBody.push(stCellBegin + _t[i][j] + stCellEnd);
                }
                aBody.push(stRowEnd);
            }
            var stTable = "<tbody>" + aBody.join('') + "</tbody>";
            GenericSearch.Table5.TBody = stTable;
        },
        Create: function() {
            this.CreateTableData();

            this.CreateHeaders();
            this.CreateRows();

            //Create table
            if (GenericSearch.Table5.Rows.length > 0) {
                var div = GenericSearch.Utility.TestWindow.document.getElementById("opa5");
                div.innerHTML = "<table class=sortable border=1>" + GenericSearch.Table5.THead + GenericSearch.Table5.TBody + GenericSearch.Table5.TFoot + "</table>";
            }
        }
    },
    TableE:
    {
        Heads: ["PREFIX", "CAPTION", "VALUE"],
        TBody: "",
        TFoot: "",
        CreateHeaders: function() {
            var aHead = [];
            var stCellBegin = "<th>";
            var stCellEnd = "</th>";
            var stRowBegin = "<tr>";
            var stRowEnd = "</tr>";

            var _t = GenericSearch.TableE.Heads;
            aHead.push(stRowBegin);
            for (var i = 0; i < _t.length; i++) {
                aHead.push(stCellBegin + _t[i] + stCellEnd);
            }
            aHead.push(stRowEnd);

            var stHead = "<thead>" + aHead.join('') + "</thead>";
            GenericSearch.TableE.THead = stHead;
        },
        CreateRows: function() {
            var aBody = [];
            var stCellBegin = "<td>";
            var stCellEnd = "</td>";
            var stRowBegin = "<tr>";
            var stRowEnd = "</tr>";

            for (var i = 0; i < GenericSearch.EcidArray.length; i++) {
                aBody.push(stRowBegin);
                var item = GenericSearch.EcidArray[i];
                aBody.push(stCellBegin + GenericSearch.Utility.GetPrefix(item) + stCellEnd);
                aBody.push(stCellBegin + GenericSearch.Utility.GetCaption(item) + stCellEnd);
                aBody.push(stCellBegin + GenericSearch.Utility.GetEcid(item) + stCellEnd);
                aBody.push(stRowEnd);
            }

            var stTable = "<tbody>" + aBody.join('') + "</tbody>";
            GenericSearch.TableE.TBody = stTable;
        },
        Create: function() {
            this.CreateHeaders();
            this.CreateRows();

            //Create table
            var div = GenericSearch.Utility.TestWindow.document.getElementById("opa2");
            div.innerHTML = "<table class=sortable border=1>" + GenericSearch.TableE.THead + GenericSearch.TableE.TBody + GenericSearch.TableE.TFoot + "</table>";
        }
    },
    Utility:
    {
        TestWindow: null,
        //Conversions
        Dec2Hex: function(d) {
            return d.toString(16).toUpperCase();
        },
        Hex2Dec: function(h) {
            return parseInt(h, 16);
        },
        GetEcid: function(ctx) {
            var _ret = "";
            var ret = ctx.Expr.substr(1, ctx.Expr.length - 2);
            var i = ret.indexOf("$");
            if (i > 0) {
                var s = ret.substr(i + 1);
                //4 letter prefix
                var __ret = s.substr(4);
                return Gkod.Escape.MyUnEscape(__ret);
            }

            return _ret;
        },
        GetPrefix: function(ctx) {
            var _ret = "";
            var ret = ctx.Expr.substr(1, ctx.Expr.length - 2);
            var i = ret.indexOf("$");
            if (i > 0) {
                var s = ret.substr(i + 1);
                _ret = s.substr(0, 4);
            }

            return _ret;
        },
        GetWeight: function(ctx) {
            var _ret = "";
            _ret = ctx.Ctx.weight;

            return _ret;
        },
        GetCaption: function(ctx) {
            var _ret = "";
            _ret = ctx.Ctx.caption;

            return _ret;
        }
    }
};

GenericSearch.TopicList = new GenericSearch._TopicList();

//Search function does not work in namespace
function StartSearch(expr) {
    var ss = "g" + expr;
    //Gkod.Trace.Log("StartSearch - expr = " + ss);    
    //alert(QueryParser)    
    QueryParser.Parse("URI", ss);
    if (QueryParser.ev) {
        try {
            QueryProcessor.Start(QueryParser.ev, GenericSearch.Search);
        }
        catch (e) {
            if (navigator.appVersion.indexOf("MSIE") != -1)
                alert("QueryProcessor.Start\n" + e.message);
            else
                alert("QueryProcessor.Start\n" + e);
        }
    }
    else {
        //Gkod.Trace.Log("StartSearch - QueryProcessor.ev is null");
    }
}

function TransferCtx2(ctx, appname, testparams) {
    CopyGenericVariablesFromRootNamespace();
    if (typeof (testparams) != 'undefined') {
        Gkod.Trace.Write(Gkod.Trace.ID.GEN, "[GENERIC] : TransferCtx2() - ctx.length=" + ctx.length + " appname=" + appname + " testparams=" + testparams, 3);
        if (typeof (testparams) != 'undefined') {
            try {
                testdata = eval('(' + testparams + ')');
            }
            catch (e) {
                //Gkod.Trace.Log("TransferCtx2 - Exception=" + e, 3);
            }

            if (typeof (testdata) != 'undefined' && testdata != null && typeof (testdata.generictest) != 'undefined') {
                if (parseInt(testdata.generictest.showscore) > -1)
                    showscore = parseInt(testdata.generictest.showscore);
                if (parseInt(testdata.generictest.showtestpage) > -1)
                    showtestpage = parseInt(testdata.generictest.showtestpage);
                if (parseInt(testdata.generictest.maxhit) > -1)
                    maxhit = parseInt(testdata.generictest.maxhit);
                if (parseInt(testdata.generictest.maxsearch) > -1)
                    maxsearch = parseInt(testdata.generictest.maxsearch);
                if (parseInt(testdata.generictest.threshold) > -1)
                    threshold = parseInt(testdata.generictest.threshold);
                if (parseInt(testdata.generictest.minscore) > -1)
                    minscore = parseInt(testdata.generictest.minscore);
            }
        }
    }
    else {
        Gkod.Trace.Write(Gkod.Trace.ID.GEN, "[GENERIC] : TransferCtx2() - error in testparams: ctx.length=" + ctx.length + " appname=" + appname, 3);
    }

    GenericSearch.EcidArray.length = 0;
    if (appname.length > 0) {
        if (ctx.length > 0) {
            GenericSearch.SetAppName(appname);

            for (var a = 0; a < ctx.length; a++) {
                if (ctx[a].generic == '1') {
                    if (ctx[a].contextid.length > 0) {
                        var sFullContext = "";
                        if (ctx[a].usenameasprefix == "0") {
                            sFullContext = ctx[a].contextid;
                        }
                        else {
                            sFullContext = ctx[a].name + ctx[a].contextid;
                        }

                        var ctxex = "'" + appname + "$" + Gkod.Escape.MyEscape(sFullContext) + "'";
                        var temp = new GenericSearch._EcidArray(ctxex, ctx[a]);
                        if (ctx[a].searchable == "1") {
                            GenericSearch.EcidArray.push(temp);
                        }
                        else {
                            GenericSearch.FilteredbyMaxSearch.push(temp);
                        }
                    }
                }
            }
            adjusted_maxsearch = GenericSearch.EcidArray.length;
            Gkod.Trace.Write(Gkod.Trace.ID.GEN, "[GENERIC] : TransferCtx2() - local : showtestpage=" + showtestpage + " showscore=" + showscore + " maxhit=" + maxhit + " maxsearch=" + maxsearch + " threshold=" + threshold, 3);
        }
        else {
            Gkod.Trace.Write(Gkod.Trace.ID.GEN, "[GENERIC] : TransferCtx2() - ERROR - ctx.length = 0", 3);
        }
    }
    else {
        Gkod.Trace.Write(Gkod.Trace.ID.GEN, "[GENERIC] : TransferCtx2() - ERROR - appname.length = 0", 3);
    }

    if (countsearchdb)
        GenericSearch.CtxProcessor.Start();
    else
        setTimeout(GenericSearch.StartXMLProcessor, 1);
}
