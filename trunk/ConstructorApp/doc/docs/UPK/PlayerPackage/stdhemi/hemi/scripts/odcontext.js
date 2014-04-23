//odcontext.js

/*--
Copyright © 1998, 2009, Oracle and/or its affiliates.  All rights reserved.
--*/

//<!--Version 9.6.1.12-->

/// <reference path=oddefs.js />
/// <reference path=escape.js />

//Gkod.Context
Gkod.Trace.Write(Gkod.Trace.ID.LOAD, "[ODCONTEXT] : odcontext.js is loaded into window.name = [" + window.name + "] URL = [" + window.location.href + "]", 3);

Gkod.Modules.Register('odcontext');

//Returns context id(s), appname, language if applicable
Gkod.Context.GetContextID = function(obj) {
    Gkod.Trace.Write(Gkod.Trace.ID.INFO, "[ODCONTEXT] : Gkod.Context.GetContextID()", 3);
    Gkod.ctxinfo.reset();
    if (Gkod.Utility.AccessGranted(obj)) {
        Gkod.Utility.MakeSureEvalIsExist(obj);

        var functions = obj.Gkod.ctxfunctions;
        Gkod.Trace.Write(Gkod.Trace.ID.CTX, "[ODCONTEXT] : Gkod.Context.GetContextID(obj) - functions = [" + functions.getapplicationname + "][" + functions.getcontextid + "][" + functions.getapplicationmodulename + "][" + functions.getapplicationlanguage + "][" + functions.getapplicationhelpurl + "][" + functions.isownapplication + "]", 3);
        var recognized = false;

        try {
            obj.Gkod.Application.GetApplicationName = obj[Gkod.Variables.ODPREFIX][Gkod.Variables.ODAPPLICATIONPREFIX][functions.getapplicationname];
            Gkod.ctxinfo.appname = obj.Gkod.Application.GetApplicationName();

            Gkod.Trace.Write(Gkod.Trace.ID.CTX, "[ODCONTEXT] : Gkod.Context.GetContextID(obj) - application = " + Gkod.ctxinfo.appname, 3);
            obj.Gkod.Application.IsOwnApplication = obj[Gkod.Variables.ODPREFIX][Gkod.Variables.ODAPPLICATIONPREFIX][functions.isownapplication];
            if (obj.Gkod.Application.IsOwnApplication()) {
                recognized = true;
                obj.Gkod.Application.GetContextID = obj[Gkod.Variables.ODPREFIX][Gkod.Variables.ODAPPLICATIONPREFIX][functions.getcontextid];
                var ctx = obj.Gkod.Application.GetContextID();
                var _temp = ctx;
                if (Gkod.Utility.IsArray(ctx) && ctx.length > 0) {
                    _temp = ctx[0];
                }
                //simple
                if (typeof (_temp.contextid) != 'undefined') {
                    Gkod.Trace.Write(Gkod.Trace.ID.CTX, "[ODCONTEXT] : Gkod.Context.GetContextID(obj) - simple ctx", 3);
                    Gkod.ctxinfo._ctxid = ctx;
                }
                //complex
                else if (typeof (_temp._ctxid) != 'undefined') {
                    Gkod.Trace.Write(Gkod.Trace.ID.CTX, "[ODCONTEXT] : Gkod.Context.GetContextID(obj) - complex ctx = " + ctx.ctxex, 3);
                    Gkod.ctxinfo.ctxex = ctx.ctxex;
                }

                obj.Gkod.Application.GetApplicationLanguage = obj[Gkod.Variables.ODPREFIX][Gkod.Variables.ODAPPLICATIONPREFIX][functions.getapplicationlanguage];
                Gkod.ctxinfo.language = obj.Gkod.Application.GetApplicationLanguage();

                obj.Gkod.Application.GetApplicationHelpURL = obj[Gkod.Variables.ODPREFIX][Gkod.Variables.ODAPPLICATIONPREFIX][functions.getapplicationhelpurl];
                Gkod.ctxinfo.apphelpurl = obj.Gkod.Application.GetApplicationHelpURL();

                obj.Gkod.Application.GetApplicationModuleName = obj[Gkod.Variables.ODPREFIX][Gkod.Variables.ODAPPLICATIONPREFIX][functions.getapplicationmodulename];
                Gkod.ctxinfo.modulename = obj.Gkod.Application.GetApplicationModuleName();
            }
            if (typeof (Gkod.ctxinfo._ctxid) == 'object') {
                for (var i = 0, j = Gkod.ctxinfo._ctxid.length; i < j; i++) {
                    if (Gkod.ctxinfo._ctxid[i].custom != "") {
                        Gkod.ctxinfo.custom = Gkod.ctxinfo._ctxid[i].custom;
                        break;
                    }
                }
            }
        }
        catch (e) {
            Gkod.Utility.OnError("Gkod.Context.GetContextID(obj)", e);
        }

        for (var i = 0; i < Gkod.ctxinfo._ctxid.length; i++)
            Gkod.Trace.Write(Gkod.Trace.ID.CTX, "[ODCONTEXT] : Gkod.Context.GetContextID(obj) - caption = " + Gkod.ctxinfo._ctxid[i].caption + " ctxid = " + Gkod.ctxinfo._ctxid[i].contextid, 3);
        if (Gkod.Utility.IsArray(Gkod.ctxinfo._ctxid) && recognized) {
            return 1;
        }
    }
    Gkod.Trace.Write(Gkod.Trace.ID.CTX, "[ODCONTEXT] : Gkod.Context.GetContextID(obj) - No context is found", 3);
    Gkod.ctxinfo.appname = '';
    return 0;
}

