/*--
Copyright © 1998, 2009, Oracle and/or its affiliates.  All rights reserved.
--*/

// OnDemand query parser

datasourceroot = "querydb/";
ConvertDbSelector = { t: "text", u: "ctxod", e: "ctxex", r: "role", g: "genctx" };

var q_search_and = " and ";
var q_search_or = " or ";

function ToHalfWidth(str)
{
  var halfKatakanaSet = "ｦｧｨｩｪｫｬｭｮｯｰｱｲｳｴｵｶｷｸｹｺｻｼｽｾｿﾀﾁﾂﾃﾄﾅﾆﾇﾈﾉﾊﾋﾌﾍﾎﾏﾐﾑﾒﾓﾔﾕﾖﾗﾘﾙﾚﾛﾜﾝ";
  var fullKatakanaSet = "ヲァィゥェォャュョッーアイウエオカキクケコサシスセソタチツテトナニヌネノハヒフヘホマミムメモヤユヨラリルレロワン";
  
  var result="";
  
  for (var i=0; i<str.length; i++)
  {
	var k = fullKatakanaSet.indexOf(str.charAt(i));
	if (k!=-1)
		result += halfKatakanaSet.charAt(k);
	else if (str.charCodeAt(i)>=0xff01 && str.charCodeAt(i)<=0xff5f)
		result += String.fromCharCode(str.charCodeAt(i)-0xfee0);
	else
		result += str.charAt(i);
  }
  
  return result;
}

function MyUnEscape1(s)
{
	if (s.length>2)
	{
		if (s.substr(1,1)=='\'')
		{
			var ss=s.substr(0,2)+Gkod.Escape.MyUnEscape(s.substr(1));
			return ss;
		}
		return Gkod.Escape.MyUnEscape(s);
	}
	return Gkod.Escape.MyUnEscape(s);
}

var QueryParser = { 
	PS: null, // stack
	PT: [ 0,
//     e   (   )   &|  !  EOT q
	[  2,  3,  0,  0,  0,  0, 4 ],
	[ -1, -1, -1, -1,  5, -1, 0 ],
	[  2,  3,  0,  0,  0,  0, 6 ],
	[  0,  0,  0,  7,  0, 10, 0 ],
	[ -2, -2, -2, -2, -2, -2, 0 ],
	[  0,  0,  8,  7,  0,  0, 0 ],
	[  2,  3,  0,  0,  0,  0, 9 ],
	[ -4, -4, -4, -4, -4, -4, 0 ],
	[ -3, -3, -3, -3, -3, -3, 0 ]],

Parse: function(query_type, query_expression)
{
	if (window.R_search_AND)
		q_search_and = " " + R_search_AND.toLowerCase() + " ";
	if (window.R_search_OR)
		q_search_or = " " + R_search_OR.toLowerCase() + " ";

	var lexer;
	var keyws;
	if ("URI" == query_type) {
		lexer = /\(|\)|\+|-|[u,e,k,r,g]|!|\d|'[^']+'/g;
		keyws = ["(",")","+","-","u","e","t","r","g","!","0","1","2","3","4","5","6","7","8","9"];
	} else {
		lexer = new RegExp('\\(|\\)|'+q_search_and+'|'+q_search_or+'|"[^"]+"|[^ \\(\\)]+(?=\\(|\\)|\\s|$)','gi'); //doesn't support db|!|\d
		keyws = ["(",")",q_search_and,q_search_or];
	}
	var codem = [1,2,3,3,5,5,5,5,5,4,4,4,4,4,4,4,4,4,4,4];
	var semvm = [0,0,"&","|",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];


	if (query_type!='URI')
	{
		query_expression = ToHalfWidth(query_expression);
		query_expression = query_expression.toLowerCase();
	}
	
	this.ev = null;
	this.pr = null;
	this.PS = new Array()
	this.PS.push({st: 1, se: 0});
	
	var result;
	var i;
	var opm = 0; // operator missing
	var cdb = "t"; // current database
	while ((result = lexer.exec(query_expression)) != null) {
		var sem = result[0]; // semantic value
		var sym = 0; // symbol value
		for (i in keyws) {
			if (sem == keyws[i]) {
				sym = codem[i];
				if (semvm[i])
					sem = semvm[i];
				break;
			}
		}

		// lexical preprocessor
		// 1) implicit db settings
		// 2) implicit operator '&'
		if (sym == 5) { // db change is stored but not passed
			cdb = sem;
			continue;
		}
		if (sym == 3) // operator
			opm = 0;
		if ((sym == 0 || sym == 1) && opm) { 
			if (this.SM(3, "&")) // insert missing '&'
				return;
			opm = 0;
		}
		if (sym == 0) { // condition
			if (sem.charAt(0) == '"' || sem.charAt(0) == "'")
				sem = sem.slice(1, sem.length - 1);
			if ("URI" != query_type) 
			{
				sem = Gkod.Escape.MyEscape(sem.toLowerCase());
			}
			sem = cdb + sem;
			opm = 1;
		}
		if (this.SM(sym, sem))
			return;
	}
	if (!this.SM(5, "$")) {
		this.ev = this.PS[1].se.ev;
		this.pr = this.PS[1].se.pr;
	}
//	alert(this.ev + "\n" + this.pr);
},

