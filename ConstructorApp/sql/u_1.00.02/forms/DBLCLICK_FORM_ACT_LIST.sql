Alter Table FORMS Disable All Triggers;
Delete From FORM_COLUMNS
      Where form_code = 'DBLCLICK_FORM_ACT_LIST';
Delete From FORM_COLUMNS$
      Where form_code = 'DBLCLICK_FORM_ACT_LIST';
Delete From FORM_ACTIONS
      Where form_code = 'DBLCLICK_FORM_ACT_LIST';
Delete From FORM_TABS
      Where form_code = 'DBLCLICK_FORM_ACT_LIST';
Delete From FORMS
      Where form_code = 'DBLCLICK_FORM_ACT_LIST';
/*  Form: DBLCLICK_FORM_ACT_LIST. Entity: FORMS.  */

Insert Into FORMS
            ("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID"
            ,"FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR"
            ,"OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH", "DESCRIPTION", "DOUBLE_CLICK_ACTION_CODE")
     Values ('DBLCLICK_FORM_ACT_LIST', ''
            ,'Select fa.action_code, NVL (fa.action_display_name, fa.action_code) As action_display_name
  From lookup_values lv, lookup_attributes la, lookup_attribute_values lav, form_actions fa
 Where lv.lookup_code = ''FORM_ACTIONS.ACTION_TYPE''
   And lv.lookup_code = la.lookup_code
   And la.attribute_code = ''AS_DUBLE_CLICK_ALLOWED''
   And la.attribute_code = lav.attribute_code
   And lv.lookup_value_code = lav.lookup_value_code
   And lv.lookup_code = lav.lookup_code
   And lav.attribute_value_char = ''Y''
   And fa.form_code = :form_code 
   And fa.action_type = lv.lookup_value_code
'
            ,'Список действий (дв.щелчок)', 'G', 'Y', '', '*', '*', '', '', 'Y', '6', '*', '', '');
/*  Form: DBLCLICK_FORM_ACT_LIST. Entity: FORM_TABS.  */
/*  Form: DBLCLICK_FORM_ACT_LIST. Entity: FORM_ACTIONS.  */

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('DBLCLICK_FORM_ACT_LIST', 'DEL', 'DBLCLICK_FORM_ACT_LIST_PKG.p_delete', 'Удалить', '48', '', '', '3'
            ,'130', 'Вы уверенны что хотите удалить запись?', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('DBLCLICK_FORM_ACT_LIST', 'EDIT', '', 'Редактировать', '50', '', '', '8', '115', 'Вы уверенны?', '', 'N'
            ,'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('DBLCLICK_FORM_ACT_LIST', 'INS', '', 'Создать', '47', '', '', '1', '110', '', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('DBLCLICK_FORM_ACT_LIST', 'REFR', '', 'Обновить', '15', '', '', '4', '10', '', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('DBLCLICK_FORM_ACT_LIST', 'UPD', 'DBLCLICK_FORM_ACT_LIST_PKG.p_ins_upd', 'Сохранить', '46', '', '', '2'
            ,'120', 'Вы уверенны?', '', 'N', 'Y', '');
/*  Form: DBLCLICK_FORM_ACT_LIST. Entity: FORM_COLUMNS$.  */

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('1', 'VARCHAR2', '1020', 'ACTION_CODE', '11', '0', '0', 'DBLCLICK_FORM_ACT_LIST', '', '*', '**ACTION_CODE');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('2', 'VARCHAR2', '1020', 'ACTION_DISPLAY_NAME', '19', '0', '0', 'DBLCLICK_FORM_ACT_LIST', '', '*'
            ,'**ACTION_DISPLAY_NAME');
/*  Form: DBLCLICK_FORM_ACT_LIST. Entity: FORM_COLUMNS.  */

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE")
     Values ('DBLCLICK_FORM_ACT_LIST', 'ACTION_CODE', 'Код', '*', 'S', '1001', 'N', 'Y', '', '', '', ''
            ,'**ACTION_CODE', 'N', 'N', '', '', '', '1', '', '', '', '', '', 'L', 'Y', '*', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE")
     Values ('DBLCLICK_FORM_ACT_LIST', 'ACTION_DISPLAY_NAME', 'Наименование', '*', 'S', '1002', 'N', 'Y', '', '', ''
            ,'', '**ACTION_DISPLAY_NAME', 'N', 'N', '', '', '', '2', '', '', '', '', '', 'L', 'Y', '*', '');

Alter Table FORMS Enable All Triggers;

