//oddefs.js

/*--
Copyright © 1998, 2009, Oracle and/or its affiliates.  All rights reserved.
--*/

//<!--Version 9.6.1.50-->

try {
    if (typeof (Gkod) == 'undefined' || !Gkod) {
        var Gkod = {};
    }

    //System
    if (typeof (Gkod.System) == 'undefined' || !Gkod.System) {

        Gkod.System = {
            //FF3
            New: function() {
                if (arguments.length > 0) {
                    var c = arguments[0];
                    var undefined;
                    var o = {};
                    var a = [];
                    for (var i = 1; i < arguments.length; i++)
                        a.push(arguments[i]);
                    c.apply(o, a);
                    if (c.prototype !== undefined)
                        o.__proto__ = c.prototype;
                    return o;
                }

                return null;
            },

            Reset: function() {
                Gkod.Application.Reset();
                Gkod.Variables.Reset();
                Gkod.Modules.Register('oddefs');
                Gkod.Version.SetVersion('7.0');
                //FF3
                window.Gkod = Gkod;
            }
        }
    }

    //Utility
    if (typeof (Gkod.Utility) == 'undefined' || !Gkod.Utility) {

        Gkod.Utility = {

            IsIE: function() {
                return (navigator.appName == 'Microsoft Internet Explorer');
            },

            IsFF: function() {
                return (navigator.appName == 'Netscape');
            },

            IsObject: function(obj) {
                return ((typeof (obj) == 'object' || Gkod.Utility.IsFunction(obj)) && obj != null);
            },

            IsFunction: function(obj) {
                return (typeof (obj) == 'function');
            },

            IsArray: function(obj) {
                // frames lose type, so test constructor string
                if (obj == null)
                    return false;
                if (obj.constructor && obj.constructor.toString().indexOf('Array') > -1) {
                    return true;
                }
                else {
                    return (Gkod.Utility.IsObject(obj) && obj.constructor == Array);
                }
            },

            IsString: function(obj) {
                return (typeof (obj) == 'string');
            },

            IsUndefined: function(obj) {
                return (typeof (obj) == 'undefined');
            },

            WriteScript: function(obj, src) {
                var headID = obj.document.getElementsByTagName('head')[0];
                var newScript = obj.document.createElement('script');
                newScript.type = 'text/javascript';
                newScript.src = src;
                headID.appendChild(newScript);
            },

            LoadScript: function(obj, src) {
                var s1 = 'void(z=document.getElementsByTagName(\'head\')[0].appendChild(document.createElement(\'script\')));';
                var s2 = 'void(z.language=\'javascript\');';
                var s3 = 'void(z.type=\'text/javascript\');';
                var s4 = 'void(z.src=\'' + src + '\');';
                obj.eval(s1 + s2 + s3 + s4);
            },

            //calling execScript once on a window object causes the eval method magically to appear, if it was disappeared
            MakeSureEvalIsExist: function(obj) {
                if (this.IsIE()) {
                    if (this.IsObject(obj) && typeof (obj.eval) == 'undefined') {
                        if (typeof (obj.execScript) != 'undefined') {
                            obj.execScript('null');
                        }
                    }
                }
            },

            AccessGranted: function(obj, nocheck) {
                if (!this.IsUndefined(nocheck) && nocheck == 1) //this is an object, not a window, no access check is needed
                    return true;
                //Access denied to the document
                if (this.IsObject(obj)) {
                    if (this.IsFF()) {
                        try {
                            if (typeof (obj.document) == 'undefined') {
                                return false;
                            }
                            //tyepof(obj.document) is 'object'
                            var dummy = obj.document.URL;
                        }
                        catch (e) {
                            //Access denied if exception occurs
                            return false;
                        }
                        return true;
                    }
                    else if (this.IsIE()) {
                        if (typeof (obj.document) != 'unknown' && typeof (obj.document) != 'undefined') {
                            return true;
                        }
                    }
                }
                //Gkod.Trace.Write(Gkod.Trace.ID.ACCESSGRANTED, '[ACCESSGRANTED] : Gkod.Utility.AccessGranted() returns false');
                return false;
            },

            //Encode/Decode UTF8
            Encode: function(s) {
                //  return unescape(encodeURIComponent(s));
                return encodeURIComponent(s);
            },

            Decode: function(s) {
                //  return decodeURIComponent(escape(s));
                return decodeURIComponent(s);
            },

            OnError: function(text, e) {
                if (this.IsFF()) {
                    if (typeof (e) != 'undefined' && e != null)
                        Gkod.Trace.Write(Gkod.Trace.ID.ERROR, '[ERROR] : Gkod.Utility.OnError(text, e) text = ' + text + ' error = ' + e, 2);
                    else
                        Gkod.Trace.Write(Gkod.Trace.ID.ERROR, '[ERROR] : Gkod.Utility.OnError(text, e) text = ' + text, 2);
                }
                else if (this.IsIE()) {
                    if (typeof (e) != 'undefined' && e != null)
                        Gkod.Trace.Write(Gkod.Trace.ID.ERROR, '[ERROR] : Gkod.Utility.OnError(text, e) text = ' + text + ' error = ' + e.description, 2);
                    else
                        Gkod.Trace.Write(Gkod.Trace.ID.ERROR, '[ERROR] : Gkod.Utility.OnError(text, e) text = ' + text, 2);
                }
            },

            IsFFWindow: function(obj) {
                if (obj.toString() != '[object Window]')
                    return false;

                if (typeof (obj.document) != 'object')
                    return false;

                return true;
            }
        }
    }

    //Trace
    if (typeof (Gkod.Trace) == 'undefined' || !Gkod.Trace) {

        Gkod.Trace = {

            ID: {
                LOAD: 'LOAD',
                CTX: 'CTX',
                IDENT: 'IDENT',
                IDENTU: 'IDENTU',
                ERROR: 'ERROR',
                INFO: 'INFO',
                ODCTX: 'ODCTX',
                GEN: 'GEN',
                DEF: 'DEF'
            },

            TRACELEVEL: {
                'ERROR': true
            },

            AllTraceEnabled: false,
            LogInConsole: false,
            LogInTraceView: false,

            IsTraceLevelEnabled: function(tr) {
                if (this.TRACELEVEL[tr] == true || this.AllTraceEnabled == true)
                    return true;

                return false;
            },

            //Log in Firefox Firebug/IE Developer Tools console
            Log: function(text) {
                if (Gkod.Utility.IsObject(window.console) &&
                ((Gkod.Utility.IsFF() && Gkod.Utility.IsFunction(window.console.log)) || (Gkod.Utility.IsIE() && Gkod.Utility.IsObject(window.console.log)))) {
                    window.console.log(text);
                }
            },

            //Log into TraceView
            Write2: function(ids, msg) {
                if (this.IsTraceLevelEnabled(ids)) {
                    if (this.LogInTraceView) {
                        if (Gkod.Utility.IsFF()) {
                            try {
                                if ('createEvent' in document) {
                                    var element = document.getElementById('ODTraceMessageId');
                                    if (!element) {
                                        element = document.createElement('ODTraceMessage');
                                        element.setAttribute('id', 'ODTraceMessageId');
                                        if (document.documentElement != null)
                                            document.documentElement.appendChild(element);
                                    }

                                    element.setAttribute('msg', msg);
                                    element.setAttribute('ids', ids);
                                    var ev = document.createEvent('Events');
                                    ev.initEvent('ODTraceEvent', true, false);
                                    element.dispatchEvent(ev);
                                }
                            }
                            catch (e) { }
                        }
                        else if (Gkod.Utility.IsIE()) {
                            try {
                                _ax_odtrace = new ActiveXObject('ODTraceCom.ODTrace');
                                if (_ax_odtrace) {
                                    _ax_odtrace.Write(ids, msg);
                                }
                            }
                            catch (e) { }
                        }
                    }

                    if (this.LogInConsole) {
                        this.Log(msg);
                    }
                }
            }
        }
    }

    if (typeof (Gkod.Trace.Dump) == 'undefined')
        Gkod.Trace.Dump = function() { }

    if (typeof (Gkod.Trace.Warning) == 'undefined')
        Gkod.Trace.Warning = function() { }

    if (typeof (Gkod.Trace.Error) == 'undefined')
        Gkod.Trace.Error = function() { }

    if (typeof (Gkod.Trace.Write) == 'undefined')
        Gkod.Trace.Write = Gkod.Trace.Write2;

    Gkod.Trace.Write(Gkod.Trace.ID.LOAD, '[ODDEFS] : oddefs.js is loaded into window.name = [' + window.name + '] URL = [' + window.location.href + ']');

    //Modules
    if (typeof (Gkod.Modules) == 'undefined' || !Gkod.Modules) {

        Gkod.Modules = {

            _modules: {},
            _validModules: { 'oddefs': true, 'odcontext': true, 'odgatewaydefs': true, 'odutilities': true },
            _isValidModule: function(mod) {
                if (Gkod.Modules._validModules[mod] == true)
                    return true;

                return false;
            },

            IsRegistered: function(mod) {
                //Gkod.Trace.Write(Gkod.Trace.ID.DEF, '[ODDEFS] : Gkod.Modules.IsRegistered = [' + mod + ']');
                if (typeof (Gkod.Modules._modules[mod]) != 'undefined' && Gkod.Modules._modules[mod] == true)
                    return true;

                return false;
            },

            Register: function(mod) {
                if (Gkod.Modules._isValidModule(mod)) {
                    Gkod.Modules._modules[mod] = true;
                    //Gkod.Trace.Write(Gkod.Trace.ID.DEF, '[ODDEFS] : Gkod.Modules.Registered = [' + mod + ']');
                }
                else {
                    //invalid module
                }
            },

            UnRegister: function(mod) {
                Gkod.Modules._modules[mod] = false;
            }
        }
    }

    //Context
    if (typeof (Gkod.Context) == 'undefined' || !Gkod.Context) {

        Gkod.Context = {

            ContextObject: function() {
                this.contextid = ''; //ODCTX
                this.name = '';
                this.usenameasprefix = '1'; //ODCTXPREF
                this.caption = '';
                this.searchable = '1';

                this.generic = '0';
                this.ctxpostf = ''; //ODCTXPOSTF
                this.custom = '';
                this.weight = 0;
                this.limit = -1;

                this.copy = function() {
                    var _t = new Gkod.Context.ContextObject();
                    _t.contextid = this.contextid;
                    _t.name = this.name;
                    _t.usenameasprefix = this.usenameasprefix;
                    _t.caption = this.caption;
                    _t.searchable = this.searchable;

                    _t.generic = this.generic;
                    _t.ctxpostf = this.ctxpostf;
                    _t.custom = this.custom;
                    _t.weight = this.weight;
                    _t.limit = this.limit;

                    return _t;
                }
            },

            IsHiddenFrame: function(_obj) {
                var _window = _obj || window;
                var bhidden = false;
                var l = 0, r = 0, t = 0, b = 0;

                try {
                    if (Gkod.Utility.AccessGranted(_window)) {
                        var pcanvas = null;
                        var mode = _window.document.compatMode;
                        if (mode == 'CSS1Compat') {
                            pcanvas = _window.document.documentElement;
                        }
                        else {
                            pcanvas = _window.document.body;
                        }
                        if (pcanvas != null) {
                            //NA in FF
                            //l = pcanvas.getBoundingClientRect().left;
                            //r = pcanvas.getBoundingClientRect().right;
                            //t = pcanvas.getBoundingClientRect().top;
                            //b = pcanvas.getBoundingClientRect().bottom;

                            l = pcanvas.offsetLeft;
                            r = pcanvas.offsetLeft + pcanvas.offsetWidth;
                            t = pcanvas.offsetTop;
                            b = pcanvas.offsetTop + pcanvas.offsetHeight;
                        }
                    }
                }
                catch (e) {
                    Gkod.Utility.OnError('Gkod.Context.IsHiddenFrame()', e);
                    bhidden = true;
                }

                if (r * b == 0) {
                    bhidden = true;
                }

                //Gkod.Trace.Write(Gkod.Trace.ID.DEF, '[ODDEFS] : Gkod.Context.IsHiddenFrame() hidden=' + bhidden + ' window.name = [' + window.name + '] URL = [' + window.location.href + ']');
                return bhidden;
            }
        }
    }

    //Variables
    if (typeof (Gkod.Variables) == 'undefined' || !Gkod.Variables) {

        Gkod.Variables = {

            OD_ECIDTESTMODE: false,

            ODVERSION: '',
            ODWINDOWS: [], //Array of Windows (xframe/xdomain scripting restrictions does not apply)

            ODRECOGNIZEDBY: '', //frame previously recognized by
            ODSAVEDCTX: {}, //in top frame

            Reset: function() {
                //stdhemiscripts.js
                this.OD_EXTERNALSCRIPTS = [];
                this.OD_EXTERNALHEMISCRIPTS = [];
                this.OD_EXTERNALAPPSCRIPTS = [];

                this.OD_REFRESHCTX = 0; //do not store ctx in ODSAVEDCTX
                this.OD_GENERICAPPLICATION = 0; //application has generic context
                this.OD_GENERICAPPLICATIONNAME = 'STDHTML'; //generic appname

                Gkod.Variables.OD_EXTERNALHEMISCRIPTS.push({ 'src': 'hemi/stdhemiscripts.js', 'type': 'required' });
                Gkod.Variables.OD_EXTERNALSCRIPTS.push({ 'src': '../stdhemi/hemi/scripts/odplaybackdefs.js', 'type': 'playback' });
                Gkod.Variables.OD_EXTERNALSCRIPTS.push({ 'src': '../stdhemi/hemi/odstdtest.js', 'type': 'optional' });
            },

            Meta: {
                ApplicationName : '',
                Version : '',
                Language : '',
                Context : ''
            }
        }
    }

    //Application
    if (typeof (Gkod.Application) == 'undefined' || !Gkod.Application) {

        Gkod.Application = {

            SetWindowList: function(list) {
                //Gkod.Trace.Write(Gkod.Trace.ID.DEF, '[ODDEFS] : SetWindowList()');
                if (window == top) {
                    Gkod.Trace.Write(Gkod.Trace.ID.DEF, '[ODDEFS] : SetWindowList() - list.length = ' + list.length);

                    //for (var i = 0; i < list.length; i++) {
                    //if (Gkod.Utility.AccessGranted(list[i]))
                    //Gkod.Trace.Write(Gkod.Trace.ID.DEF, '[ODDEFS] : SetWindowList[' + i + '] name = [' + list[i].name + '] URL = [' + list[i].location.href + ']');
                    //else
                    //Gkod.Trace.Write(Gkod.Trace.ID.DEF, '[ODDEFS] : SetWindowList[' + i + '] - no access');
                    //}
                }
                Gkod.Variables.ODWINDOWS = list;
            },

            //Works only in IE, FF does not know VBArray object
            //Call it from C++, multi dimension array
            ConvVBArrToJSArr: function(vbarray) {
                //Gkod.Trace.Write(Gkod.Trace.ID.DEF, '[ODDEFS] : Gkod.Application.ConvVBArrToJSArr [' + vbarray.dimensions() + ']');
                var ret = [];
                if (Gkod.Utility.IsIE()) {
                    if (typeof (vbarray.getItem) != 'undefined') {
                        for (var i = vbarray.lbound(); i <= vbarray.ubound(); i++) {
                            var sub = vbarray.getItem(i);
                            if (sub != null) {
                                for (var j = 0; j < sub.length; j++) {
                                    ret.push(sub[j]);
                                }
                            }
                        }
                    }
                }
                //Gkod.Trace.Write(Gkod.Trace.ID.DEF, '[ODDEFS] : Gkod.Application.ConvVBArrToJSArr ret.length =' + ret.length);
                return ret;
            },

            //Call it from C++, one dimension array
            ConvVBArrToJSArr2: function(vbarray) {
                //Gkod.Trace.Write(Gkod.Trace.ID.DEF, '[ODDEFS] : Gkod.Application.ConvVBArrToJSArr2 [' + vbarray.dimensions() + ']');
                var ret = [];
                if (Gkod.Utility.IsIE()) {
                    ret = vbarray.toArray();
                }
                //Gkod.Trace.Write(Gkod.Trace.ID.DEF, '[ODDEFS] : Gkod.Application.ConvVBArrToJSArr2 ret.length =' + ret.length);
                return ret;
            },

            AppWithGenericCtx: function() {
                return Gkod.Variables.OD_GENERICAPPLICATION;
            },

            Reset: function() {
                Gkod.Trace.Write(Gkod.Trace.ID.DEF, '[ODDEFS] : Gkod.Application.Reset()');
                Gkod.Application.IsOwnApplication = function() {
                    return false;
                }

                Gkod.Application.IsOwnApplication2 = function() {
                    /// <summary>This method returns whether the frame belongs to the application</summary> 
                    return false;
                }

                Gkod.Application.ProcessRecognition_Meta = function() {
                    /// <summary>This methodstores meta information </summary>
                    //<meta name="upk-namespace" content="AppName;1.0;en">
                    var meta = [];
                    if (Gkod.Utility.AccessGranted(window.top)) {
                        meta = window.top.document.getElementsByTagName('meta');
                    }
                    for (var i = 0; i < meta.length; i++) {
                        if (meta[i]['name'] == 'upk-namespace') {
                            var x = meta[i]['content'];
                            if (x && x.length > 0) {
                                //z[0] = application
                                //z[1] = version
                                //z[2] = language                            
                                var z = x.split(';')
                                if (z.length > 0) {
                                    if (z[0].length > 0) {
                                        Gkod.Variables.Meta.ApplicationName = z[0];
                                    }
                                }
                                if (z.length > 1) {
                                    if (z[1].length > 0) {
                                        Gkod.Variables.Meta.Version = z[1];
                                    }
                                }
                                if (z.length > 2) {
                                    if (z[2].length > 0) {
                                        Gkod.Variables.Meta.Language = z[2];
                                    }
                                }
                            }
                        }
                    }
                    return false;
                }

                Gkod.Application.IsOwnApplication2_Meta = function() {
                    /// <summary>This method returns whether the frame belongs to the application</summary>
                    return false;
                }

                Gkod.Application.GetContextID = function() {
                    return [];
                }

                Gkod.Application.GetContextID_Meta = function() {
                    if (typeof (window.UPK_GetContext) == 'undefined') {
                        if (Gkod.Utility.AccessGranted(window.top)) {
                            if (typeof (window.top.UPK_GetContext) != 'undefined') {
                                return window.top.UPK_GetContext();
                            }
                            return '';
                        }
                    }
                    else {
                        return window.UPK_GetContext();
                    }
                }

                Gkod.Application.GetContextID2 = function() {
                    /// <summary>This method returns the context of the application</summary> 
                    return [];
                }

                Gkod.Application.GetApplicationName = function() {
                    /// <summary>This method returns the name of the application</summary> 
                    return '';
                }

                Gkod.Application.GetApplicationLanguage = function() {
                    /// <summary>This method returns the language code of the application</summary>
                    if (Gkod.Variables.Meta.Language && typeof (Gkod.Variables.Meta.Language) == 'string' && Gkod.Variables.Meta.Language.length > 0) {
                        return Gkod.Variables.Meta.Language;
                    }
                    return '';
                }

                Gkod.Application.GetApplicationHelpURL = function() {
                    /// <summary>This method returns the query string of the application's help system</summary> 
                    return '';
                }

                //When there is more than one application needs the same application name, internal identifier only
                Gkod.Application.GetApplicationModuleName = function() {
                    return Gkod.Application.GetApplicationName();
                }

                Gkod.Application.IsOwnApplicationU = function() {
                    /// <summary>This method returns whether the frame belongs to the application (fast mode)</summary>
                    return Gkod.Application.IsOwnApplication();
                }

                this.Reset2();
            },

            Reset2: function() {
                //Gkod.Trace.Write(Gkod.Trace.ID.LOAD, '[ODDEFS] : Gkod.Application.Reset2()');

                Gkod.Application.IsOwnApplication = function() {
                    /// <summary>This method returns whether the frame belongs to the application</summary>
                    //Gkod.Trace.Write(Gkod.Trace.ID.LOAD, '[ODDEFS] : Gkod.Application.IsOwnApplication() - ' + this.GetApplicationName() + ' window.name = [' + window.name + '] URL = [' + window.location.href + ']');
                    try {
                        if (typeof (Gkod) != 'undefined' &&
                            typeof (Gkod.Variables) != 'undefined' &&
                            typeof (Gkod.Variables.ODSAVEDCTX) != 'undefined') {
                            Gkod.Variables.ODSAVEDCTX[this.GetApplicationName()] = []; //Reset
                        }

                        if (typeof (Gkod.Variables.ODRECOGNIZEDBY) != 'undefined') {
                            if (Gkod.Variables.ODRECOGNIZEDBY != '') {
                                if (Gkod.Variables.ODRECOGNIZEDBY == this.GetApplicationName()) {
                                    Gkod.Trace.Write(Gkod.Trace.ID.DEF, '[ODDEFS] : Gkod.Application.IsOwnApplication() - return true - previously recognized by ' + this.GetApplicationName() + ' window.name = [' + window.name + '] URL = [' + window.location.href + ']');
                                    return true;
                                }
                                else {
                                    Gkod.Trace.Write(Gkod.Trace.ID.DEF, '[ODDEFS] : Gkod.Application.IsOwnApplication() - return false - previously recognized by ' + Gkod.Variables.ODRECOGNIZEDBY);
                                    return false;
                                }
                            }
                        }

                        if (top.opener && Gkod.Utility.AccessGranted(top.opener)) {
                            if (Gkod.Utility.IsObject(top.opener.Gkod)) {
                                if (typeof (top.opener.Gkod.Variables.ODRECOGNIZEDBY) != 'undefined') {
                                    if (top.opener.Gkod.Variables.ODRECOGNIZEDBY != '') {
                                        if (top.opener.Gkod.Variables.ODRECOGNIZEDBY == this.GetApplicationName()) {
                                            Gkod.Trace.Write(Gkod.Trace.ID.DEF, '[ODDEFS] : Gkod.Application.IsOwnApplication() top.opener recognized by ' + this.GetApplicationName() + ' window.name = [' + window.name + '] URL = [' + window.location.href + ']');
                                            if (!Gkod.Application.AppWithGenericCtx()) {
                                                Gkod.Variables.ODRECOGNIZEDBY = this.GetApplicationName();
                                            }
                                            return true;
                                        }
                                    }
                                }
                            }
                        }
                        else {
                            if (window == top) {
                                //Gkod.Trace.Write(Gkod.Trace.ID.LOAD, '[ODDEFS] : Gkod.Application.IsOwnApplication() access denied to opener');
                            }
                        }

                        //Meta
                        Gkod.Application.ProcessRecognition_Meta();
                        if (this.IsOwnApplication2_Meta()) {
                            if (!Gkod.Application.AppWithGenericCtx()) {
                                Gkod.Variables.ODRECOGNIZEDBY = this.GetApplicationName();
                            }
                            Gkod.Trace.Write(Gkod.Trace.ID.DEF, '[ODDEFS] : Gkod.Application.IsOwnApplication() - [IsOwnApplication2_Meta] - recognized by ' + this.GetApplicationName() + ' window.name = [' + window.name + '] URL = [' + window.location.href + ']');
                            return true;
                        }
                        //Script
                        if (this.IsOwnApplication2()) {
                            if (!Gkod.Application.AppWithGenericCtx()) {
                                Gkod.Variables.ODRECOGNIZEDBY = this.GetApplicationName();
                            }
                            Gkod.Trace.Write(Gkod.Trace.ID.DEF, '[ODDEFS] : Gkod.Application.IsOwnApplication() - [IsOwnApplication2] - recognized by ' + this.GetApplicationName() + ' window.name = [' + window.name + '] URL = [' + window.location.href + ']');
                            return true;
                        }
                    } catch (e) {
                        if (typeof (Gkod) == 'object' && typeof (Gkod.Utility) == 'object' && typeof (Gkod.Utility.OnError) == 'function')
                            Gkod.Utility.OnError('[ODDEFS] : Error calling Gkod.Application.IsOwnApplication() in ' + this.GetApplicationName(), e);
                    }
                    Gkod.Trace.Write(Gkod.Trace.ID.DEF, '[ODDEFS] : Gkod.Application.IsOwnApplication() - not recognized by ' + this.GetApplicationName() + ' window.name = [' + window.name + '] URL = [' + window.location.href + ']');
                    return false;
                }

                Gkod.Application.GetContextID = function() {
                    /// <summary>This method returns the context of the application</summary>
                    var ctxArray = [];
                    try {
                        Gkod.Trace.Write(Gkod.Trace.ID.DEF, '[ODDEFS] : Gkod.Application.GetContextID() - [' + this.GetApplicationName() + '] generic = ' + Gkod.Application.AppWithGenericCtx() + ' window.name = [' + window.name + '] URL = [' + window.location.href + ']');

                        if (!Gkod.Variables.OD_REFRESHCTX) {

                            if (!Gkod.Application.AppWithGenericCtx()) {
                                if (typeof (Gkod) != 'undefined' &&
                                    typeof (Gkod.Variables) != 'undefined' &&
                                    typeof (Gkod.Variables.ODSAVEDCTX) != 'undefined') {
                                    if (typeof (Gkod.Variables.ODSAVEDCTX[this.GetApplicationName()]) != 'undefined' &&
                                        Gkod.Variables.ODSAVEDCTX[this.GetApplicationName()].length > 1) {//force to recalculate if < 2
                                        ctxArray = Gkod.Variables.ODSAVEDCTX[this.GetApplicationName()];
                                        Gkod.Trace.Write(Gkod.Trace.ID.DEF, '[ODDEFS] : Gkod.Application.GetContextID() is already called in this frame ' + this.GetApplicationName() + ' window.name = [' + window.name + '] URL = [' + window.location.href + ']');
                                    }
                                }
                            }
                        }

                        if (ctxArray.length < 2 || Gkod.Application.AppWithGenericCtx() || Gkod.Variables.OD_REFRESHCTX) {
                            ctxArray = this.GetContextID2();
                        }

                        if (!Gkod.Variables.OD_REFRESHCTX) {

                            if (!Gkod.Application.AppWithGenericCtx()) {
                                //remove empty ctxid
                                var ctxArrayTemp = [];
                                for (var i = 0, z = ctxArray; i < z.length; i++) {
                                    if (z[i].contextid != '')
                                        ctxArrayTemp.push(z[i]);
                                }
                                ctxArray = ctxArrayTemp;

                                //if there is no context get the opener's
                                if (ctxArray.length < 2) {
                                    if (top.opener && Gkod.Utility.AccessGranted(top.opener)) {
                                        if (Gkod.Utility.IsObject(top.opener.Gkod)) {
                                            if (typeof (top.opener.Gkod.Variables.ODRECOGNIZEDBY) != 'undefined') {
                                                if (top.opener.Gkod.Variables.ODRECOGNIZEDBY != '') {
                                                    if (top.opener.Gkod.Variables.ODRECOGNIZEDBY == this.GetApplicationName()) {
                                                        if (typeof (top.opener.Gkod) != 'undefined' &&
                                                                typeof (top.opener.Gkod.Variables) != 'undefined' &&
                                                                typeof (top.opener.Gkod.Variables.ODSAVEDCTX) != 'undefined') {
                                                            if (typeof (top.opener.Gkod.Variables.ODSAVEDCTX[this.GetApplicationName()]) != 'undefined') {
                                                                ctxArray = top.opener.Gkod.Variables.ODSAVEDCTX[this.GetApplicationName()];
                                                                Gkod.Trace.Write(Gkod.Trace.ID.DEF, '[ODDEFS] : Gkod.Application.GetContextID() context from top.opener ' + this.GetApplicationName() + ' window.name = [' + window.name + '] URL = [' + window.location.href + ']');
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    else {
                                        if (window == top) {
                                            //Gkod.Trace.Write(Gkod.Trace.ID.LOAD, '[ODDEFS] : Gkod.Application.GetContextID() access denied to opener');
                                        }
                                    }
                                }

                                if (ctxArray.length > 0) {
                                    if (typeof (Gkod) != 'undefined' &&
                                        typeof (Gkod.Variables) != 'undefined' &&
                                        typeof (Gkod.Variables.ODSAVEDCTX) != 'undefined') {
                                        Gkod.Variables.ODSAVEDCTX[this.GetApplicationName()] = ctxArray;
                                    }
                                }


                                if (typeof (Gkod.Variables.ODRECOGNIZEDBY) != 'undefined') {
                                    if (Gkod.Variables.ODRECOGNIZEDBY == this.GetApplicationName()) {
                                        for (var i = 0, z = ctxArray; i < z.length; i++) {
                                            Gkod.Trace.Write(Gkod.Trace.ID.DEF, '[ODDEFS] : Gkod.Application.GetContextID() - [' + this.GetApplicationName() + ']  [' + i + '] ' + z[i].caption + ' = ' + z[i].name + z[i].contextid + ' window.name = [' + window.name + '] URL = [' + window.location.href + ']');
                                        }
                                    }
                                }
                            }
                        }
                    } catch (e) {
                        if (typeof (Gkod) == 'object' && typeof (Gkod.Utility) == 'object' && typeof (Gkod.Utility.OnError) == 'function')
                            Gkod.Utility.OnError('[ODDEFS] : Error calling Gkod.Application.GetContextID() in ' + this.GetApplicationName(), e);
                    }
                    return ctxArray;
                }
            }
        }
    }

    //Version
    if (typeof (Gkod.Version) == 'undefined' || !Gkod.Version) {

        Gkod.Version = {

            SetVersion: function(ver) {
                Gkod.Variables.ODVERSION = ver;
            },

            GetVersion: function() {
                return Gkod.Variables.ODVERSION;
            }
        }
    }

    Gkod.System.Reset();

} catch (e) {
    if (typeof (Gkod) == 'object' && typeof (Gkod.Utility) == 'object' && typeof (Gkod.Utility.OnError) == 'function')
        Gkod.Utility.OnError('[ERROR] : Error loading oddefs.js', e);
}

//ODVERSION
//9.0 - N/A
//9.1 - ""
//9.1.5 - "1.0" , GetVersion() - supported: no context
//9.1.6 - "2.0" , GetVersion() - supported: context
//9.1.7 - "2.0" , 
//9.5.0 - "3.0" , 
//9.6.0, 9.5.1.102 - "4.0" , 
//9.5.1.103 - "4.1", 
//10.0.0, 9.6.1, 9.5.1.104 - "5.0" , new error messages
//9.6.1.101 - "6.0", tabbed gateway
//9.6.1.102 - "7.0", ff 3.6 fix, opengateway2 does not open a new window, smarthelp does
