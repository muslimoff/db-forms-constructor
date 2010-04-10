-- Start of DDL Script for View FC.BINDS_V
-- Generated 10.04.2010 22:52:53 from FC@VM_XE

CREATE force View binds_v (
   form_code,
   position,
   datatype,
   max_length,
   array_len,
   bind_name )
As
Select "FORM_CODE", "POSITION", "DATATYPE", "MAX_LENGTH", "ARRAY_LEN", "BIND_NAME"
     From Table (form_utils.get_binds ())
/


-- End of DDL Script for View FC.BINDS_V

