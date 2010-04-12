alter table forms disable all triggers;

@@data\forms\_forms.sql 

commit;

alter table forms enable all triggers;