/*--
Copyright © 1998, 2010, Oracle and/or its affiliates.  All rights reserved.
--*/

//<!--Version 9.6.1.23-->

Types.Url = new GkodConfig.Url({'Width':443});
Types.String = new GkodConfig.String({'Width':443});

Types.FrameLocation = new GkodConfig.DropDown
  (
    null,
    {
      'topframe':Gkrc('CT.Type.FrameLocation.Top'),
      'bottomframe':Gkrc('CT.Type.FrameLocation.Bottom')
    }, 
    'topframe'
  );

Types.YesNo = new GkodConfig.DropDown
  (
    null,
    {
      '1':Gkrc('CT.Type.Yes'),
      '0':Gkrc('CT.Type.No')
    },
    '1',
    function(v) { return [true,Number(v)]; } 
  );

Types.AllApplicable = new GkodConfig.DropDown
  (
    null,
    {
      '0':Gkrc('CT.Type.Applicable'),
      '1':Gkrc('CT.Type.All')
    },
    '1',
    function(v) { return [true,Number(v)]; }    
  );
  
Types.ShowDont = new GkodConfig.DropDown
  (
    null,
    {
      '1':Gkrc('CT.Type.Show'),
      '0':Gkrc('CT.Type.DontShow')
    },
    '0',
    function(v) { return [true,Number(v)]; } 
  );

Types.UseDont = new GkodConfig.DropDown
  (
    null,
    {
      '1':Gkrc('CT.Type.Use'),
      '0':Gkrc('CT.Type.DontUse')
    },
    '1',
    function(v) { return [true,Number(v)]; } 
  );

Types.Enable = new GkodConfig.DropDown
  (
    null,
    {
      '1':Gkrc('CT.Type.Enable'),
      '0':Gkrc('CT.Type.Disable')
    },
    '1',
    function(v) { return [true,Number(v)]; } 
  );

Types.Enabled = new GkodConfig.DropDown
  (
    null,
    {
      '1':Gkrc('CT.Type.Enabled'),
      '0':Gkrc('CT.Type.Disabled')
    },
    '1',
    function(v) { return [true,Number(v)]; } 
  );

Types.Disabled = new GkodConfig.DropDown
  (
    null,
    {
        '1': Gkrc('CT.Type.Enabled'),
        '0': Gkrc('CT.Type.Disabled')
    },
    '0',
    function(v) { return [true, Number(v)]; }
  );

Types.HelpMode = new GkodConfig.DropDown
  (
    null,
    {
      '1':Gkrc('CT.Type.HelpMode.TopEmbeddedFrame'),
      '2':Gkrc('CT.Type.HelpMode.BottomEmbeddedFrame'),
      '3':Gkrc('CT.Type.HelpMode.LinkInGatewayPage')
    },
    '1',
    function(v) { return [true,Number(v)]; } 
  );

Types.LanguageUrl = new GkodConfig.Url
  (
    {'Width':300}
  );

Types.ApplicationName = new GkodConfig.String
  (
    {'Width':150},
    function(v)
    {
      if(v.length<1||v.length>8) return [Gkrc('CT.Type.ApplicationName.InvalidLength')];
      if(!/^[a-zA-Z_0-9]+$/.test(v)) return [Gkrc('CT.Type.ApplicationName.InvalidCharacters')];
      return [true,v];
    }
  );

Types.UrlArray = new GkodConfig.Array
  (
    {'ValueColumn':400},
    new GkodConfig.Url({'Width':390})
  );

Types.LangId = new GkodConfig.LangId(true);

Types.LanguageMap = new GkodConfig.Dictionary
  (
    {
      'KeyColumn':125,
      'ValueColumn':240,
      'Key':Gkrc('CT.Title.Language'),
      'Value':Gkrc('CT.Title.ContentUrl')
    },
    Types.LangId,
    Types.LanguageUrl,
    null,
    function(k, v) {
        var r = [true, k, v];
        var ek = (k == 'Lang.None' || k == '');
        var ev = Gkod.Helper.IsEmpty(v);
        if (ek && !ev)
            r[0] = Gkrc('CT.Type.LanguageMap.MissingKey');
        if (!ek && ev)
            r[0] = Gkrc('CT.Type.LanguageMap.MissingValue');
        return r;
    }
  );
    
