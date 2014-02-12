
Alter Table FORMS Disable All Triggers;
Alter Table forms Disable Constraint forms_form_actions_fk;
Delete From APPS_PRIVS
      Where form_code = 'LOOKUP_ATTRIBUTE_VALUES';
Delete From FORM_COLUMN_LOOKUP_MAP
      Where form_code = 'LOOKUP_ATTRIBUTE_VALUES';
Delete From FORM_COLUMN_ACTIONS
      Where form_code = 'LOOKUP_ATTRIBUTE_VALUES';
Delete From FORM_TAB_CHILDS_ALLOWED
      Where form_code = 'LOOKUP_ATTRIBUTE_VALUES';
Delete From FORM_TAB_PARENT_EXCLNS
      Where form_code = 'LOOKUP_ATTRIBUTE_VALUES';
Delete From FORM_COLUMN_ATTR_VALS
      Where form_code = 'LOOKUP_ATTRIBUTE_VALUES';
Delete From FORM_COLUMNS
      Where form_code = 'LOOKUP_ATTRIBUTE_VALUES';
Delete From FORM_COLUMNS$
      Where form_code = 'LOOKUP_ATTRIBUTE_VALUES';
Delete From FORM_ACTIONS
      Where form_code = 'LOOKUP_ATTRIBUTE_VALUES';
Delete From FORM_TABS
      Where form_code = 'LOOKUP_ATTRIBUTE_VALUES';
Delete From FORMS
      Where form_code = 'LOOKUP_ATTRIBUTE_VALUES';
/*  Form: LOOKUP_ATTRIBUTE_VALUES. Entity: FORMS.  */

Insert Into FORMS
            ("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID"
            ,"FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR"
            ,"OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH", "DESCRIPTION", "DOUBLE_CLICK_ACTION_CODE", "LOOKUP_WIDTH"
            ,"APPS_CODE", "EXPORT_ORDER", "LOOKUP_HEIGHT", "DRAGDROP_ACTION_CODE", "DATA_PAGE_SIZE")
     Values ('LOOKUP_ATTRIBUTE_VALUES', ''
            ,'select * from &fc_schema_owner..LOOKUP_ATTRIBUTE_VALUES lav
where
       lav.lookup_code = :lookup_code
and lav.lookup_value_code = :lookup_value_code'
            ,'Значения атрибутов', 'G', 'Y', '', '*', '*', '', '', 'Y', '10', '*', '', '', '', 'FC', '20', '', '', '');
/*  Form: LOOKUP_ATTRIBUTE_VALUES. Entity: FORM_TABS.  */
/*  Form: LOOKUP_ATTRIBUTE_VALUES. Entity: FORM_ACTIONS.  */

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT", "PARENT_ACTION_CODE"
            ,"DISPLAY_IN_CONTEXT_MENU", "AUTOCOMMIT", "STATUS_BUTTON_PARAM", "STATUS_MSG_LEVEL_PARAM"
            ,"STATUS_MSG_TXT_PARAM")
     Values ('LOOKUP_ATTRIBUTE_VALUES', 'DEL', '&fc_schema_owner..LOOKUP_ATTRIBUTE_VALUES_PKG.p_delete', 'Удалить'
            ,'48', '', '', '3', '130', 'Вы уверены что хотите удалить запись?', '', 'N', 'Y', '', '', '', 'Y', 'Y', ''
            ,'', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT", "PARENT_ACTION_CODE"
            ,"DISPLAY_IN_CONTEXT_MENU", "AUTOCOMMIT", "STATUS_BUTTON_PARAM", "STATUS_MSG_LEVEL_PARAM"
            ,"STATUS_MSG_TXT_PARAM")
     Values ('LOOKUP_ATTRIBUTE_VALUES', 'EDIT', '', 'Редактировать', '50', '', '', '8', '115', 'Вы уверены?', '', 'N'
            ,'Y', '', '', '', 'Y', 'Y', '', '', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT", "PARENT_ACTION_CODE"
            ,"DISPLAY_IN_CONTEXT_MENU", "AUTOCOMMIT", "STATUS_BUTTON_PARAM", "STATUS_MSG_LEVEL_PARAM"
            ,"STATUS_MSG_TXT_PARAM")
     Values ('LOOKUP_ATTRIBUTE_VALUES', 'INS', '', 'Создать', '47', '', '', '1', '110', '', '', 'N', 'Y', '', '', ''
            ,'Y', 'Y', '', '', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT", "PARENT_ACTION_CODE"
            ,"DISPLAY_IN_CONTEXT_MENU", "AUTOCOMMIT", "STATUS_BUTTON_PARAM", "STATUS_MSG_LEVEL_PARAM"
            ,"STATUS_MSG_TXT_PARAM")
     Values ('LOOKUP_ATTRIBUTE_VALUES', 'REFR', '', 'Обновить', '15', '', '', '4', '10', '', '', 'N', 'Y', '', '', ''
            ,'Y', 'Y', '', '', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT", "PARENT_ACTION_CODE"
            ,"DISPLAY_IN_CONTEXT_MENU", "AUTOCOMMIT", "STATUS_BUTTON_PARAM", "STATUS_MSG_LEVEL_PARAM"
            ,"STATUS_MSG_TXT_PARAM")
     Values ('LOOKUP_ATTRIBUTE_VALUES', 'UPD', '&fc_schema_owner..LOOKUP_ATTRIBUTE_VALUES_PKG.p_ins_upd', 'Сохранить'
            ,'46', '', '', '2', '120', 'Вы уверены?', '', 'N', 'Y', '', '', '', 'Y', 'Y', '', '', '');
