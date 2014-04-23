/*--
Copyright © 1998, 2009, Oracle and/or its affiliates.  All rights reserved.
--*/

//<!--Version 9.6.1.8-->

/// <reference path=oddefs.js />

function ParseGatewayURL()
{
	//Valid parameter list: ODCTXID=context1;context2;context3&ODCTXPREF=A;B;C&ODAPPNAME=myotherapp&ODAPPLANG=de
	Gkod.ctxinfo.reset();
	var _sParam = document.location.search;
	var sParam = Gkod.Escape.SafeUriUnEscape(_sParam); //unescape
	if (sParam.length > 0)
	{
	    var _odctxex = sParam.indexOf("ODCTXEX=");
	    if (_odctxex > 0)
	    {
	        var end = sParam.indexOf("&", _odctxex);
	        if (end < 0)
	        {
	            end = sParam.length;
	        }    
	        _odctxex += 8;
            var odctxex = sParam.substr(_odctxex, end - _odctxex);
            if (odctxex.length > 0)
            {        
                Gkod.ctxinfo.ctxex = Gkod.Utility.Decode(odctxex);
            }            
        }	
	    var _odctx = sParam.indexOf("ODCTXID=");
	    if (_odctx > 0)
	    {
	        var end = sParam.indexOf("&", _odctx);
	        if (end < 0)
	        {
	            end = sParam.length;
	        }    
	        _odctx += 8;
            var odctx = sParam.substr(_odctx, end - _odctx);
            if (odctx.length > 0)
            {
				var sArrayId = odctx.split(";");
				for (var j = 0; j < sArrayId.length; j++)
				{
                    var ctx = new Gkod.Context.ContextObject();
                    ctx.contextid = Gkod.Utility.Decode(sArrayId[j]);
                    ctx.name = "";
                    ctx.usenameasprefix = "0";
//                  ctx.caption = "";
//                  ctx.searchable = "0";
                    Gkod.ctxinfo._ctxid[j] = ctx;
				}	                
            }
	    }

	    var _odctxpref = sParam.indexOf("ODCTXPREF=");
	    if (_odctxpref > 0)
	    {
	        var end = sParam.indexOf("&", _odctxpref);
	        if (end < 0)
	        {
	            end = sParam.length;
	        }    
	        _odctxpref += 10;
            var odctxpref = sParam.substr(_odctxpref, end - _odctxpref);
            if (odctxpref.length > 0)
            {
				var sArrayId = odctxpref.split(";");
				for (var j = 0; j < sArrayId.length; j++)
				{
					if (typeof(Gkod.ctxinfo._ctxid[j]) == 'object')
					{
						Gkod.ctxinfo._ctxid[j].name = Gkod.Utility.Decode(sArrayId[j]);
						Gkod.ctxinfo._ctxid[j].usenameasprefix = "1"; //set the usenameasprefix, if this param is available
					}
				}
            }	
        }

	    var _odctxpostf = sParam.indexOf("ODCTXPOSTF=");
	    if (_odctxpostf > 0)
	    {
	        var end = sParam.indexOf("&", _odctxpostf);
	        if (end < 0)
	        {
	            end = sParam.length;
	        }    
	        _odctxpostf += 11;
            var odctxpostf = sParam.substr(_odctxpostf, end - _odctxpostf);
            if (odctxpostf.length > 0)
            {
				var sArrayId = odctxpostf.split(";");
				for (var j = 0; j < sArrayId.length; j++)
				{
					if (typeof(Gkod.ctxinfo._ctxid[j]) == 'object')
					{
						Gkod.ctxinfo._ctxid[j].ctxpostf = Gkod.Utility.Decode(sArrayId[j]);
					}
				}
            }	
        }
           
	    var _odapp = sParam.indexOf("ODAPPNAME=");
	    if (_odapp > 0)
	    {
	        var end = sParam.indexOf("&", _odapp);
	        if (end < 0)
	        {
	            end = sParam.length;
	        }    
	        _odapp += 10;
            var odapp = sParam.substr(_odapp, end - _odapp);
            if (odapp.length > 0)
            {        
                Gkod.ctxinfo.appname = Gkod.Utility.Decode(odapp);
            }
	    }
	    
	    var _odlang = sParam.indexOf("ODAPPLANG=");
	    if (_odlang > 0)
	    {
	        var end = sParam.indexOf("&", _odlang);
	        if (end < 0)
	        {
	            end = sParam.length;
	        }    
	        _odlang += 10;
            var odlang = sParam.substr(_odlang, end - _odlang);
            if (odlang.length > 0)
            {        
                Gkod.ctxinfo.language = Gkod.Utility.Decode(odlang);
            }
	    }
	    
	    var _odhelp = sParam.indexOf("ODAPPHELP=");
	    if (_odhelp > 0)
	    {
	        var end = sParam.indexOf("&", _odhelp);
	        if (end < 0)
	        {
	            end = sParam.length;
	        }    
	        _odhelp += 10;
            var odhelp = sParam.substr(_odhelp, end - _odhelp);
            if (odhelp.length > 0)
            {        
                Gkod.ctxinfo.apphelpurl = Gkod.Utility.Decode(odhelp);
            }
	    }	
	    
	    var _odtocurl = sParam.indexOf("ODTOCURL=");
	    if (_odtocurl > 0)
	    {
	        var end = sParam.indexOf("&", _odtocurl);
	        if (end < 0)
	        {
	            end = sParam.length;
	        }    
	        _odtocurl += 9;
            var odtocurl = sParam.substr(_odtocurl, end - _odtocurl);
            if (odtocurl.length > 0)
            {        
                Gkod.ctxinfo.tocurl = Gkod.Utility.Decode(odtocurl);
            }
	    }
	    
	    var _odextra = sParam.indexOf("ODEXTRA=");
	    if (_odextra > 0)
	    {
	        var end = sParam.indexOf("&", _odextra);
	        if (end < 0)
	        {
	            end = sParam.length;
	        }    
	        _odextra += 8;
            var odextra = sParam.substr(_odextra, end - _odextra);
            if (odextra.length > 0)
            {        
                var _extra = Gkod.Utility.Decode(odextra);
		        var sArray = _extra.split(/;/);
		        if (sArray.length > 0)
		        {
			        for (var i = 0; i < sArray.length; i++)
			        {
				        var item = sArray[i].split("=");
                        Gkod.ctxinfo.extra[item[0]] = item[1];
				    }
                }
            }
	    }

	    var _odsearch = sParam.indexOf("ODSEARCH=");
	    if (_odsearch > 0) {
	        var end = sParam.indexOf("&", _odsearch);
	        if (end < 0) {
	            end = sParam.length;
	        }
	        _odsearch += 9;
	        var odsearch = sParam.substr(_odsearch, end - _odsearch);
	        if (odsearch.length > 0) {
	            Gkod.ctxinfo.search = Gkod.Utility.Decode(odsearch);
	        }
	    }	
	    
	    var _odcustom = sParam.indexOf("ODCUSTOM=");
	    if (_odcustom > 0)
	    {
	        var end = sParam.indexOf("&", _odcustom);
	        if (end < 0)
	        {
	            end = sParam.length;
	        }    
	        _odcustom += 9;
            var odcustom = sParam.substr(_odcustom, end - _odcustom);
            if (odcustom.length > 0)
            {        
                Gkod.ctxinfo.custom = Gkod.Utility.Decode(odcustom);
            }
	    }
	    
	    var _odreserved = sParam.indexOf("ODRESERVED=");
	    if (_odreserved > 0)
	    {
	        var end = sParam.indexOf("&", _odreserved);
	        if (end < 0)
	        {
	            end = sParam.length;
	        }    
	        _odreserved += 11;
            var odreserved = sParam.substr(_odreserved, end - _odreserved);
            if (odreserved.length > 0)
            {        
                Gkod.ctxinfo.reserved = Gkod.Utility.Decode(odreserved);
            }
	    }
	    
	    var _odopentoc = sParam.indexOf("ODOPENTOC=");
	    if (_odopentoc > 0)
	    {
	        var end = sParam.indexOf("&", _odopentoc);
	        if (end < 0)
	        {
	            end = sParam.length;
	        }    
	        _odopentoc += 10;
            var odopentoc = sParam.substr(_odopentoc, end - _odopentoc);
            if (odopentoc.length > 0)
            {        
                Gkod.ctxinfo.opentoc = Gkod.Utility.Decode(odopentoc);
            }
	    }	    
	}
}

