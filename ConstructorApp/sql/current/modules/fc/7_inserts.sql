--alter table global_params  set column PARAM_VALUE type varchar2(2000);
Delete From global_params
/
Insert Into global_params
            ("PARAM_NAME", "PARAM_VALUE")
     Values ('DEFAULT_TITLE', 'Forms Constructor')
/
Insert Into global_params
            ("PARAM_NAME", "PARAM_VALUE")
     Values ('HOSTED_ICON_URL', '/resources/icons/')
/
Insert Into global_params
            ("PARAM_NAME", "PARAM_VALUE")
     Values ('WEB_ICON_URL', '/ConstructorApp')
/
Insert Into global_params
            ("PARAM_NAME", "PARAM_VALUE")
     Values ('DRAW_AHEAD_RATIO', '1.5')
/
Insert Into global_params
            ("PARAM_NAME", "PARAM_VALUE")
     Values ('GRID_SCROLL_REDRAW_DELAY', '5')
/
Insert Into global_params
            ("PARAM_NAME", "PARAM_VALUE")
     Values ('FETCH_SIZE', '75')
/
Insert Into global_params
            ("PARAM_NAME", "PARAM_VALUE")
     Values ('LOOKUP_LENGTH', '1000')
/
Insert Into global_params
            ("PARAM_NAME", "PARAM_VALUE")
     Values ('EXPORT_LENGTH', '1000')
/
Insert Into global_params
            ("PARAM_NAME", "PARAM_VALUE")
     Values ('formSQL'
            ,'Select *
  From Table (&fc_schema_owner..forms_pkg.get_form_md (:p_form_code, :p_master_form_code, :p_drilldown_flag)) a')
/
Insert Into global_params
            ("PARAM_NAME", "PARAM_VALUE")
     Values ('extendedFormSQL'
            ,'Select &fc_schema_owner..form_utils.get_extended_sql_text (a.sql_text)
  From Table (&fc_schema_owner..forms_pkg.get_form_md (:p_form_code, :p_master_form_code, :p_drilldown_flag)) a')
/
Insert Into global_params
            ("PARAM_NAME", "PARAM_VALUE")
     Values ('ColumnsMetaDataSQL'
            ,'Select   *
    From Table (&fc_schema_owner..form_utils.describe_form_columns_pl (:p_form_code, :p_master_form_code))
Order By form_code, column_display_number, column_code')
/
Insert Into global_params
            ("PARAM_NAME", "PARAM_VALUE")
     Values ('formActionsSQL'
            ,'Select   *
    From &fc_schema_owner..form_actions a
   Where a.form_code = :p_form_code
Order By form_code, display_number, action_code')
/
Insert Into global_params
            ("PARAM_NAME", "PARAM_VALUE")
     Values ('argsSQLText'
            ,'Select *
  From Table (&fc_schema_owner..form_auth_cur_user_utlis_pkg.get_proc_args (:p_procedure_name))')
/
Insert Into global_params
            ("PARAM_NAME", "PARAM_VALUE")
     Values ('detailFormSQL'
            ,'Select *
  From Table (&fc_schema_owner..form_utils.get_form_tabs (:p_form_code, :p_master_form_code))')
/
Insert Into global_params
            ("PARAM_NAME", "PARAM_VALUE")
     Values ('statLookupsSQL'
            ,'Select   l.lookup_code, lv.lookup_value_code, lv.lookup_display_value
    From &fc_schema_owner..lookups l, &fc_schema_owner..lookup_values lv
   Where l.lookup_code = lv.lookup_code
     --
     --And l.lookup_code Not Like ''MZ%''
     --And l.lookup_code Not Like ''INS%''
Order By l.lookup_code, lv.lookup_value_code')
/
Insert Into global_params
            ("PARAM_NAME", "PARAM_VALUE")
     Values ('menusSQLOld', 'Select   *
    From &fc_schema_owner..forms_v a
Order By a.form_name')
/
Insert Into global_params
            ("PARAM_NAME", "PARAM_VALUE")
     Values ('menusSQL', 'Select *
  From Table (&fc_schema_owner..apps_role_menus_pkg.get_menu_list ())')
/
Insert Into global_params
            ("PARAM_NAME", "PARAM_VALUE")
     Values ('iconsSQL', 'Select i.*
  From &fc_schema_owner..icons i')
/
Insert Into global_params
            ("PARAM_NAME", "PARAM_VALUE")
     Values ('reportTemplatesSQL'
            ,'Select a.clob_content
  From &fc_schema_owner..report_templates a
 Where a.report_type_code = :p_report_code')
/
Insert Into global_params
            ("PARAM_NAME", "PARAM_VALUE")
     Values ('columnAttributesSQL'
            ,'Select a.column_code, a.attribute_code, a.attribute_value
  From &fc_schema_owner..form_column_attr_vals a
 Where a.form_code = :p_form_code')
/
Insert Into global_params
            ("PARAM_NAME", "PARAM_VALUE")
     Values ('columnActionsSQL'
            ,'Select *
  From &fc_schema_owner..form_column_actions a
 Where a.form_code = :p_form_code')
/
Insert Into global_params
            ("PARAM_NAME", "PARAM_VALUE")
     Values ('customLoginValidationSQL'
            ,'Select &validationFN (:p_username, :p_password, :p_url_params) isValid From DUAL')
/
Insert Into Fc22.Global_Params Gp
  (Param_Name, Param_Value)
Values
  ('RESET_SESSION_SQL'
  ,'Begin Xxfnd_Apps_Utils_Pkg.Reset_Session(P_Url_Params => ?); End;');
/
Insert Into Fc22.Global_Params Gp
  (Param_Name, Param_Value)
Values
  ('TIMEOUTSQL'
  ,'Begin ? := Xxfnd_Apps_Utils_Pkg.Session_Timedout(P_Url_Params => ?); End;');
/
Insert Into Fc22.Global_Params Gp
  (Param_Name, Param_Value)
Values
  ('DATE_FORMAT'
  ,'Begin ? := Fnd_Profile.Value(''ICX_DATE_FORMAT_MASK''); End;');
/
Grant Select On global_params To fc_admin

