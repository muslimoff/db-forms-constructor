/*--
Copyright © 1998, 2009, Oracle and/or its affiliates.  All rights reserved.
--*/

//<!--Version 9.6.0.8-->

var undefined;
var _SmartHelp_Installed;
var _SmartHelp_Enabled = false;
var _SmartMatch_Enabled = false;
var _StandardContentUrl = Gkod.Helper.CombineUrl(document.location,'../../../stdhemi/hemi');

function Bold(s)
  { return '<b>'+s+'</b>'; }
  
function EvalVariables(c,v)
  {
    // Filter out and evaluate the lines beginning with 'Gkod.Variables.'
    var t = Gkod.Helper.FilterLines(Gkod.Helper.GetLines(c),/^[\s]*Gkod\.Variables\./).join('\n');
    Gkod.Helper.TryCall(function(){var Gkod={'Variables':v};eval(t);},'test-ct.js');
  }

function ShowMessage(m)
  {
    setTimeout(function(){alert(m);},50);
  }

function SmartHelp_Execute(params,onCompleted)
  {
    var visible = false;
  
    var id = 'SmartHelpHandler';
    var fid = id+'Frame';
    var qparams = params?'?'+params:'';
    
    var w = null;
    var n = document.getElementById(id);
    if(n) // n.parentNode.removeChild(n);
    {
      w = window.frames[fid];
      if(w) { try { w.ErrorResult=undefined; w.location='../smarthelp/smarthelpsetup.html'+qparams; } catch(e) { w=null; } }
      if(!w) { n.parentNode.removeChild(n); n=null; }
    }
    if(!n)
    {
      n = document.createElement('div');
      n.id = id;
      n.style.width = (visible?500:0)+'px';
      n.style.height = (visible?500:0)+'px';
      n.style.overflow = (visible?'auto':'hidden');
      n.innerHTML = '<iframe id="'+fid+'" name="'+fid+'" style="display:block;border:none" frameborder="0" width="'+(visible?500:100)+'" height="'+(visible?500:100)+'" src="../smarthelp/smarthelpsetup.html'+qparams+'"></iframe>';
      document.body.insertBefore(n,null);
      w = window.frames[fid];
    }
    
    var tidCancel;
    var tiiQuery;
    
    function onCancel()
    {
      clearInterval(tiiQuery);
      onCompleted(w,false);
    }

    function onQuery()
    {
      try
      {
        if(w.ErrorResult===undefined)
          return;
        //alert(w.location+', '+w.ErrorResult);
        clearTimeout(tidCancel);
        clearInterval(tiiQuery);
        //alert(w.ErrorResult);
        onCompleted(w,(w.ErrorResult===0));
      }
      catch(e) {}
    }
    
    tidCancel = setTimeout(onCancel,60000);
    tiiQuery = setInterval(onQuery,50);
  }

{
  var temp_v = Page.CloneDefaults();
  if((text=Gkod.Helper.LoadText('../odstdcustomurl.js'))!=null)
    EvalVariables(text,temp_v);
  if(temp_v.OD_ENABLESMARTHELP) _SmartHelp_Enabled = true;
  if(temp_v.OD_ENABLESMARTMATCH) _SmartMatch_Enabled = Gkod.Helper.PingUrl(Gkod.Helper.CombineUrl(document.location,'../../../stdhtml/hemi/stdhemiscripts.js'));
}

/*
Types.ContentUrl = new GkodConfig.Url
  (
    {'Width':443},
    function(v,sync)
    {
      v = Gkod.Helper.Trim(v).replace(/([^\/])\/$/,'$1');
      return [true,v,v];
    }
  );
*/

Defaults.diagnosticmode = 0;
Defaults.standardcontent = _StandardContentUrl;
Defaults.maxhit = -1;
Defaults.maxsearch = -1;
Defaults.threshold = -1;
Defaults.minscore = -1;
Defaults.showscore = 0;
Defaults.showtestpage = 0;
Defaults.hemiparamtest = 0;

Types.YesNoDefault = new GkodConfig.DropDown
  (
    null,
    {
      '1':Gkrc('CT.Type.Yes'),
      '0':Gkrc('CT.Type.No'),
      '-1':Gkrc('CT.Type.UseDefault')
    },
    '1',
    function(v) { return [true,Number(v)]; } 
  );

