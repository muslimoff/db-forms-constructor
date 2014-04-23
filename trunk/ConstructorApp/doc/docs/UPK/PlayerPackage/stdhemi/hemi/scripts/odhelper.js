/*--
Copyright © 1998, 2009, Oracle and/or its affiliates.  All rights reserved.
--*/

//<!--Version 9.6.0.20-->

var Gkod_Undefined; // must have no value assigned, used for safe 'undefined' type checks

if(window.Gkod===Gkod_Undefined) Gkod={};
// if(window.Gkrc===Gkod_Undefined) Gkrc={};

if(Gkod.Helper===Gkod_Undefined) Gkod.Helper={};

// Component Management
// ==========================================================================

if(Gkod.Helper.$Component===Gkod_Undefined)
{
  Gkod.Helper.$Component = {};
  Gkod.Helper.$ComponentLoading = null;

  Gkod.Helper.LoadComponent = function(c)
  {
    var _c;
    if(Gkod.Helper.$ComponentLoading!==null)
    {
      _c = Gkod.Helper.$Component[Gkod.Helper.$ComponentLoading];
      if(_c!==Gkod_Undefined && _c.loading)
        Gkod.Trace.Error('Gkod.Helper.LoadComponent, unfinished load detected, ['+Gkod.Helper.$ComponentLoading+'], now loading ['+c+']');
    }
    _c = Gkod.Helper.$Component[c];
    if(_c!==Gkod_Undefined)
    { 
      if(!_c.loading) return false;
      Gkod.Trace.Error('Gkod.Helper.LoadComponent, unfinished load detected, reloading component ['+c+']');
    }
    Gkod.Helper.$ComponentLoading = c;
    Gkod.Helper.$Component[c] = {"loading":true, "time":new Date().getTime(), "elapsed":0};
    Gkod.Trace.Write(c+ ' loading...');
    return true;
  }
  
  Gkod.Helper.ComponentLoaded = function(c)
  {
    if(c===Gkod_Undefined) c = Gkod.Helper.$ComponentLoading;
    var _c;
    if(c!==null && c!==Gkod_Undefined)
      _c = Gkod.Helper.$Component[c];
    if(_c===Gkod_Undefined)
    {
      Gkod.Trace.Error('Gkod.Helper.ComponentLoaded, wrong call: component not loaded ['+c+']');
      Gkod.Helper.LoadComponent(c);
      _c = Gkod.Helper.$Component[c];
    }
    else if(!_c.loading)
      Gkod.Trace.Error('Gkod.Helper.ComponentLoaded, wrong call: component already loaded ['+c+']');
    _c.loading = false;
    _c.elapsed = new Date().getTime()-_c.time;
    Gkod.Helper.$ComponentLoading = null;  
    Gkod.Trace.Write(c+' loaded in '+_c.elapsed+' ms');
  }
}

// BEGIN COMPONENT: Gkod.Helper =============================================

