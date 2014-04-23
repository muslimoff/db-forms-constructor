//odrbb.js

/*--
Copyright © 1998, 2009, Oracle and/or its affiliates.  All rights reserved.
--*/

//<!--Version 9.6.0.3-->

/// <reference path=oddefs.js />

Gkod.Trace.Write(Gkod.Trace.ID.LOAD, '[ODRBB] : odrbb.js is loaded into window.name = [' + window.name + '] URL = [' + window.location.href + ']', 3); 
Gkod.Modules.Register('odrbb');

Gkod.RBB =
{
    //Either there is a function returning the context, or a variable bearing it
    CtxFunction: '',
    CtxVariable: '',
    CtxWindow: null,
    CtxParts: [],
    _CtxFunction: null,
    AppName: '',
    RecognitionFunction: '',
    RecognitionVariable: '',
    RecognitionWindow: null,
    RecognitionParts: [],
    _RecognitionFunction: null,

    GetContext: function() {
        if (this._CtxFunction != null)
            return this._CtxFunction();

        return '';
    },

    GetRecognition: function() {
        if (this._RecognitionFunction != null)
            return this._RecognitionFunction();

        return false;
    },

    FindProperty: function(obj) {
        var t = [];
        Gkod.Utility.Dom.FrameCollection(t);
        for (var i = 0; i < t.length; i++) {
            var _gkod_window_ = t[i];
            if (Gkod.Utility.AccessGranted(_gkod_window_)) {
                if (this.IsPropertyExists(_gkod_window_, obj)) {
                    return _gkod_window_;
                }
            }
        }
        return null;
    },

    IsPropertyExists: function(win, obj) {
        var result = true;
        var temp = win;
        for (var k = 0; k < obj.length; k++) {
            //Gkod.Trace.Write(Gkod.Trace.ID.DEF, '[RBB2RTR] : IsPropertyExists() ' + obj[k] + ' ' + typeof(temp[obj[k]]), 3);
            if (typeof (temp[obj[k]]) == 'undefined' || typeof (temp[obj[k]]) == 'unknown') {
                result = false;
                break;
            }
            temp = temp[obj[k]];
        }

        return result;
    },

    ExecuteProperty: function(win, obj) {
        var result = true;
        var temp = win;
        for (var k = 0; k < obj.length; k++) {
            if (typeof (temp[obj[k]]) == 'undefined' || typeof (temp[obj[k]]) == 'unknown') {
                return null;
            }
            temp = temp[obj[k]];
        }

        return temp;
    },

    ExecuteFunction: function(win, obj) {
        return win.eval(obj + '()');
    },

    MakeParts: function(str) {
        var ret = [];
        ret = str.split('.');

        if (ret.length == 0)
            ret.push(str);

        return ret;
    },

    Initialize: function() {
        try {
            if (this.CtxFunction != '' || this.CtxVariable != '') {
                if (this.CtxFunction == '') {
                    this._CtxFunction = function() { return this.ExecuteProperty(this.CtxWindow, this.CtxParts); };
                    this.CtxParts = this.MakeParts(this.CtxVariable);
                    this.CtxWindow = this.FindProperty(this.CtxParts);
                }
                else {
                    this._CtxFunction = function() { return this.ExecuteFunction(this.CtxWindow, this.CtxFunction); };
                    this.CtxParts = this.MakeParts(this.CtxFunction);
                    this.CtxWindow = this.FindProperty(this.CtxParts);
                }
            }

            if (this.RecognitionFunction != '' || this.RecognitionVariable != '') {
                if (this.RecognitionFunction == '') {
                    this._RecognitionFunction = function() { return this.ExecuteProperty(this.RecognitionWindow, this.RecognitionParts); };
                    this.RecognitionParts = this.MakeParts(this.RecognitionVariable);
                }
                else {
                    this._RecognitionFunction = function() { return this.ExecuteFunction(this.RecognitionWindow, this.RecognitionFunction); };
                    this.RecognitionParts = this.MakeParts(this.RecognitionFunction);
                }
                this.RecognitionWindow = this.FindProperty(this.RecognitionParts);
            }
        } catch (e) {
            Gkod.Utility.OnError('[RBB2RTR] : Initialize()', e);
        }
    },

    SetCtxFunction: function(str) {
        this.CtxFunction = str;
    },
    SetCtxVariable: function(str) {
        this.CtxVariable = str;
    },
    SetRecognitionFunction: function(str) {
        this.RecognitionFunction = str;
    },
    SetRecognitionVariable: function(str) {
        this.RecognitionVariable = str;
    },
    SetAppName: function(str) {
        this.AppName = str;
    },

    IsOwnApplication: function() {
        var ret = false;
        if (this.CtxVariable == '' && this.CtxFunction != '' && this.CtxWindow != null)
            ret = true;
        else if (this.CtxVariable != '' && this.CtxFunction == '' && this.CtxWindow != null)
            ret = true;
        else if (this.Recognition != '' && this.RecognitionWindow != null)
            ret = true;

        return ret;
    },

    GetApplicationName: function() {
        return this.AppName;
    },

    GetContextID: function() {
        return this.GetContext();
    }
}
