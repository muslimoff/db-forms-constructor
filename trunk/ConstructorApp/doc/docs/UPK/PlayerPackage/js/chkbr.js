/*--
Copyright © 1998, 2009, Oracle and/or its affiliates.  All rights reserved.
--*/

var bver_ok;
/*if(navigator.appName.indexOf("Microsoft") != -1){
	var appVerArray = navigator.appVersion.split(";");
	var appVer = appVerArray[1];
	appVer = appVer.substr(6)
	appVer = parseFloat(appVer);
	bver_ok = (appVer>=5.5) ? true : false;
}
else{
	bver_ok = false;
}
if (!bver_ok)
{
	var url="";
	if (window.notsupp_baseurl)
		url=notsupp_baseurl;
	url+="notsupp.html";
	location.replace(url);
}*/
bver_ok = true;