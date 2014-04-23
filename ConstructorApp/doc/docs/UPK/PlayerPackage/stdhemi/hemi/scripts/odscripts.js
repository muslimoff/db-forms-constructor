/*--
Copyright © 1998, 2009, Oracle and/or its affiliates.  All rights reserved.
--*/
//<!--Version 9.6.0.3-->

/// <reference path=../../stdhemi/scripts/oddefs.js />

function LoadScripts(obj, list, sAppName, level)
{
    GetFullPath(list, sAppName, level);
    Gkod.Http.LoadFiles(obj, list);
}

function GetFullPath(list, sAppName, level)
{
    if (sAppName == null)
    {
        SetPathLocal(list);
    }
    else
    {
        SetPathAppLocal(list, sAppName, level);
    }
}

function SetPathLocal(list)
{
    //get full path in stdhemi/hemi
    var loc = document.URL;
    var k = loc.indexOf('?');
    if (k > 0)
    {
        loc = loc.substr(0, k);
    }
    if (/\/hemi\//i.test(loc))
    {
        var i = loc.lastIndexOf("/");   
        if (i > 0)
        {
            var j = loc.lastIndexOf("/", i - 1);
            if (j > 0)
            {
                //stdhemi/hemi/..
                var base = loc.substr(0, j + 1);
                for (var k = 0; k < list.length; k++)
                {
                    var temp = list[k];
                    list[k] = base + temp;
                }
            }
        }
    }
}

function SetPathAppLocal(list, sAppName, level)
{
    //get full path from stdhemi/hemi to the app folder
    var loc = document.URL;
    var k = loc.indexOf('?');
    if (k > 0)
    {
        loc = loc.substr(0, k);
    }
    if (/\/hemi\//i.test(loc))
    {
        var j = loc.length + 1;
        for (var i = 0; i < level; i++)        
        {
            j = loc.lastIndexOf("/", j - 1 - i);
        }
        
        if (j > 0)
        {
            //../../<APP>/hemi
            if (sAppName != "")
            {
                var base = loc.substr(0, j + 1) + sAppName + "/hemi/";
                for (var l = 0; l < list.length; l++)
                {
                    var temp = list[l];
                    list[l] = base + temp;
                }
            }
        }
    }
}

function GetFullPath2(list)
{
    //get full path from app folder to stdhemi/hemi
    var loc = document.URL;
    var k = loc.indexOf('?');
    if (k > 0)
    {
        loc = loc.substr(0, k);
    }
    if (/\/hemi\//i.test(loc))
    {
        var i = loc.lastIndexOf('/hemi/');   
        if (i > 0)
        {
            var j = loc.lastIndexOf("/", i - 2);
            if (j > 0)
            {
                //stdhemi/hemi/..
                var base = loc.substr(0, j + 1) + 'stdhemi/hemi/';
                for (var k = 0; k < list.length; k++)
                {
                    var temp = list[k];
                    list[k] = base + temp;
                }
            }
        }
    }
}

function OdConfirm(text)
{
	return confirm(text);
}

function OdWarning(text)
{
	return alert(text);
}

function OpenGateway(obj, sAppName, sType)
{
    if (sType == 'CONTEXT')
    {
        if (Gkod.Utility.AccessGranted(obj))
        {
            Gkod.Trace.Write(Gkod.Trace.ID.INFO, "[ODSCRIPTS] : OpenGateway(obj, sAppName, sType) obj.document.URL =" +  obj.document.URL + " sAppName=" + sAppName + " sType=" + sType , 4);
        }
    }
    //Non-context
    //NOCONTEXT or NOCONTEXTNOAPP
    if (/NOCONTEXT/i.test(sType))
    {
        window.open("../../../index.html","_nocontext_");
        return;
    }
    
    var ret = 0;
    if (obj.frames && obj.frames.length > 0)
    {
        ret = OpenGatewayR(obj.frames, sAppName);
    }
    else
    {
        if (Gkod.Utility.AccessGranted(obj))
        {
            ret = OpenGateway2(obj, sAppName);
        }    
    }
    if (ret == 0)
    {
        if (Gkod.Utility.AccessGranted(obj))
        {
            var ODSCRIPTS = ["scripts/oddefs.js", "scripts/odcontext.js"];
            GetFullPath(ODSCRIPTS);
            Gkod.Http.LoadFiles(obj, ODSCRIPTS);
            var _baseurl = document.URL.substr(0, document.URL.indexOf('/stdhemi/hemi') + 13);
            obj.Gkod.Context.OpenStandardTOC(_baseurl, true, Gkod.Variables.OD_ERROR);
        }
        else
        {
            Gkod.Utility.ShowOdHemiError("", "../", 1, 1);
        }
    }
}

function OpenGatewayR(obj, sAppName)
{
    for (var i = 0; i < obj.length; i++)
    {
        if (Gkod.Utility.AccessGranted(obj[i]))
        {            
            if (OpenGateway2(obj[i], sAppName) == 1)
                return 1;
        }

        if (obj[i].frames.length) 
        {
            OpenGatewayR(obj[i].frames, sAppName);
        }
    }
    
    return 0;
}

function OpenGateway2(obj, sAppName)
{
    var ODSCRIPTS = ["scripts/oddefs.js", "scripts/odcontext.js", "scripts/escape.js", "odstdtest.js"];
    var ODSCRIPTS_SPEC = ["stdhemiscripts.js"];
    GetFullPath(ODSCRIPTS);
    GetFullPath(ODSCRIPTS_SPEC, sAppName, 4);
    var SCRIPTS = ODSCRIPTS.concat(ODSCRIPTS_SPEC);
    Gkod.Http.LoadFiles(obj, SCRIPTS);
    var hemiscripts = obj.Gkod.Variables.OD_EXTERNALSCRIPTS.concat(obj.Gkod.Variables.OD_EXTERNALAPPSCRIPTS);
    if (hemiscripts.length > 0)
    {
        for (var i = 0; i < hemiscripts.length; i++)
        {
            var _script = hemiscripts[i].src;
            if (_script.indexOf('hemi/') == 0)
            {
                _script = _script.substr(5);
                var __script = [_script];
                GetFullPath(__script, sAppName, 4);
                Gkod.Http.LoadFiles(obj, __script);
            }
            if (_script.indexOf('../stdhemi/hemi/') == 0)
            {
                _script = _script.substr(16);
                var __script = [_script];
                GetFullPath(__script);
                Gkod.Http.LoadFiles(obj, __script);
            }
        }
    }
    //Gkod.Http.LoadFile(obj, "../../../stdhemi/tools/ondemandtrace.js");
    //document.URL is the URL of the hemiframe or iepopup
    if (obj.Gkod.Context.OpenGateway2(document.URL) == true)
    {
        return 1;
    }
    
    return 0;
}