Types.Number_0_100_or_Default = new GkodConfig.Number
(
  null,
  function(v)
  {
    var n = Number(v);
    if(!isNaN(n)&&(n==-1||(n>=0&&n<=100))) return [true,n];
    return [Gkrc('CT.Type.Number.DefaultOrZero100')];
  }
);

Types.Integer_0_Inf_or_Default = new GkodConfig.Number
(
  null,
  function(v)
  {
    var n = Number(v);
    if(parseInt(v)==parseFloat(v)&&!isNaN(n)&&(n==-1||n>=0)) return [true,n];
    return [Gkrc('CT.Type.Integer.DefaultOrZeroInf')];
  }
);

var ContentUrl = function(rc,validate)
{
  this.rc = rc;
  this.validate = validate;

  var undefined;
  if(this.rc===undefined || this.rc===null) this.rc = {};
  this.width = ((this.rc.Width===undefined)?300:this.rc.Width);
}

ContentUrl.prototype = Gkod.Helper.Override({},GkodConfig.Url.prototype);

ContentUrl.prototype.Dispatch = function(ctx,cmd)
{
  var r = this.Validate(ctx,true,false,true);
  if(r[0]!==true) return;
  var v = r[1];
  window.open(v+'/../../index.html');
}

ContentUrl.prototype.RenderControl = function(ctx) {

    var v = String(ctx.dob.value);
    var undefined;
    var width = ((ctx.width !== undefined) ? ctx.width : this.width);

    var i = '<input onfocus="GkodConfig.Page.Variable_OnFocus(\'' + ctx.va.id + '\')"'
        + ' onblur="GkodConfig.Page.Variable_OnBlur(\'' + ctx.va.id + '\')"'
    // empty url text input hides display of show toc button 
        + ' onchange="getElementById(\'showtoc\').style.display=((getElementById(\'' + ctx.va.id + '_i\').value)?\'inline\':\'none\')"'
        + ' id="' + ctx.id + '_i"'
        + ' name="' + ctx.id + '_i"'
        + ' class="control" type="text"'
        + ' value="' + Gkod.Helper.EscapeHtml(v) + '"'
        + ((width > 0) ? ' style="width:' + width + 'px"' : '')
        + ' />';

    var s = '<table cellspacing="0" cellpadding="0"><tr>'
        + '<td>'
        + i //GkodConfig.Url.prototype.RenderControl.call(this,ctx) 
        + '</td>'
        + '<td style="padding-left:5px"><a id="showtoc" class="sbutton" style="white-space:normal" href="#" onclick="GkodConfig.Page.Variable_Dispatch(\'' + ctx.id + '\',\'ShowTOC\');return false">' + Gkrc('CT.Action.ShowTOC') + '</a></td>' +
    '</tr></table>'
  ;
    return s;
}

Types.ContentUrl = new ContentUrl
(
  {'Width':350},
  function(v,sync)
  {
    v = Gkod.Helper.Trim(v).replace(/([^\/])\/$/,'$1');
    return [true,v,v];
  }
);


/*  Based on entries from odplaybackdefs.js
        Gkod.Variables.GATEWAYPAGE_DUMMY = 0;
        Gkod.Variables.GATEWAYPAGE_MAIN_PLAYER = 1;
        Gkod.Variables.GATEWAYPAGE_EXTERNAL_PLAYER_APPLICABLE = 2;
        Gkod.Variables.GATEWAYPAGE_EXTERNAL_PLAYER_FULL = 3; //add index.html
        Gkod.Variables.GATEWAYPAGE_HELP = 4;
        Gkod.Variables.GATEWAYPAGE_URL_WITH_NOCTX = 5;
        Gkod.Variables.GATEWAYPAGE_URL_WITH_CTX = 6;
*/

