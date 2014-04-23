/*--
Copyright © 1998, 2009, Oracle and/or its affiliates.  All rights reserved.
--*/

var AutoExpandLimit=100;
var SearchResultLimit=200;

// common variables

var treeControlDB=false;

function ModeDesc(k)
{
	this.treeCreated = false;
	this.lastSelected = null;
	this.filteredGuids = new Array();
	this.filteredGuidList = new Array();
	this.filteredTopicCount = 0;
	this.guidsForFlat = new Array();
	this.lastSelectedFlat = null;
	this.flatMode = false;
	this.modeLetter=k;
	this.treeControl=null;
	this.flatControl=null;
}

var modeDescA = new ModeDesc("A");
var modeDescF = new ModeDesc("F");
var modeDescH = new ModeDesc("H");
var modeDescFH = new ModeDesc("X");

var treeViewMode="ALL";				// view mode ("ALL" or "FILTERED" or "HEMI" or "FILTEREDHEMI")
var treeIsEmpty;

function GetJunctionId(s)
{
	k=s.indexOf('_');
	kk=s.indexOf('_',k+1)
	ss=s.substr(0,kk);
	return ss;
}

////////////////////////////////////
// filtering support

var filteredGuidsR=new Array();	// associative array contains all guid to show
var filteredTopicCountR=0;		// number of filtered topics (ROLES)
var rolefilter_enabled=false;

var selection_need=0;
var stl_mode="ALL";
var stl_callback="";
var stl_myTopicArray=new Array();
var stl_myscoresArray=new Array();
var stl_i=0;
var stl_topicMapId=-1;
var stl_newtMap=false;
var stl_topicMapPageLen=-1;
var global_topicMap=new Array();

var _lastChangeIsFilterOnly=false;

function SetTopicList(mode, topicarray, callbackfn)
{
	stl_mode=mode;
	stl_callback=callbackfn;
	_lastChangeIsFilterOnly=false;
	if (mode=="FILTERED")
	{
		modeDescF.filteredGuids=new Array();
		modeDescF.filteredGuidList=new Array();
		modeDescF.filteredTopicCount=topicarray.length;
		modeDescF.guidsForFlat=new Array();
		modeDescF.flatMode=true;
	}
	else if (mode=="HEMI")
	{
		modeDescH.filteredGuids=new Array();
		modeDescH.filteredGuidList=new Array();
		modeDescH.filteredTopicCount=topicarray.length;
		modeDescH.guidsForFlat=new Array();
		modeDescH.flatMode=true;
	}
	else if (mode=="ROLES")
	{
		filteredGuidsR=new Array();
		filteredTopicCountR=topicarray.length;
		rolefilter_enabled=true;
		_lastChangeIsFilterOnly=true;
	}
	else	// "NOROLES"
	{
		rolefilter_enabled=false;
		_lastChangeIsFilterOnly=true;
		eval(stl_callback+"()");
		return;
	}
	stl_myTopicArray=new Array();
	stl_myTopicArray=topicarray;
	stl_myscoresArray=new Array();
	if (topicarray.length>0)
	{
	    try
	    {
    	    var a=topicarray[0].index;
    	    if (a)
    	    {
        	    stl_myTopicArray=new Array();
        	    for (var i=0;i<topicarray.length;i++)
        	    {
        	        stl_myTopicArray[stl_myTopicArray.length]=topicarray[i].index;
        	        stl_myscoresArray[topicarray[i].index]=topicarray[i].score;
         	    }
            }
    	}
    	catch(e)
    	{
    	}
	}
	stl_i=0;
	if (stl_topicMapPageLen==-1)
		SetTopicList_LoadPageLen();
	else
		SetTopicList_Next();
}

function SetTopicList_LoadPageLen()
{
	LoadXMLDocArray("../querydb/topicmap/0.xml","SetTopicList_LoadPageLen_Return","","T");
}

function SetTopicList_LoadPageLen_Return(retArray)
{
	stl_topicMapPageLen=parseInt(retArray[0]);
	SetTopicList_Next();
}

function SetTopicList_Next()
{
	fTC=modeDescF.filteredTopicCount;
	if (stl_mode=="HEMI")
		fTC=modeDescH.filteredTopicCount;
	if (stl_mode=="ROLES")
		fTC=filteredTopicCountR;
	if (!(stl_i<fTC))
	{
		eval(stl_callback+"()");
		return;
	}
	j=stl_myTopicArray[stl_i];
	a=Math.floor((j-1)/stl_topicMapPageLen);
	if (!global_topicMap[""+a])
	{
		stl_topicMapId=a;
		stl_newtMap=true;
		LoadXMLDocArray("../querydb/topicmap/"+a+".xml","SetTopicList_Next2","","T");
	}
	else
	{
		stl_topicMapId=a;
		stl_newtMap=false;
		setTimeout("SetTopicList_Next2()",1);
	}
}

function DecodeTMapArray(tmapArray)
{
	var newArray=new Array();
	var fullstr="";
	for (var i=0;i<tmapArray.length;i++)
	{
		if (i==0)
		{
			newArray[newArray.length]=tmapArray[i];
		}
		else
		{
			var s = { s : tmapArray[i], p : 0 };
			l = ReadBase64_32(s);
			str=fullstr.substr(0,l)+s.s.substr(s.p,s.s.length);
			fullstr=str;
			newArray[newArray.length]=str;
		}
	}
	return newArray;
}

function ItemDesc(type, title)
{
	this.type=type;
	this.title=title;
	this.found=false;
	this.parentguid=null;
	this.openable=new Array();
	this.treeitemdiv=null;
}

function AddItemdesc(o,array,ss,type,title,found,topicguid,parentguid)
{
	l=false;
	try
	{
		l=array[ss].title.length>0;
	}
	catch(e){};
	if (!l)
	{
		array[ss]=new ItemDesc(type,title);
		if (o)
    		o.filteredGuidList[o.filteredGuidList.length]=ss;
	}
	array[ss].parentguid=parentguid;
	if (found==true)
		array[ss].found=true;
	if (topicguid.length>0)
		array[ss].openable[array[ss].openable.length]=topicguid;
}

function AddTreeItemToItemDesc(guid,itemdiv)
{
	md=getModeDesc();
	try
	{
		if (treeViewMode=="FILTEREDHEMI")
		{
			if (!md.filteredGuids)
				md.filteredGuids=new Array();
			if (!md.filteredGuids[guid])
			{
				md.filteredGuids[guid]=new ItemDesc("","");
				md.filteredGuidList[md.filteredGuidList.length]=guid;
            }
		}
		md.filteredGuids[guid].treeitemdiv=itemdiv;
	}
	catch(e){};
    saveModeDesc(md);
}

function GetTreeItemOfItemDesc(guid)
{
	md=getModeDesc();
	var _item=null;
	try
	{
		_item=md.filteredGuids[guid].treeitemdiv;
	}
	catch(e){};
	return _item;
}

