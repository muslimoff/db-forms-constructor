SPOOL install.log
ACCEPT instance_name DEFAULT xe PROMPT 'instance (default XE): '
PROMPT Enter DBA Username(default SYS). If not SYS - grant privileges on SYS Objects manualy by starting script "sys_grants.sql "
ACCEPT dba_user DEFAULT SYS PROMPT 'DBA Username: '
ACCEPT dba_pass DEFAULT simsim PROMPT 'DBA Password: ' HIDE	
ACCEPT fc_user DEFAULT FC30 PROMPT 'FC Username (default FC30): '
ACCEPT fc_user_pass DEFAULT FC PROMPT 'FC Password: ' HIDE
ACCEPT fc_user_ts DEFAULT HP_DATA PROMPT 'FC Tablespace (default HP_DATA): '

CONN &dba_user/&dba_pass@&instance_name as sysdba
PROMPT Press Enter to start
PAUSE

rem as sysdba
PROMPT Create user
@01_create_user.sql
PROMPT End of "&fc_user" user creation.

CONN &fc_user/&fc_user_pass@&instance_name

PROMPT Create &fc_user Objects

@02_create_fc_objects.sql

@03_compile_invalids.sql
PROMPT Select invalid Objects....
Select o.object_name From user_objects o Where o.status = 'INVALID';

PROMPT Completed... Press Enter to exit
PAUSE
EXIT