Types.GatewayEmbedType = new GkodConfig.DropDown
(
  null,
  {
    //'1': Gkrc('CT.Type.GatewayType.MainPlayer'),
    '2': Gkrc('CT.Type.GatewayType.PlayerWithContext'),
    '3': Gkrc('CT.Type.GatewayType.PlayerWithoutContext'),
    '5': Gkrc('CT.Type.GatewayType.URLWithoutContext')
    //'6': Gkrc('CT.Type.GatewayType.URLWithContext')
  },
  '5',
  function(v) {
    return [true, Number(v)];
  }
);

Types.GatewayLinkType = new GkodConfig.DropDown
(
  null,
  {
    '2': Gkrc('CT.Type.GatewayType.PlayerWithContext'),
    '3': Gkrc('CT.Type.GatewayType.PlayerWithoutContext'),
    '5': Gkrc('CT.Type.GatewayType.URLWithoutContext')
    //'6': Gkrc('CT.Type.GatewayType.URLWithContext')
  },
  '5',
  function(v) {
    return [true, Number(v)];
  }
);


  Types.GatewayEmbed = new GkodConfig.Array
(
  {
    'Sortable': true,
    'RowLayout': true,
    'ValueColumn': [200, 200, 270],
    'Value':
	[
      Gkrc('CT.Title.GatewayType'),
      Gkrc('CT.Title.GatewayTabText'),
      Gkrc('CT.Title.GatewayUrl')
    ]
  },
  {
    'Named': true,
    'Type': Types.GatewayEmbedType,
    'Title': new GkodConfig.String,
    'URL': new GkodConfig.Url
  },
  function(v) {
    return [true, v]
  }
);

  Types.GatewayLinked = new GkodConfig.Array
(
  {
    'Sortable': true,
    'RowLayout': true,
    'ValueColumn': [200, 200, 270],
    'Value':
	[
      Gkrc('CT.Title.GatewayType'),
      Gkrc('CT.Title.GatewayLinkText'),
      Gkrc('CT.Title.GatewayUrl')
    ]
  },
  {
    'Named': true,
    'Type': Types.GatewayLinkType,
    'Title': new GkodConfig.String,
    'URL': new GkodConfig.Url
  },
  function(v) {
    return [true, v]
  }
);

Defaults.OD_URL_SETUPTYPE = 'default';
Defaults.OD_URL = {};

Defaults.GATEWAY_EMBED = [];
Defaults.GATEWAY_LINKED = [];

var t;

//t = new GkodConfig.Template();
//Templates.Add('StandardHemi',t);

t_help = new GkodConfig.Template();
t_help.AddSection('HELP');
t_help.AddVariable('OD_APPLICATIONHELP_URL', Types.Url);
t_help.AddVariable('OD_SHOWHELPMODE', Types.HelpMode);
t_help.AddVariable('OD_SHOWHELPTEXT[OD_SHOWHELPMODE=3]', Types.String);
Templates.Add('AppHelp',t_help);

t_lang = new GkodConfig.Template();
t_lang.AddSection('CONTENT');
t_lang.AddVariable('OD_URL', Types.LanguageMap);
t_lang.AddVariable('OD_DEFAULT_URL', Types.Url);
t_lang.AddSection('ADVANCED');
t_lang.AddVariable('OD_TOCVIEW_ALL', Types.AllApplicable);
Templates.Add('LanguageSupport',t_lang);

t_nolang = new GkodConfig.Template();
t_nolang.AddSection('ADVANCED');
t_nolang.AddVariable('OD_TOCVIEW_ALL', Types.AllApplicable);
t_nolang.AddVariable('OD_DEFAULT_URL', Types.Url);
Templates.Add('NoLanguageSupport',t_nolang);

t_gateway = new GkodConfig.Template();
t_gateway.AddSection('GATEWAY');
t_gateway.AddVariable('GATEWAY_PLAYER_TITLE', Types.String)
t_gateway.AddVariable('GATEWAY_EMBED', Types.GatewayEmbed);
t_gateway.AddVariable('TABBED_GATEWAY_OPEN_LAST_ACTIVE_TAB', Types.YesNo);
t_gateway.AddVariable('GATEWAY_RESOURCES_TITLE', Types.String);
t_gateway.AddVariable('GATEWAY_LINK', Types.GatewayLinked);
Templates.Add('GatewaySupport', t_gateway);
