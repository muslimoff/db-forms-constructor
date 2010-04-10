Select a.form_code, a.action_code, a.procedure_name, a.action_display_name, a.icon_id, a.default_param_prefix
      ,a.default_old_param_prefix, a.action_type, a.display_number, a.confirm_text, a.hot_key, a.show_separator_below
      ,a.display_on_toolbar
  From form_actions a
 Where a.form_code In
          ('COLUMNS_LIST'
          ,'FORM_ACTIONS'
          ,'FORM_COLUMNS'
          ,'FORM_TABS'
          ,'FORM_TABS_LIST'
          ,'FORMS'
          ,'FORMS_LIST'
          ,'FORMS2'
          ,'ICONS'
          ,'LOOKUP_VALUES'
          ,'LOOKUPS'
          ,'LOOKUPS_LIST'
          ,'MENUS'
          )