Gkod.Context.CreateGatewayURL = function() {
    //Gkod.Trace.Write(Gkod.Trace.ID.INFO, "[ODCONTEXT] : Gkod.Context.CreateGatewayURL()", 3);
    var ctx = "";
    var ctxpref = "";
    var ctxpostf = "";
    var ctxexctx = "";
    var appname = "";
    if (Gkod.Utility.IsString(Gkod.ctxinfo.appname) && Gkod.ctxinfo.appname.length > 0)
        appname = Gkod.Variables.ODAPPNAME + "=" + Gkod.Utility.Encode(Gkod.ctxinfo.appname) + "&";
    var language = "";
    if (Gkod.Utility.IsString(Gkod.ctxinfo.language) && Gkod.ctxinfo.language.length > 0)
        language = Gkod.Variables.ODAPPLANG + "=" + Gkod.Utility.Encode(Gkod.ctxinfo.language) + "&";
    var apphelpurl = "";
    if (Gkod.Utility.IsString(Gkod.ctxinfo.apphelpurl) && Gkod.ctxinfo.apphelpurl.length > 0)
        apphelpurl = Gkod.Variables.ODAPPHELP + "=" + Gkod.Utility.Encode(Gkod.ctxinfo.apphelpurl) + "&";
    if (Gkod.Utility.IsString(Gkod.ctxinfo.ctxex) && Gkod.ctxinfo.ctxex.length > 0)
        ctxexctx = Gkod.Variables.ODCTXEX + "=" + Gkod.Utility.Encode(Gkod.ctxinfo.ctxex) + "&";
    var custom = "";
    if (Gkod.Utility.IsString(Gkod.ctxinfo.custom) && Gkod.ctxinfo.custom.length > 0)
        custom = Gkod.Variables.ODCUSTOM + "=" + Gkod.Utility.Encode(Gkod.ctxinfo.custom) + "&";
    var search = "";
    if (Gkod.Utility.IsString(Gkod.ctxinfo.search) && Gkod.ctxinfo.search.length > 0)
        search = Gkod.Variables.ODSEARCH + "=" + Gkod.Utility.Encode(Gkod.ctxinfo.search) + "&";
    var reserved = "";
    if (Gkod.Utility.IsString(Gkod.ctxinfo.reserved) && Gkod.ctxinfo.reserved.length > 0)
        reserved = Gkod.Variables.ODRESERVED + "=" + Gkod.Utility.Encode(Gkod.ctxinfo.reserved) + "&";
    var extra = "";
    if (Gkod.Utility.IsArray(Gkod.ctxinfo.extra) && Gkod.ctxinfo.extra.length > 0) {
        for (var i = 0, j = Gkod.ctxinfo.extra.length; i < j; i++) {
            extra = Gkod.ctxinfo.extra[i];
            if (i < j)
                extra += ";";
        }
    }

    var odgateway_url = "";
    if (typeof (Gkod.Variables.OD_URL) != "undefined") {
        if (Gkod.Utility.IsString(Gkod.ctxinfo.language) && Gkod.ctxinfo.language.length > 0) {
            odgateway_url = Gkod.Variables.OD_URL[Gkod.ctxinfo.language];
        }
    }
    if (odgateway_url == null || odgateway_url == "") {
        if (typeof (Gkod.Variables.OD_DEFAULT_URL) != "undefined") {
            odgateway_url = Gkod.Variables.OD_DEFAULT_URL;
        }
    }

    odgateway_url = odgateway_url.replace(/\\/g, "/");

    if (odgateway_url.charAt(odgateway_url.length - 1) != '/')
        odgateway_url += '/';

    if (Gkod.ctxinfo.tocurl == "") {
        Gkod.ctxinfo.gatewayurl = odgateway_url + "stdhemi/hemi/" + Gkod.Variables.OD_GATEWAY;
    }
    else {
        Gkod.ctxinfo.gatewayurl = Gkod.ctxinfo.tocurl + "/" + Gkod.Variables.OD_GATEWAY;
    }

    if (Gkod.Utility.IsArray(Gkod.ctxinfo._ctxid) && Gkod.ctxinfo._ctxid.length > 0 && Gkod.Utility.IsObject(Gkod.ctxinfo._ctxid[0])) {
        ctx = Gkod.Variables.ODCTXID + "=";
        ctxpref = Gkod.Variables.ODCTXPREF + "=";
        ctxpostf = Gkod.Variables.ODCTXPOSTF + "=";
        for (var i = 0; i < Gkod.ctxinfo._ctxid.length; i++) {
            if (Gkod.ctxinfo._ctxid[i].searchable == "1") {
                if (Gkod.Utility.IsObject(Gkod.ctxinfo._ctxid[i]) && Gkod.Utility.IsString(Gkod.ctxinfo._ctxid[i].contextid) && Gkod.Utility.IsString(Gkod.ctxinfo._ctxid[i].name)) {
                    if (Gkod.ctxinfo._ctxid[i].contextid.length > 0) {
                        ctx += Gkod.Utility.Encode(Gkod.ctxinfo._ctxid[i].contextid);
                        if (Gkod.Utility.IsString(Gkod.ctxinfo._ctxid[i].usenameasprefix) && Gkod.ctxinfo._ctxid[i].usenameasprefix == "1")
                            ctxpref += Gkod.Utility.Encode(Gkod.ctxinfo._ctxid[i].name);
                        if (Gkod.Utility.IsString(Gkod.ctxinfo._ctxid[i].ctxpostf) && Gkod.ctxinfo._ctxid[i].ctxpostf.length > 0)
                            ctxpostf += Gkod.Utility.Encode(Gkod.ctxinfo._ctxid[i].ctxpostf);
                    }
                    if (i < (Gkod.ctxinfo._ctxid.length - 1)) {
                        ctx += Gkod.Variables.ODSEP;
                        ctxpref += Gkod.Variables.ODSEP;
                        ctxpostf += Gkod.Variables.ODSEP;
                    }
                }
            }
        }
        ctx += "&";
        ctxpref += "&";
        ctxpostf += "&";
    }

    if (Gkod.Utility.IsString(Gkod.ctxinfo.appname) && Gkod.ctxinfo.appname.length > 0) {
        if (ctx.length > 0 || ctxpref.length > 0 || ctxpostf.length > 0 || appname.length > 0 || language.length > 0 || apphelpurl.length > 0 || ctxexctx.length > 0 || custom.length > 0 || reserved.length > 0 || extra.length > 0 || search.length > 0)
            Gkod.ctxinfo.gatewayurl += "?" + Gkod.Escape.SafeUriEscape(ctx + ctxpref + ctxpostf + appname + language + apphelpurl + ctxexctx + custom + reserved + extra + search);
    }
    Gkod.Trace.Write(Gkod.Trace.ID.CTX, "[ODCONTEXT] : Gkod.Context.CreateGatewayURL() - gatewayurl=" + Gkod.ctxinfo.gatewayurl, 3);
}