function FlatItemDesc(type, title, guid,isroot,score)
{
	this.type=type;
	this.title=title;
	this.guid=guid;
	this.isroot=isroot;
	if (!score)
	    score=0;
	this.score=score;
}

function AddFlatItemdesc(array,guid,type,title,isroot,score)
{
    for (var i=0;i<array.length;i++)
    {
        if (array[i].guid==guid)
            return;
    }
	array[array.length]=new FlatItemDesc(type,title,guid,isroot,score);
}

function SetTopicList_Next2(tmapArray)
{
	if (stl_newtMap)
	{
		global_topicMap[""+stl_topicMapId]=DecodeTMapArray(tmapArray);
	}
	j=stl_myTopicArray[stl_i];
	a=Math.floor((j-1)/stl_topicMapPageLen);
	s=global_topicMap[""+stl_topicMapId][j-(a*stl_topicMapPageLen)];
	k=s.indexOf('#');
	s1=s.substr(0,k);
	_tguid=s1;	
	kk=s1.lastIndexOf('/')
	if (kk>0)
		_tguid=s1.substr(kk+1);
	
	var _isroot=(kk<0);
	var _concept=(s.substr(k+1,1)=='C');
	var _empty=(s.substr(k+1,1)=='E');
	
	var rbs = { s : s.substr(k+3), p : 0};
	l=ReadBase64_32(rbs);
	s2=rbs.s.substr(rbs.p+l);
	title=rbs.s.substr(rbs.p,l);
	type=s2;
	k=s2.indexOf('#');
	if (k>=0)
	{
		type=s2.substr(0,k);
		s4=s2.substr(k);
		s2=s4;
	}
	else
	{
		s2="";
	}
	s=s1+s2;
	k=s.indexOf('/');
	var _pguid=null;
	
	if (type=='Topic' || _concept==true)
	{
    	while (k>=0)
    	{
    		ss=""+s.substr(0,k);
    		if (stl_mode=="FILTERED")
    		{
//  			filteredGuidsF[ss]=itemdesc;
//  			filteredGuidsF[ss.substr(0,36)]=itemdesc;
    			AddItemdesc(modeDescF,modeDescF.filteredGuids,ss,type,title,false,_tguid,_pguid);
    			AddItemdesc(modeDescF,modeDescF.filteredGuids,ss.substr(0,36),type,title,false,_tguid,_pguid);
    		}
    		else if (stl_mode=="HEMI")
    		{
//  			filteredGuidsH[ss]=itemdesc;
    			AddItemdesc(modeDescH,modeDescH.filteredGuids,ss,type,title,false,_tguid,_pguid);
          		AddItemdesc(modeDescH,modeDescH.filteredGuids,ss.substr(0,36),type,title,false,_tguid,_pguid);
    		}
    		else	// "ROLES"
    		{
//  			filteredGuidsR[ss]=itemdesc;
    			AddItemdesc(null,filteredGuidsR,ss,type,title,false,_tguid,null);
    		}
    		_pguid=ss;
    		ss=s.substr(k+1);
    		s=ss;
    		k=s.indexOf('/');
    	}
    	if (s.length>0)
    	{
    		ss=s;
    		k=s.indexOf('#');
    		if (k>0)
    			ss=s.substr(0,k);
    		if (stl_mode=="FILTERED")
    		{
//  			filteredGuidsF[ss]=itemdesc;
    			AddItemdesc(modeDescF,modeDescF.filteredGuids,ss,type,title,true,"",_pguid);
    			AddFlatItemdesc(modeDescF.guidsForFlat,ss,type,title,_isroot);
    		}
    		else if (stl_mode=="HEMI")
    		{
//  			filteredGuidsH[ss]=itemdesc;
    			AddItemdesc(modeDescH,modeDescH.filteredGuids,ss,type,title,true,"",_pguid);
    			_score=stl_myscoresArray[stl_myTopicArray[stl_i]];
    			AddFlatItemdesc(modeDescH.guidsForFlat,ss,type,title,_isroot,_score);
    		}
    		else
    		{
//  			filteredGuidsR[ss]=itemdesc;
    			AddItemdesc(null,filteredGuidsR,ss,type,title,true,"",null);
    		}
    	}
    }
	stl_i++;
	SetTopicList_Next();
}

//////////////////////////////////////////////////////////////////////////////

function TreeViewModeLetter()
{
	if (treeViewMode=="FILTEREDHEMI")
		return "X";
	return treeViewMode.substr(0,1);
}

function IsFiltered(guid,tMode) // true if the guid must be show
{
	var k;
	l=0;
	try
	{
		l=filteredGuidsR[guid].title.length;
	}
	catch(e){};
	
	roles=0;	//not enabled
	if (rolefilter_enabled)
	{
		roles=( l>0 ? 1 : 2 );	// 1 -> found, 2 -> not found
	}

	if (tMode=="ALL")
	{
        if (roles == 0) {
            treeIsEmpty = false;
            return true;
        }
        else if (roles == 1) {
            l = false;
            try {
                l = (filteredGuidsR[guid].openable.length>0 || filteredGuidsR[guid].found);
            }
            catch (e) { };
            if (l == true)
                treeIsEmpty = false;
            return l;
        }
        else {
            return false;
        }
		
		
	}
	else if (tMode=="FILTERED")
	{
		l=0;
		try
		{
			l=modeDescF.filteredGuids[guid].title.length;
		}
		catch(e){};
		if (l==0)
			return false;

		if (roles==0)
		{
			treeIsEmpty=false;
			return true;
		}
		else if (roles==1)
		{
			l=false;
			try
			{
				l=Cut(modeDescF.filteredGuids[guid].openable,filteredGuidsR[guid].openable) || 
							(modeDescF.filteredGuids[guid].found && filteredGuidsR[guid].found);
			}
			catch(e){};
			if (l==true)
				treeIsEmpty=false;
			return l;
		}
		else
		{
			return false;
		}
	}
	else if (tMode=="HEMI")
	{
		l=0;
		try
		{
			l=modeDescH.filteredGuids[guid].title.length;
		}
		catch(e){};
		if (l==0)
			return false;

		if (roles==0)
		{
			treeIsEmpty=false;
			return true;
		}
		else if (roles==1)
		{
			l=false;
			try
			{
				l=Cut(modeDescH.filteredGuids[guid].openable,filteredGuidsR[guid].openable) || 
							(modeDescH.filteredGuids[guid].found && filteredGuidsR[guid].found);
			}
			catch(e){};
			if (l==true)
				treeIsEmpty=false;
			return l;
		}
		else
		{
			return false;
		}
	}
	else	// FILTEREDHEMI
	{
		if (roles==0)
		{
			l=false;
			try
			{
				l=Cut(modeDescF.filteredGuids[guid].openable,modeDescH.filteredGuids[guid].openable) || 
							(modeDescF.filteredGuids[guid].found && modeDescH.filteredGuids[guid].found);
			}
			catch(e){};
			if (l)
				treeIsEmpty=false;
			return l;
		}
		else if (roles==1)
		{
			l=false;
			try
			{
				l=Cut3(modeDescF.filteredGuids[guid].openable,modeDescH.filteredGuids[guid].openable,filteredGuidsR[guid].openable) || 
							(modeDescF.filteredGuids[guid].found && modeDescH.filteredGuids[guid].found && filteredGuidsR[guid].found);
			}
			catch(e){};
			if (l)
				treeIsEmpty=false;
			return l;
		
		}
		else
		{
			return false;
		}
	}
}

