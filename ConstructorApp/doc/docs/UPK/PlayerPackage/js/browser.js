/*--
Copyright © 1998, 2009, Oracle and/or its affiliates.  All rights reserved.
--*/

function IsMacOs() {
    k = (navigator.userAgent.indexOf("Macintosh") >= 0);
    return k;
}

function IsFF3()
{
	if (this.navigator)
	{
		if (this.navigator.userAgent)
		{
			if (this.navigator.userAgent.indexOf("Firefox/3")>0)
			{
				return true;
			}
		}
	}
	return false;
}

function IsFF() {
    var bi = new BrowserInfo();
    GetBrowserInfo(bi);
    return (bi.name == "Firefox");
}

function IsSafari()
{
    var bi = new BrowserInfo();
    GetBrowserInfo(bi);
    return (bi.name == "Safari" || bi.name == "Chrome");
}

function BrowserInfo() {
    this.name = "";
    this.version = 0;
}

function GetBrowserInfo(bi) {
    s = navigator.userAgent;
    k = 0 - 1;
    if (s.indexOf("Chrome") >= 0) {
        bi.name = "Chrome";
        k = s.indexOf("Chrome") + 7;
    }
    else if (s.indexOf("Opera") >= 0) {
        bi.name = "Opera";
        k = s.indexOf("Opera") + 6;
    }
    else if (s.indexOf("Firefox") >= 0) {
        bi.name = "Firefox";
        k = s.indexOf("Firefox") + 8;
    }
    else if (s.indexOf("Safari") >= 0) {
        bi.name = "Safari";
        k = s.indexOf("Version") + 8;
    }
    else if (s.indexOf("MSIE") >= 0) {
        bi.name = "MSIE";
        k = s.indexOf("MSIE") + 5;
    }
    else {
        bi.name = "other";
        bi.version = 0;
        return;
    }
    bi.version = parseInt(s.substr(k));
}

function IsSupportedBrowser() {
    var bi = new BrowserInfo();
    GetBrowserInfo(bi);
    k = false;
    if (bi.name == "MSIE" && bi.version >= 6)
        k = true;
    if (bi.name == "Firefox" && bi.version >= 3)
        k = true;
    if (bi.name == "Safari" && bi.version >= 4)
        k = true;
    if (bi.name == "Chrome")
        k = true;
    return k;
}

//
// Browser-independent object access (NS4, IE5+, Mozilla)
//

function getDIV(id)
{
	try
	{
		if(document.all)
		{
			return document.all(id);
		}
		else if (document.getElementById)
		{
			return document.getElementById(id);
		}
		else if (document.layers)
		{
			var obj = document.layers.screen.document.layers[id];
			if(!obj)
			{
				obj = document.layers[id];
			}
			return obj;
		}
		return 0;
	}
	catch (error)
	{
		return (null);
	}
}

function getDIVstyle(id)
{
	try
	{
		if(document.all)
		{
			return (document.all(id).style);
		}
		else if (document.getElementById)
		{
			if (document.getElementById(id).style != null)
			{
				return (document.getElementById(id).style);
			}
		}
		else if (document.layers)
		{
			var obj = document.layers.screen.document.layers[id];
			if(!obj)
			{
				obj = document.layers[id];
			}
			return (obj);
		}
		return 0;
	}
	catch (error)
	{
		//alert ("##### ERROR #####:\n" + error + "\n\n##### CALLER #####" + getDIVstyle.caller);
		return (null);
	}
}

function shiftTo(id, x, y)
{
  var obj = getDIVstyle(id);
  if(obj.moveTo)
  {
    obj.moveTo(x,y);
  }
  else
  {
    obj.left = x + "px";
    obj.top = y + "px";
  }
}

/**
 * #####################
 * # START NEW CONTENT #
 * #####################
*/

function getUniWidth(id)
{
	try {
		var cObj = getDIV(id);
		var w;
		if (id.style.width)
		{
			w = parseInt(id.style.width);
		}
		else if (id.style.pixelWidth)
		{
			w = id.style.pixelWidth;
		}
		else if (id.offsetWidth)
		{
			w = id.offsetWidth;
		}
		else if (document.defaultView && document.defaultView.getComputedStyle)
		{
			w = document.defaultView.getComputedStyle(cObj ,'').getPropertyValue('width');
		}
		if (typeof w == "string")
		{
			w = parseInt(w);
		}
		return w;
	}
	catch (error)
	{
		return (null);
	}		
}

function getUniHeight(id)
{
	try {
		var cObj = getDIV(id);
		var w;
		if (id.style.height)
		{
			w = parseInt(id.style.height);
		}
		else if (id.style.pixelHeight)
		{
			w = id.style.pixelHeight;
		}
		else if (id.offsetHeight)
		{
			w = id.offsetHeight;
		}
		else if (document.defaultView && document.defaultView.getComputedStyle)
		{
			w = document.defaultView.getComputedStyle(cObj ,'').getPropertyValue('height');
		}
		if (typeof w == "string")
		{
			w = parseInt(w);
		}
		return w;
	}
	catch (error)
	{
		return (null);
	}
}

function getClientWidth(id)
{
	try {
		var cObj = getDIV(id);
		if (cObj.clientWidth)
		{
			return cObj.clientWidth
		}
		else
		{
			return parseInt(cObj.width);
		}
	}
	catch (error)
	{
		return id.offsetWidth;
	}
}

function getClientHeight(id)
{
	try {
		var cObj = getDIV(id);
		if (cObj.clientHeight)
		{
			return cObj.clientHeight
		}
		else
		{
			return parseInt(cObj.height);
		}
	}
	catch (error)
	{
		return id.offsetHeight;
	}
}

/**
 * ###################
 * # END NEW CONTENT #
 * ###################
*/

function getObjHeight(id)
{
  var obj = getDIV(id);
  if(obj.clip)
  {
    return obj.clip.height;
  }
  else
  {
    return obj.offsetHeight;
  }
}

function getObjWidth(id)
{
  var obj = getDIV(id);
  if(obj.clip)
  {
    return obj.clip.width;
  }
  else
  {
    return obj.offsetWidth;
  }
}

function getObjLeft(id)
{
	try
	{
		var obj = getDIVstyle(id);
		if(obj.pixelLeft)
		{
			return obj.pixelLeft;
		}
		else
		{
			return parseInt(obj.left);
		}
	}
	catch (error)
	{
		return parseInt(id.offsetLeft);
	}
}

function getObjTop(id)
{
	try
	{
		var obj = getDIVstyle(id);
		if(obj.pixelTop)
		{
			return obj.pixelTop;
		}
		else
		{
			return parseInt(obj.top);
		}
	}
	catch (error)
	{
		return parseInt(id.offsetTop);
	}
}


function getInsideWindowWidth()
{
  if(window.innerWidth)
  {
    return window.innerWidth;
  }
  else
  {
    return document.body.clientWidth;
  }
}

function getInsideWindowHeight()
{
  if(window.innerHeight)
  {
    return window.innerHeight;
  }
  else
  {
    return document.body.clientHeight;
  }
}

function getScrollLeft()
{
  if(window.pageXOffset || window.pageXOffset==0)
  {
    return window.pageXOffset;
  }
  else
  {
    return document.body.scrollLeft;
  }
}

function getScrollTop()
{
  if(window.pageYOffset || window.pageYOffset==0)
  {
    return window.pageYOffset;
  }
  else
  {
    return document.body.scrollTop;
  }
}

function show(id)
{
  var obj = getDIVstyle(id);
  obj.visibility = "visible";
}

function hide(id)
{
  var obj = getDIVstyle(id);
  obj.visibility = "hidden";
}

