/*--
Copyright © 1998, 2009, Oracle and/or its affiliates.  All rights reserved.
--*/

//<!--Version 9.6.0.2-->

Gkod.Standard = 
{
    RootWindow              : null,
    ContentURL              : "",
    AppURL                  : "", // = ContentURL + AppName
    AppName                 : "",
    Oddefs                  : "scripts/oddefs.js",
    ErrorText               : "Please contact your Administrator.",
    ErrorCode               : "Error code %d",
    //Error codes
    E : 
    {
	    "ERR_NO_ERR" : 
	    {
		    "code" : "0",
		    "desc" : "Success" 
	    },
         //Runtime errors 	
	    "ERR_MISSING_JS" : 
	    {
		    "code" : "2200",
		    "desc" : "Missing or inaccessible javascript file : " 
	    },	
	    //General/Unspecified error
        "ERR_ERROR" : 
        {
  	        "code" : "2500",
	        "desc" : "Error occured" 
        },
	    //Syntax errors
	    "ERR_SYNTAX_ERROR" : 
	    {
		    "code" : "2600",
		    "desc" : "Syntax error in javascript array [missing property] : " 
	    },
	    "ERR_EVAL_JS" : 
	    {
		    "code" : "2601",
		    "desc" : "Syntax error in javascript file : " 
	    }		
    }, 
    LastError : 
    { 
        code : 0,
        desc : "",
        window : null,
        Set : function(_window, err, text)
        {
            this.window = _window;
            if (typeof(err) != 'undefined')
            {
                this.code = err.code;        
                this.desc = err.desc;
                if (text != 'undefined')
                    this.desc += " " + text;
            }
        },
        Write : function(text)
        {
            if (this.window != null)
            {
                Gkod.Standard.Trace(this.window, text, 3);
            }
        },
        Diag : function(_force)
        {
            if (typeof(_force) == 'undefined')
                _force = false;
            if (Gkod.Standard.ContentURL != "" && typeof(window.Gkod) != 'undefined' && !_force)
            {
                var text = Gkod.Standard.GetErrorMsg(this.code) + "<BR>" + this.desc;
                window.Gkod.Utility.ShowOdHemiError("", Gkod.Standard.ContentURL + "/stdhemi/hemi", text, 3);
            }
            else
            {
                var text = Gkod.Standard.ErrorText + "\n" + Gkod.Standard.GetErrorMsg(this.code);
                Gkod.Standard.ErrorMsg(text);
            }
        },
        Throw : function(e)
        {
            throw(e);
        }
    }    
};

Gkod.Standard.ErrorMsg = function(msg) 
{
    //alert(this.ErrorTitle, msg); 
}

Gkod.Standard.GetErrorMsg = function(err)
{
    var ret = "";
    var i = this.ErrorCode.indexOf("%d");
    if (i > -1)
    {
        var left = this.ErrorCode.substr(0, i); 
        var right = this.ErrorCode.substr(i + 2, this.ErrorCode.length - i - 2); 
        ret = left + err + right;
    }
    
    return ret;
}  

Gkod.Standard.Initialize = function()
{
    this.RootWindow = opener;
    Gkod.Standard.LastError.Set(this.RootWindow, Gkod.Standard.E.ERR_NO_ERR);        

    var url = document.URL;
    //http://../APPNAME/hemi/standard_gateway.html
    
    if (/\/hemi\/standard_gateway.html/i.test(url))
    {
        var j = url.lastIndexOf("/hemi/standard_gateway.html");
        if (j > 0)
        {
            var k  = url.lastIndexOf("/", j - 1); 
            this.AppURL = url.substr(0, j);
            if (k > 0)
            {
                this.AppName = url.substr(k + 1 , j - k - 1);
                this.ContentURL = url.substr(0, k);
            }
        }
    }    
}

Gkod.Standard.Process = function()
{
    try
    {
        this.Initialize();
        this.Start();
    }
    catch(e)
    {
        if (e == "LastError")
        {
            Gkod.Standard.LastError.Diag(false);
            return;
        }
        else if (e == "BadContent")
        {
            Gkod.Standard.LastError.Diag(true);
            return;
        }
        else
        {
            Gkod.Standard.LastError.Set(window, Gkod.Standard.E.ERR_ERROR, e);
            Gkod.Standard.LastError.Diag(false);
        }
       
        this.Trace(this.RootWindow, "Gkod.Standard::Process() - Exception :" + e, 3, 0);
    }
}

