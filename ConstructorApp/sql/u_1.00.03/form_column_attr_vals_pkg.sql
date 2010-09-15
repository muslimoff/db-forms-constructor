Drop Package fc22.form_column_attr_vals_pkg
/

Create 
PACKAGE fc22.form_column_attr_vals_pkg As
   Procedure p_ins_upd (
      p_form_column_attr_val_id   In Out   Number
     ,p_form_code                 In Out   Varchar2
     ,p_column_code               In Out   Varchar2
     ,p_attribute_code            In Out   Varchar2
     ,p_attribute_value           In Out   Varchar2
   );

   Procedure p_delete (
      p_form_column_attr_val_id   In Out   Number
     ,p_form_code                 In Out   Varchar2
     ,p_column_code               In Out   Varchar2
     ,p_attribute_code            In Out   Varchar2
     ,p_attribute_value           In Out   Varchar2
   );
End FORM_COLUMN_ATTR_VALS_PKG;
/


Create 
PACKAGE BODY fc22.form_column_attr_vals_pkg As
   Procedure p_ins_upd (
      p_form_column_attr_val_id   In Out   Number
     ,p_form_code                 In Out   Varchar2
     ,p_column_code               In Out   Varchar2
     ,p_attribute_code            In Out   Varchar2
     ,p_attribute_value           In Out   Varchar2
   ) Is
   Begin
      Update form_column_attr_vals
         Set form_code = p_form_code
            ,column_code = p_column_code
            ,attribute_code = p_attribute_code
            ,attribute_value = p_attribute_value
       Where form_column_attr_val_id = p_form_column_attr_val_id;

      If Sql%Rowcount = 0 Then
         Select main_sq.Nextval
           Into p_form_column_attr_val_id
           From DUAL;

         Insert Into form_column_attr_vals
                     (form_column_attr_val_id, form_code, column_code, attribute_code, attribute_value)
              Values (p_form_column_attr_val_id, p_form_code, p_column_code, p_attribute_code, p_attribute_value);
      End If;
   End p_ins_upd;

   Procedure p_delete (
      p_form_column_attr_val_id   In Out   Number
     ,p_form_code                 In Out   Varchar2
     ,p_column_code               In Out   Varchar2
     ,p_attribute_code            In Out   Varchar2
     ,p_attribute_value           In Out   Varchar2
   ) Is
   Begin
      Delete From form_column_attr_vals
            Where form_column_attr_val_id = p_form_column_attr_val_id;
   End p_delete;
End FORM_COLUMN_ATTR_VALS_PKG;
/

