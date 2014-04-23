/*--
Copyright © 1998, 2009, Oracle and/or its affiliates.  All rights reserved.
--*/

// -----------------------------------------------------------------------------
// Globals
// Version of Flash required
var requiredFlashVersion = "9.0.124";

var _name = "";
var _asyn = false;
var _audio = false;
var _fire = false;
var _knowpalyer = false;
// -----------------------------------------------------------------------------
// -->

if (navigator.platform == "MacPPC" && navigator.userAgent.indexOf("Safari") >= 0) {
    requiredFlashVersion = "7.0.14";
}

var bPlayerIsAvailable = false;

//////////////////////////////////////////////////////////////////////////////////////////////////////

document.write("<div id='fplayer'></div>");

var hasRequestedVersion = swfobject.hasFlashPlayerVersion(requiredFlashVersion);

if (hasRequestedVersion) {
    bPlayerIsAvailable = true;
    swfobject.embedSWF("../../js/sound/fplayer.swf", "fplayer", "0", "0", requiredFlashVersion, null, null, null, null, onLoadFlash);
}


function onLoadFlash(e) {
    document.getElementById("fplayer").style.position = "absolute";
}

//////////////////////////////////////////////////////////////////////////////////////////////////////

function Sound_Init(exported, audioPref, closerFunction) {
    if (hasRequestedVersion == false) {
        var showWarning = false;
        //        if (playMode == "S") {
        if (audioPref != "none")
            showWarning = true;
        //        }
        //        else {
        //            if (exported == true && audioPref != "none")
        //                showWarning = true;
        //        }
        if (showWarning == true) {
            eval(closerFunction);
            sw = (screen.width - 640) / 2;
            sh = (screen.height - 480) / 2;
            window.open("../../js/sound/getflash.html", "", "top=" + sh + ", left=" + sw + ", width=640, height=480, resizable=1,toolbar=1,scrollbars=1,location=1,statusbar=1,menubar=1,fullscreen=0");
            return false;
        }
    }
    return true;
}

function SoundPlayerClass() {
    this.TopicPath = unescape(window.location.href);
    while (this.TopicPath.indexOf('\\') != -1)
        this.TopicPath = this.TopicPath.replace('\\', '/');

    var i = this.TopicPath.indexOf("?");
    if (i >= 0)
        this.TopicPath = this.TopicPath.substr(0, i);
    i = this.TopicPath.lastIndexOf("/");
    this.TopicPath = this.TopicPath.substr(0, i + 1);

    this.RootPath = this.TopicPath;
    for (var j = 0; j <= 3; j++) {
        i = this.RootPath.lastIndexOf("/");
        if (i != -1)
            this.RootPath = this.RootPath.substr(0, i);
    };
    this.RootPath = this.RootPath + '/';
    this.SoundPath = this.TopicPath;
    this.AudioPath = resolveUri(this.TopicPath, "../../audio/");
}

function resolveUri(s1, s2) {
    return (s1 + s2);
    l = s1.length - 1;
    if (s1.substr(l) == "/")
        s1 = s1.substr(0, l);
    k = (s2.substr(0, 3) == "../");
    while (k) {
        s2 = s2.substr(3);
        k1 = s1.lastIndexOf("/");
        s1 = s1.substr(0, k1);
        k = (s2.substr(0, 3) == "../");
    }
    return s1 + "/" + s2;
}

SoundPlayerClass.prototype.Play = function(sndfile, audiofile, templatefile, asyncron) {

    if (!asyncron)
        asyncron = false;

    if (!bPlayerIsAvailable) {
        if (asyncron == false)
            OnErrorPlaySound();
        return;
    }

    if (!templatefile)
        templatefile = false;
    if (templatefile == true) {
        if (asyncron == false)
            OnEndPlaySound();
        return;
    }

    if (sndfile.length == 0) {
        if (asyncron == false)
            OnErrorPlaySound();
        return;
    }

    if (sndfile.substr(sndfile.length - 4) == ".ASX") {
        sndfile = sounds[sndfile].flist[0];
    };

    SoundPlayer_Stop();
    if (sndfile.length == 0) {
        if (asyncron == false)
            OnErrorPlaySound();
        return;
    }

    fname = (audiofile ? resolveUri(this.AudioPath, sndfile) : resolveUri(this.SoundPath, sndfile));

    _name = fname;
    _asyn = asyncron;
    _audio = audiofile;
    _fire = true;
    if (_knowpalyer == true) setTimeout("SoundPlayer_Open(\"" + fname + "\"," + asyncron + "," + _audio + ")", 120);
}

SoundPlayerClass.prototype.Stop = function() {
    if (bPlayerIsAvailable) {
        setTimeout("SoundPlayer_Stop()", 10);
    };
}

SoundPlayerClass.prototype.Pause = function() {
    if (bPlayerIsAvailable) {
        document.getElementById("fplayer").SoundPause();
    }
}

SoundPlayerClass.prototype.Resume = function() {
    if (bPlayerIsAvailable) {
        document.getElementById("fplayer").SoundPlay();
    }
}

SoundPlayerClass.prototype.IsAvailable = function() {
    return bPlayerIsAvailable;
};

SoundPlayerClass.prototype.SetSoundPath = function(s) {
    if (s.length > 0)
        this.SoundPath = s;
};

var _lastAsyncronFile = false;
var _lastAudioFile = false;

function SoundPlayer_Open(fname, asyncron, audio) {
    try {
        if (fname.length > 0 && asyncron == true)
            _lastAsyncronFile = true;
        document.getElementById("fplayer").SetSoundFile(fname);
        document.getElementById("fplayer").SoundPlay();
    }
    catch (e) {
        if (asyncron == false)
            OnErrorPlaySound();
        return;
    }
    _lastAudioFile = audio;
    if (audio == true)
        setTimeout("OnEndPlaySound()", 400);
}

function SoundPlayer_Stop() {
    try {
        _lastAsyncronFile = false;
        document.getElementById("fplayer").SoundStop();
    }
    catch (e) { }
}

function OnFlashLoad() {
    if (_fire == true) setTimeout("SoundPlayer_Open(\"" + _name + "\"," + _asyn + "," + _audio + ")", 20);
    _fire_ = false;
    _knowpalyer = true;
}

function SoundComplete() {
    if (_lastAsyncronFile) {
        _lastAsyncronFile = false;
        return;
    }
    if (_lastAudioFile == true)
        return;
    s = document.getElementById("fplayer").SoundState();
    if (s == "notfoundfile") {
        OnErrorPlaySound();
    }
    else if (s == "complete") {
        OnEndPlaySound();
    }
}

var SoundPlayerObj = new SoundPlayerClass();

