Create Table form_prop_values
    (prop_value_id                  Number,
    form_code                      Varchar2(4000),
    property_level                 Varchar2(4000),
    property_code                  Varchar2(4000),
    prop_val_level                 Varchar2(4000),
    value_char                     Varchar2(4000),
    value_number                   Number,
    value_date                     Date,
    value_clob                     CLOB)
/


-- Comments for FORM_PROP_VALUES

Comment On Column form_prop_values.prop_val_level Is 'SYSTEM->APP->PARENT_FORM->ROLE->USER (System - дл€ замены таблички FORM_COLUMNS$). ѕодумать о наследовании'
/

-- End of DDL Script for Table FC22.FORM_PROP_VALUES

