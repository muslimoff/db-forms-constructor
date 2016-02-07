
package com.abssoft.constructor.client.widgets.codemirror;
public enum Mode {
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_APL.gwt.xml to make this work
	 */
	APL("text/apl", "codemirror/mode/apl/apl.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_ASTERISK.gwt.xml to make this work
	 */
	ASTERISK("text/x-asterisk", "codemirror/mode/asterisk/asterisk.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_CLIKE.gwt.xml to make this work
	 */
	CLIKE("keywords", "codemirror/mode/clike/clike.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_CLOJURE.gwt.xml to make this work
	 */
	CLOJURE("text/x-clojure", "codemirror/mode/clojure/clojure.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_COBOL.gwt.xml to make this work
	 */
	COBOL("text/x-cobol", "codemirror/mode/cobol/cobol.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_COFFEESCRIPT.gwt.xml to make this work
	 */
	COFFEESCRIPT("text/x-coffeescript", "codemirror/mode/coffeescript/coffeescript.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_COMMONLISP.gwt.xml to make this work
	 */
	COMMONLISP("text/x-common-lisp", "codemirror/mode/commonlisp/commonlisp.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_CSS.gwt.xml to make this work
	 */
	CSS("text/css", "codemirror/mode/css/css.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_D.gwt.xml to make this work
	 */
	D("text/x-d", "codemirror/mode/d/d.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_DIFF.gwt.xml to make this work
	 */
	DIFF("text/x-diff", "codemirror/mode/diff/diff.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_DTD.gwt.xml to make this work
	 */
	DTD("application/xml-dtd", "codemirror/mode/dtd/dtd.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_ECL.gwt.xml to make this work
	 */
	ECL("text/x-ecl", "codemirror/mode/ecl/ecl.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_EIFFEL.gwt.xml to make this work
	 */
	EIFFEL("text/x-eiffel", "codemirror/mode/eiffel/eiffel.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_ERLANG.gwt.xml to make this work
	 */
	ERLANG("text/x-erlang", "codemirror/mode/erlang/erlang.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_FORTRAN.gwt.xml to make this work
	 */
	FORTRAN("text/x-Fortran", "codemirror/mode/fortran/fortran.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_GAS.gwt.xml to make this work
	 */
	GAS("architecture", "codemirror/mode/gas/gas.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_GFM.gwt.xml to make this work
	 */
	GFM("gfm", "codemirror/mode/gfm/gfm.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_GHERKIN.gwt.xml to make this work
	 */
	GHERKIN("text/x-feature", "codemirror/mode/gherkin/gherkin.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_GLSL.gwt.xml to make this work
	 */
	GLSL("text/x-glsl", "codemirror/mode/glsl/glsl.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_GO.gwt.xml to make this work
	 */
	GO("text/x-go", "codemirror/mode/go/go.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_GROOVY.gwt.xml to make this work
	 */
	GROOVY("text/x-groovy", "codemirror/mode/groovy/groovy.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_HAML.gwt.xml to make this work
	 */
	HAML("text/x-haml", "codemirror/mode/haml/haml.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_HASKELL.gwt.xml to make this work
	 */
	HASKELL("text/x-haskell", "codemirror/mode/haskell/haskell.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_HAXE.gwt.xml to make this work
	 */
	HAXE("text/x-haxe", "codemirror/mode/haxe/haxe.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_HTMLEMBEDDED.gwt.xml to make this work
	 */
	HTMLEMBEDDED("application/x-aspx", "codemirror/mode/htmlembedded/htmlembedded.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_HTMLMIXED.gwt.xml to make this work
	 */
	HTMLMIXED("scriptTypes", "codemirror/mode/htmlmixed/htmlmixed.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_HTTP.gwt.xml to make this work
	 */
	HTTP("message/http", "codemirror/mode/http/http.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_JADE.gwt.xml to make this work
	 */
	JADE("text/x-jade", "codemirror/mode/jade/jade.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_JAVASCRIPT.gwt.xml to make this work
	 */
	JAVASCRIPT("json", "codemirror/mode/javascript/javascript.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_JINJA2.gwt.xml to make this work
	 */
	JINJA2("jinja2", "codemirror/mode/jinja2/jinja2.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_JULIA.gwt.xml to make this work
	 */
	JULIA("text/x-julia", "codemirror/mode/julia/julia.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_LESS.gwt.xml to make this work
	 */
	LESS("text/x-less", "codemirror/mode/less/less.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_LIVESCRIPT.gwt.xml to make this work
	 */
	LIVESCRIPT("text/x-livescript", "codemirror/mode/livescript/livescript.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_LUA.gwt.xml to make this work
	 */
	LUA("specials", "codemirror/mode/lua/lua.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_MARKDOWN.gwt.xml to make this work
	 */
	MARKDOWN("text/x-markdown", "codemirror/mode/markdown/markdown.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_MIRC.gwt.xml to make this work
	 */
	MIRC("text/mirc", "codemirror/mode/mirc/mirc.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_NGINX.gwt.xml to make this work
	 */
	NGINX("text/nginx", "codemirror/mode/nginx/nginx.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_NTRIPLES.gwt.xml to make this work
	 */
	NTRIPLES("text/n-triples", "codemirror/mode/ntriples/ntriples.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_OCAML.gwt.xml to make this work
	 */
	OCAML("text/x-ocaml", "codemirror/mode/ocaml/ocaml.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_OCTAVE.gwt.xml to make this work
	 */
	OCTAVE("text/x-octave", "codemirror/mode/octave/octave.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_PASCAL.gwt.xml to make this work
	 */
	PASCAL("text/x-pascal", "codemirror/mode/pascal/pascal.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_PEGJS.gwt.xml to make this work
	 */
	PEGJS("pegjs", "codemirror/mode/pegjs/pegjs.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_PERL.gwt.xml to make this work
	 */
	PERL("text/x-perl", "codemirror/mode/perl/perl.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_PHP.gwt.xml to make this work
	 */
	PHP("application/x-httpd-php", "codemirror/mode/php/php.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_PIG.gwt.xml to make this work
	 */
	PIG("text/x-pig", "codemirror/mode/pig/pig.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_PROPERTIES.gwt.xml to make this work
	 */
	PROPERTIES("text/x-properties", "codemirror/mode/properties/properties.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_PYTHON.gwt.xml to make this work
	 */
	PYTHON("text/x-python", "codemirror/mode/python/python.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_Q.gwt.xml to make this work
	 */
	Q("text/x-q", "codemirror/mode/q/q.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_R.gwt.xml to make this work
	 */
	R("text/x-rsrc", "codemirror/mode/r/r.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_RPM_CHANGES.gwt.xml to make this work
	 */
	RPM_CHANGES("text/x-rpm-changes", "codemirror/mode/rpm/changes/changes.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_RPM_SPEC.gwt.xml to make this work
	 */
	RPM_SPEC("text/x-rpm-spec", "codemirror/mode/rpm/spec/spec.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_RST.gwt.xml to make this work
	 */
	RST("python", "codemirror/mode/rst/rst.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_RUBY.gwt.xml to make this work
	 */
	RUBY("text/x-ruby", "codemirror/mode/ruby/ruby.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_RUST.gwt.xml to make this work
	 */
	RUST("text/x-rustsrc", "codemirror/mode/rust/rust.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_SASS.gwt.xml to make this work
	 */
	SASS("text/x-sass", "codemirror/mode/sass/sass.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_SCHEME.gwt.xml to make this work
	 */
	SCHEME("text/x-scheme", "codemirror/mode/scheme/scheme.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_SHELL.gwt.xml to make this work
	 */
	SHELL("text/x-sh", "codemirror/mode/shell/shell.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_SIEVE.gwt.xml to make this work
	 */
	SIEVE("application/sieve", "codemirror/mode/sieve/sieve.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_SMALLTALK.gwt.xml to make this work
	 */
	SMALLTALK("text/x-stsrc", "codemirror/mode/smalltalk/smalltalk.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_SMARTY.gwt.xml to make this work
	 */
	SMARTY("text/x-smarty", "codemirror/mode/smarty/smarty.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_SMARTYMIXED.gwt.xml to make this work
	 */
	SMARTYMIXED("text/x-smarty", "codemirror/mode/smartymixed/smartymixed.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_SPARQL.gwt.xml to make this work
	 */
	SPARQL("application/x-sparql-query", "codemirror/mode/sparql/sparql.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_SQL.gwt.xml to make this work
	 */
	SQL("text/x-sql", "codemirror/mode/sql/sql.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_STEX.gwt.xml to make this work
	 */
	STEX("text/x-stex", "codemirror/mode/stex/stex.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_TCL.gwt.xml to make this work
	 */
	TCL("text/x-tcl", "codemirror/mode/tcl/tcl.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_TIDDLYWIKI.gwt.xml to make this work
	 */
	TIDDLYWIKI("text/x-tiddlywiki", "codemirror/mode/tiddlywiki/tiddlywiki.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_TIKI.gwt.xml to make this work
	 */
	TIKI("tiki", "codemirror/mode/tiki/tiki.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_TOML.gwt.xml to make this work
	 */
	TOML("text/x-toml", "codemirror/mode/toml/toml.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_TURTLE.gwt.xml to make this work
	 */
	TURTLE("text/turtle", "codemirror/mode/turtle/turtle.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_VB.gwt.xml to make this work
	 */
	VB("text/x-vb", "codemirror/mode/vb/vb.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_VBSCRIPT.gwt.xml to make this work
	 */
	VBSCRIPT("text/vbscript", "codemirror/mode/vbscript/vbscript.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_VELOCITY.gwt.xml to make this work
	 */
	VELOCITY("text/velocity", "codemirror/mode/velocity/velocity.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_VERILOG.gwt.xml to make this work
	 */
	VERILOG("keywords", "codemirror/mode/verilog/verilog.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_XML.gwt.xml to make this work
	 */
	XML("htmlMode (boolean)", "codemirror/mode/xml/xml.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_XQUERY.gwt.xml to make this work
	 */
	XQUERY("application/xquery", "codemirror/mode/xquery/xquery.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_YAML.gwt.xml to make this work
	 */
	YAML("text/x-yaml", "codemirror/mode/yaml/yaml.js"),
	/**
	 * You need to inherit com.googlecode.gwtcodemirror.GwtCodeMirror_Z80.gwt.xml to make this work
	 */
	Z80("text/x-z80", "codemirror/mode/z80/z80.js"),
	;
	private final String mimeType;
	private final String jsPath;
	Mode(String mimeType, String jsPath) {
		this.mimeType = mimeType;
		this.jsPath = jsPath;
	}
	public String getMimeType() {
		return mimeType;
	}
	public String getJsPath() {
			return jsPath;
	}
}