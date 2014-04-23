/*--
Copyright © 1998, 2009, Oracle and/or its affiliates.  All rights reserved.
--*/

//////////////////////////////////////////////////////////////////////////////
// Simple function for load XML file by HTTPRequest
// Parameters:
//	url				url of xml file
//	workerFunction	name of callback function will be called with request in the following form:
//					workerFunction(req,extraInfo);
//	extraInfo		extra information for user will be give back with callback function

var _workerFunction="";
var _errorFunction="";
var _extraInfo="";
var _req;
var _url;

function AbsUrl(url)
{
	for (var i=0;i<url.length;i++)
	{
		c=url.substr(i,1);
		if (c==':')
			return url;
	}
	base=window.location.href;

    var k1=base.indexOf('?');
    var k2=base.indexOf('#');
    if (k1>=0 || k2>=0)
    {
        if (k1>=0 && k2>=0)
        {
            base=base.substr(0,(k1<k2 ? k1 : k2));
        }
        else if (k1>=0)
        {
            base=base.substr(0,k1);
        }
        else
        {
            base=base.substr(0,k2);
        }
    }
	
	if (url.substr(0,3)=="../")
	{
		var k=base.lastIndexOf('/');
		base=base.substr(0,k);
		while (url.substr(0,3)=="../")
		{
			k=base.lastIndexOf('/');
			base=base.substr(0,k);
			url=url.substr(3);
		}
		base=base+"/"+url;
	}
	else
	{
		k=base.lastIndexOf('/');
		base=base.substr(0,k);
		base=base+"/"+url;
	}
	return(base);
}

function LoadXMLDoc(url,workerFunction,errorFunction,extraInfo)
{
	_workerFunction=workerFunction;
	_errorFunction=errorFunction;
	_extraInfo=extraInfo;
	_url=AbsUrl(url);
	// code for Mozilla, etc.
	if (window.XMLHttpRequest)
	{
		_req=new XMLHttpRequest();
		_req.onreadystatechange=state_Change;
		_req.open("GET",_url,true);
		_req.send(null);
	}
	// code for IE
	else if (window.ActiveXObject)
	{
		_req=new ActiveXObject("Microsoft.XMLHTTP");
		if (_req)
		{
			_req.onreadystatechange=state_Change;
			_req.open("GET",_url,true);
			_req.send();
		}
	}
}

function state_Change()
{
	if (_req.readyState==4)
	{
		if (_req.status==200)
		{
			eval(_workerFunction+"(_req,_extraInfo)");
		}
		else
		{
			if (_url.substr(0,3)=="../")
			{
				LoadXMLDoc(_url.substr(3),_workerFunction,_errorFunction,_extraInfo);
			}
			else if (_errorFunction.length>0)
			{
				alert(_url+" not found. Logged...");
				eval(_errorFunction+"(_extraInfo)");
			}
			else
				alert("Problem retrieving data: "+ _req.statusText);
		}
	}
}

//////////////////////////////////////////////////////////////////////////////
// Function to load XML files contain simple arrays
// Parameters:
//	url				url of xml file
//	returnFunction	function will be call back with a simple array loaded from xml file
//	nodeName		name of node for load

var _returnFunction="";
var _nodes;
var _nodesArray=new Array();

function LoadXMLDocArray(url,returnFunction,errorFunction,nodeName,xmlmode)
{
	_returnFunction=returnFunction;
	_nodeName=nodeName;
	if (!xmlmode)
		LoadXMLDoc(url,"XMLDocArrayWorker",errorFunction,nodeName);
	else
		LoadXMLDoc(url,"XMLDocArrayWorker2",errorFunction,nodeName);
}

function XMLDocArrayWorker(req,extraInfo)
{
	_nodesArray=new Array();
	_nodes=req.responseXML.getElementsByTagName(extraInfo);
	for (var i=0;i<_nodes.length;i++)
	{
		n=_nodes[i];
		s=(n.textContent ? n.textContent : n.text);
		if (!s)
			s="";
		k=s.length;
		if (k>=2)
		{
			if ((s.substr(0,1)=='\"') && (s.substr(k-1,1)=='\"'))
			{
				ss=s.substr(1,k-2);
				s=ss;
			}
		}
		_nodesArray[_nodesArray.length]=s;
	}
	sfn=_returnFunction+"(_nodesArray)";
	setTimeout(sfn,1);
}

function XMLDocArrayWorker2(req,extraInfo)
{
	_nodesArray=new Array();
	_nodes=req.responseXML.getElementsByTagName(extraInfo);
	for (var i=0;i<_nodes.length;i++)
	{
		n=_nodes[i];
		xmlname=n.attributes[0].nodeValue;
		xmltext="";
		for (var j=0;j<n.childNodes.length;j++)
		{
			if(n.childNodes[j].xml) {
				xmltext += n.childNodes[j].xml;
			} else {
				var oSerializer = new XMLSerializer;
				xmltext += oSerializer.serializeToString(n.childNodes[j]);
			}
		}
		_nodesArray[_nodesArray.length]=xmlname+"="+xmltext;
	}
	sfn=_returnFunction+"(_nodesArray)";
	setTimeout(sfn,1);
}

