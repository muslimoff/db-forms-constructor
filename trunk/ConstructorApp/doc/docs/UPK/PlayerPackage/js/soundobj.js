/*--
Copyright © 1998, 2009, Oracle and/or its affiliates.  All rights reserved.
--*/

var sounds=new Array();

function SoundObj(id,filelist)
{
	_flist=filelist.split("+");
	_fct = _flist.length;
	this.flist = new Array();
	this.fct=0;
	for (var i=0;i<_fct;i++)
	{
		s=_flist[i];
		if (s.substr(0, 5) != "TEMP:") {
		    this.flist[this.fct] = s;
		    this.fct++;
		}
	}
};

function Sound(id,filelist)
{
	if (id.indexOf('.')<0)
		id+=".ASX";
	sounds[id.substr(1)]=new SoundObj(id,filelist);
};