Gkod.Context.OpenGateway2 = function(baseurl) {
    var obj = Gkod.Variables.ODTARGET;
    Gkod.Trace.Write(Gkod.Trace.ID.CTX, "[ODCONTEXT] : Gkod.Context.OpenGateway2(baseurl) - obj.document.URL = " + obj.document.URL + " baseurl=" + baseurl, 3);
    Gkod.Context.GetContextID(obj);
    if (Gkod.Variables.OD_DEFAULT_URL == "../../" && typeof (baseurl) != 'undefined' && baseurl != null) {
        //Default TOC
        Gkod.Variables.OD_DEFAULT_URL = baseurl.substr(0, baseurl.indexOf('/stdhemi/hemi'));
    }
    Gkod.Context.CreateGatewayURL();
    if (typeof (Gkod.ctxinfo.appname) != 'undefined' && Gkod.ctxinfo.appname.length > 0) {
        Gkod.Context.CreateCTXEX2();
        Gkod.ctxinfo.priority = Gkod.Variables.OD_PRIORITY;
        if (Gkod.Variables.OD_ENABLEMULTIPLEHITS == 1) {
            if (Gkod.Utility.AccessGranted(top)) {
                if (typeof (top.Gkod) != 'undefined' && typeof (top.Gkod.RecognizedApps) != 'undefined') {
                    Gkod.Trace.Write(Gkod.Trace.ID.CTX, "[ODCONTEXT] : Gkod.Context.OpenGateway2(baseurl) - priority = " + Gkod.Variables.OD_PRIORITY + " appname = " + Gkod.ctxinfo.appname + " modulename = " + Gkod.ctxinfo.modulename + " obj.document.URL = " + obj.document.URL, 3);
                    top.Gkod.RecognizedApps.push(Gkod.ctxinfo.copy());
                    Gkod.Trace.Write(Gkod.Trace.ID.CTX, "[ODCONTEXT] : Gkod.Context.OpenGateway2(baseurl) - Added recognized app (length=" + top.Gkod.RecognizedApps.length + ") - ctxex2 = " + Gkod.ctxinfo.ctxex2, 3);
                    return false;
                }
            }
            else {
                Gkod.Trace.Write(Gkod.Trace.ID.CTX, "[ODCONTEXT] : Gkod.Context.OpenGateway2(baseurl) - Access Denied to top " + obj.document.URL, 3);
                return false;
            }
        }
        else {
            Gkod.Gateway.OpenWindow(Gkod.ctxinfo.gatewayurl, false);
            return true;
        }
    }
    return false;
}

