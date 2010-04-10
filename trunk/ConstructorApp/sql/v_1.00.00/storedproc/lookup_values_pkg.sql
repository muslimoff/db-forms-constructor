-- Start of DDL Script for Package FC.LOOKUP_VALUES_PKG
-- Generated 10.04.2010 22:27:22 from FC@VM_XE

Create Or Replace 
PACKAGE lookup_values_pkg As
  Procedure p_ins_upd(p_lookup_code          Varchar2,
                      p_lookup_value_code    Varchar2,
                      p_lookup_display_value Varchar2);

  Procedure p_delete(p_lookup_code Varchar2, p_lookup_value_code Varchar2);
End lookup_values_pkg;
/


Create Or Replace 
PACKAGE BODY lookup_values_pkg As
  /*
  SELECT a.lookup_code, a.lookup_value_code, a.lookup_display_value
    FROM lookup_values a
  */
  Procedure p_ins_upd(p_lookup_code          Varchar2,
                      p_lookup_value_code    Varchar2,
                      p_lookup_display_value Varchar2) Is
  Begin
    form_utils.check_nulls(args_t(p_lookup_code, p_lookup_value_code),
                           args_t('Не указан код списка',
                                  'Не указано значение списка'));
    Update lookup_values lv
       Set lookup_display_value = p_lookup_display_value
     Where lv.lookup_code = p_lookup_code
       And lv.lookup_value_code = p_lookup_value_code;
  
    If Sql%Rowcount = 0 And p_lookup_code Is Not Null And
       p_lookup_value_code Is Not Null Then
      Insert Into lookup_values
        (lookup_code, lookup_value_code, lookup_display_value)
      Values
        (p_lookup_code, p_lookup_value_code, p_lookup_display_value);
    End If;
  End p_ins_upd;

  Procedure p_delete(p_lookup_code Varchar2, p_lookup_value_code Varchar2) Is
  Begin
    delete from lookup_values lv
     where lv.lookup_code = p_lookup_code
       and lv.lookup_value_code = p_lookup_value_code;
  End p_delete;
End lookup_values_pkg;
/


-- End of DDL Script for Package FC.LOOKUP_VALUES_PKG

