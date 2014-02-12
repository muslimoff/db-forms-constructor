CREATE OR REPLACE 
PACKAGE form_actions_pkg Is
   -- Author  : V.SAFRONOV
   -- Created : 23.12.2009 11:05:23
   -- Purpose :

   -- Public type declarations
   Procedure p_ins_upd (
      p_form_code                           form_actions.form_code%Type
     ,p_action_code                         form_actions.action_code%Type
     ,p_procedure_name                      form_actions.procedure_name%Type
     ,p_action_display_name                 form_actions.action_display_name%Type
     ,p_icon_id                             form_actions.icon_id%Type
     ,p_default_param_prefix                form_actions.default_param_prefix%Type
     ,p_default_old_param_prefix            form_actions.default_old_param_prefix%Type
     ,p_action_type                         form_actions.action_type%Type
     ,p_confirm_text                        form_actions.confirm_text%Type
     ,p_display_number                      form_actions.display_number%Type
     ,p_hot_key                             form_actions.hot_key%Type
     ,p_show_separator_below                form_actions.show_separator_below%Type
     ,p_display_on_toolbar                  form_actions.display_on_toolbar%Type
     ,p_child_form_code                     form_actions.child_form_code%Type
     ,p_url_text                   In Out   Varchar2
     ,p_parent_action_code         In Out   Varchar2
     ,p_status_parameter_name      In Out   Varchar2
     ,p_display_in_context_menu in out varchar2
   );

   Procedure p_delete (p_form_code form_actions.form_code%Type, p_action_code form_actions.action_code%Type);
End FORM_ACTIONS_PKG;
/

GRANT EXECUTE ON form_actions_pkg TO fc_admin
/

CREATE OR REPLACE 
PACKAGE BODY form_actions_pkg Is
   Procedure p_ins_upd (
      p_form_code                           form_actions.form_code%Type
     ,p_action_code                         form_actions.action_code%Type
     ,p_procedure_name                      form_actions.procedure_name%Type
     ,p_action_display_name                 form_actions.action_display_name%Type
     ,p_icon_id                             form_actions.icon_id%Type
     ,p_default_param_prefix                form_actions.default_param_prefix%Type
     ,p_default_old_param_prefix            form_actions.default_old_param_prefix%Type
     ,p_action_type                         form_actions.action_type%Type
     ,p_confirm_text                        form_actions.confirm_text%Type
     ,p_display_number                      form_actions.display_number%Type
     ,p_hot_key                             form_actions.hot_key%Type
     ,p_show_separator_below                form_actions.show_separator_below%Type
     ,p_display_on_toolbar                  form_actions.display_on_toolbar%Type
     ,p_child_form_code                     form_actions.child_form_code%Type
     ,p_url_text                   In Out   Varchar2
     ,p_parent_action_code         In Out   Varchar2
     ,p_status_parameter_name      In Out   Varchar2
     ,p_display_in_context_menu    In Out   Varchar2
   ) As
   Begin
      form_utils.check_nulls (args_t (p_form_code, p_action_code)
                             ,args_t ('Не указан код формы', 'Не указан код действия')
                             );

      Update form_actions fa
         Set fa.form_code = p_form_code
            ,fa.action_code = p_action_code
            ,fa.procedure_name = p_procedure_name
            ,fa.action_display_name = p_action_display_name
            ,fa.icon_id = p_icon_id
            ,fa.default_param_prefix = p_default_param_prefix
            ,fa.default_old_param_prefix = p_default_old_param_prefix
            ,fa.action_type = p_action_type
            ,fa.confirm_text = p_confirm_text
            ,fa.display_number = p_display_number
            ,hot_key = p_hot_key
            ,show_separator_below = p_show_separator_below
            ,display_on_toolbar = p_display_on_toolbar
            ,child_form_code = p_child_form_code
            ,url_text = p_url_text
            ,parent_action_code = p_parent_action_code
            ,status_parameter_name = p_status_parameter_name
            ,display_in_context_menu = p_display_in_context_menu
       Where fa.form_code = p_form_code
         And fa.action_code = p_action_code;

      If Sql%Rowcount = 0 Then
         Insert Into form_actions fao
                     (form_code, action_code, procedure_name, action_display_name, icon_id, default_param_prefix
                     ,default_old_param_prefix, action_type, display_number, hot_key, show_separator_below
                     ,display_on_toolbar, child_form_code, url_text, parent_action_code, status_parameter_name
                     ,display_in_context_menu)
              Values (p_form_code, p_action_code, p_procedure_name, p_action_display_name, p_icon_id
                     ,p_default_param_prefix, p_default_old_param_prefix, p_action_type, p_display_number, p_hot_key
                     ,p_show_separator_below, p_display_on_toolbar, p_child_form_code, p_url_text
                     ,p_parent_action_code, p_status_parameter_name, p_display_in_context_menu);
      End If;

      Update forms f
         Set f.object_version_number = f.object_version_number + 1
       Where f.form_code = p_form_code;
   End p_ins_upd;

   Procedure p_delete (p_form_code form_actions.form_code%Type, p_action_code form_actions.action_code%Type) As
   Begin
      Delete From form_actions fao
            Where fao.form_code = p_form_code
              And fao.action_code = p_action_code;

      Update forms f
         Set f.object_version_number = f.object_version_number + 1
       Where f.form_code = p_form_code;
   End p_delete;
End FORM_ACTIONS_PKG;
/

