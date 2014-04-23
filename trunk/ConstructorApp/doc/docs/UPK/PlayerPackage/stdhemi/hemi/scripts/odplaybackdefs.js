//odplaybackdefs.js

/*--
Copyright © 1998, 2009, Oracle and/or its affiliates.  All rights reserved.
--*/

//<!--Version 9.6.1.15-->

try {

    if (typeof (Gkod) != 'undefined' && Gkod) {

        Gkod.Trace.Write(Gkod.Trace.ID.LOAD, '[ODPLAYBACKDEFS] : odplaybackdefs.js is loaded into window.name = [' + window.name + '] URL = [' + window.location.href + ']', 3);

        Gkod.Context.ExtendedContextObject = function() {

            this.reset = function() {
                this._ctxid = []; //array of Gkod.Context.ContextObject
                this.appname = '';
                this.language = '';
                this.ctxex = '';
                this.ctxex2 = '';
                this.tocurl = '';
                this.gatewayurl = '';
                this.apphelpurl = '';
                this.priority = 0;
                this.modulename = '';
                this.extra = []; //ODEXTRA
                this.custom = '';
                this.search = '';
                this.reserved = '';
                this.opentoc = 'new';
            }

            this.setappname = function(_appname) { this.appname = _appname; };
            this.setlanguage = function(_language) { this.language = _language; };
            this.setctxex = function(_ctxex) { this.ctxex = _ctxex; };
            this.setctxex2 = function(_ctxex2) { this.ctxex2 = _ctxex2; };
            this.settocurl = function(_tocurl) { this.tocurl = _tocurl; };
            this.setapphelpurl = function(_apphelpurl) { this.apphelpurl = _apphelpurl; };
            this.setgatewayurl = function(_gatewayurl) { this.gatewayurl = _gatewayurl; };
            this.setpriority = function(_priority) { this.priority = _priority; };
            this.setmodulename = function(_modulename) { this.modulename = _modulename; };
            this.getappname = function() { return this.appname; };
            this.getlanguage = function() { return this.language; };
            this.getctxex = function() { return this.ctxex; };
            this.getctxex2 = function() { return this.ctxex2; };
            this.gettocurl = function() { return this.tocurl; };
            this.getgatewayurl = function() { return this.gatewayurl; };
            this.getapphelpurl = function() { return this.apphelpurl; };
            this.getpriority = function() { return this.priority; };
            this.getmodulename = function() { return this.modulename; };

            this.copy = function() {
                var _t = Gkod.System.New(Gkod.Context.ExtendedContextObject);

                var _ctxid = [];
                for (var i = 0; i < this._ctxid.length; i++) {
                    _ctxid.push(this._ctxid[i].copy());
                }
                _t._ctxid = _ctxid;
                _t.appname = this.appname;
                _t.language = this.language;
                _t.ctxex = this.ctxex;
                _t.ctxex2 = this.ctxex2;
                _t.tocurl = this.tocurl;
                _t.gatewayurl = this.gatewayurl;
                _t.apphelpurl = this.apphelpurl;
                _t.priority = this.priority;
                _t.modulename = this.modulename;
                _t.extra = this.extra;
                _t.custom = this.custom;
                _t.search = this.search;
                _t.reserved = this.reserved;
                _t.opentoc = this.opentoc;
                return _t;
            }

            this.reset();
        }

        Gkod.Variables.FunctionObject = function(appname, contextid, modname, applang, apphelp, isown) {

            this.Reset = function() {
                this.getapplicationname = Gkod.Variables.ODAPPNAMEFUNCTION;
                this.getcontextid = Gkod.Variables.ODCONTEXTFUNCTION;
                this.getapplicationmodulename = Gkod.Variables.ODMODNAMEFUNCTION;
                this.getapplicationlanguage = Gkod.Variables.ODAPPLANGUAGEFUNCTION;
                this.getapplicationhelpurl = Gkod.Variables.ODAPPHELPFUNCTION;
                this.isownapplication = Gkod.Variables.ODISOWNAPPLICATION;
            }

            this.Set = function(appname, contextid, modname, applang, apphelp, isown) {
                if (typeof (appname) != 'undefined' && appname != '')
                    this.getapplicationname = appname;
                if (typeof (contextid) != 'undefined' && contextid != '')
                    this.getcontextid = contextid;
                if (typeof (modname) != 'undefined' && modname != '')
                    this.getapplicationmodulename = modname;
                if (typeof (applang) != 'undefined' && applang != '')
                    this.getapplicationlanguage = applang;
                if (typeof (apphelp) != 'undefined' && apphelp != '')
                    this.getapplicationhelpurl = apphelp;
                if (typeof (isown) != 'undefined' && isown != '')
                    this.isownapplication = isown;
            }

            this.setappname = function(appname) { this.getapplicationname = appname; }
            this.setcontextid = function(contextid) { this.getcontextid = contextid; }
            this.setmodname = function(modname) { this.getapplicationmodulename = modname; }
            this.setapplang = function(applang) { this.getapplicationlanguage = applang; }
            this.setapphelp = function(apphelp) { this.getapplicationhelpurl = apphelp; }
            this.setisown = function(isown) { this.isownapplication = isown; }

            this.Reset();
            this.Set(appname, contextid, modname, applang, apphelp, isown);
        }

        //Variables
        //odcustomurl.js
        Gkod.Variables.OD_EXTHELP_URL = '';
        Gkod.Variables.OD_EXTHELP_TEXT = 'External Help';

        //enum
        Gkod.Variables._EMBEDDED_TOP = 1; //not used
        Gkod.Variables._EMBEDDED_BOTTOM = 2; //not used
        Gkod.Variables._LINK_GATEWAY = 3; //not used
        Gkod.Variables._LINK_TOC = 4; //not used

        //Generic
        Gkod.Variables.OD_SMARTMATCH_URL = ''; //external generic content
        Gkod.Variables.OD_STRICTURLCHECK = 0; //stop, if any of the OD_APPICATIONSCRIPTS_URL entries do not exist

        //Gateway URL parameters
        Gkod.Variables.ODCTXID = 'ODCTXID';
        Gkod.Variables.ODCTXPREF = 'ODCTXPREF';
        Gkod.Variables.ODCTXPOSTF = 'ODCTXPOSTF'; //query expr 'APP$CTX'Z Z=postfix (SAP)
        Gkod.Variables.ODAPPNAME = 'ODAPPNAME';
        Gkod.Variables.ODAPPLANG = 'ODAPPLANG';
        Gkod.Variables.ODAPPHELP = 'ODAPPHELP';
        Gkod.Variables.ODCTXEX = 'ODCTXEX';
        Gkod.Variables.ODTOCURL = 'ODTOCURL';
        Gkod.Variables.ODSEARCH = 'ODSEARCH';
        Gkod.Variables.ODEXTRA = 'ODEXTRA'; //extra info, test params (SAP) not used
        Gkod.Variables.ODCUSTOM = 'ODCUSTOM'; //custom odcustomurl.js (SAP)
        Gkod.Variables.ODRESERVED = 'ODRESERVED'; //reserved
        Gkod.Variables.ODOPENTOC = 'ODOPENTOC'; //default, other value is 'replace' - sapgui hack (cannot close browser window in FF)
        Gkod.Variables.ODSEP = ';';

        Gkod.Variables.TABBED_GATEWAY = 1;
        Gkod.Variables.TABBED_GATEWAY_OPEN_LAST_ACTIVE_TAB = 1;
       
        Gkod.Variables.GATEWAYPAGE_DUMMY = 0;
        Gkod.Variables.GATEWAYPAGE_MAIN_PLAYER = 1;
        Gkod.Variables.GATEWAYPAGE_EXTERNAL_PLAYER_APPLICABLE = 2;
        Gkod.Variables.GATEWAYPAGE_EXTERNAL_PLAYER_FULL = 3; //add index.html
        Gkod.Variables.GATEWAYPAGE_HELP = 4;
        Gkod.Variables.GATEWAYPAGE_URL_WITH_NOCTX = 5;
        Gkod.Variables.GATEWAYPAGE_URL_WITH_CTX = 6;
        Gkod.Variables.GATEWAYPAGE_RESOURCES = 7;
        
        Gkod.Utility.ShowOdHemiError = function(title, baseurl, errcode, errtype) {
            Gkod.Trace.Write(Gkod.Trace.ID.INFO, '[ODPLAYBACKDEFS] : Gkod.Utility.ShowOdHemiError() title = ' + title + ' baseurl = ' + baseurl + ' errcode=' + errcode + ' errtype=' + errtype, 3);

            if (baseurl.charAt(baseurl.length - 1) == '/')
                baseurl = baseurl.substring(0, baseurl.length - 1);

            var strFeatures = 'width=300,height=150,left=' + (screen.availWidth - 411) / 2 + ',top=' + (screen.availHeight - 314) / 2 +
            ',resizable=0,toolbar=0,scrollbars=0,location=0,menubar=0';

            var isnumber = (parseInt(errcode) == errcode);
            if (!isnumber) {
                //debug window, bigger
                strFeatures = 'width=500,height=250,left=' + (screen.availWidth - 211) / 2 + ',top=' + (screen.availHeight - 214) / 2 +
            ',resizable=0,toolbar=0,scrollbars=0,location=0,menubar=0';
            }

            var dialogurl = '';
            if (Gkod.Variables.OD_CUSTOMERRORHTML == 1) {
                dialogurl = baseurl + '/odcustomerror.html';
            }
            else {
                dialogurl = baseurl + '/odcontenterror.html';
            }

            var newwin = window.open(dialogurl + '?errtitle=' + Gkod.Utility.Encode(title) + '&errcode=' + Gkod.Utility.Encode(errcode) + '&errtype=' + Gkod.Utility.Encode(errtype), '_odhemi_', strFeatures);
            if (newwin) {
                newwin.focus();
            }
        }

        Gkod.Utility.ShowOdHemiError2 = function(title, baseurl, errtext, errtype, _errcontent, _bigmsgbox) {
            var errcontent = _errcontent || '';
            var bigmsgbox = _bigmsgbox || false;
            Gkod.Trace.Write(Gkod.Trace.ID.INFO, '[ODPLAYBACKDEFS] : Gkod.Utility.ShowOdHemiError2() title = ' + title + ' baseurl = ' + baseurl + ' errtext=' + errtext + ' errtype=' + errtype + ' bigmsgbox=' + bigmsgbox, 3);
            if (baseurl.charAt(baseurl.length - 1) == '/')
                baseurl = baseurl.substring(0, baseurl.length - 1);

            var strFeatures = 'width=300,height=150,left=' + (screen.availWidth - 411) / 2 + ',top=' + (screen.availHeight - 314) / 2 +
            ',resizable=0,toolbar=0,scrollbars=0,location=0,menubar=0';

            if (bigmsgbox) {
                //bigger window
                strFeatures = 'width=500,height=250,left=' + (screen.availWidth - 211) / 2 + ',top=' + (screen.availHeight - 214) / 2 +
            ',resizable=0,toolbar=0,scrollbars=0,location=0,menubar=0';
            }

            var dialogurl = '';
            if (Gkod.Variables.OD_CUSTOMERRORHTML == 1) {
                dialogurl = baseurl + '/odcustomerror.html';
            }
            else {
                dialogurl = baseurl + '/odcontenterror.html';
            }

            var newwin = window.open(dialogurl + '?errtitle=' + Gkod.Utility.Encode(title) + '&errtext=' + Gkod.Utility.Encode(errtext) + '&errtype=' + Gkod.Utility.Encode(errtype) + '&errcontent=' + Gkod.Utility.Encode(errcontent), '_odhemi_', strFeatures);
            if (newwin) {
                newwin.focus();
            }
        }

        Gkod.GatewayUtility = {
            GetIndexOfMainPlayer: function() {
                for (var i = 0, z = Gkod.Variables.GATEWAY_EMBED; i < z.length; i++) {
                    if (z[i].Type == Gkod.Variables.GATEWAYPAGE_MAIN_PLAYER)
                        return i;
                }
                return -1;
            }
        }

        Gkod.Variables.Reset2 = function() {
            this.OD_URL = {};
            this.OD_DEFAULT_URL = '../../';
            this.OD_APPLICATIONHELP_URL = ''; //not used
            this.OD_APPLICATIONHELP_MODE = 0; //0=embedded, 1=linked //not used
            //this.OD_APPLICATION_URL = ''; //URL of the application, not used
            this.OD_TOCVIEW_ALL = 0;
            this.OD_TOCTYPE_EMBEDDED = 0;
            this.OD_SHOWHELPMODE = 3;
            this.OD_GATEWAY = 'stdie_gateway.html';
            this.OD_SHOWHELPTEXT = 'Help';
            this.OD_SHOWAPPLOGO = 'large_logo.gif';
            this.OD_DIRECT = 1;
            this.OD_BRAND = 'Undefined:[Brand]';
            this.OD_STANDARD_URL = '';
            //this.OD_APPLICATIONDOMAIN = ''; //not used
            this.OD_CUSTOMERRORHTML = 0; //set to 1, if odcustomerror.html is used
            this.OD_APPLICATIONSCRIPTS_URL = [];
            this.OD_ENABLEMULTIPLEHITS = 0;
            this.OD_PRIORITY = 0; //default is no priority 
            this.OD_BUTTONCACHE = 1; //default, use it
            this.OD_ENABLETRACE = 0;
            this.OD_TRACELEVEL = 0;
            this.OD_HEMIPARAMTEST = 0;
            this.OD_ENABLESMARTMATCH = 1; //generic is enabled by default
            this.OD_DISABLESMARTMATCH = 0; //targeted apps can disable generic context
            //this.OD_HEMIMSG = ['Undefined error code']; //not used
            //this.OD_ERROR = 0; //not used
            this.OD_TITLE = '';

            this.ODTARGET = window;
            this.ODPREFIX = 'Gkod';
            this.ODAPPLICATIONPREFIX = 'Application';
            this.ODCONTEXTFUNCTION = 'GetContextID';
            this.ODAPPNAMEFUNCTION = 'GetApplicationName';
            this.ODMODNAMEFUNCTION = 'GetApplicationModuleName';
            this.ODAPPLANGUAGEFUNCTION = 'GetApplicationLanguage';
            this.ODAPPHELPFUNCTION = 'GetApplicationHelpURL';
            this.ODISOWNAPPLICATION = 'IsOwnApplication';

            this.OD_DESIGNATEDECIDPARTS = ''; //if not empty, not using all ecid parts (WEBGUI, PORTAL)

            this.GATEWAY_RESOURCES_TITLE = 'Linked Resources';
            this.GATEWAY_PLAYER_TITLE = 'Main Player';
            this.GATEWAY_EMBEDDED_HELP_TITLE = 'Help';
            this.GATEWAY_EMBEDDED_TEST_TITLE = 'Test Data';

            this.GATEWAY_EMBED = []; //default player
            this.GATEWAY_LINK = [];
            this.GATEWAY_EMEBED_DEFAULT_PLAYER = { 'Title': Gkod.Variables.GATEWAY_PLAYER_TITLE, 'URL': '', 'Type': '1' };

            //Temporary
            this.GATEWAY_EMBED.push(this.GATEWAY_EMEBED_DEFAULT_PLAYER);
        }

        Gkod.System.Reset2 = function() {
            Gkod.Trace.Write(Gkod.Trace.ID.INFO, '[ODPLAYBACKDEFS] : Gkod.System.Reset2() ', 3);
            Gkod.Variables.Reset2();
            Gkod.Application.Reset2();            

            Gkod.Variables.OD_EXTERNALAPPSCRIPTS.push({ 'src': 'hemi/odcustomurl.js', 'type': 'optional' });
            Gkod.Variables.OD_EXTERNALSCRIPTS.push({ 'src': '../stdhemi/hemi/odstdcustomurl.js', 'type': 'optional' });
            Gkod.Variables.OD_EXTERNALSCRIPTS.push({ 'src': '../stdhemi/hemi/scripts/odgatewaydefs.js', 'type': 'playback' });
            Gkod.Variables.OD_EXTERNALSCRIPTS.push({ 'src': '../stdhemi/hemi/scripts/odcontext.js', 'type': 'playback' });
            //Gkod.Variables.OD_EXTERNALSCRIPTS.push({ 'src': '../stdhemi/tools/ondemandtrace.js', 'type': 'optional' });
            Gkod.Variables.OD_EXTERNALSCRIPTS.push({ 'src': '../stdhemi/hemi/scripts/escape.js', 'type': 'playback' });
            Gkod.Variables.OD_EXTERNALSCRIPTS.push({ 'src': '../stdhemi/hemi/scripts/odhelper.js', 'type': 'playback' });
            
            //Initialization, create default context object
            Gkod.ctxinfo = Gkod.System.New(Gkod.Context.ExtendedContextObject);
            Gkod.ctxfunctions = Gkod.System.New(Gkod.Variables.FunctionObject);
        }

        Gkod.System.IsPopupBlocked = function() {
            var popup = window.open('', '', 'width=1,height=1,left=0,top=0,scrollbars=no');
            var popUpsBlocked = true;
            if (popup) {
                popUpsBlocked = false;
                popup.close();
            }
            return popUpsBlocked;
        }

        Gkod.System.Reset2();
    }

} catch (e) {
    if (typeof (Gkod) == 'object' && typeof (Gkod.Utility) == 'object' && typeof (Gkod.Utility.OnError) == 'function')
        Gkod.Utility.OnError('[ERROR] : Error loading odplaybackdefs.js', e);
}