Gkod.Context.GetCTXEX = function() {
    if (typeof (top.Gkod) != 'undefined' && typeof (top.Gkod.RecognizedApps) != 'undefined' && top.Gkod.RecognizedApps.length > 0) {
        Gkod.Trace.Write(Gkod.Trace.ID.CTX, "[ODCONTEXT] : Gkod.Context.GetCTXEX()", 3);
        Gkod.Context.RemoveSameItems();
        Gkod.Context.Sort();
        Gkod.Context.GetMultipleTOC();
        top.Gkod.RecognizedApps.length = 0;
    }
    top.Gkod.ctxinfo.processed = true;
    return top.Gkod.ctxinfo.ctxex2;
}

Gkod.Context.OpenStandardTOC = function(baseurl, showerror, oderror) {
    if (baseurl.charAt(baseurl.length - 1) == '/')
        baseurl = baseurl.substring(0, baseurl.length - 1);
    Gkod.Trace.Write(Gkod.Trace.ID.CTX, "[ODCONTEXT] : Gkod.Context.OpenStandardTOC(baseurl, showerror) - baseurl = " + baseurl + " showerror=" + showerror + " apps.length = " + top.Gkod.RecognizedApps.length, 3);
    if (Gkod.Utility.AccessGranted(top)) {
        if (typeof (top.Gkod) != 'undefined' && typeof (top.Gkod.RecognizedApps) != 'undefined' && top.Gkod.RecognizedApps.length > 0) {
            Gkod.Trace.Write(Gkod.Trace.ID.CTX, "[ODCONTEXT] : Gkod.Context.OpenStandardTOC(baseurl, showerror) - Gkod.Variables.OD_PRIORITY = " + Gkod.Variables.OD_PRIORITY + " ctxex2=" + top.Gkod.ctxinfo.ctxex2, 3);
            //When not called GetCTXEX
            if (typeof (top.Gkod.ctxinfo.processed) == 'undefined' || top.Gkod.ctxinfo.processed == false) {
                Gkod.Context.RemoveSameItems();
                Gkod.Context.Sort();
                Gkod.Context.GetMultipleTOC();
            }
            else {
                top.Gkod.ctxinfo.processed = false;
            }

            //All has 0 priority
            if (top.Gkod.RecognizedApps.length > 0) {
                //Works only with FRONT (portal/webgui)
                if (Gkod.Context.IsSamePriority()) {
                    //Show all in a new window
                    //Gkod.Context.ShowMultipleHits();

                    Gkod.ctxinfo.ctxex = Gkod.ctxinfo.ctxex2;
                    Gkod.ctxinfo.tocurl = baseurl;
                    Gkod.ctxinfo._ctxid.length = 0; //reset
                    Gkod.ctxinfo.language = top.Gkod.RecognizedApps[0].language;
                    Gkod.ctxinfo.appname = top.Gkod.RecognizedApps[0].appname;

                    Gkod.Trace.Write(Gkod.Trace.ID.CTX, "[ODCONTEXT] : Gkod.Context.OpenStandardTOC(baseurl, showerror) - Gkod.ctxinfo.ctxex = " + Gkod.ctxinfo.ctxex, 3);
                    Gkod.Trace.Write(Gkod.Trace.ID.CTX, "[ODCONTEXT] : Gkod.Context.OpenStandardTOC(baseurl, showerror) - Gkod.ctxinfo.gatewayurl = " + Gkod.ctxinfo.gatewayurl, 3);
                    Gkod.Trace.Write(Gkod.Trace.ID.CTX, "[ODCONTEXT] : Gkod.Context.OpenStandardTOC(baseurl, showerror) - Gkod.ctxinfo.tocurl = " + Gkod.ctxinfo.tocurl, 3);
                    Gkod.Context.OpenGateway();
                }
                else {
                    //Show first based on priority
                    Gkod.Trace.Write(Gkod.Trace.ID.CTX, "[ODCONTEXT] : Gkod.Context.OpenStandardTOC(baseurl, showerror) - top.Gkod.RecognizedApps[0].gatewayurl = " + top.Gkod.RecognizedApps[0].gatewayurl, 3);
                    Gkod.Gateway.OpenWindow(top.Gkod.RecognizedApps[0].gatewayurl, false);
                }

                top.Gkod.RecognizedApps.length = 0;
                return;
            }
            else {
                Gkod.Trace.Write(Gkod.Trace.ID.CTX, "[ODCONTEXT] : Gkod.Context.OpenStandardTOC(baseurl) - top.Gkod.RecognizedApps.length = " + top.Gkod.RecognizedApps.length, 3);
            }
        }
        else {
            Gkod.Trace.Write(Gkod.Trace.ID.CTX, "[ODCONTEXT] : Gkod.Context.OpenStandardTOC(baseurl) - typeof(top.Gkod.RecognizedApps) = " + typeof(top.Gkod.RecognizedApps), 3);
        }
    }
    else {
        Gkod.Trace.Write(Gkod.Trace.ID.CTX, "[ODCONTEXT] : Gkod.Context.OpenStandardTOC(baseurl) - AccessGranted(top)=false", 3);
    }

    var odicon = 1;
    var isnumber = (parseInt(oderror) == oderror);
    if ((isnumber && oderror > 999) || !isnumber) {
        if (showerror == true) {
            odicon = 3;
        }
    }

    if (Gkod.Variables.OD_STANDARD_URL == "") {
        if (showerror == true) {
            Gkod.Utility.ShowOdHemiError("", baseurl, oderror, odicon);
        }
        else {
            //Open TOC
            var _baseurl = baseurl.substr(0, baseurl.indexOf('/stdhemi/hemi'));
            Gkod.Gateway.OpenWindow(_baseurl + "/index.html", false);
        }
    }
    else {
        Gkod.Gateway.OpenWindow(Gkod.Variables.OD_STANDARD_URL, false);
    }
}

