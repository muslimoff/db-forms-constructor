/*--
Copyright © 1998, 2009, Oracle and/or its affiliates.  All rights reserved.
--*/
// Tree Structure Class

function TreeItem(level,img,text,command,columns)
{
	this.Level=level;
	this.Img=img;
	this.Text=text.replace(/</g,"&lt;");
	this.Text=this.Text.replace(/>/g,"&gt;");
	if (command && command!="")
		this.CommandString=command;
	this.Columns=columns;
}

function TreeStruct(name)
{
	this.Name=name;
	this.Items=new Array();
	this.ImagePath="";
	this.TableAttributes="";
	this.RowAttributes=" valign=middle";
	this.ItemAttributes=" nowrap";
	this.ColumnAttributes=new Array();
	this.CommandAttributes="";
	this.HighlightColor="darkblue";
	this.Selection=-1;
	this.HighlightSelection=false;
}

TreeStruct.prototype.AddItem = function(level,img,text,command,columns)
{
	var length=this.Items.length;
//	if (length==0 && level!=0)
//		throw new Error("The first item must be on level 0!");
//	if (length>0 && level>this.Items[length-1].Level+1)
//		throw new Error("Illegal level value in item "+length+"!");
	var item=new TreeItem(level,img,text,command,columns);
	item.ItemAttributes=this.ItemAttributes;
	item.RowAttributes=this.RowAttributes;
	this.Items[length]=item;
}

TreeStruct.prototype.GetItemId = function(i)
{
	return this.Name+"_"+i;
}

TreeStruct.prototype.IsFolder = function(i)
{
	if (i>=this.Items.length-1)
		return false;
	return (this.Items[i+1].Level>this.Items[i].Level);
}

TreeStruct.prototype.Render = function()
{
	var a=new Array();

	function wr(str)
	{
		a[a.length] = str;
	}

	function flush()
	{
		var b=a.join(String.fromCharCode(13));
//		alert(b);
		document.write(b);
		a = new Array();
	}

	var levelLines = new Array();
	var ExpandColapseText = '';
	var divLevel=0;
	for (var i=0; i<this.Items.length; i++)
	{
		var itemId=this.GetItemId(i);
		var itemLevel=this.Items[i].Level;

		while (divLevel>itemLevel)
		{
			wr("</div>");
			divLevel--;
		}

		var itemLine="";
		itemLine = "<table cellspacing=0 cellpadding=0 border=0"+this.TableAttributes+"><tr"+this.Items[i].RowAttributes+"><td"+this.Items[i].ItemAttributes+">";
		for (var l=0; l<itemLevel; l++)
		{
			if (levelLines[l])
				itemLine+="<IMG src='"+this.ImagePath+"vert_line.gif' width=23 align=absMiddle border=0>";
			else
				itemLine+="<IMG src='"+this.ImagePath+"spacer.gif' width=23>";
		}

		var outlSuffix="";
		var imgSuffix="";
		var last=true;

		for (var j=i+1; j<this.Items.length; j++)
		{
			if (this.Items[j].Level<=itemLevel)
			{
				if (this.Items[j].Level==itemLevel)
					last=false;
				break;
			}
		}

		if (i==0)
			outlSuffix = last ? "_r" : "_f";
		else
			outlSuffix = last ? "_l" : "_m";
		if (this.IsFolder(i))
		{
			imgSuffix+="_c";
			outlSuffix+="c";
		}

		levelLines[itemLevel] = !last;

		if (this.IsFolder(i))
		{
			var toggle_command='javascript:'+this.Name+'.ToggleTree('+i+')';
			itemLine+="<A href='"+toggle_command+";'>";
			ExpandColapseText = ' ondblclick='+this.Name+'.ToggleTree('+i+') ';
		}else{
			ExpandColapseText = '';	
		}		
		itemLine+="<IMG src='"+this.ImagePath+"outl"+outlSuffix+".gif' height=18 width=18 align=absMiddle border=0 name="+itemId+"o>";
		if (this.IsFolder(i))
			itemLine+="</A>";

		if (this.Items[i].CommandString)
			itemLine+="<A " + ExpandColapseText + "href='javascript:"+this.Name+".SelectItem("+i+");'>";
		itemLine+="<IMG src='"+this.ImagePath+this.Items[i].Img+imgSuffix+".gif' height=18 width=22 align=absMiddle border=0 name="+itemId+"i>";
		if (this.Items[i].CommandString)
			itemLine+="</A>";

		if (this.Items[i].CommandString)
		{
			itemLine+="<A " + ExpandColapseText + "href='javascript:"+this.Name+".SelectItem("+i+");'";
			itemLine+=" id='"+itemId+"c'";
			itemLine+=this.CommandAttributes+">";
		}
		itemLine+=this.Items[i].Text;
		if (this.Items[i].CommandString)
			itemLine+="</A>";

		itemLine+="</td>";
		var columns=new Array();
		if (this.Items[i].Columns)
			columns=this.Items[i].Columns.split("|||");
		for (var c=0; c<this.ColumnAttributes.length; c++)
		{
			itemLine+="<td"+this.ColumnAttributes[c]+">";
			if (columns[c])
				itemLine+=(columns[c]==" ") ? "&nbsp;" : columns[c];
			else
				itemLine+="&nbsp;";
			itemLine+="</td>";
		}
		itemLine+="</tr></table>";

		wr(itemLine);
		if (this.IsFolder(i))
		{
			wr('<div id='+itemId+' style="DISPLAY: none; POSITION: relative">');
			divLevel++;
		}
	}

	while (divLevel)
	{
		wr("</div>");
		divLevel--;
	}

	flush();
}

