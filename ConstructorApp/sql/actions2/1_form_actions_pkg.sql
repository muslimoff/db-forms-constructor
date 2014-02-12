Create Or Replace Package form_actions_pkg Is
   -- Author  : V.SAFRONOV
   -- Created : 23.12.2009 11:05:23
   -- Purpose :

   -- Public type declarations
   Procedure p_delete (p_form_code form_actions.form_code%Type, p_action_code form_actions.action_code%Type);

   Procedure p_ins_upd (
      p_form_code                  form_actions.form_code%Type
     ,p_action_code                form_actions.action_code%Type
     ,p_procedure_name             form_actions.procedure_name%Type
     ,p_action_display_name        form_actions.action_display_name%Type
     ,p_icon_id                    form_actions.icon_id%Type
     ,p_default_param_prefix       form_actions.default_param_prefix%Type
     ,p_default_old_param_prefix   form_actions.default_old_param_prefix%Type
     ,p_action_type                form_actions.action_type%Type
     ,p_confirm_text               form_actions.confirm_text%Type
     ,p_display_number             form_actions.display_number%Type
     ,p_hot_key                    form_actions.hot_key%Type
     ,p_show_separator_below       form_actions.show_separator_below%Type
     ,p_display_on_toolbar         form_actions.display_on_toolbar%Type
     ,p_child_form_code            form_actions.child_form_code%Type
     ,p_url_text                   form_actions.url_text%Type
     ,p_parent_action_code         form_actions.parent_action_code%Type
     ,p_display_in_context_menu    form_actions.display_in_context_menu%Type
     ,p_autocommit                 form_actions.autocommit%Type
     ,p_status_button_param        form_actions.status_button_param%Type
     ,p_status_msg_level_param     form_actions.status_msg_level_param%Type
     ,p_status_msg_txt_param       form_actions.status_msg_txt_param%Type
   );
End FORM_ACTIONS_PKG;
/

Grant Execute On form_actions_pkg To fc_admin
/

Create Or Replace Package Body form_actions_pkg Is
   Procedure p_ins_upd (
      p_form_code                  form_actions.form_code%Type
     ,p_action_code                form_actions.action_code%Type
     ,p_procedure_name             form_actions.procedure_name%Type
     ,p_action_display_name        form_actions.action_display_name%Type
     ,p_icon_id                    form_actions.icon_id%Type
     ,p_default_param_prefix       form_actions.default_param_prefix%Type
     ,p_default_old_param_prefix   form_actions.default_old_param_prefix%Type
     ,p_action_type                form_actions.action_type%Type
     ,p_confirm_text               form_actions.confirm_text%Type
     ,p_display_number             form_actions.display_number%Type
     ,p_hot_key                    form_actions.hot_key%Type
     ,p_show_separator_below       form_actions.show_separator_below%Type
     ,p_display_on_toolbar         form_actions.display_on_toolbar%Type
     ,p_child_form_code            form_actions.child_form_code%Type
     ,p_url_text                   form_actions.url_text%Type
     ,p_parent_action_code         form_actions.parent_action_code%Type
     ,p_display_in_context_menu    form_actions.display_in_context_menu%Type
     ,p_autocommit                 form_actions.autocommit%Type
     ,p_status_button_param        form_actions.status_button_param%Type
     ,p_status_msg_level_param     form_actions.status_msg_level_param%Type
     ,p_status_msg_txt_param       form_actions.status_msg_txt_param%Type
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
            ,display_in_context_menu = p_display_in_context_menu
            ,autocommit = p_autocommit
            ,status_button_param = p_status_button_param
            ,status_msg_level_param = p_status_msg_level_param
            ,status_msg_txt_param = p_status_msg_txt_param
       Where fa.form_code = p_form_code
         And fa.action_code = p_action_code;

      If Sql%Rowcount = 0 Then
         Insert Into form_actions fao
                     (form_code, action_code, procedure_name, action_display_name, icon_id, default_param_prefix
                     ,default_old_param_prefix, action_type, display_number, hot_key, show_separator_below
                     ,display_on_toolbar, child_form_code, url_text, parent_action_code, display_in_context_menu
                     ,autocommit, status_button_param, status_msg_level_param, status_msg_txt_param)
              Values (p_form_code, p_action_code, p_procedure_name, p_action_display_name, p_icon_id
                     ,p_default_param_prefix, p_default_old_param_prefix, p_action_type, p_display_number, p_hot_key
                     ,p_show_separator_below, p_display_on_toolbar, p_child_form_code, p_url_text
                     ,p_parent_action_code, p_display_in_context_menu, p_autocommit, p_status_button_param
                     ,p_status_msg_level_param, p_status_msg_txt_param);
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

