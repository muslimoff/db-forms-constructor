Alter Table FORMS Disable All Triggers;
Delete From FORM_COLUMNS
      Where form_code = 'LOOKUPS_LIST';
Delete From FORM_COLUMNS$
      Where form_code = 'LOOKUPS_LIST';
Delete From FORM_ACTIONS
      Where form_code = 'LOOKUPS_LIST';
Delete From FORM_TABS
      Where form_code = 'LOOKUPS_LIST';
Delete From FORMS
      Where form_code = 'LOOKUPS_LIST';
/*  Form: LOOKUPS_LIST. Entity: FORMS.  */

Insert Into FORMS
            ("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID"
            ,"FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR"
            ,"OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH", "DESCRIPTION")
     Values ('LOOKUPS_LIST', ''
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
            ,'������ ������', 'G', 'Y', '11', '*', '*', '', '', 'Y', '22', '*', '');
/*  Form: LOOKUPS_LIST. Entity: FORM_TABS.  */
/*  Form: LOOKUPS_LIST. Entity: FORM_ACTIONS.  */
/*  Form: LOOKUPS_LIST. Entity: FORM_COLUMNS$.  */

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('2', 'VARCHAR2', '1020', 'LOOKUP_CODE', '11', '0', '0', 'LOOKUPS_LIST', '', '*'
            ,'*������ �� ����� - ������ ��� �������');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('3', 'VARCHAR2', '1020', 'LOOKUP_NAME', '11', '0', '0', 'LOOKUPS_LIST', '', '*', '*���������������� ���');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('1', 'VARCHAR2', '2000', 'LOOKUP_TYPE', '11', '0', '0', 'LOOKUPS_LIST', '', '*', '**LOOKUP_TYPE');
/*  Form: LOOKUPS_LIST. Entity: FORM_COLUMNS.  */

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE")
     Values ('LOOKUPS_LIST', 'LOOKUP_CODE', '', '*', 'S', '1', 'N', 'Y', '', '', '', ''
            ,'*������ �� ����� - ������ ��� �������', 'N', 'N', '', '', '', '1', '', '', '', '', '', '', 'Y', '*', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE")
     Values ('LOOKUPS_LIST', 'LOOKUP_NAME', '', '*', 'S', '2', 'N', 'Y', '', '', '', '', '*���������������� ���', 'N'
            ,'N', '', '', '', '2', '', '', '', '', '', '', 'Y', '*', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE")
     Values ('LOOKUPS_LIST', 'LOOKUP_TYPE', '', '*', 'CHAR', '1001', 'N', 'N', '', '', '', '8'
            ,'*��� - ������� ��� ��������������, ������� � ����������� �� ����, SQL, SQL � �����������', 'N', 'N'
            ,'FORM_COLUMNS.FIELD_TYPE', '', '', '', '', '', '', '', '', '', 'Y', '*', '');
Alter Table FORMS Enable All Triggers;

