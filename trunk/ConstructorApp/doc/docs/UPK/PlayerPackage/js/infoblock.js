/*--
Copyright © 1998, 2009, Oracle and/or its affiliates.  All rights reserved.
--*/

var isOnLink = false;

//defines
var SM_CYCAPTION=19;
var	SM_CXFRAME=4;
var SM_CYFRAME=4;
var SM_CYHSCROLL=16;
var SM_CXVSCROLL=16;

function ShowInfoBlock(s) {
    try {
        PlayStop();
    }
    catch (e) { };
	var webpage=false;
	var ss=Gkod.Escape.MyUnEscape(s);
	while(ss.substr(0,3)=="../")
	{
		ss=ss.substr(3);
	}
	if (ss.substr(36)=='/index.html')
	{
		webpage=true;
	}

	if (webpage)
	{	
		var w=screen.availWidth;
		var left=(w-infowidth)/2;

		var h=screen.availHeight;
		var top=(h-infoheight)/2;

		var features="toolbar=1,scrollbars=1,statusbar=1,resizable=1,fullscreen=0";
		id = window.open(Gkod.Escape.MyUnEscape(s),"","top="+top+",left="+left+",width="+infowidth+",height="+infoheight+features);
		var s="Center("+left+","+top+")";
		setTimeout(s,500);
		
	}
	else 
	{
	    iw = infowidth;
	    ih = infoheight;
		if (infowidth2)
		{
			if (infowidth2.length>0)
			{
				iw=infowidth2;
			}
		}
		if (infoheight2)
		{
			if (infoheight2.length>0)
			{
				ih=infoheight2;
			}
		}

		var w=screen.availWidth;
		var left=(w-iw)/2;

		var h=screen.availHeight;
		var top=(h-ih)/2;

		var features="toolbar=1,scrollbars=1,location=1,statusbar=1,menubar=1,resizable=1,fullscreen=0";
		id = window.open(Gkod.Escape.MyUnEscape(s),"","top="+top+",left="+left+",width="+iw+",height="+ih+features);
		var s="Center("+left+","+top+")";
		setTimeout(s,500);
	}
}

function OnLink()
{
  isOnLink = true
}

function OffLink()
{
  isOnLink = false
}

var globalloc="";

function MakeAbsolute(URL)
{
	var s=URL.toLowerCase();
	if (s.substr(0,7)=="mailto:")
		return URL;
	var loc="";
	if (globalloc.length==0)
	{
		globalloc=location.href;
		while (globalloc.indexOf('\\')!=-1)
			globalloc=globalloc.replace('\\','/');
	};
	loc=globalloc;
	var k=loc.indexOf('#');
	if (k<0)
		k=loc.indexOf('?');
	if (k>=0)
		loc=loc.substr(0,k);
	var end
	end = loc.lastIndexOf('/')
	if(end!=-1 && URL.indexOf('//')==-1)
	{
		return loc.substr(0,end+1)+URL
	}
	else
		return URL
}

function WriteBASE(base)
{
  document.writeln("<BASE href='"+MakeAbsolute(base)+"'>")
}

var id;

function Center(x,y) {
    try {
        id.focus();
        id.moveTo(x, y);
    }
    catch (e) {
    }
};

function DoLink(URL,width,height,infotype,infokey)
{
//	0	-> TEXT
//	1	-> BITMAP
//	2	-> URL
//	3	-> DOCUMENT
//	999 -> Error
//	if (window.SoundPlayerObj)
//		SoundPlayerObj.Stop();
	if (isNaN(infotype))
		infotype=999;

	var w=0;
	if (width)
		w=width;
	var h=0;
	if (height)
		h=height;

	if (infotype==1)
	{
		w+=42;
		h+=22;
	}
	
	sw=window.screen.availWidth-2*SM_CYFRAME;				// screen width
	sh=window.screen.availHeight-2*SM_CYFRAME-SM_CYCAPTION;	// screen height

	if (w==0) w=sw;
	if (h==0) h=sh;

	if (w>sw) w=sw;
	if (h>sh) h=sh;

	var x=(sw-w)/2;
	var y=(sh-h)/2;

	var brprops="toolbar=0,scrollbars=1,location=0,statusbar=0,menubar=0,resizable=1";

	while (URL.indexOf("!apos;")!=-1)
		URL=URL.replace("!apos;","'");
	while (infokey.indexOf("!apos;")!=-1)
		infokey=infokey.replace("!apos;","'");
	while (infokey.indexOf('!quot;')!=-1)
		infokey=infokey.replace('!quot;','"');
	while (infokey.indexOf('!slash;')!=-1)
		infokey=infokey.replace('!slash;','\\');

	if (infotype==2 || infotype==3)
	{
		brprops="toolbar=1,scrollbars=1,location=1,statusbar=1,menubar=1,resizable=1";
	};

	var absURL=MakeAbsolute(URL);
	if (x==0 && y==0)
	{
		if(window.fatPlayer)
		{
			if (fatPlayer=="FS" || fatPlayer=="WEB")
			{
				var s="URL="+encodeURIComponent(absURL)+"&X=0&Y=0&W="+w+"&H="+h;
				s+="&TYPE="+infotype+"&KEY="+encodeURIComponent(infokey);
				FatPlayerCommand("INFOBLOCK_DOLINK",s);
			}
		}
		else
		{
			id = window.open(absURL,"", 
					brprops+",width="+w+",height="+h+",left=0,top=0");
		};
	}
	else
	{
		if(window.fatPlayer)
		{
			if (fatPlayer=="FS" || fatPlayer=="WEB")
			{
				var s="URL="+encodeURIComponent(absURL)+"&X="+x+"&Y="+y+"&W="+w+"&H="+h;
				s+="&TYPE="+infotype+"&KEY="+encodeURIComponent(infokey);
				FatPlayerCommand("INFOBLOCK_DOLINK",s);
			}
		}
		else
		{
			if (infotype==0)	// text info
			{
//				DeleteCookies();
				var cookie=new Cookie(document,"OnDemandPlayer",365,"/");
				cookie.Load();
				if (cookie.textInfoX)
					x=cookie.textInfoX;
				if (cookie.textInfoY)
					y=cookie.textInfoY;
				if (cookie.textInfoW)
					w=cookie.textInfoW;
				if (cookie.textInfoH)
					h=cookie.textInfoH;
				cookie.textInfoX=x;
				cookie.textInfoY=y;
				cookie.textInfoW=w;
				cookie.textInfoH=h;
				cookie.Store();
			};

			if (infotype==0)
			{
				id = window.open(absURL,"", 
						brprops+",width="+w+",height="+h+",left=2000,top="+y);
				var s="Center("+x+","+y+")";
				setTimeout(s,200);
			}
			else
			{
				id = window.open(absURL,"", 
						brprops+",width="+w+",height="+h+",left="+x+",top="+y);
			};
		};
	};
}

function DeleteCookies()
{
	var cookie=new Cookie(document,"OnDemandPlayer",365,"/");
	cookie.Load();
	delete cookie.textInfoX;
	delete cookie.textInfoY;
	delete cookie.textInfoW;
	delete cookie.textInfoH;
	cookie.Store();
};

function SaveCookies()
{
	var cookie=new Cookie(document,"OnDemandPlayer",365,"/");
	cookie.Load();
	cookie.textInfoX=window.screenLeft-4;
	cookie.textInfoY=window.screenTop-23;
	cookie.textInfoW=document.body.clientWidth+16;
	cookie.textInfoH=document.body.clientHeight;
	cookie.Store();
};

function InitTextInfo()
{
	setInterval("SaveCookies()",2000);
};
