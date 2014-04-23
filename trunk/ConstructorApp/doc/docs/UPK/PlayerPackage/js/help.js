/*--
Copyright © 1998, 2009, Oracle and/or its affiliates.  All rights reserved.
--*/

function onHelp(url)
{
	if (url.charAt(url.length - 1) == '/')
		url = url.substr(0, url.length - 1);
	_left=screen.availWidth/17;
	_top=_left;
	_height=screen.availHeight-3*_top;
	if (_height>500)
		_height=500;
	_width=_height*4.5/3;
	_height=390;
	_width=637;
	var strFeatures = "width="+_width+",height="+_height+",left="+_left+",top="+_top + 
				",resizable=1,toolbar=1,scrollbars=1,location=0,menubar=0";
	w=window.open(url+"/help/index.html", "odhelp", strFeatures)
	w.focus();
}