function Cut(array1,array2)
{
	if (array2==null)
	{
		return array1.length>0;
	}
	for (var i=0;i<array1.length;i++)
	{
		for (var j=0;j<array2.length;j++)
		{
			if (array1[i]==array2[j])
				return true;
		}
	}
	return false;
}

function Cut3(array1,array2,array3)
{
	if (array3==null)
		return Cut(array1,array2);
	for (var i=0;i<array1.length;i++)
	{
		for (var j=0;j<array2.length;j++)
		{
			for (var k=0;k<array3.length;k++)
			{
				if (array1[i]==array2[j] && array2[j]==array3[k])
					return true;
			}
		}
	}
	return false;
}

function IsOpenable(guid)
{
	var roleArray=null;
	if (rolefilter_enabled==true)
	{
		roleArray=filteredGuidsR[guid].openable;
	}	    

	if (treeViewMode=="ALL") {
	    if (rolefilter_enabled) {
	        l=false;
	        try {
	            l = roleArray.length > 0;
	        } catch (e) { };
	        return l;
	    }
   		return true;
	}
	else if (treeViewMode=="FILTERED")
	{
		l=true;
		try
		{
			l=Cut(modeDescF.filteredGuids[guid].openable,roleArray);
		}
		catch(e){};
		return l;
	}
	else if (treeViewMode=="HEMI")
	{
		l=true;
		try
		{
			l=Cut(modeDescH.filteredGuids[guid].openable,roleArray);
		}
		catch(e){};
		return l;
	}
	else		// FILTEREDHEMI
	{
		l=Cut3(modeDescF.filteredGuids[guid].openable,modeDescH.filteredGuids[guid].openable,roleArray);
		return l;
	}
	return true;
}

function IsAutoExpand()	// true if the tree must be appear expanded
{
	if (treeViewMode=="ALL")
		return false;
	else if (treeViewMode=="FILTERED")
		return (modeDescF.filteredTopicCount<AutoExpandLimit)
	else if (treeViewMode=="FILTEREDHEMI")
		return (modeDescF.filteredTopicCount<AutoExpandLimit)
	else	//"HEMI"
		return (modeDescH.filteredTopicCount<AutoExpandLimit)
}

////////////////////////////////////
// delayed tree load support

var treeLoadQueue=new Array();
var treeLoadQueueDivs=new Array();
var treeLoadQueuePtr=0;

function Queue_Init()	// init queue internal variables
{
	treeLoadQueue=new Array();
	treeLoadQueueDivs=new Array();
	treeLoadQueuePtr=0
}

function Queue_Add(s,div)	// add section html file to queue
{
	treeLoadQueue[treeLoadQueue.length]=s;
	treeLoadQueueDivs[treeLoadQueueDivs.length]=div;
}

function Queue_Next(t)	// load next section html file
{
	if (treeLoadQueuePtr<treeLoadQueue.length)
	{
		t.LoadScript(treeLoadQueue[treeLoadQueuePtr],treeLoadQueueDivs[treeLoadQueuePtr]);
		treeLoadQueuePtr++;
	}
	else
	{
		if (selection_need>0)
		{
		    var sel=false;
		    if (_lastSelectedGlobal.length>0)
		    {
		        if (rolefilter_enabled==true)
		        {
	                l=0;
	                try
	                {
		                l=filteredGuidsR[_lastSelectedGlobal].title.length;
	                }
	                catch(e){};
	                if (l>0)
	                {
                        sel=true;
	                }
		        }
		        else
		        {
		            sel=true;
		        }
		    }

            if (sel==true)
            {
                selection_need=0;
        	    if (ChangeTreeView_CallBack()==true)
            	    return;
            }
		    t.SelectFirstItem();
		}
		if (parent.TreeFinished)
		{
			parent.TreeFinished(treeViewMode,treeIsEmpty);
		}
//		if (parent.selector.SearchEnable)
//		{
//			setTimeout("parent.selector.SearchEnable()",100);
//		}
//		else
//		{
//			setTimeout("parent.selector.SearchEnable()",500);
//		}
	}
}

function SelectionCallBack(_item)
{
	var t;
	md=getModeDesc();
	switch (treeViewMode)
	{
		case "ALL": 
		                if (_lastSelectedItem!=null)
		                {
		                    if (_lastSelectedItem.startAction==true)
		                    {
		                        _lastSelectedItem.startAction=false;
		                    }            
		                    else
		                    {                   
        		                _lastSelectedItem.startAction=true;
                        	    ChangeTreeView_CallBack()
						        return;
						    }
						}
					    t= ( _item==null ? md.lastSelected : _item );						   
						break;
		default: 
		                if (md.flatMode==true)
		                {
		                    SetFlatSelection();
		                    return;
		                }       
						t= ( (md.flatMode==true) ? md.lastSelectedFlat : ( _item==null ? md.lastSelected : _item ));
						break;
	}
	
	if (t==null)
	{
		if (parent.TreeItemSelected)
			parent.TreeItemSelected(null,null);
		return;
	};
	var tpc = t.getAttribute("tpc");
	if (tpc==null)
		tpc = t.parentNode.getAttribute("tpc");
	if (tpc==null)
		tpc = t.parentNode.parentNode.getAttribute("tpc");
	if (md.flatMode==false)
	{
		ChangeSelection(t);
		window.scrollTo(0,(t.parentNode.offsetTop/2)+10);
	}
	if (tpc!=null)
    	SetLastSelected(tpc,treeViewMode);
	if (parent.TreeItemSelected)
		parent.TreeItemSelected(tpc,treeViewMode);
}

function ClearDescriptor(md,fm)
{
	md.treeCreated=true;
	md.lastSelected=null;
	md.lastSelectedFlat=null;
//	if (_lastChangeIsFilterOnly==false)
    	md.flatMode=fm;
	for (var i=0;i<md.filteredGuidList.length;i++)
	{
	    s=md.filteredGuidList[i];
	    md.filteredGuids[s].treeitem=null;
	    md.filteredGuids[s].treeitemdiv=null;
	}
}

function LastSelectedItem(guid, mode)
{
    this.guid=guid;
    this.mode=mode;
    this.startAction=false;
    this.firsdBuild=false;
}

var _lastSelectedItem=null;
var _lastSelectedGlobal="";
var _lastSelectedGlobalMode="";

