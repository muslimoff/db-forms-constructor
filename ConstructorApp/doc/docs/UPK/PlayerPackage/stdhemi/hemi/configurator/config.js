/*--
Copyright © 1998, 2010, Oracle and/or its affiliates.  All rights reserved.
--*/

//<!--Version 9.6.1.45-->

var Gkod_Undefined;

if(this.Gkod===Gkod_Undefined) Gkod={};

// Gkrc
// ==========================================================================

Gkrc = Gkod.Helper.CreateResourceManager();
Gkrc.AttachResource('config.js');

// GkodConfig
// ==========================================================================

GkodConfig = {};
GkodConfig.AppVersion = '9.6.1';
GkodConfig.Copyright = null;
GkodConfig.Title = null;
GkodConfig.Page = {};
GkodConfig.LoadSuccess = false; 
GkodConfig.DefaultLanguage = 'en';
GkodConfig.CurrentLanguage = 'en';
GkodConfig.Languages = 
  {
  //  'de': 'Deutsch',
    'en': 'English'
  //  'es': 'Español'
  //  'fr': 'Français',
  //  'ja': '日本語'
  }
;
GkodConfig.PublishData = null;
GkodConfig.TestData = null;
GkodConfig.AppData = null;
GkodConfig.AppList = null;
GkodConfig.ToggleHelp = false;
GkodConfig.EnableComments = false;
GkodConfig.Standalone = false;
GkodConfig.AlwaysShowAdvanced = false;
GkodConfig._TemplateMap = null;

GkodConfig._PageUpdateFn = null;
GkodConfig._PageUpdateTID = null;

GkodConfig.DelayedPageUpdate = function(updateFn)
{
  GkodConfig.CancelPageUpdate();
  GkodConfig._PageUpdateFn = updateFn;
  GkodConfig._PageUpdateTID = setTimeout
  (
    function()
    {
      try
      {
        var updateFn = GkodConfig._PageUpdateFn;
        GkodConfig._PageUpdateFn = null;
        GkodConfig._PageUpdateTID = null;
        updateFn.call();
      }
      catch(e) { Gkod.Helper.Exception(e,'GkodConfig.DelayedPageUpdate'); }
    },
    1500
  );
  updateFn;
}

GkodConfig.CommitPageUpdate = function()
{
  if(!GkodConfig._PageUpdateTID)
    return;
  var updateFn = GkodConfig._PageUpdateFn;
  GkodConfig.CancelPageUpdate();
  updateFn.call();
}

GkodConfig.CancelPageUpdate = function()
{
  if(!GkodConfig._PageUpdateTID)
    return;
  clearTimeout(GkodConfig._PageUpdateTID);
  GkodConfig._PageUpdateFn = null;
  GkodConfig._PageUpdateTID = null;
}

/*
GkodConfig.AppMap = {};
GkodConfig.S_general = {};
GkodConfig.S_applications = {};
GkodConfig._ExtendAppMap = function(appMap,apps)
{
  for(var m in apps)
  {
    
    var $m = apps[m];
    var p = m.indexOf('/');
    if(p!=-1)
    {
      var k = m.substr(0,p);
      if(appMap[k]===undefined)
        appMap[k]={'list':[],'props':{}};
      appMap[k].list.push(m);
    }
    if(appMap[m]===undefined)
      appMap[m]={'list':[],'props':{}};
    appMap[m].list.push(m);
    Gkod.Helper.Override(appMap[m].properties,$m);
  }
}
GkodConfig._GetAppDefaults = function(id)
{
  var a = id.toLowerCase().split('/');
  var n =
  {
    'Id':id,
    'Title':m,
    'Location':'../../../'+a[0]+'/hemi/'+((a.length>1)?a[1]+'_':'')+'odcustomurl.js',
    'Template':'../../../'+a[0]+'/hemi/odcustomurl.js'
  }
}
*/

GkodConfig._EnsureAppDefaults = function(list)
{
  var undefined;
  for(var m in list)  
  {
    var $m = list[m];
    var a = m.toLowerCase().split('/');
    if($m.Id===undefined)
      $m.Id = m;
    if($m.Title===undefined)
      $m.Title = m;
    if($m.Template===undefined)
      $m.Template = ($m.Location===undefined)?'../../../'+a[0]+'/hemi/odcustomurl-ct.js':Gkod.Helper.PostfixFilename($m.Location,'-ct');
    if($m.Location===undefined)
      $m.Location = '../../../'+a[0]+'/hemi/'+((a.length>1)?a[1]+'_':'')+'odcustomurl.js';
	// Document defaults
    /*
    if($m.Document===undefined) 
      $m.Document = {};
	if($m.Document.Title===undefined)
	   $m.Document.Title = $m.Title + ' Help Menu Integration';
	if($m.Document.Path===undefined)
      $m.Document.Path = '../../../'+a[0]+ '/hemi/doc/';	
    */  
  }
}

GkodConfig._DetectPublishedApps = function(configure)
{
  var r = new Object();
  for(var m in configure.Applications)
  {
    r[m] = new Object();
    r[m].Detect = true;
  }
  return r;
}

GkodConfig.LastModified = 0;
GkodConfig.LastModifiedBy = null;
GkodConfig.UserMap = new Object();

GkodConfig._LoadConfigContent = function(co)
{
  if(!co.Published)
    return;

  co.Version = null;
  co.VersionCounter = 0;
  co.LastModified = null;
  co.LastModifiedBy = null;
  co.Comments = new Object();

  co.BrandContent = null;
  co.ConfigContent = null;
  co.Config = new Object();
  
  var rq = null;
  if(co.Location!=null)
  {
    rq = Gkod.Helper.Load(co.Location); 
    co.ConfigContent = rq.GetResponseText();
    co.BrandContent = Gkod.Helper.LoadText(Gkod.Helper.CombineUrl(co.Location,'odbrand.js')); 
  }
  
  if(co.ConfigContent==null)
    return;

  var pg = GkodConfig.CreatePage(co);
  var vars = pg.EvalConfig(co.ConfigContent);
  co.HasErrors = pg.containsError;
  co.ErrorMessage = pg.configError;

  Gkod.Helper.Override(co.Config,vars.Config);

  var __t = Gkod.Helper.FilterLines(Gkod.Helper.GetLines(co.ConfigContent),/^[\s]*Gkod\.Variables\.Config\./).join('\n');
  var __v = co.Config;
  Gkod.Helper.TryCall(function(){var Gkod={'Variables':{'Config':__v}};eval(__t);},'GkodConfig._LoadConfigContent, source='+co.Location);
  
  co.Version = __v.Version?__v.Version:Gkod.Helper.GetVersion(co.ConfigContent);
  if(co.Version)
  {
    var a = co.Version.match(/^[0-9]+\.[0-9]+\.[0-9]+\.([0-9]+)$/);
    if(a && a.length==2)
      co.VersionCounter = new Number(a[1]);
  }
  
  var date = __v.LastModified||rq.GetResponseHeader('Last-Modified')||null;
  co.LastModified = date?new Date(date):null;
  co.LastModifiedBy = Gkod.Helper.Get(__v.ModifiedBy,null);

  if(!GkodConfig.LastModifiedBy || (co.LastModifiedBy && GkodConfig.LastModified<co.LastModified))
  {
    GkodConfig.LastModified = co.LastModified;
    GkodConfig.LastModifiedBy = co.LastModifiedBy;
  }
  
  if(co.LastModifiedBy)
    GkodConfig.UserMap[co.LastModifiedBy] = co.LastModifiedBy;
    
  co.Comments = (Gkod.Helper.IsEmpty(__v.Comments)?new Object():__v.Comments);
  
  for(var m in co.Comments)
  {
    var $m = co.Comments[m];
    var modified = $m.Time?new Date($m.Time):null;
    var modifiedBy = $m.By||null;
    
    if(!GkodConfig.LastModifiedBy || (modifiedBy && GkodConfig.LastModified<modified))
    {
      GkodConfig.LastModified = modified;
      GkodConfig.LastModifiedBy = modifiedBy;
    }

    if(modifiedBy)
      GkodConfig.UserMap[modifiedBy] = modifiedBy;
  }
}