Page.SmartHelp_Install = function(onCompleted)
  {
    var that = this;
  
    function onInstallCompleted(w,success)
    {
      _SmartHelp_Installed = success;
      
      if(success && w.QueryResult)
      {
        var sm_o = {};
        function add(n,alt)
          { sm_o[n] = Gkod.Helper.Get(w.QueryResult[alt||n],Defaults[n]); }

        add('diagnosticmode');
        add('standardcontent','StandardContent');
        
        if(_SmartMatch_Enabled)
        {
          add('showtestpage');
          add('showscore');
          add('threshold');
          add('minscore');
          add('maxhit');         
          add('maxsearch');
        }

        if(sm_o.diagnosticmode!=1) sm_o.diagnosticmode=0;
        that.OverrideVariables(sm_o);
      }
      
      onCompleted && onCompleted.call(that,success);
      if(!success)
        ShowMessage(Gkrc('CT.SmartHelp.Message.InstallFailed'));
      else Page.CheckSection('SMARTMATCH');
    }
  
    SmartHelp_Execute(null,onInstallCompleted);
  }

Page.AddSection('HEMI');
Page.AddVariable('hemiparamtest',    Types.YesNo);

Page.AddSection
(
  'SMARTHELP',
  {
    'onCheckEnabled':function(v){return _SmartHelp_Enabled;},
    'onCheckVisible':function(v){return !!_SmartHelp_Installed;},
    'onShow':Page.SmartHelp_Install
  }
);

Page.AddVariable('standardcontent',  Types.ContentUrl,
  {
    'buttons':
    [
      {
        'title':Gkrc('CT.Action.UseCurrentServer'),
        'onClick':function(){Page.SetVariable('standardcontent',_StandardContentUrl,true);}
      }
    ]
  }
);
Page.AddVariable('diagnosticmode',   Types.Enabled);

if(_SmartMatch_Enabled)
{
  Page.AddSection
  (
    'SMARTMATCH',
    {
      'onCheckEnabled':function(v){return !!_SmartHelp_Installed;}
    }
  );

  Page.AddVariable('showtestpage',     Types.YesNo);
  Page.AddVariable('showscore',        Types.YesNo);
  Page.AddVariable('threshold',        Types.Number_0_100_or_Default);
  Page.AddVariable('minscore',         Types.Number_0_100_or_Default);
  Page.AddVariable('maxsearch',        Types.Integer_0_Inf_or_Default);
  Page.AddVariable('maxhit',           Types.Integer_0_Inf_or_Default);
}

Page.DoLoad = function()
{
  var obj = this.CloneDefaults();

  obj.hemiparamtest = (Gkod.Cookie.Get('HemiCookie','hemiparamtest')=='1')?1:0;

  if(_SmartHelp_Installed!==undefined && !_SmartHelp_Installed)
    return this.LoadCompleted(obj);

  var that = this;
  function onLoadCompleted(w,success)
  {
    if(success)
      _SmartHelp_Enabled = true;
    _SmartHelp_Installed = success;
    // _SmartHelp_Enabled = true;

    if(success && w.QueryResult)
    {
      Gkod.Helper.Override(obj,w.QueryResult);
      if(obj.StandardContent!==undefined)
        Defaults.standardcontent = obj.standardcontent = obj.StandardContent;
      obj.showtestpage = (obj.showtestpage==1)?1:0;
      obj.showscore = (obj.showscore==1)?1:0;
      obj.diagnosticmode = (obj.diagnosticmode==1)?1:0;
    }
      
    that.LoadCompleted(obj);
  }

  SmartHelp_Execute('detect',onLoadCompleted);
}

Page.DoSave = function(obj,old)
{
  var that = this;
  function onSaveCompleted(_,success)
  {
    that.SaveCompleted(success);
    if(success)
      that.DoReload();
    else ShowMessage(Gkrc('CT.SmartHelp.Message.SaveFailed'));
  }

  if(obj.hemiparamtest !== old.hemiparamtest)
    Gkod.Cookie.Set('HemiCookie','hemiparamtest',obj.hemiparamtest?'1':'0');

  if(_SmartHelp_Installed)
  {
    var sm_c = 0;
    var sm_o = {};
    function add(n)
    {
      var x = Gkod.Helper.Get(obj[n],Defaults[n]);
      var y = Gkod.Helper.Get(old[n],Defaults[n]);
      if(Gkod.Helper.Equals(x,y)) return;
      sm_o[n] = x;
      ++sm_c;
    }

    add('diagnosticmode');
    add('standardcontent');
    
    if(_SmartMatch_Enabled)
    {
      add('showtestpage');
      add('showscore');
      add('threshold');
      add('minscore');
      add('maxhit');         
      add('maxsearch');
    }
    
    if(sm_c!=0)
    {
      var params = '';
      for(var m in sm_o)
        params += (params?'&':'')+m+'='+encodeURIComponent(sm_o[m]);
      // alert('Count:'+sm_c+', Params:'+params);
      SmartHelp_Execute(params,onSaveCompleted);
      return;
    }
  }
  
  onSaveCompleted(null,true);
}