SM: function(sym, sem)
{
//	alert(sym + ", " + sem);
	while (1) {
		var sp = this.PS[this.PS.length - 1];
		var ptv = this.PT[sp.st][sym];
		if (ptv == 10) {
//			alert("accept");
			return false;
		}
		if (ptv == 0) {
//			alert("error");
			return true; // error
		}
		if (ptv > 0) { // shift
			this.PS.push({st: ptv, se: sem});
			return false;
		}
		if (ptv < 0) {
			var nsem;
			var p = this.PS.length;
			var p1 = this.PS[p - 1];
			var p2 = this.PS[p - 2];
			var p3 = this.PS[p - 3];
			switch (-ptv) {
				case 1: 
					nsem = { 
					ev: "{a:'s', d:'" + p1.se.charAt(0) + "', p:'" + p1.se.slice(1) + "'}", 
					pr: p1.se.slice(1) }; 
					break;
				case 2:	
					if (p1.se == "!") {
						nsem = { ev: "{a:'s', d:'" + p2.se.charAt(0) + "', p:'" + p2.se.slice(1) + "', m:'" + p1.se + "'}" };
					} else {
						var ss = p2.se.slice(1, parseInt(p1.se) + 1) + "$002A";
						nsem = {
						ev: "{a:'s', d:'" + p2.se.charAt(0) + "', p:'" + p2.se.slice(1) +
						"'}, {a:'s', d:'" + p2.se.charAt(0) + "', p:'" + ss + 
						"'}, {a:'o', p:'|'}" };
					}
					nsem.pr = p2.se.slice(1);
					break;
				case 3: nsem = {
					ev: p3.se.ev + ", " + p1.se.ev + ", {a:'o', p:'" + p2.se + "'}",
					pr: p3.se.pr + (p2.se == "|" ? " or " : " ") + p1.se.pr };
					break;
				case 4: nsem = {
					ev: p2.se.ev,
					pr: "(" + p2.se.pr + ")" };	
					ptv = -3;
					break;
			}
			if (ptv == -1 || ptv == -2) {
				nsem.pr = decodeURIComponent(nsem.pr);
				if (nsem.pr.search(/\s/) != -1)
					nsem.pr = '"' + nsem.pr + '"';
			}
			this.PS.length += ptv;
			this.PS.push({st: this.PT[this.PS[this.PS.length - 1].st][6], se: nsem});
		}
	}
},

o: function(op, op1, op2)
{
	debug.insertAdjacentHTML("beforeEnd", "<div>" + op + ", " + op1 + ", " + op2 + "</div>");
	return op1 + op + op2;
},

e: function(db, se, st)
{
	if (!st)
		st = "";
	se = decodeURIComponent(se);
	debug.insertAdjacentHTML("beforeEnd", "<div>" + db + ", " + se + ", " + st + "</div>");
	
	return db + "=" + se + st;
}
};

