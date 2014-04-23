//odgatewaydefs.js

/*--
Copyright © 1998, 2009, Oracle and/or its affiliates.  All rights reserved.
--*/

//<!--Version 9.6.1.17-->

/// <reference path=oddefs.js />

Gkod.Trace.Write(Gkod.Trace.ID.LOAD, '[ODGATEWAYDEFS] : odgatewaydefs.js is loaded into window.name = [' + window.name + '] URL = [' + window.location.href + ']', 3);

Gkod.Modules.Register('odgatewaydefs');

//Gkod.Http
if (typeof (Gkod.Http) == 'undefined' || !Gkod.Http) {
    Gkod.Http = {
        IsFileExists: function(url) {
            var oxmlhttp = this.GetHttpObject();
            if (!oxmlhttp) {
                Gkod.Utility.OnError('Gkod.Http.IsFileExists [GetHttpObject is null]');
                return false;
            }
            try {
                oxmlhttp.open('HEAD', url, false);
                oxmlhttp.send(null);
            }
            catch (e) {
                Gkod.Utility.OnError('Gkod.Http.IsFileExists [oxmlhttp.open] ', e);
                return false;
            }
            if (oxmlhttp.readyState == 4) {
                //if (oxmlhttp.status != 404)
                if (oxmlhttp.status == 200) {
                    return true;
                }
            }
            //Gkod.Utility.OnError('Gkod.Http.IsFileExists [oxmlhttp.status] ' + oxmlhttp.status + ' ' + url);
            return false;
        },

        GetHttpObject: function() {
            var oxmlhttp = null;
            try {
                if (window.XMLHttpRequest) { // Mozilla, Safari, IE7...
                    oxmlhttp = new XMLHttpRequest();
                }
                else if (window.ActiveXObject) { // IE6
                    try {
                        oxmlhttp = new ActiveXObject('Msxml2.XMLHTTP');
                    }
                    catch (e) {
                        try {
                            oxmlhttp = new ActiveXObject('Microsoft.XMLHTTP');
                        }
                        catch (e) {
                            Gkod.Utility.OnError('Gkod.Http.GetHttpObject', e);
                        }
                    }
                }
            }
            catch (e) {
                Gkod.Utility.OnError('Gkod.Http.GetHttpObject', e);
            }

            return oxmlhttp;
        },

        GetFile: function(filename) {
            var oxmlhttp = this.GetHttpObject();
            if (!oxmlhttp) {
                Gkod.Utility.OnError('Gkod.Http.GetFile [GetHttpObject is null] ' + filename);
                return null;
            }

            try {
                oxmlhttp.open('GET', filename, false);
                oxmlhttp.send(null);
            }
            catch (e) {
                Gkod.Utility.OnError('Gkod.Http.GetFile [oxmlhttp.open] ' + filename, e);
                return null;
            }

            if (oxmlhttp.readyState == 4 && oxmlhttp.status == 200) {
                return oxmlhttp.responseText;
            }

            return null;
        },

        LoadFile: function(obj, filename) {
            if (!this.IsFileExists(filename)) {
                //Gkod.Utility.OnError('Gkod.Http.LoadFile [file does not exist] ' + filename);    
                return 0;
            }

            if (Gkod.Utility.AccessGranted(obj)) {
                Gkod.Utility.MakeSureEvalIsExist(obj);

                var content = this.GetFile(filename);
                if (content == null) {
                    Gkod.Utility.OnError('Gkod.Http.LoadFile [content is null] ' + filename);
                    return -1;
                }

                if (content.charAt(0) == '<') {
                    Gkod.Utility.OnError('Gkod.Http.LoadFile [content is not javascript] ' + filename);
                    return -2;
                }

                if (!Gkod.Utility.IsIE()) {
                    try {
                        eval.call(obj, content);
                    }
                    catch (e) {
                        Gkod.Utility.OnError('Gkod.Http.LoadFile ' + filename, e);
                        return -3;
                    }
                }
                else {
                    try {
                        obj.eval(content);
                    }
                    catch (e) {
                        Gkod.Utility.OnError('Gkod.Http.LoadFile ' + filename, e);
                        return -4;
                    }
                }

                return 1;
            }
            else {
                Gkod.Utility.OnError('Gkod.Http.LoadFile [Gkod.Utility.AccessGranted = false] ' + filename);
            }

            return 0;
        },

        LoadFiles: function(obj, list) {
            var ret = 0
            var i = 0;
            for (; i < list.length; i++) {
                var t = this.LoadFile(obj, list[i]);
                if (t != 1)
                    Gkod.Utility.OnError('Gkod.Http.LoadFiles [Could not load file ] ' + list[i]);
                ret += t;
            }

            if (ret == i)
                return 1;

            return 0;
        }
    }
}

