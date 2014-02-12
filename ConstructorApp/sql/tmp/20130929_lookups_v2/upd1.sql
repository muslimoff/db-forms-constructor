/*
GLOBAL_PARAMS:
    +columnLookupMappingSQL

Packages:
    +MENUS_PKG *
    +FORM_COLUMN_LOOKUP_MAP_PKG
    -FORM_UTILS *

Views:
    +FORM_COLUMN_LOOKUP_MAP_V
    
Lookups:
    +FORM_COLUMN_LOOKUP_MAP.MAPPING_TYPE
    +FORM_COLUMNS.FIELD_TYPE [16, 9]
        
Forms:
    -MENUS *
    +FORMS *
    -APPS_ROLE_MENUS *
    -APPS_ROLE_USERS *
    +FORM_COLUMN_LOOKUP_MAP
    +FORM_COLUMNS *
    +FORM_ACTIONS *
    +FORM_COLUMN_ACTIONS *
    +FORM_TABS *
    +FORM_TAB_CHILDS_ALLOWED *
    +FORM_TAB_PARENT_EXCLNS *
    +LOOKUP_ATTRIBUTE_VALUES *
    +LOOKUP_VALUES *
    +LOOKUPS_LIST
*/
--
Drop Table form_column_lookup_map
/
Create Table form_column_lookup_map
    (form_column_lookup_map_id      Number,
    form_code                      Varchar2(255),
    column_code                    Varchar2(255),
    lookup_form_code               Varchar2(255),
    lookup_form_column_code        Varchar2(255),
    mapping_type                   Varchar2(255) DEFAULT 'CONSTANT',
    constant_value                 Varchar2(255),
    column_user_name               Varchar2(255),
    column_display_size            Varchar2(255),
    column_display_number          Number,
    show_on_grid                   Varchar2(1),
    column_code_to_mapping         Varchar2(255))
/
Delete From global_params a
      Where a.param_name = 'columnLookupMappingSQL';
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
Rename form_column_attr_vals To form_column_attr_vals_old
/
Select a.form_column_attr_val_id, a.form_code, a.column_code, a.attribute_code, a.attribute_value
  From form_column_attr_vals_old a
/
Delete From form_column_lookup_map a
      Where a.mapping_type = 'CONSTANT'
/
Insert Into form_column_lookup_map
            (form_column_lookup_map_id, form_code, column_code, lookup_form_code, lookup_form_column_code, mapping_type
            ,constant_value)
   Select main_sq.Nextval As form_column_lookup_map_id, a.form_code, a.column_code, b.lookup_code As lookup_form_code
         ,a.attribute_code As lookup_form_column_code, 'CONSTANT' As mapping_type, a.attribute_value As constant_value
     From form_column_attr_vals_old a, form_columns b
    Where a.form_code = b.form_code
      And a.column_code = b.column_code
/
Create Or Replace View form_column_attr_vals As
   Select a.form_column_lookup_map_id As form_column_attr_val_id, a.form_code As form_code
         ,a.column_code As column_code, a.lookup_form_column_code As attribute_code
         ,a.constant_value As attribute_value
     From form_column_lookup_map a
    Where a.mapping_type = 'CONSTANT'
/
--Контроль
Select   a.form_code, Count (*) As cnt
        ,stragg (a.column_code || ' [' || a.column_user_name || ' | ' || a.lookup_code || ']') As xx
    From form_columns a
   Where a.field_type = '9'
Group By a.form_code
Order By a.form_code
/
Create Or Replace View fc22.form_column_lookup_map_v (form_column_lookup_map_id
                                                     ,form_code
                                                     ,column_code
                                                     ,lookup_form_code
                                                     ,lookup_form_column_code
                                                     ,mapping_type
                                                     ,constant_value
                                                     ,column_user_name
                                                     ,column_display_size
                                                     ,column_display_number
                                                     ,show_on_grid
                                                     ,column_code_to_mapping
                                                     ) As
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
Insert Into lookups
            ("LOOKUP_CODE", "LOOKUP_NAME")
     Values ('FORM_COLUMN_LOOKUP_MAP.MAPPING_TYPE', 'Типы поля для меппинга лукапов')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMN_LOOKUP_MAP.MAPPING_TYPE', 'CONSTANT', 'Константа')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMN_LOOKUP_MAP.MAPPING_TYPE', 'COLUMN', 'Столбец')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.FIELD_TYPE', '16', 'Lookup-форма')
/
Update lookup_values a
   Set a.lookup_display_value = '!!!Устарело!!! Lookup-форма'
 Where a.lookup_code = 'FORM_COLUMNS.FIELD_TYPE'
   And a.lookup_value_code = '9'

