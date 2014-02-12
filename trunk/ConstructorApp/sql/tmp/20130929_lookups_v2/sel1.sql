Select NVL (fclm.form_column_lookup_map_id, -ROWNUM) As form_column_lookup_map_id
      ,NVL (fclm.form_code, fc.form_code) As form_code, fc.column_code
-----
       ,NVL (fclm.lookup_form_code, fcl.form_code) As lookup_form_code
      ,NVL (fclm.lookup_form_column_code, fcl.column_code) As lookup_form_column_code
      ,NVL (fclm.column_user_name, fcl.column_user_name) As column_user_name
      ,NVL (fclm.column_display_size, fcl.column_display_size) As column_display_size
      ,NVL (fclm.column_display_number, fcl.column_display_number) As column_display_number
      ,NVL (fclm.show_on_grid, fcl.show_on_grid) As show_on_grid, fclm.mapping_type, fclm.constant_value
      ,fclm.column_code_to_mapping
  From form_columns fc Join form_columns fcl On fcl.form_code = fc.lookup_code
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

