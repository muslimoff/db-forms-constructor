-- Start of DDL Script for Package FC.LOOKUPS_PKG
-- Generated 10.04.2010 22:27:33 from FC@VM_XE

Create Or Replace 
PACKAGE lookups_pkg As
  Procedure p_ins_upd(p_lookup_code In Out Varchar2,
                      p_lookup_name Varchar2);
  Procedure p_delete(p_lookup_code Varchar2);
End;
/


Create Or Replace 
PACKAGE BODY lookups_pkg As
  Procedure p_ins_upd(p_lookup_code In Out Varchar2,
                      p_lookup_name Varchar2) Is
  Begin
    form_utils.check_nulls(args_t(p_lookup_code),
                           args_t('Не указан код списка'));
    Update lookups l
       Set lookup_name = p_lookup_name
     Where l.lookup_code = p_lookup_code;
  
    If Sql%Rowcount = 0 And p_lookup_code || p_lookup_name Is Not Null Then
      p_lookup_code := NVL(p_lookup_code, UPPER(p_lookup_name));
    
      Insert Into lookups
        (lookup_code, lookup_name)
      Values
        (p_lookup_code, p_lookup_name);
    End If;
  End;
  Procedure p_delete(p_lookup_code Varchar2) as
  begin
    delete from LOOKUP_VALUES where lookup_code = p_lookup_code;
    delete from LOOKUPS where lookup_code = p_lookup_code;
  end;
End;
/


-- End of DDL Script for Package FC.LOOKUPS_PKG

