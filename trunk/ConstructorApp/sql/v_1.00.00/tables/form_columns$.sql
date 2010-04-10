-- Start of DDL Script for Table FC.FORM_COLUMNS$
-- Generated 10.04.2010 20:50:53 from FC@VM_XE

Create Table form_columns$
    (col_num                        Number,
    col_type                       Varchar2(255),
    col_max_len                    Number,
    col_name                       Varchar2(4000),
    col_name_len                   Number,
    col_precision                  Number,
    col_scale                      Number,
    form_code                      Varchar2(255),
    pimary_key_flag                Varchar2(1),
    default_column_width           Varchar2(30),
    column_description             Varchar2(4000))
/





-- Constraints for FORM_COLUMNS$

Alter Table form_columns$
Add Constraint form_columns$_uk Unique (form_code, col_name)
Using Index
/


-- End of DDL Script for Table FC.FORM_COLUMNS$

