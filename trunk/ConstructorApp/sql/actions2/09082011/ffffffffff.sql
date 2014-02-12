-- detailFormSQL form_utils.get_form_tabs (:p_form_code, :p_master_form_code))
-- columnActionsSQL -- form_column_actions a -- fc22.form_utils_customization.customize_form_action
-- menusSQL -- apps_role_menus_pkg.get_menu_list

Select form_code, action_code, procedure_name, action_display_name, icon_id,
       default_param_prefix, default_old_param_prefix, action_type,
       display_number, confirm_text, hot_key, show_separator_below,
       display_on_toolbar, child_form_code, url_text, parent_action_code,
       status_parameter_name, display_in_context_menu, autocommit,
       status_button_param, status_msg_level_param, status_msg_txt_param
  From Table( &fc_schema_owner..form_utils_customization.customize_form_action(:p_form_code))
 Order By form_code, display_number, action_code
