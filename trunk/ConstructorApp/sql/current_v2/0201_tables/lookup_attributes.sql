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


-- End of DDL Script for Table FC22.LOOKUP_ATTRIBUTES

