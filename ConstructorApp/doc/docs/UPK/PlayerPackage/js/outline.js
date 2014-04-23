/*--
Copyright © 1998, 2009, Oracle and/or its affiliates.  All rights reserved.
--*/

var allLastSelected="";
var filteredLastSelected="";
var hemiLastSelected="";
var lastModeSelected="ALL";

var topicDescriptorCache=new Array();
var jumpInArray=new Array();

function TopicDescriptor(playmodes,jumpinarray,leadin,concept)
{
	this.playmodes=playmodes;
	this.jumpinarray=jumpinarray;
	this.leadin=leadin;
	this.concept=concept;
}

function JumpInPoint(label,frame)
{
	this.label=label;
	this.frame=frame;
}

var myrows="";

function ShowRightPanels(concept,leadin)
{
	myframeset=document.all["internalframeset2"];
	if (myrows.length==0)
		myrows=myframeset.rows;
	loc=frames["introduction"].frames["leadin"].location.href;
	kold=loc.indexOf("empty.html");
	knew=leadin.indexOf("empty.html");
	if (kold<0)
	{
		myrows=myframeset.rows;
	}
	if (knew>=0)	// one pane
	{
		myframeset.rows="100%,*";
		myframeset.frameBorder="no";
		myframeset.frameSpacing="0";
	}
	else		// two panes
	{
		myframeset.rows=myrows;
		myframeset.frameBorder="yes";
		myframeset.frameSpacing="16";
	}
	try
	{
		frames["concept"].frames["concept"].location.replace(concept);
	}
	catch (e) {};
	frames["introduction"].frames["leadin"].location.replace(leadin);
}

function EmptySelected()
{
	ShowRightPanels("../toc/empty.html","../toc/empty.html");
}

function TreeItemSelected(id,mode)
{
	if (frames.outlineheader.setButtonsStatus)
	{
		lastModeSelected=mode;
		if (id=="NEW")
		{
			SetLastSelected("",mode);		
		}
		else if (id=="LAST")
		{
			id=GetLastSelected(mode);
		}
		else
		{
			SetLastSelected(id,mode);
		}	

		if (id==null)
			return;
		if (id=="")
			return;
		if (id=="NEW")
		{
			frames.outlineheader.setButtonsStatus("",new Array());
			EmptySelected();
			return;
		}
		if (topicDescriptorCache[id])
		{
			Refresh(id);
		}
		else
		{
			var s="../tpc/"+id.substr(0,36)+"/descriptor.xml";
			LoadXMLDoc(s,"TreeItemSelected_Returned_Descriptor","",id.substr(0,36));
		}
	}
	else
	{
		setTimeout("TreeItemSelected('"+id+"','"+mode+"')",100);
	}
}

function TreeItemSelected_Returned_Descriptor(req,id)
{
	var playmodes="";
	nodes=req.responseXML.getElementsByTagName("PlayModes");
	if (nodes.length>0)
	{	
		n=nodes[0];
		if (n.textContent!=null)
			playmodes=n.textContent;
		else if (n.text!=null)
			playmodes=n.text;
		else if (n.firstChild.data!=null)
			playmodes=n.firstChild.data;
	}
	jumpInArray=new Array();
	nodes=req.responseXML.getElementsByTagName("JumpIn");
	for (var i=0;i<nodes.length;i++)
	{
		n=nodes[i];
		if (n.textContent)
			label=n.textContent;
		else if (n.text)
			label=n.text;
		else if (n.firstChild.data)
			label=n.firstChild.data;
		a=n.attributes[0];
		frameid=a.nodeValue;
		jumpInArray[jumpInArray.length]=new JumpInPoint(label,frameid);
	}
	_leadIn="../toc/empty.html";
	nodes=req.responseXML.getElementsByTagName("Leadin");
	if (nodes.length>0)
	{
		_leadIn="../tpc/"+id+"/leadin.html";
	}
	_concept="../toc/empty.html";
	nodes=req.responseXML.getElementsByTagName("Concept");
	if (nodes.length>0)
	{
		n=nodes[0];
		if (n.textContent)
			_concept=n.textContent;
		else if (n.text)
			_concept=n.text;
		else if (n.firstChild.data)
			_concept=n.firstChild.data;
	}
	topicDescriptorCache[id]=new TopicDescriptor(playmodes,jumpInArray,_leadIn,_concept);
	Refresh(id);
}

function Refresh(id)
{
	frames.outlineheader.setButtonsStatus(topicDescriptorCache[id].playmodes,
											topicDescriptorCache[id].jumpinarray);
	ShowRightPanels(topicDescriptorCache[id].concept,topicDescriptorCache[id].leadin);
}

function SetLastSelected(id, mode)
{
	if (mode=="ALL")
		allLastSelected=id;
	else if (mode=="FILTERED")
		filteredLastSelected=id;
	else
		hemiLastSelected=id;
}

function GetLastSelected(mode)
{
	if (!mode)
		mode=lastModeSelected;
	if (mode=="ALL")
		return allLastSelected;
	else if (mode=="FILTERED")
		return filteredLastSelected;
	else
		return hemiLastSelected;
}
