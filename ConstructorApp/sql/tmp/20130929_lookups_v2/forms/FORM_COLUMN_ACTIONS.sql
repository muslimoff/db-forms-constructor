
Alter Table FORMS Disable All Triggers;
Alter Table forms Disable Constraint forms_form_actions_fk;
Delete From APPS_PRIVS
      Where form_code = 'FORM_COLUMN_ACTIONS';
Delete From FORM_COLUMN_LOOKUP_MAP
      Where form_code = 'FORM_COLUMN_ACTIONS';
Delete From FORM_COLUMN_ACTIONS
      Where form_code = 'FORM_COLUMN_ACTIONS';
Delete From FORM_TAB_CHILDS_ALLOWED
      Where form_code = 'FORM_COLUMN_ACTIONS';
Delete From FORM_TAB_PARENT_EXCLNS
      Where form_code = 'FORM_COLUMN_ACTIONS';
Delete From FORM_COLUMN_ATTR_VALS
      Where form_code = 'FORM_COLUMN_ACTIONS';
Delete From FORM_COLUMNS
      Where form_code = 'FORM_COLUMN_ACTIONS';
Delete From FORM_COLUMNS$
      Where form_code = 'FORM_COLUMN_ACTIONS';
Delete From FORM_ACTIONS
      Where form_code = 'FORM_COLUMN_ACTIONS';
Delete From FORM_TABS
      Where form_code = 'FORM_COLUMN_ACTIONS';
Delete From FORMS
      Where form_code = 'FORM_COLUMN_ACTIONS';
/*  Form: FORM_COLUMN_ACTIONS. Entity: FORMS.  */

Insert Into FORMS
            ("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID"
            ,"FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR"
            ,"OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH", "DESCRIPTION", "DOUBLE_CLICK_ACTION_CODE", "LOOKUP_WIDTH"
            ,"APPS_CODE", "EXPORT_ORDER", "LOOKUP_HEIGHT", "DRAGDROP_ACTION_CODE", "DATA_PAGE_SIZE")
     Values ('FORM_COLUMN_ACTIONS', ''
            ,'Select *
  From &fc_schema_owner..form_column_actions a
 Where a.action_code = NVL (:action_code, a.action_code)
   And a.form_code = NVL (:form_code, a.form_code)
   And a.column_code = NVL (:column_code, a.column_code)
--'
            ,'', 'G', 'Y', '29', '*', '*', '', '', 'Y', '23', '*', '', '', '', 'FC', '100', '', '', '');
/*  Form: FORM_COLUMN_ACTIONS. Entity: FORM_TABS.  */
/*  Form: FORM_COLUMN_ACTIONS. Entity: FORM_ACTIONS.  */

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT", "PARENT_ACTION_CODE"
            ,"DISPLAY_IN_CONTEXT_MENU", "AUTOCOMMIT", "STATUS_BUTTON_PARAM", "STATUS_MSG_LEVEL_PARAM"
            ,"STATUS_MSG_TXT_PARAM")
     Values ('FORM_COLUMN_ACTIONS', 'DEL', '&fc_schema_owner..FORM_COLUMN_ACTIONS_PKG.p_delete', 'Удалить', '48', ''
            ,'', '3', '130', 'Вы уверены что хотите удалить запись?', '', 'N', 'Y', '', '', '', 'Y', 'Y', '', '', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT", "PARENT_ACTION_CODE"
            ,"DISPLAY_IN_CONTEXT_MENU", "AUTOCOMMIT", "STATUS_BUTTON_PARAM", "STATUS_MSG_LEVEL_PARAM"
            ,"STATUS_MSG_TXT_PARAM")
     Values ('FORM_COLUMN_ACTIONS', 'EDIT', '', 'Редактировать', '50', '', '', '8', '115', 'Вы уверены?', '', 'N', 'Y'
            ,'', '', '', 'Y', 'Y', '', '', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT", "PARENT_ACTION_CODE"
            ,"DISPLAY_IN_CONTEXT_MENU", "AUTOCOMMIT", "STATUS_BUTTON_PARAM", "STATUS_MSG_LEVEL_PARAM"
            ,"STATUS_MSG_TXT_PARAM")
     Values ('FORM_COLUMN_ACTIONS', 'INS', '', 'Создать', '47', '', '', '1', '110', '', '', 'N', 'Y', '', '', '', 'Y'
            ,'Y', '', '', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT", "PARENT_ACTION_CODE"
            ,"DISPLAY_IN_CONTEXT_MENU", "AUTOCOMMIT", "STATUS_BUTTON_PARAM", "STATUS_MSG_LEVEL_PARAM"
            ,"STATUS_MSG_TXT_PARAM")
     Values ('FORM_COLUMN_ACTIONS', 'REFR', '', 'Обновить', '15', '', '', '4', '10', '', '', 'N', 'Y', '', '', '', 'Y'
            ,'Y', '', '', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT", "PARENT_ACTION_CODE"
            ,"DISPLAY_IN_CONTEXT_MENU", "AUTOCOMMIT", "STATUS_BUTTON_PARAM", "STATUS_MSG_LEVEL_PARAM"
            ,"STATUS_MSG_TXT_PARAM")
     Values ('FORM_COLUMN_ACTIONS', 'UPD', '&fc_schema_owner..FORM_COLUMN_ACTIONS_PKG.p_ins_upd', 'Сохранить', '46', ''
            ,'', '2', '120', 'Вы уверены?', '', 'N', 'Y', '', '', '', 'Y', 'Y', '', '', '');