function SetLastSelected(guid,mode)
{
    _lastSelectedGlobal=guid;
    _lastSelectedGlobalMode=mode;
    if (treeViewMode=="ALL")
        return;
    _lastSelectedItem=new LastSelectedItem(guid,mode);
}

function GetTpcAttribute(obj)
{
    var tpc=null;
    while (tpc==null)
    {
			try
			{
				tpc=obj.getAttribute("tpc");
			}
			catch(e)
			{
				return null;
			}	
        if (tpc==null)
            obj=obj.parentNode;
    }
    return tpc;
}

function createTreeControl(rootData,flatmode,_item)
{
	fm=(flatmode==true ? true : false);
	selection_need=1;
	if (treeViewMode=="ALL")
	{
		if (modeDescA.treeCreated==true)
		{
			SelectionCallBack(_item);
			return;
		}
        ClearDescriptor(modeDescA,false);
		if (_lastSelectedItem!=null)
		{
		    _lastSelectedItem.startAction=true;
		    _lastSelectedItem.firstBuild=true;
		}
		else
		{
	        selection_need=2;
	    }
	}
	else if (treeViewMode=="FILTERED")
	{
		if (modeDescF.treeCreated==true)
		{
//			if (fm==true && _lastChangeIsFilterOnly==false)
//				modeDescF.flatMode=true;
			modeDescF.flatMode=fm;
			SelectionCallBack(_item);
			return;
		}
		ClearDescriptor(modeDescF,fm);
	}
	else if (treeViewMode=="FILTEREDHEMI")
	{
		if (modeDescFH.treeCreated==true)
		{
//			if (fm==true && _lastChangeIsFilterOnly==false)
//				modeDescFH.flatMode=true;
			modeDescFH.flatMode=fm;
			SelectionCallBack(_item);
			return;
		}
		ClearDescriptor(modeDescFH,fm);
	}
	else	//"HEMI"
	{
		if (modeDescH.treeCreated==true)
		{
//			if (fm==true && _lastChangeIsFilterOnly==false)
//				modeDescH.flatMode=true;
			modeDescH.flatMode=fm;
			SelectionCallBack(_item);
			return;
		}
		ClearDescriptor(modeDescH,fm);
	}
	treeIsEmpty=true;
	if (treeViewMode=="ALL")
		treeControl = new TreeControl(document.getElementById("treeControlHostForAll"), rootData);
	else if (treeViewMode=="FILTERED")
	{
		treeControl = new TreeControl(document.getElementById("treeControlHostForFiltered"), rootData);
		modeDescF.flatControl = new FlatControl("flatControlHostForFiltered");
		modeDescF.flatControl.Load();
		selection_need=( modeDescF.flatMode==true ? 0 : 1 );
	}
	else if (treeViewMode=="FILTEREDHEMI")
	{
		treeControl = new TreeControl(document.getElementById("treeControlHostForFilteredHemi"), rootData);
		modeDescFH.flatControl = new FlatControl("flatControlHostForFilteredHemi");
		modeDescFH.flatControl.Load();
		selection_need=( modeDescFH.flatMode==true ? 0 : 1 );
	}
	else	//"HEMI"
	{
		treeControl = new TreeControl(document.getElementById("treeControlHostForHemi"), rootData);
		modeDescH.flatControl = new FlatControl("flatControlHostForHemi");
		modeDescH.flatControl.Load();
		selection_need=( modeDescH.flatMode==true ? 0 : 1 );
	}
	Queue_Init();
	
	treeControl.LoadScript(treeControl.rootData + ".html", treeControl.treeHost.id);
}

function TreeControl(host, rootData)
{
	this.host = host;
	this.rootData = rootData;

	host.innerHTML="";
	this.treeHost = document.createElement("div");
	this.treeHost.id = rootData + "_" + TreeViewModeLetter();
	this.treeHost.className = "treeControlNode";
	this.treeHost.onclick = this.OnClick;
	this.treeHost.onmouseup = this.OnMouseUp;
	this.treeHost.ondblclick = this.OnDoubleClick;
	this.host.appendChild(this.treeHost);

	if (treeViewMode=="ALL")
		this.loader=document.getElementById("treeControlDataForAll");
	else if (treeViewMode=="FILTERED")
		this.loader=document.getElementById("treeControlDataForFiltered");
	else if (treeViewMode=="FILTEREDHEMI")
		this.loader=document.getElementById("treeControlDataForFilteredHemi");
	else	//"HEMI"
		this.loader=document.getElementById("treeControlDataForHemi");
	this.loader.className = "treeControlData";

	var imagesToCache = new Array(
		"module_c.gif", "module_o.gif", "outl_f.gif", "outl_fc.gif", "outl_fo.gif", "outl_l.gif",
		"outl_lc.gif", "outl_lo.gif", "outl_m.gif", "outl_mc.gif", "outl_mo.gif", "outl_r.gif", 
		"outl_rc.gif", "outl_ro.gif", "topic.gif", "vert_line.gif", "s.gif");
	
	this.imageCache = new Array();
	for (var i = 0; i < imagesToCache.length; i++) 
	{
		this.imageCache[i] = new Image();
		this.imageCache[i].src = "../img/" + imagesToCache[i];
	}
}

var _indexedSrc="";

TreeControl.prototype.LoadScript = function(src, indexedSrc)
{
	_indexedSrc=indexedSrc;
	setTimeout("treeControl.LoadScriptInternal('" + src + "')", 1);
}

TreeControl.prototype.LoadScriptInternal = function(src)
{
	var l = this.loader;
	var d = (l.contentDocument ? l.contentDocument : (l.contentWindow ? l.contentWindow.document : null));
	if (!d)
		return;
	treeControlDB = true;
	d.location.replace(src);
}

TreeControl.prototype.Bind = function(data)
{
	if (treeControlDB) 
	{
		treeControlDB = false;
		this.TraverseChildren(data.c, document.getElementById(_indexedSrc));
	}
	if (_lastSelectedItem!=null && treeViewMode=="ALL" && _lastSelectedItem.firstBuild==true)
	{
//        _lastSelectedItem.firstBuild=false;	    
//	    ChangeTreeView_CallBack();
  //    	return;
	}
	if (directMode==true)
    	ChangeTreeView_CallBack()
	else
    	Queue_Next(this);
}

function UnescapeQuotes(s)
{
	ss=s;
	k=ss.indexOf('&amp;');
	while (k>=0)
	{
		sss=ss.substr(0,k)+"&"+ss.substr(k+5);
		ss=sss;
		k=ss.indexOf('&amp;');
	}
	k=ss.indexOf('&gt;');
	while (k>=0)
	{
		sss=ss.substr(0,k)+">"+ss.substr(k+4);
		ss=sss;
		k=ss.indexOf('&gt;');
	}
	k=ss.indexOf('&lt;');
	while (k>=0)
	{
		sss=ss.substr(0,k)+"<"+ss.substr(k+4);
		ss=sss;
		k=ss.indexOf('&lt;');
	}
	return ss;
}

