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
-- End of DDL script for Foreign Key(s)