/*  Form: FORM_COLUMN_ACTIONS. Entity: FORM_COLUMNS$.  */

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('4', 'VARCHAR2', '1020', 'ACTION_CODE', '11', '0', '0', 'FORM_COLUMN_ACTIONS', 'Y', '*', '*Код действия');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('5', 'VARCHAR2', '1020', 'ACTION_KEY_CODE', '15', '0', '0', 'FORM_COLUMN_ACTIONS', '', '*'
            ,'*Клавиша (для типа "по нажатию клавиши").');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('3', 'VARCHAR2', '1020', 'COLUMN_CODE', '11', '0', '0', 'FORM_COLUMN_ACTIONS', 'Y', '*'
            ,'*Идентификатор поля (из запроса)');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('6', 'VARCHAR2', '1020', 'COL_ACTION_TYPE_CODE', '20', '0', '0', 'FORM_COLUMN_ACTIONS', '', '*'
            ,'*Тип действия (лукап FORM_COLUMNS.ACTION_TYPE)');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('2', 'VARCHAR2', '1020', 'FORM_CODE', '9', '0', '0', 'FORM_COLUMN_ACTIONS', 'Y', '*'
            ,'*Идентификатор форм');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('1', 'NUMBER', '22', 'FORM_COLUMN_ACTION_ID', '21', '0', '-127', 'FORM_COLUMN_ACTIONS', '', '*'
            ,'*Ключ. Для обновления из интерфейса');