Gkod.Context.OpenStandardTOC2 = function(baseurl, title, showerror, oderror) {
    if (baseurl.charAt(baseurl.length - 1) == '/')
        baseurl = baseurl.substring(0, baseurl.length - 1);
    Gkod.Trace.Write(Gkod.Trace.ID.CTX, "[ODCONTEXT] : Gkod.Context.OpenStandardTOC2(baseurl, showerror) - baseurl = " + baseurl + " showerror=" + showerror + " apps.length = " + top.Gkod.RecognizedApps.length, 3);
    if (Gkod.Utility.AccessGranted(top)) {
        if (typeof (top.Gkod) != 'undefined' && typeof (top.Gkod.RecognizedApps) != 'undefined' && top.Gkod.RecognizedApps.length > 0) {
            Gkod.Trace.Write(Gkod.Trace.ID.CTX, "[ODCONTEXT] : Gkod.Context.OpenStandardTOC2(baseurl, showerror) - Gkod.Variables.OD_PRIORITY = " + Gkod.Variables.OD_PRIORITY + " ctxex2=" + top.Gkod.ctxinfo.ctxex2, 3);
            //When not called GetCTXEX
            if (typeof (top.Gkod.ctxinfo.processed) == 'undefined' || top.Gkod.ctxinfo.processed == false) {
                Gkod.Context.RemoveSameItems();
                Gkod.Context.Sort();
                Gkod.Context.GetMultipleTOC();
            }
            else {
                top.Gkod.ctxinfo.processed = false;
            }

            //All has 0 priority
            if (top.Gkod.RecognizedApps.length > 0) {
                //Works only with FRONT (portal/webgui)
                if (Gkod.Context.IsSamePriority()) {
                    //Show all in a new window
                    //Gkod.Context.ShowMultipleHits();

                    Gkod.ctxinfo.ctxex = Gkod.ctxinfo.ctxex2;
                    Gkod.ctxinfo.tocurl = baseurl;
                    Gkod.ctxinfo._ctxid.length = 0; //reset
                    Gkod.ctxinfo.language = top.Gkod.RecognizedApps[0].language;
                    Gkod.ctxinfo.appname = top.Gkod.RecognizedApps[0].appname;

                    Gkod.Trace.Write(Gkod.Trace.ID.CTX, "[ODCONTEXT] : Gkod.Context.OpenStandardTOC2(baseurl, showerror) - Gkod.ctxinfo.ctxex = " + Gkod.ctxinfo.ctxex, 3);
                    Gkod.Trace.Write(Gkod.Trace.ID.CTX, "[ODCONTEXT] : Gkod.Context.OpenStandardTOC2(baseurl, showerror) - Gkod.ctxinfo.gatewayurl = " + Gkod.ctxinfo.gatewayurl, 3);
                    Gkod.Trace.Write(Gkod.Trace.ID.CTX, "[ODCONTEXT] : Gkod.Context.OpenStandardTOC2(baseurl, showerror) - Gkod.ctxinfo.tocurl = " + Gkod.ctxinfo.tocurl, 3);
                    Gkod.Context.OpenGateway();
                }
                else {
                    //Show first based on priority
                    Gkod.Trace.Write(Gkod.Trace.ID.CTX, "[ODCONTEXT] : Gkod.Context.OpenStandardTOC2(baseurl, showerror) - top.Gkod.RecognizedApps[0].gatewayurl = " + top.Gkod.RecognizedApps[0].gatewayurl, 3);
                    Gkod.Gateway.OpenWindow(top.Gkod.RecognizedApps[0].gatewayurl, false);
                }

                top.Gkod.RecognizedApps.length = 0;
                return;
            }
            else {
                Gkod.Trace.Write(Gkod.Trace.ID.CTX, "[ODCONTEXT] : Gkod.Context.OpenStandardTOC2(baseurl) - top.Gkod.RecognizedApps.length = " + top.Gkod.RecognizedApps.length, 3);
            }
        }
        else {
            Gkod.Trace.Write(Gkod.Trace.ID.CTX, "[ODCONTEXT] : Gkod.Context.OpenStandardTOC2(baseurl) - typeof(top.Gkod.RecognizedApps) = " + typeof (top.Gkod.RecognizedApps), 3);
        }
    }
    else {
        Gkod.Trace.Write(Gkod.Trace.ID.CTX, "[ODCONTEXT] : Gkod.Context.OpenStandardTOC2(baseurl) - AccessGranted(top) = false", 3);
    }

    if (Gkod.Variables.OD_STANDARD_URL == "") {
        if (showerror == true) {
            Gkod.Utility.ShowOdHemiError2(title, baseurl, oderror, 1); //No content
        }
        else {
            //Open TOC
            var _baseurl = baseurl.substr(0, baseurl.indexOf('/stdhemi/hemi'));
            Gkod.Gateway.OpenWindow(_baseurl + "/index.html", false);
        }
    }
    else {
        Gkod.Gateway.OpenWindow(Gkod.Variables.OD_STANDARD_URL, false);
    }
}