GkodConfig._LoadConfigFiles = function(list)
{
  GkodConfig.UserMap = new Object();

  var rlist = new Object();

  for (var m in list)
  {
    try
    {
      var $m = list[m];
      rlist[m] = $m;
      if(!!$m._Processed)
        continue;
      $m.TemplateContent = ($m.Template && ($m.Detect || $m.Published)) ? Gkod.Helper.LoadText($m.Template) : null;
      $m.CanEdit = ($m.TemplateContent !== null);
      if($m.Detect) $m.Published = $m.CanEdit;
      GkodConfig._LoadConfigContent($m);
      if($m.Published && $m.CanEdit)
      {
        var a = Gkod.Helper.FilterLines(Gkod.Helper.GetLines($m.TemplateContent),/^[\s]*EmbeddedApps[\s]*\.[\s]*Add[\s]*\(/);
        if(a.length>0)
        {
          var __t = a.join('\n');
          var __e = [];
          Gkod.Helper.TryCall(function(){var EmbeddedApps={Add:function(id,t){__e.push({'Id':id,'Title':t})}};eval(__t);},'GkodConfig._LoadConfigFiles, source='+$m.Template);
          for(var ie=0,en=__e.length; ie<en; ++ie)
          {
            var $ie = __e[ie];
            var nmid = (m+'/'+$ie.Id).toUpperCase();
            var was = !!list[nmid];
            var nm = (was?list[nmid]:new Object());
            nm._Processed = true;
            nm.CanEdit = true;
            nm.TemplateContent = $m.TemplateContent;
            if(!nm.Id) nm.Id = nmid;
            if(!nm.Section) nm.Section = $m.Section;
            if(!nm.Licensed) nm.Licensed = $m.Licensed;
            if(!nm.Published) nm.Published = $m.Published;
            if(!nm.Title) nm.Title = Gkod.Helper.FormatHtml(Gkrc('Config.Message.EmbeddedApp'),{'APP_TITLE':$m.Title,'EMBEDDED_TITLE':$ie.Title});
            if(!nm.Location) nm.Location = $m.Location.replace(/\/([^\/]*)$/,'/'+$ie.Id.toLowerCase()+'_$1');
            GkodConfig._LoadConfigContent(nm);
            if(!was) rlist[nmid] = nm;
          }
        }
      }
      $m._Processed = true;
    }
    catch (e) { Gkod.Helper.Exception(e, 'GkodConfig._LoadConfigFiles'); }
  }
  
  GkodConfig.UserMap = Gkod.Helper.SortMap(GkodConfig.UserMap,Gkod.Helper.CaseInsensitiveCompare);
  
  return rlist;
}

GkodConfig._OverrideAppList = function(apps,list)
{
  var undefined;
  for(var m in list)  
  {
    if(apps[m]===undefined) apps[m]={};
    Gkod.Helper.Override(apps[m],list[m]);
  }
}

GkodConfig._EnsureFields = function(list,name,value)
{
  for(var m in list)
    list[m][name] = value;
}

GkodConfig.LoadData = function() {
  //Gkod.Trace.Write('LoadData');
  try {
    if (GkodConfig.LoadSuccess)
      return true;

    var adata = Gkod.Helper.LoadJson('appdata.json.js');
    GkodConfig.AppData = adata;
    if (!adata)
      return false;
      
    if (!adata.Configure.Applications)
      adata.Configure.Applications = {};

    // MGH 6/3/09 test existence of publishdata.json
    var pdata = Gkod.Helper.PingUrl('../../../publishdata.json.js')
	          ? Gkod.Helper.LoadJson('../../../publishdata.json.js')
			  : null;

    GkodConfig.LoadSuccess = true;

    GkodConfig.Copyright = adata.Copyright;
    GkodConfig.Languages = Gkod.Helper.Get(adata.Languages, GkodConfig.Languages);
    GkodConfig.DefaultLanguage = Gkod.Helper.Get(adata.DefaultLanguage, GkodConfig.DefaultLanguage);
    if (pdata && pdata.DefaultLanguage)
      GkodConfig.DefaultLanguage = pdata.DefaultLanguage.toLowerCase();
    GkodConfig.CurrentLanguage = GkodConfig.DefaultLanguage;
    if (!GkodConfig.Languages[GkodConfig.CurrentLanguage])
      GkodConfig.CurrentLanguage = 'en';

    GkodConfig.DefaultTemplate = Gkod.Helper.LoadText('default-ct.js') || '';
    GkodConfig.DefaultResource = Gkod.Helper.CreateResourceManager(Gkrc);
    GkodConfig.DefaultResource.AttachResource('default-ct.js');

    //MATYI-20090624: add applications from publishdata not present in appdata.json
    if (pdata && pdata.Applications) {
      for (var m in pdata.Applications) {
        if (!adata.Configure.Applications[m] && m !== 'CLARITY') //MGH 9491556
          adata.Configure.Applications[m] = pdata.Applications[m];
      }
    }

    var papps = Gkod.Helper.Get(pdata ? pdata.Applications : GkodConfig._DetectPublishedApps(adata.Configure), {});

    GkodConfig._EnsureAppDefaults(adata.Configure.General);
    GkodConfig._EnsureAppDefaults(adata.Configure.Applications);
    GkodConfig._EnsureFields(adata.Configure.General, 'Section', 'General');
    GkodConfig._EnsureFields(adata.Configure.Applications, 'Section', 'Applications');
    GkodConfig._EnsureFields(papps, 'Section', 'Applications');
    GkodConfig._EnsureFields(papps, 'Licensed', true);

    var apps = {};

    GkodConfig._OverrideAppList(apps, adata.Configure.General);
    GkodConfig._OverrideAppList(apps, adata.Configure.Applications);
    GkodConfig._OverrideAppList(apps, papps);

    GkodConfig.AppList = GkodConfig._LoadConfigFiles(apps);

    var ca = { 'General': [], 'Applications': [] };
    for (var m in GkodConfig.AppList) {
      var $m = GkodConfig.AppList[m];
      if (!$m.Published || ca[$m.Section] === undefined)
        continue;
      ca[$m.Section].push($m);
    }
    GkodConfig.Configure = ca;

    GkodConfig.EnableComments = true;
  }
  catch (e) { Gkod.Helper.Exception(e, 'GkodConfig.LoadData'); }
}

GkodConfig.LoadTestData = function()
{
  //Gkod.Trace.Write('LoadTestData');
  try
  {
    if(GkodConfig.LoadSuccess)
      return true;

    var data = Gkod.Helper.LoadJson('testdata.json.js');
    if(!data)
      return false;
    GkodConfig.TestData = data;
    
    GkodConfig.LoadSuccess = true;

    GkodConfig.Copyright = data.Copyright;
    GkodConfig.Languages = Gkod.Helper.Get(data.Languages,GkodConfig.Languages);
    GkodConfig.DefaultLanguage = Gkod.Helper.Get(data.DefaultLanguage,GkodConfig.DefaultLanguage);
    GkodConfig.CurrentLanguage = GkodConfig.DefaultLanguage;
    if(!GkodConfig.Languages[GkodConfig.CurrentLanguage])
      GkodConfig.CurrentLanguage = 'en';

    GkodConfig.DefaultTemplate = Gkod.Helper.LoadText('default-ct.js')||'';
    GkodConfig.DefaultResource = Gkod.Helper.CreateResourceManager(Gkrc);
    GkodConfig.DefaultResource.AttachResource('default-ct.js');

    var apps = {};
    
    apps['$TEST'] = 
      {
        'Id':'$TEST',
        'Title':'Test',
        'Location':null,
        'Template':'test-ct.js',
        'Section':'Test',
        'Licensed':true,
        'Published':true
      };

    GkodConfig.AppList = GkodConfig._LoadConfigFiles(apps);

    GkodConfig.EnableComments = false;
    GkodConfig.Standalone = true;
  }
  catch(e) { Gkod.Helper.Exception(e,'GkodConfig.LoadTestData'); }
}


GkodConfig.GetApplicationName = function(name)
{
  if(!name)
    return Gkrc('Config.Title.Unknown');
  return (GkodConfig.AppList[name]?GkodConfig.AppList[name].Title:name);
}

GkodConfig.LoadLanguage = function(lang)
{
  if(!GkodConfig.Title)
  {
    Gkrc.LoadResources('en');
    GkodConfig.Title = Gkrc('Config.Title');
  }
  
  var undefined;
  if(lang===undefined) lang = GkodConfig.CurrentLanguage;
  if(GkodConfig.Languages[lang]===undefined) lang = 'en';
  Gkrc.LoadResources(lang);
  if(GkodConfig.DefaultResource)
    GkodConfig.DefaultResource.LoadResources(lang);
  GkodConfig.CurrentLanguage = lang;
  
  document.title = Gkrc('Config.Title');
}

/*
GkodConfig.InjectLanguageBar = function(lang)
{
  var s = '<div class="navbar">';
  for(var m in GkodConfig.Languages)
  {
    var $m = GkodConfig.Languages[m];
    s += '<a class="lbarlink'+((m==GkodConfig.CurrentLanguage)?' selected':'')+'" href="#" onclick="GkodConfig.InjectMenu(\''+m+'\');return false">'+$m+'</a>';
  }
  s += '</div>';

  var node = Gkod.Helper.Dom.E('lbar');
  node.style.display = '';  
  node.innerHTML = s;
}
*/

GkodConfig.RenderLanguageBar = function()
{
  var s = '<div class="langhead">';

  s += Gkod.Helper.FormatHtml(Gkrc('Config.Title.SelectLanguage'))
    +  '<select class="control" style="margin-left:8px; width:150px" id="lsel" '
    + 'onchange="GkodConfig.InjectMenu('
    +   'getElementById(\'lsel\').options[getElementById(\'lsel\').selectedIndex].value'
    + ')">';
  
  for(var m in GkodConfig.Languages)
  {
    var $m = GkodConfig.Languages[m];
    s += '<option value="' + m + '"'
      +  ( (m==GkodConfig.CurrentLanguage) ? ' selected' : '' )
      +  '>' + $m + '</option>';
  }    
  
  s += '</select></div>';
 
  return s;
}

GkodConfig.EditedBy_Id = Gkod.Helper.UniqueId('eby');
GkodConfig.EditedBy = null;

GkodConfig.GetEditedBy = function()
{
  var n = Gkod.Helper.Dom.Get(GkodConfig.EditedBy_Id+'_i');
  if(!n||!n.value)
    return '';
  if(!GkodConfig.UserMap[n.value])
  {
    GkodConfig.UserMap[n.value] = n.value;
    GkodConfig.UserMap = Gkod.Helper.SortMap(GkodConfig.UserMap,Gkod.Helper.CaseInsensitiveCompare);
  }
  return n.value;
}

/*
GkodConfig.InjectUserBar = function(lang)
{
  var modifiedBy = GkodConfig.LastModifiedBy||'';

  if(Gkod.Helper.Dom.Get(GkodConfig.EditedBy_Id+'_i'))
    modifiedBy = GkodConfig.GetEditedBy();

  var users = [];
  
  GkodConfig.EditedBy = new GkodConfig.TypeIn({'Width':150},GkodConfig.UserMap,modifiedBy);
  var dob = GkodConfig.EditedBy.DecompileObject(modifiedBy);

  var s = 
    '<div class="navbar"><table width="100%" cellspacing="0" cellpadding="0"><tr>'+
      '<td><b>'+Gkod.Helper.FormatHtml(Gkrc('Config.Title.EditedBy'))+'</b></td>'+
      '<td width="1">'+GkodConfig.EditedBy.RenderControl({'id':GkodConfig.EditedBy_Id,'dob':dob})+'</td>'+
    '</tr></table></div>';

  var node = Gkod.Helper.Dom.E('ubar');
  node.style.display = '';  
  node.innerHTML = s;
}
*/

GkodConfig.RenderUserPane = function()
{
  var modifiedBy = GkodConfig.LastModifiedBy||'';

  if(Gkod.Helper.Dom.Get(GkodConfig.EditedBy_Id+'_i'))
    modifiedBy = GkodConfig.GetEditedBy();

  var users = [];
  
  GkodConfig.EditedBy = new GkodConfig.TypeIn({'Width':150},GkodConfig.UserMap,modifiedBy);
  var dob = GkodConfig.EditedBy.DecompileObject(modifiedBy);

  var s = 
    '<div class="ubar"><table cellspacing="0" cellpadding="0"><tr>'+
      '<td style="text-align:right;padding-right:8px"><div class="text">'+Gkod.Helper.FormatHtml(Gkrc('Config.Title.EditedBy'))+'</div></td>'+
      '<td>'+GkodConfig.EditedBy.RenderControl({'id':GkodConfig.EditedBy_Id,'dob':dob})+'</td>'+
    '</tr></table></div>';

  return s;
}

/*
GkodConfig.InjectNavigationBar = function()
{
  var s = '<div class="navbar right"><a class="lbarlink" href="#" onclick="if(GkodConfig.Page.Cancel())GkodConfig.InjectMenu();return false">'+Gkrc('Config.Title')+'</a></div><div class="navbar">&nbsp;</div>';
  var node = Gkod.Helper.Dom.E('lbar');
  node.style.display = '';  
  node.innerHTML = s;
}
*/

/*
GkodConfig.ClearLanguageBar = function()
{
  var node = Gkod.Helper.Dom.E('lbar');
  node.style.display = 'none';  
  node.innerHTML = '';
}
*/

GkodConfig.InjectLoading = function()
{
  Gkod.Helper.Dom.E('page').innerHTML = '<div class="title">'+Gkod.Helper.EscapeHtml(Gkrc('Config.Message.Loading'))+'</div>';
}

GkodConfig.InjectMenu = function(lang)
{
  GkodConfig.LoadData();
  
  GkodConfig.LoadLanguage(lang);
  GkodConfig.DelayedPageUpdate(GkodConfig.InjectLoading);
  GkodConfig.InjectMainMenu();
}

GkodConfig.InjectTest = function(lang)
{
  GkodConfig.LoadTestData();
  
  GkodConfig.LoadLanguage(lang);
  GkodConfig.DelayedPageUpdate(GkodConfig.InjectLoading);
  
  if(GkodConfig.AppList)
    GkodConfig.InjectConfigPage(GkodConfig.AppList['$TEST']);
  else GkodConfig.InjectMainMenu();
}

/*
GkodConfig.InjectSelector = function(a,id)
{
  var undefined;
  if(id===undefined) id='page';
  
  try
  {
    var url = new Gkod.Helper.Url(document.URL);
    var lang = url.GetParam('lang','en');
  
    var s =
      '<div class="title">'+
        Gkod.Helper.EscapeHtml(Gkrc('Config.Message.SelectorTitle'))+
      '</div>'+
      '<div class="head"><div class="help">'+
        Gkod.Helper.EscapeHtml((!a||a.length==0)?Gkrc('Config.Message.NoConfig'):Gkrc('Config.Message.SelectorHelp'))+
      '</div></div>'
    ;
    
    if(!!a && a.length>0)
    {
      s += '<div class="body"><div class="scriptlist">';
      for(var i=0,n=a.length; i<n; ++i)
        s += '<div style="scriptitem"><table cellspacing="0" cellpadding="0"><tr><td><div class="llink"><a class="action" href="?name='+a[i]+'&lang='+lang+'">'+a[i]+'.js</a></div></td></tr></table></div>';
      s += '</div></div>';
    }
    
    Gkod.Helper.Dom.E(id).innerHTML = s;
  }
  catch(e) { Gkod.Helper.Exception(e, 'GkodConfig.InjectSelector failed'); }
}
*/

GkodConfig.RenderHead = function(title,subtitle,buttons)
{
  var s_buttons = buttons?'<div class="page_buttons"><table cellspacing="0" cellpadding="0"><tr><td>'+buttons.join('</td><td>')+'</tr></table></div>':'';
  var s_header = subtitle?'<div class="page_header"><table width="100%" cellspacing="0" cellpadding="0"><tr><td>'+s_buttons+'<div class="page_menu">'+subtitle+'</div></td></tr></table></div>':'';
  var s = ''
        + (GkodConfig.EnableComments?'<div style="position:absolute"><div style="position:relative;left:400px;width:294px;padding-top:6px;"><div style="float:right">'+GkodConfig.RenderUserPane()+'</div></div></div>':'')
        + '<div class="page_banner">'
        + '<div class="page_head">'
//        + (GkodConfig.EnableComments?'<div style="position:absolute"><div style="position:relative;left:400px;width:294px;padding-top:6px;"><div style="float:right">'+GkodConfig.RenderUserPane()+'</div></div></div>':'')
        + '<div>'
        + '<table width="100%" cellspacing="0" cellpadding="0"><tr height="90"><td valign="bottom">'
        + '<div class="page_title" style="float:left;clear:both">'+title+'</div>'
        + '</td></tr></table>'
        + '</div>'
        + '</div>'
        + s_header
        + '</div>'
        ;
  return s;
}

GkodConfig.RenderAppPalette = function(list,title,emptyMsg)
{
  var empty = Gkod.Helper.IsEmpty(list);
  if(empty&&Gkod.Helper.IsNull(emptyMsg))
    return '';

  var body = '';

  if(empty)
  {
    body += 
      '<tr class="odd"><td colspan="3"><div class="app_empty">'+emptyMsg+'</div></td></tr>';
  }
  else
  {
    for(var i=0,n=list.length; i<n; ++i)
    {
      var $i = list[i];
      if (!$i.Published || !$i.CanEdit) // MGH: 8925787, 8976256, 8976267
        continue;
      
      body +=
        '<tr class="'+(i%2?'even':'odd')+'">'+
            '<td class="list_cell" valign="top">'+
              ($i.CanEdit?
                '<a class="aaction" href="#" onclick="GkodConfig.ConfigPage_Application(\''+$i.Id+'\');return false">'+Gkod.Helper.EscapeHtml($i.Title)+'</a>':
                '<span class="noneditable">'+Gkod.Helper.EscapeHtml($i.Title)+'</span>'
              )+
              ($i.HasErrors?'<div class="error"><b>'+Gkod.Helper.FormatHtml(Gkrc('Config.Message.JavaScriptErrorInfo'),{'ERROR':$i.ErrorMessage})+'</b></div>':'')+
              (($i.Config&&$i.Config.ApplicationName&&($i.Config.ApplicationName!=$i.Id))?'<div class="error"><b>'+Gkod.Helper.FormatHtml(Gkrc('Config.Message.ApplicationErrorInfo'),{'NAME':GkodConfig.GetApplicationName($i.Config.ApplicationName)})+'</b></div>':'')+
            '</td>'+
            '<td class="list_cell" valign="top"><div class="app_info">'+GkodConfig._RenderAppInfo($i)+'</div></td>'+
            '<td class="list_cell" width="1" valign="top"><div style="width:1px;overflow:visible;">'+GkodConfig._RenderAppComment($i)+'</div></td>'+
        '</tr>'
      ;
    }
  }
    
  var s = 
    '<div class="palette">'+
    '<div class="palette_body"><div class="app_listsection"><div class="app_list">'+
      '<div class="body">'+
        '<table width="100%" cellspacing="0" cellpadding="0" border="0">'+ // border="1"
          '<thead><tr>'+
            '<td valign="bottom"><div class="app_section">'+Gkod.Helper.EscapeHtml(title)+'</div></td>'+
            '<td width="40%" valign="bottom" align="center">'+Gkrc('Config.Title.Description')+'</td>'+
            '<td width="1"><div style="width:1px;height:0px;overflow:hidden;">&nbsp;</div></td>'+
          '</tr></thead>'+
          '<tbody>'+body+'</tbody>'+
        '</table>'+
      '</div>'+
    '</div></div></div>'+
    '</div>'
  ;
  
  return s;
}

GkodConfig._RenderAppComment = function(app)
{
  if(!app.Comments || !app.Comments[''])
    return '<div style="width:1px;overflow:hidden">&nbsp;</div>';

  var c = app.Comments[''];
  return Gkod.Helper.RenderComment
    (
      '<div style="width:270px;padding-left:10px">'+
        GkodConfig._RenderComment(null,c.Comment,c.By,c.Time)+
      '</div>'
    )
  ;
}
      
GkodConfig._RenderAppInfo = function(app)
{
  if(!app.CanEdit)
    return Gkrc('Config.Message.NotEditable');

  if(!app.LastModified)
    return Gkrc('Config.Message.NotConfigured');

  var s =
  // start MGH IR 28713 remove file version
  // ...only need to comment out original line 
  //  (app.Version?'<div>'+Gkod.Helper.FormatHtml(Gkrc('Config.Message.VersionInfo'),{'VERSION':'<b>'+app.Version+'</b>'})+'</div>':'')+
  // end MGH IR 28713 remove file version
    Gkod.Helper.FormatHtml
      (
        (app.LastModifiedBy?Gkrc('Config.Message.LastModifiedByOn'):Gkrc('Config.Message.LastModifiedOn')),
        {
          'PERSON':'<b>'+(app.LastModifiedBy?app.LastModifiedBy:Gkrc('Config.Message.Unknown'))+'</b>',
          'TIME':app.LastModified.toLocaleTimeString(),
          'DATE':app.LastModified.toLocaleDateString()
        }
      )
  ;
  return s;
}

GkodConfig._RenderComment = function(name,comment,by,time,head,onclick,footer,eid)
{
  if(by=='') by = null;

  var comment_by = (by?'<b>'+Gkod.Helper.EscapeHtml(by)+'</b>':'');
  var comment_time = (time?new Date(time).toLocaleDateString():'');
  var comment_date = (time?new Date(time).toLocaleDateString():'');
  var active = !!onclick||!(time>0);
  var messageHead = 
  (
    by?
      (time?Gkrc('Config.Message.SomebodyWroteOn'):Gkrc('Config.Message.SomebodySays')):
      (time?Gkrc('Config.Message.UnknownWroteOn'):Gkrc('Config.Message.UnknownSays'))
  );
  
  if(name==='') messageHead = Gkod.Helper.Strip(messageHead);

  var s =
    ((active)?'<div'+(onclick?Gkod.Helper.RenderMouseHover('active')+' onclick="'+onclick+'"':'')+((time>0)?'':' class="static"')+'>':'')+
      '<div class="comment_box">'+
        (head?head:'')+
        '<div class="comment_a">'+
          Gkod.Helper.FormatHtml(messageHead,{'PERSON':comment_by,'DATE':comment_date})+
        '</div>'+
        '<div class="comment_hbox"><div class="comment_h"></div></div>'+
        '<div class="comment_bbox">'+
          '<div class="comment_frame">'+
            '<div class="comment_b">'+
              '<div class="comment_text">'+
                (eid?'<textarea id="'+eid+'"'+(name==''?' class="large"':'')+' rows="6">'+Gkod.Helper.EscapeHtml(comment)+'</textarea>':Gkod.Helper.FormatHtml(comment))+
              '</div>'+
              (footer&&eid?'<div class="comment_foot">'+footer+'</div>':'')+
            '</div>'+
          '</div>'+
        '</div>'+
      '</div>'+
    ((active)?'</div>':'')
  ;

  return s;
}

GkodConfig.InjectMainMenu = function()
{
  GkodConfig.CancelPageUpdate();

  try
  {
    var s = 
      GkodConfig.RenderHead
      (
        Gkod.Helper.EscapeHtml(Gkrc('Config.Title')),
        GkodConfig.RenderLanguageBar()
      );

    var cfg = GkodConfig.Configure;
    if(cfg)
    {
      s +=
        '<div class="page_explainhead">'+Gkod.Helper.FormatHtml(Gkrc('Config.Explain'))+'</div>'+
        '<div class="page_body">'+
        '<div class="page_dlg">'+
          GkodConfig.RenderAppPalette(cfg.Applications,Gkrc('Config.ApplicationSection'))+
          GkodConfig.RenderAppPalette(cfg.General,Gkrc('Config.GeneralSection'))+
        '</div>'+
        '</div>'
      ;
    }
    else
    {
      s+=
        '<div class="page_body">'+
        '<div class="page_dlg">'+
          '<div class="dlgerror">'+
            '<div class="dlgerrorbody">'+
              '<div class="dlgerrortitle">'+Gkrc('Config.Message.NothingToConfigure')+'</div>'+
            '</div>'+
          '</div>'+
        '</div>'+
        '</div>'
      ;
    }
    
    Gkod.Helper.Dom.E('page').innerHTML = s;
  }
  catch(e) { Gkod.Helper.Exception(e,'GkodConfig.InjectMainMenu failed'); }          
}

GkodConfig.ConfigPage_Application = function(id)
{
  var app = GkodConfig.AppList[id];
  if(!app) return;

  GkodConfig.InjectConfigPage(app);
}

GkodConfig.CreatePage = function(app)
{
  var epos = app.Id.indexOf('/');
  var name = (epos>=0)?app.Id.substr(0,epos):app.Id;
  var embeddedName = (epos>=0)?app.Id.substr(epos+1):null;

  var irc = Gkod.Helper.CreateResourceManager(GkodConfig.DefaultResource);
  irc.AttachResource(app.Template);
  irc.LoadResources(GkodConfig.CurrentLanguage);

  var pg = new GkodConfig.ConfigPage(irc,app);

  var __template  = app.Template;
  var __t_default = '(function(){'+GkodConfig.DefaultTemplate+'}).call(this);';
  var __t_content = '(function(){'+app.TemplateContent+'}).call(this);';

  GkodConfig._TemplateMap = new GkodConfig.TemplateMap();

  try
  {
    (
      function(Page)
      {
        var evalIx = 0;
        try
        {
          var Defaults = new Object();
          var Types = new Object();
          var AppName = app.Id;
          var EmbeddedApp = embeddedName;
          var EmbeddedApps = {Add:function(){}};
          var Templates = GkodConfig._TemplateMap;
          var Gkrc = irc;
          evalIx = 1;
          eval(__t_default);
          evalIx = 2;
          eval(__t_content);
          Page.tdefaults = Defaults;
        }
        catch(e)
        {
          Page.containsError = true;
          Page.configError = ((evalIx==2)?__template:'default-ct.js')+': '+Gkod.Helper.GetException(e);
        }
      }
    ).call(this,pg);
  }
  catch(e) { Gkod.Helper.Exception(e, 'GkodConfig.InjectConfigPage failed: '+url); }

  // GkodConfig._TemplateMap = null;
  
  return pg;
}

GkodConfig.InjectConfigPage = function(app)
{
  GkodConfig.DelayedPageUpdate(GkodConfig.InjectLoading);
  GkodConfig.Page = GkodConfig.CreatePage(app);
  GkodConfig.Page._Reload();  
}

// ConfigPage
// ==========================================================================

GkodConfig.ConfigPage = function(rc, app) {
  var al = app.Location;
  if (!al) al = 'config.js';
  var a = al.match(/([^\/]+)$/);
  var filename = a[1];

  this.rc = rc;
  this.app = app;
  this.title = app.Title;
  this.name = app.Id;
  this.location = al;
  this.hasRequired = false;
  this.advancedCount = 0;
  this.visibleAdvanced = 0;
  this.section = null;
  this.sectionList = [];
  this.sectionMap = {};
  this.has$vn = {};
  this.va$name = {};
  this.va$id = {};
  this.ca$vn = {};
  this.filename = filename;
  this.saverScripts = ['saveit.odph', 'saveit.php', 'saveit.asp', 'saveit.jsp'];
  this.currentScript = 0;
  this.lastScript = 0;
  this.tryScript = null;
  this.containsError = false;
  this.configError = null;
  this.tdefaults = {}; // template defaults
  this.cdefaults = {};
  this.variables = {};
  this.original = {};
  this.comment = new GkodConfig.$Comment('page_cc', '');
  this.modified = false;
  this.canreset = false;
  this.commentChanged = false;
  this.currentVersion = null;
  this.currentModifiedBy = null;
  this.autoCheck = false;
  this.configVisible = false;
  
  var that = this;
  this.smoothvalidation = new Gkod.Helper.SmoothActivation
  (
    {
      'atime': 100,
      'dtime': 200,
      'Deactivate': function(id) { that.Variable_Deactivate(id); }
    }
  );
} 

GkodConfig.ConfigPage.prototype.CloneDefaults = function()
{
  var v = {};
  try
  { 
    // MGH 6/3/09 added test for undefined methods
	var undefined;
    if ( Gkod.Variables.Reset !== undefined ) 
		Gkod.Variables.Reset.call(v);
    if ( Gkod.Variables.Reset2 !== undefined ) 
		Gkod.Variables.Reset2.call(v);
    if (this.app && this.app.BrandContent) try { (function(c) { var Gkod = { 'Variables': v }; eval(c); }).call(this, this.app.BrandContent); } catch (e) { }
    Gkod.Helper.Override(v,Gkod.Helper.DeepClone(this.tdefaults));
  }
  catch(e) { Gkod.Helper.Exception(e, 'GkodConfig.Page.CloneDefaults call'); }
  return v;
}

GkodConfig.ConfigPage.prototype.EvalConfig = function(content)
{
  var v = this.CloneDefaults();
  var $ok = false;
  try { (function(){var Gkod={'Variables':v};eval(content)||'';}).call(); $ok=true; }
  catch(e)
  {
    this.containsError = true;
    this.configError = Gkod.Helper.GetException(e);
  }
  
  return v;
}

GkodConfig.ConfigPage.prototype.SetModified = function(modified)
{
  if(this.modified == modified)
    return;
  this.modified = modified;
  Gkod.Helper.Dom.Show(null,'modified',modified);
}

GkodConfig.ConfigPage.prototype.SetCanReset = function(canreset)
{
  if(this.canreset == canreset)
    return;
  // alert('CanReset:'+(canreset?'YES':'NO'));
  this.canreset = canreset;
  Gkod.Helper.Dom.Show(null,'i_reset',canreset);
  Gkod.Helper.Dom.Show(null,'i_dreset',!canreset);
}

GkodConfig.ConfigPage.prototype.ResetToDefaults = function()
{
  for(var xid in this.va$id)
  {
    var xva = this.va$id[xid];
    if(!xva.Enabled()) continue;
    if(xva.canreset)
      this.Variable_Reset(xid,true); 
  }
}

GkodConfig.ConfigPage.prototype.CheckModified = function()
{
  if(this.commentChanged)
    this.SetModified(true);
  else
  {
    var modified = false;
    var canreset = false;
    for(var xid in this.va$id)
    {
      var xva = this.va$id[xid];
      if(!xva.Enabled()) continue;
      if(xva.canreset) canreset = true;
      if(xva.modified) modified = true;
      if(canreset && modified) break;
    }
    this.SetModified(modified);
    this.SetCanReset(canreset);
  }
}

GkodConfig.ConfigPage.prototype.Validate = function(changeList,sync)
{
  var o = {};

  var modified = this.commentChanged;
  this.valid = true;
  for(var id in this.va$id)
  {
    var va = this.va$id[id];
    if(!va.Enabled()) continue;
    var v = this.Variable_Validate(id,false,changeList,true,sync);
    if(!va.valid) this.valid = false;
    if(va.modified) modified = true;
    if(va.cansave) o[va.varname] = v;
  }
  
  this.SetModified(modified);

  return o;
}

GkodConfig.ConfigPage.prototype._Reload = function()
{
  var undefined;

  var that = this;
  GkodConfig.DelayedPageUpdate(function(){that.InjectStep0()});

  try
  {
    GkodConfig._LoadConfigContent(this.app);
    
    this.commentChanged = false;
    this.SetModified(false);

    var v = null;
    
    if(this.DoLoad !== undefined)
    {
      this.DoLoad.call(this);
    }
    else
    {
      GkodConfig.CancelPageUpdate();
      
      this.configVisible = false;

      this.cdefaults = this.CloneDefaults();
      v = this.EvalConfig(this.app.ConfigContent);
      
      if(this.onLoad !== undefined)
      {
        var nv = this.onLoad.call(this,v);
        if(nv !== undefined) v = nv;
      }
      
      this.original = Gkod.Helper.DeepClone(v); // create a clone of the original configuration
      if(!Gkod.Helper.Equals(this.original,v)) alert('Gkod.Helper.DeepClone error');
          
      this.BindConfig(v);
      this.Bind(v);
      this.InjectStep1();
      this.CheckModified();
    }
  }
  catch(e) { Gkod.Helper.Exception(e,'GkodConfig.ConfigPage._Reload'); }
}

GkodConfig.ConfigPage.prototype.Edit = function()
{
  ++this.app.VersionCounter;
  var v = this.variables;
  this.Bind(v);
  this.InjectStep1();
}

GkodConfig.ConfigPage.prototype.LoadCompleted = function(obj)
{
  try
  {
    GkodConfig.CancelPageUpdate();
    this.cdefaults = this.CloneDefaults();
    this.original = Gkod.Helper.DeepClone(obj);
    this.BindConfig(obj);
    this.Bind(obj);
    this.InjectStep1();
    this.CheckModified();
  }
  catch(e) { Gkod.Helper.Exception(e,'GkodConfig.ConfigPage.LoadCompleted'); }
}

GkodConfig.ConfigPage.prototype.SaveCompleted = function(ok)
{
  GkodConfig.CancelPageUpdate();

  this.autoCheck = false;
}

GkodConfig.ConfigPage.prototype.OverrideVariables = function(variables)
{
  Gkod.Helper.Override(this.variables, variables);
  Gkod.Helper.Override(this.original, variables);
}

GkodConfig.ConfigPage.prototype.SaveAndCheck = function()
{
  this.autoCheck = true;
  return this.Save();
}

GkodConfig.ConfigPage.prototype.Save = function()
{
  this.smoothvalidation.Cancel();
  
  var changeList = new Array();
  var o = this.Validate(changeList,true);
  if(changeList.length>0)
    this.ApplyChanges(changeList);

  if(!this.valid && !confirm(Gkrc('Config.Message.ConfirmSaveInvalid')))
    return false;

  if (this.name == '_SMARTHELP_') {
    o['OD_ENABLESMARTHELP'] = 1;
    //Gkod.Trace.Dump('o:', o);
  }
  
  if(this.DoSave)
    return this.DoSave(o,this.original);
  
  var now = new Date();
  this.time = now.getTime();
  this.currentVersion = GkodConfig.AppVersion+'.'+(this.app.VersionCounter+1);
  this.currentModifiedBy = GkodConfig.GetEditedBy();
  
  var sa =
  [
    '/*--',
    GkodConfig.Copyright,
    '--*/',
    '',
    '// Generated by '+GkodConfig.Title+'. Do not edit manually!',
    '// '+now.toUTCString(),
    '',
    'Gkod.Variables.Config = {};',
    '',
    '// Customized variables',
    this.$Serialize('Gkod.Variables',o),
    '',
    '// Extra variables',
    this.$Serialize('Gkod.Variables',this.extra),
    '',
    '// Configurator',
    'Gkod.Variables.Config.Version = '+Gkod.Helper.Serialize(this.currentVersion)+';',
    'Gkod.Variables.Config.ApplicationName = '+Gkod.Helper.Serialize(this.name)+';',
    'Gkod.Variables.Config.ModifiedBy = '+Gkod.Helper.Serialize(this.currentModifiedBy)+';',
    'Gkod.Variables.Config.LastModified = '+this.time+';', 
    this.$Serialize('Gkod.Variables.Config',{'Comments':this.comments},true),
    ''
  ];

  var v = this.CloneDefaults();
  Gkod.Helper.Override(v,o);  
  Gkod.Helper.Override(v,this.extra);
  this.variables = v;  
    
  this.saveit_l = this.location;
  this.saveit_f = this.filename;
  this.saveit_c = sa.join("\r\n");

  var that = this;
  GkodConfig.DelayedPageUpdate(function(){that.InjectStep2()});

  this.$SaveContent_TryNextScript(false);
  return true;
}

GkodConfig.ConfigPage.prototype.SaveAgain = function(noInject)
{
  this.autoCheck = false;

  var undefined;
  if(this.saveit_l === undefined ||
     this.saveit_f === undefined ||
     this.saveit_c === undefined)
     return;

  if(!noInject)
  {
    var that = this;
    GkodConfig.DelayedPageUpdate(function(){that.InjectStep2()});
  }
    
  this.$SaveContent_TryNextScript(false);
}

GkodConfig.ConfigPage.prototype.ToggleSaveManually = function()
{
  Gkod.Helper.Dom.Toggle(null,'i_savetext');
  Gkod.Helper.Dom.Toggle(null,'i_savemanually');
  Gkod.Helper.Dom.Toggle(null,'i_selectall');
  if(Gkod.Helper.Dom.IsVisible(Gkod.Helper.Dom.E('i_savetext')))
    Gkod.Helper.Dom.Focus(null,'i_savetext');
}

GkodConfig.ConfigPage.prototype.Reload = function()
{
  this.smoothvalidation.Cancel();
  this.Validate();
  
  if(!confirm(Gkrc('Config.Message.ConfirmReload')))
    return false;
    
  this._Reload();
}

GkodConfig.ConfigPage.prototype.DoReload = function(message,type,noAutoHide)
{
  this._Reload();
}

GkodConfig.ConfigPage.prototype.Exit = function(forceExit)
{
  this.smoothvalidation.Cancel();
  
  if(!forceExit)
  {
    this.Validate();
    
    if(this.modified && !confirm(Gkrc('Config.Message.ConfirmExit')))
      return false;
  }
  
  GkodConfig._LoadConfigContent(this.app);
  GkodConfig.InjectMenu();
}

GkodConfig.ConfigPage.prototype.HideSaveManually = function()
{
  //Gkod.Helper.Dom.E('savemanuallybtn').style.display = '';
  //Gkod.Helper.Dom.E('savemanually').style.display = 'none';
}

GkodConfig.ConfigPage.prototype.SelectCopyText = function()
{
  Gkod.Helper.Dom.Focus(null,'savetext');
}

GkodConfig.ConfigPage.prototype.Verify = function()
{
  this.InjectStep3();

  var that = this;
  Gkod.Helper.AsyncLoad(this.location, function(content,request){that.VerifyConfig(content,request.GetResponseHeader('Last-Modified'));});
}

GkodConfig.ConfigPage.prototype.VerifyConfig = function(content,lastModified)
{
  var msg = null;
  var hasError = true;
  var config = new Object();

  if(content===null)
    msg = Gkrc('Config.Message.VerifyConfigNotFound');
  else
  {
    var v = this.EvalConfig(content);
    if(this.containsError) // set by EvalConfig
      msg = Gkrc('Config.Message.VerifyConfigError');
    else
    {
      var differentVersion = 
      (
        !v.Config || 
        v.Config.LastModified!=this.time ||
        v.Config.ApplicationName!=this.name ||
        v.Config.Version!=this.currentVersion ||
        v.Config.ModifiedBy!=this.currentModifiedBy
      );

      config = v.Config||config;
      //MATYI:Comparison fixed when fixing BUG:8795988
      var differentConfig = !Gkod.Helper.Equals(this.comments||{},config.Comments||{});
      delete v.Config;
      
      if(!config.LastModified)
        config.LastModified = lastModified;
      if(!config.Version)
        config.Version = Gkod.Helper.GetVersion(content);

      if(differentConfig || !Gkod.Helper.Equals(this.variables,v))
        msg = differentVersion?Gkrc('Config.Message.VerifyDifferent'):Gkrc('Config.Message.VerifyDifferentContent');
      else if(differentVersion)
        msg = Gkrc('Config.Message.VerifyDifferentVersion');
      else
      {
        msg = Gkrc('Config.Message.VerifySuccess');
        hasError = false;
      }
    }
  }
  
  var verify = Gkod.Helper.Dom.E('verify');
  verify.innerHTML = Gkod.Helper.FormatHtml(msg);
  verify.className = (hasError?'error':'success');
  
  if(content)
    Gkod.Helper.Dom.E('serverdetails').innerHTML = this._RenderConfigDetails(config);

  Gkod.Helper.Dom.Show(null,'serverconfig',!!content);
  Gkod.Helper.Dom.Show(null,'currentconfig',hasError);
}

GkodConfig.ConfigPage.prototype.Cancel = function()
{
  return confirm(Gkrc('Config.Message.ConfirmExit'));
}

GkodConfig.ConfigPage.prototype.Item = function(id)
{
  return this.va$id[id];
}

GkodConfig.ConfigPage.prototype.AddItem = function(id)
{
  this.va$id[id].AddItem();
  this.Variable_Validate(id,true);
}

GkodConfig.ConfigPage.prototype.DeleteItem = function(id,ix)
{
  this.va$id[id].DeleteItem(ix);
  this.Variable_Validate(id,true);
}

GkodConfig.ConfigPage.prototype.UndeleteItem = function(id,ix)
{
  this.va$id[id].UndeleteItem(ix);
  this.Variable_Validate(id,true);
}

GkodConfig.ConfigPage.prototype.AddSection = function(rcid, flags)
{
  var undefined;
  var name = rcid?rcid:'';
  if(this.sectionMap[name] === undefined)
  {
    var rc = {};
    rc.Title = rcid?this.rc('CT.Section.'+rcid):null;
    rc.Show = rcid?this.rc('CT.Section.'+rcid+'.Show',null):null;
    rc.Hidden = rcid?this.rc('CT.Section.'+rcid+'.Hidden',null):null;
    var o = new GkodConfig.$Section(name, rc, flags);
    this.sectionMap[name] = o;
    this.sectionList.push(o);
    this.section = o;
  }
  else this.section = this.sectionMap[name];
}

GkodConfig.ConfigPage.prototype.AddVariable = function(name, type, flags)
{
  if(!name) throw 'GkodConfig.ConfigPage.AddVariable: undefined name';
  if(!type) throw 'GkodConfig.ConfigPage.AddVariable('+name+'): undefined type';

  this.$EnsureSection();
  var id = Gkod.Helper.UniqueId('va');
  var obj = new GkodConfig.$Variable(this.rc, id, name, type, flags);
  if(obj.required) this.hasRequired = true;
  if(obj.advanced) ++this.advancedCount;
  this.has$vn[obj.varname] = true;
  this.va$name[name] = obj;
  this.va$id[id] = obj;

  if(obj.varcond)
  {
    var undefined;
    var ca = obj.varcond.split('=',2);
    if(ca.length==2)
    {
      if(this.ca$vn[ca[0]]===undefined)
        this.ca$vn[ca[0]] = [];
      this.ca$vn[ca[0]].push(id);
    }
  }

  this.section.Add(obj);
}

GkodConfig.ConfigPage.prototype.AddTemplate = function(name,ignoreList)
{
  var t;
  if(!GkodConfig._TemplateMap||(t=GkodConfig._TemplateMap.Get(name))==null)
    return;
  var currentSection = this.section;
  for(var sn in t.sections)
  {
    var st = t.sections[sn];
    this.AddSection(sn);
    for(var sti=0; sti<st.length; ++sti)
    {
      var st$ = st[sti];
      if(ignoreList && Gkod.Helper.Contains(ignoreList,st$.name.split('[')[0]))
        continue;
      this.AddVariable(st$.name,st$.type,st$.flags);
    }
  }
  this.section = currentSection;
}

GkodConfig.ConfigPage.prototype.BindConfig = function(v)
{
  this.config = v.Config||new Object();
  this.comments = this.config.Comments||new Object();
  delete v.Config;
}

GkodConfig.ConfigPage.prototype.Bind = function(v)
{
  this.variables = v;

  // put unconfigured variables to extra
  var x = {};
  for(var m in v)
    if(!this.has$vn[m] && !Gkod.Helper.Equals(v[m],this.cdefaults[m]))
        x[m] = v[m];
  this.extra = x;

  for(var i=0; i<this.sectionList.length; ++i)
    this.sectionList[i].BindPage(this);
}

GkodConfig.ConfigPage.prototype.InjectStep0 = function(id)
{
  var undefined;
  if(id===undefined) id='page';
  
  try
  {
    var s = 
      GkodConfig.RenderHead(Gkod.Helper.FormatHtml(this.title))+
      '<div class="page_body">'+
        '<div class="page_explainhead">'+
          Gkod.Helper.EscapeHtml(Gkrc('Config.Message.Loading'))+
        '</div>'+
      '</div>'
    ;

    this.configVisible = false;
    Gkod.Helper.Dom.E(id).innerHTML = s;
  }
  catch(e) { Gkod.Helper.Exception(e, 'InjectStep0 failed'); }
}

GkodConfig.ConfigPage.prototype.GetDocumentURL = function()
{
  //Gkod.Trace.Dump('this.app.Id',this.app.Id);
  if( GkodConfig.AppData==undefined )
    return;
  /*
  if( GkodConfig.AppData.Configure.Applications[this.app.Id] !== undefined
      && GkodConfig.AppData.Configure.Applications[this.app.Id].Document !== undefined
	)
  {  
    var url = encodeURI( GkodConfig.AppData.Configure.Applications[this.app.Id].Document.Path 
	                   + GkodConfig.AppData.Configure.Applications[this.app.Id].Document.Title 
		               + '_' + GkodConfig.CurrentLanguage.toLowerCase() + '.pdf'
                       );
    if(Gkod.Helper.PingUrl(url))
	  return url;				
  }
  return;
  */
  var url = encodeURI('../../../inappguide/index.html');
  if (Gkod.Helper.PingUrl(url))
    return url;
  return;				
}

GkodConfig.ConfigPage.prototype.InjectStep1 = function(id)
{
  //Gkod.Trace.Write('InjectStep1');
  var undefined;
  if(id===undefined) id='page';

//      '<div class="page_head">'+
        /*'<div style="float:right;width:1px;overflow:visible">'+
          Gkod.Helper.RenderComment
          (
            '<div style="width:270px;padding-left:8px">'+
              this.comment.Build()+
            '</div>'
          )+
        '</div>'+*/
//        '<div class="page_title">'+Gkod.Helper.FormatHtml(this.title)+'&nbsp;<span id="modified" class="page_modified"'+(this.modified?'':' style="display:none"')+'>[modified]</span></div>'+
//      '</div>'+

  var commands = 
    new Array
    (
      '<a href="#" onclick="GkodConfig.Page.SaveAndCheck();return false">'+Gkrc('Config.Action.Save')+'</a>',
      '<a href="#" onclick="GkodConfig.Page.Reload();return false">'+Gkrc('Config.Action.Reload')+'</a>'
    );

  if(!GkodConfig.Standalone)
    commands.push('<a href="#" onclick="GkodConfig.Page.Exit();return false">'+Gkrc('Config.Action.Exit')+'</a>');

	try
  {
    var s = 
      GkodConfig.RenderHead
      (
        Gkod.Helper.FormatHtml(this.title)+'&nbsp;<span id="modified" class="page_modified" style="'+(this.modified?'':'display:none')+'">[modified]</span>',
		'<div class="page_subtitle">'+Gkrc('Config.Title.EditConfiguration')+'</div>'
      )+
      '<div class="page_body">'+
        '<div class="page_content">'+
          '<div class="page_dlghead">'+
            (
              (this.app.Config&&this.app.Config.ApplicationName&&(this.app.Config.ApplicationName!=this.name))
                ?
              '<div class="dlgerror">'+
                '<div class="dlgerrorbody">'+
                  '<b>'+Gkod.Helper.CombineUrl(window.location,this.location)+'</b>'+
                  '<br/><br/>'+
                  Gkod.Helper.FormatHtml(Gkod.Helper.Strip(Gkrc('Config.Message.ApplicationErrorInfo')),{'NAME':'<b>'+GkodConfig.GetApplicationName(this.app.Config.ApplicationName)+'</b>'})+
                '</div>'+
              '</div>'
                :
              ''
            )+
            (this.containsError?
              '<div class="dlgerror">'+
                '<div class="dlgerrorbody">'+
                  '<b>'+Gkod.Helper.CombineUrl(window.location,this.location)+'</b>'+
                  '<br/><br/>'+
                  Gkod.Helper.FormatHtml(Gkrc('Config.Message.ConfigError'),{'ERROR':'<b>'+this.configError+'</b>'})+
                  '<br/><br/>'+
                  Gkod.Helper.FormatHtml(Gkrc('Config.Message.CheckConfigFile'))+
                '</div>'+
              '</div>'
              :'')+
             (GkodConfig.EnableComments? this.comment.Build() : '') +
          '</div>'+
          '<div id="dlgbody" class="page_dlg">'+this.RenderSections()+'</div>'+
        '</div>'+
        '<div class="page_footer"><div class="page_action">'+
        this.RenderButtons(commands)+ 
		  '</div></div>'+
      '</div>'
    ;

    Gkod.Helper.Dom.E(id).innerHTML = s;
    this.configVisible = true;
    
    this.Validate();
    Gkod.Helper.Dom.Focus(null,'dlgbody');
  }
  catch(e) { Gkod.Helper.Exception(e, 'InjectStep1 failed'); }
}

GkodConfig.ConfigPage.prototype.RenderButtons = function(commands)
{
  var s = '<div class="page_action">'
        + '<table width="100%" cellspacing="0" cellpadding="0">'
		+ '<tr><td>';
  
  // Documentation		
  if( this.GetDocumentURL() )
      s += '<td><a class="page_buttons" href="'+this.GetDocumentURL()+'" target="_blank">'
	    + Gkrc('Config.Action.ShowDocumentation')
	    + '</a>';
  
  // Advanced Options  
  /*
  if( GkodConfig.AlwaysShowAdvanced && !this.advancedCount )
  {
    s += '<a class="disabled" href="#" onclick="return false">'
       + Gkrc('Config.Action.ShowAdvanced')
       + '</a>';
  }
  else if( this.advancedCount )
  {
    s += '<a id="i_advanced" href="#" onclick="GkodConfig.Page.ToggleAdvanced(true);return false">'
       + Gkrc('Config.Action.ShowAdvanced')
       + '</a>'
       + '<a id="i_hideadvanced" style="display:none" href="#" '
       + 'onclick="GkodConfig.Page.ToggleAdvanced(false);return false">'
       + Gkrc('Config.Action.HideAdvanced')
       + '</a>';
  }
  */
  
  // Reset to Defaults
  s += '<a id="i_reset" style="'+(this.canreset?'':'display:none')
     + '" href="#" onclick="GkodConfig.Page.ResetToDefaults();return false">'
     + Gkrc('Config.Action.ResetToDefaults')
     + '</a>'
     + '<a id="i_dreset" style="'
     + (this.canreset?'display:none':'')
     + '" class="disabled" href="#" onclick="return false">'
     + Gkrc('Config.Action.ResetToDefaults')
     + '</a>';
	 
  // page commands
  if( commands )
  {
    s += '</td><td style="align:right">'
       + '<div class="page_buttons">'
       + commands.join('')
	   + '</div>';
  }
  
  s += '</td></tr></table>';
  return s;
}

GkodConfig.ConfigPage.prototype.RenderSections = function()
{
  var s = '';
  
  // Ensure 'ADVANCED' section is always last
  for( var i=0,n=this.sectionList.length; i<n; ++i )
  {
    if( this.sectionList[i].name == 'ADVANCED' )
	{
	  this.sectionList.push( (this.sectionList.splice(i,1))[0] );
	  break;
	}
  }  
  
  s += '<form id="settings" name="settings" style="display:inline" action="." onsubmit="GkodConfig.Page.SaveAndCheck();return false;">';
  for(var i=0,n=this.sectionList.length; i<n; ++i)
    s += '<div>'+this.sectionList[i].Build(this)+'</div>'; // outer div is needed for reloading section
  s += '</form>';
  s += (this.hasRequired?'<div class="dlghint">'+Gkod.Helper.FormatHtml(Gkrc('Config.Message.RequiredFields'))+'</div>':'');
  
  return s;
}

GkodConfig.ConfigPage.prototype.ApplyChanges = function(changeList)
{
  for(var i=0,n=changeList.length; i<n; ++i)
  {
    var va = changeList[i];
    if(va.advanced)
    {
      this.visibleAdvanced += (va.visible?1:-1);
      if(va.visible) Gkod.Helper.Dom.Show(null,'s_'+va.sid);
    }
    Gkod.Helper.Dom.Show(null,'v_'+va.id,va.visible);
  }
  
  if(this.advancedCount)
  {
    if(this.visibleAdvanced==this.advancedCount)
      Gkod.Helper.Dom.ShowHide(null,'i_hideadvanced','i_advanced',true);
    else Gkod.Helper.Dom.ShowHide(null,'i_advanced','i_hideadvanced',true);
  }
  
  this.RenewVariableRows();
}

GkodConfig.ConfigPage.prototype.RenewVariableRows = function()
{
  var index = 0;
  for(var id in this.va$id)
  {
    var n = Gkod.Helper.Dom.E('v_'+id);
    if(Gkod.Helper.Dom.HasClassName(n,'first')) index = 0;
    var va = this.va$id[id];
    if(!va.visible) continue;
    Gkod.Helper.Dom.AddClassName(n,index%2?'even':'odd');
    Gkod.Helper.Dom.RemoveClassName(n,index%2?'odd':'even');
    ++index;
  }
}

GkodConfig.ConfigPage.prototype.ToggleAdvanced = function(show)
{
  this.smoothvalidation.Cancel();
  this.Validate();

  var changeList = new Array();
  for(var id in this.va$id)
  {
    var va = this.va$id[id];
    if(va.advanced && va.visible!=show)
    {
      va.visible = !va.visible;
      changeList.push(va);
    }
  }

  // hide all pure-advanced sections
  if(!show)
  {
    var a = this.sectionList;
    for(var i=0; i<a.length; ++i)
      if(a[i].advanced)
        Gkod.Helper.Dom.Hide(null,'s_'+a[i].id);
  }
  
  this.ApplyChanges(changeList);
}

GkodConfig.ConfigPage.prototype.InjectStep2 = function(id,updated)
{
  //Gkod.Trace.Write('InjectStep2');
  try
  {
    var undefined;
    if(id===undefined || id===null) id='page';
  
    var explainSaveSpan = '<a href="#" onclick="GkodConfig.Page.ToggleSaveManually();return false"><b>'+Gkod.Helper.FormatHtml(Gkrc('Config.Span.SaveItManually'))+'</b></a>';
    var explainSave = Gkod.Helper.FormatHtml(Gkrc('Config.Explain.'+(updated?'Update':'Save')),{'SAVE_IT_MANUALLY':explainSaveSpan});
    var checkIt = '<a href="#" onclick="GkodConfig.Page.Verify();return false"><b>'+Gkod.Helper.FormatHtml(Gkrc('Config.Span.PleaseCheck'))+'</b></a>';
    var checkServerAfterSave = Gkod.Helper.FormatHtml(Gkrc('Config.Explain.CheckServerAfter'+(updated?'Update':'Save')),{'PLEASE_CHECK':checkIt});

    var commands = 
      new Array
      (
        '<a href="#" onclick="GkodConfig.Page.Verify();return false">'+Gkrc('Config.Action.CheckServer')+'</a>',
        '<a href="#" onclick="GkodConfig.Page.Edit();return false">'+Gkrc('Config.Action.Modify')+'</a>'
      );

    if(!GkodConfig.Standalone)
      commands.push('<a href="#" onclick="GkodConfig.Page.Exit(true);return false">'+Gkrc('Config.Action.Exit')+'</a>');
  
    var s = 
      GkodConfig.RenderHead
      (
        Gkod.Helper.FormatHtml(this.title),
        '<div class="page_subtitle">'+Gkrc('Config.Title.SaveConfiguration')+'</div>'
        //commands
      )+
      '<div class="page_body">'+
        '<div class="page_content">'+
          '<div id="dlgbody" class="">'+
            '<div class="page_explain">'+
              explainSave+
              '<div class="page_location"><br/>'+Gkod.Helper.CombineUrl(window.location,this.location)+'<br/><br/></div>'+
              this._RenderConfigDetails
              (
                {
                  'ApplicationName':this.name,
                  //'Version':this.currentVersion,
                  'ModifiedBy':this.currentModifiedBy,
                  'LastModified':this.time
                }
              )+
            '</div>'+
            '<div class="page_explain">'+
              checkServerAfterSave+
            '</div>'+
            '<div id="i_savetext" style="display:none">'+
              '<div class="page_menu"><div class="page_subtitle"><a href="#" onclick="GkodConfig.Page.ToggleSaveManually();return false">'+Gkod.Helper.FormatHtml(Gkrc('Config.Title.SaveManually'))+'</a></div></div>'+
              '<div class="page_explain">'+
                Gkod.Helper.FormatHtml(Gkrc('Config.Explain.SaveManually'))+
              '</div>'+
              '<div class="copytextcnt"><form style="display:inline" onsubmit="return false;"><textarea class="copytext" name="savetext" id="savetext" readonly="readonly">'+Gkod.Helper.EscapeHtml(this.saveit_c)+'</textarea></form></div>'+
            '</div>'+
          '</div>'+
        '</div>'+
        '<div class="page_footer"><div class="page_action">'+
          '<table width="100%" cellspacing="0" cellpadding="0"><tr><td>'+
            '<a href="#" onclick="GkodConfig.Page.SaveAgain(true);return false">'+Gkrc('Config.Action.RetrySave')+'</a>'+
            '<a href="#" id="i_savemanually" onclick="GkodConfig.Page.ToggleSaveManually();return false">'+Gkrc('Config.Action.SaveManually')+'</a>'+
            '<a href="#" id="i_selectall" onclick="GkodConfig.Page.SelectCopyText();return false" style="display:none">'+Gkrc('Config.Action.SelectAll')+'</a>'+
		  // start MGH IR 28714	
          // original: '</td></tr></table>'+
		  '</td><td>'+
			(commands?commands.join(''):'')+
		  // end MGH IR 28714
		  '</tr></table>'+
        '</div></div>'+
      '</div>'
    ;

    this.configVisible = false;
    Gkod.Helper.Dom.E(id).innerHTML = s;
    Gkod.Helper.Dom.Focus(null,'dlgbody');
  }
  catch(e) { Gkod.Helper.Exception(e, 'InjectStep2 failed'); }
}

GkodConfig.ConfigPage.prototype._RenderConfigDetails = function(cfg)
{
  var s =
    '<div>'+
      // '<div class="page_subsubtitle">'+Gkod.Helper.FormatHtml(Gkrc('Config.Title.Details'))+'</div>'+
      // '<div class="page_subexplain">'+
        '<table class="configdetails" cellspacing="0" cellpadding="0">'+
          '<tr>'+
            '<td><b>'+Gkod.Helper.FormatHtml(Gkrc('Config.Title.Application'))+'</b></td>'+
            '<td style="padding-left:10px">'+GkodConfig.GetApplicationName(cfg.ApplicationName)+'</td>'+
          '</tr>'+
          //'<tr>'+
          //  '<td><b>'+Gkod.Helper.FormatHtml(Gkrc('Config.Title.Version'))+'</b></td>'+
          //  '<td style="padding-left:10px">'+(cfg.Version?cfg.Version:Gkrc('Config.Title.Unknown'))+'</td>'+
          //'</tr>'+
          '<tr>'+
            '<td><b>'+Gkod.Helper.FormatHtml(Gkrc('Config.Title.ModifiedBy'))+'</b></td>'+
            '<td style="padding-left:10px">'+(cfg.ModifiedBy?cfg.ModifiedBy:Gkrc('Config.Title.Unknown'))+'</td>'+
          '</tr>'+
          '<tr>'+
            '<td><b>'+Gkod.Helper.FormatHtml(Gkrc('Config.Title.LastModified'))+'</b></td>'+
            '<td style="padding-left:10px">'+(cfg.LastModified?new Date(cfg.LastModified).toLocaleString():Gkrc('Config.Title.Unknown'))+'</td>'+
          '</tr>'+
        '</table>'+
      // '</div>'+
    '</div>'
  ;
  
  return s;
}

GkodConfig.ConfigPage.prototype.InjectStep3 = function(id)
{
  //Gkod.Trace.Write('InjectStep3');
  var undefined;
  if(id===undefined) id='page';
  
  try
  {
    var commands = 
      new Array
      (
        '<a href="#" onclick="GkodConfig.Page.Verify();return false">'+Gkrc('Config.Action.CheckAgain')+'</a>',
        '<a href="#" onclick="GkodConfig.Page.Edit();return false">'+Gkrc('Config.Action.Modify')+'</a>'
      );

    if(!GkodConfig.Standalone)
      commands.push('<a href="#" onclick="GkodConfig.Page.Exit(true);return false">'+Gkrc('Config.Action.Exit')+'</a>');
  
    var s = 
      GkodConfig.RenderHead
      (
        Gkod.Helper.FormatHtml(this.title),
        '<div class="page_subtitle">'+Gkrc('Config.Title.CheckServerConfiguration')+'</div>'
      )+
      '<div class="page_body">'+
        '<div class="page_content">'+
          '<div id="dlgbody" class="">'+
            '<div class="page_message">'+
              '<div class="page_location">'+Gkod.Helper.CombineUrl(window.location,this.location)+'<br/><br/></div>'+
              '<div id="verify">'+Gkod.Helper.FormatHtml(Gkrc('Config.Message.Checking'))+'</div>'+
            '</div>'+
            '<div id="serverconfig">'+
              '<div class="page_subsubtitle">'+Gkrc('Config.Title.ServerConfiguration')+'</div>'+
              '<div class="page_subexplain">'+
                '<div id="serverdetails">'+Gkod.Helper.FormatHtml(Gkrc('Config.Message.Checking'))+'</div>'+
              '</div>'+
            '</div>'+
            '<div id="currentconfig">'+
              '<div class="page_subsubtitle">'+Gkrc('Config.Title.CurrentConfiguration')+'</div>'+
              '<div class="page_subexplain">'+
                this._RenderConfigDetails
                (
                  {
                    'ApplicationName':this.name,
                    'Version':this.currentVersion,
                    'ModifiedBy':this.currentModifiedBy,
                    'LastModified':this.time
                  }
                )+
              '</div>'+
            '</div>'+
          '</div>'+
        '</div>'+
        '<div class="page_footer"><div class="page_action">'+
          '<table width="100%" cellspacing="0" cellpadding="0"><tr><td>'+
            '<a href="#" onclick="GkodConfig.Page.SaveAgain();return false">'+Gkrc('Config.Action.RetrySave')+'</a>'+
		  // start MGH IR 28714	
          // original: '</td></tr></table>'+
		  '</td><td>'+
			(commands?commands.join(''):'')+
		  // end MGH IR 28714
		  '</td></tr></table>'+
        '</div></div>'+
      '</div>'
    ;
    
    /// class="error"

    this.configVisible = false;
    Gkod.Helper.Dom.E(id).innerHTML = s;
    Gkod.Helper.Dom.Focus(null,'dlgbody');
  }
  catch(e) { Gkod.Helper.Exception(e, 'InjectStep3 failed'); }
}

GkodConfig.ConfigPage.prototype.$EnsureSection = function()
{
  if(this.section !== null) return;
  var o = new GkodConfig.$Section('', null);
  this.sectionMap[''] = o;
  this.sectionList.push(o);
  this.section = o;
}

GkodConfig.ConfigPage.prototype.$Serialize = function(vn,o,r)
{
  var undefined;
  var sa = [];
  var vnd = Gkod.Helper.IsEmpty(vn)?'':vn+'.';
  for(m in o)
  {
    var v = o[m];
    if(v===undefined || v===null) continue;
    
    if(Gkod.Helper.IsString(v)||Gkod.Helper.IsNumber(v)||Gkod.Helper.IsBoolean(v))
      sa.push(vnd+m+' = '+Gkod.Helper.Serialize(v)+';');
    else if(Gkod.Helper.IsArray(v))
    {
      //BUG:8795988, MATYI: Do not create root objects anymore. This was a special request from the team.
      //sa.push(vnd+m+' = [];');
      
   	  // MGH: added ability to specify whether to create root object...
      if (r) sa.push(vnd + m + ' = [];');

      for(var i=0,n=v.length; i<n; ++i)
        sa.push(vnd+m+'.push('+Gkod.Helper.Serialize(v[i])+');');
    }
    else if(Gkod.Helper.IsObject(v))
    {
      //BUG:8795988, MATYI: Do not create root objects anymore. This was a special request from the team.
      //sa.push(vnd+m+' = {};');

	  // MGH: added ability to specify whether to create root object...
	  if(r) sa.push(vnd+m+' = {};');

      for(var x in v)
        sa.push(vnd+m+'['+Gkod.Helper.SerializeString(x)+'] = '+Gkod.Helper.Serialize(v[x])+';');
    }
  }
  return sa.join("\r\n");
}

GkodConfig.ConfigPage.prototype.$SaveContent_TryNextScript = function(next)
{
  this.tryScriptAborted = !!this.tryScript;
  if(this.tryScriptAborted)
  {
    this.tryScript.Abort();
    this.currentScript = Gkod.Helper.GetInCircularRange(this.currentScript+1, 0, this.saverScripts.length-1);
  }

  if(!next)
    this.lastScript = Gkod.Helper.GetInCircularRange(this.currentScript-1, 0, this.saverScripts.length-1);
  else
  {
    var last = (this.currentScript==this.lastScript);
    this.currentScript = Gkod.Helper.GetInCircularRange(this.currentScript+1, 0, this.saverScripts.length-1);
    if(last)
    {
      GkodConfig.CommitPageUpdate();
      return; // this.$SaveContent_TryClient();
    }
  }

  var myself = this;
  
  this.tryScript = new Gkod.Helper.AjaxRequest
  (
    this.saverScripts[this.currentScript],
    {
      'asynchronous':true,
      'method':'POST',
      'parameters':
      {
        'saveit_l': this.saveit_l,
        'saveit_f': this.saveit_f,
        'saveit_c': this.saveit_c
      },
      'OnDone': function(arq)
      {
        if(myself.tryScriptAborted)
          return;

        myself.tryScript = null;

        try
        {
          var text = arq.request.responseText;
          if(!!text)
          {
            if(text=='UPDATED')
              return myself.$SaveContent_Updated();
          
            if(text.indexOf('Gkod.Variables.Config.LastModified')!=-1)
              return myself.$SaveContent_ContinueScript();
          }
        }
        catch(e) { Gkod.Helper.Exception(e,'LoadConfig.OnDone failed'); }
        
        return myself.$SaveContent_TryNextScript(true);        
      }
    }
  );
}

GkodConfig.ConfigPage.prototype.$SaveContent_Updated = function()
{
  GkodConfig.CancelPageUpdate();

  if(this.autoCheck)
  {
    this.autoCheck = false;
    this.Verify();
  }
  else this.InjectStep2(null,true);
}

GkodConfig.ConfigPage.prototype.$SaveContent_ContinueScript = function()
{
  GkodConfig.CommitPageUpdate();

  this.autoCheck = false;

  var id = 'ConfigTplSaver';
  var framename = id+'Frame';
  
  var n = document.getElementById(id);
  if(!!n) n.parentNode.removeChild(n);

  n = document.createElement('div');
  n.id = id;
  n.style.width = '0px';
  n.style.height = '0px';
  n.style.overflow = 'hidden';
  n.innerHTML = '<iframe id="'+framename+'" name="'+framename+'" style="display:block;border:none" frameborder="0" width="100" height="100" src="saver.html?use='+encodeURIComponent(this.saverScripts[this.currentScript])+'&_=' + new Date().getTime()+'"></iframe>';
  document.body.insertBefore(n,null);

  var w = window.frames[framename];
  if(!w) Gkod.Helper.Error('Cannot see injected frame: '+framename);
}

GkodConfig.ConfigPage.prototype.GetVariable = function(name)
{
  var undefined;
  var va = this.va$name[name];
  return ((va===undefined)?null:va);
}

GkodConfig.ConfigPage.prototype.SetVariable = function(name,value,dofocus)
{
  var va = this.va$name[name];
  va.Assign(value);
  
  var id = va.id;
  var n = Gkod.Helper.Dom.E('v_'+id);
  Gkod.Helper.Dom.AddClassName(n,'modified',va.modified);
  n.innerHTML = va.Build();

  this.Variable_Validate(id);
  this.Variable_OnChange(id);

  if(dofocus)
    Gkod.Helper.Dom.Focus(n);
}

GkodConfig.ConfigPage.prototype.SetTitleAndExplainAlt = function(name,alt)
{
  //Gkod.Trace.Write('var name: ' + name);
  //Gkod.Trace.Dump(this.va$name[name]);

  var undefined;
  var va = this.va$name[name];
  
  if( va==undefined )
    return;
  
  va.SetTitleAlt(alt);
  va.SetExplainAlt(alt);
  if(!this.configVisible)
    return;

  var id = va.id;
  var n = Gkod.Helper.Dom.E('v_'+id);
  //Gkod.Helper.Dom.AddClassName(n,'modified',va.modified);
  n.innerHTML = va.Build();

  //this.Variable_Validate(id);
  //this.Variable_OnChange(id);
}

GkodConfig.ConfigPage.prototype.SetExplainAlt = function(name,alt)
{
  var va = this.va$name[name];
  va.SetExplainAlt(alt);
  if(!this.configVisible)
    return;

  var id = va.id;
  var n = Gkod.Helper.Dom.E('v_'+id);
  Gkod.Helper.Dom.AddClassName(n,'modified',va.modified);
  n.innerHTML = va.Build();

  this.Variable_Validate(id);
  this.Variable_OnChange(id);
}

GkodConfig.ConfigPage.prototype.Variable_Reset = function(id,nofocus)
{
  var va = this.va$id[id];
  this.SetVariable(va.name,va.Extract(this.CloneDefaults()),!nofocus);
  // MGH IR 29420 reset doesn't (always?) reset fields with conditions
  this.CheckDependentConditions(id);
}

GkodConfig.ConfigPage.prototype.Variable_ButtonClick = function(id,index)
{
  var va = this.va$id[id];
  var onClick = va.buttons[index].onClick;
  onClick && onClick.call(this);
}

GkodConfig.ConfigPage.prototype.Variable_Dispatch = function(id,action)
{
  this.smoothvalidation.Commit();
  var va = this.va$id[id];
  va && va.Dispatch(action);
}

GkodConfig.ConfigPage.prototype.Variable_OnFocus = function(id)
{
  this.smoothvalidation.Activate(id);
}

GkodConfig.ConfigPage.prototype.Variable_OnChange = function(id)
{
  var va = this.va$id[id];
  if(!va) return;

  var v = this.Variable_Validate(id,true);
  var old_v = this.variables[va.varname];
  
  if(Gkod.Helper.Equals(old_v,v))
    return;

  if(va.onChanged)
  {
    var undefined;
    var nv = va.onChanged.call(va,v);
    if(nv !== undefined)
      v = nv;
  }
  
  this.variables[va.varname] = v;

  // start MGH IR 29420 reset doesn't reset controls with dependent conditions
  this.CheckDependentConditions(id);
}  

GkodConfig.ConfigPage.prototype.CheckDependentConditions = function(id)
{
  var va = this.va$id[id];
  if(!va) return;

  var ca = this.ca$vn[va.varname];
  if(!ca) return;
  
  var changeList = null;
  for(var i=0,n=ca.length; i<n; ++i)
  {
    var $i = ca[i];
    var va$i = this.va$id[$i];
    if(va$i.visible == va$i.Enabled()) continue;
    va$i.visible = !va$i.visible;
    if(!changeList)
      changeList = new Array();
    changeList.push(va$i);
  }
  changeList && this.ApplyChanges(changeList);
}
// end MGH IR 29420 reset doesn't reset controls with dependent conditions


GkodConfig.ConfigPage.prototype.Variable_OnBlur = function(id)
{
  this.Variable_Validate(id,true);
  this.smoothvalidation.Deactivate(id);
}

GkodConfig.ConfigPage.prototype.Variable_Deactivate = function(id)
{
  this.Variable_Validate(id);
}

GkodConfig.ConfigPage.prototype.Variable_Validate = function(id,ignore,changeList,noModify,sync)
{
  var va = this.va$id[id];
  var r = va.Validate(ignore,sync);
  
  var undefined;
  va.valid = (r.length>1 && r[0]===true && r[1]!==undefined);
  if(changeList && !va.valid && !va.visible)
  {
    va.visible = true;
    changeList.push(va);
  }

  var modified = !va.valid || !Gkod.Helper.Equals(va.Extract(this.original),r[1]);
  var vn = Gkod.Helper.Dom.E('v_'+va.id);
  
  if(va.modified!=modified)
  {
    va.modified = modified;
    Gkod.Helper.Dom.AddClassName(vn,'modified',modified);
  }

  var canreset = (!va.valid || !!r[3] || !Gkod.Helper.Equals(va.Extract(this.cdefaults),r[1]));
  if(va.canreset!=canreset)
  {
    va.canreset = canreset;
    Gkod.Helper.Dom.AddClassName(vn,'customized',canreset);
    Gkod.Helper.Dom.E('vr_'+va.id).style.display = (canreset?'':'none');
    if(canreset) this.SetCanReset(true);
  }
  
  va.cansave = (va.valid && !Gkod.Helper.Equals(va.Extract(this.cdefaults),r[1]));

  if(!noModify)
    this.CheckModified();
 
  return (va.valid?r[1]:null);
}

GkodConfig.ConfigPage.prototype.Variable_ToggleHelp = function(id)
{
  Gkod.Helper.Dom.Toggle(null,id+'_h,'+id+'_hh');
}

GkodConfig.ConfigPage.prototype.CheckSection = function(name)
{
  var se = this.sectionMap[name];
  if(!se) return;
  
  var sn = Gkod.Helper.Dom.E('s_'+se.id);
  se.BindPage(this);
  sn.parentNode.innerHTML = se.Build(this);
  this.Validate();
}

GkodConfig.ConfigPage.prototype.Section_Show = function(name)
{
  var se = this.sectionMap[name];
  if(!se) return;
  
  function onCompleted(success)
  {
    var sn = Gkod.Helper.Dom.E('s_'+se.id);
    se.BindPage(this);
    sn.parentNode.innerHTML = se.Build(this);
    this.Validate();
  }
  
  Gkod.Helper.Dom.Show(null,'svw_'+se.id);
  Gkod.Helper.Dom.Hide(null,'svs_'+se.id);
  se.onShow.call(this, onCompleted);
}

GkodConfig.ConfigPage.prototype.RenderComment = function(id,name)
{
  var co = this.comments[name];
  if(!co) return '';
  
  var head = '<a class="deletenote" href="#" '
           + 'onclick="Gkod.Helper.StopPropagation(event);'
		   + 'GkodConfig.Page.Comment_Delete(\''+id+'\',\''+name+'\');'
		   + 'return false">'
		   + Gkod.Helper.FormatHtml(Gkrc('Config.Action.Delete'))
		   +'</a>';
  var onclick = 'Gkod.Helper.StopPropagation(event);GkodConfig.Page.Comment_Change(\''+id+'\',\''+name+'\')';
  return GkodConfig._RenderComment(name,co.Comment,co.By,co.Time,head,onclick);
}

GkodConfig.ConfigPage.prototype.Comment_Delete = function(id,name)
{
  var cid = id+'_cb';
  Gkod.Helper.Dom.Show(null,cid,false);
  Gkod.Helper.Dom.Show(null,id+'_addnote',true);
  var n = Gkod.Helper.Dom.Get(id+'_cb');
  if(n) n.innerHTML = '';
  delete this.comments[name];

  this.commentChanged = true;
  this.SetModified(true);
}

GkodConfig.ConfigPage.prototype.Comment_Change = function(id,name)
{
  var co = this.comments[name];
  var comment = co?co.Comment:Gkrc('Config.Message.YourNote');
  var cid = id+'_cb';
  
  var footer = 
    '<table width="100%" cellspacing="0" cellpadding="0"><tr><td>'+
      '<a class="commitnote" href="#" onclick="GkodConfig.Page.Comment_DoChange(\''+id+'\',\''+name+'\',false);return false">'+Gkod.Helper.FormatHtml(Gkrc('Config.Action.Cancel'))+'</a>'+
      '<a class="commitnote" href="#" onclick="GkodConfig.Page.Comment_DoChange(\''+id+'\',\''+name+'\',true);return false">'+Gkod.Helper.FormatHtml(Gkrc('Config.Action.Ok'))+'</a>'+
    '</td></tr></table>'
  ;
  
  Gkod.Helper.Dom.E(cid).innerHTML = GkodConfig._RenderComment(name,comment,GkodConfig.GetEditedBy(),0,null,null,footer,id+'_cbe');
  Gkod.Helper.Dom.ShowHide(null,cid,id+'_addnote');
}

GkodConfig.ConfigPage.prototype.Comment_DoChange = function(id,name,save)
{
  var n = Gkod.Helper.Dom.Get(id+'_cbe');
  if(!n) return;

  var undefined;
  var co = this.comments[name];
  var has = (co!==undefined);
  var cid = id+'_cb';

  if(save)
  {
    var comment = Gkod.Helper.Trim(n.value);
    if(comment == '')
      return this.Comment_Delete(id,name);

    if(!has)
    {
      has = true;
      this.comments[name] = co = new Object();
    }
    
    co.Comment = comment;
    co.By = GkodConfig.GetEditedBy();
    co.Time = new Date().getTime();
  }
  
  if(!has)
  {
    Gkod.Helper.Dom.Show(null,id+'_addnote',true);
    Gkod.Helper.Dom.Show(null,cid,false);
  }
  
  Gkod.Helper.Dom.E(cid).innerHTML = this.RenderComment(id,name);

  if(save)
  {
    this.commentChanged = true;
    this.SetModified(true);
  }
}

GkodConfig.ConfigPage.prototype.MoveItemUp = function(id, ix) {
  this.va$id[id].MoveItemUp(ix);
  this.Variable_Validate(id, true);
}

GkodConfig.ConfigPage.prototype.MoveItemDown = function(id, ix) {
  this.va$id[id].MoveItemDown(ix);
  this.Variable_Validate(id, true);
}

// $Section
// ==========================================================================

GkodConfig.$Section = function(name, rc, flags)
{
  this.id = Gkod.Helper.UniqueId('ie');
  this.name = name;
  this.rc = (rc&&rc.Title)||null;
  this.rc_Show = (rc&&rc.Show)||Gkrc('Config.Action.Show');
  this.rc_Hidden = (rc&&rc.Hidden)||Gkrc('Config.Explain.HiddenSection');
  this.list = [];
  this.onCheckEnabled = (flags && flags.onCheckEnabled) || null;
  this.onCheckVisible = (flags && flags.onCheckVisible) || null;
  this.onShow = (flags && flags.onShow) || null;
  this.advanced = true; // full-advanced section
  this.visible = true;
  this.enabled = true;
}

GkodConfig.$Section.prototype.Add = function(va)
{
  if(!va.advanced)
    this.advanced = false;

  va.sid = this.id;
  this.list.push(va);
}

GkodConfig.$Section.prototype.BindPage = function(pg)
  {
    this.enabled = (this.onCheckEnabled?this.onCheckEnabled.call(pg, pg.variables):true);
    this.visible = this.enabled && (this.onCheckVisible?this.onCheckVisible.call(pg, pg.variables):true);
    for(var i=0,n=this.list.length; i<n; ++i)
    {
      var va = this.list[i];
      va.hidden = !this.visible;
      va.Bind(pg.variables);
    }
  }

GkodConfig.$Section.prototype.Build = function(pg)
  {
    var s = '';
    s += '<div id="s_'+this.id+'" class="app_listsection"'+((!this.enabled||this.advanced)?' style="display:none"':'')+'>';

    if(this.enabled)
    {
      if(this.visible)
      {
        s += '<div class="app_list">';
        if(this.rc)
          s += '<div class="head"><div class="app_subsection">'+Gkod.Helper.EscapeHtml(this.rc)+'</div></div>';
        s += '<div class="body">';
        
        var index = 0;
        for(var i=0,n=this.list.length; i<n; ++i)
        {
          var va = this.list[i];
          s += '<div id="v_'+va.id+'" class="'+(index%2?'even':'odd')+(index==0?' first':'')+(va.advanced?' advanced':'')+(va.modified?' modified':'')+'"'+(va.visible?'':' style="display:none"')+'>'+va.Build(i)+'</div>';
          if(va.visible)
            ++index;
        }

        s += '</div></div>';
      }
      else
      {
        if(this.rc)
          s += '<div class="head"><div class="app_subsection">'+Gkod.Helper.EscapeHtml(this.rc)+'</div></div>';
        s += 
          '<div id="sv_'+this.id+'" class="sectioncell"><div class="sectionitem">'+
          '<div class="sectionhidden">'+Gkod.Helper.FormatHtml(this.rc_Hidden)+'</div>'+
          '<div>'+
            (this.onShow?'<span id="svw_'+this.id+'" class="working" style="display:none">&nbsp;</span><a id="svs_'+this.id+'" class="sbutton" href="#" onclick="GkodConfig.Page.Section_Show(\''+this.name+'\');return false">'+Gkod.Helper.EscapeHtml(this.rc_Show)+'</a>':'')+
          '</div>'+
          '</div></div>' // </div>
        ;
      }
    }
    
    s += '</div>';
    return s;
  }

// $Comment
// ==========================================================================

GkodConfig.$Comment = function(id,name)
{
  this.id = id;
  this.name = name;
}

GkodConfig.$Comment.prototype.Build = function()
{
  var undefined;
  var has = (GkodConfig.Page.comments[this.name]!==undefined);

  var s = '';
  s += '<div id="'+this.id+'_addnote"'+(has?' style="display:none"':'')+'><div><a class="addnote'+(this.name==''?'_large':'')+'" href="#" onclick="Gkod.Helper.StopPropagation(event);GkodConfig.Page.Comment_Change(\''+this.id+'\',\''+this.name+'\');return false">'+Gkrc('Config.Action.AddNote')+'</a></div></div>';
  s += '<div id="'+this.id+'_cb" style="'+(has?'':'display:none;')+'clear:both">'+GkodConfig.Page.RenderComment(this.id,this.name)+'</div>';
  return s;
}

// $Variable
// ==========================================================================

GkodConfig.$Variable = function(rc, id, name, type, flags)
{
  var na = name.split('[',2);

  this.rc = rc;
  this.varname = na[0];
  this.varcond = (na.length>1&&na[1].charAt(na[1].length-1)==']')?na[1].substr(0,na[1].length-1):null;
  this.explainArgs = (flags&&flags.explainArgs)||null;

  this.rc_Name = rc('CT.Variable.'+name+'.Title',(this.varcond!==null)?rc('CT.Variable.'+this.varname+'.Title',this.varname):this.varname); 
  
  this.id = id;
  this.sid = null;
  this.name = name;
  this.type = type;
  this.flags = flags;
  this.dob = null;
  this.required = !!(flags && flags.required);
  this.advanced = !!(flags && flags.advanced);
  this.buttons = (flags && flags.buttons && [].concat(flags.buttons))||null;
  this.valid = true;
  this.modified = false;
  this.cansave = true;
  this.canreset = false;
  this.variables = null;
  this.comment = new GkodConfig.$Comment(this.id+'_cc',this.name);
  this.hidden = false;
  this.visible = !this.advanced && this.Enabled();
  this.onChanged = (flags && flags.onChanged) || null;
  
  this.SetExplainAlt((flags && flags.explainAlt)||null);
}

GkodConfig.$Variable.prototype.SetTitleAlt = function(alt)
{
  this.explainAlt = alt||null; // keep for debugging purposes only
  
  var x = (alt?'.'+alt:'');
  var r = this.rc('CT.Variable.'+this.name+'.Title'+x,null) || 
          (this.varcond && this.rc('CT.Variable.'+this.varname+'.Title'+x,null));
  if(!r && x!='')
    r = this.rc('CT.Variable.'+this.name+'.Title',null) || 
        (this.varcond && this.rc('CT.Variable.'+this.varname+'.Title',null));
  this.rc_Name = r;
}

GkodConfig.$Variable.prototype.SetExplainAlt = function(alt)
{
  this.explainAlt = alt||null; // keep for debugging purposes only
  
  var x = (alt?'.'+alt:'');
  var r = this.rc('CT.Variable.'+this.name+'.Explain'+x,null) || 
          (this.varcond && this.rc('CT.Variable.'+this.varname+'.Explain'+x,null));
  if(!r && x!='')
    r = this.rc('CT.Variable.'+this.name+'.Explain',null) || 
        (this.varcond && this.rc('CT.Variable.'+this.varname+'.Explain',null));
  this.rc_Help = r;
}

GkodConfig.$Variable.prototype.AddItem = function()
{
  (this.type.AddItem||Gkod.Helper.Nop).call(this.type,this);
}

GkodConfig.$Variable.prototype.DeleteItem = function(ix)
{
  (this.type.DeleteItem||Gkod.Helper.Nop).call(this.type,this,ix);
}

GkodConfig.$Variable.prototype.UndeleteItem = function(ix)
{
  (this.type.UndeleteItem||Gkod.Helper.Nop).call(this.type,this,ix);
}

GkodConfig.$Variable.prototype.MoveItemUp = function(ix) {
  (this.type.MoveItemUp || Gkod.Helper.Nop).call(this.type, this, ix);
}

GkodConfig.$Variable.prototype.MoveItemDown = function(ix) {
  (this.type.MoveItemDown || Gkod.Helper.Nop).call(this.type, this, ix);
}

GkodConfig.$Variable.prototype.Extract = function(vs)
{
  var undefined;
  if(vs[this.name]!==undefined) // Try to extract 'varname:varcond=value' named variables too. Default values could use this feature.
    return vs[this.name];

  if(vs[this.varname]===undefined)
    return this.type.New();
    
  if(!this.varcond)
    return vs[this.varname];

  var ca = this.varcond.split('=',2);
  if(Gkod.Helper.Equals(vs[ca[0]],((ca.length==2)?ca[1]:'')))
    return vs[this.varname];
    
  return this.type.New();
}

GkodConfig.$Variable.prototype.Enabled = function()
{
  if(this.hidden) return false;
  if(!this.varcond) return true;
  if(!this.variables) return false;
  var ca = this.varcond.split('=',2);
  return Gkod.Helper.Equals(this.variables[ca[0]],((ca.length==2)?ca[1]:''));
}

GkodConfig.$Variable.prototype.Assign = function(v)
{
  this.value = v;
  if(!this.Enabled())
    return Gkod.Trace.Write('GkodConfig.$Variable.Assign: Cannot assign '+this.name);
  var old_v = this.variables[this.varname];
  this.variables[this.varname] = v;
  this.dob = this.type.DecompileObject(this.value);
  if(this.onChanged)
    this.onChanged.call(this,v);
}

GkodConfig.$Variable.prototype.Bind = function(vs)
{
  var undefined;
  if(vs===undefined) vs = this.variables; else this.variables = vs;
  this.value = this.Extract(vs);
  this.dob = this.type.DecompileObject(this.value);
  this.visible = !this.advanced && this.Enabled();

  // Gkod.Trace.Write(this.name, this.value);
}

GkodConfig.$Variable.prototype.Build = function(ix)
{
  //Gkod.Trace.Write('GkodConfig.$Variable.Build');

  var undefined;
  var id_z = this.id+'_z';
  var id_u = this.id+'_u';
  var id_v = this.id+'_v';
  var id_n = this.id+'_n';
  var id_h = this.id+'_h';
  var id_hh = this.id+'_hh';
  
  var hasHelp = !!this.rc_Help;
  var toggleHelp = GkodConfig.ToggleHelp && hasHelp;
  var helpVisible = true;

  var button_s = '';
  if(this.buttons)
  {
    button_s = '<div style="padding-top:5px"><table width="100%" cellspacing="0" cellpadding="0"><tr><td>';
    for(var i=0; i<this.buttons.length; ++i)
      button_s += '<a class="sbutton" href="#" onclick="GkodConfig.Page.Variable_ButtonClick(\''+this.id+'\','+i+');return false">'+Gkod.Helper.FormatHtml(this.buttons[i].title)+'</a>';
    button_s += '</td></tr></table></div>';
  }

  try
  {
    var s =
      '<div class="sectionitem">'+
      '<table width="100%" cellspacing="0" cellpadding="0"><tbody><tr>'+
        '<td class="list_cell" width="220" valign="top">'+
          '<div class="varname_button">'+
            '<div id="vr_'+this.id+'"'+(this.canreset?'':' style="display:none"')+'><a class="sbutton" href="#" onclick="GkodConfig.Page.Variable_Reset(\''+this.id+'\');return false">'+
              Gkod.Helper.FormatHtml(Gkrc('Config.Action.Reset'))+
            '</a></div>'+
          '</div>'+
          '<div class="varname">'+
            (toggleHelp?'<a class="varname_a" href="#" onclick="GkodConfig.Page.Variable_ToggleHelp(\''+this.id+'\');return false">':'')+
              Gkod.Helper.EscapeHtml(this.rc_Name)+(this.required?'*':'')+
            (toggleHelp?'<span id="'+id_hh+'" style="'+(helpVisible?'display:none;':'')+'font-weight:normal;color:#CCC">&nbsp?</span></a>':'')+
          '</div>'+
        '</td>'+
        '<td class="list_cell" valign="top">'+
          '<div class="varmodify"><div class="varvalue">'+
            '<div>'+
              '<div id="'+id_n+'" class="varerror" style="display:none"></div>'+
              '<div id="'+id_v+'" class="edit">'+this.type.RenderControl({'va':this,'id':this.id,'dob':this.dob})+'</div>'+
            '</div>'+
            button_s+
            (hasHelp?'<div id="'+id_h+'" class="varhelp"'+(helpVisible?'':' style="display:none"')+'>'+Gkod.Helper.FormatHtml(this.rc_Help,this.explainArgs)+'</div>':'')+
          '</div></div>'+
        '</td>'+
        '<td class="list_cell" width="1" valign="top">'+
          '<div style="width:1px;overflow:visible">' +
            (GkodConfig.EnableComments?
              Gkod.Helper.RenderComment
              (
                '<div style="width:270px;padding-left:11px">'+
                  this.comment.Build()+
                '</div>'
              ):'')+
          '</div>'+
        '</td>'+
      '</tr></tbody></table>'+
      '</div>'
    ;
  }
  catch(e) { Gkod.Helper.Exception(e, '$Variable.Build failed: '+this.name); }

  return s;
}

GkodConfig.$Variable.prototype.Validate = function(ignore,sync)
{
  var vv = this.type.Validate({'va':this,'id':this.id},true,ignore,sync);
  if(!ignore)
  {
    var n = Gkod.Helper.Dom.E(this.id+'_n');
    if(vv[0]===true || vv[0]===false)
    {
      n.style.display = 'none';
      n.parentNode.className = '';
    }
    else
    {
      n.innerHTML = vv[0];
      n.style.display = '';
      n.parentNode.className = 'errormark';
    }
  }
  return vv;
}

GkodConfig.$Variable.prototype.Dispatch = function(action)
{
  return this.type.Dispatch && this.type.Dispatch({'va':this,'id':this.id,'dob':this.dob},action);
}

GkodConfig.$RenderColumns = function(type,column,content,first,offs)
{
  var undefined;
  if(offs===undefined) offs = 0;

  if(type.constructor!==GkodConfig.$Compound && type.constructor!==GkodConfig.$Named )
    return '<td'+((column==-1)?'':' width="'+(column-offs+6)+'"')+(first?'':' style="padding-left:'+(2+offs)+'px"')+'><div class="column" style="overflow:visible;width:'+(column-offs+6)+'px">'+content+'</div></td>';

  var s = '';
  for(var i=0,n=type.types.length; i<n; ++i)
  {
    s += '<td'+((column[i]==-1)?'':' width="'+(column[i]-offs+6)+'"')+(first?'':' style="padding-left:'+(2+offs)+'px"')+'><div class="column" style="overflow:visible;width:'+(column[i]-offs+6)+'px">'+content[i]+'</div></td>';
    first = false;
  }
  return s;
}

// Compound
// ==========================================================================

GkodConfig.$Compound = function(columns, types) 
  {
    this.types = types;
    this.columns = columns;
  }

GkodConfig.$Compound.prototype.New = function()
  {
    var a = [];
    for(var i=0,n=this.types.length; i<n; ++i)
      a.push(this.types[i].New());
    return a;    
  }

GkodConfig.$Compound.prototype.GetValueName = function(value)
  {
    var a = [];
    for(var i=0,n=this.types.length; i<n; ++i)
      a[i] = this.types[i].GetValueName(value[i]);
    return a;    
  }

GkodConfig.$Compound.prototype.DecompileObject = function(value)
  {
    var dob = [];
    for(var i=0,n=this.types.length; i<n; ++i)
      dob.push(this.types[i].DecompileObject(value[i]));
    return dob;
  }
  
GkodConfig.$Compound.prototype.RenderControl = function(ctx)
  {
    var a = [];
    for(var i=0,n=this.types.length; i<n; ++i)
      a.push(this.types[i].RenderControl({'va':ctx.va,'id':ctx.id+'@'+i,'dob':ctx.dob[i],'width':ctx.width[i]}));
    return a;
  }
GkodConfig.$Compound.prototype.RenderDeleted = function(ctx)
  {
    var a = [];
    for(var i=0,n=this.types.length; i<n; ++i)
      a.push(this.types[i].RenderDeleted({'va':ctx.va,'id':ctx.id+'@'+i,'dob':ctx.dob[i],'width':ctx.width[i]}));
    return a;
  }
GkodConfig.$Compound.prototype.Validate = function(ctx,validate,ignore,sync)
  {
    var a = [];
    var valid = true;
    for (var i = 0, n = this.types.length; i < n; ++i) {
      var v = this.types[i].Validate({ 'va': ctx.va, 'id': ctx.id + '@' + i }, validate, ignore, sync);
      if (valid === true && v[0] !== true)
        valid = v[0];
      a.push(v[1]);
    }
    return [valid, a];
  }

// Named
// ==========================================================================

GkodConfig.$Named = function(columns, types) 
  {
    this.names = [];
    this.types = [];
    for (i in types) {
      if (i == 'Named') continue;
      this.names.push(i);
      this.types.push(types[i]);
    }

    this.columns = columns;
  }

GkodConfig.$Named.prototype.New = function() 
  {
    var a = {};
    for (var i = 0, n = this.types.length; i < n; ++i)
      a[this.names[i]] = this.types[i].New();
    return a;
  }

GkodConfig.$Named.prototype.DecompileObject = function(value) 
  {
    var dob = [];
    for (var i = 0, n = this.types.length; i < n; ++i) {
      //var fieldValue = value[this.names[i]];
      //console.log('fieldValue = %s',fieldValue);
      dob.push(this.types[i].DecompileObject(value[this.names[i]]));
    }
    return dob;
  }

GkodConfig.$Named.prototype.Validate = function(ctx, validate, ignore, sync) 
  {
    var a = {};
    var valid = true;
    for (var i = 0, n = this.types.length; i < n; ++i) {
      var v = this.types[i].Validate({ 'va': ctx.va, 'id': ctx.id + '@' + i }, validate, ignore, sync);
      if (valid === true && v[0] !== true)
        valid = v[0];
      a[this.names[i]] = v[1];
    }
    return [valid, a];
  }

GkodConfig.$Named.prototype.GetValueName  = GkodConfig.$Compound.prototype.GetValueName;
GkodConfig.$Named.prototype.RenderControl = GkodConfig.$Compound.prototype.RenderControl;
GkodConfig.$Named.prototype.RenderDeleted = GkodConfig.$Compound.prototype.RenderDeleted;

// String
// ==========================================================================

GkodConfig.String = function(rc,validate)
{
  this.rc = rc;
  this.validate = validate;

  var undefined;
  if(this.rc===undefined || this.rc===null) this.rc = {};
  this.width = ((this.rc.Width===undefined)?300:this.rc.Width);
}

GkodConfig.String.prototype.New = function()
  { return new String(); }

GkodConfig.String.prototype.GetValueName = function(value)
  { return value; }

GkodConfig.String.prototype.DecompileObject = function(value)
  { return {'value':value}; }

GkodConfig.String.prototype.RenderControl = function(ctx)
  {
    var v = String(ctx.dob.value);
    var undefined;
    var width = ((ctx.width!==undefined)?ctx.width:this.width);
    return '<input onfocus="GkodConfig.Page.Variable_OnFocus(\''+ctx.va.id+'\')" onblur="GkodConfig.Page.Variable_OnBlur(\''+ctx.va.id+'\')" id="'+ctx.id+'_i" name="'+ctx.id+'_i" class="control" type="text" value="'+Gkod.Helper.EscapeHtml(v)+'"'+((width>0)?' style="width:'+width+'px"':'')+' />';
  }

GkodConfig.String.prototype.RenderDeleted = function(ctx)
  {
    var v = String(ctx.dob.value);
    var width = ((ctx.width!==undefined)?ctx.width:this.width);
    return '<div class="deletedtext"'+((width>0)?' style="overflow:hidden;width:'+width+'px"':'')+'>'+((v.length>0)?Gkod.Helper.EscapeHtml(v):'&nbsp;')+'</div>';
  }

GkodConfig.String.prototype.Get = function(ctx)
  { return Gkod.Helper.Dom.E(ctx.id+'_i').value; }

GkodConfig.String.prototype.Set = function(ctx,v)
  { Gkod.Helper.Dom.E(ctx.id+'_i').value = v; }

GkodConfig.String.prototype.Validate = function(ctx,validate,ignore,sync)
  {
    var vv = this.Get(ctx);
    var v = Gkod.Helper.Trim(vv);
    var r = (!validate||!this.validate)?[true,v]:this.validate.call(ctx.va,v,sync);
    // r[2] = (String(r[1]!=vv);
    if(r[0]===true) return r;
    if(r[0]===false) r[0] = 'Invalid';
    var msg = this.rc[r[0]];
    if(msg) r[0] = Gkod.Helper.EscapeHtml(msg);
    return r;
  }

// Number
// ==========================================================================

GkodConfig.Number = function(rc,validate)
{
  var undefined;
  this.rc = rc;
  this.validate = validate;

  var undefined;
  if(this.rc===undefined || this.rc===null) this.rc = {};
  this.width = ((this.rc.Width===undefined)?100:this.rc.Width);
}

GkodConfig.Number.prototype.New = function()
  { return new Number(0); }

GkodConfig.Number.prototype.GetValueName = function(value)
  { return String(value); }

GkodConfig.Number.prototype.DecompileObject = function(value)
  { return {'value':value}; }

GkodConfig.Number.prototype.RenderControl = function(ctx)
  {
    var v = Number(ctx.dob.value);
    var undefined;
    var width = ((ctx.width!==undefined)?ctx.width:this.width);
    return '<input onfocus="GkodConfig.Page.Variable_OnFocus(\''+ctx.va.id+'\')" onblur="GkodConfig.Page.Variable_OnBlur(\''+ctx.va.id+'\')" id="'+ctx.id+'_i" name="'+ctx.id+'_i" class="control" type="text" value="'+v+'"'+((width>0)?' style="width:'+width+'px"':'')+' />';
  }

GkodConfig.Number.prototype.RenderDeleted = function(ctx)
  {
    var v = Number(ctx.dob.value);
    var width = ((ctx.width!==undefined)?ctx.width:this.width);
    return '<div class="deletedtext"'+((width>0)?' style="overflow:hidden;width:'+width+'px"':'')+'>'+v+'</div>';
  }

GkodConfig.Number.prototype.Get = GkodConfig.String.prototype.Get;
GkodConfig.Number.prototype.Set = GkodConfig.String.prototype.Set;

GkodConfig.Number.prototype.Validate = function(ctx,validate,ignore,sync)
  {
    var vv = this.Get(ctx);
    var v = Gkod.Helper.Trim(vv);
    v = (v=='')?'0':v;
    var n = Number(v);
    var r = (validate&&this.validate)?this.validate.call(ctx.va,v,sync):[!isNaN(n),n];
    if(r[0]===true) return r;
    if(r[0]===false) r[0] = 'Invalid';
    var msg = this.rc[r[0]];
    if(msg) r[0] = Gkod.Helper.EscapeHtml(msg);
    return r;
  }

// Url
// ==========================================================================

GkodConfig.Url = function(rc,validate)
{
  this.rc = rc;
  this.validate = validate;

  var undefined;
  if(this.rc===undefined || this.rc===null) this.rc = {};
  this.width = ((this.rc.Width===undefined)?300:this.rc.Width);
}

GkodConfig.Url.prototype.New = GkodConfig.String.prototype.New;
GkodConfig.Url.prototype.GetValueName = GkodConfig.String.prototype.GetValueName;
GkodConfig.Url.prototype.DecompileObject = GkodConfig.String.prototype.DecompileObject;
GkodConfig.Url.prototype.RenderControl = GkodConfig.String.prototype.RenderControl;
GkodConfig.Url.prototype.RenderDeleted = GkodConfig.String.prototype.RenderDeleted;
GkodConfig.Url.prototype.Get = GkodConfig.String.prototype.Get;
GkodConfig.Url.prototype.Set = GkodConfig.String.prototype.Set;
GkodConfig.Url.prototype.Validate = GkodConfig.String.prototype.Validate;

// DropDown
// ==========================================================================

GkodConfig.DropDown = function(rc,map,def,validate)
{
  var undefined;

  this.tc = Gkod.Helper.UniqueId('tc_');
  this.rc = rc;
  this.map = map;
  this.def = ((def===undefined || def===null)?'':def);
  this.validate = validate;

  if(this.rc===undefined || this.rc===null) this.rc = {};
  this.width = ((this.rc.Width===undefined)?-1:this.rc.Width);
}

GkodConfig.DropDown.prototype.New = function()
  { return this.def; }

GkodConfig.DropDown.prototype.GetValueName = function(value)
  {
    var undefined;
    if(value===undefined) value = this.def;
    if(value===undefined) return '';
    return (this.map[value]!==undefined)?this.map[value]:value;
  }

GkodConfig.DropDown.prototype.SetDefault = function(def)
  {
    this.def = ((def===undefined || def===null)?'':def);
  }

GkodConfig.DropDown.prototype.ResetOptions = function(map,def)
  {
    this.map = map||new Object();
    this.def = ((def===undefined)?this.def:((def===null)?'':def));
  }

GkodConfig.DropDown.prototype.AddOption = function(name,value,after)
  {
    var undefined;
    if(after===undefined)
    {
      this.map[name] = value;
      return;
    }
    var map = new Object();
    if(after===null)
      map[name]=value;
    for(var m in this.map)
    {
      map[m] = this.map[m];
      if(m==after)
        map[name] = value;
    }
    this.map = map;
  }

GkodConfig.DropDown.prototype.RemoveOption = function(name)
  {
    var undefined;
    if(this.map[name]===undefined) return;
    delete this.map[name];
  }

GkodConfig.DropDown.prototype.DecompileObject = function(value)
  { return {'value':value}; }

GkodConfig.DropDown.prototype.RenderControl = function(ctx)
  {
    var v = String(ctx.dob.value);
    var s = '';
    var width = ((ctx.width!==undefined)?ctx.width:this.width);
    s += '<select class="'+this.tc+' control" onchange="GkodConfig.Page.Variable_OnChange(\''+ctx.va.id+'\')" onfocus="GkodConfig.Page.Variable_OnFocus(\''+ctx.va.id+'\')" onblur="GkodConfig.Page.Variable_OnBlur(\''+ctx.va.id+'\')" id="'+ctx.id+'_i" name="'+ctx.id+'_i"'+((width>0)?' style="width:'+(width+5)+'px"':'')+'>';
    for(var $v in this.map)
    {
      var $n = this.map[$v];
      var ESC_$n = Gkod.Helper.EscapeHtml($n);
      var ESC_$v = Gkod.Helper.EscapeHtml($v);
      s += '<option label="'+ESC_$n+'" value="'+ESC_$v+'"'+(($v==v)?' selected="selected"':'')+'>'+ESC_$n+'</option>';
    }
    s += '</select>';
    return s;
  }

GkodConfig.DropDown.prototype.RenderDeleted = function(ctx)
  {
    var undefined;
    var n = Gkod.Helper.Trim(this.map[ctx.dob.value]);
    var width = ((ctx.width!==undefined)?ctx.width:this.width);
    return '<div class="deletedtext"'+((width>0)?' style="overflow:hidden;width:'+width+'px"':'')+'>'+((n===undefined||n=='')?'&nbsp;':Gkod.Helper.EscapeHtml(n))+'</div>';
  }

GkodConfig.DropDown.prototype.Get = GkodConfig.String.prototype.Get;
GkodConfig.DropDown.prototype.Set = GkodConfig.String.prototype.Set;

GkodConfig.DropDown.prototype.Validate = function(ctx,validate,ignore,sync)
  {
    var v = Gkod.Helper.Dom.E(ctx.id+'_i').value;
    if(!validate || !this.validate) return [true,v]; 
    return this.validate.call(ctx.va,v,sync);
  }

// LangId
// ==========================================================================

GkodConfig.LangId = function(useNoneAsDefault)
{
  // The internal values are in 'Lang.*' format. These values are mapped between different locale maps when necessary.
  this.useNoneAsDefault = !!useNoneAsDefault;
  GkodConfig.DropDown.call(this, null, null, null);
  this.SetLocaleMap({'Lang.None':''},'Lang.None',true);
}

GkodConfig.LangId.prototype = Gkod.Helper.Clone(GkodConfig.DropDown.prototype);

GkodConfig.LangId.prototype.GetValueName = function(value)
  {
    var undefined;
    value = (value===undefined)?this.def:value;
    value = Gkod.Helper.Get(this.rmap[value],value);
    return Gkod.Helper.Get(this.map[value],value);
  }

GkodConfig.LangId.prototype.GetElements = function()
  {
    return ((GkodConfig.Page && GkodConfig.Page.configVisible)? Gkod.Helper.Dom.GetElements(null, 'select', this.tc): []);
  }

GkodConfig.LangId.prototype.SetLocaleMap = function(lcmap,def)
  {
    var undefined;
    var lcm = (this.useNoneAsDefault?{'Lang.None':''}:{});
    Gkod.Helper.Override(lcm,lcmap);
    if(def === undefined || def=='')
      def = ((lcm['Lang.None']!==undefined)?'Lang.None':'');
    var ea = this.GetElements();
    var transform = this.PrepareTransform(lcm,def,ea);
    this.RebuildOptions();
    for(var i=0; i<ea.length; ++i)
      this.ResetDomElement(ea[i],transform);
  }

GkodConfig.LangId.prototype.PrepareTransform = function(lcmap,def,ea)
  {
    var undefined;
    var transform = {};
    
    if(!ea)
      ea = this.GetElements();
    
    var lcm = {};
    for(var m in lcmap)
      lcm[Gkrc(m,((m=='Lang.None')?'':undefined))]=m;
      
    var lck = Gkod.Helper.GetKeys(lcm).sort();
    var pmap = {};
    var rmap = {};
    for(var i=0; i<lck.length; ++i)
    {
      var name = lck[i];
      var m = lcm[name];
      pmap[m] = name;
      rmap[lcmap[m]] = m;
    }
    var xopt = {};
    for(var i=0; i<ea.length; ++i)
    {
      var o = ea[i].value;
      if(pmap[o]===undefined && rmap[o]===undefined)
      {
        var lco = this.lcmap[o];
        if(lco===undefined) lco = o;
        transform[o] = lco;
        xopt[lco] = true;
      }
    }
    
    if(def!==undefined)
      this.def = Gkod.Helper.Get(lcmap[def],def);
      
    this.lcmap = lcmap;
    this.pmap = pmap;
    this.xopt = xopt;
    this.rmap = rmap;
    
    return transform;
  }

GkodConfig.LangId.prototype.RebuildOptions = function()
  {
    var map = Gkod.Helper.Clone(this.pmap);
    var xa = Gkod.Helper.GetKeys(this.xopt).sort();
    for(var i=0; i<xa.length; ++i)
      map[xa[i]] = xa[i];
    this.map = map;
  }

GkodConfig.LangId.prototype.RemoveOptions = function(node)
  {
    var v = node.value;
    while(node.options.length>0) node.remove(0);
    return v;
  }

GkodConfig.LangId.prototype.ResetDomElement = function(node,transform)
  {
    var undefined;
    var v = this.RemoveOptions(node);
    for(var m in this.map)
    {
      var o = document.createElement('OPTION');
      o.value = m;
      o.text = this.map[m];
      node.add(o,Gkod.Helper.IE?-1:null);
    }
    if(this.map[v]!==undefined)
      node.value = v;
    else if(transform && transform[v]!==undefined)
      node.value = transform[v];
    else if(this.rmap[v]!==undefined)
      node.value = this.rmap[v];
    else node.value = this.def;
  }

GkodConfig.LangId.prototype.DecompileObject = function(value)
  {
    var undefined;
    if(this.rmap[value]===undefined && this.xopt[value]===undefined)
      { this.xopt[value] = true; this.RebuildOptions(); }
    var v = this.rmap[value];
    if(v===undefined)
      v = value;
    return {'value':v};
  }

GkodConfig.LangId.prototype.Validate = function(ctx,validate,ignore,sync)
  {
    var undefined;
    var v = Gkod.Helper.Dom.E(ctx.id+'_i').value;
    v = Gkod.Helper.Get(this.lcmap[v],v);
    if(!validate || !this.validate) return [true,v];
    return this.validate.call(ctx.va,v,sync);
  }

// TypeIn
// ==========================================================================

GkodConfig.TypeIn = function(rc,map,def,validate)
{
  var undefined;

  this.tid = Gkod.Helper.UniqueId('tin');
  this.rc = rc;
  this.map = map;
  this.def = ((def===undefined || def===null)?'':def);
  this.validate = validate;

  if(this.rc===undefined || this.rc===null) this.rc = {};
  this.width = ((this.rc.Width===undefined)?-1:this.rc.Width);
  this.paletteWidth = ((this.rc.PaletteWidth===undefined)?0:this.rc.PaletteWidth);
  
  GkodConfig.TypeIn.Register(this.tid,{'map':map,'paletteWidth':this.paletteWidth});
}

GkodConfig.TypeIn.vmap = {};
GkodConfig.TypeIn.Register = function(tid,obj)
  { GkodConfig.TypeIn.vmap[tid] = obj; }

GkodConfig.TypeIn.Choose = function(tid,id)
  {
    var undefined;
    var obj = GkodConfig.TypeIn.vmap[tid];
    if(obj===undefined)
      return;

    var map = obj.map;
    var paletteWidth = obj.paletteWidth;

    var s = '';
    for(var m in map)
    {
      var $m = map[m];
      s += '<a class="typein_a" href="#" onclick="GkodConfig.TypeIn.ChooseOk(\''+id+'\',\''+Gkod.Helper.EscapeHtml(m)+'\');return false">'+Gkod.Helper.EscapeHtml($m)+'</a> ';
    }
    if(s.length==0)
      s = '<br/>&nbsp;';
    
    Gkod.Helper.ShowPalette(id,s,{'width':paletteWidth,'left':2,'top':2});     
    // alert(values); 
  }
  
GkodConfig.TypeIn.ChooseOk = function(id,value)
  {
    Gkod.Helper.HidePalette(id);
    var n = Gkod.Helper.Dom.E(id);
    Gkod.Helper.Dom.SetValue(n,value);
    Gkod.Helper.Dom.Focus(n);
  }

GkodConfig.TypeIn.prototype.New = function()
  { return this.def; }

GkodConfig.TypeIn.prototype.GetValueName = function(value)
  {
    var undefined;
    if(value===undefined) value = this.def;
    if(value===undefined) return '';
    return (this.map[value]!==undefined)?this.map[value]:value;
  }

GkodConfig.TypeIn.prototype.DecompileObject = function(value)
  { return {'value':value}; }

GkodConfig.TypeIn.prototype.RenderControl = function(ctx)
  {
    // Gkod.Trace.Write('GkodConfig.TypeIn.RenderControl');
    var v = String(ctx.dob.value);
    var s = '';
    var width = ((ctx.width!==undefined)?ctx.width:this.width);
    s += 
      '<table cellspacing="0" cellpadding="1" class="typein_cell"><tr><td>'+
        '<table cellspacing="0" cellpadding="0"><tr>'+
          '<td class="typein_acell"><input'+(ctx.va?' onfocus="GkodConfig.Page.Variable_OnFocus(\''+ctx.va.id+'\')" onblur="GkodConfig.Page.Variable_OnBlur(\''+ctx.va.id+'\')"':'')+' id="'+ctx.id+'_i" name="'+ctx.id+'_i" class="control" type="text" value="'+Gkod.Helper.EscapeHtml(v)+'"'+((width>0)?' style="width:'+(width-22)+'px"':'')+'></td>'+
          '<td class="typein_bcell"><a class="typein_b" href="#" onclick="GkodConfig.TypeIn.Choose(\''+this.tid+'\',\''+ctx.id+'_i\');return false">'+
            '<div class="typein_icell"><img width="18" height="18" border="0" src="down_w.gif"/></div>'+
          '</a><td>'+
        '</tr></table>'+
      '</td></tr></table>'
    ;
    return s;
  }

GkodConfig.TypeIn.prototype.RenderDeleted = function(ctx)
  {
    var width = ((ctx.width!==undefined)?ctx.width:this.width);
    return '<div class="deletedtext"'+((width>0)?' style="overflow:hidden;width:'+width+'px"':'')+'>'+(ctx.dob.value?Gkod.Helper.EscapeHtml(ctx.dob.value):'&nbsp;')+'</div>';
  }

GkodConfig.TypeIn.prototype.Get = GkodConfig.String.prototype.Get;
GkodConfig.TypeIn.prototype.Set = GkodConfig.String.prototype.Set;

GkodConfig.TypeIn.prototype.Validate = function(ctx,validate,ignore,sync)
  {
    var v = this.Get(ctx);
    if(!validate || !this.validate) return [true,v]; 
    return this.validate.call(ctx.va,v,sync);
  }

// Array
// ==========================================================================

GkodConfig.Array = function(rc, valueType, validate) 
{
  var undefined;

  this.rc = rc;
  this.validate = validate;
  
  if( valueType.Named !== undefined && valueType.Named === true )
  {
    this.vt = new GkodConfig.$Named(this.rc.ValueColumn,valueType)
  }
  else
  { 
    this.vt = Gkod.Helper.IsArray(valueType)?new GkodConfig.$Compound(this.rc.ValueColumn,valueType):valueType;
  }	

  var undefined;
  if (this.rc === undefined || this.rc === null) this.rc = {};
  if (this.rc.ValueColumn === undefined) this.rc.ValueColumn = 300;
  if (this.rc.RowLayout === undefined) this.rc.RowLayout = false;
  
  // I think sortable data must be moved to va[id] because Array type seems shared
  this.sortable = (this.rc.hasOwnProperty("Sortable")) ? this.rc.Sortable : false;
  if( this.sortable )
    this.sortOrder = [ ];
}

GkodConfig.Array.prototype.New = function()
  { return []; }

GkodConfig.Array.prototype.GetValueName = function(value)
  { return '(Array)'; }

GkodConfig.Array.prototype.DecompileObject = function(value)
  {
    var dob = [];
    for(var i=0,n=value.length; i<n; ++i)
      dob.push({'value':this.vt.DecompileObject(value[i]),'deleted':false});
    if(dob.length==0)
      dob[0] = {'value':this.vt.DecompileObject(this.vt.New()),'deleted':false};
    
    // must be moved to va[id]
    if( this.sortable && this.sortOrder.length !== dob.length )  
	{
	  this.sortOrder = [];
	  for( var i=0; i < dob.length; i++) this.sortOrder.push(i);
	}
	
	return dob;
  }

GkodConfig.Array.prototype.AddItem = function(va)
  {
    var ix = va.dob.length;
    va.dob[ix] = {'value':this.vt.DecompileObject(this.vt.New()),'deleted':false};
    var nn = document.createElement('div');
    nn.id = va.id+'_$'+ix;
    nn.className = 'listitem';
    nn.innerHTML = this.RenderItem(va,ix);
    Gkod.Helper.Dom.E(va.id+'_l').appendChild(nn);
    Gkod.Helper.Dom.Focus(nn);
    
 	if( this.sortable )
	  this.sortOrder.push(this.sortOrder.length);
  }

GkodConfig.Array.prototype.DeleteItem = function(va,ix)
  {
    this.StoreItem(va,ix,false);
    va.dob[ix].deleted = true;
    this.UpdateItem(va,ix);
  }

GkodConfig.Array.prototype.UndeleteItem = function(va,ix)
  {
    va.dob[ix].deleted = false;
    this.UpdateItem(va,ix);
  }

GkodConfig.Array.prototype.UpdateItem = function(va,ix)
  {
    var n = Gkod.Helper.Dom.E(va.id+'_$'+ix);
    n.innerHTML = this.RenderItem(va,ix);
    Gkod.Helper.Dom.Focus(n);
  }

GkodConfig.Array.prototype.MoveItemUp = function(va,ix)
  { 
    var activeNode = Gkod.Helper.Dom.E( va.id + '_$' + ix );
    var Parent = activeNode.parentNode;

    var ordered_ix;
    for(var i=0; i<this.sortOrder.length; i++)
    {
      if( this.sortOrder[i] == ix )
      {
        ordered_ix = i;
        if( i > 0 ) 
        {
          var bumped_ix = this.sortOrder.splice(i-1,1,ix);
          this.sortOrder.splice(i,1,bumped_ix[0]);

          var bumpedNode = Gkod.Helper.Dom.E( va.id + '_$' + bumped_ix[0] );
          Parent.insertBefore(activeNode, bumpedNode);
        }
        break;
      }
    }
  }
  
GkodConfig.Array.prototype.MoveItemDown = function(va,ix)
  { 
    var activeNode = Gkod.Helper.Dom.E( va.id + '_$' + ix );
    var Parent = activeNode.parentNode;

    var ordered_ix;
    var i;
    for(i=0; i<this.sortOrder.length; i++)
    {
      if( this.sortOrder[i] == ix )
      {
        ordered_ix = i;
        if( i < (this.sortOrder.length - 1) ) 
        {
          var bumped_ix = this.sortOrder.splice(i+1,1,ix);
          this.sortOrder.splice(i,1,bumped_ix[0]);

          var bumpedNode = Gkod.Helper.Dom.E( va.id + '_$' + bumped_ix[0] );
          Parent.insertBefore(bumpedNode, activeNode);
        }
		break;
      }
    }
  }  
  
GkodConfig.Array.prototype.StoreItem = function(va,ix,validate,ignore,sync)
  {
    var vv = this.vt.Validate({'va':va,'id':va.id+'_$'+ix+'v'},validate,ignore,sync);
    if(vv[0]===true) va.dob[ix].value = this.vt.DecompileObject(vv[1]);
    if(!validate) return vv;
    if(!ignore)
    {
      var n = Gkod.Helper.Dom.E(va.id+'_$'+ix+'_n');
      if(vv[0]===true || vv[0]===false)
      {
        n.style.display = 'none';
        n.parentNode.className = '';
      }
      else
      {
        n.innerHTML = vv[0];
        n.style.display = '';
        n.parentNode.className = 'errormark';
      }
    }
    return vv;
  }

GkodConfig.Array.prototype.RenderItem = function(va,ix)
  { 
    var st = va.dob[ix];
    var s = '<div><div id="'+va.id+'_$'+ix+'_n" class="varerror" style="display:none;width:'+this.rc.ValueColumn+'px"></div>';

    var buttons = '<div class="rlink">';

	if(this.sortable)
	{
	    buttons += '<a onfocus="GkodConfig.Page.Variable_OnFocus(\''+va.id+'\')" '
		        +  'onblur="GkodConfig.Page.Variable_OnBlur(\''+va.id+'\')" '
		        +  'class="sbutton" href="#" '
		        +  'onclick="GkodConfig.Page.MoveItemUp(\''+va.id+'\','+ix+');return false">'
		        +  '<img src="shuttle_uparrow.png" alt="'+Gkrc('Config.Action.Up')+'" title="'+Gkrc('Config.Action.Up')+'"/>'
		        +  '</a>'
				+  '<a onfocus="GkodConfig.Page.Variable_OnFocus(\''+va.id+'\')" '
		        +  'onblur="GkodConfig.Page.Variable_OnBlur(\''+va.id+'\')" '
		        +  'class="sbutton" href="#" '
		        +  'onclick="GkodConfig.Page.MoveItemDown(\''+va.id+'\','+ix+');return false">'
		        +  '<img src="shuttle_downarrow.png" alt="'+Gkrc('Config.Action.Down')+'" title="'+Gkrc('Config.Action.Down')+'"/>'
		        +  '</a>';
	}

    if(st.deleted)
	{
		buttons += '<a onfocus="GkodConfig.Page.Variable_OnFocus(\''+va.id+'\')" '
		        +  'onblur="GkodConfig.Page.Variable_OnBlur(\''+va.id+'\')" '
		        +  'class="sbutton" href="#" '
		        +  'onclick="GkodConfig.Page.UndeleteItem(\''+va.id+'\','+ix+');return false">'
		        +  '<img src="undo_ena.png" alt="'+Gkrc('Config.Action.Undo')+'" title="'+Gkrc('Config.Action.Undo')+'"/>'
		        +  '</a>';
	}
	else
	{
	    buttons += '<a onfocus="GkodConfig.Page.Variable_OnFocus(\''+va.id+'\')" '
		        +  'onblur="GkodConfig.Page.Variable_OnBlur(\''+va.id+'\')" '
		        +  'class="sbutton" href="#" '
		        +  'onclick="GkodConfig.Page.DeleteItem(\''+va.id+'\','+ix+');return false">'
		        +  '<img src="delete_ena.png" alt="'+Gkrc('Config.Action.Delete')+'" title="'+Gkrc('Config.Action.Delete')+'"/>'
		        +  '</a>';
	}
	
	buttons += '</div>';
      
   if( st.deleted && this.rc.RowLayout == false )
    {
      s += this.RenderColumns
      (
        this.vt.RenderDeleted({'va':va,'id':va.id+'_$'+ix+'v','dob':st.value,'width':this.rc.ValueColumn}),
	    buttons
      );  
    }
    else if( this.rc.RowLayout == false )
    {
      s += this.RenderColumns
      (
        this.vt.RenderControl({'va':va,'id':va.id+'_$'+ix+'v','dob':st.value,'width':this.rc.ValueColumn}),
		buttons
      );
    }
	else if( st.deleted && this.rc.RowLayout == true )
	{
      s += this.RenderRows
      (
        this.vt.RenderDeleted({'va':va,'id':va.id+'_$'+ix+'v','dob':st.value,'width':this.rc.ValueColumn}),
	    buttons
      );  
	
	}
	else 
	{
      s += this.RenderRows
      (
        this.vt.RenderControl({'va':va,'id':va.id+'_$'+ix+'v','dob':st.value,'width':this.rc.ValueColumn}),
	    buttons
      );  
	
	}
	
	s += '</div>';
    return s;
  }

GkodConfig.Array.prototype.RenderRows = function(values,right,offs)
  {
    var s = '';
    if(right) 
	  s += '<table width="100%" cellspacing="0" cellpadding="0">'
	    +  '<tr><td style="border-bottom: 1px solid #F3F3F3">';

	s += '<table cellspacing="0" cellpadding="0">';
	
	for(var i=0,n=this.vt.types.length; i<n; ++i)
	{
	  s += '<tr><td style="width:100px"><div class="listhead">'
	    +  this.rc.Value[i]
		+'</div></td>';
		
	  s += '<td>';
	  s += values[i];
	  s += '</td></tr>';
	  
	}
	
	s += '</table>';
	
    if(right) 
	  s += '</td><td  style="border-bottom: 1px solid #F3F3F3">'
	    +  right + '</td></tr></table>';
		
    return s;
  }  
  
GkodConfig.Array.prototype.RenderColumns = function(values,right,offs)
  {
    var s = '';
    if(right) 
      s += '<table width="100%" cellspacing="0" cellpadding="0"><tr><td>';
    s += '<table cellspacing="0" cellpadding="0"><tr>'+GkodConfig.$RenderColumns(this.vt,this.rc.ValueColumn,values,true,offs)+'</tr></table>';
    if(right)
      s += '</td><td>'+right+'</td></tr></table>';
    return s;
  }

GkodConfig.Array.prototype.RenderControl = function(ctx)
  {
    var va = ctx.va;

    var itemList = '';
    for(var i=0,n=va.dob.length; i<n; ++i)
      itemList += '<div id="'+va.id+'_$'+i+'" class="listitem">'+this.RenderItem(va,i)+'</div>';
    
    var s = '<div class="list">';
	
    if( (this.vt.constructor==GkodConfig.$Compound 
	     || this.vt.constructor==GkodConfig.$Named)  
		 && this.rc.RowLayout==false
	   )
	{
	  s += '<div class="listhead">'+this.RenderColumns(this.rc.Value,null,4)+'</div>';
	}   
	   
    s += '<div id="'+ctx.id+'_l'+'">'+itemList+'</div>'
	  +	 '<div class="rrlink">'
	  +	 '<a onfocus="GkodConfig.Page.Variable_OnFocus(\''+ctx.va.id+'\')" onblur="GkodConfig.Page.Variable_OnBlur(\''+ctx.va.id+'\')" '
	  +	 'class="sbutton" href="#" onclick="GkodConfig.Page.AddItem(\''+ctx.id+'\');return false">'
	  +	 '<img src="add_ena.png" alt="'
	  +  Gkrc('Config.Action.NewRow')
	  +  '" title="'
	  +  Gkrc('Config.Action.NewRow')+'"/>'
	  +  '</a></div>'
      +  '</div>'
    ;
    
    return s;
  }

GkodConfig.Array.prototype.Validate = function(ctx,validate,ignore,sync)
  {
    var undefined; if(validate===undefined) validate = true;
  
    var ev = this.vt.New();
    var va = ctx.va;
    var valid = true;
    var a = [];
    var canreset = (va.dob.length!=1)||va.dob[0].deleted;
    
    for(var j=0,n=va.dob.length; j<n; ++j)
    {
	  var i = (this.sortable) ? this.sortOrder[j] : j;
	        
	  if(va.dob[i].deleted) continue;
      var vi = this.StoreItem(va,i,validate,ignore,sync);
      if(Gkod.Helper.Equals(ev,vi[1])) continue;
      canreset = true;
      if(vi[0]===true) a.push(vi[1]); else valid = false;
    }
    
    if(!validate || !this.validate) return [valid,a,canreset];

    var r = this.validate.call(ctx.va,a,sync);
    if(r[0]===true && valid) return r;
    if(r[0]===false) r[0] = 'Invalid';
    if(r[0]!==true) r[0] = Gkod.Helper.EscapeHtml(this.rc[r[0]] || r[0]);
    r[3] = canreset;
    return r;
  }

// Dictionary
// ==========================================================================

GkodConfig.Dictionary = function(rc, keyType, valueType, validate, validateItem)
{
  this.rc = Gkod.Helper.Clone(rc);
  this.kt = Gkod.Helper.IsArray(keyType)?new GkodConfig.$Compound(this.rc.KeyColumn,keyType):keyType;
  this.vt = Gkod.Helper.IsArray(valueType)?new GkodConfig.$Compound(this.rc.ValueColumn,valueType):valueType;
  this.validate = validate;
  this.validateItem = validateItem;
  
  var undefined;
  if(this.rc===undefined || this.rc===null) this.rc = {};
  if(this.rc.KeyColumn  ===undefined) this.rc.KeyColumn   = 110;
  if(this.rc.ValueColumn===undefined) this.rc.ValueColumn = 260;
}

GkodConfig.Dictionary.prototype.New = function()
  { return {}; }

GkodConfig.Dictionary.prototype.GetValueName = function(value)
  { return '(Object)'; }

GkodConfig.Dictionary.prototype.$DecompileKeyExItem = function(dob,types,keys,key,value)
  {
    var undefined;
    keys.push((key===undefined)?types[0].New():key);
    var t = types.shift();
    if(types.length==0)
      dob.push({'key':this.kt.DecompileObject(Gkod.Helper.DeepClone(keys)),'value':this.vt.DecompileObject(value),'deleted':false});
    else this.$DecompileKeyEx(dob,types,keys,value);
    types.unshift(t);
    keys.pop();
  }

GkodConfig.Dictionary.prototype.$DecompileKeyEx = function(dob,types,keys,value)
  {
    var undefined;
    if(value===undefined)
      return this.$DecompileKeyExItem(dob,types,keys);
    for(var m in value)
      this.$DecompileKeyExItem(dob,types,keys,m,value[m]);
  }

GkodConfig.Dictionary.prototype.DecompileObject = function(value)
  {
    var dob = [];
    if(this.kt.constructor===GkodConfig.$Compound)
      this.$DecompileKeyEx(dob,Gkod.Helper.Clone(this.kt.types),[],value);
    else
      for(var m in value)
        dob.push({'key':this.kt.DecompileObject(m),'value':this.vt.DecompileObject(value[m]),'deleted':false});
    if(dob.length==0)
      dob[0] = {'key':this.kt.DecompileObject(this.kt.New()),'value':this.vt.DecompileObject(this.vt.New()),'deleted':false};
    return dob;
  }

GkodConfig.Dictionary.prototype.AddItem = function(va)
  {
    var ix = va.dob.length;
    va.dob[ix] = {'key':this.kt.DecompileObject(this.kt.New()),'value':this.vt.DecompileObject(this.vt.New()),'deleted':false};
    var nn = document.createElement('div');
    nn.id = va.id+'_$'+ix;
    nn.className = 'listitem';
    nn.innerHTML = this.RenderItem(va,ix);
    Gkod.Helper.Dom.E(va.id+'_l').appendChild(nn);
    Gkod.Helper.Dom.Focus(nn);
  }

GkodConfig.Dictionary.prototype.DeleteItem = function(va,ix)
  {
    this.StoreItem(va,ix,false);
    va.dob[ix].deleted = true;
    this.UpdateItem(va,ix);
  }

GkodConfig.Dictionary.prototype.UndeleteItem = function(va,ix)
  {
    va.dob[ix].deleted = false;
    this.UpdateItem(va,ix);
  }

GkodConfig.Dictionary.prototype.UpdateItem = function(va,ix)
  {
    var n = Gkod.Helper.Dom.E(va.id+'_$'+ix);
    n.innerHTML = this.RenderItem(va,ix);
    Gkod.Helper.Dom.Focus(n);
  }

GkodConfig.Dictionary.prototype.StoreItem = function(va,ix,validate,ignore,sync)
  {
    var st = va.dob[ix];
    var vk = this.kt.Validate({'id':va.id+'_$'+ix+'k'},validate,ignore,sync);
    var vv = this.vt.Validate({'id':va.id+'_$'+ix+'v'},validate,ignore,sync);
    if(!validate)
    {
      st.key = this.kt.DecompileObject(vk[1]);
      st.value = this.vt.DecompileObject(vv[1]);
      return [true,vk[1],vv[1]];
    }

    var msga = [];

    var valid = true;
    var k = null;
    var v = null;

    if(vk[0]!==true) { valid=false; if(vk[0]!==false) msga.push(vk[0]); }
    if(vv[0]!==true) { valid=false; if(vv[0]!==false) msga.push(vv[0]); }

    if(valid)
    {
      if(!this.validateItem)
        { k = vk[1]; v = vv[1]; }
      else
      {
        var r = this.validateItem(vk[1],vv[1],sync);
        if(r[0]===true)
          { k = r[1]; v = r[2]; }
        else
        {
          valid = false;
          var msg = (r[0]===false)?'Invalid':r[0];
          if(this.rc[msg]) msg = this.rc[msg];
          msga.push(Gkod.Helper.EscapeHtml(msg));
        }
      }
      if(valid) { st.key = this.kt.DecompileObject(k); st.value = this.vt.DecompileObject(v); }
    }
    
    if(!ignore)
    {
      var n = Gkod.Helper.Dom.E(va.id+'_$'+ix+'_n');
      if(msga.length > 0)
      {
        n.innerHTML = msga.join('<br/>');
        n.style.display = '';
        n.parentNode.className = 'errormark';
      } 
      else
      {
        n.style.display = 'none';
        n.parentNode.className = '';
      }
    }

    return [valid,k,v];
  }

GkodConfig.Dictionary.prototype.RenderItem = function(va,ix)
  {
    var s = '';
    var st = va.dob[ix];
    var id_n = va.id+'_$'+ix+'_n';
  
    var buttons = '<div class="rlink">';

    if(st.deleted)
	{
		buttons += '<a onfocus="GkodConfig.Page.Variable_OnFocus(\''+va.id+'\')" '
		        +  'onblur="GkodConfig.Page.Variable_OnBlur(\''+va.id+'\')" '
		        +  'class="sbutton" href="#" '
		        +  'onclick="GkodConfig.Page.UndeleteItem(\''+va.id+'\','+ix+');return false">'
		        +  '<img src="undo_ena.png" alt="'+Gkrc('Config.Action.Undo')+'" title="'+Gkrc('Config.Action.Undo')+'"/>'
		        +  '</a>';
	}
	else
	{
	    buttons += '<a onfocus="GkodConfig.Page.Variable_OnFocus(\''+va.id+'\')" '
		        +  'onblur="GkodConfig.Page.Variable_OnBlur(\''+va.id+'\')" '
		        +  'class="sbutton" href="#" '
		        +  'onclick="GkodConfig.Page.DeleteItem(\''+va.id+'\','+ix+');return false">'
		        +  '<img src="delete_ena.png" alt="'+Gkrc('Config.Action.Delete')+'" title="'+Gkrc('Config.Action.Delete')+'"/>'
		        +  '</a>';
	}

	buttons += '</div>';
  
    s += '<div><div id="'+id_n+'" class="varerror" style="display:none;width:'+(this.rc.KeyColumn+this.rc.ValueColumn)+'px"></div>';
    if(st.deleted)
    {
      s += this.RenderColumns
      (
        this.kt.RenderDeleted({'va':va,'id':va.id+'_$'+ix+'k','dob':st.key,'width':this.rc.KeyColumn}),
        this.vt.RenderDeleted({'va':va,'id':va.id+'_$'+ix+'v','dob':st.value,'width':this.rc.ValueColumn}),
		buttons
      );
    }
    else
    {
      s += this.RenderColumns
      (
        this.kt.RenderControl({'va':va,'id':va.id+'_$'+ix+'k','dob':st.key,'width':this.rc.KeyColumn}),
        this.vt.RenderControl({'va':va,'id':va.id+'_$'+ix+'v','dob':st.value,'width':this.rc.ValueColumn}),
        buttons
      );
    }  
	s += '</div>';
    return s;
  }
GkodConfig.Dictionary.prototype.RenderColumns = function(keys,values,right,offs)
  {
    var s = '';
    if(right)
      s += '<table width="100%" cellspacing="0" cellpadding="0"><tr><td>';
    s += 
      '<table cellspacing="0" cellpadding="0"><tr>'+
         GkodConfig.$RenderColumns(this.kt,this.rc.KeyColumn,keys,true,offs)+
         GkodConfig.$RenderColumns(this.vt,this.rc.ValueColumn,values,false,offs)+
       '</tr></table>'
    ;
    if(right)
      s += '</td><td>'+right+'</td></tr></table>';
    return s;
  }

GkodConfig.Dictionary.prototype.RenderControl = function(ctx)
  {
    var va = ctx.va;

    var itemList = ''; 
    for(var i=0,n=va.dob.length; i<n; ++i)
      itemList += '<div id="'+va.id+'_$'+i+'" class="listitem">'+this.RenderItem(va,i)+'</div>';
    
    var s = 
      '<div class="list">'+
        '<div class="listhead">'+this.RenderColumns(this.rc.Key,this.rc.Value,null,4)+'</div>'+
        '<div id="'+ctx.id+'_l'+'">'+itemList+'</div>'+
		// start MGH IR 28716 array ui updates
        //'<table cellspacing="0" cellpadding="3"><tr>'+
        //  '<td><div class="llink"><a onfocus="GkodConfig.Page.Variable_OnFocus(\''+ctx.va.id+'\')" onblur="GkodConfig.Page.Variable_OnBlur(\''+ctx.va.id+'\')" class="sbutton" href="#" onclick="GkodConfig.Page.AddItem(\''+ctx.id+'\');return false">'+Gkrc('Config.Action.NewRow')+'</a></div></td>'+
		//  '</tr></table>'+
		// end original
		//'<table cellspacing="0" cellpadding="3"><tr><td>'+
		'<div class="rrlink"><a onfocus="GkodConfig.Page.Variable_OnFocus(\''+ctx.va.id+'\')" '+
		'onblur="GkodConfig.Page.Variable_OnBlur(\''+ctx.va.id+'\')" '+
		'class="sbutton" href="#" onclick="GkodConfig.Page.AddItem(\''+ctx.id+'\');return false">'+
        '<img src="add_ena.png" alt="'+Gkrc('Config.Action.NewRow')+'" title="'+Gkrc('Config.Action.NewRow')+'"/>'+
		'</a></div>'+
        //'</td></tr></table>'+
		// end MGH IR 28716 array ui updates  
      '</div>'
    ;
    
    return s;
  }

GkodConfig.Dictionary.prototype.HasKey = function(o,key)
  {
    var undefined;
    if(this.kt.constructor!==GkodConfig.$Compound)
      return (o[key]!==undefined);
    var c = o;
    for(var i=0,n=key.length; i<n; ++i)
    {
      if(c[key[i]]===undefined)
        return false;
      c=c[key[i]];
    }
    return true;
  }

GkodConfig.Dictionary.prototype.EnsureKeyAndValue = function(o,key,value)
  {
    if(this.kt.constructor!==GkodConfig.$Compound)
    {
      o[key]=value;
      return;
    }
    
    var undefined;
    var c = o;
    for(var i=0,n=key.length-1; i<n; ++i)
    {
      if(c[key[i]]===undefined)
        c[key[i]]={};
      c=c[key[i]];
    }
    c[key[key.length-1]] = value;
  }

GkodConfig.Dictionary.prototype.Validate = function(ctx,validate,ignore,sync)
  {
    var undefined; if(validate===undefined) validate = true;

    var ek = this.kt.New();
    var ev = this.vt.New();
    var msg;
    var msga = [];
    var va = ctx.va;
    var valid = true;
    var o = {};
    var canreset = (va.dob.length!=1)||va.dob[0].deleted;
    for(var i=0,n=va.dob.length; i<n; ++i)
    {
      if(va.dob[i].deleted) continue;
      var vi = this.StoreItem(va,i,validate,ignore,sync);
      if(Gkod.Helper.Equals(ek,vi[1])&&Gkod.Helper.Equals(ev,vi[2])) continue;
      canreset = true;
      if(vi[0]===true)
      {
        var k = vi[1]; 
        if(this.HasKey(o,k))
        {
          var kn = this.kt.GetValueName(k);
          var ks = Gkod.Helper.IsArray(kn)?kn.join(', '):kn;
          msga.push(Gkod.Helper.FormatHtml(this.rc['DuplicatedKey']||Gkrc('Config.Message.Dictionary.DuplicatedKey'),{'KEY':ks}));
          valid = false;
        }
        this.EnsureKeyAndValue(o,k,vi[2]);
      }
      else valid = false;
    }
    
    if(!validate || !this.validate) return [(valid?true:((msga.length>0)?msga.join('<br/>'):false)),o,canreset];
    var r = this.validate.call(ctx.va,o,sync);
    if(r[0]===true && valid) return r;
    if(r[0]===false) r[0] = 'Invalid';
    if(r[0]!==true) msga.push(Gkod.Helper.EscapeHtml(this.rc[r[0]] || r[0]));
    r[0] = msga.join('<br/>');
    r[3] = canreset;
    return r;
  }

// TemplateMap
// ==========================================================================

GkodConfig.TemplateMap = function()
{
  this.map = new Object();
}

GkodConfig.TemplateMap.prototype.Add = function(name, template)
{
  this.map[name] = template;
}

GkodConfig.TemplateMap.prototype.Get = function(name)
{
  var undefined;
  return ((this.map[name]===undefined)?null:this.map[name]);
}

// Template
// ==========================================================================

GkodConfig.Template = function()
{
  this.sections = new Object();
  this.section = null;
}

GkodConfig.Template.prototype.AddSection = function(name)
{
  var undefined;
  this.section = this.sections[name];
  if(this.section===undefined)
  {
    this.section = new Array();
    this.sections[name] = this.section;
  }
}

GkodConfig.Template.prototype.AddVariable = function(name, type, flags)
{
  var undefined;
  if(name === undefined)
    return;
  if(!this.section)
    this.AddSection('');
  var o = new Object();
  o.name = name;
  o.type = type;
  o.flags = flags;
  this.section.push(o);
}

