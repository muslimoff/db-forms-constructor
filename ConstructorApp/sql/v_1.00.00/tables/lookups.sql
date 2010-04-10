-- Start of DDL Script for Table FC.LOOKUPS
-- Generated 10.04.2010 20:53:48 from FC@VM_XE

Create Table lookups
    (lookup_code                    Varchar2(255),
    lookup_name                    Varchar2(255))
/

-- Grants for Table
Grant Select On lookups To mz_so_integration
/




-- Comments for LOOKUPS

Comment On Column lookups.lookup_code Is 'Текстовый идентфикатор (ID)'
/
Comment On Column lookups.lookup_name Is 'Пользовательское имя'
/

-- End of DDL Script for Table FC.LOOKUPS

