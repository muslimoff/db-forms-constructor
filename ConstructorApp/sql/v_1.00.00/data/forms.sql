Insert Into forms
            ("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID"
            ,"FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR"
            ,"OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH")
     Values ('MENUS', Null
            ,'select * from table(menus_pkg.p_get_menu_tree(:menu_code,:element_type,:form_display))
--------
',           'Конструктор', 'T', 'Y', 28, '25%', '*', Null, Null, 'Y', 275, '*')
/
Insert Into forms
            ("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID"
            ,"FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR"
            ,"OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH")
     Values ('FORMS', 'Ctrl+Shift+q'
            ,'Select *
  From forms a
 Where DECODE (:p_$master_form_code, ''FORMS2'', :form_code_for_filter,''MENUS'',:form_code_for_filter, a.form_code) = a.form_code
----'
            ,'Детальная Свойства формы', 'G', 'Y', 4, '0%', '*', 'B', 'B', 'N', 110, '*')
/
Insert Into forms
            ("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID"
            ,"FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR"
            ,"OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH")
     Values ('LOOKUPS', Null, 'SELECT * FROM lookups a
---',        'Списки', 'G', 'Y', 28, '30%', '*', Null, Null, 'N', 17, '120')
/
Insert Into forms
            ("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID"
            ,"FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR"
            ,"OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH")
     Values ('LOOKUP_VALUES', Null, 'SELECT * FROM lookup_values a where a.lookup_code=:lookup_code'
            ,'Детальная Значения списков', 'G', 'Y', 4, '*', '*', Null, Null, 'Y', 20, '*')
/
Insert Into forms
            ("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID"
            ,"FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR"
            ,"OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH")
     Values ('FORM_COLUMNS', Null
            ,'SELECT   t.*, NVL ( (SELECT   NVL (f.form_name, form_code)
                       FROM   forms f
                      WHERE   f.form_code = t.lookup_code AND t.field_type IN (''9'', ''11'')),
              (SELECT   l.lookup_name
                 FROM   lookups l
                WHERE   t.lookup_code = l.lookup_code AND t.field_type IN (''8'', ''10'')))
                 lookup_name
  FROM   Table (form_utils.describe_form_columns_pl (DECODE (
                                                        :p_$master_form_code,
                                                        ''FORMS2'', :form_code_for_filter,
                                                        ''MENUS'', :form_code_for_filter,
                                                        :form_code
                                                     ))) t
--'
            ,'Детальная Колонки', 'G', 'Y', 4, '35%', '*', Null, 'B', 'Y', 323, '*')
/
Insert Into forms
            ("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID"
            ,"FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR"
            ,"OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH")
     Values ('COLUMNS_LIST', Null
            ,'Select   column_code, NVL (column_user_name, column_code) column_user_name
    From Table (form_utils.describe_form_columns_pl (:form_code))
'
            ,'Список Столбцы', 'G', 'Y', 11, '*', '*', Null, Null, 'Y', 9, '*')
/
Insert Into forms
            ("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID"
            ,"FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR"
            ,"OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH")
     Values ('FORM_TABS_LIST', Null
            ,'Select   a.form_code, a.tab_code, NVL (a.tab_name, a.tab_code) tab_name, a.tab_type
    From form_tabs_v a
   Where 
--a.form_code = NVL (:form_code, a.form_code)
a.form_code = :form_code
Order By a.tab_display_number
'
            ,'Список Вкладки', 'G', 'Y', 11, '*', '*', Null, Null, 'Y', 16, '*')
