/*--
Copyright © 1998, 2009, Oracle and/or its affiliates.  All rights reserved.
--*/

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	EcidComparer:
//	------------
//	void Init(expressionstr)	-> Initializes the object variable with expression string, got the player 
//										as ECID parameter in command line
//	BOOL Compare(ecidarray)		-> EcidArray contains ECID-s, got the player in an Action function
//										If the return value is true, the player has to start from frame, that
//										contain the given action, as "forward" action.
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	Using:	You have to initialize the object variable, and you can use the compare function for every action.
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	Important:	Include with "query.js"!!!
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

var EcidComparer =
{
	expstr: "",
	
Init:
function(expressionstr)
{
	if (expressionstr && expressionstr.length > 0)
	{
		QueryParser.Parse("URI", expressionstr);
	}
	else
	{
		this.expstr="";
		return;
	};

	if (QueryParser.ev)
		this.expstr=QueryParser.ev;
},






Compare:
function(ecidarray)
{
	if (this.expstr.length==0)
		return false;
	if (!ecidarray)
		return false;
	eval("exparray = [" + this.expstr + "]");
	for (var i=0;i<exparray.length;i++)
	{
		exparray[i].l=false;
		if (exparray[i].a.toLowerCase()=="s")
		{
			for (var j=0;j<ecidarray.length;j++)
			{
				if (matchString(ecidarray[j],exparray[i].p))
				{
					exparray[i].l=true;
				};
			};
		};
	};
	EcidCompareStack.Init();
	for (var i=0;i<exparray.length;i++)
	{
		if (exparray[i].a.toLowerCase()=="s")
		{
			EcidCompareStack.Push(exparray[i]);
		}
		else
		{
			var a=EcidCompareStack.Pop();
			var b=EcidCompareStack.Pop();
			if (exparray[i].p=="|")
				a.l=a.l || b.l;
			else
				a.l=a.l && b.l;
			EcidCompareStack.Push(a);
		};
	};
	return EcidCompareStack.Pop().l;
}
};

function StackItem(a,p,l)
{
	this.a=a;
	this.p=p;
	this.l=l;
};

var EcidCompareStack =
{
Init:
function()
{
	this.stArray=new Array();
	this.pTop=(-1);
},

Push:
function(element)
{
	if (this.stArray.length-this.pTop==1)
	{
		this.stArray[this.stArray.length]=new StackItem(element.a,element.p,element.l);
		this.pTop++;
	}
	else
	{
		this.pTop++;
		this.stArray[this.pTop]=new StackItem(element.a,element.p,element.l);
	};
},

Pop:
function()
{
	if (this.pTop!=(-1))
	{
		return this.stArray[this.pTop--];
	};
}
};

/////////////////////////////////////////////////////////////////////////////////////

function matchCharacter(char1, char2) 
{
    var halfKatakanaSet = " ｦｧｨｩｪｫｬｭｮｯｰｱｲｳｴｵｶｷｸｹｺｻｼｽｾｿﾀﾁﾂﾃﾄﾅﾆﾇﾈﾉﾊﾋﾌﾍﾎﾏﾐﾑﾒﾓﾔﾕﾖﾗﾘﾙﾚﾛﾜﾝ";
    var fullKatakanaSet = "　ヲァィゥェォャュョッーアイウエオカキクケコサシスセソタチツテトナニヌネノハヒフヘホマミムメモヤユヨラリルレロワン";
    
    if (char1 == char2) {
        return true;
    }
    else if (halfKatakanaSet.indexOf(char1) > -1 && halfKatakanaSet.indexOf(char2) > -1) {
        return false;
    }
    else if (fullKatakanaSet.indexOf(char1) > -1 && fullKatakanaSet.indexOf(char2) > -1) {
        return false;
    }
    else if (halfKatakanaSet.indexOf(char1) > -1 || halfKatakanaSet.indexOf(char2) > -1) {
        return halfKatakanaSet.indexOf(char1) == fullKatakanaSet.indexOf(char2) || halfKatakanaSet.indexOf(char2) == fullKatakanaSet.indexOf(char1);
    }
    else {
        var diff = "Ａ".charCodeAt(0) - "A".charCodeAt(0);
        var charCode1 = char1.charCodeAt(0);
        var charCode2 = char2.charCodeAt(0);
        
        return (charCode1 - diff == charCode2) || (charCode2 - diff == charCode1);
    }
}

function replaceDotAndCircle(str)
{
    var fullKatakanaSet1 = "ガギグゲゴザジズゼゾダヂヅデドバビブベボ";
    var newFullKatakanaSet1 = "カキクケコサシスセソタチツテトハヒフヘホ";
    var fullKatakanaSet2 = "パピプペポ"
    var newFullKatakanaSet2 = "ハヒフヘホ";
    var newStr = null;
    
    newStr = str.replace(new RegExp("ﾞ", "g"), "#");
    newStr = newStr.replace(new RegExp("ﾟ", "g"), "*");
    
    for (var i = 0; i < fullKatakanaSet1.length; i++) {
        newStr = newStr.replace(new RegExp(fullKatakanaSet1.charAt(i), "g"), newFullKatakanaSet1.charAt(i) + "#");
    }
    for (var i = 0; i < fullKatakanaSet2.length; i++) {
        newStr = newStr.replace(new RegExp(fullKatakanaSet2.charAt(i), "g"), newFullKatakanaSet2.charAt(i) + "*");
    }
    return newStr;
}

function matchString(s1,s2,casesensitive)
{
	if (!s1)
		return false;
	if (!casesensitive)
		casesensitive=false;
	var sl1=s1.length;
	var sl2=s2.length;
	if (sl1==0 && sl2==0)
		return true;
	if (sl1==0 && sl2!=0)
		return false;
	if (sl1!=0 && sl2==0)
		return false;
	if (sl1!=sl2)
		return false;

	var ss1=(casesensitive ? s1 : s1.toLowerCase());
	var ss2=(casesensitive ? s2 : s2.toLowerCase());
	
    var newStr1 = replaceDotAndCircle(ss1);
    var newStr2 = replaceDotAndCircle(ss2);
    if (newStr1.length!=newStr2.length)
		return false;	

	for (var i=0;i<newStr1.length;i++)
	{
		if (!matchCharacter(newStr1.substr(i,1),newStr2.substr(i,1)))
			return false;
	}
	return true;
}

/////////////////////////////////////////////////////////////////////////////////////