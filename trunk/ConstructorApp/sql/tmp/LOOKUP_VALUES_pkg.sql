CREATE OR REPLACE 
PACKAGE fc22.lookup_values_pkg As
   Procedure p_ins_upd (
      p_lookup_code            In Out   Varchar2
     ,p_lookup_value_code      In Out   Varchar2
     ,p_lookup_display_value   In Out   Varchar2
     ,p_lookup_value_id        In Out   Number
   );

   Procedure p_delete (p_lookup_value_id In Out Number);
End LOOKUP_VALUES_PKG;
/

GRANT EXECUTE ON fc22.lookup_values_pkg TO fc_admin
/

CREATE OR REPLACE 
PACKAGE BODY fc22.lookup_values_pkg As
   Procedure p_ins_upd (
      p_lookup_code            In Out   Varchar2
     ,p_lookup_value_code      In Out   Varchar2
     ,p_lookup_display_value   In Out   Varchar2
     ,p_lookup_value_id        In Out   Number
   ) Is
   Begin
      form_utils.check_nulls (args_t (p_lookup_code), args_t ('Не указан код списка'));

      Update lookup_values
         Set lookup_code = p_lookup_code
            ,lookup_value_code = p_lookup_value_code
            ,lookup_display_value = p_lookup_display_value
       Where lookup_value_id = p_lookup_value_id;

      If Sql%Rowcount = 0 Then
         Select main_sq.Nextval
           Into p_lookup_value_id
           From DUAL;

         Select NVL (p_lookup_value_code, main_sq.Nextval)
           Into p_lookup_value_code
           From DUAL;

         Insert Into lookup_values
                     (lookup_code, lookup_value_code, lookup_display_value, lookup_value_id)
              Values (p_lookup_code, p_lookup_value_code, p_lookup_display_value, p_lookup_value_id);
      End If;
   End p_ins_upd;

   Procedure p_delete (p_lookup_value_id In Out Number) Is
   Begin
      Delete From lookup_values
            Where lookup_value_id = p_lookup_value_id;
   End p_delete;
End lookup_values_pkg;
/

CREATE OR REPLACE 
Package      fc22.lookup_values_pkg_old As
   Procedure p_ins_upd (
      p_lookup_code                     Varchar2
     ,p_lookup_value_code               Varchar2
     ,p_lookup_display_value            Varchar2
     ,p_lookup_value_id        In Out   Number
   );

   Procedure p_delete (p_lookup_code Varchar2, p_lookup_value_code Varchar2);
End lookup_values_pkg_old;
/


CREATE OR REPLACE 
Package Body      fc22.lookup_values_pkg_old As
   /*
   SELECT a.lookup_code, a.lookup_value_code, a.lookup_display_value
     FROM lookup_values a
   */
   Procedure p_ins_upd (
      p_lookup_code                     Varchar2
     ,p_lookup_value_code               Varchar2
     ,p_lookup_display_value            Varchar2
     ,p_lookup_value_id        In Out   Number
   ) Is
   Begin
      form_utils.check_nulls (args_t (p_lookup_code, p_lookup_value_code)
                             ,args_t ('Не указан код списка', 'Не указано значение списка')
                             );

      Update lookup_values lv
         Set lookup_display_value = p_lookup_display_value
       Where lv.lookup_code = p_lookup_code
         And lv.lookup_value_code = p_lookup_value_code;

      If     Sql%Rowcount = 0
         And p_lookup_code Is Not Null
         And p_lookup_value_code Is Not Null Then
         Insert Into lookup_values
                     (lookup_code, lookup_value_code, lookup_display_value)
              Values (p_lookup_code, p_lookup_value_code, p_lookup_display_value)
           Returning lookup_value_id
                Into p_lookup_value_id;
      End If;
   End p_ins_upd;

   Procedure p_delete (p_lookup_code Varchar2, p_lookup_value_code Varchar2) Is
   Begin
      Delete From lookup_values lv
            Where lv.lookup_code = p_lookup_code
              And lv.lookup_value_code = p_lookup_value_code;
   End p_delete;
End lookup_values_pkg_old;
/

