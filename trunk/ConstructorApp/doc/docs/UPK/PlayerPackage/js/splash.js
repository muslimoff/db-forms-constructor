/*--
Copyright © 1998, 2009, Oracle and/or its affiliates.  All rights reserved.
--*/

function SplashWindow()
{
//	var x=window.screen.availWidth;
//	var y=window.screen.availHeight;

	var x=document.documentElement.offsetWidth;
	var y=document.documentElement.offsetHeight;

	document.open();

	document.writeln("<script>function ShowSplash()");
	document.writeln("{document.getElementById('splash').style.display='block';}");
	document.writeln("</script>");

	document.writeln("<DIV id='splash' style='display:none;position:absolute;left:0;top:"+(y/2-50)+";width:"+x+";height:200'>");
	document.writeln("<p align='center'><font color='#FF0000' face='Arial' style='font-size:11pt'>");
	document.writeln(R_splashtext);
	document.writeln("</font></p>");
	document.writeln("</DIV>");
	document.writeln("<script>setTimeout('ShowSplash()',2000);</script>");
	document.close();
};

SplashWindow();




