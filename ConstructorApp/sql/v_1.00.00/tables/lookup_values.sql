-- Start of DDL Script for Table FC.LOOKUP_VALUES
-- Generated 10.04.2010 20:53:35 from FC@VM_XE

Create Table lookup_values
    (lookup_code                    Varchar2(255),
    lookup_value_code              Varchar2(255),
    lookup_display_value           Varchar2(255))
/

-- Grants for Table
Grant Select On lookup_values To app_rates
/
Grant Select On lookup_values To mz_so_integration
/




-- End of DDL Script for Table FC.LOOKUP_VALUES