/
Insert Into forms
            ("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID"
            ,"FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR"
            ,"OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH")
     Values ('FORMS2', 'shift+alt+ctrl+f'
            ,'Select t.*, DECODE (child_count, 0, 0, 1) is_folder, NVL (t.parent_code, t.code) form_code_for_filter
      ,DECODE (entity_type
              ,''DATA'', ''FORMS''
              ,''COLUMNS'', ''FORM_COLUMNS''
              ,''TABS'', ''FORM_TABS''
              ,''ACTIONS'', ''FORM_ACTIONS''
--              ,''FORM'', t.code
              ) detail_form
      ,DECODE (entity_type, ''FORM'', t.code) detail_form_multi
  From (Select ''FORM'' entity_type, Null parent_code, a.form_code code, NVL (a.form_name, a.form_code) user_name
              ,a.icon_id, 1 child_count, a.description
          From forms_v a
         Where :code Is Null
        Union All
        Select ''COLUMNS'' entity_type, :code parent_code, ''COLUMNS'' code, ''Колонки'', 11 icon_id, 0 child_count
              ,Null description
          From DUAL x
         Where :code Is Not Null
           And ''FORM'' = :entity_type
        Union All
        Select ''TABS'' entity_type, :code parent_code, ''TABS'' code, ''Вкладки'', 12 icon_id, 0 child_count
              ,Null description
          From DUAL x
         Where :code Is Not Null
           And ''FORM'' = :entity_type
        Union All
        Select ''ACTIONS'' entity_type, :code parent_code, ''ACTIONS'' code, ''Действия'', 13 icon_id, 0 child_count
              ,Null description
          From DUAL x
         Where :code Is Not Null
           And ''FORM'' = :entity_type
        Union All
        Select ''DATA'' entity_type, :code parent_code, ''DATA'' code, ''Настройки формы'', 14 icon_id, 0 child_count
              ,Null description
          From DUAL x
         Where :code Is Not Null
           And ''FORM'' = :entity_type) t order by t.USER_NAME'
            ,'Конструктор форм', 'T', 'Y', 28, '20%', '*', Null, Null, 'Y', 140, '*')
/
Insert Into forms
            ("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID"
            ,"FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR"
            ,"OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH")
     Values ('ICONS', 'ctrl+alt+shift+i'
            ,'Select a.icon_id, a.icon_id icon, a.icon_file_name, a.icon_path
  From icons a', 'Иконки', 'G', 'Y', 28, '*', '*', Null, 'B', 'Y', 116, Null)
/
Insert Into forms
            ("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID"
            ,"FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR"
            ,"OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH")
     Values ('FORM_TABS', 'shift+alt+ctrl+a'
            ,'Select *
  From form_tabs a
 Where DECODE (:p_$master_form_code, ''FORMS'', :form_code, ''FORMS2'', :form_code_for_filter,''MENUS'',:form_code_for_filter, a.form_code) = a.form_code
'
            ,'Детальная Вкладки', 'G', 'Y', 4, '*', '*', Null, Null, 'Y', 70, '*')
/
Insert Into forms
            ("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID"
            ,"FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR"
            ,"OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH")
     Values ('LOOKUPS_LIST', Null
            ,'SELECT   :field_type lookup_type, a.lookup_code, a.lookup_name
  FROM   lookups a
 WHERE   :field_type IN (''8'', ''10'')
UNION ALL
SELECT   :field_type lookup_type, a.form_code, NVL (a.form_name, a.form_code) form_name
  FROM   forms_v a
 WHERE   :field_type IN (''9'', ''11'')
/*****************************
Select *
  From (Select ''8'' lookup_type, a.lookup_code, a.lookup_name
          From lookups a
        Union All
        Select ''9'' lookup_type, a.form_code, NVL (a.form_name, a.form_code) form_name
          From forms_v a) t
 Where t.lookup_type = NVL (:field_type, t.lookup_type)
*****************************/
/* Formatted on 22.01.2010 1:35:06 (QP5 v5.120.811.25008) */'
            ,'Список Списки', 'G', 'Y', 11, '*', '*', Null, Null, 'Y', 22, '*')
/
Insert Into forms
            ("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID"
            ,"FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR"
            ,"OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH")
     Values ('FORMS_LIST', Null
            ,'Select a.form_code, NVL (a.form_name, a.form_code) form_name, a.hot_key, a.icon_id
  From forms_v a', 'Список Формы', 'G', 'Y', 11, '250', '*', Null, Null, 'Y', 21, '*')
/
Insert Into forms
            ("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID"
            ,"FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR"
            ,"OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH")
     Values ('FORM_ACTIONS', Null
            ,'SELECT *
  FROM form_actions a
 Where DECODE (:p_$master_form_code, ''FORMS'', :form_code, ''FORMS2'', :form_code_for_filter,''MENUS'',:form_code_for_filter, a.form_code) = a.form_code'
            ,'Детальная Действия', 'G', 'Y', 4, '*', '*', Null, Null, 'Y', 52, '*')
/

