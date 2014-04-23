/*--
Copyright © 1998, 2009, Oracle and/or its affiliates.  All rights reserved.
--*/

function UserPreferences() {
    this.EnablePreferences = true;
    this.TimeStamp = "000000000000";
    this.PlayAudio = "all";
    this.ShowLeadIn = "all";
    this.MarqueeColor = "red";
    this.TryIt = new Object;
    this.TryIt.EnableSkipping = true;
    this.DoIt = new Object
    this.DoIt.HotKey = new Object;
    this.DoIt.HotKey.Ctrl = "L";
    this.DoIt.HotKey.Shift = "N";
    this.DoIt.HotKey.Alt = "L";
    this.DefaultPlayMode = "S";
    this.Tutorial_DontShow_TOC = false;
    this.Tutorial_DontShow_SeeIt = false;
    this.Tutorial_DontShow_TryIt = false;
    this.Tutorial_DontShow_KnowIt = false;
    this.Tutorial_DontShow_DoIt = false;
    this.WebPageAutoPlayback = true;
}

UserPreferences.prototype.Copy = function(src) {
    this.TimeStamp = src.TimeStamp;
    this.PlayAudio = src.PlayAudio;
    this.ShowLeadIn = src.ShowLeadIn;
    this.MarqueeColor = src.MarqueeColor;
    this.TryIt.EnableSkipping = src.TryIt.EnableSkipping;
    this.DoIt.HotKey.Ctrl = src.DoIt.HotKey.Ctrl;
    this.DoIt.HotKey.Shift = src.DoIt.HotKey.Shift;
    this.DoIt.HotKey.Alt = src.DoIt.HotKey.Alt;
    this.DefaultPlayMode = src.DefaultPlayMode;
    this.Tutorial_DontShow_TOC = src.Tutorial_DontShow_TOC;
    this.Tutorial_DontShow_SeeIt = src.Tutorial_DontShow_SeeIt;
    this.Tutorial_DontShow_TryIt = src.Tutorial_DontShow_TryIt;
    this.Tutorial_DontShow_KnowIt = src.Tutorial_DontShow_KnowIt;
    this.Tutorial_DontShow_DoIt = src.Tutorial_DontShow_DoIt;
    this.WebPageAutoPlayback = src.WebPageAutoPlayback;
}

UserPreferences.prototype.Compare = function(src) {
    if (this.PlayAudio != src.PlayAudio) return true;
    if (this.ShowLeadIn != src.ShowLeadIn) return true;
    if (this.MarqueeColor != src.MarqueeColor) return true;
    if (this.TryIt.EnableSkipping != src.TryIt.EnableSkipping) return true;
    if (this.DoIt.HotKey.Ctrl != src.DoIt.HotKey.Ctrl) return true;
    if (this.DoIt.HotKey.Shift != src.DoIt.HotKey.Shift) return true;
    if (this.DoIt.HotKey.Alt != src.DoIt.HotKey.Alt) return true;
    if (this.DefaultPlayMode != src.DefaultPlayMode) return true;
    if (this.Tutorial_DontShow_TOC != src.Tutorial_DontShow_TOC) return true;
    if (this.Tutorial_DontShow_SeeIt != src.Tutorial_DontShow_SeeIt) return true;
    if (this.Tutorial_DontShow_TryIt != src.Tutorial_DontShow_TryIt) return true;
    if (this.Tutorial_DontShow_KnowIt != src.Tutorial_DontShow_KnowIt) return true;
    if (this.Tutorial_DontShow_DoIt != src.Tutorial_DontShow_DoIt) return true;
    if (this.WebPageAutoPlayback != src.WebPageAutoPlayback) return true;
    return false;
}

UserPreferences.prototype.GetCookie = function() {
    return new Cookie(document, "OnDemandPlayer", 365, "/");
}

UserPreferences.prototype.LoadCookie = function() {
    var cookie = this.GetCookie();
    cookie.Load();
    if (UserPrefs.TimeStamp != "000000000000" && (!cookie.TimeStamp || UserPrefs.TimeStamp > cookie.TimeStamp))
        return;

    if (cookie.PlayAudio)
        this.PlayAudio = cookie.PlayAudio;
    if (cookie.ShowLeadIn)
        this.ShowLeadIn = cookie.ShowLeadIn;
    if (cookie.MarqueeColor)
        this.MarqueeColor = cookie.MarqueeColor;
    if (cookie.TryIt_EnableSkipping)
        this.TryIt.EnableSkipping = (cookie.TryIt_EnableSkipping == "true");
    if (cookie.DoIt_HotKey_Ctrl)
        this.DoIt.HotKey.Ctrl = cookie.DoIt_HotKey_Ctrl;
    if (cookie.DoIt_HotKey_Shift)
        this.DoIt.HotKey.Shift = cookie.DoIt_HotKey_Shift;
    if (cookie.DoIt_HotKey_Alt)
        this.DoIt.HotKey.Alt = cookie.DoIt_HotKey_Alt;
    if (cookie.DefaultPlayMode)
        this.DefaultPlayMode = cookie.DefaultPlayMode;
    if (cookie.Tutorial_DontShow_TOC)
        this.Tutorial_DontShow_TOC = cookie.Tutorial_DontShow_TOC;
    if (cookie.Tutorial_DontShow_SeeIt)
        this.Tutorial_DontShow_SeeIt = cookie.Tutorial_DontShow_SeeIt;
    if (cookie.Tutorial_DontShow_TryIt)
        this.Tutorial_DontShow_TryIt = cookie.Tutorial_DontShow_TryIt;
    if (cookie.Tutorial_DontShow_KnowIt)
        this.Tutorial_DontShow_KnowIt = cookie.Tutorial_DontShow_KnowIt;
    if (cookie.Tutorial_DontShow_DoIt)
        this.Tutorial_DontShow_DoIt = cookie.Tutorial_DontShow_DoIt;
    if (cookie.WebPageAutoPlayback)
        this.WebPageAutoPlayback = cookie.WebPageAutoPlayback;
}

