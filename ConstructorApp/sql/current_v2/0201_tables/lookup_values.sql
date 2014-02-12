Create Table lookup_values
    (lookup_code                    Varchar2(255),
    lookup_value_code              Varchar2(255),
    lookup_display_value           Varchar2(255),
    lookup_value_id                Number Not Null)
/


-- Constraints for LOOKUP_VALUES

Alter Table lookup_values
Add Constraint lookup_value_id_pk Primary Key (lookup_value_id)
Using Index
/

Alter Table lookup_values
Add Constraint lookup_value_uk Unique (lookup_code, lookup_value_code)
Using Index
/


-- Triggers for LOOKUP_VALUES

Create Or Replace Trigger lookup_values_biud
 Before
  Insert Or Delete Or Update
 On lookup_values
Referencing New As New Old As Old
 For Each Row
Begin
   If INSERTING Then
      Select main_sq.Nextval
        Into :New.lookup_value_id
        From DUAL;
   End If;
End;
/


-- End of DDL Script for Table FC22.LOOKUP_VALUES

