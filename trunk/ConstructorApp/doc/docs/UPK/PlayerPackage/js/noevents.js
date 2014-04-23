/*--
Copyright © 1998, 2009, Oracle and/or its affiliates.  All rights reserved.
--*/

function IE()
{
	return (window.navigator.appName=="Microsoft Internet Explorer");
}

function EventKeyDown(event)
{
	var code = event.keyCode;
	if (code==114 || code==116 || code==122)		// F1, F3, F5 and F11 keys
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
			if (document.attachEvent)
			{
				// IE
				wnd.document.body.attachEvent("onkeydown", EventKeyDown);
				wnd.document.body.attachEvent("oncontextmenu", EventNull);
				wnd.document.body.attachEvent("onhelp", EventNull);
				wnd.document.body.attachEvent("onmousedown", testFunction);
			}
			else
			{
				// FF
				wnd.document.body.addEventListener("onkeydown", EventKeyDown, false);
				wnd.document.body.oncontextmenu = new Function("return false");
				wnd.document.oncontextmenu = new Function("return false");
				wnd.document.body.addEventListener("onhelp", EventNull, false);
			}
		}
	}
	catch(e){};
	if (wnd.frames)
	{
		for (var f=0; f<wnd.frames.length; f++)
		{
			attach_event_handlers(wnd.frames[f]);
		}
	}
}


function SetNoEvents()
{
	attach_event_handlers(window);
	//if (IE())
	//{
	//	attach_event_handlers(window);
	//}
	//else
	//{
	//	document.body.oncontextmenu = new Function("alert('Hi, babe!');return false");
	//}
}
