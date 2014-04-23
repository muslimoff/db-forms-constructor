//odtabbedgateway.js

/*--
Copyright © 1998, 2009, Oracle and/or its affiliates.  All rights reserved.
--*/

//<!--Version 9.6.1.13-->

/// <reference path=oddefs.js />
/// <reference path=odplaybackdefs.js />

Gkod.Trace.Write(Gkod.Trace.ID.LOAD, '[ODTABBEDGATEWAY] : odtabbedgateway.js is loaded into window.name = [' + window.name + '] URL = [' + window.location.href + ']', 3);

var _class = (Gkod.Gateway.Browser._type == 'Explorer') ? 'className' : 'class';
//Gkod.TabbedGateway
if (typeof (Gkod.TabbedGateway) == 'undefined' || !Gkod.TabbedGateway) {

    Gkod.TabbedGateway = {
        _ie: (Gkod.Gateway.Browser._type == 'Explorer'),
        _ff: (Gkod.Gateway.Browser._type == 'Firefox'),
        Active: -1,
        _width: 0,
        IsEnabled: function() {
            if (Gkod.Variables.TABBED_GATEWAY == 1 && (Gkod.Variables.GATEWAY_EMBED.length > 1 || Gkod.Variables.GATEWAY_LINK.length > 0)) {
                return true;
            }
            return false;
        },
        VersionMismatch: function() {
            if (Gkod.Helper && Gkod.Helper.CompareVersion && Gkod.Variables.Config) {
                if (Gkod.Helper.CompareVersion(Gkod.Variables.Config.Version, GkodConfig.AppVersion) == -1) {
                    //odcustomurl.js < config.js
                    return true;
                }
            }
            return false;
        },
        Popup: {
            _menuwidth: 300,
            _timer: null,

            _dropdown: null,
            _contains_ff: function(a, b) {
                while (b.parentNode) {
                    if ((b = b.parentNode) === a)
                        return true;
                    return false;
                }
            },
            _iecompattest: function() {
                return (document.compatMode && document.compatMode.indexOf("CSS") != -1) ? document.documentElement : document.body;
            },

            Show: function(e, id) {
                if (Gkod.TabbedGateway._ie) {
                    e = event;
                }
                //Gkod.Trace.Write(Gkod.Trace.ID.GATEWAY, '[ODTABBEDGATEWAY] : Show() ' + e.type);
                var _menu = document.getElementById('tabMenu');
                if (!_menu) {
                    return;
                }
                this.ClearHide();
                _menu.style.width = this._menuwidth;
                //_menu.contentwidth = _menu.offsetWidth;
                //_menu.contentheight = _menu.offsetHeight;

                var eventX = e.clientX;
                var eventY = e.clientY;
                Gkod.Trace.Write(Gkod.Trace.ID.GATEWAY, '[ODTABBEDGATEWAY] : object = ' + (Gkod.TabbedGateway._ie ? e.srcElement.tagName : e.target.tagName) + ' eventX = ' + eventX + ' eventY = ' + eventY + ' this._menuwidth = ' + this._menuwidth);
                var rect = Gkod.TabbedGateway._ie ? e.srcElement.getBoundingClientRect() : e.target.getBoundingClientRect();

                var _left = parseInt(rect.left);
                var _top = parseInt(rect.top);
                var _right = parseInt(rect.right);
                var _bottom = parseInt(rect.bottom);
                if (Gkod.TabbedGateway._ie) {
                    _bottom = _bottom - 2;
                    _right = _right - 8;
                }
                Gkod.Trace.Write(Gkod.Trace.ID.GATEWAY, '[ODTABBEDGATEWAY] : a rect = ' + _left + ' ' + _top + ' ' + _right + ' ' + _bottom);
                _menu.style.top = _bottom + 'px';
                _menu.style.left = (_right - this._menuwidth - 1 + document.documentElement.scrollLeft) + 'px';
                Gkod.Trace.Write(Gkod.Trace.ID.GATEWAY, '[ODTABBEDGATEWAY] : menu rect = ' + _menu.style.left + ' ' + _menu.style.top + ' ' + _menu.style.right + ' ' + _menu.style.bottom);
                _menu.style.visibility = "visible";
                return false;
            },

            DelayHide: function() {
                this._timer = setTimeout(this.Hide, 1000);
            },

            ClearHide: function() {
                if (this._timer) {
                    clearTimeout(this._timer);
                }
            },

            Hide: function() {
                if (document.getElementById('tabMenu') != null) {
                    document.getElementById('tabMenu').style.visibility = 'hidden';
                }
            }
        },

        OpenWindow: function(url, close) {
            Gkod.Trace.Write(Gkod.Trace.ID.GATEWAY, '[ODTABBEDGATEWAY] : OpenWindow() - url = ' + url);
            window.open(url);
            if (close) {
                window.close();
            }
        },

        CreatePopup: function() {
            Gkod.Trace.Write(Gkod.Trace.ID.GATEWAY, '[ODTABBEDGATEWAY] : CreatePopup()');
            if (document.getElementById('tabMenu') == null) {
                var divm = document.createElement('div');
                divm.setAttribute('id', 'tabMenu');
                divm.setAttribute(_class, 'popupmenu');
                divm.onmouseover = function(e) { Gkod.TabbedGateway.Popup.ClearHide(e); };
                divm.onmouseout = function(e) { Gkod.TabbedGateway.Popup.DelayHide(e) };
                document.body.insertBefore(divm, null);

                for (var i = 0, z = parent.Gkod.Variables.GATEWAY_LINK; i < z.length; i++) {
                    Gkod.TabbedGateway.AddPopup(z[i]);
                }

                //try to get calculate the size of the dropdown
                var _width = 0;
                var t = document.getElementById('tabMenu');
                for (var i = 0, z = t.childNodes; i < z.length; i++) {
                    if (z[i].tagName.toLowerCase() == 'a') {
                        var l = parseInt(z[i].getBoundingClientRect().left);
                        var r = parseInt(z[i].getBoundingClientRect().right);
                        if (r - l > _width) {
                            _width = r - l;
                        }
                        Gkod.Trace.Write(Gkod.Trace.ID.GATEWAY, '[ODTABBEDGATEWAY] : CreatePopup() width = ' + _width);
                    }
                }
                Gkod.TabbedGateway.Popup._menuwidth = _width;
                Gkod.TabbedGateway.Popup.Hide();
            }
        },

        AddPopup: function(z) {
            var url = z.URL;
            //help page
            if (z.Type == Gkod.Variables.GATEWAYPAGE_HELP) {
                var _helpCtx = '';
                if (Gkod.ctxinfo.apphelpurl != '') {
                    _helpCtx = '?' + Gkod.ctxinfo.apphelpurl;
                }
                url += _helpCtx;
                Gkod.Variables.OD_APPLICATIONHELP_URL = url;
            }
            //applicable players
            else if (z.Type == Gkod.Variables.GATEWAYPAGE_EXTERNAL_PLAYER_APPLICABLE) {
                var tocParams = Gkod.ctxinfo.tocurl.substr(Gkod.ctxinfo.tocurl.indexOf('/index.html'));
                url += tocParams;
            }
            //full players
            else if (z.Type == Gkod.Variables.GATEWAYPAGE_EXTERNAL_PLAYER_FULL) {
                var k = url;
                if (k.indexOf('index.html') == -1) {
                    if (k.lastIndexOf("/") != k.length - 1) {
                        k += "/";
                    }
                    k += "index.html";
                    url = k;
                }
            }
            var d = document.getElementById('tabMenu');
            var a = document.createElement('a');
            a.onclick = function(e) { Gkod.TabbedGateway.OpenWindow(url) };
            if (z.global) {
                a.setAttribute(_class, 'global');
            }
            else {
                a.setAttribute(_class, 'local');
            }
            a.href = 'javascript:void(null);';
            var t = document.createTextNode(z.Title);
            a.appendChild(t);
            d.appendChild(a);
        },

        AddTabPage: function(id) {
            Gkod.Trace.Write(Gkod.Trace.ID.GATEWAY, '[ODTABBEDGATEWAY] : AddTabPage() id = ' + id);

            var dropdown = (Gkod.Variables.GATEWAY_EMBED[id].Type == Gkod.Variables.GATEWAYPAGE_RESOURCES);
            var e_tabs = document.getElementById('tabArea');
            var li = document.createElement('li');
            li.setAttribute(_class, 'tab');
            var nobr = document.createElement('nobr');
            var a = document.createElement('a');
            if (Gkod.Variables.GATEWAY_EMBED[id].global) {
                a.setAttribute(_class, 'global');
            }
            else {
                a.setAttribute(_class, 'local');
            }
            a.href = 'javascript:void(null);';
            if (!dropdown) {
                a.onclick = function(e) { Gkod.TabbedGateway.ShowTabContent(e, id) };
            }
            if (dropdown) {
                a.onmouseover = function(e) { Gkod.TabbedGateway.Popup.Show(e, id) };
                a.onmouseout = function(e) { Gkod.TabbedGateway.Popup.DelayHide(e, id) };
                a.onclick = function(e) { Gkod.TabbedGateway.Popup.Show(e, id) };
            }
            var text = Gkod.Variables.GATEWAY_EMBED[id].Title + (dropdown ? ' ▼' : '');
            var t = document.createTextNode(text);
            a.appendChild(t);
            li.appendChild(a);
            e_tabs.appendChild(li);
        },

        UpdateResource: function(object, title, url) {
            Gkod.Trace.Write(Gkod.Trace.ID.GATEWAY, '[ODTABBEDGATEWAY] : UpdateResource() title = ' + title + ' url = ' + url);

            if (typeof (title) == 'string' && title.length > 0) {
                object.Title = title;
            }
            if (typeof (url) == 'string' && url.length > 0) {
                object.URL = url;
            }
        },

        AddMoreTabs: function() {
            for (var i = 1, z = Gkod.Variables.GATEWAY_EMBED; i < z.length; i++) {
                //help page
                if (z[i].Type == Gkod.Variables.GATEWAYPAGE_HELP) {
                    var _helpCtx = '';
                    if (Gkod.ctxinfo.apphelpurl != '') {
                        _helpCtx = '?' + Gkod.ctxinfo.apphelpurl;
                    }
                    Gkod.TabbedGateway.UpdateResource(Gkod.Variables.GATEWAY_EMBED[i], '', z[i].URL + _helpCtx);
                    Gkod.Variables.OD_APPLICATIONHELP_URL = z[i].URL;
                }
                //applicable players
                else if (z[i].Type == Gkod.Variables.GATEWAYPAGE_EXTERNAL_PLAYER_APPLICABLE) {
                    var tocParams = Gkod.ctxinfo.tocurl.substr(Gkod.ctxinfo.tocurl.indexOf('/index.html'));
                    Gkod.TabbedGateway.UpdateResource(Gkod.Variables.GATEWAY_EMBED[i], '', z[i].URL + tocParams);
                }
                //full players
                else if (z[i].Type == Gkod.Variables.GATEWAYPAGE_EXTERNAL_PLAYER_FULL) {
                    var k = Gkod.Variables.GATEWAY_EMBED[i].URL;
                    if (k.indexOf('index.html') == -1) {
                        if (k.lastIndexOf("/") != k.length - 1) {
                            k += "/";
                        }
                        k += "index.html";
                        Gkod.TabbedGateway.UpdateResource(Gkod.Variables.GATEWAY_EMBED[i], '', k);
                    }
                }
            }

            //Test
            if (Gkod.Variables.OD_HEMIPARAMTEST == 1 && Gkod.GatewayUtility.GetIndexOfMainPlayer() != -1) {
                Gkod.Variables.GATEWAY_EMBED.push({ 'Title': Gkod.Variables.GATEWAY_EMBEDDED_TEST_TITLE, 'URL': root_url + '/gateway/dummy.html', 'Type': Gkod.Variables.GATEWAYPAGE_DUMMY });
            }

            //Reosurces
            if (Gkod.Variables.GATEWAY_LINK.length > 0) {
                Gkod.Variables.GATEWAY_EMBED.push({ 'Title': Gkod.Variables.GATEWAY_RESOURCES_TITLE, 'URL': '', 'Type': Gkod.Variables.GATEWAYPAGE_RESOURCES });
            }
        },

        Show: function() {
            if (this._ie) {
                var d = document.getElementById('tabEars');
                if (d) {
                    d.setAttribute(_class, 'tabEars_IE');
                }
            }
            for (var i = 0, z = Gkod.Variables.GATEWAY_EMBED; i < z.length; i++) {
                this.AddTabPage(i);
                var dropdown = (Gkod.Variables.GATEWAY_EMBED[i].Type == Gkod.Variables.GATEWAYPAGE_RESOURCES);
                if (dropdown) {
                    this.CreatePopup();
                }
                else {
                    this.AddTabFrame(i);
                }
            }

            //Check valid index
            if (this.Active < Gkod.Variables.GATEWAY_EMBED.length) {
                if (Gkod.Variables.GATEWAY_EMBED[this.Active].Title != lastactive_tabtitle) {
                    this.Active = 0;
                }
            }
            else {
                this.Active = 0;
            }

            //document.getElementById('tabRow').setAttribute('style', 'table-layout: fixed')

            this.ShowTabContent(null, this.Active);
        },

        AddTabFrame: function(id) {
            Gkod.Trace.Write(Gkod.Trace.ID.GATEWAY, '[ODTABBEDGATEWAY] : AddTabFrame() id = ' + id);
            var content = document.getElementById('tab' + id);

            if (content == null) {
                content = document.createElement('iframe');
                content.setAttribute(_class, 'eframe');
                content.setAttribute('width', '0');
                content.setAttribute('height', '0');
                content.setAttribute('frameBorder', '0');
                content.setAttribute('id', 'tab' + id);
                var d = document.getElementById('tabPages');
                d.appendChild(content);
            }
        },

        SetContentSize: function(id) {
            Gkod.Trace.Write(Gkod.Trace.ID.GATEWAY, "[ODTABBEDGATEWAY] : SetContentSize() id = " + id);
            var fr = document.getElementById('tab' + id);
            if (fr) {
                this._SetContentSize(fr);
            }
        },

        _SetContentSize: function(fr) {
            var h = 10, w = 0;
            //Gkod.Trace.Write(Gkod.Trace.ID.GATEWAY, "[ODTABBEDGATEWAY] : _SetContentSize fr = " + fr.id);

            if (fr.id && fr.id == 'eplayer') {
                h = 0;
            } else {
                var d = document.getElementById('tabEars');
                if (d) {
                    var r = d.getBoundingClientRect();
                    h += r.bottom - r.top;
                    Gkod.Trace.Write(Gkod.Trace.ID.GATEWAY, "[ODTABBEDGATEWAY] : _SetContentSize h = " + h);
                }
            }

            var ch = Gkod.TabbedGateway.GetContentHeight();
            var cw = Gkod.TabbedGateway.GetContentWidth();
            fr.setAttribute('height', (ch - h) + 'px');
            fr.setAttribute('width', (cw - w) + 'px');
        },

        OnResize: function() {
            //Gkod.Trace.Write(Gkod.Trace.ID.GATEWAY, "[ODTABBEDGATEWAY] : OnResize() Active = " + Gkod.TabbedGateway.Active);
            if (Gkod.TabbedGateway.Active > -1) {
                Gkod.TabbedGateway.SetContentSize(Gkod.TabbedGateway.Active);
                Gkod.TabbedGateway.FixDiv();
            }
            if (Gkod.TabbedGateway.Active == -1) {
                var z = document.getElementById('eplayer');
                Gkod.TabbedGateway._SetContentSize(z);
            }
        },

        FixDiv: function() {
            if (document.getElementById('tabEars')) {
                var w = Gkod.TabbedGateway.GetTabs();
                if (typeof (w) != 'undefined' && w.length > 1) {
                    var d = w[w.length - 1];
                    var z = (d.offsetLeft + d.offsetWidth);
                    Gkod.Trace.Write(Gkod.Trace.ID.GATEWAY, '[ODTABBEDGATEWAY] : OnResize() div#tabEars size is set to ' + z + ' GetContentWidth = ' + Gkod.TabbedGateway.GetContentWidth());
                    if (z > Gkod.TabbedGateway.GetContentWidth()) {
                        document.getElementById('tabEars').style.width = z + 'px';
                    }
                    else {
                        document.getElementById('tabEars').style.width = Gkod.TabbedGateway.GetContentWidth() + 'px';
                    }
                }
            }
        },

        GetContentWidth: function() {
            var cw = 0;
            if (window.innerWidth) {
                cw = window.innerWidth;
            }
            else if (document.documentElement.clientWidth) {
                cw = document.documentElement.clientWidth;
            }
            else if (document.body.clientWidth) {
                cw = document.body.clientWidth;
            }
            return cw;
        },

        GetContentHeight: function() {
            var ch = 0;
            if (window.innerHeight) {
                ch = window.innerHeight;
            }
            else if (document.documentElement.clientHeight) {
                ch = document.documentElement.clientHeight;
            }
            else if (document.body.clientHeight) {
                ch = document.body.clientHeight;
            }
            return ch;
        },

        ShowTabContent: function(e, id) {
            if (Gkod.TabbedGateway._ie) {
                e = event;
            }
            if (e && e != null) {
                var z = (Gkod.TabbedGateway._ie ? e.srcElement : e.target);
                if (z) {
                    z.blur();
                }
            }
            var content = document.getElementById('tab' + id);

            Gkod.Trace.Write(Gkod.Trace.ID.GATEWAY, '[ODTABBEDGATEWAY] : ShowTabContent() id = ' + id + ' content is null = ' + (content == null));
            if (content != null) {
                if (typeof (Gkod.Variables.GATEWAY_EMBED[id].url_is_set) == 'undefined') { //otherwise it is reloading all the time a tab is selected
                    content.setAttribute('src', Gkod.Variables.GATEWAY_EMBED[id].URL);
                    Gkod.Variables.GATEWAY_EMBED[id].url_is_set = 1;
                }
                content.style.display = 'block';
            }

            this.SetContentSize(id);

            if (this.Active != id) {
                var current_id = this.Active;
                var current_frame = document.getElementById('tab' + current_id);
                current_frame.style.display = 'none';
            }
            if (Gkod.Variables.GATEWAY_EMBED[id].Title == Gkod.Variables.GATEWAY_EMBEDDED_TEST_TITLE) {
                if (!Gkod.TabbedGateway.IAS._opened) {
                    Gkod.TabbedGateway.IAS._opened = true;
                    Gkod.TabbedGateway.IAS._timer = setInterval(function() {
                        if (Gkod.TabbedGateway.IAS.CheckTestPage(id)) {
                            Gkod.TabbedGateway.IAS.CreateTestPage(mode, id);
                        }
                    }, 10);
                }
            }

            this.SetActiveTab(id);

            Gkod.Cookie.Set('HemiCookie', 'lastactivetabindex', this.Active);
            Gkod.Cookie.Set('HemiCookie', 'lastactivetabtitle', Gkod.Variables.GATEWAY_EMBED[this.Active].Title);
        },

        SetActiveTab: function(x) {
            Gkod.Trace.Write(Gkod.Trace.ID.GATEWAY, '[ODTABBEDGATEWAY] : SetActiveTab() id = ' + x);
            var e_tabs = this.GetTabs();
            e_tabs[this.Active].removeAttribute(_class);
            e_tabs[this.Active].setAttribute(_class, 'tab');
            e_tabs[x].setAttribute(_class, 'activeTab');
            this.Active = x;
        },

        GetTabs: function() {
            var r = [];
            var e_tabs = document.getElementById('tabArea');
            for (var i = 0, z = e_tabs.childNodes; i < z.length; i++) {
                if (z[i].nodeName.toLowerCase() == 'li') {
                    r.push(z[i]);
                }
            }
            return r;
        },

        IAS: {
            _id: -1,
            _opened: false,
            _timer: null,
            _win: null,
            _unescape: function(s) {
                var _temp = s;
                var _app = parent.Gkod.ctxinfo.appname + "\\$";
                _temp = _temp.replace(new RegExp(_app, "g"), "");
                _temp = Gkod.Escape.MyUnEscape(_temp);
                return _temp;
            },
            CheckTestPage: function(id) {
                var fr = document.getElementById('tab' + id);
                //Gkod.Trace.Write(Gkod.Trace.ID.GATEWAY, '[ODTABBEDGATEWAY] : CreateTestPage() - fr = ' + fr);
                if (fr) {
                    if (fr.contentWindow.document.getElementById('dheader') && fr.contentWindow.document.getElementById('dcontent')) {
                        return true;
                    }
                }
                return false;
            },
            CreateTestPage: function(mode, id) {
                Gkod.Trace.Write(Gkod.Trace.ID.GATEWAY, '[ODTABBEDGATEWAY] : CreateTestPage() - mode = ' + mode + ' id = ' + id);
                this._id = id;
                if (this._timer) {
                    clearInterval(this._timer);
                }

                var hemisource = '';
                var logosource = '<table width="450" border="0" cellspacing="0" cellpadding="0">' +
                    '<tr><td colspan="2"><img src=' + 'large_logo.gif' + ' border="0"></td></tr></table><br /><hr /><br />';

                if (mode == 'exactmatch') {
                    this._win = document.getElementById('tab' + id).contentWindow;

                    hemisource += "<div id='em1'></div>";
                    hemisource += "<br /><hr /><br />";
                    hemisource += "<div id='em2'></div>";
                }
                else {
                    var player = document.getElementById('tab0');
                    if (player && player.contentWindow) {
                        this._win = player.contentWindow;
                    }

                    hemisource += "<div id='sm'></div>";
                    hemisource += "<br /><hr /><br />";
                    hemisource += "<div id='opa1'></div>" +
                                    "<div id='opa1f'></div><br />" +
                                    "<div id='opa2'></div><br />" +
                                    "<a id='anchor1' href='#anchor1'></a>" +
                                    "<div id='opa3'></div>" +
                                    "<div id='opa3f'></div><br />" +
                                    "<div id='opa4'></div><br />" +
                                    "<div id='opa5'></div>";

                    if (this._win && document.getElementById('tab' + id)) {
                        this._win.GenericSearch.Utility.TestWindow = document.getElementById('tab' + id).contentWindow;
                        Gkod.Trace.Write(Gkod.Trace.ID.GATEWAY, '[ODTABBEDGATEWAY] : CreateTestPage() - TestWindow is set to ' + this._win.GenericSearch.Utility.TestWindow);
                    }
                }

                var fr = document.getElementById('tab' + id);
                if (fr) {
                    var e = fr.contentWindow.document.getElementById('dheader');
                    if (e) {
                        e.innerHTML = logosource;
                    }
                    var d = fr.contentWindow.document.getElementById('dcontent');
                    if (d) {
                        d.innerHTML = hemisource;
                    }
                }
                if (mode == 'exactmatch') {
                    this.EM_Table1.Create();
                    this.EM_Table2.Create();
                }
                else {
                    this.SM_Table1.Create();

                    if (this._win && this._win.GenericSearch.CallBack) {
                        this._win.GenericSearch.CallBack();
                    }
                }
            },

            SM_Table1: {
                THead: '',
                Heads: ["VARIABLE", "VALUE"],
                TBody: "",
                TFoot: "",
                CreateHeaders: function() {
                    var aHead = [];
                    var stCellBegin = "<th>";
                    var stCellEnd = "</th>";
                    var stRowBegin = "<tr>";
                    var stRowEnd = "</tr>";

                    var _t = this.Heads;
                    aHead.push(stRowBegin);
                    for (var i = 0; i < _t.length; i++) {
                        aHead.push(stCellBegin + _t[i] + stCellEnd);
                    }
                    aHead.push(stRowEnd);

                    var stHead = "<thead>" + aHead.join('') + "</thead>";
                    this.THead = stHead;
                },
                CreateRows: function() {
                    var aBody = [];
                    var stCellBegin = "<td>";
                    var stCellEnd = "</td>";
                    var stRowBegin = "<tr>";
                    var stRowEnd = "</tr>";

                    aBody.push(stRowBegin);
                    aBody.push(stCellBegin + 'GATEWAY URL' + stCellEnd + stCellBegin + parent.window.location.href + stCellEnd);
                    aBody.push(stRowEnd);
                    aBody.push(stRowBegin);
                    aBody.push(stCellBegin + 'APPLICATION NAME' + stCellEnd + stCellBegin + (Gkod.TabbedGateway.IAS._win ? Gkod.TabbedGateway.IAS._win.GenericSearch.AppName : "N/A") + stCellEnd);
                    aBody.push(stRowEnd);
                    aBody.push(stRowBegin);
                    aBody.push(stCellBegin + 'PLAYER MODE' + stCellEnd + stCellBegin + mode.toUpperCase() + stCellEnd);
                    aBody.push(stRowEnd);

                    var stTable = "<tbody>" + aBody.join('') + "</tbody>";
                    this.TBody = stTable;
                },
                Create: function() {
                    this.CreateHeaders();
                    this.CreateRows();

                    //Create table
                    var div = Gkod.TabbedGateway.IAS._win.GenericSearch.Utility.TestWindow.document.getElementById("sm");
                    div.innerHTML = "<table class=sortable1 border=1>" + this.THead + this.TBody + this.TFoot + "</table>";
                }
            },

            EM_Table1: {
                THead: '',
                Heads: ["VARIABLE", "VALUE"],
                TBody: "",
                TFoot: "",
                CreateHeaders: function() {
                    var aHead = [];
                    var stCellBegin = "<th>";
                    var stCellEnd = "</th>";
                    var stRowBegin = "<tr>";
                    var stRowEnd = "</tr>";

                    var _t = this.Heads;
                    aHead.push(stRowBegin);
                    for (var i = 0; i < _t.length; i++) {
                        aHead.push(stCellBegin + _t[i] + stCellEnd);
                    }
                    aHead.push(stRowEnd);

                    var stHead = "<thead>" + aHead.join('') + "</thead>";
                    this.THead = stHead;
                },
                CreateRows: function() {
                    var aBody = [];
                    var stCellBegin = "<td>";
                    var stCellEnd = "</td>";
                    var stRowBegin = "<tr>";
                    var stRowEnd = "</tr>";

                    aBody.push(stRowBegin);
                    aBody.push(stCellBegin + 'GATEWAY URL' + stCellEnd + stCellBegin + parent.window.location.href + stCellEnd);
                    aBody.push(stRowEnd);
                    aBody.push(stRowBegin);
                    aBody.push(stCellBegin + 'APPLICATION NAME' + stCellEnd + stCellBegin + parent.Gkod.ctxinfo.appname + stCellEnd);
                    aBody.push(stRowEnd);
                    aBody.push(stRowBegin);
                    aBody.push(stCellBegin + 'PLAYER MODE' + stCellEnd + stCellBegin + mode.toUpperCase() + stCellEnd);
                    aBody.push(stRowEnd);
                    aBody.push(stRowBegin);
                    aBody.push(stCellBegin + 'PLAYER URL' + stCellEnd + stCellBegin + parent.Gkod.ctxinfo.tocurl + stCellEnd);
                    aBody.push(stRowEnd);

                    var stTable = "<tbody>" + aBody.join('') + "</tbody>";
                    this.TBody = stTable;
                },
                Create: function() {
                    this.CreateHeaders();
                    this.CreateRows();

                    //Create table
                    var div = Gkod.TabbedGateway.IAS._win.document.getElementById("em1");
                    div.innerHTML = "<table class=sortable1 border=1>" + this.THead + this.TBody + this.TFoot + "</table>";
                }
            },

            EM_Table2: {
                THead: '',
                Heads: ["VARIABLE", "VALUE"],
                TBody: "",
                TFoot: "",
                CreateHeaders: function() {
                    var aHead = [];
                    var stCellBegin = "<th>";
                    var stCellEnd = "</th>";
                    var stRowBegin = "<tr>";
                    var stRowEnd = "</tr>";

                    var _t = this.Heads;
                    aHead.push(stRowBegin);
                    for (var i = 0; i < _t.length; i++) {
                        aHead.push(stCellBegin + _t[i] + stCellEnd);
                    }
                    aHead.push(stRowEnd);

                    var stHead = "<thead>" + aHead.join('') + "</thead>";
                    this.THead = stHead;
                },
                CreateRows: function() {
                    var aBody = [];
                    var stCellBegin = "<td>";
                    var stCellEnd = "</td>";
                    var stRowBegin = "<tr>";
                    var stRowEnd = "</tr>";

                    aBody.push(stRowBegin);
                    aBody.push(stCellBegin + 'LANGUAGE CODE' + stCellEnd + stCellBegin + parent.Gkod.ctxinfo.language + stCellEnd);
                    aBody.push(stRowEnd);
                    aBody.push(stRowBegin);
                    aBody.push(stCellBegin + 'CTXEX (raw)' + stCellEnd + stCellBegin + parent.Gkod.ctxinfo.ctxex + stCellEnd);
                    aBody.push(stRowEnd);
                    aBody.push(stRowBegin);
                    aBody.push(stCellBegin + 'CTXEX (unescaped)' + stCellEnd + stCellBegin + Gkod.TabbedGateway.IAS._unescape(parent.Gkod.ctxinfo.ctxex) + stCellEnd);
                    aBody.push(stRowEnd);
                    aBody.push(stRowBegin);
                    aBody.push(stCellBegin + 'HELP URL' + stCellEnd + stCellBegin + Gkod.Variables.OD_APPLICATIONHELP_URL + stCellEnd);
                    aBody.push(stRowEnd);

                    for (i in parent.Gkod.ctxinfo.extra) {
                        aBody.push(stRowBegin);
                        aBody.push(stCellBegin + 'EXTRA PARAMETERS[' + i + ']' + stCellEnd + stCellBegin + parent.Gkod.ctxinfo.extra[i] + stCellEnd);
                        aBody.push(stRowEnd);
                    }

                    var stTable = "<tbody>" + aBody.join('') + "</tbody>";
                    this.TBody = stTable;
                },
                Create: function() {
                    this.CreateHeaders();
                    this.CreateRows();

                    //Create table
                    var div = Gkod.TabbedGateway.IAS._win.document.getElementById("em2");
                    div.innerHTML = "<table class=sortable1 border=1>" + this.THead + this.TBody + this.TFoot + "</table>";
                }
            }
        }
    }
}

