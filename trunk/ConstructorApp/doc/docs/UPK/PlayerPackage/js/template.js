/*--
Copyright © 1998, 2009, Oracle and/or its affiliates.  All rights reserved.
--*/

var template_leadin = "";
var template_leadout = "";
var template_explanation = "";
var template_pauselink = "";

var template_knowit_leadin = "";
var template_knowit_leadout = "";
var template_knowit_nextstep = "";
var template_knowit_explanation = "";

var template_knowit_leadin_score = "";

var template_knowit_warningL1 = "";
var template_knowit_warningL2 = "";
var template_knowit_warningL3_0 = "";
var template_knowit_warningL3_H = "";
var template_knowit_warningL4 = "";

var template_scoring = "";

var template_scoring_YES = "";
var template_scoring_NO = "";

var template_knowit_continue = "";
var template_knowit_confirmdemo = "";
var template_typingcomplete = "";

var template_knowit_dragwarning = ""

var template_knowit_finish_close = "";

var template_strinp_suppress_example = 0;

//***********************************************************************************************

var _template_arr = new Array();
var _template_retfv = "";

function LoadTemplates(guid, retfv) {
    _template_retfv = retfv;
    if (document.implementation && document.implementation.createDocument) {
        xmlDoc = document.implementation.createDocument("", "", null);
        xmlDoc.onload = LoadTemplates_Returned0;
    }
    else if (window.ActiveXObject) {
        xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
        xmlDoc.onreadystatechange = function() {
            if (xmlDoc.readyState == 4) LoadTemplates_Returned0();
        };
    }
    else {
        LoadTemplates_Error();
        return;
    }

    try {
        xmlDoc.load("../../template/" + guid + "/template.xml");
    }
    catch (e) {
        LoadXMLDocArray("../../template/" + guid + "/template.xml", "LoadTemplates_Returned", "LoadTemplates_Error", "Item", true)
    }
}

function LoadTemplates_Returned0() {
    _nodesArray = new Array();
    var _nodes = xmlDoc.getElementsByTagName('Item');
    for (var i = 0; i < _nodes.length; i++) {
        n = _nodes[i];
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
        _nodesArray[_nodesArray.length] = xmlname + "=" + xmltext;
    }
    LoadTemplates_Returned(_nodesArray);
}

function LoadTemplates_Error() {
    alert("Common template loading error ...");
}

function LoadTemplates_Returned(a) {
    _template_arr = new Array();
    for (var i = 0; i < a.length; i++) {
        k = a[i].indexOf("=");
        key = a[i].substr(0, k);
        value = a[i].substr(k + 1);
        _template_arr[key] = value;
    }
    LoadAll();
    setTimeout(_template_retfv, 100);
}

function GetTemp(id) {
    if (_template_arr[id])
        return _template_arr[id];
    return "";
}

function LoadAll() {
    template_leadin = GetTemp('leadin');
    template_leadout = GetTemp('leadout');
    template_explanation = GetTemp('continue');
    var p = GetTemp('pauselink');
    var p1 = ReplaceAll(p, '<br></br>', '<br/>');
    template_pauselink = ReplaceAll(p1, '<BR></BR>', '<br/>');

    template_knowit_leadin = GetTemp('knowit_leadin');
    template_knowit_leadout = GetTemp('knowit_leadout');
    template_knowit_nextstep = GetTemp('knowit_nextstep');
    template_knowit_explanation = GetTemp('knowit_explanation');

    template_knowit_leadin_score = GetTemp('leadin_score');

    template_knowit_warningL1 = GetTemp('knowit_warningL1');
    template_knowit_warningL2 = GetTemp('knowit_warningL2');
    template_knowit_warningL3_0 = GetTemp('knowit_warningL3_0');
    template_knowit_warningL3_H = GetTemp('knowit_warningL3_H');
    template_knowit_warningL4 = GetTemp('knowit_warningL4');

    template_scoring = GetTemp('scoring');

    template_scoring_YES = GetTemp('scoring_YES');
    template_scoring_NO = GetTemp('scoring_NO');

    template_knowit_continue = GetTemp('knowit_continue');
    template_knowit_confirmdemo = GetTemp('knowit_confirmdemo');
    template_typingcomplete = GetTemp('typingcomplete');

    template_knowit_dragwarning = GetTemp('knowit_dragwarning')

    template_knowit_finish_close = GetTemp('knowit_finish_close');

    template_strinp_suppress_example = GetTemp('strinp_suppress_example');

    s = GetTemplate_knowit_leadin_score("168");
}

function ReplaceAll(sourcestr, sourceexpr, newexpr) {
    var ret = sourcestr;
    var k = ret.indexOf(sourceexpr);
    while (k >= 0) {
        ret = Template_Replace(ret, sourceexpr, newexpr);
        var k = ret.indexOf(sourceexpr);
    }
    return ret;
}

function Template_Replace(sourcestr, sourceexpr, newexpr) {
    var k = sourcestr.indexOf(sourceexpr);
    if (k < 0)
        return sourcestr;
    var s1 = sourcestr.substr(0, k);
    var s2 = sourcestr.substr(k + sourceexpr.length);
    return s1 + newexpr + s2;
}

function GetTemplate_knowit_leadin_score(score) {
    return Template_Replace(template_knowit_leadin_score, "$score$", score);
}

function GetTemplate_scoring(good, needed, result) {
    s = Replace(template_scoring, "$good$", good);
    ss = Replace(s, "$needed$", needed);
    return Replace(ss, "$result$", result);
}

