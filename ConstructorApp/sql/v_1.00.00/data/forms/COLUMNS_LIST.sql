Alter Table FORMS Disable All Triggers;
Delete From FORM_COLUMNS
      Where form_code = 'COLUMNS_LIST';
Delete From FORM_COLUMNS$
      Where form_code = 'COLUMNS_LIST';
Delete From FORM_ACTIONS
      Where form_code = 'COLUMNS_LIST';
Delete From FORM_TABS
      Where form_code = 'COLUMNS_LIST';
Delete From FORMS
      Where form_code = 'COLUMNS_LIST';
/*  Form: COLUMNS_LIST. Entity: FORMS.  */

Insert Into FORMS
            ("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID"
            ,"FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR"
            ,"OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH", "DESCRIPTION")
     Values ('COLUMNS_LIST', ''
            ,'Select   column_code, NVL (column_user_name, column_code) column_user_name
    From Table (form_utils.describe_form_columns_pl (:form_code))
'
            ,'Список Столбцы', 'G', 'Y', '11', '*', '*', '', '', 'Y', '9', '*', '');
/*  Form: COLUMNS_LIST. Entity: FORM_TABS.  */
/*  Form: COLUMNS_LIST. Entity: FORM_ACTIONS.  */
/*  Form: COLUMNS_LIST. Entity: FORM_COLUMNS$.  */

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('1', 'VARCHAR2', '1020', 'COLUMN_CODE', '11', '0', '0', 'COLUMNS_LIST', '', '*'
            ,'*Идентификатор поля (из запроса)');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('2', 'VARCHAR2', '1020', 'COLUMN_USER_NAME', '16', '0', '0', 'COLUMNS_LIST', '', '*'
            ,'*Пользовательское имя поля');
/*  Form: COLUMNS_LIST. Entity: FORM_COLUMNS.  */

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE")
     Values ('COLUMNS_LIST', 'COLUMN_CODE', '', '*', 'S', '1001', 'N', 'Y', '', '', '', ''
            ,'*Идентификатор поля (из запроса)', 'N', 'N', '', '', '', '1', '', '', '', '', '', '', 'Y', '*', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE")
     Values ('COLUMNS_LIST', 'COLUMN_USER_NAME', '', '*', 'S', '1002', 'N', 'Y', '', '', '', ''
            ,'*Пользовательское имя поля', 'N', 'N', '', '', '', '2', '', '', '', '', '', '', 'Y', '*', '');
Alter Table FORMS Enable All Triggers;

