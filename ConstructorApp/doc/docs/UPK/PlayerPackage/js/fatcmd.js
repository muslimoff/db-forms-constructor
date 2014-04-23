/*--
Copyright © 1998, 2009, Oracle and/or its affiliates.  All rights reserved.
--*/

function FatPlayerCommand(cmd,params)
{
	var cmdurl="about:blank"+"?FatCmd="+cmd;
	if (params)
		cmdurl+="&"+params;
	window.navigate(cmdurl);
}
  