TreeControl.prototype.TraverseNode = function(node, parentElement, image, last)
{
	var e, f, g, hasChildren;
	if (treeViewMode=="ALL")
	{
	    var pGuid=parentElement.getAttribute("id");
	    k=pGuid.lastIndexOf("_");
	    pGuid=pGuid.substr(0,k);
	    var iGuid=(node.d ? node.d : node.i);
	    AddItemdesc(modeDescA,modeDescA.filteredGuids,iGuid,"","-",false,"",pGuid);
        AddTreeItemToItemDesc(iGuid,true); 
	}
	node.element = document.createElement("div");
	f = node.element;
	f.className = "treeControlNode";

	hasChildren = node.c || node.d;
	emptylesson=false;
	if (node.e)
		emptylesson=true;
	_openable=( node.d ? IsOpenable(node.d) : false )
		
	g = f.appendChild(document.createElement("div"));
	guid=(node.i ? node.i : node.d);
	g.setAttribute("tpc", guid);
	
	e = g.appendChild(document.createElement("img"));
	e.setAttribute("srcroot", "../img/outl_" + image);
	if (emptylesson || (node.d && !_openable))
	{
		e.src = e.getAttribute("srcroot") + ".gif";
		e.openable = false;
	}
	else
	{
		e.src = e.getAttribute("srcroot") + (hasChildren ? ( IsAutoExpand() ? "o.gif" : "c.gif") : ".gif");
		e.openable = (hasChildren ? ( IsAutoExpand() ? true : true) : false);
	}
	
	e = g.appendChild(document.createElement("img"));

	if (emptylesson || (node.d && !_openable))
		e.src= "../img/module_c.gif";
	else
		e.src= ( hasChildren ? (IsAutoExpand() ? "../img/module_o.gif" : "../img/module_c.gif") : 
							"../img/topic.gif" );

	e = g.appendChild(document.createElement("span"));
	ee=e.appendChild(document.createElement("a"));
	ee.className="";
	ee.style.cursor="pointer";
	ee.onmouseover = this.OnOverItem;
	ee.onmouseout = this.OnOutItem;
	ee.appendChild(document.createTextNode(UnescapeQuotes(node.t)));
	AddTreeItemToItemDesc(guid,ee);
	
	parentElement.appendChild(f);

	if (hasChildren && _openable) 
	{
		e = node.element.appendChild(document.createElement("table"));
		e.className = "treeControlChildren" + (!IsAutoExpand() ? "H" : "V");
		e.cellSpacing = 0;
		e = e.appendChild(document.createElement("tbody"));
		e = e.appendChild(document.createElement("tr"));
		f = e.appendChild(document.createElement("td"));
		f.className = "treeControlLine" + (last ? "H" : "V");
		f = f.appendChild(document.createElement("img"));
		f.src = "../img/s.gif";

		f = e.appendChild(document.createElement("td"));
		if (node.c)
			this.TraverseChildren(node.c, f);
		if (node.d)
		{
			f.id = node.d + "_" + TreeViewModeLetter();
			return f.id;
		}
	}
	return null;
}

TreeControl.prototype.TraverseChildren = function(children, parentElement)
{
	if (!children)
		return;
	
	var children2=new Array();
	var childrendivs=new Array();

	for (var c=0;c<children.length;c++)
	{
		var guid=(children[c].d ? children[c].d : children[c].i);
		if (IsFiltered(guid,treeViewMode))
			children2[children2.length]=children[c];
	}

	if (children2.length > 0) 
	{
		if (parentElement.className=="treeControlNode")
		{
			if (children2.length==1)
			{
				childrendivs[0]=this.TraverseNode(children2[0], parentElement, "r", true);
			}
			else
			{
				childrendivs[0]=this.TraverseNode(children2[0], parentElement, "f", false);
				var lasti = children2.length - 1;
				for (var i = 1; i < lasti; i++)
					childrendivs[i]=this.TraverseNode(children2[i], parentElement, "m", false);
				childrendivs[lasti]=this.TraverseNode(children2[lasti], parentElement, "l", true);
			}
		}
		else
		{
			var lasti = children2.length - 1;
			for (var i = 0; i < lasti; i++)
				childrendivs[i]=this.TraverseNode(children2[i], parentElement, "m", false);
			childrendivs[lasti]=this.TraverseNode(children2[lasti], parentElement, "l", true);
		}
	} 
	
	if (IsAutoExpand())
	{
		for (var j=0; j<children2.length; j++)
		{
			if (children2[j].d)
				Queue_Add(children2[j].d + ".html",childrendivs[j]);
		}
	}
}

TreeControl.prototype.OnOverItem = function(event)
{
	if (!event)
		event = window.event;
	target=event.target;
	if (!target)
		target = event.srcElement;
	if (target.className=="tselected")
		return;
	target.className="thover";
}

TreeControl.prototype.OnOutItem = function(event)
{
	if (!event)
		event = window.event;
	target=event.target;
	if (!target)
		target = event.srcElement;
	if (target.className=="tselected")
		return;
	target.className="";
}

TreeControl.prototype.OnMouseUp = function (event)
{
    try
    {
        if (event.target.nodeName=="A")
        {
            event.target.focus();
        }
    }
    catch(e){};
}

TreeControl.prototype.OnClick = function(event)
{
	if (!event)
		event = window.event;
	target=event.target;
	if (!target)
		target = event.srcElement;
	treeControl.OnClickHandler(event,target);
}

TreeControl.prototype.OnDoubleClick = function(event) {
    if (!event)
        event = window.event;
    target = event.target;
    if (!target)
        target = event.srcElement;
    if (!target.tagName)
        target = target.parentNode;
    if (target.tagName == "A" || target.tagName == "IMG") {
        if (target.tagName == "IMG") {
            s = target.outerHTML;
            if (s.substr(s.length - 11, 9) != "topic.gif") {
                return;
            }
        }
        var t = target.parentNode.parentNode.firstChild;
        target = t;
        treeControl.OnClickHandler(event, target);
        if (parent.TreeItemDoubleSelected)
            parent.TreeItemDoubleSelected();
    }
    clearTextSelection();
}

