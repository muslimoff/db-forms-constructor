 /*--
Copyright © 1998, 2009, Oracle and/or its affiliates.  All rights reserved.
--*/

var lcFatPlayer=false;

function ParseUrl()
{
	var paramstr=unescape(document.location.hash.substring(1));
	if (paramstr=="")
		paramstr=unescape(document.location.search.substring(1));
	var pars=paramstr.split('&');
	for (var p1=0; p1<pars.length; p1++)
	{
		var paritem=pars[p1].split("=");
		if (paritem[0].toUpperCase()=="FATPLAYER")
			lcFatPlayer=true;
	}
}

ParseUrl();

function EventCancel(event)
{
return false; 
}

function RegisterInMain()
{
	if (parent.parent.parent.LeadConcLoaded)
		parent.parent.parent.LeadConcLoaded(window)
}

function EventOnload()
{
	setTimeout("RegisterInMain()",200);
}

function EventKeyDown()
{
	if (parent.parent.parent.SearchKeyEvent)
		return parent.parent.parent.SearchKeyEvent(window.event.keyCode);
}


document.ondragstart = EventCancel;
document.onkeydown = EventKeyDown;

function DoLink(URL,width,height,infotype,infokey)
{
	while (infokey.indexOf("!apos;")!=-1)
		infokey=infokey.replace("!apos;","'");
	while (infokey.indexOf('!quot;')!=-1)
		infokey=infokey.replace('!quot;','"');
	while (infokey.indexOf('!slash;')!=-1)
		infokey=infokey.replace('!slash;','\\');

	if (!lcFatPlayer)
	{
		var _url=URL;
		if (URL.substr(0,2)=="..")
		{
			var path=unescape(document.location.pathname);
			while (path.indexOf('\\')!=-1)
				path=path.replace('\\','/');
			_url=document.location.protocol+'//'+document.location.host+path.substr(0,path.lastIndexOf('/')+1)+URL;
		}
		if (parent.DoLink)
			parent.DoLink(_url,width,height,infotype,infokey);
		else
			parent.parent.DoLink(_url,width,height,infotype,infokey);
	}
	else
		FatPlayerCommand("InfoBlock","Application="+lcAppName+"&Module="+encodeURIComponent(lcModuleName)+"&ID="+encodeURIComponent(infokey));
}
