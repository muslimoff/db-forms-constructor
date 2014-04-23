/*--
Copyright © 1998, 2009, Oracle and/or its affiliates.  All rights reserved.
--*/

if (typeof(Gkod) == 'undefined')
    var Gkod = {};

if (typeof(Gkod.Escape) == 'undefined')
    Gkod.Escape = {};

//*****************************************************************
//Safe Escape/UnEscape support

Gkod.Escape.SafeUri_EscapeCharacter = '/';

Gkod.Escape.SafeUri_UnsafeCharacters = ['<','>','"','\'','%',';','(',')','&','+'];

Gkod.Escape.SafeUriEscape = function(s)
{
	return this.__Escape(s,1);
}

Gkod.Escape.SafeUriUnEscape = function(s)
{
	return this.__UnEscape(s,1);
}


//*****************************************************************
// Simple Escape/UnEscape support

Gkod.Escape.MyEscape = function(s)
{
	return this.__Escape(s,0);
}

Gkod.Escape.MyUnEscape = function(s)
{
	return this.__UnEscape(s,0);
}

//*****************************************************************
// private

Gkod.Escape.__Escape = function(s,safe)
{
	var snew="";
	for (var i=0;i<s.length;i++)
	{
		ss=s.substr(i,1);
		if (safe==0 ? this.__Normal_Contains(ss) : !this.__SafeUri_Contains(ss))
		{
			snew+=ss;
		}
		else
		{
			ss=s.charCodeAt(i);		
			a="0000"+ss.toString(16).toUpperCase();
			snew+=(safe==0 ? "$" : this.SafeUri_EscapeCharacter)+a.substr(a.length-4);		
		}
	}
	return snew;
}

Gkod.Escape.__UnEscape = function(s,safe)
{
	var snew="";
	var bEscape=false;
	for (var i=0;i<s.length;i++)
	{
		if (bEscape)
		{
			ss=s.substr(i,4);
			snew+=String.fromCharCode(parseInt("0x"+ss));
			i+=3;
			bEscape=false;
		}
		else
		{
			ss=s.substr(i,1);
			if (ss==(safe==0 ? '$' : this.SafeUri_EscapeCharacter))
				bEscape=true;
			else
				snew+=ss;
		}
	}
	return snew;
}

Gkod.Escape.__Normal_Contains = function(s)
{
	return ((s>='0' && s<='9') || (s>='a' && s<='z') || (s>='A' && s<='Z'));
}

Gkod.Escape.__SafeUri_Contains = function(s)
{
	var l=this.SafeUri_UnsafeCharacters.length;
	for (var i=0;i<l;i++)
	{
		if (s==this.SafeUri_UnsafeCharacters[i])
			return true;
	}
	if (s==this.SafeUri_EscapeCharacter)
		return true;
	return false;
}
