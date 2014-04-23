/*--
Copyright © 1998, 2009, Oracle and/or its affiliates.  All rights reserved.
--*/

var PlayMode="S";
var fatPlayer="";

if (location.hash)
{
	var n=location.hash.indexOf("Mode=");
	if (n!=-1)
		PlayMode=location.hash.charAt(n+5);
}

document.write("<P><A class='InstructText'>"+R_menu_press+"</A><A class='InstructText' href='javascript:HLink(3);'>"+R_menu_close+"</A><A class='InstructText'>"+R_menu_this+"</A></P>");

function HLink(s)
{
	if (s==3)
	{
		if (fatPlayer=="FS" || fatPlayer=="WEB")
		{
			FatPlayerCommand("INFOBLOCK_CLOSE","");
		}
		else
		{
			window.close();
		};
	};
}

function document_onkeypress()
{
	if (window.event.keyCode==13)
	{
		if (fatPlayer=="FS" || fatPlayer=="WEB")
		{
			FatPlayerCommand("INFOBLOCK_CLOSE","");
		}
		else
		{
			window.close();
		};
	};
}

function EventKeyDown(event)
{
	if (event==null)
		event=window.event;
	var code = event.which ? event.which : event.keyCode
	if (code==13)
	{
		if (fatPlayer=="FS" || fatPlayer=="WEB")
		{
			FatPlayerCommand("INFOBLOCK_CLOSE","");
		}
		else
		{
			window.close();
		};
	};
}

function EventCancel(event)
{
 	return false 
}

document.ondragstart = EventCancel;
document.onkeydown = EventKeyDown;

function init(){
	
	strArgs = document.location.hash.substring(1).split("&");
	for (var i=0;i<strArgs.length;i++)
	{
		if (strArgs[i]=="FATPLAYER=FS")
		{
			fatPlayer="FS";
		};
		if (strArgs[i]=="FATPLAYER=WEB")
		{
			fatPlayer="WEB";
		};
	};

	window.focus();
}

init();
