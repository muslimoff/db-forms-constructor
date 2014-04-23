/*--
Copyright © 1998, 2009, Oracle and/or its affiliates.  All rights reserved.
--*/
//
// Browser-independent object access (NS4, IE5+, Mozilla)
//

function IsMozilla()
{
	return (window.navigator.appName=="Netscape");
}

function IsSafari()
{
	if (!IsMozilla())
		return false;
	s=window.navigator.userAgent;
	k=(s.indexOf("Safari")>=0);
	return k;
}

function Get_Element(id)
{
  if(document.all)
    return document.all(id);
  else if(document.getElementById)
    return document.getElementById(id);
  else if(document.layers)
  {
    var obj = document.layers.screen.document.layers[id]
    if(!obj)
      obj = document.layers[id]
    return obj
  }
  return 0;
}

function Get_Element_Style(id)
{
  if(document.all)
    return document.all(id).style;
  else if(document.getElementById)
    return document.getElementById(id).style;
  else if(document.layers)
  {
    var obj = document.layers.screen.document.layers[id]
    if(!obj)
      obj = document.layers[id]
    return obj
  }
  return 0;
}

function Shift_Element_To(id, x, y)
{
  var obj = Get_Element_Style(id)
  if(obj.moveTo)
  {
    obj.moveTo(x,y)
  }
  else
  {
    obj.left = x + "px"
    obj.top = y + "px"
  }
}

function Get_Element_Height(id)
{
  var obj = Get_Element(id)
  if(obj.clip)
  {
    return obj.clip.height
  }
  else
  {
    return obj.offsetHeight
  }
}

function Get_Element_Width(id)
{
  var obj = Get_Element(id)
  if(obj.clip)
  {
    return obj.clip.width
  }
  else
  {
    return obj.offsetWidth
  }
}

function Get_Element_Left(id)
{
  var el = Get_Element(id);
  if (el.offsetLeft!=null)
  {
	var ol = el.offsetLeft;
	while ((el = el.offsetParent) != null)
		ol += el.offsetLeft;
	return ol;
  }
  
  var obj = Get_Element_Style(id)
  if(obj.pixelLeft)
  {
    return obj.pixelLeft
  }
  else
  {
    return parseInt(obj.left)
  }
}

function Get_Element_Top(id)
{
  var el = Get_Element(id);
  if (el.offsetTop!=null)
  {
	var ot = el.offsetTop;
	while ((el = el.offsetParent) != null)
		ot += el.offsetTop;
	return ot;
  }

  var obj = Get_Element_Style(id)
  if(obj.pixelTop)
  {
    return obj.pixelTop
  }
  else
  {
    return parseInt(obj.top)
  }
}


function Get_InsideWindowWidth()
{
  if(window.innerWidth)
  {
    return window.innerWidth
  }
  else
  {
    return document.body.clientWidth
  }
}

function Get_InsideWindowHeight()
{
  if(window.innerHeight)
  {
    return window.innerHeight
  }
  else
  {
    return document.body.clientHeight
  }
}

function Get_ScrollLeft()
{
  if(window.pageXOffset || window.pageXOffset==0)
  {
    return window.pageXOffset
  }
  else
  {
    return document.body.scrollLeft
  }
}

function Get_ScrollTop()
{
  if(window.pageYOffset || window.pageYOffset==0)
  {
    return window.pageYOffset
  }
  else
  {
    return document.body.scrollTop
  }
}

function Show_Element(id)
{
  var obj = Get_Element_Style(id)
  obj.visibility = "visible"
}

function Hide_Element(id)
{
  var obj = Get_Element_Style(id)
  obj.visibility = "hidden"
}

