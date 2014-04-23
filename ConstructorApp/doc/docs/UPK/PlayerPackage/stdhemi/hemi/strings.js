/*--
Copyright © 1998, 2009, Oracle and/or its affiliates.  All rights reserved.
--*/

//<!--Version 9.5.0.2-->


var strings1 = '../smarthelp/strings.resources';
var strings2 = '../smarthelp.resources';

var rm = Gkod.Helper.CreateResourceManager();
rm.AttachResource(strings1);
rm.AttachResource(strings2);
rm.LoadResources();
var rc = rm.GetStrings();

for (i in rc) {
    window[i] = rc[i];
}

res = {};
res['IDS_BUTTONTEXT'] = PRODUCTNAME;
res['IDS_WARNING_CAPTION'] = PRODUCTNAME + ' ' + SH_WARNING_TITLE;
res['IDS_NOT_LOADED'] = SH_NOTLOADED;
res['IDS_ERROR_CAPTION'] = PRODUCTNAME + ' ' + SH_ERROR_TITLE;
res['IDS_CONTACT'] = SH_CONTACT;
res['IDS_ERROR_CODE'] = SH_ERROR_CODE;
res['IDS_NO_ACCESS'] = SH_NOACCESS;
res['IDS_NEW_VERSION'] = SH_NEWVERSION;
res['IDS_UPGRADE'] = SH_UPGRADE;
res['IDS_INCOMPATIBLE'] = SH_INCOMPATIBLE;
res['IDS_ERROR'] = SH_ERROR;
res['IDS_NOCONTENT'] = SH_NOCONTENT;