//Gkod.Gateway
if (typeof (Gkod.Gateway) == 'undefined' || !Gkod.Gateway) {
    Gkod.Gateway = {
        Browser: {
            _Query: function() {
                this._type = this._searchString(this._dataBrowser) || 'An unknown browser';
                this._version = this._searchVersion(navigator.userAgent)
			|| this._searchVersion(navigator.appVersion)
			|| 'an unknown version';
                this._OS = this._searchString(this._dataOS) || 'an unknown OS';
            },
            _searchString: function(_data_) {
                for (var i = 0; i < _data_.length; i++) {
                    var _dataString = _data_[i]._string;
                    var _dataProp = _data_[i]._prop;
                    this._versionSearchString = _data_[i]._versionSearch || _data_[i]._identity;
                    if (_dataString) {
                        if (_dataString.indexOf(_data_[i]._subString) != -1)
                            return _data_[i]._identity;
                    }
                    else if (_dataProp_)
                        return _data_[i]._identity;
                }
            },
            _searchVersion: function(_dataString_) {
                var _index = _dataString_.indexOf(this._versionSearchString);
                if (_index == -1)
                    return;
                return parseFloat(_dataString_.substring(_index + this._versionSearchString.length + 1));
            },
            _dataBrowser:
	        [
            //            		{ 	
            //            _string: navigator.userAgent,
            //            _subString: 'OmniWeb',
            //            _versionSearch: 'OmniWeb/',
            //            _identity: 'OmniWeb'
            //            },
            //            {
            //            _string: navigator.vendor,
            //            _subString: 'Apple',
            //            _identity: 'Safari'
            //            },
            //            {
            //            _prop: window.opera,
            //            _identity: 'Opera'
            //            },
            //            {
            //            _string: navigator.vendor,
            //            _subString: 'iCab',
            //            _identity: 'iCab'
            //            },
            //            {
            //            _string: navigator.vendor,
            //            _subString: 'KDE',
            //            _identity: 'Konqueror'
            //            },
            //            {
            //            _string: navigator.vendor,
            //            _subString: 'Camino',
            //            _identity: 'Camino'
            //            },
            //            {		// for newer Netscapes (6+)
            //            _string: navigator.userAgent,
            //            _subString: 'Netscape',
            //            _identity: 'Netscape'
            //            },
            //            {
            //            _string: navigator.userAgent,
            //            _subString: 'Gecko',
            //            _identity: 'Mozilla',
            //            _versionSearch: 'rv'
            //            },
            //            { 		// for older Netscapes (4-)
            //            _string: navigator.userAgent,
            //            _subString: 'Mozilla',
            //            _identity: 'Netscape',
            //            _versionSearch: 'Mozilla'
            //            },
                {
                _string: navigator.userAgent,
                _subString: 'Firefox',
                _identity: 'Firefox'
            },
		        {
		            _string: navigator.userAgent,
		            _subString: 'MSIE',
		            _identity: 'Explorer',
		            _versionSearch: 'MSIE'
		        }
	        ],
            _dataOS:
	        [
		        {
		            _string: navigator.platform,
		            _subString: 'Win',
		            _identity: 'Windows'
		        },

            //        {
            //        _string: navigator.platform,
            //        _subString: 'Mac',
            //        _identity: 'Mac'
            //        },

		        {
		        _string: navigator.platform,
		        _subString: 'Linux',
		        _identity: 'Linux'
		    }
            ]
        },

        CloseWindow: function() {
            if (Gkod.Gateway.Browser._type == 'Explorer') {
                if (Gkod.Gateway.Browser._version >= 7.0)
                    window.open('', '_parent', '');
                else
                    window.opener = '';
            }
            Gkod.Trace.Write(Gkod.Trace.ID.DEF, '[ODGATEWAYDEFS] : CloseWindow() url=' + window.location.href, 3);
            window.close();
        },

        OpenWindow: function(url, close) {
            Gkod.Trace.Write(Gkod.Trace.ID.DEF, '[ODGATEWAYDEFS] : OpenWindow()  param.url=' + url + ' window.name=' + window.name + ' close=' + close + ' url=' + window.location.href, 3);
            var windowname = '_odstdiegateway_';
            var win = window.open(url, windowname);
            if (win) {
                win.focus();
                if (close) {
                    Gkod.Gateway.CloseWindow();
                }
            }
            return win;
        },

        ReplaceWindow: function(url) {
            document.location.replace(url);
        },

        OpenWindowFullSize: function(aURL, aWinName) {
            var wOpen;
            var sOptions;

            //sOptions = 'status=yes,menubar=yes,scrollbars=yes,resizable=yes,toolbar=yes';
            sOptions = sOptions + ',width=' + (screen.availWidth - 10).toString();
            sOptions = sOptions + ',height=' + (screen.availHeight - 122).toString();
            sOptions = sOptions + ',screenX=0,screenY=0,left=0,top=0';

            wOpen = window.open('', aWinName, sOptions);
            wOpen.location = aURL;
            wOpen.focus();
            wOpen.moveTo(0, 0);
            wOpen.resizeTo(screen.availWidth, screen.availHeight);
            return wOpen;
        }
    }
}