function ChangeSelection(e,first)
{
	ee=(e.tagName=="A" ? e : e.childNodes[0]);   
    SetLastSelected(GetTpcAttribute(ee),treeViewMode);
	if (treeViewMode=="ALL")
	{
		if (modeDescA.lastSelected) 
		{
			modeDescA.lastSelected.className="";
		}
		modeDescA.lastSelected = ee;
		modeDescA.lastSelected.className="tselected";
	}
	else if (treeViewMode=="FILTERED")
	{
		if (modeDescF.lastSelected) 
		{
			modeDescF.lastSelected.className="";
		}
		modeDescF.lastSelected = ee;
		modeDescF.lastSelected.className="tselected";
	}
	else if (treeViewMode=="FILTEREDHEMI")
	{
		if (modeDescFH.lastSelected) 
		{
			modeDescFH.lastSelected.className="";
		}
		modeDescFH.lastSelected = ee;
		modeDescFH.lastSelected.className="tselected";
	}
	else	//"HEMI"
	{
		if (modeDescH.lastSelected) 
		{
			modeDescH.lastSelected.className="";
		}
		modeDescH.lastSelected = ee;
		modeDescH.lastSelected.className="tselected";
	}
//	if (!first)
//	{
//		if (ee.parentNode.parentNode.focus)
//			ee.parentNode.parentNode.focus();
//	}

//	if (parent["selector"].FocusToSearchField)
//		parent["selector"].FocusToSearchField();
}

TreeControl.prototype.SelectFirstItem = function()
{
	var hostname="";
	if (treeViewMode=="ALL")
		hostname="treeControlHostForAll";
	else if (treeViewMode=="FILTERED")
		hostname="treeControlHostForFiltered";
	else if (treeViewMode=="FILTEREDHEMI")
		hostname="treeControlHostForFilteredHemi";
	else	//"HEMI"
		hostname="treeControlHostForHemi";
	var tpc="";
	var spam;
	var f=document.getElementById(hostname);
	while (tpc=="")
	{
		try
		{
			t=f.getAttribute("tpc");
		}
		catch(e)
		{
			return;
		}
		if (t)
		{
			tpc=t;
			spam=f.lastChild;
		}
		f=f.firstChild;
	}
	ChangeSelection(spam,true);
	mode=treeViewMode;
	if (selection_need==1)
	{
		mode="HIDE";
	}
	selection_need=0;
	if (parent.TreeItemSelected)
		parent.TreeItemSelected(tpc,treeViewMode);
}

TreeControl.prototype.OnClickHandler = function(event,t)
{
	var realselect=false;
//	var t = event.target;
	if (!t.tagName)
		t = t.parentNode;
	if (t.tagName == "IMG") 
	{
		var e = t.parentNode.parentNode.lastChild;
		if (e.tagName == "TABLE") // section icon
		{
			var f = t.parentNode.firstChild;
			
			if (t.openable || f.openable || e.openable)
			{
				if (e.className == "treeControlChildrenV") 
				{
					f.src = f.getAttribute("srcroot") + "c.gif";
					f = f.nextSibling
					f.src = "../img/module_c.gif";
					e.className = "treeControlChildrenH";
				} 
				else 
				{
					f.src = f.getAttribute("srcroot") + "o.gif";
					f = f.nextSibling
					f.src = "../img/module_o.gif";
					e.className = "treeControlChildrenV";
					var g = e.firstChild.firstChild.lastChild;
					if (!g.firstChild)
					{
						goriginal=( g.id.length>36 ? GetJunctionId(g.id) : g.id);
						treeControl.LoadScript(goriginal + ".html",g.id);
					}
				}
			}
		}
		else	// topic icon
		{
			var e = t.parentNode.lastChild;
			if (e.tagName=="IMG")
			    return;
			ChangeSelection(e);
			realselect=true;
		}
	}
	if (t.tagName == "A") // text field in <A> tag
	{
		ChangeSelection(t);
		realselect=true;
	}
	
	var tpc = t.parentNode.getAttribute("tpc");
	if (tpc==null)
		tpc = t.parentNode.parentNode.getAttribute("tpc");
	if (realselect && parent.TreeItemSelected)
		parent.TreeItemSelected(tpc,treeViewMode);

}

function GetTableItemForThis(_item)
{
    _tItem=_item.parentNode;
    if (_tItem==null)
        return null;
    while (_tItem.tagName!="TABLE")
    {
        _tItem=_tItem.parentNode;
        if (_tItem==null)
            return null;
    }
    return _tItem;
}

function ShowTreeItem(guid)
{
    mdActual=getModeDesc();
    mdSource=getModeDesc(true);
	_item=GetTreeItemOfItemDesc(guid);
	if (_item==null)
	{
	    while (_item==null)
	    {
	        var Item=null;
    	    Item=mdSource.filteredGuids[guid];
    	    if (Item==null)
    	        Item=modeDescF.filteredGuids[guid];
    	    if (Item==null)
    	        Item=modeDescH.filteredGuids[guid];
    	    if (Item==null)
    	        return false;
       	    guid=Item.parentguid;
       	    if (guid==null)
       	        return false;
    	    _item=GetTreeItemOfItemDesc(guid);
	    }
	    treeControl.LoadScript(guid+".html",guid+"_"+mdActual.modeLetter);
	}
	return true;
}

function OpenItem(_tItem)
{
    if (_tItem.className=="treeControlChildrenH")
    {
        f=_tItem.parentNode.firstChild.firstChild;
        f.src = f.getAttribute("srcroot") + "o.gif";
    	f = f.nextSibling
    	f.src = "../img/module_o.gif";
    	_tItem.className = "treeControlChildrenV";
    }
}

function ChangeTreeView()
{
	retvalue=false;
	dA=document.getElementById("treeControlHostForAll");
	dS=document.getElementById("treeControlHostForFiltered");
	dSf=document.getElementById("flatControlHostForFiltered");
	dH=document.getElementById("treeControlHostForHemi");
	dHf=document.getElementById("flatControlHostForHemi");
	dFH=document.getElementById("treeControlHostForFilteredHemi");
	dFHf=document.getElementById("flatControlHostForFilteredHemi");
	
	if (treeViewMode=="FILTERED")
	{
		modeDescF.flatMode=!modeDescF.flatMode;
		retvalue=modeDescF.flatMode;
		dS.style.display=(modeDescF.flatMode ? "none" : "block");
		dSf.style.display=(modeDescF.flatMode ? "block" : "none");
	}
	else if (treeViewMode=="HEMI")
	{
		modeDescH.flatMode=!modeDescH.flatMode;
		retvalue=modeDescH.flatMode;
		dH.style.display=(modeDescH.flatMode ? "none" : "block");
		dHf.style.display=(modeDescH.flatMode ? "block" : "none");
	}
	else	// FILTEREDHEMI
	{
		modeDescFH.flatMode=!modeDescFH.flatMode;
		retvalue=modeDescFH.flatMode;
		dFH.style.display=(modeDescFH.flatMode ? "none" : "block");
		dFHf.style.display=(modeDescFH.flatMode ? "block" : "none");
	}
    ChangeTreeView_CallBack();
	return retvalue;
}

var directMode=false;

function _rec_SearchAInFlat(obj,tpc)
{
    if (obj.nodeName=="IMG")
    {
        attr=obj.getAttribute("tpc");
        if (attr==tpc)
        {
            return obj;
        }
    }
    for (var i=0;i<obj.childNodes.length;i++)
    {
        r=_rec_SearchAInFlat(obj.childNodes[i],tpc);
        if (r!=null)
            return r;
    }
    return null;
}

