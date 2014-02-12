
Alter Table FORMS Disable All Triggers;
Alter Table forms Disable Constraint forms_form_actions_fk;
Delete From APPS_PRIVS
      Where form_code = 'FORM_TAB_PARENT_EXCLNS';
Delete From FORM_COLUMN_LOOKUP_MAP
      Where form_code = 'FORM_TAB_PARENT_EXCLNS';
Delete From FORM_COLUMN_ACTIONS
      Where form_code = 'FORM_TAB_PARENT_EXCLNS';
Delete From FORM_TAB_CHILDS_ALLOWED
      Where form_code = 'FORM_TAB_PARENT_EXCLNS';
Delete From FORM_TAB_PARENT_EXCLNS
      Where form_code = 'FORM_TAB_PARENT_EXCLNS';
Delete From FORM_COLUMN_ATTR_VALS
      Where form_code = 'FORM_TAB_PARENT_EXCLNS';
Delete From FORM_COLUMNS
      Where form_code = 'FORM_TAB_PARENT_EXCLNS';
Delete From FORM_COLUMNS$
      Where form_code = 'FORM_TAB_PARENT_EXCLNS';
Delete From FORM_ACTIONS
      Where form_code = 'FORM_TAB_PARENT_EXCLNS';
Delete From FORM_TABS
      Where form_code = 'FORM_TAB_PARENT_EXCLNS';
Delete From FORMS
      Where form_code = 'FORM_TAB_PARENT_EXCLNS';
/*  Form: FORM_TAB_PARENT_EXCLNS. Entity: FORMS.  */

Insert Into FORMS
            ("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID"
            ,"FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR"
            ,"OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH", "DESCRIPTION", "DOUBLE_CLICK_ACTION_CODE", "LOOKUP_WIDTH"
            ,"APPS_CODE", "EXPORT_ORDER", "LOOKUP_HEIGHT", "DRAGDROP_ACTION_CODE", "DATA_PAGE_SIZE")
     Values ('FORM_TAB_PARENT_EXCLNS', ''
            ,'Select *
  From &fc_schema_owner..FORM_TAB_PARENT_EXCLNS a
 Where :form_code = a.form_code
   and NVL(:tab_code, a.tab_code) = a.tab_code'
            ,'Исключение вкладок', 'G', 'Y', '', '*', '*', '', '', 'Y', '21', '*', '', '', '', 'FC', '100', '', '', '');
/*  Form: FORM_TAB_PARENT_EXCLNS. Entity: FORM_TABS.  */
/*  Form: FORM_TAB_PARENT_EXCLNS. Entity: FORM_ACTIONS.  */

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT", "PARENT_ACTION_CODE"
            ,"DISPLAY_IN_CONTEXT_MENU", "AUTOCOMMIT", "STATUS_BUTTON_PARAM", "STATUS_MSG_LEVEL_PARAM"
            ,"STATUS_MSG_TXT_PARAM")
     Values ('FORM_TAB_PARENT_EXCLNS', 'DEL', '&fc_schema_owner..FORM_TAB_PARENT_EXCLNS_PKG.p_delete', 'Удалить', '48'
            ,'', '', '3', '130', 'Вы уверены что хотите удалить запись?', '', 'N', 'Y', '', '', '', 'Y', 'Y', '', ''
            ,'');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT", "PARENT_ACTION_CODE"
            ,"DISPLAY_IN_CONTEXT_MENU", "AUTOCOMMIT", "STATUS_BUTTON_PARAM", "STATUS_MSG_LEVEL_PARAM"
            ,"STATUS_MSG_TXT_PARAM")
     Values ('FORM_TAB_PARENT_EXCLNS', 'EDIT', '', 'Редактировать', '50', '', '', '8', '115', 'Вы уверены?', '', 'N'
            ,'Y', '', '', '', 'Y', 'Y', '', '', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT", "PARENT_ACTION_CODE"
            ,"DISPLAY_IN_CONTEXT_MENU", "AUTOCOMMIT", "STATUS_BUTTON_PARAM", "STATUS_MSG_LEVEL_PARAM"
            ,"STATUS_MSG_TXT_PARAM")
     Values ('FORM_TAB_PARENT_EXCLNS', 'INS', '', 'Создать', '47', '', '', '1', '110', '', '', 'N', 'Y', '', '', ''
            ,'Y', 'Y', '', '', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT", "PARENT_ACTION_CODE"
            ,"DISPLAY_IN_CONTEXT_MENU", "AUTOCOMMIT", "STATUS_BUTTON_PARAM", "STATUS_MSG_LEVEL_PARAM"
            ,"STATUS_MSG_TXT_PARAM")
     Values ('FORM_TAB_PARENT_EXCLNS', 'REFR', '', 'Обновить', '15', '', '', '4', '10', '', '', 'N', 'Y', '', '', ''
            ,'Y', 'Y', '', '', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT", "PARENT_ACTION_CODE"
            ,"DISPLAY_IN_CONTEXT_MENU", "AUTOCOMMIT", "STATUS_BUTTON_PARAM", "STATUS_MSG_LEVEL_PARAM"
            ,"STATUS_MSG_TXT_PARAM")
     Values ('FORM_TAB_PARENT_EXCLNS', 'UPD', '&fc_schema_owner..FORM_TAB_PARENT_EXCLNS_PKG.p_ins_upd', 'Сохранить'
            ,'46', '', '', '2', '120', 'Вы уверены?', '', 'N', 'Y', '', '', '', 'Y', 'Y', '', '', '');
