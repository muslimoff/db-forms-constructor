-- Start of DDL Script for Type FC.ARGS_T
-- Generated 10.04.2010 23:00:42 from FC@VM_XE

Create Or Replace 
TYPE args_t                                                                                            as table of varchar2(4000)
/

-- Grants for Type
Grant Execute On args_t To public
/
Grant Execute On args_t To app_rates
/


-- End of DDL Script for Type FC.ARGS_T

