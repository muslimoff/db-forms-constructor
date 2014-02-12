-- Start of DDL Script for View FC22.BINDS_V
-- Generated 17.11.2013 0:50:11 from FC22@XE

CREATE FORCE View binds_v (
   form_code,
   position,
   datatype,
   max_length,
   array_len,
   bind_name )
As
Select "FORM_CODE", "POSITION", "DATATYPE", "MAX_LENGTH", "ARRAY_LEN", "BIND_NAME"
     From Table (form_utils.get_binds ())
/

-- End of DDL Script for View FC22.BINDS_V

-- Start of DDL Script for View FC22.FORM_COLUMN_ATTR_VALS
-- Generated 17.11.2013 0:50:11 from FC22@XE

CREATE FORCE View form_column_attr_vals (
   form_column_attr_val_id,
   form_code,
   column_code,
   attribute_code,
   attribute_value )
As
Select a.form_column_lookup_map_id As form_column_attr_val_id, a.form_code As form_code
         ,a.column_code As column_code, a.lookup_form_column_code As attribute_code
         ,a.constant_value As attribute_value
     From form_column_lookup_map a
    Where a.mapping_type = 'CONSTANT'
/

-- End of DDL Script for View FC22.FORM_COLUMN_ATTR_VALS

-- Start of DDL Script for View FC22.FORM_COLUMN_LOOKUP_MAP_V
-- Generated 17.11.2013 0:50:11 from FC22@XE

CREATE FORCE View form_column_lookup_map_v (
   form_column_lookup_map_id,
   form_code,
   column_code,
   lookup_form_code,
   lookup_form_column_code,
   mapping_type,
   constant_value,
   column_user_name,
   column_display_size,
   column_display_number,
   show_on_grid,
   column_code_to_mapping )
As
Select
/*объединить с табличкой FORM_COLUMN_ATTR_VALS: поля mapping_type и constant_value*/
       NVL (fclm.form_column_lookup_map_id, -ROWNUM) As form_column_lookup_map_id
      ,NVL (fclm.form_code, fc.form_code) As form_code, fc.column_code
      ,NVL (fclm.lookup_form_code, fcl.form_code) As lookup_form_code
      ,NVL (fclm.lookup_form_column_code, fcl.column_code) As lookup_form_column_code
      ,NVL (fclm.mapping_type, 'COLUMN') As mapping_type, fclm.constant_value
--      ,NVL (fclm.column_user_name, fcl.column_user_name) As column_user_name
       ,NVL (fclm.column_user_name
            ,NVL (fcl.column_user_name
                 ,SUBSTR (Ltrim (Replace (fcl.column_description, fcl.column_code, ''), '*'), 1, 100)
                 )
            ) As column_user_name
      ,NVL (fclm.column_display_size, fcl.column_display_size) As column_display_size
      ,NVL (fclm.column_display_number, fcl.column_display_number) As column_display_number
      ,NVL (fclm.show_on_grid, fcl.show_on_grid) As show_on_grid, fclm.column_code_to_mapping
  --NVL (fclm.column_code_to_mapping, NVL (fclm.lookup_form_column_code, fcl.column_code)) As column_code_to_mapping
From   form_columns fc Join form_columns fcl On fcl.form_code = fc.lookup_code
--From   form_columns fc Join Table (fc22.form_utils.describe_form_columns_pl (fc.lookup_code)) fcl On 1 = 1
       Left Join form_column_lookup_map fclm
       On fc.form_code = fclm.form_code
     And fc.column_code = fclm.column_code
     And fcl.form_code = fclm.lookup_form_code
     And fcl.column_code = fclm.lookup_form_column_code
 Where 1 = 1
   And fc.field_type In ('16')
--   And fc.form_code = 'LOOKUPS_TEST1'
--   And fc.column_code = 'LOOKUP_DISPLAY_VALUE'
--Order By fcl.column_display_number
Union All
Select "FORM_COLUMN_LOOKUP_MAP_ID", "FORM_CODE", "COLUMN_CODE", "LOOKUP_FORM_CODE", "LOOKUP_FORM_COLUMN_CODE"
      ,"MAPPING_TYPE", "CONSTANT_VALUE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DISPLAY_NUMBER"
      ,"SHOW_ON_GRID", "COLUMN_CODE_TO_MAPPING"
  From form_column_lookup_map fclm
 Where fclm.mapping_type = 'CONSTANT'
/

-- End of DDL Script for View FC22.FORM_COLUMN_LOOKUP_MAP_V

-- Start of DDL Script for View FC22.FORM_TABS_V
-- Generated 17.11.2013 0:50:11 from FC22@XE

CREATE FORCE View form_tabs_v (
   form_code,
   tab_code,
   child_form_code,
   tab_position,
   tab_name,
   number_of_columns,
   icon_id,
   tab_type,
   tab_display_number )
As
Select ft.form_code, ft.tab_code, ft.child_form_code, NVL (ft.tab_position, 'R') tab_position
         ,NVL (ft.tab_name, (Select NVL (f.form_name, f.form_code)
                               From forms f
                              Where f.form_code = ft.child_form_code)) tab_name
         ,NVL (ft.number_of_columns, 2) number_of_columns
         ,NVL (ft.icon_id, (Select f.icon_id
                              From forms f
                             Where f.form_code = ft.child_form_code)) icon_id, ft.tab_type, tab_display_number
     From form_tabs ft
/

-- End of DDL Script for View FC22.FORM_TABS_V

-- Start of DDL Script for View FC22.FORMS_V
-- Generated 17.11.2013 0:50:11 from FC22@XE

CREATE FORCE View forms_v (
   apps_code,
   export_order,
   form_code,
   hot_key,
   sql_text,
   form_name,
   description,
   form_type,
   show_tree_root_node,
   icon_id,
   form_width,
   form_height,
   bottom_tabs_orientation,
   side_tabs_orientation,
   show_bottom_toolbar,
   object_version_number,
   default_column_width,
   double_click_action_code,
   lookup_width,
   lookup_height,
   fc_schema,
   dragdrop_action_code,
   data_page_size )
As
Select a.apps_code, a.export_order, a.form_code, a.hot_key, a.sql_text, NVL (a.form_name, a.form_code) As form_name
      ,a.description, a.form_type, a.show_tree_root_node, a.icon_id, a.form_width, a.form_height
      ,NVL (a.bottom_tabs_orientation, 'T') As bottom_tabs_orientation
      ,NVL (a.side_tabs_orientation, 'T') As side_tabs_orientation, NVL (a.show_bottom_toolbar
                                                                        ,'Y') show_bottom_toolbar
      ,a.object_version_number, a.default_column_width, double_click_action_code, lookup_width, lookup_height
      ,applications_pkg.get_fc_schema () As fc_schema, dragdrop_action_code, data_page_size
  From forms a
 Where 1 = 1
/*      And (   SYS_CONTEXT ('USERENV', 'SESSION_USER') = applications_pkg.get_fc_schema ()
           Or a.form_code In (Select ap.form_code
                                From apps_privs ap, APPLICATIONS a
                               Where a.apps_code = ap.apps_code
                                 And (a.schema_name = User))
          )*/
/

-- End of DDL Script for View FC22.FORMS_V

