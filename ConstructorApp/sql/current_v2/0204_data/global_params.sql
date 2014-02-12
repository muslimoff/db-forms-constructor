set define off
Insert Into global_params
            ("PARAM_NAME", "PARAM_VALUE", "DESCRIPTION")
     Values ('Version_DB', '1.1.33', 'Текущая версия метаданных БД')
/
Insert Into global_params
            ("PARAM_NAME", "PARAM_VALUE", "DESCRIPTION")
     Values ('Version_APP', '1.1.33', Null)
/
Insert Into global_params
            ("PARAM_NAME", "PARAM_VALUE", "DESCRIPTION")
     Values ('Version_CLIENT', '1.1.33', Null)
/
Insert Into global_params
            ("PARAM_NAME", "PARAM_VALUE", "DESCRIPTION")
     Values ('DEFAULT_TITLE', 'Forms Constructor', Null)
/
Insert Into global_params
            ("PARAM_NAME", "PARAM_VALUE", "DESCRIPTION")
     Values ('HOSTED_ICON_URL', '/resources/icons/', Null)
/
Insert Into global_params
            ("PARAM_NAME", "PARAM_VALUE", "DESCRIPTION")
     Values ('WEB_ICON_URL', '/ConstructorApp', Null)
/
Insert Into global_params
            ("PARAM_NAME", "PARAM_VALUE", "DESCRIPTION")
     Values ('DRAW_AHEAD_RATIO', '1.5', Null)
/
Insert Into global_params
            ("PARAM_NAME", "PARAM_VALUE", "DESCRIPTION")
     Values ('GRID_SCROLL_REDRAW_DELAY', '5', Null)
/
Insert Into global_params
            ("PARAM_NAME", "PARAM_VALUE", "DESCRIPTION")
     Values ('FETCH_SIZE', '75', Null)
/
Insert Into global_params
            ("PARAM_NAME", "PARAM_VALUE", "DESCRIPTION")
     Values ('columnLookupMappingSQL'
            ,'Select a.form_column_lookup_map_id, a.form_code, a.column_code, a.lookup_form_code, a.lookup_form_column_code
      ,a.mapping_type, a.constant_value, a.column_user_name, a.column_display_size, a.column_display_number
      ,a.show_on_grid, a.column_code_to_mapping
  From &fc_schema_owner..form_column_lookup_map_v a
 Where a.form_code = :p_form_code
   And a.mapping_type In (''COLUMN'')'
            ,'Меппинг новых лукапов (16) с полями формы')
/
Insert Into global_params
            ("PARAM_NAME", "PARAM_VALUE", "DESCRIPTION")
     Values ('LOOKUP_LENGTH', '1000', Null)
/
Insert Into global_params
            ("PARAM_NAME", "PARAM_VALUE", "DESCRIPTION")
     Values ('EXPORT_LENGTH', '1000', Null)
/
Insert Into global_params
            ("PARAM_NAME", "PARAM_VALUE", "DESCRIPTION")
     Values ('formSQL'
            ,'Select *
  From Table (&fc_schema_owner..forms_pkg.get_form_md (:p_form_code, :p_master_form_code, :p_drilldown_flag)) a'
            ,'Запрос для получения метаданных формы')
/
Insert Into global_params
            ("PARAM_NAME", "PARAM_VALUE", "DESCRIPTION")
     Values ('extendedFormSQL'
            ,'Select &fc_schema_owner..form_utils.get_extended_sql_text (a.sql_text)
  From Table (&fc_schema_owner..forms_pkg.get_form_md (:p_form_code, :p_master_form_code, :p_drilldown_flag)) a'
            ,Null)
/
Insert Into global_params
            ("PARAM_NAME", "PARAM_VALUE", "DESCRIPTION")
     Values ('ColumnsMetaDataSQL'
            ,'Select   *
    From Table (&fc_schema_owner..form_utils.describe_form_columns_pl (:p_form_code, :p_master_form_code, :p_master_form_tab_code))
Order By form_code, column_display_number, column_code'
            ,Null)
/
Insert Into global_params
            ("PARAM_NAME", "PARAM_VALUE", "DESCRIPTION")
     Values ('formActionsSQL'
            ,'Select   *
    From &fc_schema_owner..form_actions a
   Where a.form_code = :p_form_code
Order By form_code, display_number, action_code'
            ,'Запрос для получения метаданных колонок формы')
/
Insert Into global_params
            ("PARAM_NAME", "PARAM_VALUE", "DESCRIPTION")
     Values ('argsSQLText'
            ,'Select *
  From Table (&fc_schema_owner..form_auth_cur_user_utlis_pkg.get_proc_args (:p_procedure_name))'
            ,Null)
/
Insert Into global_params
            ("PARAM_NAME", "PARAM_VALUE", "DESCRIPTION")
     Values ('detailFormSQL'
            ,'Select *
  From Table (&fc_schema_owner..form_utils.get_form_tabs (:p_form_code, :p_master_form_code))', Null)
/
Insert Into global_params
            ("PARAM_NAME", "PARAM_VALUE", "DESCRIPTION")
     Values ('statLookupsSQL'
            ,'Select   l.lookup_code, lv.lookup_value_code, lv.lookup_display_value
    From &fc_schema_owner..lookups l, &fc_schema_owner..lookup_values lv
   Where l.lookup_code = lv.lookup_code
     --
     --
And l.lookup_code Not Like ''MZ%''
     --
And l.lookup_code Not Like ''INS%''
Order By l.lookup_code, lv.lookup_value_code'
            ,Null)
/
Insert Into global_params
            ("PARAM_NAME", "PARAM_VALUE", "DESCRIPTION")
     Values ('menusSQLOld', 'Select   *
    From &fc_schema_owner..forms_v a
Order By a.form_name', Null)
/
Insert Into global_params
            ("PARAM_NAME", "PARAM_VALUE", "DESCRIPTION")
     Values ('menusSQL', 'Select *
  From Table (&fc_schema_owner..apps_role_menus_pkg.get_menu_list ())', Null)
/
Insert Into global_params
            ("PARAM_NAME", "PARAM_VALUE", "DESCRIPTION")
     Values ('iconsSQL', 'Select i.*
  From &fc_schema_owner..icons i', Null)
/
Insert Into global_params
            ("PARAM_NAME", "PARAM_VALUE", "DESCRIPTION")
     Values ('reportTemplatesSQL'
            ,'Select a.clob_content
  From &fc_schema_owner..report_templates a
 Where a.report_type_code = :p_report_code'
            ,Null)
/
Insert Into global_params
            ("PARAM_NAME", "PARAM_VALUE", "DESCRIPTION")
     Values ('columnAttributesSQL'
            ,'Select a.column_code, a.attribute_code, a.attribute_value
  From &fc_schema_owner..form_column_attr_vals a
 Where a.form_code = :p_form_code'
            ,Null)
/
Insert Into global_params
            ("PARAM_NAME", "PARAM_VALUE", "DESCRIPTION")
     Values ('columnActionsSQL'
            ,'Select *
  From &fc_schema_owner..form_column_actions a
 Where a.form_code = :p_form_code', Null)
/
Insert Into global_params
            ("PARAM_NAME", "PARAM_VALUE", "DESCRIPTION")
     Values ('customLoginValidationSQL'
            ,'Select &validationFN (:p_username, :p_password, :p_url_params) isValid From DUAL', Null)
/
set define on