UserPreferences.prototype.GetUrlParamString = function() {
    return "PP_SOUND=" + this.PlayAudio +
		"&PP_LEADIN=" + this.ShowLeadIn +
		"&PP_SKIP=" + (this.TryIt.EnableSkipping ? "true" : "false") +
		"&PP_MARQUEE=" + this.MarqueeColor +
		"&PP_ENABLE=" + (this.EnablePreferences ? "true" : "false") +
		"&PP_HOTKEY=" + this.DoIt.HotKey.Ctrl + this.DoIt.HotKey.Shift + this.DoIt.HotKey.Alt;
}

UserPreferences.prototype.ParseUrlParamString = function(param_str) {
    var params = param_str.split('&');
    for (var p = 0; p < params.length; p++) {
        var paritem = params[p].split("=");
        if (paritem[0].toUpperCase() == "PP_SOUND")
            this.PlayAudio = paritem[1];
        else if (paritem[0].toUpperCase() == "PP_LEADIN")
            this.ShowLeadIn = paritem[1];
        else if (paritem[0].toUpperCase() == "PP_MARQUEE")
            this.MarqueeColor = paritem[1];
        else if (paritem[0].toUpperCase() == "PP_SKIP")
            this.TryIt.EnableSkipping = (paritem[1] == "true");
        else if (paritem[0].toUpperCase() == "PP_ENABLE")
            this.EnablePreferences = (paritem[1] == "true");
        else if (paritem[0].toUpperCase() == "PP_HOTKEY") {
            this.DoIt.HotKey.Ctrl = paritem[1].charAt(0);
            this.DoIt.HotKey.Shift = paritem[1].charAt(1);
            this.DoIt.HotKey.Alt = paritem[1].charAt(2);
        }
    }
}

var UserPrefs = new UserPreferences();

if (window.SetDefaultPreferences)
    SetDefaultPreferences();
if (UserPrefs.EnablePreferences)
    UserPrefs.LoadCookie();

var paramstr = unescape(document.location.hash.substring(1));
if (paramstr == "")
    paramstr = unescape(document.location.search.substring(1));

if (UserPrefs.EnablePreferences)
    UserPrefs.LoadCookie();

UserPrefs.ParseUrlParamString(paramstr);

function OpenPreferencesDialog(path, nosound, seeitonly) {
    if (!UserPrefs.EnablePreferences)
        alert(R_preferences_disabled);
    else {
        var p = path + "/preferences/preferences.html";
        h = 402;
        if (nosound && seeitonly) {
            p += "?nosound&seeitonly";
            h = 200;
        }
        if (!nosound && seeitonly) {
            p += "?seeitonly";
            h = 200;
        }
        if (nosound && !seeitonly) {
            p += "?nosound";
        }
        window.open(p, "prefwin", "width=500,height=" + h + ",resizable=1,scrollbars=0,top=" + (screen.availHeight - 290) / 2 + ",left=" + (screen.availWidth - 500) / 2);
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////

function UserRolesClass() {
    this.Filtering = false;
    this.Roles = new Array;
}

UserRolesClass.prototype.Copy = function(src) {
    this.Filtering = src.Filtering;
    this.Roles = new Array;
    for (var r = 0; r < src.Roles.length; r++)
        this.Roles[r] = src.Roles[r];
}

UserRolesClass.prototype.Compare = function(src) {
    if (this.Filtering != src.Filtering) return true;
    if (this.Roles.length != src.Roles.length) return true;
    for (var r = 0; r < this.Roles.length; r++) {
        if (this.Roles[r] != src.Roles[r]) return true;
    }
    return false;
}

UserRolesClass.prototype.GetCookie = function() {
    return new Cookie(document, "OnDemandPlayerRoles", 365, "/");
}

UserRolesClass.prototype.LoadCookie = function() {
    var cookie = this.GetCookie();
    cookie.Load();
    this.Filtering = false;
    if (cookie.Filtering)
        this.Filtering = (cookie.Filtering == "true");
    this.Roles = new Array();
    if (cookie.Roles)
        this.Roles = cookie.Roles.split("+");
}

UserRolesClass.prototype.StoreCookie = function() {
    var cookie = this.GetCookie();
    cookie.Filtering = this.Filtering ? "true" : "false";
    cookie.Roles = this.Roles.join("+");
    cookie.Store();
}

UserRolesClass.prototype.GetUrlParamString = function() {
    return "PP_ROLEFILTERING=" + (this.Filtering ? "true" : "false") + "&PP_ROLES=" + encodeURIComponent(this.Roles.join('+'));
}

UserRolesClass.prototype.ParseUrlParamString = function(param_str) {
    var params = param_str.split('&');
    for (var p = 0; p < params.length; p++) {
        var paritem = params[p].split("=");
        if (paritem[0].toUpperCase() == "PP_ROLEFILTERING")
            this.Filtering = (paritem[1] == "true");
        else if (paritem[0].toUpperCase() == "PP_ROLES") {
            this.Roles = new Array;
            if (paritem[1])
                this.Roles = paritem[1].split('+');
        }
    }
}

var UserRoles = new UserRolesClass();
UserRoles.LoadCookie();
UserRoles.ParseUrlParamString(paramstr);

function OpenRolesDialog(path) {
    window.open(path + "/preferences/roles.html", "roleswin", "width=500,height=318,resizable=1,scrollbars=0,top=" + (screen.availHeight - 286) / 2 + ",left=" + (screen.availWidth - 500) / 2);
}
