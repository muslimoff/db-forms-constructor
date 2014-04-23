//odutilities.js

/*--
Copyright © 1998, 2009, Oracle and/or its affiliates.  All rights reserved.
--*/

//<!--Version 9.6.0.17-->

/// <reference path=oddefs.js />

try {
    Gkod.Trace.Write(Gkod.Trace.ID.LOAD, "[ODUTILITIES] : odutilities.js is registered = " + Gkod.Modules.IsRegistered('odutilities') + " loaded into window.name = [" + window.name + "] URL = [" + window.location.href + "]", 3);
    if (!Gkod.Modules.IsRegistered('odutilities')) {
        Gkod.Trace.ID.ODUT = ['ODUT'];
        Gkod.Modules.Register('odutilities');

        //Gkod.Utility
        Gkod.Utility.Dom = {};
        Gkod.Utility.String = {};
        Gkod.Utility.Text = {};

        Gkod.Utility.ApplyRegExp = function(string, regexp, replace) {
            var retString = "";
            if (string == null)
                return "";

            if (replace != "") {
                if (regexp != "") {
                    retString = string.replace(regexp, replace);
                }
            }
            else if (regexp != "") {
                retString = string.match(regexp);
            }

            if (typeof (retString) == 'object' && retString != null && retString.length == 1)
                return retString[0];

            return retString;
        }

        //***
        //Dom
        //***
        Gkod.Utility.Dom.GetElementsByAttribute = function(attr, value, win, top) {
            if (attr == 'className') {
                if (!Gkod.Utility.IsIE())
                    attr = "class";
            }
            var ret = [];
            var t = [];
            Gkod.Utility.Dom.FrameCollection(t, win, top);
            for (var i = 0, _ilength = t.length; i < _ilength; i++) {
                if (Gkod.Utility.AccessGranted(t[i])) {
                    var a = t[i].document.getElementsByTagName('*'); //all
                    for (var j = 0, jlength = a.length; j < jlength; j++) {
                        if (a[j].getAttribute(attr) == value)
                            ret.push(a[j]);
                    }
                }
            }

            return ret;
        }

        //t contains the windows to be processed
        Gkod.Utility.Dom.GetElementsByAttribute2 = function(attr, value) {
            if (attr == 'className') {
                if (!Gkod.Utility.IsIE())
                    attr = "class";
            }
            var t = Gkod.Variables.ODWINDOWS;
            var ret = [];
            if (typeof (t) == 'undefined' || t.length == 0)
                return ret;

            for (var i = 0, _ilength = t.length; i < _ilength; i++) {
                if (Gkod.Utility.AccessGranted(t[i])) {
                    var a = t[i].document.getElementsByTagName('*'); //all
                    for (var j = 0, jlength = a.length; j < jlength; j++) {

                        if (a[j].getAttribute(attr) == value)
                            ret.push(a[j]);
                    }
                }
            }
            return ret;
        }

        Gkod.Utility.Dom.GetElementsByAttribute2Contains = function(tag, attr, value, type) {
            //type 0 = element
            //type 1 = attribute
            var t = Gkod.Variables.ODWINDOWS;
            var ret = [];
            if (typeof (t) == 'undefined' || t.length == 0)
                return ret;

            for (var i = 0, _ilength = t.length; i < _ilength; i++) {
                if (Gkod.Utility.AccessGranted(t[i])) {
                    var a = t[i].document.getElementsByTagName(tag);
                    for (var j = 0, jlength = a.length; j < jlength; j++) {
                        var z = a[j].getAttribute(attr);
                        //Gkod.Trace.Write(Gkod.Trace.ID.ODUT, "[ODUTILITY] : Gkod.Utility.Dom.GetElementsByAttribute2Contains() attr=" + attr + "=[" + z + "]", 3); 
                        if (z != null && z.toString().indexOf(value) != -1) {
                            if (type == 0) {
                                ret.push(a[j]);
                            }
                            else if (type == 1) {
                                ret.push(z.toString());
                            }
                        }
                    }
                }
            }
            return ret;
        }

        Gkod.Utility.Dom.GetVariable = function(value) {
            var t = Gkod.Variables.ODWINDOWS;
            var ret = null;
            if (typeof (t) == 'undefined' || t.length == 0)
                return ret;

            for (var i = 0, _ilength = t.length; i < _ilength; i++) {
                if (Gkod.Utility.AccessGranted(t[i])) {
                    var z = t[i][value];
                    if (typeof (z) != 'undefined')
                        return z;
                }
            }
            return ret;
        }

        //If win is specified, then only elements from that window will be collected
        //otherwise, elements from all windows will be collected
        Gkod.Utility.Dom.GetElementsByTagName = function(value, win, top) {
            var ret = [];
            var t = [];
            Gkod.Utility.Dom.FrameCollection(t, win, top);
            for (var i = 0; i < t.length; i++) {
                if (Gkod.Utility.AccessGranted(t[i])) {
                    var a = t[i].document.getElementsByTagName(value);
                    for (var j = 0, ilength = a.length; j < ilength; j++) {
                        ret.push(a[j]);
                    }
                }
            }
            return ret;
        }

        //If win is specified, then only elements from that window will be collected
        //otherwise, elements from all windows will be collected
        //ELEMENT_NODE == 1 
        //ATTRIBUTE_NODE == 2 
        //TEXT_NODE == 3 
        //CDATA_SECTION_NODE == 4 
        //ENTITY_REFERENCE_NODE == 5 
        //ENTITY_NODE == 6 
        //PROCESSING_INSTRUCTION_NODE == 7 
        //COMMENT_NODE == 8 
        //DOCUMENT_NODE == 9 
        //DOCUMENT_TYPE_NODE == 10 
        //DOCUMENT_FRAGMENT_NODE == 11 
        //NOTATION_NODE == 12 

        Gkod.Utility.Dom.GetElementsByNodeType = function(coll, type, win, top) {
            var t = [];
            Gkod.Utility.Dom.FrameCollection(t, win, top);
            //Gkod.Trace.Write(Gkod.Trace.ID.ODUT, "[ODUTILITY] : Gkod.Utility.Dom.GetElementsByNodeType() frames length=" + t.length, 3); 
            for (var i = 0, ilength = t.length; i < ilength; i++) {
                if (Gkod.Utility.AccessGranted(t[i])) {
                    Gkod.Utility.Dom._GetElementsByNodeType(coll, t[i].document, type);
                }
            }
        }

        Gkod.Utility.Dom.GetElementsByNodeType2 = function(coll, type) {
            var t = Gkod.Variables.ODWINDOWS;
            var ret = [];
            if (typeof (t) == 'undefined' || t.length == 0)
                return ret;

            //Gkod.Trace.Write(Gkod.Trace.ID.ODUT, "[ODUTILITY] : Gkod.Utility.Dom.GetElementsByNodeType2() frames length=" + t.length, 3); 
            for (var i = 0, ilength = t.length; i < ilength; i++) {
                if (Gkod.Utility.AccessGranted(t[i])) {
                    Gkod.Utility.Dom._GetElementsByNodeType(coll, t[i].document, type);
                }
            }
        }

        Gkod.Utility.Dom._GetElementsByNodeType = function(coll, node, type) {
            //Gkod.Trace.Write(Gkod.Trace.ID.ODUT, "[ODUTILITY] : Gkod.Utility.Dom._GetElementsByNodeType() type=" + type + " node = " + node.nodeName + " [" + node.nodeValue + "][" + node.nodeType + "]", 3); 
            if (node.nodeType == type) {
                coll.push(node);
            }
            if (node.hasChildNodes()) {
                var children = node.childNodes;
                for (var i = 0, ilength = children.length; i < ilength; i++) {
                    Gkod.Utility.Dom._GetElementsByNodeType(coll, children[i], type);
                }
            }
        }

        //Returns the requested windows in an array
        //If win is not defined it will return all windows below window.top
        //If win is defined, but top is undefined, it will return win
        //If win is defined and top is defined
        //top = false - it will return all windows below win
        //top = true - it will return all windows below win.top
        Gkod.Utility.Dom.FrameCollection = function(coll, win, top) {
            if ((typeof (coll)).toLowerCase() == 'object') {
                if ((typeof (win)).toLowerCase() == 'object') {
                    if (typeof (top) == 'undefined') {
                        coll.push(win);
                        return;
                    }
                }

                var _win = window.top;
                if (typeof (top) != 'undefined') {
                    if (top == false)
                        _win = win;
                    if (top == true)
                        _win = win.top;
                }
                Gkod.Utility.Dom._FrameCollection(coll, _win);
            }
        }

        Gkod.Utility.Dom._FrameCollection = function(coll, win) {
            if ((typeof (coll)).toLowerCase() == 'object') {
                if ((typeof (win)).toLowerCase() == 'object') {
                    coll.push(win);
                    var l = win.length;
                    for (var i = 0; i < l; i++) {
                        Gkod.Utility.Dom._FrameCollection(coll, win.frames[i]);
                    }
                }
            }
        }

        //Helper functions
        //The goal is to collect certain type of elements' given properties and match them to an array of properties
        //the third parameter is for in case of how many matches should the function return true
        //

        Gkod.Utility.Dom.MatchVariables = function(_window, _gkod_variables_temp, match, nocheck) { //set nocheck=true for objects
            var _gkod_match = 0;
            var _gkod_variables_temp_length = _gkod_variables_temp.length;
            for (var i = 0; i < _gkod_variables_temp_length; i++) {
                if (Gkod.Utility.AccessGranted(_window, nocheck)) {
                    Gkod.Trace.Write(Gkod.Trace.ID.ODUT, "[ODUTILITY] : Gkod.Utility.Dom.MatchVariables() " + _gkod_variables_temp[i] + " type = " + typeof (_window[_gkod_variables_temp[i]]), 3); 
                    if (typeof (_window[_gkod_variables_temp[i]]) != 'undefined') {
                        _gkod_match++;
                    }
                }
            }

            if (_gkod_match >= match) {
                return true;
            }
            return false;
        }

        Gkod.Utility.Dom.MatchFunctions = function(_window, _gkod_functions_temp, match) {
            var _gkod_match = 0;
            var _gkod_functions_temp_length = _gkod_functions_temp.length;
            for (var i = 0; i < _gkod_functions_temp_length; i++) {
                if (Gkod.Utility.AccessGranted(_window)) {
                    if (typeof (_window[_gkod_functions_temp[i]]) == 'function') {
                        //Gkod.Trace.Write(Gkod.Trace.ID.ODUT, "[ODUTILITY] : Gkod.Utility.Dom.MatchFunctions() " + _gkod_functions_temp[i] + " type = " + typeof(_window[_gkod_functions_temp[i]]), 3); 
                        _gkod_match++;
                    }
                }
            }

            if (_gkod_match >= match) {
                return true;
            }
            return false;
        }

        Gkod.Utility.Dom.MatchWindowNames = function(_window, _gkod_windownames_temp) {
            for (var i = 0, ilength = _gkod_windownames_temp.length; i < ilength; i++) {
                if (Gkod.Utility.AccessGranted(_window)) {
                    //Gkod.Trace.Write(Gkod.Trace.ID.ODUT, "[ODUTILITY] : Gkod.Utility.Dom.MatchWindowNames() _window.name = " + _window.name, 3); 
                    if (_window.name.indexOf(_gkod_windownames_temp[i]) > -1) {
                        return true;
                    }
                }
            }

            return false;
        }

        Gkod.Utility.Dom._MatchWindowNames = function(_gkod_windownames_temp, match) {
            var t = Gkod.Variables.ODWINDOWS;
            var _gkod_match = 0;
            //Gkod.Trace.Write(Gkod.Trace.ID.ODUT, "[ODUTILITY] : Gkod.Utility.Dom.FindFrameByName2() ODWINDOWS.length = " + ODWINDOWS.length, 3); 
            if (typeof (t) == 'undefined' || t.length == 0)
                return false;

            for (var i = 0; i < t.length; i++) {
                //Gkod.Trace.Write(Gkod.Trace.ID.ODUT, "[ODUTILITY] : Gkod.Utility.Dom.FindFrameByName2() window.name = [" + t[i].name + "] URL = [" + t[i].location.href + "]", 3); 
                for (var j = 0; j < _gkod_windownames_temp.length; j++) {
                    if (typeof (t[i].name) == 'string' && t[i].name == _gkod_windownames_temp[j]) {
                        _gkod_match++;
                    }
                }
            }
            if (_gkod_match >= match) {
                return true;
            }
            return false;
        }

        Gkod.Utility.Dom.MatchScriptNames = function(_window, _gkod_scripts_temp, match, _fullmatch) {
            try {
                var fullmatch = (typeof (_fullmatch) == 'undefined' ? true : _fullmatch); //default is true
                var _gkod_scriptelements = Gkod.Utility.Dom.GetElementsByTagName("script", _window);
                return Gkod.Utility.Dom._MatchScriptNames(_gkod_scriptelements, _gkod_scripts_temp, match, fullmatch);
            } catch (e) {
                Gkod.Utility.OnError('[ERROR] : Error in calling Gkod.Utility.Dom.MatchScriptNames()', e);
                throw (e);
            }
            return -1;
        }

        Gkod.Utility.Dom._MatchScriptNames = function(_gkod_scriptelements, _gkod_scripts_temp, match, fullmatch) {
            var _gkod_match = 0;
            for (var i = 0, ilength = _gkod_scriptelements.length; i < ilength; i++) {
                var _gkod_text = _gkod_scriptelements[i].src;
                if (_gkod_text != '') {
                    var _gkod_regexp = new RegExp('.*[/|\\\\]([^/|\\\\]*)\\.js');
                    var _gkod_result = _gkod_text.match(_gkod_regexp);
                    if (_gkod_result != null && _gkod_result.length > 1) {
                        if (_gkod_result[1] != null && _gkod_result[1].length > 0) {
                            Gkod.Trace.Write(Gkod.Trace.ID.ODUT, "[ODUTILITY] : Gkod.Utility.Dom.MatchScriptNames() script = " + _gkod_result[1] + " " + (fullmatch?" full":" partial"), 3);
                            for (var j = 0, jlength = _gkod_scripts_temp.length; j < jlength; j++) {
                                if (!fullmatch) {
                                    var k = _gkod_result[1].indexOf(_gkod_scripts_temp[j]);
                                    if (k > -1) {
                                        _gkod_match++;
                                    }
                                }
                                else {
                                    if (_gkod_result[1] == _gkod_scripts_temp[j]) {
                                        _gkod_match++;
                                    }
                                }
                            }
                        }
                    }
                }
            }

            if (_gkod_match >= match) {
                return true;
            }
            return false;
        }

        Gkod.Utility.Dom.MatchImageNames = function(_window, _gkod_images_temp, match) {
            var _gkod_imageelements = Gkod.Utility.Dom.GetElementsByTagName("img", _window);
            return Gkod.Utility.Dom._MatchImageNames(_gkod_imageelements, _gkod_images_temp, match);
        }

        Gkod.Utility.Dom._MatchImageNames = function(_gkod_imageelements, _gkod_images_temp, match) {
            var _gkod_match = 0;
            for (var i = 0, ilength = _gkod_imageelements.length; i < ilength; i++) {
                var _gkod_text = _gkod_imageelements[i].src;
                if (_gkod_text != '') {
                    var _gkod_regexp = new RegExp('.*[/|\\\\]([^/|\\\\]*)\\.gif');
                    var _gkod_result = _gkod_text.match(_gkod_regexp);
                    if (_gkod_result != null && _gkod_result.length > 1) {
                        if (_gkod_result[1] != null && _gkod_result[1].length > 0) {
                            Gkod.Trace.Write(Gkod.Trace.ID.ODUT, "[ODUTILITY] : Gkod.Utility.Dom.MatchImageNames() image = " + _gkod_result[1], 3);
                            for (var j = 0, jlength = _gkod_images_temp.length; j < jlength; j++) {
                                //var k = _gkod_result[1].indexOf(_gkod_images_temp[j]);
                                //if (k > -1) 
                                if (_gkod_result[1] == _gkod_images_temp[j]) {
                                    _gkod_match++;
                                }
                            }
                        }
                    }
                }
            }

            if (_gkod_match >= match) {
                return true;
            }
            return false;
        }

        Gkod.Utility.Dom.MatchStyleSheetNames = function(_window, _gkod_styles_temp, match, _fullmatch) {
            try {
                var fullmatch = (typeof (_fullmatch) == 'undefined' ? true : _fullmatch); //default is true
                var _gkod_styleelements = Gkod.Utility.Dom.GetElementsByTagName("link", _window);
                return Gkod.Utility.Dom._MatchStyleSheetNames(_gkod_styleelements, _gkod_styles_temp, match, fullmatch)
            } catch (e) {
                Gkod.Utility.OnError('[ERROR] : Error in calling Gkod.Utility.Dom.MatchStyleSheetNames()', e);
                throw (e);
            }
            return -1;
        }

        //searches first array, second is the pattern
        Gkod.Utility.Dom._MatchStyleSheetNames = function(_gkod_styleelements, _gkod_styles_temp, match, fullmatch) {
            var _gkod_match = 0;
            for (var i = 0, ilength = _gkod_styleelements.length; i < ilength; i++) {
                var _gkod_text = _gkod_styleelements[i].href;
                if (_gkod_text != '') {
                    var _gkod_regexp = new RegExp('.*[/|\\\\]([^/|\\\\]*)\\.[css|jsp]');
                    var _gkod_result = _gkod_text.match(_gkod_regexp);
                    if (_gkod_result != null && _gkod_result.length > 1) {
                        if (_gkod_result[1] != null && _gkod_result[1].length > 0) {
                            Gkod.Trace.Write(Gkod.Trace.ID.ODUT, "[ODUTILITY] : Gkod.Utility.Dom._MatchStyleSheetNames() style = " + _gkod_result[1] + " " + (fullmatch ? " full" : " partial"), 3);
                            for (var j = 0, jlength = _gkod_styles_temp.length; j < jlength; j++) {
                                if (!fullmatch) {
                                    var k = _gkod_result[1].indexOf(_gkod_styles_temp[j]);
                                    if (k > -1) {
                                        _gkod_match++;
                                    }
                                }
                                else {
                                    if (_gkod_result[1] == _gkod_styles_temp[j]) {
                                        _gkod_match++;
                                    }
                                }
                            }
                        }
                    }
                }
            }

            if (_gkod_match >= match) {
                return true;
            }
            return false;
        }

        Gkod.Utility.Dom.MatchComments = function(_window, _gkod_comments_temp, match) {
            var _gkod_commentelements = [];
            Gkod.Utility.Dom.GetElementsByNodeType(_gkod_commentelements, 8, _window);
            return Gkod.Utility.Dom._MatchComments(_gkod_commentelements, _gkod_comments_temp, match)
        }

        Gkod.Utility.Dom._MatchComments = function(_gkod_commentelements, _gkod_comments_temp, match) {
            var _gkod_match = 0;
            var _gkod_comments = "";
            for (var i = 0, ilength = _gkod_commentelements.length; i < ilength; i++) {
                var _gkod_text = _gkod_commentelements[i].nodeValue;
                if (_gkod_text != '') {
                    _gkod_comments += _gkod_text.toUpperCase();
                }
            }
            for (var j = 0, jlength = _gkod_comments_temp.length; j < jlength; j++) {
                var _gkod_arr = _gkod_comments_temp[j].toUpperCase();
                //Gkod.Trace.Write(Gkod.Trace.ID.ODUT, "[ODUTILITY] : Gkod.Utility.Dom._MatchComments() [" + _gkod_comments + "] [" + _gkod_arr + "]", 3); 
                var k = _gkod_comments.indexOf(_gkod_arr);
                if (k > -1) {
                    _gkod_match++;
                }
            }

            if (_gkod_match >= match) {
                return true;
            }

            return false;
        }

        Gkod.Utility.Dom.MatchAttribute = function(_window, attr, _gkod_attributes_temp, match) {
            var _gkod_match = 0;
            var _gkod_attributes_temp_length = _gkod_attributes_temp.length;
            for (var i = 0; i < _gkod_attributes_temp_length; i++) {
                if (Gkod.Utility.AccessGranted(_window)) {
                    var z = Gkod.Utility.Dom.GetElementsByAttribute(attr, _gkod_attributes_temp[i], _window);
                    if (z.length > 0) {
                        //Gkod.Trace.Write(Gkod.Trace.ID.ODUT, "[ODUTILITY] : Gkod.Utility.Dom._MatchStyleVariables() " + z + " type = " + typeof (_window[z[i]]), 3); 
                        _gkod_match++;
                    }
                }
            }

            if (_gkod_match >= match) {
                return true;
            }
            return false;
        }

        Gkod.Utility.Dom.MatchAttribute2 = function(_window, tagname, attr, _gkod_attributes_temp, match) {
            var _gkod_match = 0;
            var x = Gkod.Utility.Dom.GetElementsByTagName(tagname, _window);
            Gkod.Trace.Write(Gkod.Trace.ID.ODUT, "[ODUTILITY] : Gkod.Utility.Dom.MatchAttribute2() found " + x.length + ' ' + tagname, 3);
            var _gkod_attributes_temp_length = _gkod_attributes_temp.length;
            for (var i = 0; i < _gkod_attributes_temp_length; i++) {
                if (Gkod.Utility.AccessGranted(_window)) {
                    for (var j = 0; j < x.length; j++) {
                        var z = Gkod.Utility.Dom.GetAttribute(x[j], attr);
                        Gkod.Trace.Write(Gkod.Trace.ID.ODUT, "[ODUTILITY] : Gkod.Utility.Dom.MatchAttribute2() " + tagname + '[' + j + ']' + ' ' + attr + '=' + z, 3);
                        if (z == _gkod_attributes_temp[i]) {
                            _gkod_match++; 
                            break;
                        }
                    }
                }
            }

            if (_gkod_match >= match) {
                return true;
            }
            return false;
        }

        Gkod.Utility.Dom.FindFrame = function(frame) {
            var f = Gkod.Utility.Dom.FindElementById(frame);
            if (f) {
                return f;
            }
            return null;
        }

        Gkod.Utility.Dom.FindElementById = function(Id) {
            var mywin = window.top;
            if (!Gkod.Utility.AccessGranted(mywin))
                return null;
            var f = mywin.document.getElementById(Id);
            if (f != null) {
                return f;
            }
            for (var i = 0; i < mywin.length; i++) {
                f = Gkod.Utility.Dom.FindElement(mywin.frames[i], Id);
                if (f != null) {
                    return f;
                }
            }
            return null;
        }

        Gkod.Utility.Dom.FindElement = function(frame, Id) {
            // frames with certain plugins (word, excel) will cause a js error because the frame document doesn't exist
            if (!Gkod.Utility.AccessGranted(frame)) {
                return null;
            }

            var f = null;
            try {
                f = frame.document.getElementById(Id);
            }
            catch (ex) {
                // Ignore this frame if we can't access it.
            }

            if (f != null) {
                return f;
            }

            for (var i = 0; i < frame.length; i++) {
                f = Gkod.Utility.Dom.FindElement(frame.frames[i], Id);
                if (f != null) {
                    return f;
                }
            }
            return null;
        }

        //This should work in IE, Firefox and Opera
        Gkod.Utility.Dom.GetParentWindow = function(_document) {
            return _document.parentWindow ? _document.parentWindow : _document.defaultView;
        }

        Gkod.Utility.Dom.GetInnerText = function(_object) {
            return (_object.innerText) ? _object.innerText : (_object.textContent) ? _object.textContent : "";
        }

        Gkod.Utility.Dom.GetInnerText2 = function(_object) {
            if (_object.firstChild)
                return _object.firstChild.nodeValue;

            return "";
        }

        //******
        //String
        //******
        Gkod.Utility.String.leftTrim = function(sString) {
            while (sString.substring(0, 1) == ' ') {
                sString = sString.substring(1, sString.length);
            }
            return sString;
        }

        Gkod.Utility.String.rightTrim = function(sString) {
            while (sString.substring(sString.length - 1, sString.length) == ' ') {
                sString = sString.substring(0, sString.length - 1);
            }
            return sString;
        }

        Gkod.Utility.String.trimAll = function(sString) {
            //FF textContent has the weird characters - 10, 160
            while (sString.substr(0, 1) == " " || sString.charCodeAt(0) == 9 || sString.charCodeAt(0) == 10 || sString.charCodeAt(0) == 160) {
                sString = sString.substr(1, sString.length - 1);
            }
            while (sString.substr(sString.length - 1, sString.length) == " " || sString.charCodeAt(sString.length - 1) == 9 || sString.charCodeAt(sString.length - 1) == 10 || sString.charCodeAt(sString.length - 1) == 160) {
                sString = sString.substr(0, sString.length - 1);
            }
            return sString;
        }

        Gkod.Utility.Dom.Contains = function(e1, e2) {
            var e = e2;
            while (e) {
                if (e == e1)
                    break;

                e = e.parentNode;
            }

            if (e)
                return true;

            return false;
        }

        Gkod.Utility.Dom.GetInfoNeededByTagName = function(doc, taglist) {
            if (taglist.length == 0 || typeof (doc) == 'undefined')
                return "";

            var sRet = "";
            if (typeof (doc.all) != 'undefined' && doc.all.length > 0) {
                var lcc = [];
                var lastcontainer;

                //Put in a list the tag-collections that are needed
                for (var i = 0; i < taglist.length; i++) {
                    var combcoll = {};
                    combcoll.curindex = 0;
                    combcoll.cursrcndx = 0;
                    combcoll.lengthcoll = 0;
                    combcoll.curelement = doc.all[0];
                    combcoll.collection = doc.getElementsByTagName(taglist[i]);

                    combcoll.lengthcoll = combcoll.collection.length;
                    if (combcoll.lengthcoll > 0) {
                        combcoll.curelement = combcoll.collection.item(0);
                        combcoll.cursrcndx = combcoll.curelement.sourceIndex;
                        lcc.push(combcoll);
                    }
                }

                var iAct = lcc.length - 1;
                while (iAct > -1) {
                    var combcoll = lcc[iAct];
                    for (var i = 0; i < lcc.length; i++)
                        if (lcc[i].cursrcndx < combcoll.cursrcndx) {
                        iAct = i;
                        combcoll = lcc[iAct];
                    }

                    var element = combcoll.curelement;

                    if (++(combcoll.curindex) < combcoll.lengthcoll) {
                        combcoll.curelement = combcoll.collection.item(combcoll.curindex);
                        combcoll.cursrcndx = combcoll.curelement.sourceIndex;
                    }
                    else {
                        var iLast = lcc.length - 1;
                        if (iAct != iLast)
                            lcc[iAct] = lcc[iLast];
                        lcc.pop();
                        iAct = lcc.length - 1;
                    }

                    if (typeof (lastcontainer) != 'undefined') {
                        if (Gkod.Utility.Dom.Contains(lastcontainer, element))
                            continue;
                    }

                    if (sRet != "")
                        sRet += " ";
                    sRet += element.outerHTML;

                    lastcontainer = element;
                }
            }

            return sRet;
        }

        Gkod.Utility.Dom.GetInfoNeededByClassName = function(doc, tag, classlist) {
            if (classlist.length == 0 || typeof (doc) == 'undefined')
                return "";

            var sRet = "";
            if (typeof (doc.all) != 'undefined' && doc.all.length > 0) {
                var tags = doc.getElementsByTagName(tag);
                if (typeof (tags) != 'undefined') {
                    var lastcontainer;

                    var i;
                    for (i = 0; i < classlist.length; i++)
                        classlist[i].toUpperCase(); //because of the insensitive wcsicmp

                    for (var j = 0; j < tags.length; j++) {
                        var element = tags.item(j);

                        var classname = element.className;
                        classname.toUpperCase(); //because of the insensitive wcsicmp

                        for (i = 0; i < classlist.length; i++)
                            if (classname == classlist[i])
                            break;

                        if (i == classlist.length)
                            continue;

                        if (typeof (lastcontainer) != 'undefined') {
                            if (Gkod.Utility.Dom.Contains(lastcontainer, element))
                                continue;
                        }

                        if (sRet != "")
                            sRet += " ";
                        sRet += element.outerHTML;

                        lastcontainer = element;
                    }
                }
            }

            return sRet;
        }

        Gkod.Utility.Dom.FindFrameByName = function(win, nam) {
            if (typeof (win.name) == 'string' && win.name == nam)
                return win.document;

            var len = 0;
            var subframes = win.frames;
            if (subframes)
                len = subframes.length;
            for (var i = 0; i < len; i++) {
                var doc = Gkod.Utility.Dom.FindFrameByName(subframes[i], nam);
                if (doc)
                    return doc;
            }

            return null;
        }

        Gkod.Utility.Dom.FindFrameByName2 = function(name) {
            var t = Gkod.Variables.ODWINDOWS;
            //Gkod.Trace.Write(Gkod.Trace.ID.ODUT, "[ODUTILITY] : Gkod.Utility.Dom.FindFrameByName2() ODWINDOWS.length = " + ODWINDOWS.length, 3); 
            if (typeof (t) == 'undefined' || t.length == 0)
                return null;
            for (var i = 0; i < t.length; i++) {
                //Gkod.Trace.Write(Gkod.Trace.ID.ODUT, "[ODUTILITY] : Gkod.Utility.Dom.FindFrameByName2() window.name = [" + t[i].name + "] URL = [" + t[i].location.href + "]", 3); 
                if (typeof (t[i].name) == 'string' && t[i].name == name)
                    return t[i].document;
            }
            return null;
        }

        //Get the text next to 'iPattern' from reverse, e.g "...\ps\cache\kanji.gif" = kanji.gif
        Gkod.Utility.GetStringAfter = function(sStr, sPattern) {
            if (sStr != "") {
                var i = sStr.lastIndexOf(sPattern);
                if (i != -1)
                    sStr = sStr.substr(i + 1, sStr.length - i - 1);
            }

            return sStr;
        }

        Gkod.Utility.Dom.GetAttribute = function(element, attr) {
            if (attr == 'className') {
                if (!Gkod.Utility.IsIE())
                    attr = "class";
            }

            return element.getAttribute(attr);
        }

        Gkod.Utility.Dom.GetPosition = function(cell) {
            var ret = 0;
            while (cell) {
                ret++;
                var temp = cell;
                temp = cell.previousSibling;
                cell = temp;
            }
            return ret;
        }

        Gkod.Utility.Dom.GetXthSiblingFromChild = function(pos, header) {
            //Gkod.Trace.Write(Gkod.Trace.ID.CTX, "Gkod.Application.Sapcrm07.GetXthSiblingFromChild() pos = " + pos + " header = " + header, 3);
            var ret = null;
            var i = 1;
            if (header) {
                var child = header.firstChild;
                if (child)
                    ret = child;
                //Gkod.Trace.Write(Gkod.Trace.ID.CTX, "Gkod.Application.Sapcrm07.GetXthSiblingFromChild() child = " + child.tagName, 3);
                while (child && i < pos) {
                    var temp = child.nextSibling;
                    if (temp) {
                        i++;
                    }
                    child = temp;
                    if (child)
                        ret = child;
                }
            }
            return ret;
        }


        Gkod.Utility.Text.FindSubString = function(sPattern, sString, sEnd) {
            var sResult = '';
            if (sString.length == 0 || sPattern.length == 0)
                return sResult;

            sString.toLowerCase();
            sPattern.toLowerCase();

            var l = sString.length;
            var ll = sPattern.length;

            var i = sString.indexOf(sPattern);
            var j = 0;

            if (i != -1) {
                if (sEnd.length > 0) {
                    sEnd.toLowerCase();
                    j = sString.indexOf(sEnd, i);
                    if (j == -1)
                        j = l;
                }
                else {
                    j = l;
                }

                if (j != -1) {
                    sResult = sString.substr(i + ll, j - i - ll);
                }
            }
            sResult.toUpperCase();

            return sResult;
        }
    }
} catch (e) {
    if (typeof (Gkod) == 'object' && typeof (Gkod.Utility) == 'object' && typeof (Gkod.Utility.OnError) == 'function')
        Gkod.Utility.OnError('[ODUTILITES] : Error loading odutilities.js', e);
}