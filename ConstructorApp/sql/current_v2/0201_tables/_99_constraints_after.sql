Alter Table forms
Add Constraint forms_form_actions_fk Foreign Key (form_code,
  double_click_action_code)
References form_actions (form_code,action_code)
/
Alter Table form_columns
Add Constraint form_tabs_fk Foreign Key (form_code, editor_tab_code)
References form_tabs (form_code,tab_code)
/

