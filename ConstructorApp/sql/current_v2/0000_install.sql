SPOOL install.log
ACCEPT instance_name DEFAULT xe PROMPT 'instance (default XE): '
PROMPT Enter DBA Username(default SYSTEM). If not SYS - grant privileges on SYS Objects manualy by starting script "sys_grants.sql "
ACCEPT dba_user DEFAULT SYSTEM PROMPT 'DBA Username (default SYSTEM): '
ACCEPT dba_pass DEFAULT simsim PROMPT 'DBA Password: ' HIDE	
ACCEPT fc_user DEFAULT FC50 PROMPT 'FC Username (default FC50): '
ACCEPT fc_user_pass DEFAULT fc PROMPT 'FC Password: ' HIDE
ACCEPT fc_user_ts DEFAULT HP_DATA PROMPT 'FC Tablespace (default HP_DATA): '

CONN &dba_user/&dba_pass@&instance_name 
PROMPT Press Enter to start
PAUSE

rem as sysdba
PROMPT Create user
@0100_create_user.sql


CONN &fc_user/&fc_user_pass@&instance_name

PROMPT Create &fc_user Objects
@0200_create_fc_objects.sql

PROMPT Compile invalid objects.....
@0300_compile_invalids.sql

PROMPT Select invalid Objects....
Select o.object_name From user_objects o Where o.status = 'INVALID';

PROMPT Completed... Press Enter to exit
PAUSE
EXIT