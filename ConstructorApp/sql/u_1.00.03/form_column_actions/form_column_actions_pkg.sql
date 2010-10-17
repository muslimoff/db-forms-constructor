Create Package fc22.form_column_actions_pkg As
   Procedure p_ins_upd (
      p_form_column_action_id   In Out   Number
     ,p_form_code               In Out   Varchar2
     ,p_column_code             In Out   Varchar2
     ,p_action_code             In Out   Varchar2
     ,p_action_key_code         In Out   Varchar2
     ,p_col_action_type_code    In Out   Varchar2
   );

   Procedure p_delete (
      p_form_column_action_id   In Out   Number
     ,p_form_code               In Out   Varchar2
     ,p_column_code             In Out   Varchar2
     ,p_action_code             In Out   Varchar2
     ,p_action_key_code         In Out   Varchar2
     ,p_col_action_type_code    In Out   Varchar2
   );
End form_column_actions_pkg;
/

Create Package Body fc22.form_column_actions_pkg As
   Procedure p_ins_upd (
      p_form_column_action_id   In Out   Number
     ,p_form_code               In Out   Varchar2
     ,p_column_code             In Out   Varchar2
     ,p_action_code             In Out   Varchar2
     ,p_action_key_code         In Out   Varchar2
     ,p_col_action_type_code    In Out   Varchar2
   ) Is
   Begin
      Update form_column_actions
         Set form_code = p_form_code
            ,column_code = p_column_code
            ,action_code = p_action_code
            ,action_key_code = p_action_key_code
            ,col_action_type_code = p_col_action_type_code
       Where form_column_action_id = p_form_column_action_id;

      If Sql%Rowcount = 0 Then
         Select main_sq.Nextval
           Into p_form_column_action_id
           From DUAL;

         Insert Into form_column_actions
                     (form_column_action_id, form_code, column_code, action_code, action_key_code
                     ,col_action_type_code)
              Values (p_form_column_action_id, p_form_code, p_column_code, p_action_code, p_action_key_code
                     ,p_col_action_type_code);
      End If;
   End p_ins_upd;

   Procedure p_delete (
      p_form_column_action_id   In Out   Number
     ,p_form_code               In Out   Varchar2
     ,p_column_code             In Out   Varchar2
     ,p_action_code             In Out   Varchar2
     ,p_action_key_code         In Out   Varchar2
     ,p_col_action_type_code    In Out   Varchar2
   ) Is
   Begin
      Delete From form_column_actions
            Where form_column_action_id = p_form_column_action_id;
   End p_delete;
End form_column_actions_pkg;
/