var QueryProcessor = {
	rr: null,
Start: function(q, r)
{
	this.Stop();
	this.rr = r;
	eval("this.qa = [" + q + "]");
	this.qp = 0;
	this.Eval();
},

Stop: function()
{
	//jsdbfile.src = null; 
//	jsdbfile.src = datasourceroot + "dummy.js";
},

Eval: function()
{
	var n = this.qa[this.qp];
	if (n.a == "s") {
		var m = n.d == "t" ? false : true;
		if (n.m == "!")
			m = !m;
		SearchDBs[n.d].Search(decodeURIComponent(n.p), m);
	} else if (n.a == "o") {
		if (n.p == "&")
			this.qa[this.qp - 2].And(this.qa[this.qp - 1]);
		else
			this.qa[this.qp - 2].Or(this.qa[this.qp - 1]);
		this.qp -= 2;
		this.qa.splice(this.qp + 1, 2);
		this.Next();
	}
},

Next: function()
{
	if (this.qa.length == 1) {
		this.rr(this.qa[0].rs);
		return;
	}
	this.qp++;
	this.Eval();
},

ReportResult: function(r)
{
	this.qa[this.qp] = r;
	this.Next();
}
};

function ReadBase64_6(i)
{
	if (i == 43)
		return 62;
	if (i == 45)
		return 63;
	if (i < 58)
		return i - 48;
	if (i < 91)
		return i - 55;
	else
		return i - 61;
}

function ReadBase64_32(s)
{
	var i, j;
	j = 0;
	i = 0x20;
	while (i & 0x20) {
		i = ReadBase64_6(s.s.charCodeAt(s.p));
		j <<= 5;
		j |= (i & 0x1f);
		s.p++;
	}
	return j;
}

function ReadBase64_ITP(s, ctr)
{
	var r = new Array();
	var c, n, l = 0;
	while (s.p < s.s.length) {
		n = ReadBase64_32(s);
		c = 1 == n ? ReadBase64_32(s) : 1;
		while (c) {
			l += n;
			r.push(new ctr(l));
			c--;
		}
	}
	return r;
}

function SearchDB(dbid)
{
	this.db_id = dbid;
	this.ResetIndex();
	this.request_total = 0;
	this.request_count = 0;
}

SearchDB.prototype.ResetIndex = function()
{
	this.index = new Array();
	this.index.push({ key: null, node: "1" });
}

SearchDB.prototype.k = function(args)
{
	var prev = "";
	for (var i = 0; i < args.length; i++) {
		var s = { s: args[i], p: 0 };
		var l;
		var w = "";
		l = ReadBase64_32(s);
		var nk;
		nk = i == args.length - 1 ? this.index[this.index_insert_position]: new Object;
		nk.node = l > 0 ? s.s.slice(s.p, s.p + l): 0;
		s.p += l;
		l = ReadBase64_32(s);
		w += prev.slice(0, l);
		l = ReadBase64_32(s);
		w += s.s.slice(s.p, s.p + l);
		s.p += l;
		if (w.length > 0) {
			nk.key = w;
		}
		prev = w;
		while (s.p < s.s.length) {
			nk.values = new Array();
			l = ReadBase64_32(s);
			nk.values.push(s.s.slice(s.p, s.p + l));
			s.p += l;
		}
		if (i < args.length - 1) {
			this.index.splice(this.index_insert_position, 0, nk);
			this.index_insert_position++;
		}
	}
	this.d();
}

SearchDB.prototype.LoadScript = function(f)
{
	CDB=this;
	var dbPath = ConvertDbSelector[this.db_id];
//	setTimeout("jsdbfile.src='" + datasourceroot + dbPath + "/" + f + ".js'", 1);
	var s="SearchDBs."+this.db_id+".LoadScript_Callback";
	LoadXMLDocArray(datasourceroot+dbPath+"/"+f+".xml",s,"","N");
	this.request_total++;
	this.request_count++;
}

SearchDB.prototype.LoadScript_Callback = function(a)
{
	CDB=this;
	CDB.k(a);	
}

