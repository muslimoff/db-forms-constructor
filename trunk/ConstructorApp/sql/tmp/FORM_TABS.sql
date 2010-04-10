Select a.form_code, a.tab_code, a.child_form_code, a.tab_position, a.tab_name, a.number_of_columns, a.icon_id
      ,a.tab_type, a.tab_display_number
  From form_tabs a
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