//hemi_gateway.html
Gkod.Application.ParseGatewayURL = function() {
    var appname = '';
    var ctxex = [];
    var langcode = '';
    var prefix = '';
    if (location.search != '') {
        var _search = location.search.substr(1);
        var _split = _search.split('&');
        for (var k = 0; k < _split.length; k++) {
            if (_split[k].length > 0) {
                var _text = _split[k].split('=');
                if (_text[0].toLowerCase() == 'ctxex' && _text[1].length > 1) {
                    ctxex.push(Gkod.Utility.Decode(_text[1]));
                }
                else if (_text[0].toLowerCase() == 'lang' && _text[1].length > 1) {
                    langcode = _text[1];
                }
                else if (_text[0].toLowerCase() == 'application' && _text[1].length > 1) {
                    appname = _text[1];
                }
                else if (_text[0].toLowerCase() == 'prefix' && _text[1].length > 0) {
                    prefix = _text[1];
                }
            }
        }
    }
    //Workaround for agile, jdeworld, citicard - adding C as prefix
    if (ctxex.length == 1 && prefix.length == 1) {
        var temp = ctxex[0];
        ctxex[0] = prefix + temp;
    }

    if (appname == '') {
        //error
        return;
    }
    var _ctxex = '';
    for (var i = 0; i < ctxex.length; i++)
        _ctxex += '\'' + appname.toUpperCase() + '$' + Gkod.Escape.MyEscape(ctxex[i]) + '\'';

    var _gkod_stdiegatewayurl_ = document.URL.substr(0, document.URL.toLowerCase().indexOf('hemi_gateway.html')) + Gkod.Variables.OD_GATEWAY;
    var _gkod_appname_ = Gkod.Variables.ODAPPNAME + '=' + Gkod.Utility.Encode(appname.toUpperCase());
    var _gkod_ctxex_ = '';
    if (_ctxex.length > 0)
        _gkod_ctxex_ = '&' + Gkod.Variables.ODCTXEX + '=' + Gkod.Utility.Encode(_ctxex);
    var _gkod_applang_ = '';
    if (langcode.length > 0)
        _gkod_applang_ = '&' + Gkod.Variables.ODAPPLANG + '=' + Gkod.Utility.Encode(langcode);
    _gkod_stdiegatewayurl_ += '?' + Gkod.Escape.SafeUriEscape(_gkod_appname_ + _gkod_ctxex_ + _gkod_applang_);
    Gkod.Gateway.OpenWindow(_gkod_stdiegatewayurl_, true);
}

Gkod.Application.ParseGatewayURL_Meta = function() {
    if (window.location.search != "") {
        var _search = window.location.search.substr(1);
        var _split = _search.split('&');
        for (var k = 0; k < _split.length; k++) {
            if (_split[k].length > 0) {
                var _text = _split[k].split("=");
                if (_text[0].toLowerCase() == "namespace" && _text[1].length > 1) {
                    //z[0] = application
                    //z[1] = version
                    //z[2] = language                            
                    var z = _text[1].split(';')
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
                if (_text[0].toLowerCase() == "context" && _text[1].length > 1) {
                    Gkod.Variables.Meta.Context = _text[1];
                }
            }
        }
    }
}

//Gkod.Cookie
if (typeof (Gkod.Cookie) == 'undefined' || !Gkod.Cookie) {
    Gkod.Cookie = {
        MyCookie: {},

        Set: function(_cookie, _property, _value) {
            if (typeof (Cookie) != 'undefined') {
                if (typeof (this.MyCookie[_cookie]) == 'undefined')
                    this.MyCookie[_cookie] = new Cookie(document, _cookie, 365, '/');

                this.MyCookie[_cookie][_property] = _value;
                this.MyCookie[_cookie].Store();
            }
        },

        Get: function(_cookie, _property) {
            if (typeof (Cookie) != 'undefined') {
                if (typeof (this.MyCookie[_cookie]) == 'undefined')
                    this.MyCookie[_cookie] = new Cookie(document, _cookie, 365, '/');
                if (this.MyCookie[_cookie].Load())
                    return this.MyCookie[_cookie][_property];
            }
            return 'undefined';
        },

        GetAll: function(_cookie) {
            var result = {};
            if (typeof (Cookie) != 'undefined') {
                if (typeof (this.MyCookie[_cookie]) == 'undefined')
                    this.MyCookie[_cookie] = new Cookie(document, _cookie, 365, '/');
                if (this.MyCookie[_cookie].Load()) {
                    var allcookies = document.cookie;
                    if (allcookies == '')
                        return result;

                    var start = allcookies.indexOf(_cookie + '=');
                    if (start == -1)
                        return ret;
                    start += _cookie.length + 1;

                    var end = allcookies.indexOf(';', start);
                    if (end == -1)
                        end = allcookies.length;

                    var cookieval = allcookies.substring(start, end);

                    var a = cookieval.split('&');
                    for (var i = 0; i < a.length; i++) {
                        var p = a[i].split(':');
                        result[p[0]] = unescape(p[1]);
                    }
                }
            }
            return result;
        }
    }
}

Gkod.Gateway.Browser._Query();

if (window == top) {
    //Application list
    if (typeof (Gkod.RecognizedApps) == 'undefined' || !Gkod.RecognizedApps) {
        Gkod.Trace.Write(Gkod.Trace.ID.DEF, '[ODGATEWAYDEFS] : Gkod.RecognizedApps is reset', 3);
        Gkod.RecognizedApps = [];
    }
}
