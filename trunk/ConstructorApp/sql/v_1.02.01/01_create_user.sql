--
Drop User &fc_user Cascade;

Create User &fc_user
Identified By &fc_user_pass
Default Tablespace &fc_user_ts
Temporary Tablespace TEMP
/
--ROLE GRANTS
Grant CREATE ANY PROCEDURE To &fc_user
/
Grant CREATE ANY TABLE To &fc_user
/
Grant DROP ANY TABLE To &fc_user
/
Grant SELECT ANY TABLE To &fc_user
/
Grant UNLIMITED TABLESPACE To &fc_user
/
Grant CONNECT To &fc_user
/
Grant DBA To &fc_user
/
Grant RESOURCE To &fc_user
/
Alter User &fc_user Default Role All
/
Grant SELECT On dba_data_files To &fc_user
/
Grant SELECT On dba_objects To &fc_user
/
Grant SELECT On dba_role_privs To &fc_user
/
Grant SELECT On dba_source To &fc_user
/
Grant SELECT On dba_sys_privs To &fc_user
/
Grant SELECT On dba_tab_columns To &fc_user
/
Grant SELECT On dba_users To &fc_user
/