if(Gkod.Helper.LoadComponent('Gkod.Helper:2.090922'))
{

Gkod_Helper_Debug = false;
Gkod_Helper_Checks = false;

Gkod.Helper.IE = (navigator.userAgent.indexOf('MSIE ')>-1);
Gkod.Helper.IE6 = (navigator.userAgent.indexOf('MSIE 6')>-1);
Gkod.Helper.IE7 = (navigator.userAgent.indexOf('MSIE 7')>-1);

// checks

Gkod.Helper.Check = Gkod_Helper_Checks? function(v,e) { if(!!v) return true; Gkod.Trace.Error('Check failed, '+e); return false; } : function(v) { return !!v; };
Gkod.Helper.Ensure = function(v,e) { if(this.Check(v,e)) return true; throw 'EnsureFail'+((e!==Gkod_Undefined)?'('+e+')':''); }
Gkod.Helper.Exception = function(e,s) { Gkod.Trace.Error(s+((s!==Gkod_Undefined)?', ':'')+'Exception: '+(e.message||String(e))); }
Gkod.Helper.TryCall = function(f,n)
  {
    if(!Gkod.Helper.IsArray(f))
      { try { f.call(); return true; } catch(e) { if(n) Gkod.Helper.Exception(e,n); } return false; }
    for(var i=0; i<f.length; ++i)
      { try { f.call(); return true; } catch(e) { if(n) Gkod.Helper.Exception(e,n); } }
    return false;
  }
Gkod.Helper.GetException = function(e) { return (e.message||String(e)); }

// type, object functions

Gkod.Helper.Is = function(o,t){ return ((o===Gkod_Undefined||o===null)?o===t:o.constructor===t); }
Gkod.Helper.IsNull = function(o) { return o===Gkod_Undefined||o===null; }
Gkod.Helper.IsEmpty = function(o) { return o===Gkod_Undefined||o===null||(o.length!==Gkod_Undefined&&o.length==0); }
Gkod.Helper.IsFunction = function(o) { return (typeof(o)=='function'); }
Gkod.Helper.IsWindow = function(o) { return (typeof(o)=='object'&&(o.constructor==Window)); }
Gkod.Helper.IsObject = function(o) { return (typeof(o)=='object'); }
Gkod.Helper.IsArray = function(o) { return (typeof(o)=='object'&&(o.join!==Gkod_Undefined)&&(o.push!==Gkod_Undefined)&&(o.length!==Gkod_Undefined)); }
Gkod.Helper.IsString = function(o) { return (typeof(o)=='string')||((typeof(o)=='object'&&o.constructor==String)); }
Gkod.Helper.IsNumber = function(o) { return (typeof(o)=='number')||((typeof(o)=='object'&&o.constructor==Number)); }
Gkod.Helper.IsBoolean = function(o) { return (typeof(o)=='boolean')||((typeof(o)=='object'&&o.constructor==Boolean)); }
Gkod.Helper.IsHashObject = function(o) { return ((typeof(o)=='object')&&(o.constructor!=String)&&(o.constructor!=Number)&&(o.constructor!=Boolean)); }

Gkod.Helper.Nop = function() {}

Gkod.Helper.EnsureMember = function(o,m,v) { var undefined; if(o[m]===undefined) o[m]=v; }

Gkod.Helper.Override = function(d,s)
  {
    var undefined;
    if(s===undefined||s===null) return d;
    for(var m in s) d[m]=s[m];
    return d;
  }

Gkod.Helper.Merge = function(d,s)
  {
    var undefined;
    if(s===undefined||s===null) return d;
    for(var m in s) if(d[m]===undefined) d[m]=s[m];
    return d;
  }
  
Gkod.Helper.Extend = function(d,s)
  {
    var undefined;
    if(d===undefined || d===null) d = {};
    for(var m in s)
    {
      var $m = s[m];
      d[m] = Gkod.Helper.IsHashObject($m)?Gkod.Helper.Extend(d[m],$m):$m;
    }
    return d;
  }

Gkod.Helper.Clone = function(v)
  {
    try
    {
      var undefined;
      var t = typeof v;
      if(t!='object')
      {
        if(t=='string') return String(v);
        if(t=='number') return Number(v);
        if(t=='boolean') return Boolean(v);
        if(t=='function'||t=='undefined') return v; 
      }
      if(v===null||v.attachEvent||v.QueryInterface||v.constructor===undefined) return v;
      if(v.constructor===String) return String(v);
      if(v.constructor===Number) return Number(v);
      if(v.constructor===Boolean) return Boolean(v);
      if(v.constructor===RegExp) return RegExp(v);
      if(v.constructor===Function) return v;

      var undefined;
      var b = (v.constructor===Array||(v.push&&v.pop&&v.splice))?[]:{};
      if(b.__proto__ !== v.__proto__) b.__proto__ = v.__proto__;
      if(b.prototype !== v.prototype) b.prototype = v.prototype;
      for(var m in v)
        b[m] = v[m];
      return b;
    }
    catch(e) {}
    return v;
  }

Gkod.Helper._DeepClone = function(a)
{
  try
  {
    var undefined;
    var b = (a.constructor===Array||(a.push&&a.pop&&a.splice))?[]:{};
    if(b.__proto__ !== a.__proto__) b.__proto__ = a.__proto__;
    if(b.prototype !== a.prototype) b.prototype = a.prototype;
    for(var m in a)
    {
      try
      {
        var v = a[m];
        var t = typeof v;
        if(t!='object')
        {
          if(t=='string') { b[m]=String(v); continue; }
          if(t=='number') { b[m]=Number(v); continue; }
          if(t=='boolean') { b[m]=Boolean(v); continue; }
          if(t=='function'||t=='undefined')
            { b[m]=v; continue; }
        }
        if(v===null||v.attachEvent||v.QueryInterface||v.constructor===undefined) { b[m]=v; continue; }
        if(v.constructor===String) { b[m]=String(v); continue; }
        if(v.constructor===Number) { b[m]=Number(v); continue; }
        if(v.constructor===Boolean) { b[m]=Boolean(v); continue; }
        if(v.constructor===RegExp) { b[m]=RegExp(v); continue; }
        if(v.constructor===Function) { b[m]=v; continue; }
        b[m] = Gkod.Helper._DeepClone(v);
      }
      catch(e) { b[m]=v; }
    }
    return b;
  }
  catch(e) {}
  return a;
}

Gkod.Helper.DeepClone = function(a)
  { return Gkod.Helper._DeepClone({'_':a})._; }

Gkod.Helper.Equals = function(a,b)
  {
    if(a===b) return true;
    if(a===null || b===null) return false;
    var t=typeof(a);
    if(t=='undefined' || typeof(b)=='undefined') return false;
    if(a.QueryInterface) return false; // a===b must work for this
    if(t!=typeof(b)) return a==b;
    if(t!='object')
    {
      if(t=='string'||t=='number'||t=='boolean') return a==b;
      if(t=='function') { if(String(a)!=String(b)) return false; }
    }
    else
    {
      var c = a.constructor;
      if(c!==b.constructor) return false;
      if(c===String||c===Number||c===Boolean||c===RegExp) return a==b;
      if(c===Function) { if(String(a)!=String(b)) return false; }
      else if(c===Array||(a.push&&a.pop&&a.splice)) { if(a.length!=b.length) return false; }
    }
    
    var undefined;
    var x = {};
    for(var m in a)
      { x[m] = true; if((a[m]!==undefined&&b[m]===undefined) || !Gkod.Helper.Equals(a[m],b[m])) return false; }
    for(var m in b)
      if(!x[m]) return false;
    return true;
  }

Gkod.Helper.SerializeString = function(s)
  {
    var undefined;
    if(s===undefined || s===null) return '""';
    return '"'+String(s).replace(/(["\\])/g,"\\$1").replace(/\r\n|\n|\r/g,"\\n").replace('</',"<\\/")+'"';
  }

Gkod.Helper.Serialize = function(v,maxdepth,depth)
  {
    var undefined;
    if(v===undefined || v===null) return 'null';
    if(Gkod.Helper.IsString(v)) return '"'+v.replace(/(["\\])/g,"\\$1").replace(/\r\n|\n|\r/g,"\\n").replace('</',"<\\/")+'"';
    if(Gkod.Helper.IsNumber(v)) return String(v);
    if(Gkod.Helper.IsBoolean(v)) return (v?'true':'false');
    if(Gkod.Helper.IsFunction(v)) return v;
    if(v.attachEvent||v.QueryInterface) return 'null'; // do not serialize complex objects

    if(maxdepth===undefined) maxdepth = 20;
    if(maxdepth>0)
      depth = (depth>0)? (depth+1): 1;

    if(Gkod.Helper.IsArray(v))
    {
      if(depth>maxdepth)
        return '[]';
      var a = [];
      for(var i=0,n=v.length; i<n; ++i)
        { try { a.push(Gkod.Helper.Serialize(v[i],maxdepth,depth)); } catch(_e) {} }
      return '['+a.join()+']';
    }

    if(Gkod.Helper.IsObject(v))
    {
      if(depth>maxdepth)
        return '{}';
      var a = [];
      for(var m in v)
        { try { a.push(Gkod.Helper.SerializeString(m)+':'+Gkod.Helper.Serialize(v[m],maxdepth,depth)); } catch(_e) {} }
      return '{'+a.join()+'}';
    }

    return 'null';
  }
  
Gkod.Helper.Get = function(o,d) { var undefined; return ((o===undefined)?d:o); }
Gkod.Helper.GetNonNull = function(o,d) { return Gkod.Helper.IsNull(o)?d:o; }
Gkod.Helper.GetNonEmpty = function(o,d) { return Gkod.Helper.IsEmpty(o)?d:o; }

Gkod.Helper.CaseInsensitiveCompare = function(a,b)
{
  var la = a.toLowerCase();
  var lb = b.toLowerCase();
  return (la<lb?-1:(la==lb?(a<b?-1:(a==b?0:1)):1));
}

Gkod.Helper.SortMap = function(map,compareFn)
  {
    var a = new Array();
    for(var m in map)
      a.push(m);
    a.sort(compareFn);
    var r = new Object();
    for(var i=0;i<a.length;++i)
      r[a[i]]=map[a[i]];
    return r;
  }

// time functions

Gkod.Helper.GetTime = function() { return new Date().getTime(); }
Gkod.Helper.GetElapsed = function(t) { return (new Date().getTime()-t); }

// string functions

Gkod.Helper.PostfixFilename = function(s,x) 
  { 
    var _s=String(s);
    var r=_s.replace(/\.([^\/]*)$/,x+'.$1');
    if(r==_s) r+=x;
    return r;
  }
Gkod.Helper.Trim = function(s) { var _s=String(s); return _s.replace(/^\s+|\s+$/g,''); }
Gkod.Helper.LeftTrim = function(s) { var _s=String(s); return _s.replace(/^\s+/g,''); }
Gkod.Helper.RightTrim = function(s) { var _s=String(s); return _s.replace(/\s+$/g,''); }
Gkod.Helper.Strip = function(s) { var _s=String(s); return _s.replace(/\s+/g,' ').replace(/^\s+|\s+$/g,''); }
Gkod.Helper.EscapeRegExp = function(s) {return String(s).replace(/([\^\$\.\*\+\?\|\(\)\[\]\{\}\\])/g,"\\$1");}
Gkod.Helper.EscapeHtml = function(s) {if(s===null) return ''; return String(s).replace(/&/g,"&amp;").replace(/</g,"&lt;").replace(/>/g,"&gt;");}
Gkod.Helper.FormatHtml = function(fmt,arg)
  {
    var undefined;
    var s = '';
    arg = arg||new Object();
    var a = String(fmt).match(/[^\n\{<]+|<[\/]?(?:[biu]|h[1-6]|br)[\/]?>|[<\n]|\{(?:[0-9A-Z_]+\})?/g);
    if(a)
    {
      for(var i=0,n=a.length; i<n; ++i)
      {
        var $i = a[i];
        var $c = $i.charAt(0);
        if($c=='{' && $i.length>1)
        {
          var v = arg[$i.substr(1,$i.length-2)];
          if(v!==undefined)
            s += String(v);
        }
        else if($c == '<' && $i.length>1)
          s += $i;
        else if($c == '\n') s += '<br/>';
        else s += Gkod.Helper.EscapeHtml($i);
      }
    }
    return s;
  }
Gkod.Helper._fsrx = /[^\{]+|\{(?:[0-9A-Za-z_]+\})?/g;
Gkod.Helper.FormatString = function(format,args)
  {
    if(format == null)
      return null;
    var r = '';
    var a = String(format).match(this._fsrx);
    if(a)
    {
      for(var i=0,n=a.length; i<n; ++i)
      {
        var t = a[i];
        if(t.charAt(0)!='{' || t.length==1)
          r += t;
        else if(args)
        {
          var v = args[t.substr(1,t.length-2)];
          if(v != null)
            r += String(v);
        }
      }
    }
    return r;
  }
Gkod.Helper.Padz = function(s,l,c)
  {
    var undefined;
    if(l===undefined) l=2;
    if(c===undefined) c='0';
    s = String(s); if(s.length >= l) return s;
    var cc = ''; for(var i=s.length; i<l; ++i) cc += c;
    return (cc+s);
  }
Gkod.Helper.Fill = function(s,l,c)
  {
    var undefined;
    if(l===undefined) l=2;
    if(c===undefined) c=' ';
    s = String(s); if(s.length >= l) return s;
    var cc = ''; for(var i=s.length; i<l; ++i) cc += c;
    return (s+cc);
  }
Gkod.Helper.GetLines = function(s)
  {
    var _s=String(s);
    var a = _s.match(/[^\n\r]+|\r\n|\n|\r/g);
    var r = [];
    if(!a) return r;
    for(var i=0,n=a.length; i<n; ++i)
    {
      var $i = a[i];
      if($i.length==0) { r.push(''); continue; }
      var c = $i[0];
      if(c=='\n'||c=='\r') continue;
      r.push($i);
    }
    return r;
  }
Gkod.Helper.FilterLines = function(lines,m)
  {
    var r = [];
    for(var i=0,n=lines.length; i<n; ++i)
    {
      var $i = lines[i];
      if($i.match(m))
        r.push($i);
    }
    return r;
  }
Gkod.Helper.GetVersion = function(text,d)
  {
    var undefined;
    if(d===undefined) d = null;
    var a = text.match(/<!--Version\s+([0-9\.]+)-->/i);
    return ((a&&a.length==2)?a[1]:d);
  }
  
// numbers

Gkod.Helper.$uid = {};
Gkod.Helper.UniqueId = function(p) { var undefined; var k=(p===undefined)?'__uid__':p; var v; if(Gkod.Helper.$uid[k]===undefined) v=Gkod.Helper.$uid[k]=1; else v=++Gkod.Helper.$uid[k]; return (p===undefined)?v:(p+v); }
Gkod.Helper.GetInRange = function(n,l,h) { if(n<l) return l; if(n>h) return h; return n; }
Gkod.Helper.GetInCircularRange = function(n,l,h) { if(n<l) return h; if(n>h) return l; return n; }

// array functions

Gkod.Helper.Join = function(a,c) { return ((a===Gkod_Undefined || a===null)?'':a.join(c)); }
Gkod.Helper.Contains = function(a,item)
  {
    for(var i=0,n=a.length; i<n; ++i) if(a[i]==item) return true;
    return false;
  }
Gkod.Helper.IndexOf = function(a,item,i)
  {
    i = i||0;
    var l = a.length;
    if(i<0) i = l+i;
    for(; i<l; i++) if(a[i]==item) return i;
    return -1;
  }
Gkod.Helper.GetOption = function(v,a,d)
  {
    if(Gkod.Helper.IndexOf(a,v)!=-1) return v;
    var undefined; if(d!==undefined) return d;
    return ((a&&a.length>0)?a[0]:null);
  }
Gkod.Helper.GetKeys = function(o)
  {
    var a = [];
    for(var m in o) a.push(m);
    return a;
  }
Gkod.Helper.GetValues = function(o)
  {
    var a = [];
    for(var m in o) a.push(o[m]);
    return a;
  }

// URL functions

Gkod.Helper.CombineUrl = function(u,s)
  {
    var w = (String(u).replace(/(:?[^\/]+)(?:#[\s\S]*)?$/,'')+String(s)).replace('/./','/');
    var x; while((x=w.replace(/\/[\.]?[^\/\.][^\/]*\/\.\.[\/]/,'/'))!=w) w=x;
    return w;
  }

// Event functions

Gkod.Helper.StopPropagation = function(e)
  {
    // alert(e);
    e = e||window.event;
    if(!e) return;
    if(e.stopPropagation)
      e.stopPropagation();
    else e.cancelBubble = true;
  }

// rendering functions

Gkod.Helper.RenderMouseHover = function(c)
  {
    var undefined;
    if(c===undefined) c = 'active';
    return ' onmouseover="Gkod.Helper.Dom.AddClassName(this,\''+c+'\')" onmouseout="Gkod.Helper.Dom.RemoveClassName(this,\''+c+'\')" ';
  }
Gkod.Helper.RenderComment = function(body)
  {
    var s =
      '<div style="float:right;width:0px;overflow:'+(Gkod.Helper.IE6||Gkod.Helper.IE7?'hidden':'visible')+'">'+
        '<div style="position:relative;text-align:left">'+
          body+
        '</div>'+
      '</div>'
    ;
    return s;
  }

// Context functions

// Returns true if is APPNAME or APPNAME/INNERNAME
Gkod.Helper.IsApplicationNameEx = function(n) { return /^[_A-Za-z0-9\-]{1,8}(?:\/[_A-Za-z0-9\-]{1,8})?$/.test(n); }

// String
// ==========================================================================

Gkod.Helper.String = function(p) { this.p = String(p); }
Gkod.Helper.String.prototype.toString = function() { return this.p; }
Gkod.Helper.String.prototype.StartsWith = function(s) { var _s=String(s); if(_s.length==0||_s.length>this.p.length) return false; return (this.p.substr(0,_s.length)==_s); }
Gkod.Helper.String.prototype.EndsWith = function(s) { var _s=String(s); if(_s.length==0||_s.length>this.p.length) return false; return (this.p.substring(this.p.length-_s.length,this.p.length)==_s); }
Gkod.Helper.String.prototype.Contains = function(s) { var _s=String(s); if(_s.length==0) return false; return (this.p.indexOf(_s,0)!=-1); }
Gkod.Helper.String.prototype.Equals = function(s) { var _s=String(s); return (this.p==_s); }
Gkod.Helper.String.prototype.Trim = function() { this.p=this.p.replace(/^\s+|\s+$/g,''); return this; }
Gkod.Helper.String.prototype.LeftTrim = function() { this.p=this.p.replace(/^\s+/g,''); return this; }
Gkod.Helper.String.prototype.RightTrim = function() { this.p=this.p.replace(/\s+$/g,''); return this; }

// AppTemplate
// ==========================================================================

Gkod.Helper.AppTemplate = function(n)
{
  this.ApplicationName = n;

  this.$matchAny = false;
  this.$f_frame = [];
  this.$x_url = [];
  this.$rx_url = null;
  this.$f_url = [];
  this.$x_title = [];
  this.$rx_title = null;
  this.$f_title = [];

  this.$as = true; // auto search enabled
  
  this.$parts = "ABCDEFGHIJKLMNOPQRSTUVXYZ"; // valid part letters
  this.$nextpart = 0; // next part index
  this.$part = null; // current part
  this.$p2o = {}; // part-to-object {I:index,N:name}
  this.$n2p = {}; // name-to-part
  this.$pl = []; // part list
  this.$al = []; // action list
  
  this.$fri = -1; // current frame index
  this.$fmi = -1; // current form index 
  this.$obi = -1; // current object index
  this.$ndi = -1; // current node index

  this.$cacheG = Math.floor(Math.random()*2147483646);
  this.$cacheI = 0;
  this.$cacheA = [];

  this.OnBeforeMatch = function() {}
  this.OnAfterMatch = function(w) {}
  this.OnBeforeBuild = function(w) {}
  this.OnAfterBuild = function(w) {}

  this.SelectFrame(null);
}

// AppTemplate Frame Cache
// ==========================================================================

Gkod.Helper.AppTemplate.prototype.$GetFrameCache = function(w)
  // returns the frame cache
  {
    try
    {
      var ci;
      if(w['__Gkod_CG'] === this.$cacheG) 
        ci = w['__Gkod_CI'];
      else
      {
        ci = this.$cacheI++;
        this.$cacheA[ci] = {};
        w['__Gkod_CI'] = ci;
        w['__Gkod_CG'] = this.$cacheG;
      }
      return this.$cacheA[ci];
    }
    catch(e) {}
    return {};
  }

// AppTemplate Parts
// ==========================================================================

Gkod.Helper.AppTemplate.prototype.$NextPart = function()
{
  var p = null;
  while(true)
  {
    if(this.$nextpart>this.$parts.length) { p=null; break; }
    p = this.$parts.charAt(this.$nextpart++);
    if(!this.$p2o[p]) break;
  }
  this.$part = p;
  return this.$part;
}

Gkod.Helper.AppTemplate.prototype.$EnsurePartName = function(n)
{
  if(this.$n2p[n]) return true; 
  if(this.$NextPart()===null) return false;
  this.SetPartInfo(n,this.$part);
  return true;
}

// Sets the part id and searchable attribute
Gkod.Helper.AppTemplate.prototype.SetPartInfo = function(n,p,s)
{
  if(Gkod.Helper.IsNull(n)) return;
  if(Gkod.Helper.IsNull(p))
  {
    if(this.$NextPart()===null) return;
    p = this.$part;
  }
  this.$p2o[p] = {"I":this.$pl.length,"N":n,"S":((s === !!s)?s:true)};
  this.$n2p[n] = p;
  this.$pl.push(p);
}

// AppTemplate Options
// ==========================================================================

Gkod.Helper.AppTemplate.prototype.EnableAutoSearch = function(v)
{
  this.$as = !!v;
}

// AppTemplate Match
// ==========================================================================

Gkod.Helper.AppTemplate.prototype.MatchAnyCategory = function(v)
{
  this.$matchAny = (v===Gkod_Undefined)||!!v;
} 

Gkod.Helper.AppTemplate.prototype.MatchFrame = function(x)
{
  if(Gkod.Helper.IsNull(x)) return;
  if(!Gkod.Helper.IsFunction(x)) return;
  this.$f_frame.push(x);
}

Gkod.Helper.AppTemplate.prototype.MatchUrl = function(x)
{
  if(Gkod.Helper.IsNull(x)) return; 
  if(Gkod.Helper.IsFunction(x)) 
    this.$f_url.push(x);
  else this.$x_url.push(x);
}

Gkod.Helper.AppTemplate.prototype.MatchTitle = function(x)
{
  if(Gkod.Helper.IsNull(x)) return; 
  if(Gkod.Helper.IsFunction(x)) 
    this.$f_title.push(x);
  else this.$x_title.push(x);
}

// AppTemplate Context-Match Expession
// ==========================================================================

Gkod.Helper.AppTemplate.prototype.$Match = function(s)
  {
    if(s===null || s===Gkod_Undefined) return false;
    var alo = this.$alo;
    var r;
    if(alo.XF!==Gkod_Undefined)
    {
      var ret = alo.XF.call(this,s);
      if(ret===Gkod_Undefined || ret===null) return false;
      r = String(ret);
    }
    else if(alo.XR===Gkod_Undefined || alo.XR===null)
      r = String(s);
    else
    {  
      var a = String(s).match(alo.XR);
      if(Gkod.Helper.IsEmpty(a)) return false;
      if(a.length == 1) r = a[0];
      else { a.shift(); r = a.join(''); }
    }
    this.$cx[alo.P] = r;
    return true;
  }

// AppTemplate Rule List
// ==========================================================================

// Action Codes
// Push - 1 : F
// Pop - 2 : F
// SelectFrame - 3 : F,S
// SelectForm - 4 : F,S
// SelectUrl - 5 : F,S
// SetTitlePart - 6 : F,P,N,X,O
// SetUrlPart - 7 : F,P,N,X,O
// SetQueryParamPart - 8 : F,P,N,X,O 

Gkod.Helper.AppTemplate.prototype.$AddAction = function(ac,n,x,p1,p2)
  {
    var ao = {"AC":ac,"P1":p1,"P2":p2};
    if(n!==null&&this.$EnsurePartName(n)) { ao.N = n; ao.P = this.$n2p[n]; }
    if(x!==null&&x!==Gkod_Undefined&&x!='{...}')
    {
      if(Gkod.Helper.IsFunction(x))
        ao.XF = x;
      else
      {
        ao.XX = x;
        if(ac==11) // The action is SetUrlPart, XPhrase work in URL mode
          ao.XR = Gkod.Helper.XPhrase.CreateUrlRegExp(x);
        else ao.XR = Gkod.Helper.XPhrase.CreateRegExp(x);
      }
    }
    this.$ali = this.$al.length;
    this.$al.push(ao);
  }

// AppTemplate.SelectFrame 
// ==========================================================================

Gkod.Helper.AppTemplate.prototype.$GetFrameSP = function(fs)
  {
    if(Gkod.Helper.IsNull(fs)) { return [null]; } 
    var s = String(fs);
    if(s.length==0) { return [null]; }
    
    var a = s.match(/\/+|[^\/]+/g);
    if(a.length>0)
    {
      var sp = [];
      var i=0;
      if(s.charAt(0)=='/') sp.push(null);
      for(var n=a.length; i<n; ++i)
        if(a[i]!=='/') sp.push(a[i]);
      return sp;
    }
    
    return [null];
  }

Gkod.Helper.AppTemplate.prototype.$PrepareFrameSelectorAction = function(s,r) 
  {
    if(Gkod.Helper.IsNull(s))
      return {"B":0,"R":r};
    if(Gkod.Helper.IsFunction(s)) 
      return {"B":this.$fri,"SF":s,"R":r};
    var sp = this.$GetFrameSP(s);
    var b; if(sp[0]===null) { b=0; sp.shift(); } else b=this.$fri;
    var o = {"B":b,"R":r};
    if(sp.length == 1)
      o.S = sp[0];
    else o.SP = sp;
    return o;
  }

Gkod.Helper.AppTemplate.prototype.SelectFrame = function(s)
  {
    var o = this.$PrepareFrameSelectorAction(s);
    
    o.$FNP = function()
    {
      this.$fri = this.$ali;
      this.$fmi = this.$obi = this.$ndi = 0;
      this.$cc.fmi = this.$cc.obi = this.$cc.ndi = -1;
    }
    
    this.$AddAction(3,null,null,o);
    this.$fri = this.$ali;
    this.$fmi = this.$obi = this.$ndi = 0;
  }

Gkod.Helper.AppTemplate.prototype.$DoSelectFrame = function(w,alo)
  {
    var o = alo.P1;
    if(o.S !== Gkod_Undefined)
      w = w.frames[o.S];
    else if(o.SF !== Gkod_Undefined)
      w = o.SF.call(this,w);
    else if(o.SP !== Gkod_Undefined)
    {
      for(var i=0,n=o.SP.length; i<n; ++i)
      {
        var s = o.SP[i];
        if(s !== null) w = w.frames[s];
        if(!w) break;
      }
    }
    w = (!w?null:w);
    // alo.frame = w;
    return w;
  }

Gkod.Helper.AppTemplate.prototype.$LoadSelectedFrame = function()
  // Ensure that the same frame is loaded that is selected 
  {
    var cc = this.$cc;
    if(cc.fri === this.$fri) return !!cc.frame;
  
    if(this.$fri === 0)
    {
      cc.fri = cc.fmi = cc.obi = cc.ndi = this.$fmi = this.$obi = this.$ndi = 0;
      cc.frame = cc.ob = cc.root;
      cc.xpv = Gkod.XPath?Gkod.XPath.CreateNodeSet(cc.root):null;
      cc.form = Gkod_Undefined;
      return true;
    }
    
    var alo = this.$al[this.$fri];
    /*
    if(alo.frame !== undefined)
    {
      cc.fri = this.$fri;
      cc.frame = cc.ob = alo.frame;
      cc.xpv = cc.frame?Gkod.XPath.CreateNodeSet(Gkod.Helper.Window.GetDocument(cc.frame)):null;
      return !!cc.frame;
    }
    */
    var w = cc.root;
    var a = [this.$fri];
    if(this.$fri>0)
    {
      while(true)
      {
        var b = alo.P1.B;
        if(b === cc.fri) break;
        if(alo.frame !== Gkod_Undefined) { w = alo.frame; break; }
        if(b === 0) break;
        a.push(b);
        alo = this.$al[b];
      }
    }
    while(a.length>0)
    {
      var b=a.pop();
      alo = this.$al[b];
      w = this.$DoSelectFrame(w,alo);
      if(w === null) break;
    }
    cc.fri = this.$fri;
    cc.fmi = cc.obi = this.$fmi = this.$obi = 0;
    cc.frame = cc.ob = w;
    cc.form = Gkod_Undefined;
    cc.xpv = (Gkod.XPath&&w)?Gkod.XPath.CreateNodeSet(Gkod.Helper.Window.GetDocument(w)):null;
    return !!cc.frame;
  }

Gkod.Helper.AppTemplate.prototype.$ProcessFrame = function(w,deep)
  // process frames recursively, and calls this.$fnp for each frame until fn returns false, otherwise returns true 
  {
    if(!w) return false;
  
    // try
    {
      var c = this.$GetFrameCache(w);
      if(this.$alo.P1.$FNPFR.call(this,w,c))
        return true;
    }
    // catch(e) { Gkod.Helper.Exception(e,'Gkod.Helper.AppTemplate.$ProcessFrame.1'); }
  
    try
    {
      if(!deep||!w.frames||!w.frames.length) return false;
    }
    catch(e) { Gkod.Helper.Exception(e,'Gkod.Helper.AppTemplate.$ProcessFrame.2'); return false; }
  
    var ok = false;
    var frame = this.$cc.frame;
    try
    {
      for(var i=0,n=w.frames.length; i<n; ++i)
      {
        this.$cc.frame = w.frames[i];
        if(this.$ProcessFrame(this.$cc.frame,true))
          { ok = true; break; }
      }
    }
    catch(e) { Gkod.Helper.Exception(e,'Gkod.Helper.AppTemplate.$ProcessFrame.3'); }
    this.$cc.frame = frame;
    return ok;
  }

Gkod.Helper.AppTemplate.prototype.$ProcessFrameSelection = function()
  //FIX: this.$cc.fs 
  // ensure valid frame is selected and process the frames
  {
    if(!this.$LoadSelectedFrame()) return;
    this.$ProcessFrame(this.$cc.frame,true);
  }

// AppTemplate.SetPart 
// ==========================================================================

Gkod.Helper.AppTemplate.prototype.SetPart = function(n,p,x)
  {
    if(Gkod.Helper.IsNull(n)||Gkod.Helper.IsNull(p)) return;
    
    var o = {};
    if(Gkod.Helper.IsFunction(p))
      o.SF = p;
    else o.S = String(p);
    o.$FNP = function() 
    {
      var alo = this.$alo;
      var s;
      if(alo.P1.SF !== Gkod_Undefined)
        s = alo.P1.SF.call(this,this.$cc.root);
      else s = alo.P1.S;
      this.$Match(s);
    }
    
    this.$AddAction(14,n,x,o);
  }

// AppTemplate.SetTitlePart 
// ==========================================================================

Gkod.Helper.AppTemplate.prototype.$EnsureTitle = function(w,c)
  {
    if(c.title === null) return;
    c.title = null;
    var d = Gkod.Helper.Window.GetDocument(w);
    if(!d) return;
    c.title = Gkod.Helper.Document.GetTitle(d);
  }

Gkod.Helper.AppTemplate.prototype.SetTitlePart = function(n,x)
  {
    if(Gkod.Helper.IsNull(n)) return;
  
    var o = {"B":this.$fri};
    o.$FNP = function() { this.$ProcessFrameSelection(); }
    o.$FNPFR = function(w,c)
    {
      if(!c.title) this.$EnsureTitle(w,c); 
      if(c.title === null) return;
      return this.$Match(c.title);
    }
    
    this.$AddAction(10,n,x,o);
  }

// AppTemplate.SetUrlPart 
// ==========================================================================

Gkod.Helper.AppTemplate.prototype.$EnsureUrl = function(w,c)
  {
    if(c.url === null) return;
    c.url = null;
    var d = Gkod.Helper.Window.GetDocument(w);
    if(!d) return;
    c.url = Gkod.Helper.Document.GetUrl(d);
  }

Gkod.Helper.AppTemplate.prototype.SetUrlPart = function(n,x)
  {
    if(Gkod.Helper.IsNull(n)) return;
    if(x===Gkod_Undefined || x===null) x = "/{..}";
    
    var o = {"B":this.$fri};
    o.$FNP = function(w,c) { this.$ProcessFrameSelection(); }
    o.$FNPFR = function(w,c)
    {
      if(!c.url) this.$EnsureUrl(w,c);
      if(c.url === null) return;
      return this.$Match(c.url.GetUrl());
    }
    
    this.$AddAction(11,n,x,o);
  }

// AppTemplate.SetQueryParamPart 
// ==========================================================================

Gkod.Helper.AppTemplate.prototype.$GetFormInputValue = function(f,n)
  {
    var fe = f.elements[n];
    if(fe===Gkod_Undefined || fe.value===Gkod_Undefined) return null;
    return fe.value;
  }

Gkod.Helper.AppTemplate.prototype.SetQueryParamPart = function(n,p,x)
  {
    if(Gkod.Helper.IsNull(n)||Gkod.Helper.IsNull(p)) return;
  
    var o = {"B":this.$fri};
    o.$FNP = function(w,c) { this.$ProcessFrameSelection(); }
    o.$FNPFR = function(w,c)
    {
      // Gkod.Trace.Write('SetQueryParamPart:$FNPFR');
      // debug;
      
      var alo = this.$alo;
  
      if(!c.url) this.$EnsureUrl(w,c);
      if(c.url === null) return false;
      
      var q = c.url.GetQuery();
      if(q[alo.P2]!==Gkod_Undefined) { if(this.$Match(q[alo.P2])) return true; }
  
      return this.$ProcessFormSelection();  
    }
    o.$FNPFM = function(w,c,f)
    {
      // Gkod.Trace.Write('SetQueryParamPart:$FNPFM');
  
      var alo = this.$alo;
  
      var s = this.$GetFormInputValue(f,alo.P2);
      if(s === null) return false;
  
      return this.$Match(s);
    }
  
    this.$AddAction(12,n,x,o,p);
  }

// AppTemplate.SelectObject 
// ==========================================================================

Gkod.Helper.AppTemplate.prototype.$GetObjectSP = function(os)
  {
    if(Gkod.Helper.IsEmpty(os)) return null;
    var a = String(os).match(/[^\.]+/g);
    var sp = []; for(var i=0,n=a.length; i<n; ++i) sp.push(a[i]);
    return sp;
  }

Gkod.Helper.AppTemplate.prototype.$PrepareObjectSelectorAction = function(s) 
  {
    var o = {"B":this.$fri};
    if(Gkod.Helper.IsNull(s)) return o;
    if(Gkod.Helper.IsFunction(s)) { o.SF = s; return o; }
    var sp = this.$GetObjectSP(String(s));
    if(sp === null) return o;
    if(sp.length == 1)
      o.S = sp[0];
    else if(sp.length > 1)
      o.SP = sp;
    return o;
  }

Gkod.Helper.AppTemplate.prototype.SelectObject = function(s)
  {
    var o = this.$PrepareObjectSelectorAction(s);
    if(Gkod.Helper.IsNull(s))
      o.$FNP = function() { this.$obi = 0; }
    else o.$FNP = function() { this.$obi = this.$ali; }
    
    this.$AddAction(5,null,null,o);
    this.$obi = this.$ali;
  }

// AppTemplate.SetObjectPart 
// ==========================================================================

Gkod.Helper.AppTemplate.prototype.$DoSelectObject = function(alo,ob)
  {
    if(ob!==null && ob!==Gkod_Undefined)
    {
      var o = alo.P1;
      if(o.S!==Gkod_Undefined) 
        ob = ob[o.S];
      else if(o.SF!==Gkod_Undefined)
        ob = o.SF.call(this,ob);
      else
      {
        for(var i=0,n=o.SP.length; i<n; ++i)
        {
          ob = ob[o.SP[i]];
          if(ob===Gkod_Undefined || ob === null)
            break;
        }
      }
    }
    if(ob===Gkod_Undefined) ob = null;
    alo.ob = ob;
    return ob;
  }

Gkod.Helper.AppTemplate.prototype.$LoadSelectedObject = function()
  {
    var cc = this.$cc;
    if(cc.obi === this.$obi) return !!cc.ob;
    
    if(this.$obi === 0)
    {
      cc.obi = 0;
      cc.ob = cc.frame;
      return !!cc.ob;
    }
    
    var alo = this.$al[this.$obi];
    if(alo.ob!==Gkod_Undefined)
    {
      cc.obi = this.$obi;
      cc.ob = alo.ob;
      return !!cc.ob;
    }
    
    cc.ob = this.$DoSelectObject(alo,cc.frame);
    cc.obi = this.$obi;
    return !!cc.ob;
  }

Gkod.Helper.AppTemplate.prototype.SetObjectPart = function(n,p,x)
  {
    if(Gkod.Helper.IsNull(n)||Gkod.Helper.IsNull(p)) return;
  
    var o = this.$PrepareObjectSelectorAction(p);
    o.$FNP = function(w,c) { this.$ProcessFrameSelection(); }
    o.$FNPFR = function(w,c)
    {
      if(!this.$LoadSelectedObject()) return false;
      var cc = this.$cc;
      var s = this.$DoSelectObject(this.$alo,cc.ob);
      if(s === null) return false;
      return this.$Match(s);
    }
  
    this.$AddAction(13,n,x,o);
  }

// AppTemplate.SelectForm 
// ==========================================================================

Gkod.Helper.AppTemplate.prototype.SelectForm = function(s)
  {
    var o = {"B":this.$fri,"R":this.$as};
  
    if(Gkod.Helper.IsFunction(s)) 
      o.SF = s;
    else o.S = String(s);
    
    o.$FNP = function() { this.$fmi = this.$ali; }
    
    this.$AddAction(4,null,null,o);
    this.$fmi = this.$ali;
  }

Gkod.Helper.AppTemplate.prototype.$LoadSelectedForm = function()
  {
    var cc = this.$cc;
    if(cc.fmi === this.$fmi) return true;
  
    cc.fmi = this.$fmi;
    if(this.$fmi === 0)
    {
      cc.form = Gkod_Undefined;
      return true;
    }
    
    var alo = this.$al[this.$fmi];
    if(alo.form !== Gkod_Undefined)
    {
      cc.form = alo.form;
      return !!cc.form;
    }
    
    cc.form = null;
    if(alo.P1.SF !== Gkod_Undefined)
    {
      cc.form = alo.P1.SF.call(this,cc.frame);
      if(cc.form === Gkod_Undefined)
        cc.form = null;
    }
    else if(alo.P1.S !== Gkod_Undefined)
    {
      var forms = Gkod.Helper.Window.GetForms(cc.frame); 
      cc.form = forms? forms[alo.P1.S]: null;
    }
    return !!cc.form;
  }

Gkod.Helper.AppTemplate.prototype.$ProcessFormSelection = function()
  {
    if(!this.$LoadSelectedForm()) return;
    var cc = this.$cc;
    var w = cc.frame;
    if(w === null) return false;
    
    var c = this.$GetFrameCache(w);
    
    if(Gkod.Helper.IsNull(cc.form))
    {
      var forms = Gkod.Helper.Window.GetForms(w);
      if(forms)
      {
        for(var i=0,n=forms.length; i<n; ++i)
        {
          try {
            if(this.$alo.P1.$FNPFM.call(this,w,c,forms[i])) return true;
          } catch(e) { Gkod.Helper.Exception(e,'Gkod.Helper.AppTemplate.$ProcessFormSelection'); }
        }
      }
    }
    else
    {
      try {
        if(this.$alo.P1.$FNPFM.call(this,w,c,cc.form)) return true;
      } catch(e) { Gkod.Helper.Exception(e,'Gkod.Helper.AppTemplate.$ProcessFormSelection.1'); }
    }
    
    return false;
  }

// AppTemplate.SelectNode 
// ==========================================================================

Gkod.Helper.AppTemplate.prototype.$PrepareNodeSelectorAction = function(s) 
  {
    var o = {"B":this.$fri};
    if(Gkod.Helper.IsNull(s)) return o;
    if(Gkod.Helper.IsFunction(s)) { o.SF = s; return o; }
    o.SE = s;
    try { o.SXP = Gkod.XPath.Compile(s); }
    catch(e) { Gkod.Helper.Exception(e,'Gkod.XPath.Compile'); }
    return o;
  }

Gkod.Helper.AppTemplate.prototype.SelectNode = function(s)
  {
    if(!Gkod.XPath) return;
  
    var o = this.$PrepareNodeSelectorAction(s);
    if(Gkod.Helper.IsNull(s))
      o.$FNP = function() { this.$ndi = 0; }
    else o.$FNP = function() { this.$ndi = this.$ali; }
  
    this.$AddAction(6,null,null,o);
    this.$ndi = this.$ali;
  }

Gkod.Helper.AppTemplate.prototype.$LoadSelectedNode = function()
  {
    var cc = this.$cc;
    if(cc.ndi === this.$ndi)
      return !!cc.xpv;
    
    if(this.$ndi === 0)
    {
      cc.ndi = 0;
      cc.xpv = ((cc.frame === null)?null:Gkod.XPath.CreateNodeSet([Gkod.Helper.Window.GetDocument(cc.frame)]));
      return !!cc.xpv;
    }
  
    cc.ndi = this.$ndi;
    cc.xpv = null;
    var nd = Gkod.Helper.Window.GetDocument(cc.frame);
    if(nd!==null && nd!==Gkod_Undefined)
    {
      var o = this.$al[cc.ndi].P1;
      if(o.SXP !== Gkod_Undefined)
      {
        cc.xpv = Gkod.XPath.Evaluate(o.SXP,nd);
        // Gkod.Trace.Write('SE='+o.SE);
        // Gkod.Trace.Dump('XPV',cc.xpv);
        // if(cc.xpv == 'node-set') Gkod.Trace.Dump('XPV/value',cc.xpv.value);
      }
      else if(o.SF !== Gkod_Undefined)
        cc.xpv = o.SF.call(this,nd);
    }
    return !!cc.xpv;
  }

// AppTemplate.SetNodePart 
// ==========================================================================

Gkod.Helper.AppTemplate.prototype.$MatchXPV = function(xpv)
  {
    if(!xpv) return false;
    if(xpv.type == 'node-set')
    {
      for(var i=0; i<xpv.value.length; ++i)
      {
        var s = xpv.value[i].innerText||xpv.value[i].textContent||null;
        if(s!==null && this.$Match(s)) return true;
      }
      return false;
    }
    var s = xpv.stringValue();
    return this.$Match(s);
  }

Gkod.Helper.AppTemplate.prototype.SetNodePart = function(n,p,x)
  {
    if(!Gkod.XPath||Gkod.Helper.IsEmpty(n)||Gkod.Helper.IsNull(p)) return;
  
    var o = this.$PrepareNodeSelectorAction(p);
    o.$FNP = function(w,c) { this.$ProcessFrameSelection(); }
    o.$FNPFR = function(w,c)
    {
      if(!this.$LoadSelectedNode()) return false;
  
      var cc = this.$cc;
      var o = this.$alo.P1;
  
      if(o.SF !== Gkod_Undefined)
        return this.$Match(o.SF.call(this,cc.xpv));
      
      if(o.SXP !== Gkod_Undefined && cc.xpv.type == 'node-set')
      {
        var a = cc.xpv.value;
        for(var i=0,ni=a.length; i<ni; ++i)
          if(this.$MatchXPV(Gkod.XPath.Evaluate(o.SXP,a[i])))
            return true;
      }
     
      return false;
    }
  
    this.$AddAction(16,n,x,o);
  }

// AppTemplate.GetRootWindow 
// ==========================================================================

Gkod.Helper.AppTemplate.prototype.$IsOwnApplication = function(w)
  {
    var d = Gkod.Helper.Window.GetDocument(w);
    if(!d) return false;
  
    var any = this.$matchAny;
    var ma = [];
  
    var needUrl = this.$needUrl; 
    if(needUrl)
    {
      var url = Gkod.Helper.Document.GetUrl(d).GetUrl();
      if(this.$rx_url)
      {
        if(this.$rx_url.test(url))
          { if(any) { Gkod.Trace.Write('GkodTpl.IsOwnApplication ['+this.ApplicationName+']: true (any:URL)'); return true; } ma.push('URL'); needUrl = false; }
      }
  
      if(this.$f_url.length>0)
      {
        for(var i=0,n=this.$f_url.length; i<n; ++i)
        {
          try {
            if(this.$f_url[i].call(this,url))
              { if(any) { Gkod.Trace.Write('GkodTpl.IsOwnApplication ['+this.ApplicationName+']: true (any, URL matched)'); return true; } ma.push('URL'); needUrl = false; break; }
          } catch(e) { Gkod.Helper.Exception(e,'Gkod.Helper.AppTemplate.$IsOwnApplication.1'); }
        }
      }
      
      if(needUrl)
        { Gkod.Trace.Write('GkodTpl.IsOwnApplication ['+this.ApplicationName+']: false (cancelled: URL failed)'); return false; }
    }
  
    var needTitle = this.$needTitle; 
    if(needTitle)
    {
      var title = Gkod.Helper.Document.GetTitle(d);
      if(this.$rx_title)
      {
        if(this.$rx_title.test(title))
          { if(any) { Gkod.Trace.Write('GkodTpl.IsOwnApplication ['+this.ApplicationName+']: true (any:TITLE)'); return true; } ma.push('TITLE'); needTitle = false; }
      }
  
      if(this.$f_title.length>0)
      {
        for(var i=0,n=this.$f_title.length; i<n; ++i)
        {
          try {
            if(this.$f_title[i].call(this,title))
              { if(any) { Gkod.Trace.Write('GkodTpl.IsOwnApplication ['+this.ApplicationName+']: true (any, TITLE matched)'); return true; } ma.push('TITLE'); needTitle = false; break; }
          } catch(e) { Gkod.Helper.Exception(e,'Gkod.Helper.AppTemplate.$IsOwnApplication.2'); }
        }
      }
  
      if(needTitle)
        { Gkod.Trace.Write('GkodTpl.IsOwnApplication ['+this.ApplicationName+']: false (cancelled: '+ ((ma.length>0)?ma.join(',')+' matched, but ':'') + 'URL failed)'); return false; }
    }
  
    var needFrame = this.$needFrame;
    if(needFrame)
    {
      for(var i=0,n=this.$f_frame.length; i<n; ++i)
      {
        try {
          if(this.$f_frame[i].call(this,w))
            { if(any) { Gkod.Trace.Write('GkodTpl.IsOwnApplication ['+this.ApplicationName+']: true (any, FRAME matched)'); return true; } ma.push('FRAME'); needFrame = false; break; }
        } catch(e) { Gkod.Helper.Exception(e,'Gkod.Helper.AppTemplate.$IsOwnApplication.3'); }
      }
  
      if(needFrame)
        { Gkod.Trace.Write('GkodTpl.IsOwnApplication ['+this.ApplicationName+']: false (cancelled: '+ ((ma.length>0)?ma.join(',')+' matched, but ':'') + 'FRAME failed)'); return false; }
    }
  
    Gkod.Trace.Write('GkodTpl.IsOwnApplication ['+this.ApplicationName+']: true ('+((ma.length>0)?ma.join(',')+' matched':'no rules')+')');
    return true;
  }

Gkod.Helper.AppTemplate.prototype.GetRootWindow = function()
  {
    try
    {
      if(!this.$init)
      {
        this.$init = true;
        this.$needTitle = (this.$x_title.length>0 || this.$f_title.length>0);
        this.$needUrl   = (this.$x_url.length>0 || this.$f_url.length>0);
        this.$needFrame = (this.$f_frame.length>0);
        this.$rx_title  = Gkod.Helper.XPhrase.CreateRegExp(this.$x_title);
        this.$rx_url    = Gkod.Helper.XPhrase.CreateUrlRegExp(this.$x_url);
      }
      
      var pwl = Gkod.Helper.Window.GetParentList();
      for(var i=pwl.length-1; i>=0; --i)
        try { if(this.$IsOwnApplication(pwl[i])) return pwl[i]; } catch(e) {}
    }
    catch(e) { Gkod.Helper.Exception(e,'Gkod.Helper.AppTemplate.GetRootWindow'); }
    return null;
  }

// AppTemplate.IsOwnApplication 
// ==========================================================================

Gkod.Helper.AppTemplate.prototype.IsOwnApplication = function()
  {
    var w = null;
    try
    {
      this.OnBeforeMatch.call(this);
      w = this.GetRootWindow();
      this.OnAfterMatch.call(this,w);
    }
    catch(e) { Gkod.Helper.Exception(e,'Gkod.Helper.AppTemplate.IsOwnApplication'); }
    return !!w;
  }

// AppTemplate.GetApplicationName 
// ==========================================================================

Gkod.Helper.AppTemplate.prototype.GetApplicationName = function()
  {
    try {
      if(this.IsOwnApplication()) return this.ApplicationName;
    } catch(e) { Gkod.Helper.Exception(e,'Gkod.Helper.AppTemplate.GetApplicationName'); }
    return "";
  }

// AppTemplate.GetContextID 
// ==========================================================================

Gkod.Helper.AppTemplate.prototype.GetContextID = function()
  {
    var root = this.GetRootWindow();
    if(!root) return [];
  
    var ctxa = [];
  
    this.$inContext = true;
    try
    {
      this.$cacheI = 0;
      this.$cacheA = [];
      ++this.$cacheG;
    
      this.OnBeforeBuild.call(this,root);
    
      this.$cc = // capture context
      {
        "fri":-1,
        "fmi":-1,
        "obi":-1,
        "ndi":-1,
        "root":root,
        "frame":null,
        "form":null,
        "ob":null
      };
      
      this.$cx = {};
      this.$ali = 0;
      this.$fri = -1;
      this.$fmi = -1;
      this.$obi = -1;
      this.$ndi = -1;
    
      for(var aln=this.$al.length; this.$ali<aln; ++this.$ali)
      {
        this.$alo = this.$al[this.$ali];
        var p = this.$alo.P;
        if(p !== Gkod_Undefined && this.$cx[p] !== Gkod_Undefined) continue;
        this.$alo.P1.$FNP.call(this);
      }
    
      this.OnAfterBuild.call(this,root);
    
      // this.$cacheI = 0;
      // this.$cacheA = [];
      
      for(var i=0,n=this.$pl.length; i<n; ++i)
      {
        var $i = this.$pl[i];
        var x = this.$cx[$i];
        if(x === Gkod_Undefined) continue;
        var o = this.$p2o[$i];
        var ctx = new Gkod.Context.ContextObject();
        ctx.name = $i;
        ctx.caption = o.N;
        ctx.contextid = x;
        ctx.usenameasprefix = "1";
        ctx.searchable = (o.S?"1":"0");
        // Gkod.Trace.Dump('ctx.'+i,ctx);
        ctxa.push(ctx);
      }
    }
    catch(e) { Gkod.Helper.Exception(e,'Gkod.Helper.AppTemplate.GetContextID'); }
  
    this.$inContext = false;
  
    return ctxa;
  }

// versions supported: 1
Gkod.Helper.CreateTemplate = function(n,v)
  {
    if(Gkod.Helper.IsNull(n)) n='UNKNOWN';
    if(Gkod.Helper.IsNull(v)) v=1;
    if(v!=1)
    {
      if(this.$notSupported) return null; 
      this.$notSupported=true;
      Gkod.Trace.Error(n,'CreateTemplate: Version '+v+' is not supported.'); 
      return null;
    }
    
    return new Gkod.Helper.AppTemplate(n);
  }

// XPhrase
// ==========================================================================

Gkod.Helper.XPhrase = {};
Gkod.Helper.XPhrase.$rx_m = /\s+|\/+|\*+|\?+|\([0-9A-Z\-]+\)|\.+|\\[>/%<\[\]\(\)\{\}\|\?\*\\]?|%[0-9A-Fa-f]{2}|[\[\]\(\)\|\{\}:%]|[^\\\*\?\.\[\]\(\)\|\{\}\s\/:%]+/g; // match
Gkod.Helper.XPhrase.$rx_e = /([\^\$\.\*\+\?\|\(\)\[\]\{\}\\])/g; // escape RegExp characters

Gkod.Helper.XPhrase.CreateRegExp = function(xp)
  {
    var rx = this.CreatePattern(xp);
    if(rx===null)
      return null;
    return new RegExp(rx,"i");
  }

Gkod.Helper.XPhrase.CreatePathRegExp = function(xp)
  {
    var rx = this.CreatePathPattern(xp);
    if(rx===null)
      return null;
    return new RegExp(rx,"i");
  }

Gkod.Helper.XPhrase.CreateUrlRegExp = function(xp)
  {
    var rx = this.CreateUrlPattern(xp);
    if(rx===null)
      return null;
    return new RegExp(rx,"i");
  }

Gkod.Helper.XPhrase.CreatePattern = function(x_)
  {
    return this.$CreatePattern(x_,0,0);
  }

Gkod.Helper.XPhrase.CreatePathPattern = function(x_)
  {
    return this.$CreatePattern(x_,1,1);
  }

Gkod.Helper.XPhrase.CreateUrlPattern = function(x_)
  {
    return this.$CreatePattern(x_,1,3);
  }

Gkod.Helper.XPhrase.$CreatePattern = function(x_,m,s)
  {
    if(x_===Gkod_Undefined || x_===null)
      return null;
  
    var o;
    var i,n;
    
    var oa = []; // object array
    if(Gkod.Helper.IsArray(x_))
    {
      for(i=0,n=x_.length; i<n; ++i)
        if((o=this.$TransformSpan(x_[i],m,s))!==null)
          oa.push(o);
    }
    else
    {
      if((o=this.$TransformSpan(x_,m,s))!==null)
        oa.push(o);
    }
      
    if(oa.length==0)
      return null;
  
    var au = true; // all url
    var aal = true; // all absolute left
    var aar = true; // all absolute right
    for(i=0,n=oa.length; i<n; ++i)
    {
      o = oa[i];
      if(o.type==0) return '^$';
      if(o.type==2) return '^([\\s\\S]*)$';
      if(o.m!=1||o.s!=3) au = false; 
      if(o.type==3) continue;
      if(o.ldot) aal = false;
      if(o.rdot) aar = false; 
    }
  
    var ss = '';
    if(aal) ss += '^'; // au==true implies aal==true
    if(au) ss += '\\w+:/+(?=[^\/])';
    if(oa.length!=1) ss += '(?:';
    for(i=0,n=oa.length; i<n; ++i)
    {
      o = oa[i];
      if(i!=0) ss += '|';
      if(!aal&&!o.ldot) ss += '^';
      if(!au&&o.m==1&&o.s==3) ss += '\\w+:/+(?=[^\/])';
      // a TransformSpan vedi az o.rx-beli root-level alternativakat, 
      // ezek mar benne vannak egy zarojelben, u.h. itt nem szukseges beletenni. 
      ss += o.rx; 
      if(!aar&&!o.rdot) ss += '$';
    }
    if(oa.length!=1) ss += ')';
    if(aar) ss += '$';
    return ss;
  }

Gkod.Helper.XPhrase.$TransformSpan = function(x_,m,s)
  {
    if(x_===Gkod_Undefined || x_===null)
      return null;
  
    var x = String(x_);
    var o = {};
    var ctm = x.match(/^\(([UPT])\)/); 
    if(ctm&&ctm.length==2)
    {
      var ct = ctm[1];
      if(ct=='U') { m=1; s=3; }
      else if(ct=='P') { m=1; s=1; }
      else { m=0; s=0; }
      x = x.replace(/^\([UPT]\)/,'');
    }
    var ldot = (m==1&&s==3)?false:/^\.\.+/.test(x);
    var rdot = /\.\.+$/.test(x)||((m==1&&s==3)?!/\/|\.\./.test(x):false);
    if(ldot||rdot)
    {
      o.ldot = ldot;
      o.rdot = rdot;
      x = x.replace(/^\.\.+|\.\.+$/g,'');
      o.type = (x.length==0)?0:1;
    }
    else o.type = /^\{\.\.\.+\}$/.test(x)?2:3;
    o.m = m;
    o.s = s;
    o.rx = this.$CreateSpan(x,m,s);
    return ((o.rx==null)?null:o);
  }

Gkod.Helper.XPhrase.$CreateSpan = function(x,m_,s_)
  {
    if(x.length==0) return '';
    if(/^(?:\.\.\.+|\{\.\.\.+\})$/.test(x))
      return (x.charAt(0)=='{')?'([\\s\\S]*)':'[\\s\\S]*';
  
    var a = x.match(this.$rx_m);
    if(Gkod.Helper.IsEmpty(a))
      return null;
    
    var m = m_;
    var s = s_; 
  
    // mode: 0-text, 1-url or path
    // mode:state
    // 0:* (ignored)
    // 1:4 (url-schema)
    // 1:3 (url-domain)
    // 1:2 (url-port)
    // 1:1 (url-path)
  
    var cm = {"bm":m,"bs":s};
    var cs = [];
    var sa = [];
    var ss = ''; // span string
    
    // assumptions
    // if state > 0 => mode is 1
    // if mode != 0 => mode is 1
    
    if(m&&s==3&&/^[\{\}\[\]\(\)]*[/]/.test(x))
      { ss += '[^/\\s]*'; s=1; }
    
    for(var t=0; t<a.length; ++t)
    {
      var t$ = a[t]; // token
      // Gkod.Trace.Write('XPhrase.$CreateSpan: token '+t$);
      if(t$.length == 0) continue;
      if(/\s/.test(t$)) { ss += '\\s+'; continue; }
      if(t$.length == 1)
      {
        if(t$=='?') { ss += m?'(?:%[0-9A-Fa-f]{2}|[^/\\.\\s])':'\\S'; continue; } // ok
        if(t$=='*') { ss += m?((s==3)?'(?:%[0-9A-Fa-f]{2}|[^:/\\.\\s])*':'(?:%[0-9A-Fa-f]{2}|[^/\\.\\s])*'):'\\S*'; continue; } // ok
        if(t$=='.') { ss += '\\.'; continue; } // ok
        if(t$==':') { if(s>2) { ss += this.$UrlState(s,2,cs); s=2; } ss += ':'; continue; } // ok
        if(t$=='/') { if(s>1) { ss += this.$UrlState(s,1,cs); s=1; } else ss += '/'; continue; } // ok
        if(t$=='\\') { ss += '\\\\'; continue; } // ok
        if(t$=='|') { if(cs.length==0) { sa.push({"ss":ss,"m":m,"s":s}); ss = ''; } else ss += '|'; m = cm.bm; s = cm.bs; continue; } // ok
        if(t$=='[') { ss += '(?:'; cs.push({"bm":cm.bm,"bs":cm.bs,"p":0}); cm.bm=m; cm.bs=s; continue; } // ok
        if(t$=='(') { ss += '(?:'; cs.push({"bm":cm.bm,"bs":cm.bs,"p":1}); cm.bm=m; cm.bs=s; continue; } // ok
        if(t$=='{') { ss += '(';   cs.push({"bm":cm.bm,"bs":cm.bs,"p":2}); cm.bm=m; cm.bs=s; continue; } // ok
        if(t$==']')
        {
          if(cs.length>0) // ok
            { if(cs[cs.length-1].p==0) { ss += ')?'; var $=cs.pop(); cm.bm=$.bm; cm.bs=$.bs; } else Gkod.Trace.Warning('XPhrase: Wrong ] in "'+x+'"'); }
          else Gkod.Trace.Warning('XPhrase: Extra ] in "'+x+'"');
          continue;
        }
        if(t$==')') // ok
        {
          if(cs.length>0)
            { if(cs[cs.length-1].p==1) { ss += ')'; var $=cs.pop(); cm.bm=$.bm; cm.bs=$.bs; } else Gkod.Trace.Warning('XPhrase: Wrong ) in "'+x+'"'); }
          else Gkod.Trace.Warning('XPhrase: Extra ) in "'+x+'"');
          continue;
        }
        if(t$=='}') // ok
        {
          if(cs.length>0)
            { if(cs[cs.length-1].p==2) { ss += ')'; var $=cs.pop(); cm.bm=$.bm; cm.bs=$.bs; } else Gkod.Trace.Warning('XPhrase: Wrong } in "'+x+'"'); }
          else Gkod.Trace.Warning('XPhrase: Extra } in "'+x+'"');
          continue;
        }
      }
      else 
      {
        var t$c0 = t$.charAt(0);
  
        if(t$.length==2)
        {
          if(t$c0=='\\') { ss += t$.charAt(1).replace(this.$rx_e,'\\$1'); continue; } // ok // \\[><\[\]\(\)\{\}\|\?\*\\]
          if(t$c0=='(') { Gkod.Trace.Warning('XPhrase: Control-tag '+t$+' ignored in "'+x+'"'); continue; } // ok // (): ignored
        }
        else if(m && t$.length==3 && t$c0=='%') // ok // %XX
        {
          var t$u = t$.toUpperCase();
          var t$l = t$.toLowerCase();
          ss += '(?:%['+t$u.charAt(1)+t$l.charAt(1)+']['+t$u.charAt(2)+t$l.charAt(2)+']';
          if(t$u != '%2F')
            ss += '|'+String.fromCharCode(+("0x"+t$u.charAt(1)+t$u.charAt(2))).replace(this.$rx_e,'\\$1');
          ss += ')';
          continue;
        }
  
        // C{2,N}
        if(t$c0=='.') { if(m) { if(s>1) { ss += '[^/:\\s]*'+this.$UrlState(s,1,cs); s=1; } ss += '(?:%[0-9A-Fa-f]{2}|\\S)*'; } else ss += '[\\s\\S]*'; continue; } // ok
        if(t$c0=='/') { if(m) { if(s>1) { ss += this.$UrlState(s,1,cs); s=1; ss += '(?:\\S*/)?'; } else ss += '/(?:\\S*/)?'; } else ss += t$; continue; } // ok
        if(t$c0=='?') { ss += m?'(?:%[0-9A-Fa-f]{2}|[^/\\.\\s]){'+t$.length+'}':'\\S{'+t$.length+'}'; continue; } // ok
        if(t$c0=='*') { ss += m?((s==3)?'(?:%[0-9A-Fa-f]{2}|[^/:\\s])*':'(?:%[0-9A-Fa-f]{2}|[^/\\s])*'):'\\S*'; continue; } // ok
  
        // (SYMBOL)
        if(t$c0 == '(')
        {
          if(t$ == '(U)') { if(m) ss += this.$UrlState(s,3,cs); else { ss += '\\w+:/+(?=[^\/])'; m=1; } s=3; }
          if(t$ == '(P)') { if(m) ss += this.$UrlState(s,1,cs); else m=1; s=1; }
          if(t$ == '(T)') { if(m) ss += this.$UrlState(s,1,cs); m=0; s=0; }
          Gkod.Trace.Warning('XPhrase: Control-tag '+t$+' ignored in "'+x+'"');
          continue;
        }
      }
      ss += t$.replace(this.$rx_e,'\\$1');
    }
  
    while(cs.length>0) { var pc=cs.pop(); ss += (pc.p==0)?')?':')'; Gkod.Trace.Warning('XPhrase: Unterminated '+((pc.p==0)?'[':((pc.p==1)?'(':'{'))+' in "'+x+'"'); }
  
    if(sa.length==0)
    {
      if(m) ss += this.$UrlState(s,1,cs); // force enter (url-path)
    }
    else
    {
      sa.push({"ss":ss,"m":m,"s":s});
      
      // force enter (url-path) for all
      var all = true;
      for(var i=0,n=sa.length; i<n; ++i)
        { var i$ = sa[i]; if(i$.m!=1||i$.s!=1) all = false; }
      if(all)
        ss = '(?:'+sa.join('|')+')'+this.$UrlState(2,1,cs); // 2->1 is enough to force enter (url-path)
      else
      {
        for(var i=0,n=sa.length; i<n; ++i)
          { var i$ = sa[i]; if(i$.m==1&&i$.s>1) sa[i] += this.$UrlState(i$.s,1,cs); }
        ss = '(?:'+sa.join('|')+')';
      }
    }
  
    // Gkod.Trace.Write('XPhrase.$CreateSpan: "'+x+'" -> "'+ss+'"');
    return ss;
  }

Gkod.Helper.XPhrase.$UrlState = function(s1,s2,cs) // state1, state2, context-stack
  {
    if(s1<=s2) return '';
    if(s2==1)
    {
      if(s1==2) return '/';
      if(cs.length>0 && cs[cs.length-1].p==2)
        return ')(?::[^/\\s]*)?(/';
      return '(?::[^/\\s]*)?/';
    }
    return '';
  }

// Url
// ==========================================================================

Gkod.Helper.Url = function(p)
{
  this.p = String(p);
  var a = this.p.match(/^[^\?#&]*|[\?&][^\?#&=]*|=[^\?#&]*|#.*$/g);
  this.url = (a.length>0)?a[0]:'';
  this.fragment = ((a.length>1)&&(a[a.length-1].charAt(0)=='#'))?a.pop().substr(1):null;
  this.query = {};
  for(var i=1,n=a.length; i<n; ++i)
  {
    var ai = a[i++];
    if((i<n)&&(a[i].charAt(0)==='='))
      { this.query[ai.substr(1)]=decodeURIComponent(a[i].substr(1)); continue; }
    this.query[ai.substr(1)]='';
    --i;
  }
}

Gkod.Helper.Url.prototype.toString = function() { return this.p; }
Gkod.Helper.Url.prototype.GetUrl = function() { return this.url; }
Gkod.Helper.Url.prototype.GetQuery = function() { return this.query; }
Gkod.Helper.Url.prototype.GetFragment = function() { return this.fragment; }
Gkod.Helper.Url.prototype.GetParam = function(p,d) { var undefined; var r=this.query[p]; return ((r===undefined)?d:r); }
Gkod.Helper.Url.prototype.Safe_GetParam = function(p,l,d) 
  {
    var undefined;
    var r=this.query[p];
    if(r===undefined) return d;
    r = r.replace(/[<'">]/g,'');
    if(l!==undefined && r.length>l) r = r.substr(0,l);
    return r;
  }
Gkod.Helper.Url.GetDomain = function(u)
  {
    var a = String(u).match(/:\/\/+([^\/:]+)(?::[^\/]+)?\//);
    if(!a||a.length!=2) return null;
    return a[1];  
  }

// Window
// ==========================================================================

Gkod.Helper.Window = {};
Gkod.Helper.Window.GetParent = function(w) { if(w && w.parent) return w.parent; return null; }
Gkod.Helper.Window.GetParentList = function(w) { var a=[]; if(!w) w=window; while(w) { a.push(w); if(w==w.top) return a; w=w.parent; } return a; }
Gkod.Helper.Window.GetDocument = function(w) { try { if(w && w.document) return w.document; } catch(e) {} return null; }
Gkod.Helper.Window.GetForms = function(w) { try { if(w && w.document && w.document.forms) return w.document.forms; } catch(e) {} return null; }
Gkod.Helper.Window.SetHash = function(w,hash)
{
  w = w||window;
  var h = w.location.hash;
  var l = String(w.location);
  w.location = ((h && h.length!=0)?l.substr(0,l.length-h.length):l)+(hash?'#'+hash:'');
}

// Document
// ==========================================================================

Gkod.Helper.Document = {};
Gkod.Helper.Document.GetUrl = function(d) { if(d) return new Gkod.Helper.Url(d.URL); /* Gkod.Trace.Write(document.URL); */ return new Gkod.Helper.Url(document.URL); } 
Gkod.Helper.Document.GetTitle = function(d) { if(d) return d.title; return document.title; }

// Dom
// ==========================================================================

Gkod.Helper.Dom = {};
Gkod.Helper.Dom.E = function(id,n) { var undefined; if(n===undefined) n=document; n=n.getElementById(id); if(!!n) return n; throw 'Gkod.Helper.Dom.E, missing id="'+id+'"'; }
Gkod.Helper.Dom.EA = function(ids,n)
  {
    var undefined;
    if(n===undefined) n=document;
    var a = ids.split(',');
    var na = [];
    for(var i=0,ni=a.length; i<ni; ++i)
    {
      var $n = n.getElementById(a[i]);
      if($n) na.push($n);
    }
    return na;
  }
Gkod.Helper.Dom.RemoveNode = function(n) { if(!n||!n.parentNode) return; n.parentNode.removeChild(n); }
Gkod.Helper.Dom.Get = function(id,n) { var undefined; if(n===undefined) n=document; return n.getElementById(id); }
Gkod.Helper.Dom.GetElements = function(n,t,c)
  {
    var undefined;
    n = n||document;
    if(c!==undefined && n.getElementsByClassName)
    {
      var l = n.getElementsByClassName(c);
      if(t===undefined) return l;
      t = t.toUpperCase();
      var a = [];
      for(var i=0; i<l.length; ++i)
        if(l[i].tagName == t)
          a.push(l[i]);
      return a;
    }
    
    if(t!==undefined)
    {
      var l = n.getElementsByTagName(t);
      if(c===undefined) return l;
      var a = [];
      var x = new RegExp("(^|\\s)"+c+"(\\s|$)");
      for(var i=0; i<l.length; ++i)
        if(l[i].className == c || x.test(l[i].className))
          a.push(l[i]);
      return a;
    }
    
    return null;
  }
Gkod.Helper.Dom.GetBoundingRect = function(n) // works only on IE and FF3
  {
    var r = {'left':0,'top':0,'right':0,'bottom':0};
    if(!n||!n.getBoundingClientRect) return r;
    return n.getBoundingClientRect();
  }
Gkod.Helper.Dom.GetTextContent = function(n) { return n.innerText || n.textContent; } 
Gkod.Helper.Dom.SetTextContent = function(n,v) { if(n.innerText===Gkod_Undefined) n.textContent=v; else n.innerText=v; }
Gkod.Helper.Dom.SetStyle = function(n,s,v) { n.style[s] = v; }
Gkod.Helper.Dom.HasClassName = function(n,c)
  {
    var cc = n.className;
    return (cc.length>0 && (cc==c || new RegExp("(^|\\s)"+c+"(\\s|$)").test(cc)));
  }
Gkod.Helper.Dom.AddClassName = function(n,c,add)
  {
    if(add===false)
      return Gkod.Helper.Dom.RemoveClassName(n,c);
    if(Gkod.Helper.Dom.HasClassName(n,c))
      return;
    n.className += (n.className?' ':'')+c;
  }
Gkod.Helper.Dom.RemoveClassName = function(n,c)
  {
    n.className = Gkod.Helper.Trim(n.className.replace(new RegExp("(^|\\s+)"+c+"(\\s+|$)"),' '));
  }
Gkod.Helper.Dom.WriteLine = function(n,v) { n.innerHTML += v+'<br />'; }
Gkod.Helper.Dom.Focus = function(n,ids)
  {
    if(n===null) n=document;
    var undefined;
    var a = (ids===undefined)?[n]:Gkod.Helper.Dom.EA(ids,n);
    for(var i=0,ni=a.length; i<ni; ++i)
    {
      var $n = a[i];
      var na;
      if($n.tagName && "INPUT,SELECT,TEXTAREA,A".indexOf($n.tagName)>=0) na = [$n];
      else
      { 
        na = $n.getElementsByTagName('FORM'); if(!na||na.length==0) {
        na = $n.getElementsByTagName('INPUT'); if(!na||na.length==0) {
        na = $n.getElementsByTagName('SELECT'); if(!na||na.length==0) {
        na = $n.getElementsByTagName('TEXTAREA'); if(!na||na.length==0) {
        na = $n.getElementsByTagName('A'); } } } }
      }
      
      if(na&&na.length>0)
      {
        var $na = na[0];
        if($na.tagName=='FORM')
        {
          var found = false;
          for(var j=0; j<$na.length; ++j)
          {
            var $e = $na.elements[j];
            if($e.type == 'hidden') continue;
            $na = $e;
            found = true;
            break;
          }
          if(!found)
            $na = null;
        }
        
        if($na)
        {
          $na.focus(); 
          if($na.tagName == 'INPUT' || $na.tagName=='TEXTAREA')
            $na.select();
          return;
        }
      }
    } 
  }
Gkod.Helper.Dom.SetValue = function(n,v)
  {
    n.value = v;
  }
Gkod.Helper.Dom.IsVisible = function(n)
  { return (n.style.display!='none'); }
Gkod.Helper.Dom.Toggle = function(n,s)
  {
    if(n===null) n=document;
    var a,i,ni;
    a = s.split(',');
    for(i=0,ni=a.length; i<ni; ++i)
    {
      var $i = a[i];
      if($i.length==0) continue;
      var $n = n.getElementById($i);
      if($n)
        $n.style.display = (($n.style.display=='none')?'':'none'); 
    }
  }
Gkod.Helper.Dom.Show = function(n,s,b)
  {
    var undefined;
    if(b===undefined) b = true;
    if(n===null) n=document;
    var show = (!!b)?'':'none'; 
    var a,i,ni;
    a = s.split(',');
    for(i=0,ni=a.length; i<ni; ++i)
    {
      var $i = a[i];
      if($i.length==0) continue;
      var $n = n.getElementById($i);
      if($n) $n.style.display = show; 
    }
  }
Gkod.Helper.Dom.Hide = function(n,s)
  {
    return Gkod.Helper.Dom.Show(n,s,false);
  }
Gkod.Helper.Dom.ShowHide = function(n,s,h,mf)
  {
    Gkod.Helper.Dom.Show(n,h,false);
    Gkod.Helper.Dom.Show(n,s,true);
    if(!mf) this.Focus(n,s);
  }

// Palette
// ==========================================================================

Gkod.Helper.$Palette = function(id,content,options)
  {
    var undefined;
    this.id = id;
    this.content = content;
    this.width = (options!==undefined && options.width!==undefined)?options.width:0;
    this.left = (options!==undefined && options.left!==undefined)?options.left:0;
    this.top = (options!==undefined && options.top!==undefined)?options.top:0;
    this.Show();
  }
  
Gkod.Helper.$Palette.prototype.Show = function()
  {
    var pn = Gkod.Helper.Dom.Get('gkod_$xpalette');
    var p = Gkod.Helper.$PaletteObj;
    if(pn!==null && p!==null && p.id==this.id) return;
    if(p!==null) p.Hide();

    var tn = Gkod.Helper.Dom.Get(this.id);
    if(!tn) return;
    
    var width = this.width>0?this.width:(tn.clientWidth+20);
    
    n = document.createElement('div');
    n.id = 'gkod_$xpalette';
    n.innerHTML =
      '<div style="position:relative;left:0px;top:0px;width:0px;overflow:visible"><div class="xpalette" style="position:absolute;left:'+this.left+'px;top:'+this.top+'px;width:'+width+'px">'+this.content+'</div></div>' 
    ;
    
    tn.parentNode.insertBefore(n,null);
    Gkod.Helper.$PaletteObj = this;
    var id = this.id;
    
    setTimeout
    (
      function() 
      {
        document.onclick = function()
        {
          Gkod.Helper.HidePalette(id);
          document.onclick = null;
        };
      },
      10
    );
  }

Gkod.Helper.$Palette.prototype.Hide = function()
  {
    var p = Gkod.Helper.$PaletteObj;
    if(p===null || p.id!=this.id) return;
    Gkod.Helper.$PaletteObj = null;
    Gkod.Helper.Dom.RemoveNode(Gkod.Helper.Dom.Get('gkod_$xpalette'));
    document.onclick = null;
  }

Gkod.Helper.$PaletteObj = null;

Gkod.Helper.ShowPalette = function(id,content,options)
  { new Gkod.Helper.$Palette(id,content,options); }

Gkod.Helper.HidePalette = function(id)
  {
    var p = Gkod.Helper.$PaletteObj;
    if(p===null || p.id!=id) return;
    p.Hide();
  }

/*

// OpacityEffect
// ==========================================================================

Gkod.Helper._OpacityEffect = function()
{
}

// Dialog
// ==========================================================================

Gkod.Helper._dialogs = [];
Gkod.Helper._glass = null;
Gkod.Helper._glassColor = '#006797';
Gkod.Helper._glassFader = null;
Gkod.Helper._glassOpacityNow = 100;

Gkod.Helper._Initialize = function(show)
  {
  }

Gkod.Helper._GlassPane = function()
  {
  }

Gkod.Helper.ShowDialog = function(id,content,options)
  {
    var dlg = new Gkod.Helper._Dialog();
    if(!Gkod.Helper._dialogs.length)
      Gkod.Helper._GlassPane(true);
    else Gkod.Helper._dialogs[Gkod.Helper._dialogs.length-1].Hide();
    Gkod.Helper._dialogs.push(dlg);
    dlg.Show();
  }

Gkod.Helper.CloseDialog = function(id)
  {
    if(!Gkod.Helper._dialogs.length) return;
    var dlg = Gkod.Helper._dialogs.pop();
    dlg.Hide();
    if(!Gkod.Helper._dialogs.length)
      Gkod.Helper._GlassPane(false);
    
  }
*/

// Cache
// ==========================================================================


Gkod.Helper.Cache = function()
{
  this.c = new Object();
}

Gkod.Helper.Cache.prototype.Set = function(n,v) { this.c[n] = v; }
Gkod.Helper.Cache.prototype.Get = function(n,dv) { var undefined; var v = this.c[n]; return (v===undefined?dv:v); }
Gkod.Helper.Cache.prototype.Clear = function() { this.c = new Object(); }

// Load
// ==========================================================================

Gkod.Helper.PingUrl = function(url, options)
  {
    var o = Gkod.Helper.Override({}, options);
    o.method = 'HEAD';
    o.asynchronous = false;
    return new Gkod.Helper.AjaxRequest(url,o).Success();
  }

Gkod.Helper.Load = function(url, options)
  {
    var o = Gkod.Helper.Override({}, options);
    o.asynchronous = false;
    return new Gkod.Helper.AjaxRequest(url, o);
  }

Gkod.Helper.LoadText = function(url, options)
  {
    return Gkod.Helper.Load(url,options).GetResponseText();
  }

Gkod.Helper.LoadXml = function(url, options)
  {
    return Gkod.Helper.Load(url,options).GetResponseXML();
  }

Gkod.Helper.LoadJson = function(url, options) // unsafe for loading cross-domain data!
{
  // url = '../../../publishdata.json';
  var __t = Gkod.Helper.LoadText(url, options);
  if(__t===null) return null;
  return (function(){try{return eval('(function(){return '+__t+'}).call()');}catch(e){Gkod.Helper.Exception(e,'Gkod.Helper.LoadJson: '+url);return null;}}).call();
}

Gkod.Helper.LoadScript = function(url, options) // unsafe for loading cross-domain data!
{
  var __t = Gkod.Helper.LoadText(url, options);
  if(__t == null) return false;
  var ok = true;
  (function(){try{eval(__t);}catch(e){ok=false;Gkod.Helper.Exception(e,'Gkod.Helper.LoadScript: '+url);}}).call();
  return ok;
}

Gkod.Helper.AsyncPingUrl = function(url, process, options)
  {
    var undefined;
    var o = Gkod.Helper.Override({}, options);
    var onDone = o.OnDone;
    o.method = 'HEAD';
    o.asynchronous = true;
    o.OnDone = function(arq) 
    {
      try { if(onDone!==undefined) onDone.call(arq,arq); } catch(e) {}
      if(process!==undefined)
        process.call(arq,arq.Success(),arq); 
    };
    return new Gkod.Helper.AjaxRequest(url,o);
  }

Gkod.Helper.AsyncLoad = function(url, process, options)
  {
    var undefined;
    var o = Gkod.Helper.Override({}, options);
    var onDone = o.OnDone;
    o.asynchronous = true;
    o.OnDone = function(arq) 
    {
      try { if(onDone!==undefined) onDone.call(arq,arq); } catch(e) {}
      if(process!==undefined)
        process.call(arq, arq.Success()?arq.request.responseText:null, arq); 
    };
    return new Gkod.Helper.AjaxRequest(url,o);
  }

// XmlResource
// ==========================================================================

Gkod.Helper._GetTextContent = function(node)
{
  var undefined;
  if(node.textConent !== undefined)
    return node.textContent;

  var c = node.childNodes;
  var t = '';
  for (var i=0,n=c.length; i<n; ++i)
  {
    var $i = c[i];
    if($i.nodeType==1)
      t += Gkod.Helper._GetTextContent($i);
    else if($i.nodeType==3)
      t += $i.nodeValue;
    else if($i.nodeType==4)
      t += $i.data;
  }
  return t;
}

Gkod.Helper.GetXmlResourceUrl = function(url,lang)
  {
    url = url || '';
    var rclang = (lang&&lang!='')?lang.toLowerCase()+'.':'';
    var rcs = ((url==''||/[\/]$/.test(url))?'':'.')+rclang+'resources.xml';
    return url.replace(/(?:\.[^\.\/]*)?$/,rcs);
  }

Gkod.Helper.LoadXmlResource = function(url,lang)
{
  lang = lang || '';
  var rsu = Gkod.Helper.GetXmlResourceUrl(url,lang);
  var xrc = Gkod.Helper.LoadXml(rsu);
  var rc = new Object();
  if(xrc)
  {
    var erg = xrc.getElementsByTagName('resource');
    for(var i=0,n=erg.length; i<n; ++i)
    {
      var $i = erg[i];
      var a = $i.attributes.getNamedItem('xml:id').nodeValue;
      if(!a) continue;
      rc[a] = Gkod.Helper.Trim(Gkod.Helper._GetTextContent($i));
    }
  }
  return rc;
}

// Resource Manager Object
// ==========================================================================

Gkod.Helper._RM_cache = new Gkod.Helper.Cache();
Gkod.Helper._RM_rx = /[^\{]+|\{(?:rc:[^\}]+\})?/g;
Gkod.Helper._RM =
{
  _LoadResourceObject: function(url,lang,loadNeutral)
    {
      var undefined;
      var rmc = Gkod.Helper._RM_cache;

      lang = lang || '';

      // add default language files
      var la = new Array(lang);
      if(loadNeutral && (lang!=''))
        la.push('');

      // compose resource object
      var rc = new Object();
      while(la.length>0)
      {
        var l = la.shift();
        var n = url+'?'+l;
        var c = rmc.Get(n);
        if(c===undefined)
        {
          c = Gkod.Helper.LoadXmlResource(url,l);
          if(!c)
            c = new Object();
          rmc.Set(n,c);
        }
        Gkod.Helper.Merge(rc,c);
      }
      
      return rc;
    },
  _BindString: function(stack,rc,rcl,rci,m,v,ri)
    {
      var undefined;

      if(rc[m]!==undefined)
        return rc[m];

      var nonbase = (v === undefined);
      if(nonbase)
      {
        // search loops
        for(var i=0; i<stack.length; ++i)
          if(stack[i]==m)
            { rc[m] = ''; return ''; }

        ri = rci[m];
        if(ri !== undefined)
          v = rcl[ri][m];

        if(v === undefined)
          { rc[m] = ''; return ''; }

        stack.push(m);
      }
      
      // bind string tokens
      var vb = null;
      var vp = null;
      var r = '';
      var a = v.match(Gkod.Helper._RM_rx);
      if(a)
      {
        for(var i=0,n=a.length; i<n; ++i)
        {
          var t = a[i];
          if(t.charAt(0)!='{' || t.length==1)
            r += t;
          else
          {
            var x = t.substr(4,t.length-5);
            if(x == 'base')
            {
              if(vb == null)
              {
                vb = '';
                var bi = ri;
                while(bi>0)
                {
                  --bi;
                  var bs = rcl[bi][m];
                  if(bs !== undefined)
                  {
                    vb = this._BindString(stack,rc,rcl,rci,m,bs,bi);
                    break;
                  }  
                }
              }
              r += vb;
            }
            else if(x == 'parent')
            {
              if(vp == null)
              {
                vp = '';
                var p = m.lastIndexOf('.');
                if(p>=0)
                  vp = this._BindString(stack,rc,rcl,rci,m.substring(0,p));
              }
              r += vp;
            }
            else
            {
              var c0 = x.charAt(0);
              if(c0.toUpperCase()!=c0)
                r += '(Invalid:'+t+')';
              else r += this._BindString(stack,rc,rcl,rci,x);
            }
          }
        }
      }

      if(nonbase)
      {
        rc[m] = r;
        stack.pop();
      }
      
      return r;
    },
  _BindResources: function(rcl)
    {
      var undefined;

      // merge plain strings
      var rc = new Object();
      var rci = new Object();
      for(var i=rcl.length;i>=0;--i)
      {
        var rcn = rcl[i];
        for(var m in rcn)
        {
          if(rc[m]!== undefined)
            continue;
          var v = rcn[m];
          if(rcn[m].indexOf('{rc:')<0)
            rc[m] = v;
          else if(rci[m]===undefined)
            rci[m] = i;
        }
      }
      
      // bind resource strings containing references
      var empty = new Array();
      for(var m in rci)
        this._BindString(empty,rc,rcl,rci,m);
        
      return rc;
    },
  _LoadResources: function(that,lang)
    {
      var rcl = that.parent?this._LoadResources(that.parent.that,lang):new Array();
      var rcn = new Object();
      for(var i=0,n=that.rcs.length; i<n; ++i)
        Gkod.Helper.Override(rcn,this._LoadResourceObject(that.rcs[i],lang,'en',true));
      rcl.push(rcn);
      return rcl;
    },
  AttachResource: function(that,url)
    {
      var index = Gkod.Helper.IndexOf(that.rcs,url);
      if(index!=-1)
        that.rcs.splice(index,1);
      that.rcs.push(url);
    },
  LoadResources: function(that,lang)
    {
      lang = lang?lang.toUpperCase():'';
      if(that.lang==lang)
        return that.rco;

      var rc = this._BindResources(this._LoadResources(that,lang));
      that.lang = lang;
      that.rco = rc;
      return rc;
    }
};
    
Gkod.Helper.CreateResourceManager = function(parent)
{
  var undefined;

  var that = new Object();
  that.parent = parent||null;
  that.lang = null;
  that.rco = new Object();
  that.rcs = new Array();

  var rm = Gkod.Helper._RM;
  var rmo = function(id,d) { var v = that.rco[id]; return ((v===undefined)?((d===undefined)?'Undefined:'+id:d):v); }
  rmo.AttachResource = function(url) { rm.AttachResource(that,url) };
  rmo.LoadResources = function(lang) { rm.LoadResources(that,lang) };
  rmo.GetStrings = function() { return that.rco; };
  rmo.that = that;
  return rmo;
}

// Resource
// ==========================================================================

Gkod.Helper.GetResourceUrl = function(url, lang)
  {
    var llang = lang.toLowerCase();
    var rcurl = url.replace(/\.([^\.\/]*)$/,'.'+llang+'.$1');
    if(rcurl == url) rcurl += '.'+llang;
    return rcurl;
  }

Gkod.Helper.GetResources = function(urls, lang)
  {
    var rc = Gkod.Helper.CreateResourceManager();
    urls = Gkod.Helper.IsEmpty(urls)?['']:(Gkod.Helper.IsArray(urls)?urls:[''+urls]);
    for(var i=0, n=urls.length; i<n; ++i)
      rc.AttachResource(urls[i]);
    rc.LoadResources(lang);
    return rc;
  }

Gkod.Helper.$LoadResourceScript = function(url) // unsafe for loading cross-domain data!
  {
    var text = Gkod.Helper.LoadText(url);
    if(text === null)
      return null;
    
    var rc = (
      function()
      {
        var Resource={};
        try {eval(text)||'';} catch(e){ Gkod.Helper.Exception(e,'Gkod.Helper.$LoadResourceScript: '+url); }
        return Resource;
      }
    ).call();
  
    return rc;
  }

// AjaxRequest
// ==========================================================================

// url
// options.method
// options.parameters
// options.asynchronous

Gkod.Helper.AjaxRequest = function(url, options)
{
  var undefined;
  if(options===undefined) options = {};
  if(options.method) options.method.toUpperCase();

  this.id = Gkod.Helper.UniqueId('ax');
  this.url = url;
  this.options = options;
  this.contentType = options.contentType?options.contentType:'application/x-www-form-urlencoded'; 
  this.parameters = options.parameters;
  this.method = Gkod.Helper.GetOption(options.method,['GET','POST','HEAD']);
  this.queryParams = Gkod.Helper.AjaxRequest.$CreateQueryString(options.parameters);
  // when GET, append parameters to URL
  if(this.method!='POST' && this.queryParams.length>0)
    this.url += ((this.url.indexOf('?')>=0)?'&':'?')+this.queryParams;
  // else if (/Konqueror|Safari|KHTML/.test(navigator.userAgent)) params += '&_=';
  this.body = this.method=='POST'?this.queryParams:null;
  this.asynchronous = !!this.options.asynchronous;

  this.request = null;
  this.aborted = false;
  this.$completed = false;

  if(window.XMLHttpRequest)
    this.request = new XMLHttpRequest();
  else if(window.ActiveXObject && !(this.request=new ActiveXObject("Msxml2.XMLHTTP")))
    this.request = new ActiveXObject("Microsoft.XMLHTTP");
  if(!this.request)
    throw 'Gkod.Helper.AjaxRequest, no transport';

  this.$DoRequest();
}

Gkod.Helper.AjaxRequest.States = 
[
  'Unsent',          // 0 
  'Opened',          // 1
  'HeadersReceived', // 2 
  'Loading',         // 3
  'Done'             // 4
];
 
Gkod.Helper.AjaxRequest.$CreateQueryString = function(params)
{
  var undefined;
  if(params===undefined) params = {};
  var a = [];
  params._ = new Date().getTime();
  for(var key in params)
  {
    var value = params[key];
    a.push((value===undefined)?key:key+'='+encodeURIComponent(String(value)));
  }
  return a.join('&');
}

Gkod.Helper.AjaxRequest.prototype.$OnReadyStateChange = function()
{
  if(this.$completed) return;

  var rs = this.request.readyState;
  var state = Gkod.Helper.AjaxRequest.States[rs];
  
  // Gkod.Trace.Write(this.id+', processing ReadyState:'+rs+', state:'+state);
  if(rs==4) this.$completed = true;
  
  try { (this.options['On'+state] || Gkod.Helper.Nop)(this); } 
  catch(e) { this.$OnException(e); }

  if(this.$completed)
  {
    // avoid memory leak (IE)
    this.request.onreadystatechange = function() {};
    try { (this.options['On'+(this.Success()?'Success':'Failure')] || Gkod.Helper.Nop)(this); } 
    catch(e) { this.$OnException(e); }
  }
}

Gkod.Helper.AjaxRequest.prototype.$DoRequest = function()
{
  // Gkod.Trace.Write(this.id+', URL:'+this.url);
  try
  {
    var myself = this;
    this.request.onreadystatechange = function() { myself.$OnReadyStateChange(); }
    this.request.open(this.method, this.url, this.asynchronous);
    this.$SetHeaders();
    this.request.send(this.body);
    if(!this.asynchronous) myself.$OnReadyStateChange(); // Force ready state 4 for synchronous requests
  }
  catch(e) { this.$OnException(e); }
}

Gkod.Helper.AjaxRequest.prototype.$SetHeaders = function()
{
  var header = 
  {
    'Accept': 'text/plain, text/javascript, text/html, text/xml, application/xml, */*'
  };
  
  if(this.method == 'POST')
  {
    if(!!this.contentType)
      header['Content-type'] = this.contentType+'; charset=UTF-8';
    
    // Force "Connection: close" for older Mozilla browsers to work around a bug where 
    // XMLHttpRequest sends an incorrect Content-length header. See Mozilla Bugzilla #246651.
    if(this.request.overrideMimeType && (navigator.userAgent.match(/Gecko\/(\d{4})/)||[0,2005])[1]<2005)
      header['Connection'] = 'close';
  }
  
  if(!!this.options.header)
    for(var m in this.options.header)
      header[m] = this.options.header[m];

  for(var m in header)
    this.request.setRequestHeader(m, header[m]);
}

Gkod.Helper.AjaxRequest.prototype.Abort = function()
  { if(!this.$completed) this.request.abort(); }

Gkod.Helper.AjaxRequest.prototype.Success = function()
  { var s = this.GetStatus(); return (!s || (s>=200 && s<300)); }

Gkod.Helper.AjaxRequest.prototype.GetStatus = function()
  { try { return this.request.status || 0; } catch (e) { return 0; } }

Gkod.Helper.AjaxRequest.prototype.EvalResponse = function()
  { try { return eval(this.request.responseText||''); } catch (e) { this.$OnException(e); } }

Gkod.Helper.AjaxRequest.prototype.GetResponseHeader = function(name)
  { try { return this.request.getResponseHeader(name)||null; } catch (e) { return null } }

Gkod.Helper.AjaxRequest.prototype.GetResponseText = function()
  { return (this.Success()?this.request.responseText:null); }

Gkod.Helper.AjaxRequest.prototype.GetResponseXML = function()
  { return (this.Success()?this.request.responseXML:null); }

Gkod.Helper.AjaxRequest.prototype.$OnException = function(e)
  { if(this.options.OnException) this.options.OnException(this, e); }

// SmoothActivation
// ==========================================================================

Gkod.Helper.SmoothActivation = function(options)
{
  var undefined;
  if(options===undefined) options = {};

  this.cid = null;
  this.aid = null;
  this.did = null;
  this.atimer = -1;
  this.dtimer = -1;
  this.atime = ((options.atime===undefined)?50:options.atime);
  this.dtime = ((options.dtime===undefined)?this.atime:options.dtime);
  this.fna = ((options.Activate===undefined)?Gkod.Helper.Nop:options.Activate);
  this.fnd = ((options.Deactivate===undefined)?Gkod.Helper.Nop:options.Deactivate);
  // this.nostrobe = !!options.nostrobe;
}

Gkod.Helper.SmoothActivation.prototype.Activate = function(id)
{
  if(this.aid==id) // ignore pending re-activation
    return;  

  if(this.did==id) // ignore deactiation strobe
    return this.$CancelDeactivate();
  
  if(this.cid==id) // ignore re-activation
    return;

  if(!!this.cid) // deactivate current if new activation
    this.Deactivate(this.cid);

  if(!!this.aid) // clear previous non-completed activation
    this.$CancelActivate(); // strobe activation ?

  // Gkod.Trace.Write('Activate: '+id);
  var _this = this;
  this.aid = id;
  this.atimer = setTimeout(function(){_this.$ActivateTimer();}, this.atime);
}

Gkod.Helper.SmoothActivation.prototype.Deactivate = function(id)
{
  if(this.did==id) // ignore pending re-deactivation
    return;  

  if(this.aid==id) // ignore activation strobe
    return this.$CancelActivate();

  if(this.cid!=id || !!this.aid) // ignore deactivation
    return;

  var _this = this;
  this.did = id;
  this.dtimer = setTimeout(function(){_this.$DeactivateTimer();}, this.dtime);
}

Gkod.Helper.SmoothActivation.prototype.Cancel = function()
{
  this.$CancelActivate();
  this.$CancelDeactivate();
}

Gkod.Helper.SmoothActivation.prototype.Commit = function()
{
  var did = this.did;
  this.$CancelActivate();
  this.$CancelDeactivate();
  try { did && this.fnd.call(this,did); } catch(e) { Gkod.Helper.Exception(e,'Gkod.Helper.SmoothActivation.Commit'); }
}

Gkod.Helper.SmoothActivation.prototype.$CancelActivate = function()
  {
    if(this.atimer>=0)
      clearTimeout(this.atimer);
    this.aid = null;
    this.atimer = -1;
  }

Gkod.Helper.SmoothActivation.prototype.$CancelDeactivate = function()
  {
    if(this.dtimer>=0)
      clearTimeout(this.dtimer);
    this.did = null;
    this.dtimer = -1;
  }

Gkod.Helper.SmoothActivation.prototype.$ActivateTimer = function()
  {
    if(this.did!==null)
    {
      clearTimeout(this.dtimer);
      this.$DeactivateTimer();
    }

    if(this.cid!==null)
    {
      try { this.fnd.call(this,this.cid); } catch(e) { Gkod.Helper.Exception(e,'Gkod.Helper.SmoothActivation.$ActivateTimer, deactivate callback'); }
      this.cid = null;
    }
    
    try { this.fna.call(this,this.aid); } catch(e) { Gkod.Helper.Exception(e,'Gkod.Helper.SmoothActivation.$ActivateTimer, activate callback'); }
    this.cid = this.aid;
    this.aid = null;
    this.atimer = -1;
  }

Gkod.Helper.SmoothActivation.prototype.$DeactivateTimer = function()
  {
    if(this.cid!=this.did) return Gkod.Trace.Write('Gkod.Helper.SmoothActivation.$DeactivateTimer.Ignore'); // ignore this
  
    try { this.fnd.call(this,this.did); } catch(e) { Gkod.Helper.Exception(e,'Gkod.Helper.SmoothActivation.$DeactivateTimer, deactivate callback'); }
    this.cid = null;
    this.did = null;
    this.dtimer = -1;
  }

// END COMPONENT: Gkod.Helper ===============================================

Gkod.Helper.ComponentLoaded();
}
