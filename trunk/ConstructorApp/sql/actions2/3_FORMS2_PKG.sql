CREATE OR REPLACE 
PACKAGE forms2_pkg As
  Procedure p_delete(p_code Varchar2);

  Procedure p_insert(p_user_name In Out Varchar2,
                     p_code      Out Varchar2,
                     p_is_folder Out Varchar2);
End;
/


CREATE OR REPLACE 
PACKAGE BODY forms2_pkg As
   Procedure p_insert (p_user_name In Out Varchar2, p_code Out Varchar2, p_is_folder Out Varchar2) Is
      l_app_code               APPLICATIONS.apps_code%Type;
      l_default_table_prefix   APPLICATIONS.default_table_prefix%Type;
      l_current_user           Varchar2 (30)                            := SYS_CONTEXT ('USERENV', 'SESSION_USER');
      l_table_descr            Varchar2 (100);
   Begin
      form_utils.check_nulls (args_t (p_user_name), args_t ('Не указано имя формы'));

      Begin
         Select a.apps_code, a.default_table_prefix
           Into l_app_code, l_default_table_prefix
           From APPLICATIONS a
          Where 1 = 1
            And a.schema_name = l_current_user;
      Exception
         When NO_DATA_FOUND Then
            Null;
      End;

      Begin
         Select SUBSTR (t.comments, 1, 100)
           Into l_table_descr
           From all_tab_comments t
          Where t.owner = l_current_user
            And t.table_name = UPPER (p_user_name);
      Exception
         When NO_DATA_FOUND Then
            Null;
      End;

      p_is_folder    := 1;
      p_code         := l_default_table_prefix || UPPER (p_user_name);

      Insert Into forms
                  (form_code, object_version_number, sql_text, form_name)
           Values (p_code, 1, 'select * from ' || l_current_user || '.' || UPPER (p_user_name), l_table_descr);

      If 1 = 1 Then
         Insert Into apps_privs
              Values (l_app_code, p_code);
      --         raise_application_error (-20002, USERENV ('SCHEMAID') || 'xxx' || Sql%Rowcount);
      End If;

      Begin
         form_utils.generate_form_pkg (p_code, l_current_user, p_user_name);
      Exception
         When Others Then
            DBMS_OUTPUT.put_line (SQLERRM);
      End;

      Insert Into form_actions
         Select p_code, a.action_code, Replace (a.procedure_name, 'FORM_ACTIONS', p_code) procedure_name
               ,a.action_display_name, a.icon_id, a.default_param_prefix, a.default_old_param_prefix, a.action_type
               ,a.display_number, a.confirm_text, a.hot_key, a.show_separator_below, a.display_on_toolbar
               ,a.child_form_code, a.url_text, a.parent_action_code, a.display_in_context_menu, a.autocommit
               ,a.status_button_param, a.status_msg_level_param, a.status_msg_txt_param
           From form_actions a
          Where a.form_code = 'FORM_ACTIONS';
   End p_insert;

   Procedure p_delete (p_code Varchar2) Is
      l_form_code   forms.form_code%Type   := p_code;
   Begin
      Delete From form_actions a
            Where a.form_code = l_form_code;

      Delete From apps_privs a
            Where a.form_code = l_form_code;

      Delete From form_columns a
            Where a.form_code = l_form_code;

      Delete From form_columns$ a
            Where a.form_code = l_form_code;

      Delete From form_tabs a
            Where a.form_code = l_form_code;

      Delete From forms a
            Where a.form_code = l_form_code;
   End p_delete;
End;
/

