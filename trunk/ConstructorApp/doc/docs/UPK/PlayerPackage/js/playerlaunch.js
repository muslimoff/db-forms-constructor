/*--
Copyright © 1998, 2010, Oracle and/or its affiliates.  All rights reserved.
--*/


function LaunchDoIt(url, params) {
    var popupVersion = false;
    var _params = params;
    var isIE = (navigator.appName.indexOf("Microsoft") != -1) ? true : false;
    if (isIE) {
        try {
            function IsWindowPositioningRestricted() {
                var p = createPopup();
                p.show(top.screenLeft, top.screenTop - 1, 1, 1);
                var r = p.document.parentWindow.screenTop == top.screenTop - 1;
                p.hide();
                return !r;
            }

            if (!IsWindowPositioningRestricted()) {
                var safeuri = false;
                if (_params.substr(0, 3) == "su=") {
                    _params = Gkod.Escape.SafeUriUnEscape(_params.substr(3));
                    safeuri = true;
                }
                _params += "&popup=true";
                if (safeuri) {
                    _params = "su=" + Gkod.Escape.SafeUriEscape(_params);
                }
                popupVersion = true;
            }
        } catch (e) {
        }
    }

    if (popupVersion) {
        playerwindow = window.open(url + "?" + _params, "", "toolbar=0,scrollbars=0,location=0,statusbar=0,menubar=0,resizable=1,left=1500"); 
    }
    else {
        if (isIE) {
            var appVerArray = navigator.appVersion.split(";");
            var appVer = appVerArray[1];
            appVer = appVer.substr(6)
            appVer = parseFloat(appVer);
            isIE6 = (appVer < 7) ? true : false;
        }
        if (systemEnableCookies) {
            GICookie = new Cookie(document, "GICookie", 365, "/", null, null)
            var LeftPos = IsSafari() ? screen.availWidth - 361 : screen.availWidth - 290;
            var TopPos = screen.availHeight - 450;
            var popWidth = IsSafari() ? 346 : 275;
            var popHeight = 400;
            if (GICookie.Load()) {
                if (GICookie["Cleft"] >= 0 && GICookie["Ctop"] >= 0 && GICookie["Cleft"] < screen.availWidth && GICookie["Ctop"] < screen.availHeight) {
                    LeftPos = parseInt(GICookie["Cleft"]);
                    TopPos = parseInt(GICookie["Ctop"]);
                    popWidth = parseInt(GICookie["Cwidth"]);
                    popHeight = parseInt(GICookie["Cheight"]);
                }
            }
        }
        if (isIE6) {
            alert(R_popup_create_error);
        }
        else {
            playerwindow = window.open(url + "?" + _params, "", "toolbar=0,scrollbars=0,location=1,statusbar=0,menubar=0,resizable=1,left=" + LeftPos + ",top=" + TopPos + ",width=" + popWidth + ",height=" + popHeight);
        }
    }
}