Gkod.Context.ReplaceGateway = function() {
    Gkod.Context.CreateGatewayURL();
    if (Gkod.ctxinfo.appname.length > 0) {
        Gkod.Gateway.ReplaceWindow(Gkod.ctxinfo.gatewayurl);
    }
}

Gkod.Context.IsSamePriority = function() {
    var list = top.Gkod.RecognizedApps;
    if (list.length > 1) {
        for (var i = 1; i < list.length; i++) {
            if (list[i - 1].priority != list[i].priority)
                return false;
        }
        return true;
    }
    return false;
}

Gkod.Context.RemoveSameItems = function() {
    var list = top.Gkod.RecognizedApps;
    for (var i = 0; i < top.Gkod.RecognizedApps.length; i++) {
        Gkod.Trace.Write(Gkod.Trace.ID.CTX, "[ODCONTEXT] : Gkod.Context.RemoveSameItems() top.Gkod.RecognizedApps[" + i + "].ctxex2 = " + top.Gkod.RecognizedApps[i].ctxex2, 3);
        Gkod.Trace.Write(Gkod.Trace.ID.CTX, "[ODCONTEXT] : Gkod.Context.RemoveSameItems() top.Gkod.RecognizedApps[" + i + "].gatewayurl = " + top.Gkod.RecognizedApps[i].gatewayurl, 3);
    }
    if (list.length > 1) {
        var newlist = [];
        for (var i = 0; i < list.length; i++) {
            if (list[i].ctxex2.length > 0) {
                newlist.push(list[i]);
                break;
            }
        }
        for (var i = 0; i < list.length; i++) {
            var found = false;
            if (list[i].ctxex2.length > 0) {
                for (var j = 0; j < newlist.length; j++) {
                    if (list[i].ctxex2 == newlist[j].ctxex2) {
                        found = true;
                        break;
                    }
                }
                if (!found) {
                    newlist.push(list[i]);
                }
            }
        }
        //no real context found
        if (newlist.length == 0) {
            for (var i = 0; i < list.length; i++) {
                if (list[i].gatewayurl.length > 0) {
                    newlist.push(list[i]);
                    break;
                }
            }
            for (var i = 0; i < list.length; i++) {
                var found = false;
                if (list[i].gatewayurl.length > 0) {
                    for (var j = 0; j < newlist.length; j++) {
                        if (list[i].gatewayurl == newlist[j].gatewayurl) {
                            found = true;
                            break;
                        }
                    }
                    if (!found) {
                        newlist.push(list[i]);
                    }
                }
            }
        }

        top.Gkod.RecognizedApps = newlist;
    }
    for (var i = 0; i < top.Gkod.RecognizedApps.length; i++) {
        Gkod.Trace.Write(Gkod.Trace.ID.CTX, "[ODCONTEXT] : Gkod.Context.RemoveSameItems() remains - top.Gkod.RecognizedApps[" + i + "].ctxex2 = " + top.Gkod.RecognizedApps[i].ctxex2, 3);
    }
}