TreeStruct.prototype.SaveOpenFolders = function()
{
	var open_folders="";

	function _set_cookie(name, value, expire) {
	  document.cookie = name + "=" + escape(value)
	  + ((expire == null) ? "" : ("; expires=" + expire.toGMTString()));
	}

	function add_folder(folder_name)
	{
		if (open_folders!="")
			open_folders+="&";
		open_folders+=folder_name;
	}

	for (var i=0; i<this.Items.length; i++)
	{
		if (this.IsFolder(i))
		{
			var itemId=this.GetItemId(i);
			if (getDIVstyle(itemId).display=="block")
				add_folder(i.toString());
		}
	}

	if (open_folders=="")
		open_folders="none";

	_set_cookie(this.Name,open_folders);
}

TreeStruct.prototype.RestoreOpenFolders = function()
{
	function _get_cookie(Name){
	  var search = Name + "=";
	  if (document.cookie.length > 0){
	    offset = document.cookie.indexOf(search);
	    if (offset != -1){
	      offset += search.length;
	      end = document.cookie.indexOf(";", offset);
	      if (end == -1) end = document.cookie.length;
	      return unescape(document.cookie.substring(offset, end));
	    }
	  }
	  return "";
	}

	var open_folders=_get_cookie(this.Name);
	if (open_folders=="none")
		return true;
	else if (open_folders!="")
	{
		var aFolders=open_folders.split("&");
		for (var i=0; i < aFolders.length; i++)
			this.OpenFolder(Number(aFolders[i]));
		return true;
	}
	
	return false;
}

TreeStruct.prototype.IsOpenFolder = function(i)
{
	if (!this.IsFolder(i))
		return false;

	var itemId=this.GetItemId(i);
	return (getDIVstyle(itemId).display=="block");
}

TreeStruct.prototype.OpenFolder = function(i)
{
	if (this.IsFolder(i))
	{
		var itemId=this.GetItemId(i);
		if (getDIVstyle(itemId).display=="none")
			this.ToggleTree(i);
	}
}

TreeStruct.prototype.CloseFolder = function(i)
{
	if (this.IsFolder(i))
	{
		var itemId=this.GetItemId(i);
		if (getDIVstyle(itemId).display=="block")
			this.ToggleTree(i);
	}
}

TreeStruct.prototype.ExpandAll = function()
{
	for (var i=0; i<this.Items.length; i++)
	{
		this.OpenFolder(i);
	}
}

TreeStruct.prototype.CollapseAll = function()
{
	for (var i=0; i<this.Items.length; i++)
	{
		this.CloseFolder(i);
	}
}

TreeStruct.prototype.Highlight = function(i)
{
	var obj;
	
	var itemId = (i!=-1) ? this.GetItemId(i)+"c" : "";
	var selId  = (this.Selection!=-1) ? this.GetItemId(this.Selection)+"c" : "";

	if (selId!="" && selId!=itemId)
	{
		obj = getDIVstyle(selId);
		obj.color = '';
		obj.backgroundColor = '';
	}

	if (itemId!="" && selId!=itemId)
	{
		obj = getDIVstyle(itemId);
		obj.color = 'white';
		obj.backgroundColor = this.HighlightColor;
	}

	this.Selection=i;
}

TreeStruct.prototype.ToggleTree = function(i)
{
	var itemId=this.GetItemId(i);
	
	if(getDIVstyle(itemId).display=="none")
	{
		getDIVstyle(itemId).display = "block";
		var gifName = document.images[itemId+'o'].src;
		document.images[itemId+'o'].src = gifName.substr(0,gifName.length-5)+"o.gif";
		gifName = document.images[itemId+'i'].src;
		document.images[itemId+'i'].src = gifName.substr(0,gifName.length-5)+"o.gif";
	}
	else
	{
		if (this.Selection>i && this.Items[i].Level<this.Items[this.Selection].Level)
		{
			var bChild=true;
			for (var j=i+1; bChild && j<=this.Selection; j++)
				bChild=(this.Items[i].Level<this.Items[j].Level);
			if (bChild)
				this.SelectItem(i);
		}

		getDIVstyle(itemId).display = "none";
		var gifName = document.images[itemId+'o'].src;
		document.images[itemId+'o'].src = gifName.substr(0,gifName.length-5)+"c.gif";
		gifName = document.images[itemId+'i'].src;
		document.images[itemId+'i'].src = gifName.substr(0,gifName.length-5)+"c.gif";
	}
}

TreeStruct.prototype.SelectItem = function(i)
{
	if (this.HighlightSelection)
		this.Highlight(i);
	if (this.OnSelect && this.Items[i].CommandString)
		this.OnSelect(i,this.Items[i].CommandString);
}

function getDIVstyle(id)
{
  if(document.all)
    return document.all(id).style;
  else if(document.getElementById)
    return document.getElementById(id).style;
  return 0;
}

