
document.write('<script src="../../js/sound/swfobject.js"></script>');
document.write('<script src="../../js/sound.js"></script>');
document.write('<script src="../../js/cookie.js"></script>');
document.write('<script src="../../js/preferences.js"></script>');
document.write('<script src="../../js/resource.js"></script>');

if (navigator.userAgent.indexOf("MSIE 6") >= 0) {
    document.write('<link href="../../css/websoundie6.css" rel="stylesheet" type="text/css" />');
}
else {
    document.write('<link href="../../css/websound.css" rel="stylesheet" type="text/css" />');
}

var playMode = "";

var _sound_installed = false;

function Init() {

    if (hassound == false) {
        return;
    }

    if (UserPrefs.PlayAudio != "all") {
        return;
    }

    _sound_installed = Sound_Init(true, UserPrefs.PlayAudio);
    if (_sound_installed == false) {
        return;
    }

    var odsdiv = document.getElementById("odsounddiv");
    odsdiv.className = "playerCombination";
    var s = '<div id="odsounddivctrl">';
    s += '<div id="odsVol">' + R_sound_sound + '</div>';
    s += '<div id="odsPlay" class="odsounddivclass playerCombination" title="' + R_sound_play + '" onclick="playPauseClicked();">';
    s += '<div id="playimg" ></div>';
    s += '</div>';
    s += '<div id="odsPause" class="odsounddivclass playerCombination" title="' + R_sound_pause + '" onclick="playPauseClicked();">';
    s += '<div id="pauseimg" ></div>';
    s += '</div>';
    s += '<div id="odsStop" class="odsounddivclass playerCombination" title="' + R_sound_stop + '" onclick="stopClicked();">';
    s += '<div id="stopimg" ></div>';
    s += '</div>';
    s += '</div>';
    odsdiv.innerHTML = s;
    odsdiv.style.display = "block";
    _ResizeSoundControls();
    _Resize();
    window.onresize = _Resize;
    window.onscroll = _Scrolled;
    setTimeout("PlaySound_Init()", 100);
}

function _ResizeSoundControls() {
    var volWidth = document.getElementById("odsVol").clientWidth;
    document.getElementById("odsPlay").style.left = "" + (volWidth + 3) + "px";
    document.getElementById("odsPause").style.left = "" + (volWidth + 3) + "px";
    var btnWidth = document.getElementById("odsPlay").clientWidth;
    document.getElementById("odsStop").style.left = "" + (volWidth + btnWidth + 6) + "px";
}

function _Resize() {
    var cw = document.getElementById("odsounddiv").clientWidth;
    var ctrlx = document.getElementById("odsVol").clientWidth;
    ctrlx += document.getElementById("odsPlay").clientWidth;
    ctrlx += document.getElementById("odsStop").clientWidth;
    ctrlx += 10;
    var xpos = Math.round((cw - ctrlx) / 2);
    try {
        document.getElementById("odsounddivctrl").style.left = "" + xpos + "px";
    }
    catch (e) { };
}

function getScrollX() {
    var x1 = 0;
    var x2 = 0;
    if (document.body) {
        x1 = document.body.scrollLeft;
    }
    if (document.documentElement) {
        x2 = document.documentElement.scrollLeft;
    }
    return (x1 > 0 ? x1 : x2);
}

function _Scrolled(event) {
    scrLeft = getScrollX();
    document.getElementById("odsounddiv").style.left = "" + scrLeft + "px";
}

var pstatus = 0;

function SaveAutoPlaybackValue(v) {
    var k= (v ? "true" : "false");
    var c = UserPrefs.GetCookie();
    c.Load();
    c.WebPageAutoPlayback = k;
    c.Store();
    if (c.Load()==true)
        UserPrefs.WebPageAutoPlayback = v;
}

function playPauseClicked() {
    SaveAutoPlaybackValue(true);
    _Play();
}

function _Play() {
    if (pstatus == 0) {
        SoundPlayerObj.Play("./sound/sound.flv");
        document.getElementById("odsPlay").style.display = "none";
        document.getElementById("odsPause").style.display = "block";
        pstatus = 1;
    }
    else if (pstatus == 1) {
        SoundPlayerObj.Pause();
        document.getElementById("odsPlay").style.display = "block";
        document.getElementById("odsPause").style.display = "none";
        pstatus = 2;
    }
    else {
        SoundPlayerObj.Resume();
        document.getElementById("odsPlay").style.display = "none";
        document.getElementById("odsPause").style.display = "block";
        pstatus = 1;
    }
}

function stopClicked() {
    _Stop();
    SaveAutoPlaybackValue(false);
}

function _Stop() {
    SoundPlayerObj.Stop();
    document.getElementById("odsPlay").style.display = "block";
    document.getElementById("odsPause").style.display = "none";
    pstatus = 0;
}

function OnEndPlaySound() {
    _Stop()
}

function OnErrorPlaySound() {
    _Stop();
}

function Sound_Stop() {
    try {
        _Stop();
    }
    catch (e) { };
}

function PlaySound_Init() {
    if (_sound_installed == false)
        return;
    try {
        if (parent.PlayConceptSound() == false)
            return;
    }
    catch (e) { };
    if (UserPrefs.WebPageAutoPlayback == "true" || UserPrefs.WebPageAutoPlayback == true) {
        _Stop();
        _Play();
    }
}
