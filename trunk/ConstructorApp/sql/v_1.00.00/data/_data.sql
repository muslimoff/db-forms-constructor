alter table forms disable all triggers;

@@forms.sql
@@form_tabs.sql
@@form_actions.sql
@@form_columns$.sql
@@form_columns.sql
@@lookups.sql
@@lookup_values.sql
@@menus.sql 
@@icons.sql 
@@global_params.sql 

REM CLOBs Data update
rem @@

commit;

alter table forms enable all triggers;