function CreateTOCURL()
{
    if (Gkod.ctxinfo.tocurl != "")
        return;
	var odtoc_url = null;
	if (Gkod.ctxinfo.language != "" && typeof(Gkod.Variables.OD_URL[Gkod.ctxinfo.language]) == "string" && Gkod.Variables.OD_URL[Gkod.ctxinfo.language] != "")
	    odtoc_url = Gkod.Variables.OD_URL[Gkod.ctxinfo.language];
	if (odtoc_url == null)
		odtoc_url = Gkod.Variables.OD_DEFAULT_URL;
	odtoc_url = odtoc_url.replace(/\\/g,"/");
	if (odtoc_url.charAt(odtoc_url.length - 1) != '/')
	    odtoc_url += '/';
	odtoc_url += "index.html";
    if (Gkod.Variables.OD_TOCVIEW_ALL == 0)
    {
	    if (Gkod.ctxinfo.appname != "")
	    {
	        if (Gkod.ctxinfo.ctxex.length > 0) {
	            odtoc_url += "?SU=" + Gkod.Escape.SafeUriEscape("CTXEX=" + Gkod.ctxinfo.ctxex);
	        }
	        else if (Gkod.ctxinfo.search.length > 0) {
	            odtoc_url += "?SU=" + Gkod.Escape.SafeUriEscape("SEARCH=" + Gkod.ctxinfo.search);
	        }
	    }
    }
    
	Gkod.ctxinfo.tocurl = odtoc_url;
}

function CreateCTXEX()
{
    if (Gkod.ctxinfo.ctxex != "")
        return;
	if (Gkod.ctxinfo._ctxid.length > 0)
	{
		for (var i = 0; i < Gkod.ctxinfo._ctxid.length; i++)
		{
			if (typeof(Gkod.ctxinfo._ctxid[i]) == 'object')
			{
			    if (Gkod.ctxinfo._ctxid[i].contextid.length > 0)
			    {
			        var sFullContext = "";
			        if (Gkod.ctxinfo._ctxid[i].usenameasprefix == "0")
			        {
			            sFullContext = Gkod.ctxinfo._ctxid[i].contextid;
			        }
			        else
			        {
			            sFullContext = Gkod.ctxinfo._ctxid[i].name + Gkod.ctxinfo._ctxid[i].contextid;
			        }
			        if (Gkod.ctxinfo.appname.length > 0)
			        {
				        Gkod.ctxinfo.ctxex += "'" + Gkod.ctxinfo.appname + "$" + Gkod.Escape.MyEscape(sFullContext) + "'";
			            if (Gkod.ctxinfo._ctxid[i].ctxpostf != "")				        
			            {
			                Gkod.ctxinfo.ctxex += Gkod.ctxinfo._ctxid[i].ctxpostf;
			            }
				    }
				}
			}
		}
	}
}

