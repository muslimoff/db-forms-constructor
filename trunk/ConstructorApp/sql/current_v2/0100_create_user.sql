-- Drop the old instance of &fc_user
Drop USER &fc_user
  Cascade
/
Create USER &fc_user
Identified By &fc_user_pass
DEFAULT Tablespace &fc_user_ts
--Temporary Tablespace TEMP
Quota Unlimited On &fc_user_ts
/
Grant Create ANY Procedure To &fc_user
/
Grant Create ANY Table To &fc_user
/
Grant Create USER To &fc_user
/
Grant Create View To &fc_user
/
Grant Drop ANY Table To &fc_user
/
Grant Select ANY Table To &fc_user
/
Grant Connect To &fc_user
/
Grant FC_ADMIN To &fc_user
/
Grant Resource To &fc_user
/
Grant Select_catalog_role To &fc_user
/
Grant XDB_WEBSERVICES To &fc_user
/
Grant XDB_WEBSERVICES_OVER_HTTP To &fc_user
/
Grant XDB_WEBSERVICES_WITH_PUBLIC To &fc_user
/
Alter USER &fc_user DEFAULT Role All
/
rem @@sys_grants.sql