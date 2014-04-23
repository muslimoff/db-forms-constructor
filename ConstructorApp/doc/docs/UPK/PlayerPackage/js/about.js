/*--
Copyright © 1998, 2009, Oracle and/or its affiliates.  All rights reserved.
--*/

function OpenAbout(url)
{
	var strFeatures = "width=380,height=405,left="+(screen.availWidth-411)/2+",top="+(screen.availHeight-314)/2+ 
			",resizable=0,toolbar=0,scrollbars=0,location=0,menubar=0";
	window.open(url, "aboutwnd", strFeatures)
}
