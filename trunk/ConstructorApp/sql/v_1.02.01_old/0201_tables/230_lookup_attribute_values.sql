Create Table fc22.lookup_attribute_values
    (lookup_code                    Varchar2(255),
    lookup_value_code              Varchar2(255),
    attribute_code                 Varchar2(255),
    attribute_value_number         Number,
    attribute_value_char           Varchar2(2000),
    attribute_value_date           Date)
/



Alter Table fc22.lookup_attribute_values
Add Constraint lookup_attribute_values_fk1 Foreign Key (lookup_code, 
  attribute_code)
References FC22.lookup_attributes (lookup_code,attribute_code)
/
Alter Table fc22.lookup_attribute_values
Add Constraint lookup_attribute_values_fk2 Foreign Key (lookup_code, 
  lookup_value_code)
References FC22.lookup_values (lookup_code,lookup_value_code)
/