/*  Form: LOOKUP_ATTRIBUTE_VALUES. Entity: FORM_COLUMNS$.  */

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('3', 'VARCHAR2', '1020', 'ATTRIBUTE_CODE', '14', '0', '0', 'LOOKUP_ATTRIBUTE_VALUES', '', '*'
            ,'*Код атрибута');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('5', 'VARCHAR2', '4000', 'ATTRIBUTE_VALUE_CHAR', '20', '0', '0', 'LOOKUP_ATTRIBUTE_VALUES', '', '*'
            ,'**ATTRIBUTE_VALUE_CHAR');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('6', 'DATE', '7', 'ATTRIBUTE_VALUE_DATE', '20', '0', '0', 'LOOKUP_ATTRIBUTE_VALUES', '', '*'
            ,'**ATTRIBUTE_VALUE_DATE');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('4', 'NUMBER', '22', 'ATTRIBUTE_VALUE_NUMBER', '22', '0', '-127', 'LOOKUP_ATTRIBUTE_VALUES', '', '*'
            ,'**ATTRIBUTE_VALUE_NUMBER');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('1', 'VARCHAR2', '1020', 'LOOKUP_CODE', '11', '0', '0', 'LOOKUP_ATTRIBUTE_VALUES', '', '*'
            ,'*Ссылка на лукап - формау или простой');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('2', 'VARCHAR2', '1020', 'LOOKUP_VALUE_CODE', '17', '0', '0', 'LOOKUP_ATTRIBUTE_VALUES', '', '*'
            ,'**LOOKUP_VALUE_CODE');
/*  Form: LOOKUP_ATTRIBUTE_VALUES. Entity: FORM_COLUMNS.  */

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT")
     Values ('LOOKUP_ATTRIBUTE_VALUES', 'ATTRIBUTE_CODE', 'Код атрибута', '*', 'S', '1003', 'N', 'Y', '', '', '', '16'
            ,'**ATTRIBUTE_CODE', 'N', 'N', 'LOOKUP_ATTRIBUTES', '', '', '', '', '', '', '', '', 'L', 'Y', '*', '', ''
            ,'', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT")
     Values ('LOOKUP_ATTRIBUTE_VALUES', 'LOOKUP_CODE', 'Ссылка на лукап - формау или простой', '*', 'S', '1001', 'N'
            ,'N', '', '', '', '', '*Ссылка на лукап - формау или простой', 'N', 'N', '', '', '', '', '', '', '', ''
            ,':lookup_code', 'L', 'Y', '*', '', '', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT")
     Values ('LOOKUP_ATTRIBUTE_VALUES', 'LOOKUP_VALUE_CODE', '', '*', 'S', '1002', 'N', 'N', '', '', '', ''
            ,'**LOOKUP_VALUE_CODE', 'N', 'N', '', '', '', '', '', '', '', '', ':lookup_value_code', 'L', 'Y', '*', ''
            ,'', '', '');
/*  Form: LOOKUP_ATTRIBUTE_VALUES. Entity: FORM_COLUMN_ATTR_VALS.  */
/*  Form: LOOKUP_ATTRIBUTE_VALUES. Entity: FORM_TAB_PARENT_EXCLNS.  */
/*  Form: LOOKUP_ATTRIBUTE_VALUES. Entity: FORM_TAB_CHILDS_ALLOWED.  */
/*  Form: LOOKUP_ATTRIBUTE_VALUES. Entity: FORM_COLUMN_ACTIONS.  */
/*  Form: LOOKUP_ATTRIBUTE_VALUES. Entity: FORM_COLUMN_LOOKUP_MAP.  */

Insert Into FORM_COLUMN_LOOKUP_MAP
            ("FORM_COLUMN_LOOKUP_MAP_ID", "FORM_CODE", "COLUMN_CODE", "LOOKUP_FORM_CODE", "LOOKUP_FORM_COLUMN_CODE"
            ,"MAPPING_TYPE", "CONSTANT_VALUE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DISPLAY_NUMBER"
            ,"SHOW_ON_GRID", "COLUMN_CODE_TO_MAPPING")
     Values ('20518', 'LOOKUP_ATTRIBUTE_VALUES', 'ATTRIBUTE_CODE', 'LOOKUP_ATTRIBUTES', 'ATTRIBUTE_CODE', 'COLUMN', ''
            ,'', '*', '1002', 'Y', 'ATTRIBUTE_CODE');
/*  Form: LOOKUP_ATTRIBUTE_VALUES. Entity: APPS_PRIVS.  */

Insert Into APPS_PRIVS
            ("APPS_CODE", "FORM_CODE")
     Values ('SC', 'LOOKUP_ATTRIBUTE_VALUES');

Insert Into APPS_PRIVS
            ("APPS_CODE", "FORM_CODE")
     Values ('BF', 'LOOKUP_ATTRIBUTE_VALUES');

Insert Into APPS_PRIVS
            ("APPS_CODE", "FORM_CODE")
     Values ('AAHR', 'LOOKUP_ATTRIBUTE_VALUES');

Insert Into APPS_PRIVS
            ("APPS_CODE", "FORM_CODE")
     Values ('TC', 'LOOKUP_ATTRIBUTE_VALUES');

Insert Into APPS_PRIVS
            ("APPS_CODE", "FORM_CODE")
     Values ('INS', 'LOOKUP_ATTRIBUTE_VALUES');



Alter Table forms Enable VALIDATE Constraint forms_form_actions_fk;
Alter Table FORMS Enable All Triggers;

