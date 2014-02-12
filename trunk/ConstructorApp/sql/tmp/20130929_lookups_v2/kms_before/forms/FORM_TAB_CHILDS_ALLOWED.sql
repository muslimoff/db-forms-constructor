
Alter Table FORMS Disable All Triggers;
Alter Table forms Disable Constraint forms_form_actions_fk;
Delete From APPS_PRIVS
      Where form_code = 'FORM_TAB_CHILDS_ALLOWED';
Delete From FORM_TAB_CHILDS_ALLOWED
      Where form_code = 'FORM_TAB_CHILDS_ALLOWED';
Delete From FORM_TAB_PARENT_EXCLNS
      Where form_code = 'FORM_TAB_CHILDS_ALLOWED';
Delete From FORM_COLUMN_ATTR_VALS
      Where form_code = 'FORM_TAB_CHILDS_ALLOWED';
Delete From FORM_COLUMNS
      Where form_code = 'FORM_TAB_CHILDS_ALLOWED';
Delete From FORM_COLUMNS$
      Where form_code = 'FORM_TAB_CHILDS_ALLOWED';
Delete From FORM_ACTIONS
      Where form_code = 'FORM_TAB_CHILDS_ALLOWED';
Delete From FORM_TABS
      Where form_code = 'FORM_TAB_CHILDS_ALLOWED';
Delete From FORMS
      Where form_code = 'FORM_TAB_CHILDS_ALLOWED';
/*  Form: FORM_TAB_CHILDS_ALLOWED. Entity: FORMS.  */

Insert Into FORMS
            ("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID"
            ,"FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR"
            ,"OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH", "DESCRIPTION", "DOUBLE_CLICK_ACTION_CODE", "LOOKUP_WIDTH"
            ,"APPS_CODE", "EXPORT_ORDER", "LOOKUP_HEIGHT", "DRAGDROP_ACTION_CODE", "DATA_PAGE_SIZE")
     Values ('FORM_TAB_CHILDS_ALLOWED', ''
            ,'Select *
  From &fc_schema_owner..FORM_TAB_CHILDS_ALLOWED ftpe
 Where ftpe.form_code = :form_code
   And ftpe.tab_code = :tab_code
--   '
            ,'Динамические формы таба', 'G', 'Y', '', '*', '*', '', '', 'Y', '16', '*', '', '', '', '', '100', '', ''
            ,'');
/*  Form: FORM_TAB_CHILDS_ALLOWED. Entity: FORM_TABS.  */
/*  Form: FORM_TAB_CHILDS_ALLOWED. Entity: FORM_ACTIONS.  */

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT", "PARENT_ACTION_CODE"
            ,"DISPLAY_IN_CONTEXT_MENU", "AUTOCOMMIT", "STATUS_BUTTON_PARAM", "STATUS_MSG_LEVEL_PARAM"
            ,"STATUS_MSG_TXT_PARAM")
     Values ('FORM_TAB_CHILDS_ALLOWED', 'DEL', '&fc_schema_owner..FORM_TAB_CHILDS_ALLOWED_PKG.p_delete', 'Удалить'
            ,'48', '', '', '3', '130', 'Вы уверены что хотите удалить запись?', '', 'N', 'Y', '', '', '', 'Y', 'Y', ''
            ,'', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT", "PARENT_ACTION_CODE"
            ,"DISPLAY_IN_CONTEXT_MENU", "AUTOCOMMIT", "STATUS_BUTTON_PARAM", "STATUS_MSG_LEVEL_PARAM"
            ,"STATUS_MSG_TXT_PARAM")
     Values ('FORM_TAB_CHILDS_ALLOWED', 'EDIT', '', 'Редактировать', '50', '', '', '8', '115', 'Вы уверены?', '', 'N'
            ,'Y', '', '', '', 'Y', 'Y', '', '', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT", "PARENT_ACTION_CODE"
            ,"DISPLAY_IN_CONTEXT_MENU", "AUTOCOMMIT", "STATUS_BUTTON_PARAM", "STATUS_MSG_LEVEL_PARAM"
            ,"STATUS_MSG_TXT_PARAM")
     Values ('FORM_TAB_CHILDS_ALLOWED', 'INS', '', 'Создать', '47', '', '', '1', '110', '', '', 'N', 'Y', '', '', ''
            ,'Y', 'Y', '', '', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT", "PARENT_ACTION_CODE"
            ,"DISPLAY_IN_CONTEXT_MENU", "AUTOCOMMIT", "STATUS_BUTTON_PARAM", "STATUS_MSG_LEVEL_PARAM"
            ,"STATUS_MSG_TXT_PARAM")
     Values ('FORM_TAB_CHILDS_ALLOWED', 'REFR', '', 'Обновить', '15', '', '', '4', '10', '', '', 'N', 'Y', '', '', ''
            ,'Y', 'Y', '', '', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT", "PARENT_ACTION_CODE"
            ,"DISPLAY_IN_CONTEXT_MENU", "AUTOCOMMIT", "STATUS_BUTTON_PARAM", "STATUS_MSG_LEVEL_PARAM"
            ,"STATUS_MSG_TXT_PARAM")
     Values ('FORM_TAB_CHILDS_ALLOWED', 'UPD', '&fc_schema_owner..FORM_TAB_CHILDS_ALLOWED_PKG.p_ins_upd', 'Сохранить'
            ,'46', '', '', '2', '120', 'Вы уверены?', '', 'N', 'Y', '', '', '', 'Y', 'Y', '', '', '');