function _rec_GetFirstObjInFlat(obj)
{
    if (obj.nodeName=="IMG")
    {
        return obj;
    }
    for (var i=0;i<obj.childNodes.length;i++)
    {
        r=_rec_GetFirstObjInFlat(obj.childNodes[i]);
        if (r!=null)
            return r;
    }
    return null;
}

function SetFlatSelection()
{
	mdActual=getModeDesc();
    obj=_rec_SearchAInFlat(mdActual.flatControl.host,_lastSelectedGlobal);
    if (obj==null)
        obj=_rec_GetFirstObjInFlat(mdActual.flatControl.host);
    if (obj!=null)
    {
        mdActual.flatControl.OnClickHandler(null,obj);
        return;
		}
	if (parent.TreeItemSelected)
		parent.TreeItemSelected(null,null);
}

function ChangeTreeView_CallBack()
{
	mdActual=getModeDesc();
	mdSource=getModeDesc(true);
	var _item=null;
	if (mdActual.flatMode==true)
	{
	    SetFlatSelection();
	    return true;
	}
	if (mdActual.flatMode==false || treeViewMode=="ALL")
	{
	    var guid=null;
//	    if (treeViewMode=="ALL")
//	    {
//	        guid=_lastSelectedItem.guid;
//	    }
//	    else
//	    {
//		    guid=mdSource.lastSelectedFlat.getAttribute("tpc");
//		}
		guid=_lastSelectedGlobal;
		_item=GetTreeItemOfItemDesc(guid);
        if (_item==null)
        {
            directMode=true;
		    k=ShowTreeItem(guid);
		    return k;
    	}
    	if (_item!=null)
    	{
    		_tItem=GetTableItemForThis(_item);
    		while (_tItem!=null)
    		{
    		    OpenItem(_tItem);
    		    _tItem=GetTableItemForThis(_tItem);
    		}
    	}
    }
    directMode=false;
	createTreeControl(null,mdActual.flatMode,_item);
	return true;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// FLAT VIEW
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function FlatControl(hostname)
{
	this.host=document.getElementById(hostname);
	this.document=( this.host.document ? this.host.document : this.host.ownerDocument );
}

function showOnFlat(desc)
{
    if (desc.isroot==true)
        return false;
	if (rolefilter_enabled==false)
		return true;
	ret=false;
	try
	{
		ret=filteredGuidsR[desc.guid].found;
	}
	catch(e){};
	return ret;
}

function getModeDesc(source)
{
    if (source==null)
        source=false;
    var mode=( source==true ? _lastSelectedGlobalMode : treeViewMode );
	if (mode=="ALL")
	{
		return modeDescA;
	}
	else if (mode=="FILTERED")
	{
		return modeDescF;
	}
	else if (mode=="HEMI")
	{
		return modeDescH;
	}
	else if (mode=="FILTEREDHEMI")
	{
		modeDescFH.guidsForFlat=new Array();
		for (var i=0;i<modeDescF.guidsForFlat.length;i++)
		{
			guidF=modeDescF.guidsForFlat[i];
			for (var j=0;j<modeDescH.guidsForFlat.length;j++)
			{
				guidH=modeDescH.guidsForFlat[j];
				if (guidF.guid==guidH.guid)
				{
					modeDescFH.guidsForFlat[modeDescFH.guidsForFlat.length]=guidF;
				}
			}
		}
		return modeDescFH;
	}
	return null;
}

function saveModeDesc(md)
{
	if (treeViewMode=="ALL")
	{
		modeDescA=md;
	}
	else if (treeViewMode=="FILTERED")
	{
		modeDescF=md;
	}
	else if (treeViewMode=="HEMI")
	{
		modeDescH=md;
	}
	else if (treeViewMode=="FILTEREDHEMI")
	{
		modeDescFH=md;
	}
}

FlatControl.prototype.Load = function ()
{
	myDesc=getModeDesc();
	this.host.innerHTML="";

	div=this.host.appendChild(this.document.createElement("div"));
	div.className="treeControlNode";
	div.onclick = this.OnClick;
	div.ondblclick = this.OnDoubleClick;
	div.onmouseup = this.OnMouseUp;
	table=div.appendChild(this.document.createElement("table"));
	table.cellSpacing=0;
	first=true;
	var showCt=0;
	for (var i=0;i<myDesc.guidsForFlat.length;i++)
	{
		itemdesc=myDesc.guidsForFlat[i];
		if (showOnFlat(itemdesc))
		{
		    showCt++;
		    if (showCt>SearchResultLimit)
		        continue;
		   myDesc.actualFlatCounter=showCt;
			tr=table.appendChild(this.document.createElement("tbody"));
			tr=tr.appendChild(this.document.createElement("tr"));
			td=tr.appendChild(this.document.createElement("td"));
			img=td.appendChild(this.document.createElement("img"));
			img.src=(itemdesc.type=="Topic" ? "../img/topic.gif" : "../img/module_c.gif" );
			img.setAttribute("tpc",itemdesc.guid);			
			td=tr.appendChild(this.document.createElement("td"));
			td.className="treeControlNode";
			a=td.appendChild(this.document.createElement("a"));
			if (first==true)
			{
				myDesc.lastSelectedFlat=a;
				saveModeDesc(myDesc);
			}
			a.className=( first==true ? "tselected" : "");
			if (first==true && _lastChangeIsFilterOnly==false)
			{
			    SetLastSelected(itemdesc.guid,treeViewMode);
			}
			first=false;
			a.style.cursor="pointer";
			a.setAttribute("tpc",itemdesc.guid);
			a.onmouseover=this.OnOverItem;
			a.onmouseout=this.OnOutItem;
			var _tname=itemdesc.title;
			if (treeViewMode=="HEMI" && parent.showscore>0)
			{
			    _tname=""+Math.round(itemdesc.score*100)+" "+itemdesc.title;
			}
			a.appendChild(this.document.createTextNode(_tname));		
		}
	}
	if (myDesc.flatMode==true)
	{
	    SetFlatSelection();
	}
	var tpc=null;
	try
	{
		tpc=myDesc.lastSelectedFlat.getAttribute("tpc");
	}
	catch(e){};
	if (parent.TreeItemSelected)
		parent.TreeItemSelected(tpc,treeViewMode);
	
}

FlatControl.prototype.OnOverItem = function(event)
{
	if (!event)
		event = window.event;
	target=event.target;
	if (!target)
		target = event.srcElement;
	if (target.className=="tselected")
		return;
	target.className="thover";
}

FlatControl.prototype.OnOutItem = function(event)
{
	if (!event)
		event = window.event;
	target=event.target;
	if (!target)
		target = event.srcElement;
	if (target.className=="tselected")
		return;
	target.className="";
}

FlatControl.prototype.OnMouseUp = function (event)
{
    try
    {
        if (event.target.nodeName=="A")
        {
            event.target.focus();
        }
    }
    catch(e){};
}

FlatControl.prototype.OnClick = function(event) {
    if (!event)
        event = window.event;
    target = event.target;
    if (!target)
        target = event.srcElement;
    mdActual = getModeDesc();
    mdActual.flatControl.OnClickHandler(event, target);
}

FlatControl.prototype.OnDoubleClick = function (event)
{
	if (!event)
		event = window.event;
	target=event.target;
	if (!target)
		target = event.srcElement;
	mdActual=getModeDesc();
	mdActual.flatControl.OnClickHandler(event,target);
	if (parent.TreeItemDoubleSelected)
		parent.TreeItemDoubleSelected();
}

FlatControl.prototype.OnClickHandler = function(event, target) {
    a = target;
    t = GetTpcAttribute(a);
    if (t != null)
        SetLastSelected(t, treeViewMode);
    if (target.tagName != "A" && target.tagName != "IMG")
        return;
    if (target.tagName != "A") {
        tr = target.parentNode.parentNode;
        for (var i = 0; i < tr.childNodes.length; i++) {
            k = tr.childNodes[i].childNodes[0];
            if (k.tagName == "A") {
                a = k;
                continue;
            }
        }
    }
    if (treeViewMode == "FILTERED") {
        modeDescF.lastSelectedFlat.className = "";
    }
    else if (treeViewMode == "HEMI") {
        modeDescH.lastSelectedFlat.className = "";
    }
    else	// FILTEREDHEMI
    {
        modeDescFH.lastSelectedFlat.className = "";
    }
    a.className = "tselected";
    if (treeViewMode == "FILTERED") {
        modeDescF.lastSelectedFlat = a;
    }
    else if (treeViewMode == "HEMI") {
        modeDescH.lastSelectedFlat = a;
    }
    else	// FILTEREDHEMI
    {
        modeDescFH.lastSelectedFlat = a;
    }
    var tpc = a.getAttribute("tpc");
    if (parent.TreeItemSelected)
        parent.TreeItemSelected(tpc, treeViewMode);
}

function GetActualFlatView()
{
    md=getModeDesc();
    return md.flatMode;
}

function GetActualFlatItemCounter()
{
	md=getModeDesc();
	return md.actualFlatCounter;
}

function IsActualViewEmpty()
{
	md=getModeDesc();
	return (md.filteredGuidList==0);
}

//////////////////////////////////////////////////////////////////////////////////////////

function getActualIndex_Flat() {
    md = getModeDesc();
    if (md.flatMode == true) {
        for (var i = 0; i < md.flatControl.host.firstChild.firstChild.childNodes.length; i++) {
            if (md.flatControl.host.firstChild.firstChild.childNodes[i].firstChild.childNodes[1].firstChild.className == "tselected") {
                return i;
            }
        }
    }
    return "";
}

function getActualIndex_Tree(ls,md) {
    for (var i = 0; i < ls.length; i++) {
        if (ls[i].firstChild.childNodes[2].firstChild.className == "tselected") {
            return i;
        }
    }
    if (md.lastSelected != null) {
        _tpc = md.lastSelected.parentNode.parentNode.getAttribute("tpc");
        for (var i = 0; i < ls.length; i++) {
            if (ls[i].firstChild.getAttribute("tpc")==_tpc)
                return i;
        }
    }
    return "";
}

function getTargetForIndex_Flat(md,i) {
    return md.flatControl.host.firstChild.firstChild.childNodes[i].firstChild.firstChild.firstChild;
}

function getTargetForIndex_Tree(i) {
    return ls[i].firstChild.childNodes[2].firstChild;
}

function getActualImageObj_Tree(md) {
    return md.lastSelected.parentNode.parentNode.firstChild;
}

function getOpenedStatus(obj) {
    s = obj.getAttribute("src");
    k = s.indexOf(".gif");
    c = s.substr(k - 1, 1);
    return (c == "o");
}

function _getLinearStructure_Recursive(o, a) {
    a[a.length] = o;
    _imgObj = o.firstChild.firstChild;
    if (getOpenedStatus(_imgObj) == true) {
        for (var i = 0; i < o.childNodes[1].firstChild.firstChild.childNodes[1].childNodes.length; i++) {
            _getLinearStructure_Recursive(o.childNodes[1].firstChild.firstChild.childNodes[1].childNodes[i], a);
        }
    }
}

function getRoot(o) {
    if (o.tagName == "DIV" && o.id.substr(0, 15) == "treeControlHost")
        return o.firstChild;
    return getRoot(o.parentNode);
}

function getLinearStructure_Tree(md) {
    var oArray = new Array();
    root = getRoot(md.lastSelected);
//    root = treeControl.host.firstChild;
    for (var i = 0; i < root.childNodes.length; i++) {
        _getLinearStructure_Recursive(root.childNodes[i],oArray);
    }
    return oArray;
}

function EventKeyDown(event) {
    if (event == null)
        event = window.event;
    var code = event.which ? event.which : event.keyCode;
    if (code == 13) {
        if (parent.TreeItemDoubleSelected)
            parent.TreeItemDoubleSelected();
        return;
    }
    md = getModeDesc();
    if (md.flatMode == true) {
        index = getActualIndex_Flat();
        if (code == 38) {  // up
            if (index > 0) {
                t = getTargetForIndex_Flat(md, index - 1);
                md.flatControl.OnClickHandler(null, t);
            }
        }
        else if (code == 40) {  // down
            if (index < md.actualFlatCounter - 1) {
                t = getTargetForIndex_Flat(md, index + 1);
                md.flatControl.OnClickHandler(null, t);
            }
        }
    }
    else {
        imgObj = getActualImageObj_Tree(md);
        _isOpenable = (imgObj.openable ? imgObj.openable : imgObj.getAttribute("openable"));
        _isOpened = getOpenedStatus(imgObj);
        ls = getLinearStructure_Tree(md);
        index = getActualIndex_Tree(ls,md);
        if (code == 37) {  // left
            if (_isOpenable == true) {
                if (_isOpened == true) {
                    treeControl.OnClickHandler(null, imgObj);
                }
            }
        }
        else if (code == 38) {  // up
            if (index > 0) {
                t = getTargetForIndex_Tree(index-1);
                treeControl.OnClickHandler(null, t);
            }
        }
        else if (code == 39) {  // right
            if (_isOpenable == true) {
                if (_isOpened == false) {
                    treeControl.OnClickHandler(null, imgObj);
                }
            }
        }
        else if (code == 40) {  // down
            if (index < ls.length-1) {
                t = getTargetForIndex_Tree(index + 1);
                treeControl.OnClickHandler(null, t);
             }
        }
    }
}

function tree_SetFocus() {
    document.frames[0].document.childNodes[1].childNodes[1].focus();
    }

function tree_Init() {
    document.onkeydown = EventKeyDown;
}

function clearTextSelection() {
    if (document.selection)
        document.selection.empty();
    if (window.getSelection)
        window.getSelection().removeAllRanges();
}