/*  Form: FORM_TAB_PARENT_EXCLNS. Entity: FORM_COLUMNS$.  */

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('5', 'NUMBER', '22', 'EXCLN_ID', '8', '0', '-127', 'FORM_TAB_PARENT_EXCLNS', '', '*', '*ID');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('1', 'VARCHAR2', '4000', 'FORM_CODE', '9', '0', '0', 'FORM_TAB_PARENT_EXCLNS', '', '*', '*??? ?????');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('4', 'VARCHAR2', '8', 'INCLUDED_FLAG', '13', '0', '0', 'FORM_TAB_PARENT_EXCLNS', '', '*'
            ,'**INCLUDED_FLAG');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('3', 'VARCHAR2', '4000', 'PARENT_FORM_CODE', '16', '0', '0', 'FORM_TAB_PARENT_EXCLNS', '', '*'
            ,'**PARENT_FORM_CODE');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('2', 'VARCHAR2', '4000', 'TAB_CODE', '8', '0', '0', 'FORM_TAB_PARENT_EXCLNS', '', '*'
            ,'*????????????? ????????');
/*  Form: FORM_TAB_PARENT_EXCLNS. Entity: FORM_COLUMNS.  */

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT")
     Values ('FORM_TAB_PARENT_EXCLNS', 'EXCLN_ID', 'ID', '*', 'N', '1005', 'Y', 'N', '', '', '', '', '*ID', 'N', 'N'
            ,'', '', '', '', '', '', '', '', '', 'L', 'Y', '*', '', '', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT")
     Values ('FORM_TAB_PARENT_EXCLNS', 'FORM_CODE', 'Идентификатор форм', '*', 'S', '1001', 'N', 'N', '', '', '', ''
            ,'*Идентификатор форм', 'N', 'N', '', '', '', '', '', '', '', '', ':FORM_CODE', 'L', 'Y', '*', '', '', ''
            ,'');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT")
     Values ('FORM_TAB_PARENT_EXCLNS', 'INCLUDED_FLAG', '', '*', 'B', '1004', 'N', 'Y', '', '', '', ''
            ,'**INCLUDED_FLAG', 'N', 'N', '', '', '', '', '', '', '', '', '', 'L', 'Y', '*', '', '', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT")
     Values ('FORM_TAB_PARENT_EXCLNS', 'PARENT_FORM_CODE', '', '*', 'S', '1003', 'N', 'Y', '', '', '', '16'
            ,'**PARENT_FORM_CODE', 'N', 'N', 'FORMS_LIST', '', '', '', '', '', '', '', '', 'L', 'Y', '*', '', '', ''
            ,'');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT")
     Values ('FORM_TAB_PARENT_EXCLNS', 'TAB_CODE', 'Идентификатор закладки', '*', 'S', '1002', 'N', 'N', '', '', '', ''
            ,'*Идентификатор закладки', 'N', 'N', '', '', '', '', '', '', '', '', ':TAB_CODE', 'L', 'Y', '*', '', ''
            ,'', '');
/*  Form: FORM_TAB_PARENT_EXCLNS. Entity: FORM_COLUMN_ATTR_VALS.  */
/*  Form: FORM_TAB_PARENT_EXCLNS. Entity: FORM_TAB_PARENT_EXCLNS.  */
/*  Form: FORM_TAB_PARENT_EXCLNS. Entity: FORM_TAB_CHILDS_ALLOWED.  */
/*  Form: FORM_TAB_PARENT_EXCLNS. Entity: FORM_COLUMN_ACTIONS.  */
/*  Form: FORM_TAB_PARENT_EXCLNS. Entity: FORM_COLUMN_LOOKUP_MAP.  */

Insert Into FORM_COLUMN_LOOKUP_MAP
            ("FORM_COLUMN_LOOKUP_MAP_ID", "FORM_CODE", "COLUMN_CODE", "LOOKUP_FORM_CODE", "LOOKUP_FORM_COLUMN_CODE"
            ,"MAPPING_TYPE", "CONSTANT_VALUE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DISPLAY_NUMBER"
            ,"SHOW_ON_GRID", "COLUMN_CODE_TO_MAPPING")
     Values ('20517', 'FORM_TAB_PARENT_EXCLNS', 'PARENT_FORM_CODE', 'FORMS_LIST', 'FORM_CODE', 'COLUMN', ''
            ,'Код формы', '*', '1001', 'N', 'PARENT_FORM_CODE');
/*  Form: FORM_TAB_PARENT_EXCLNS. Entity: APPS_PRIVS.  */

Insert Into APPS_PRIVS
            ("APPS_CODE", "FORM_CODE")
     Values ('SC', 'FORM_TAB_PARENT_EXCLNS');

Insert Into APPS_PRIVS
            ("APPS_CODE", "FORM_CODE")
     Values ('INS', 'FORM_TAB_PARENT_EXCLNS');

Insert Into APPS_PRIVS
            ("APPS_CODE", "FORM_CODE")
     Values ('FC', 'FORM_TAB_PARENT_EXCLNS');


Declare
   l_clob   Clob
      := 'Исключение из формы вкладок в случае если одна и та же форма может выступать как главная форма, так и как подчиненная.';
Begin
   Update FORMS
      Set description = l_clob
    Where form_code = 'FORM_TAB_PARENT_EXCLNS';
End;
/

Alter Table forms Enable VALIDATE Constraint forms_form_actions_fk;
Alter Table FORMS Enable All Triggers;

