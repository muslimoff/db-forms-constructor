/*--
Copyright © 1998, 2009, Oracle and/or its affiliates.  All rights reserved.
--*/
function EventKeyDown(event)
{
	var code = event.keyCode;
	if (code == 112 || code==114 || code==116 || code==122)		// F1, F3, F5 and F11 keys
	{
		event.keyCode=0;
		return false;
	}
	return true;
}

function EventNull(event)
{
	return false;
}

function attach_event_handlers(wnd)
{
	try
	{
		if (wnd.document.body)
		{
			wnd.document.body.attachEvent("onkeydown", EventKeyDown);
			wnd.document.body.attachEvent("oncontextmenu", EventNull);
			wnd.document.body.attachEvent("onhelp", EventNull);
		}
	}
	catch(e)
	{
	}
/*	
	if (wnd.frames)
	{
		for (var f=0; f<wnd.frames.length; f++)
			attach_event_handlers(wnd.frames[f]);
	}
*/	
}

function IE()
{
	return (window.navigator.appName=="Microsoft Internet Explorer");
}

function SetNoEvents()
{
	if (IE())
		attach_event_handlers(window);
}

//<!--Version 9.6.0.1-->