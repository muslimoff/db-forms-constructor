alter table forms disable all triggers;

rem @@forms.sql
rem @@form_tabs.sql
rem @@form_actions.sql
rem @@form_columns$.sql
rem @@form_columns.sql
@@lookups.sql
@@lookup_values.sql
@@menus.sql 
@@icons.sql 
@@global_params.sql 
@@data\forms\_forms.sql 

commit;

alter table forms enable all triggers;