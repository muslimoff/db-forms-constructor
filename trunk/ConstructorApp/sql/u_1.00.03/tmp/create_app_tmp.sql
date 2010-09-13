grant create user to fc22;
----
Drop USER dd1 Cascade
/
Create USER dd1 Identified By dd1 DEFAULT Tablespace hp_data Temporary Tablespace temp
/

Begin
   APPLICATIONS_PKG.create_new_application ('dd1', 'hp_data');
End;

