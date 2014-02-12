Create Table fc22.lookup_attributes
    (lookup_code                    Varchar2(255),
    attribute_code                 Varchar2(255),
    attribute_name                 Varchar2(255),
    attribute_type                 Varchar2(1))
/

Alter Table fc22.lookup_attributes
Add Constraint lookup_attribute_uk Unique (lookup_code, attribute_code)
Using Index
/