SearchDB.prototype.Search = function(s, m)
{
	this.RequestCount = 0;
	this.search = s;
	this.exact_match = m;
	this.results = new SearchResultSet();
	if (this.search.length == 0)
		return;
	this.index_match = 0;
	this.d = this.d1;
	this.d();
}

SearchDB.prototype.IndexSearch = function()
{
	var i;
	for (i = this.index_match; i < this.index.length; i++)
		if (null == this.index[i].key || this.search <= this.index[i].key)
			break;

	this.index_match = i;
}

SearchDB.prototype.d1 = function()
{
	this.IndexSearch();
	if (null != this.index[this.index_match].key && this.search == this.index[this.index_match].key) {
		if (!this.exact_match && this.index[this.index_match].values.length < 2) {
			this.d = this.d2;
			this.d();
		} else {
			var v = this.index[this.index_match].values;
			for (var j in v) {
				this.results.Or(new SearchResultSet(v[j]));
				if (this.exact_match)
					break;
			}			
			QueryProcessor.ReportResult(this.results);
		}
	} else {
		if (this.index[this.index_match].node != 0) {
			this.index_insert_position = this.index_match;
			this.LoadScript(this.index[this.index_match].node);
		} else {
			if (!this.exact_match) {
				this.d = this.d2;
				this.d();
			}
			else {
				QueryProcessor.ReportResult(this.results);
			}
		}
	}
}

SearchDB.prototype.d2 = function()
{
	if (null == this.index[this.index_match].key || (this.index[this.index_match].key.substring(0, this.search.length) != this.search && this.index[this.index_match].node == 0)) {
		QueryProcessor.ReportResult(this.results);
		return;
	}
	if (this.index[this.index_match].node == 0) {
		this.results.Or(new SearchResultSet(this.index[this.index_match].values[0]));
		this.index_match++;
		this.d2();
	} else {
		this.index_insert_position = this.index_match;
		this.LoadScript(this.index[this.index_match].node);
	} 
}

SearchDBs = { t: new SearchDB("t"), u: new SearchDB("u"), e: new SearchDB("e"), r: new SearchDB("r"), g: new SearchDB("g") };
CDB = null;

function SearchResult(index)
{
    this.index = index;
    this.weight = 1.0;
}

function SearchResultSet(s)
{
	if (s) {
		var ss = { s: s, p: 0 };
		this.rs = ReadBase64_ITP(ss, SearchResult);
	} else
		this.rs = new Array();
}

SearchResultSet.prototype.Or = function(srs)
{
    this.AOR(srs, true);
}

SearchResultSet.prototype.AddWithWeight = function(srs, weight)
{
    this.AOR(srs, false, weight);
}

SearchResultSet.prototype.AOR = function(srs, or, weight)
{
	var i, j;
	for (i = 0, j = 0; i < srs.rs.length; i++) {
		while (j < this.rs.length && this.rs[j].index < srs.rs[i].index)
			j++;
		if (j == this.rs.length || this.rs[j].index != srs.rs[i].index)
			this.rs.splice(j, 0, srs.rs[i]);
		else {
		    var w1 = this.rs[j].weight;
		    var w2 = srs.rs[i].weight;
            this.rs[j].weight = or ? Math.max(w1, w2) : w1 + w2 * weight;
		}
	}
}

SearchResultSet.prototype.And = function(srs)
{
	var i, j;
	for (i = 0, j = 0; i < srs.rs.length && j < this.rs.length; i++) {
		while (j < this.rs.length && this.rs[j].index < srs.rs[i].index)
			this.rs.splice(j, 1);
		if (j < this.rs.length && srs.rs[i].index == this.rs[j].index) {
		    var w1 = this.rs[j].weight;
		    var w2 = srs.rs[i].weight;
	        this.rs[j].weight = Math.min(w1, w2);
			j++;
	    }
	}
	this.rs.splice(j, this.rs.length - j);
}

SearchResultSet.prototype.Multiply = function(m)
{
    var i;
    for (i = 0; i < this.rs.length; i++)
        this.rs[i].weight *= m;
}