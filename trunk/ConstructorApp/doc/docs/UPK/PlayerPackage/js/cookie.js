/*--
Copyright © 1998, 2009, Oracle and/or its affiliates.  All rights reserved.
--*/

var systemEnableCookies = true;

function Cookie(doc,name,exp,path,domain,secure)
{
	this.$document=doc;
	this.$name=name;
	if (exp)
		this.$exp=new Date((new Date()).getTime()+exp*3600000*24);
	else
		this.$exp=null;
	if (path)	this.$path=path; else this.$path=null;
	if (domain)	this.$domain=domain; else this.$domain=null;
	if (secure)	this.$secure=true; else this.$secure=false;
}

Cookie.prototype.Store = function()
{
	if (!systemEnableCookies)
		return;

	var cookieval="";
	for (var prop in this)
	{
		if ((prop.charAt(0)=="$") || ((typeof this[prop])=='function'))
			continue;
		if (cookieval!="")	cookieval+="&";
		cookieval+=prop+":"+escape(this[prop]);
	}
	
	var cookie=this.$name+"="+cookieval;
	if (this.$exp)
		cookie+="; expires="+this.$exp.toGMTString();
	if (this.$path)	cookie+="; path="+this.$path;
	if (this.$domain)	cookie+="; domain="+this.$domain;
	if (this.$secure)	cookie+="; secure=";
	
	this.$document.cookie=cookie;
}

Cookie.prototype.Load = function()
{
	if (!systemEnableCookies)
		return false;

	var allcookies=this.$document.cookie;
	if (allcookies=="")	return false;
		
	var start=allcookies.indexOf(this.$name+"=");
	if (start==-1)	return false;
	start+=this.$name.length+1;
	
	var end=allcookies.indexOf(";",start);
	if (end==-1)
		end=allcookies.length;
		
	var cookieval=allcookies.substring(start,end);
	
	var a=cookieval.split("&");
	for (var i=0; i<a.length; i++)
	{
		var p=a[i].split(":");
		this[p[0]]=unescape(p[1]);
	}
	
	return true;	
}

Cookie.prototype.Remove = function()
{
	if (!systemEnableCookies)
		return;

	var cookie = this.$name + '=';
	if (this.$path)	cookie += '; path=' + this.$path;
	if (this.$domain)	cookie += '; domain=' + this.$domain;
	cookie += '; expires=Fri, 02-Jan-1970 00:00:00 GMT';
	
	this.$document.cookie = cookie;
}