Gkod.Standard.Start = function()
{
    this.Trace(this.RootWindow, "Gkod.Standard::Start()", 3, 0);
    {
        if (this.LoadOddefs())
        {
            var _externalhemiscripts = this.RootWindow.Gkod.Variables.OD_EXTERNALHEMISCRIPTS;
            for (var i = 0, j = _externalhemiscripts.length; i < j; i++)
            {
                this.CheckArraySyntax(_externalhemiscripts[i], "OD_EXTERNALHEMISCRIPTS");
                var jsfile =  this.NormalizeUrl(this.AppURL, _externalhemiscripts[i].src);
                this.Trace(this.RootWindow, "Gkod.Standard::Start() load file [OD_EXTERNALHEMISCRIPTS] = " + jsfile, 3, 0);
                Gkod.Http.LoadFile(this.RootWindow, jsfile);  
            }
            
            this.LoadExternalScripts();
            
            var _externalappscripts = this.RootWindow.Gkod.Variables.OD_EXTERNALAPPSCRIPTS;
            for (var k = 0, l = _externalappscripts.length; k < l; k++)
            {
                this.CheckArraySyntax(_externalappscripts[k], "OD_EXTERNALAPPSCRIPTS");
                var jsfile = this.NormalizeUrl(this.AppURL, _externalappscripts[k].src);
                this.Trace(this.RootWindow, "Gkod.Standard::Start() load file [OD_EXTERNALAPPSCRIPTS] = " + jsfile, 3, 0);
                Gkod.Http.LoadFile(this.RootWindow, jsfile);  
            }     
                   
            this.RootWindow.Gkod.Context.GetContextID(this.RootWindow);
            this.RootWindow.Gkod.Context.CreateGatewayURL();
            
            Gkod.Gateway.OpenWindow(this.RootWindow.Gkod.ctxinfo.gatewayurl, true);
        }
    }
    return false;
}

Gkod.Standard.LoadOddefs = function()
{
    var jsfile = this.ContentURL + "/stdhemi/hemi/" + this.Oddefs;
    this.Trace(this.RootWindow, "Gkod.Standard::Start() load file = " + jsfile, 3, 0);
    if (Gkod.Http.LoadFile(this.RootWindow, jsfile))
    {
        if (typeof(this.RootWindow.Gkod) != 'undefined')
        {
            return true;
        }
        else
        {
            this.Trace(this.RootWindow, "Gkod.Standard::Start() - Cannot continue, RootWindow.Gkod is undefined", 3, 0);
        }          
    }    
    return false;
}

Gkod.Standard.LoadExternalScripts = function()
{
    var _externalscripts = this.RootWindow.Gkod.Variables.OD_EXTERNALSCRIPTS;
    for (var i = 0, j = _externalscripts.length; i < j; i++)
    {
        //stdhemiscripts.js
        this.CheckArraySyntax(_externalscripts[i], "OD_EXTERNALSCRIPTS");
        var jsfile =  this.NormalizeUrl(this.ContentURL + "/stdhemi/hemi", _externalscripts[i].src);
        this.Trace(this.RootWindow, "Gkod.Standard::Start() load file [OD_EXTERNALSCRIPTS] = " + jsfile, 3, 0);
        Gkod.Http.LoadFile(this.RootWindow, jsfile);
    }
}

Gkod.Standard.CheckArraySyntax = function(obj, text)
{
    if (typeof(obj) != 'object' || typeof(obj.src) == 'undefined' || typeof(obj.type) == 'undefined')
    {
        Gkod.Standard.LastError.Set(window, Gkod.Standard.E.ERR_SYNTAX_ERROR, text);
        Gkod.Standard.LastError.Write("Gkod.Standard::CheckArraySyntax(obj, text) - Error code :" + Gkod.Standard.LastError.code + " Error description : " + Gkod.Standard.LastError.desc);
        Gkod.Standard.LastError.Throw("LastError");
    }
}

Gkod.Standard.Trace = function(_window, text, code, _alert)
{
    if (typeof(this.RootWindow.console) == "object")
    {
        this.RootWindow.console.log(text);
        return;
    }
    else
    {
        this.ErrorMsg(text);
        return;
    }

    if (typeof(_window.Gkod) != 'undefined' && typeof(_window.Gkod.Trace) != 'undefined' && typeof(_window.Gkod.Trace.Write) != 'undefined' && 
    _window.Gkod.Trace.Write.toString().indexOf("CreateTIO") > 0)
    {
        _window.Gkod.Trace.Write(text, code);
    }
    else if (typeof(window.Gkod) != 'undefined' && typeof(window.Gkod.Trace) != 'undefined' && typeof(window.Gkod.Trace.Write) != 'undefined' &&
    window.Gkod.Trace.Write.toString().indexOf("CreateTIO") > 0)
    {
        window.Gkod.Trace.Write("Gkod.Standard.Trace " + text, code);
    }
}

Gkod.Standard.NormalizeUrl = function(url, file)
{
    //url 
    //StandardContent
    // http://server/content/stdhemi/hemi
    //appscript
    // http://server/content/app
    //file
    // ../stdhemi/hemi/file.js
    // ../stdhemi/tools/file.js
    // /hemi/file.js
    
    var ret = url;
    var _temp = "";        
    var i = url.lastIndexOf('/stdhemi/hemi');    
    var k = file.lastIndexOf('/stdhemi/hemi/');
    var l = file.lastIndexOf('/stdhemi/');
    if (i > -1)
    {
        //this is content url
        //OD_EXTERNALSCRIPTS
        if (k > -1)
        {        
            _temp = file.substr(k + 13);
            ret += _temp;
        }
        else if (l > - 1)
        {
            var m = ret.lastIndexOf('/hemi');
            if (m > -1)
            {
                ret = ret.substr(0, m);
                _temp = file.substr(l + 8);
                ret += _temp;
            }
        }
    }
    else
    {
        //this is app url
        //OD_EXTERNALHEMI
        if (file.indexOf("hemi") == 0)
            file = "/" + file;
        var k = file.indexOf('/hemi/');
        if (k == 0)
        {
            ret += file;
        }
    }
       
    return ret; 
}
