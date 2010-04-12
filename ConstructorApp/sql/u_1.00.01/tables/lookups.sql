Create Sequence main_sq Start With 1
/
Alter Table lookup_values Add lookup_value_id Number
/
Update lookup_values
   Set lookup_value_id = main_sq.Nextval
/
Alter Table lookup_values
Add Constraint lookup_value_id_pk Primary Key (lookup_value_id)
Using Index
/
Create Or Replace Trigger lookup_values_biud
   Before Insert Or Delete Or Update
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


Alter Table lookup_values
Add Constraint lookup_value_uk Unique (lookup_code, lookup_value_code)
Using Index
/

Create Table lookup_attributes
    (lookup_code                    Varchar2(255),
    attribute_code                 Varchar2(255),
    attribute_name                 Varchar2(255),
    attribute_type                 Varchar2(1))
/
-- Constraints for LOOKUP_ATTRIBUTES

Alter Table lookup_attributes
Add Constraint lookup_attribute_uk Unique (lookup_code, attribute_code)
Using Index
/
-- End of DDL Script for Table FC22.LOOKUPS

Create Table lookup_attribute_values
    (lookup_code                    Varchar2(255),
    lookup_value_code              Varchar2(255),
    attribute_code                 Varchar2(255),
    attribute_value_number         Number,
    attribute_value_char           Varchar2(2000),
    attribute_value_date           Date)
/
-- Constraints for LOOKUP_ATTRIBUTE_VALUES



-- End of DDL Script for Table FC22.LOOKUP_ATTRIBUTE_VALUES

-- Foreign Key
Alter Table lookup_attribute_values
Add Constraint lookup_attribute_values_fk1 Foreign Key (lookup_code,
  attribute_code)
References lookup_attributes (lookup_code,attribute_code)
/
Alter Table lookup_attribute_values
Add Constraint lookup_attribute_values_fk2 Foreign Key (lookup_code,
  lookup_value_code)
References lookup_values (lookup_code,lookup_value_code)
/



Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_ACTIONS.ACTION_TYPE', '9', 'Фильтр')
/
