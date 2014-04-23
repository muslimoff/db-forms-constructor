/*--
Copyright © 1998, 2009, Oracle and/or its affiliates.  All rights reserved.
--*/

//<!--Version 9.6.0.6-->

Types.ApplicationScripts = new GkodConfig.Array
  (
    {'ValueColumn':370},
    new GkodConfig.Url()
  );

Defaults.OD_ENABLESMARTHELP = 0;
Defaults.OD_APPLICATIONSCRIPTS_URL = new Array();
Defaults.OD_STRICTURLCHECK = 0;
Defaults.OD_STANDARD_URL = '';
Defaults.OD_CUSTOMERRORHTML = 0;
Defaults.OD_ENABLESMARTMATCH = 1;
Defaults.OD_SMARTMATCH_URL = '';

Page.AddVariable('OD_ENABLESMARTHELP',        Types.Enabled, { advanced: true });
//Page.AddVariable('OD_CUSTOMERRORHTML',        Types.Enabled);

Page.AddSection('CONTEXT');
Page.AddVariable('OD_APPLICATIONSCRIPTS_URL', Types.ApplicationScripts);
//Page.AddVariable('OD_STRICTURLCHECK',         Types.YesNo);
Page.AddVariable('OD_SMARTMATCH_URL',         Types.Url);
Page.AddVariable('OD_STANDARD_URL',           Types.Url);


Page.AddSection('ADVANCED');
Page.AddVariable('OD_ENABLESMARTMATCH',       Types.Enabled);
Page.AddVariable('OD_GENERICAPPLICATIONNAME', Types.ApplicationName);