/*  Form: FORM_TAB_CHILDS_ALLOWED. Entity: FORM_COLUMNS$.  */

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('4', 'VARCHAR2', '4000', 'CHILD_FORM_CODE', '15', '0', '0', 'FORM_TAB_CHILDS_ALLOWED', '', '*'
            ,'*????? ???????? ????? ? ????? ????/????');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('2', 'VARCHAR2', '4000', 'FORM_CODE', '9', '0', '0', 'FORM_TAB_CHILDS_ALLOWED', '', '*', '*??? ?????');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('1', 'NUMBER', '22', 'FORM_TAB_CHILDS_ALLOWED_ID', '26', '0', '-127', 'FORM_TAB_CHILDS_ALLOWED', '', '*'
            ,'**FORM_TAB_CHILDS_ALLOWED_ID');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('3', 'VARCHAR2', '4000', 'TAB_CODE', '8', '0', '0', 'FORM_TAB_CHILDS_ALLOWED', '', '*'
            ,'*????????????? ????????');
/*  Form: FORM_TAB_CHILDS_ALLOWED. Entity: FORM_COLUMNS.  */

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT")
     Values ('FORM_TAB_CHILDS_ALLOWED', 'CHILD_FORM_CODE', 'Дочерняя форма', '*', 'S', '1003', 'N', 'Y', '', '', ''
            ,'9', '*????? ???????? ????? ? ????? ????/????', 'N', 'N', 'FORMS_LIST', '', '', '', '', '', '', '', ''
            ,'L', 'Y', '*', '', '', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT")
     Values ('FORM_TAB_CHILDS_ALLOWED', 'FORM_CODE', 'Код формы', '*', 'S', '1001', 'N', 'N', '', '', '', '9'
            ,'*??? ?????', 'N', 'N', 'FORMS_LIST', '', '', '', '', '', '', '', ':FORM_CODE', 'L', 'Y', '*', '', '', ''
            ,'');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT")
     Values ('FORM_TAB_CHILDS_ALLOWED', 'FORM_TAB_CHILDS_ALLOWED_ID', 'Идентификатор записи', '*', 'N', '1001', 'Y'
            ,'N', '', '', '', '', '**FORM_TAB_CHILDS_ALLOWED_ID', 'N', 'N', '', '', '', '', '', '', '', '', '', 'L'
            ,'Y', '*', '', '', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT")
     Values ('FORM_TAB_CHILDS_ALLOWED', 'TAB_CODE', 'Код закладки', '*', 'S', '1002', 'N', 'N', '', '', '', '9'
            ,'*????????????? ????????', 'N', 'N', 'FORM_TABS_LIST', '', '', '', '', '', '', '', ':TAB_CODE', 'L', 'Y'
            ,'*', '', '', '', '');
/*  Form: FORM_TAB_CHILDS_ALLOWED. Entity: FORM_COLUMN_ATTR_VALS.  */
/*  Form: FORM_TAB_CHILDS_ALLOWED. Entity: FORM_TAB_PARENT_EXCLNS.  */
/*  Form: FORM_TAB_CHILDS_ALLOWED. Entity: FORM_TAB_CHILDS_ALLOWED.  */
/*  Form: FORM_TAB_CHILDS_ALLOWED. Entity: APPS_PRIVS.  */

Insert Into APPS_PRIVS
            ("APPS_CODE", "FORM_CODE")
     Values ('FC', 'FORM_TAB_CHILDS_ALLOWED');

Insert Into APPS_PRIVS
            ("APPS_CODE", "FORM_CODE")
     Values ('HCMM', 'FORM_TAB_CHILDS_ALLOWED');


Declare
   l_clob   Clob := ' ';
Begin
   Update FORMS
      Set description = l_clob
    Where form_code = 'FORM_TAB_CHILDS_ALLOWED';
End;
/

Alter Table forms Enable VALIDATE Constraint forms_form_actions_fk;
Alter Table FORMS Enable All Triggers;

