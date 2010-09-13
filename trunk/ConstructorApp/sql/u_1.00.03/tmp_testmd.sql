--<sqlStatement name="formSQL">
Select *
  From Table (forms_pkg.get_form_md (:p_form_code, :p_master_form_code, :p_drilldown_flag)) a
/
--		<!--extendedFormSQL-->
Select form_utils.get_extended_sql_text (a.sql_text)
  From Table (forms_pkg.get_form_md (:p_form_code, :p_master_form_code, :p_drilldown_flag)) a
/
--		<!--ColumnsMetaDataSQL-->
Select
           /* column_display_number, form_code, column_code, column_data_type, column_user_name, column_display_size
         ,pimary_key_flag, show_on_grid, tree_initialization_value, tree_field_type, editor_tab_code, field_type
         ,column_description, is_frozen_flag, show_hover_flag, exists_in_metadata_flag, exists_in_query_flag
         ,lookup_code, hover_column_code, editor_height, lookup_field_type, help_text, text_mask
         ,validation_regexp, default_orderby_number, default_value, editor_title_orientation, editor_end_row_flag
            ,editor_cols_span, lookup_display_value
            */
         *
    From Table (form_utils.describe_form_columns_pl (:p_form_code, :p_master_form_code))
Order By form_code, column_display_number, column_code
/
--		<!--formActionsSQL-->
Select   *
    From form_actions a
   Where a.form_code = :p_form_code
Order By form_code, display_number, action_code
/
--		<!--argsSQLText-->
Select   a.Position, a.argument_name, DECODE (a.in_out, 'IN/OUT', 'Y', 'IN', 'Y') in_flag
        ,DECODE (a.in_out, 'IN/OUT', 'Y', 'OUT', 'Y') out_flag
    From all_arguments a
   Where a.package_name || '.' || a.object_name = UPPER (:p_procedure_name)
     And (   a.owner = User
          Or a.owner = :p_fc_schema_owner)
     And a.Position != 0
     And a.argument_name Is Not Null
Order By a.Position, a.Sequence
/
--		<!--detailFormSQL-->
Select *
  From Table (form_utils.get_form_tabs (:p_form_code, :p_master_form_code))
/
--		<!--statLookupsSQL-->
Select   l.lookup_code, lv.lookup_value_code, lv.lookup_display_value
    From lookups l, lookup_values lv
   Where l.lookup_code = lv.lookup_code
--             And l.lookup_code Not Like 'INS%'
Order By l.lookup_code, lv.lookup_value_code
/
--		<!--menusSQLOld-->
Select   *
    From forms_v a
Order By a.form_name
/
--		<!--menusSQL-->
Select *
  From Table (apps_role_menus_pkg.get_menu_list ())
/
--		<!--iconsSQL-->
Select *
  From icons i
/
--		<sqlStatement name="reportTemplatesSQL">
Select a.clob_content
  From report_templates a
 Where a.report_type_code = :p_report_code
/
Select a.column_code, a.attribute_code, a.attribute_value From form_column_attr_vals a Where a.form_code = :p_form_code