Gkod.Context.ShowMultipleHits = function() {
    var header = "<BR><HR><CENTER><B>Found multiple Applications, please select one of them</B></CENTER><HR><BR>";
    var list = top.Gkod.RecognizedApps;
    var alist = "";
    for (var i = 0; i < list.length; i++) {
        alist += "<CENTER><A href=javascript:void(0) onclick=window.open('" + list[i].gatewayurl + "')>" + list[i].appname + " [" + list[i].priority + "]" + "</A></CENTER><BR>";
    }
    var newwin = window.open('', '_odmultiple_', 'height=200, width=400, left=100, top=100, resizable=no, scrollbars=yes, toolbar=no, status=no');
    newwin.document.body.innerHTML = header + alist;
    newwin.document.title.innerText = "Application Hits";
    newwin.focus();
}

Gkod.Context.GetMultipleTOC = function() {
    var query = "";
    var list = top.Gkod.RecognizedApps;
    for (var i = 0, j = list.length; i < j; i++) {
        Gkod.Trace.Write(Gkod.Trace.ID.CTX, "[ODCONTEXT] : Gkod.Context.GetMultipleTOC() - appname = " + list[i].appname + " modulename = " + list[i].modulename + " priority = " + list[i].priority + " ctxex2 = " + list[i].ctxex2 + " gatewayurl = " + list[i].gatewayurl, 3);

        if (i > 0 && query.length > 0)
            query += "-";

        if (list[i].ctxex2.length > 0) {
            if (j > 1)
                query += "(";
            query += list[i].ctxex2;
            if (j > 1)
                query += ")";
        }
    }

    top.Gkod.ctxinfo.ctxex2 = query;

    Gkod.Trace.Write(Gkod.Trace.ID.CTX, "[ODCONTEXT] : Gkod.Context.GetMultipleTOC() - complex query = " + query, 3);
}

