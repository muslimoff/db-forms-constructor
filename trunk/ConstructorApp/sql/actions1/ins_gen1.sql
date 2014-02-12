Select a.lookup_code, a.lookup_value_code, a.lookup_display_value
  From lookup_values a
 Where a.lookup_code In ('FORM_ACTIONS.ACTION_TYPE')
   And a.lookup_value_code = '99'
Union
Select a.lookup_code, a.lookup_value_code, a.lookup_display_value
  From lookup_values a
 Where a.lookup_code In ('FORMS.TABS_ORIENTATION')
   And a.lookup_value_code = 'H'
/
Select a.icon_id, a.icon_file_name, a.icon_path
  From icons a
 Where a.icon_id In (120, 121, 122)

