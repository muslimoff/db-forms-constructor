SPOOL install.log
ACCEPT instance_name DEFAULT vm_xe PROMPT 'instance (default VM_XE): '
PROMPT Enter DBA Username(default SYS). If not SYS - grant privileges on SYS Objects manualy by starting script "sys_grants.sql "
ACCEPT dba_user DEFAULT SYS PROMPT 'DBA Username: '
ACCEPT dba_pass DEFAULT simsim PROMPT 'DBA Password: ' HIDE	
ACCEPT fc_user DEFAULT FC22 PROMPT 'FC Username (default FC22): '
ACCEPT fc_user_pass DEFAULT FC PROMPT 'FC Password: ' HIDE
ACCEPT fc_user_ts DEFAULT HP_DATA PROMPT 'FC Tablespace (default HP_DATA): '

CONN &dba_user/&dba_pass@&instance_name 
PROMPT Press Enter to start
PAUSE

rem as sysdba
PROMPT Create user
@create_user.sql


CONN &fc_user/&fc_user_pass@&instance_name

PROMPT Create &fc_user Objects

@tables\_tables.sql
@views\_views.sql
@storedproc\_storedproc.sql
@data\_data.sql

@compile_invalids.sql
PROMPT Select invalid Objects....
Select o.object_name From user_objects o Where o.status = 'INVALID';

PROMPT Completed... Press Enter to exit
PAUSE
EXIT