Gkod.Context.Sort = function() {
    //Descending
    var list = top.Gkod.RecognizedApps;
    if (list.length > 1) {
        var le = list.length;
        for (var i = (le - 1); i >= 0; i--) {
            for (var j = 1; j <= i; j++) {
                if (parseInt(list[j - 1].priority) < parseInt(list[j].priority)) {
                    var _temp = list[j - 1];
                    list[j - 1] = list[j];
                    list[j] = _temp;
                }
            }
        }
    }
}

Gkod.Context.CreateCTXEX2 = function() {
    //Gkod.Trace.Write(Gkod.Trace.ID.INFO, "[ODCONTEXT] : Gkod.Context.CreateCTXEX2()", 3);
    if (Gkod.ctxinfo._ctxid.length > 0) {
        for (var i = 0; i < Gkod.ctxinfo._ctxid.length; i++) {
            if (typeof (Gkod.ctxinfo._ctxid[i]) == 'object') {
                if (Gkod.ctxinfo._ctxid[i].contextid.length > 0) {
                    if (Gkod.ctxinfo._ctxid[i].searchable == "1") {
                        var sFullContext = "";
                        if (Gkod.ctxinfo._ctxid[i].usenameasprefix == "0") {
                            sFullContext = Gkod.ctxinfo._ctxid[i].contextid;
                        }
                        else {
                            sFullContext = Gkod.ctxinfo._ctxid[i].name + Gkod.ctxinfo._ctxid[i].contextid;
                        }
                        if (Gkod.ctxinfo.appname.length > 0) {

                            Gkod.ctxinfo.ctxex2 += "'" + Gkod.ctxinfo.appname + "$" + Gkod.Escape.MyEscape(sFullContext) + "'";
                        }
                    }
                }
            }
        }
    }
}

Gkod.Context.OpenGateway = function() {
    Gkod.Context.CreateGatewayURL();
    Gkod.Trace.Write(Gkod.Trace.ID.CTX, "[ODCONTEXT] : Gkod.Context.OpenGateway() - Gkod.ctxinfo.gatewayurl=" + Gkod.ctxinfo.gatewayurl, 3);
    if (Gkod.ctxinfo.appname.length > 0) {
        Gkod.Gateway.OpenWindow(Gkod.ctxinfo.gatewayurl, false);
    }
}