/*  Form: FORM_COLUMN_ACTIONS. Entity: FORM_COLUMNS.  */

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT")
     Values ('FORM_COLUMN_ACTIONS', 'ACTION_CODE', 'Код действия', '*', 'S', '40', 'N', 'Y', '', '1', '', '16'
            ,'*Код действия', 'N', 'N', 'DBLCLICK_FORM_ACT_LIST', '', '', '1', '', '', '', '', ':ACTION_CODE', 'L', 'Y'
            ,'*', '', '', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT")
     Values ('FORM_COLUMN_ACTIONS', 'ACTION_KEY_CODE', 'Клавиша (для типа "по нажатию клавиши").', '*', 'S', '60', 'N'
            ,'Y', '', '', '', '', '*Клавиша (для типа "по нажатию клавиши").', 'N', 'N', '', '', '', '', '', '', '', ''
            ,'', 'L', 'Y', '*', '', '', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT")
     Values ('FORM_COLUMN_ACTIONS', 'COLUMN_CODE', 'Идентификатор поля (из запроса)', '*', 'S', '30', 'N', 'Y', '', '1'
            ,'', '16', '*Идентификатор поля (из запроса)', 'N', 'N', 'COLUMNS_LIST', '', '', '1', '', '', '', ''
            ,':COLUMN_CODE', 'L', 'Y', '*', '', '', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT")
     Values ('FORM_COLUMN_ACTIONS', 'COL_ACTION_TYPE_CODE', 'Тип действия', '*', 'S', '50', 'N', 'Y', '', '', '', '8'
            ,'*Тип действия (лукап FORM_COLUMNS.ACTION_TYPE)', 'N', 'N', 'FORM_COLUMNS.ACTION_TYPE', '', '', '', '', ''
            ,'', '', '', 'L', 'Y', '*', '', '', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT")
     Values ('FORM_COLUMN_ACTIONS', 'FORM_CODE', 'Идентификатор форм', '*', 'S', '20', 'N', 'Y', '', '1', '', ''
            ,'*Идентификатор форм', 'N', 'N', '', '', '', '1', '', '', '', '', ':FORM_CODE', 'L', 'Y', '*', '', '', ''
            ,'');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT")
     Values ('FORM_COLUMN_ACTIONS', 'FORM_COLUMN_ACTION_ID', 'Ключ. Для обновления из интерфейса', '*', 'N', '10', 'Y'
            ,'N', '', '', '', '', '*Ключ. Для обновления из интерфейса', 'N', 'N', '', '', '', '', '', '', '', '', ''
            ,'L', 'Y', '*', '', '', '', '');
/*  Form: FORM_COLUMN_ACTIONS. Entity: FORM_COLUMN_ATTR_VALS.  */
/*  Form: FORM_COLUMN_ACTIONS. Entity: FORM_TAB_PARENT_EXCLNS.  */
/*  Form: FORM_COLUMN_ACTIONS. Entity: FORM_TAB_CHILDS_ALLOWED.  */
/*  Form: FORM_COLUMN_ACTIONS. Entity: FORM_COLUMN_ACTIONS.  */
/*  Form: FORM_COLUMN_ACTIONS. Entity: FORM_COLUMN_LOOKUP_MAP.  */

Insert Into FORM_COLUMN_LOOKUP_MAP
            ("FORM_COLUMN_LOOKUP_MAP_ID", "FORM_CODE", "COLUMN_CODE", "LOOKUP_FORM_CODE", "LOOKUP_FORM_COLUMN_CODE"
            ,"MAPPING_TYPE", "CONSTANT_VALUE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DISPLAY_NUMBER"
            ,"SHOW_ON_GRID", "COLUMN_CODE_TO_MAPPING")
     Values ('20511', 'FORM_COLUMN_ACTIONS', 'COLUMN_CODE', 'COLUMNS_LIST', 'COLUMN_CODE', 'COLUMN', ''
            ,'Идентификатор поля (из запроса)', '*', '1001', 'Y', 'COLUMN_CODE');

Insert Into FORM_COLUMN_LOOKUP_MAP
            ("FORM_COLUMN_LOOKUP_MAP_ID", "FORM_CODE", "COLUMN_CODE", "LOOKUP_FORM_CODE", "LOOKUP_FORM_COLUMN_CODE"
            ,"MAPPING_TYPE", "CONSTANT_VALUE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DISPLAY_NUMBER"
            ,"SHOW_ON_GRID", "COLUMN_CODE_TO_MAPPING")
     Values ('20512', 'FORM_COLUMN_ACTIONS', 'ACTION_CODE', 'DBLCLICK_FORM_ACT_LIST', 'ACTION_CODE', 'COLUMN', ''
            ,'Код', '*', '1001', 'Y', 'ACTION_CODE');
/*  Form: FORM_COLUMN_ACTIONS. Entity: APPS_PRIVS.  */

Insert Into APPS_PRIVS
            ("APPS_CODE", "FORM_CODE")
     Values ('FC', 'FORM_COLUMN_ACTIONS');



Alter Table forms Enable VALIDATE Constraint forms_form_actions_fk;
Alter Table FORMS Enable All Triggers;

