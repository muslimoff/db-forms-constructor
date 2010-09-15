/*****************COLUMNS_LIST*********************/
Alter Table FORMS Disable All Triggers;
Alter Table forms Disable Constraint forms_form_actions_fk;
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
            ,"OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH", "DESCRIPTION", "DOUBLE_CLICK_ACTION_CODE", "LOOKUP_WIDTH"
            ,"APPS_CODE", "EXPORT_ORDER")
     Values ('COLUMNS_LIST', ''
            ,'Select   column_code, NVL (column_user_name, column_code) column_user_name
    From Table (&fc_schema_owner..form_utils.describe_form_columns_pl (:form_code))
'
            ,'Список Столбцы', 'G', 'Y', '11', '*', '*', '', '', 'Y', '10', '*', '', '', '', 'FC', '10');
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
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('COLUMNS_LIST', 'COLUMN_CODE', '', '*', 'S', '1001', 'N', 'Y', '', '', '', ''
            ,'*Идентификатор поля (из запроса)', 'N', 'N', '', '', '', '1', '', '', '', '', '', '', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('COLUMNS_LIST', 'COLUMN_USER_NAME', '', '*', 'S', '1002', 'N', 'Y', '', '', '', ''
            ,'*Пользовательское имя поля', 'N', 'N', '', '', '', '2', '', '', '', '', '', '', 'Y', '*', '', '');

Alter Table forms Enable VALIDATE Constraint forms_form_actions_fk;
Alter Table FORMS Enable All Triggers;
/*****************DBLCLICK_FORM_ACT_LIST*********************/
Alter Table FORMS Disable All Triggers;
Alter Table forms Disable Constraint forms_form_actions_fk;
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
            ,"OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH", "DESCRIPTION", "DOUBLE_CLICK_ACTION_CODE", "LOOKUP_WIDTH"
            ,"APPS_CODE", "EXPORT_ORDER")
     Values ('DBLCLICK_FORM_ACT_LIST', ''
            ,'Select fa.action_code, NVL (fa.action_display_name, fa.action_code) As action_display_name
  From &fc_schema_owner..lookup_values lv, &fc_schema_owner..lookup_attributes la, &fc_schema_owner..lookup_attribute_values lav, &fc_schema_owner..form_actions fa
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
            ,'Список действий (дв.щелчок)', 'G', 'Y', '11', '*', '*', '', '', 'Y', '12', '*', '', '', '', 'FC', '10');
/*  Form: DBLCLICK_FORM_ACT_LIST. Entity: FORM_TABS.  */
/*  Form: DBLCLICK_FORM_ACT_LIST. Entity: FORM_ACTIONS.  */

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('DBLCLICK_FORM_ACT_LIST', 'REFR', '', 'Обновить', '15', '', '', '4', '10', '', '', 'N', 'Y', '');
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
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('DBLCLICK_FORM_ACT_LIST', 'ACTION_CODE', 'Код', '*', 'S', '1001', 'N', 'Y', '', '', '', ''
            ,'**ACTION_CODE', 'N', 'N', '', '', '', '1', '', '', '', '', '', 'L', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('DBLCLICK_FORM_ACT_LIST', 'ACTION_DISPLAY_NAME', 'Наименование', '*', 'S', '1002', 'N', 'Y', '', '', ''
            ,'', '**ACTION_DISPLAY_NAME', 'N', 'N', '', '', '', '2', '', '', '', '', '', 'L', 'Y', '*', '', '');

Alter Table forms Enable VALIDATE Constraint forms_form_actions_fk;
Alter Table FORMS Enable All Triggers;
/*****************FORMS_LIST*********************/
Alter Table FORMS Disable All Triggers;
Alter Table forms Disable Constraint forms_form_actions_fk;
Delete From FORM_COLUMNS
      Where form_code = 'FORMS_LIST';
Delete From FORM_COLUMNS$
      Where form_code = 'FORMS_LIST';
Delete From FORM_ACTIONS
      Where form_code = 'FORMS_LIST';
Delete From FORM_TABS
      Where form_code = 'FORMS_LIST';
Delete From FORMS
      Where form_code = 'FORMS_LIST';
/*  Form: FORMS_LIST. Entity: FORMS.  */

Insert Into FORMS
            ("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID"
            ,"FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR"
            ,"OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH", "DESCRIPTION", "DOUBLE_CLICK_ACTION_CODE", "LOOKUP_WIDTH"
            ,"APPS_CODE", "EXPORT_ORDER")
     Values ('FORMS_LIST', ''
            ,'Select a.form_code, NVL (a.form_name, a.form_code) form_name, a.hot_key, a.icon_id
  From &fc_schema_owner..forms_v a'
            ,'Список Формы', 'G', 'Y', '11', '*', '*', '', '', 'Y', '23', '*', '', '', '250', 'FC', '10');
/*  Form: FORMS_LIST. Entity: FORM_TABS.  */
/*  Form: FORMS_LIST. Entity: FORM_ACTIONS.  */
/*  Form: FORMS_LIST. Entity: FORM_COLUMNS$.  */

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('1', 'VARCHAR2', '1020', 'FORM_CODE', '9', '0', '0', 'FORMS_LIST', '', '*', '*Идентификатор форм');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('2', 'VARCHAR2', '1020', 'FORM_NAME', '9', '0', '0', 'FORMS_LIST', '', '*', '*Имя формы для пользователя');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('3', 'VARCHAR2', '400', 'HOT_KEY', '7', '0', '0', 'FORMS_LIST', '', '*'
            ,'*Горячая клавиша  - строка вида [Ctrl+][Alt+][Shift+]Chr. Регистр не важен');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('4', 'NUMBER', '22', 'ICON_ID', '7', '0', '-127', 'FORMS_LIST', '', '*', '**ICON_ID');
/*  Form: FORMS_LIST. Entity: FORM_COLUMNS.  */

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORMS_LIST', 'FORM_CODE', '', '*', 'S', '1001', 'N', 'N', '', '', '', '', '*Идентификатор форм', 'N', 'N'
            ,'', '', '', '1', '', '', '', '', '', '', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORMS_LIST', 'FORM_NAME', 'Форма', '*', 'S', '1002', 'N', 'Y', '', '', '', ''
            ,'*Имя формы для пользователя', 'N', 'N', '', '', '', '2', '', '', '', '', '', '', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORMS_LIST', 'HOT_KEY', '', '*', 'S', '1003', 'N', 'N', '', '', '', ''
            ,'*Горячая клавиша  - строка вида [Ctrl+][Alt+][Shift+]Chr. Регистр не важен', 'N', 'N', '', '', '', '', ''
            ,'', '', '', '', '', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORMS_LIST', 'ICON_ID', 'Icon', '20%', 'N', '5', 'N', 'Y', '', '', '', '3', '**ICON_ID', 'N', 'N', '', ''
            ,'', '3', '', '', '', '', '', '', 'Y', '*', '', '');

Alter Table forms Enable VALIDATE Constraint forms_form_actions_fk;
Alter Table FORMS Enable All Triggers;
/*****************FORM_TABS*********************/
Alter Table FORMS Disable All Triggers;
Alter Table forms Disable Constraint forms_form_actions_fk;
Delete From FORM_COLUMNS
      Where form_code = 'FORM_TABS';
Delete From FORM_COLUMNS$
      Where form_code = 'FORM_TABS';
Delete From FORM_ACTIONS
      Where form_code = 'FORM_TABS';
Delete From FORM_TABS
      Where form_code = 'FORM_TABS';
Delete From FORMS
      Where form_code = 'FORM_TABS';
/*  Form: FORM_TABS. Entity: FORMS.  */

Insert Into FORMS
            ("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID"
            ,"FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR"
            ,"OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH", "DESCRIPTION", "DOUBLE_CLICK_ACTION_CODE", "LOOKUP_WIDTH"
            ,"APPS_CODE", "EXPORT_ORDER")
     Values ('FORM_TABS', 'shift+alt+ctrl+a'
            ,'Select *
  From &fc_schema_owner..form_tabs a
 Where DECODE (:p_$master_form_code, ''FORMS'', :form_code, ''FORMS2'', :form_code_for_filter,''MENUS'',:form_code_for_filter, a.form_code) = a.form_code
'
            ,'Детальная Вкладки', 'G', 'Y', '4', '*', '*', '', '', 'Y', '70', '*', '', '', '', 'FC', '10');
/*  Form: FORM_TABS. Entity: FORM_TABS.  */
/*  Form: FORM_TABS. Entity: FORM_ACTIONS.  */

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('FORM_TABS', 'DEL', '&fc_schema_owner..FORM_TABS_PKG.p_delete', 'Удалить', '48', '', '', '3', '130'
            ,'Вы уверенны что хотите удалить запись?', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('FORM_TABS', 'EDIT', '', 'Редактировать', '50', '', '', '8', '115', 'Вы уверенны?', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('FORM_TABS', 'INS', '', 'Создать', '47', '', '', '1', '110', '', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('FORM_TABS', 'REFR', '', 'Обновить', '15', '', '', '4', '10', '', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('FORM_TABS', 'UPD', '&fc_schema_owner..FORM_TABS_PKG.p_ins_upd', 'Сохранить', '46', '', '', '2', '120'
            ,'Вы уверенны?', '', 'N', 'Y', '');
/*  Form: FORM_TABS. Entity: FORM_COLUMNS$.  */

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('3', 'VARCHAR2', '1020', 'CHILD_FORM_CODE', '15', '0', '0', 'FORM_TABS', '', '*'
            ,'*Вызов дочерней формы в новом табе/окне');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('1', 'VARCHAR2', '1020', 'FORM_CODE', '9', '0', '0', 'FORM_TABS', 'Y', '*', '*Идентификатор форм');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('7', 'NUMBER', '22', 'ICON_ID', '7', '0', '-127', 'FORM_TABS', '', '*', '**ICON_ID');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('6', 'NUMBER', '22', 'NUMBER_OF_COLUMNS', '17', '0', '-127', 'FORM_TABS', '', '*'
            ,'*см. com.smartgwt.client.widgets.form.DynamicForm   setNumCols');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('2', 'VARCHAR2', '1020', 'TAB_CODE', '8', '0', '0', 'FORM_TABS', 'Y', '*', '*Идентификатор закладки');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('9', 'NUMBER', '22', 'TAB_DISPLAY_NUMBER', '18', '0', '-127', 'FORM_TABS', '', '*', '*Порядок сортировки');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('5', 'VARCHAR2', '1020', 'TAB_NAME', '8', '0', '0', 'FORM_TABS', '', '*', '*Пользовательское имя закладки');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('4', 'VARCHAR2', '4', 'TAB_POSITION', '12', '0', '0', 'FORM_TABS', '', '*'
            ,'*Lookup FORMS.EDITOR_POSITION');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('8', 'VARCHAR2', '8', 'TAB_TYPE', '8', '0', '0', 'FORM_TABS', '', '*', '**TAB_TYPE');
/*  Form: FORM_TABS. Entity: FORM_COLUMNS.  */

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_TABS', 'CHILD_FORM_CODE', 'Дочерняя форма', '*', 'S', '1003', 'N', 'Y', '', '', '', '9'
            ,'**CHILD_FORM_CODE', 'N', 'N', 'FORMS_LIST', '', '', '', '', '', '', '', '', '', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_TABS', 'FORM_CODE', 'Код формы', '*', 'S', '1001', 'Y', 'N', '', '1', '', '', '*Идентификатор форм'
            ,'N', 'N', '', '', '', '1', '', '', '', '', ':form_code_for_filter', '', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_TABS', 'ICON_ID', 'Иконка', '*', 'N', '1007', 'N', 'Y', '', '', '', '9', '**ICON_ID', 'N', 'N'
            ,'ICONS', '', '', '', '', '', '', '', '', '', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_TABS', 'NUMBER_OF_COLUMNS', 'Количество колонок', '*', 'N', '1006', 'N', 'Y', '', '', '', ''
            ,'*см. com.smartgwt.client.widgets.form.DynamicForm   setNumCols', 'N', 'N', '', '', '', '', '', '', '', ''
            ,'', '', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_TABS', 'TAB_CODE', 'Код закладки', '*', 'S', '1002', 'Y', 'Y', '', '1', '', ''
            ,'*Идентификатор закладки', 'N', 'N', '', '', '', '1', '', '', '', '', '', '', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_TABS', 'TAB_NAME', 'Наименование', '*', 'S', '1005', 'N', 'Y', '', '', '', ''
            ,'*Пользовательское имя закладки', 'N', 'N', '', '', '', '2', '', '', '', '', '', '', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_TABS', 'TAB_POSITION', 'Позиция', '*', 'S', '1004', 'N', 'Y', '', '', '', '8'
            ,'*Lookup FORMS.EDITOR_POSITION', 'N', 'N', 'FORMS.EDITOR_POSITION', '', '', '', '', '', '', '', '', ''
            ,'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_TABS', 'TAB_TYPE', 'Тип закладки', '*', 'S', '1008', 'N', 'Y', '', '', '', '8', '**TAB_TYPE', 'N'
            ,'N', 'FORM_TABS.TAB_TYPE', '', '', '', '', '', '', '', '', '', 'Y', '*', '', '');

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>Дочерняя форма.</b></font></span><div>Описание настройки.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_TABS'
      And column_code = 'CHILD_FORM_CODE';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>Иконка.</b></font></span><div>Описание настройки.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_TABS'
      And column_code = 'ICON_ID';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>Количество колонок.</b></font></span><div>Описание настройки.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_TABS'
      And column_code = 'NUMBER_OF_COLUMNS';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>Код закладки.</b></font></span><div>Описание настройки.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_TABS'
      And column_code = 'TAB_CODE';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>Наименование.</b></font></span><div>Описание настройки.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_TABS'
      And column_code = 'TAB_NAME';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>Позиция.</b></font></span><div>Описание настройки.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_TABS'
      And column_code = 'TAB_POSITION';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>Тип закладки.</b></font></span><div>Описание настройки.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_TABS'
      And column_code = 'TAB_TYPE';
End;
/

Alter Table forms Enable VALIDATE Constraint forms_form_actions_fk;
Alter Table FORMS Enable All Triggers;
/*****************FORM_TABS_LIST*********************/
Alter Table FORMS Disable All Triggers;
Alter Table forms Disable Constraint forms_form_actions_fk;
Delete From FORM_COLUMNS
      Where form_code = 'FORM_TABS_LIST';
Delete From FORM_COLUMNS$
      Where form_code = 'FORM_TABS_LIST';
Delete From FORM_ACTIONS
      Where form_code = 'FORM_TABS_LIST';
Delete From FORM_TABS
      Where form_code = 'FORM_TABS_LIST';
Delete From FORMS
      Where form_code = 'FORM_TABS_LIST';
/*  Form: FORM_TABS_LIST. Entity: FORMS.  */

Insert Into FORMS
            ("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID"
            ,"FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR"
            ,"OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH", "DESCRIPTION", "DOUBLE_CLICK_ACTION_CODE", "LOOKUP_WIDTH"
            ,"APPS_CODE", "EXPORT_ORDER")
     Values ('FORM_TABS_LIST', ''
            ,'Select   a.form_code, a.tab_code, NVL (a.tab_name, a.tab_code) tab_name, a.tab_type
    From &fc_schema_owner..form_tabs_v a
   Where
--a.form_code = NVL (:form_code, a.form_code)
a.form_code = :form_code
Order By a.tab_display_number
'
            ,'Список Вкладки', 'G', 'Y', '11', '*', '*', '', '', 'Y', '17', '*', '', '', '', 'FC', '10');
/*  Form: FORM_TABS_LIST. Entity: FORM_TABS.  */
/*  Form: FORM_TABS_LIST. Entity: FORM_ACTIONS.  */
/*  Form: FORM_TABS_LIST. Entity: FORM_COLUMNS$.  */

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('1', 'VARCHAR2', '1020', 'FORM_CODE', '9', '0', '0', 'FORM_TABS_LIST', '', '*', '*Идентификатор форм');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('2', 'VARCHAR2', '1020', 'TAB_CODE', '8', '0', '0', 'FORM_TABS_LIST', '', '*', '*Идентификатор закладки');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('3', 'VARCHAR2', '1020', 'TAB_NAME', '8', '0', '0', 'FORM_TABS_LIST', '', '*'
            ,'*Пользовательское имя закладки');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('4', 'VARCHAR2', '8', 'TAB_TYPE', '8', '0', '0', 'FORM_TABS_LIST', '', '*', '**TAB_TYPE');
/*  Form: FORM_TABS_LIST. Entity: FORM_COLUMNS.  */

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_TABS_LIST', 'FORM_CODE', '', '*', 'S', '1001', 'N', 'N', '', '', '', '', '*Идентификатор форм', 'N'
            ,'N', '', '', '', '', '', '', '', '', '', '', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_TABS_LIST', 'TAB_CODE', 'Код', '*', 'S', '1002', 'N', 'Y', '', '', '', '', '*Идентификатор закладки'
            ,'N', 'N', '', '', '', '1', '', '', '', '', '', '', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_TABS_LIST', 'TAB_NAME', 'Имя', '*', 'S', '1003', 'N', 'Y', '', '', '', ''
            ,'*Пользовательское имя закладки', 'N', 'N', '', '', '', '2', '', '', '', '', '', '', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_TABS_LIST', 'TAB_TYPE', 'Тип', '*', 'S', '1004', 'N', 'Y', '', '', '', '8', '**TAB_TYPE', 'N', 'N'
            ,'FORM_TABS.TAB_TYPE', '', '', '', '', '', '', '', '', '', 'Y', '*', '', '');

Alter Table forms Enable VALIDATE Constraint forms_form_actions_fk;
Alter Table FORMS Enable All Triggers;
/*****************ICONS*********************/
Alter Table FORMS Disable All Triggers;
Alter Table forms Disable Constraint forms_form_actions_fk;
Delete From FORM_COLUMNS
      Where form_code = 'ICONS';
Delete From FORM_COLUMNS$
      Where form_code = 'ICONS';
Delete From FORM_ACTIONS
      Where form_code = 'ICONS';
Delete From FORM_TABS
      Where form_code = 'ICONS';
Delete From FORMS
      Where form_code = 'ICONS';
/*  Form: ICONS. Entity: FORMS.  */

Insert Into FORMS
            ("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID"
            ,"FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR"
            ,"OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH", "DESCRIPTION", "DOUBLE_CLICK_ACTION_CODE", "LOOKUP_WIDTH"
            ,"APPS_CODE", "EXPORT_ORDER")
     Values ('ICONS', ''
            ,'Select a.icon_id, a.icon_id icon, a.icon_file_name, a.icon_path
  From &fc_schema_owner..icons a
-----------'
            ,'Иконки', '', 'N', '13', '', '', '', '', 'N', '127', '', '', '', '', 'FC', '10');
/*  Form: ICONS. Entity: FORM_TABS.  */
/*  Form: ICONS. Entity: FORM_ACTIONS.  */

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('ICONS', 'CUST_ACT', '&fc_schema_owner..ICONS_PKG.p_ins_upd', 'Что-то', '22', '', '', '7', '200'
            ,'Вы уверенны?', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('ICONS', 'DEL', '&fc_schema_owner..ICONS_PKG.p_delete', 'Удалить', '48', '', '', '3', '130'
            ,'Вы уверенны что хотите удалить запись?', '', 'Y', 'N', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('ICONS', 'EDIT', '', 'Редактировать', '50', '', '', '8', '115', 'Вы уверенны?', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('ICONS', 'INS', '', 'Создать', '47', '', '', '1', '110', '', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('ICONS', 'NEXT', '', 'Вперед', '53', '', '', '6', '40', '', '', 'Y', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('ICONS', 'PREV', '', 'Назад', '54', '', '', '5', '30', '', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('ICONS', 'REFRESH', '', 'Обновить', '55', '', '', '4', '10', '', 'Alt+R', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('ICONS', 'UPD', '&fc_schema_owner..ICONS_PKG.p_ins_upd', 'Сохранить', '46', '', '', '2', '120'
            ,'Вы уверенны?', '', 'N', 'Y', '');
/*  Form: ICONS. Entity: FORM_COLUMNS$.  */

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('2', 'NUMBER', '22', 'ICON', '4', '0', '-127', 'ICONS', '', '', '**ICON');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('3', 'VARCHAR2', '4000', 'ICON_FILE_NAME', '14', '0', '0', 'ICONS', '', ''
            ,'*файл иконки по пути default_icon_path');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('1', 'NUMBER', '22', 'ICON_ID', '7', '0', '-127', 'ICONS', '', '', '**ICON_ID');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('4', 'VARCHAR2', '1020', 'ICON_PATH', '9', '0', '0', 'ICONS', '', '', '**ICON_PATH');
/*  Form: ICONS. Entity: FORM_COLUMNS.  */

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('ICONS', 'ICON', 'Изображение', '10%', 'S', '1002', 'N', 'Y', '', '', '', '3', '**ICON', 'N', 'Y', ''
            ,'ICON_FILE_NAME', '', '2', '', '', '', '', '', '', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('ICONS', 'ICON_FILE_NAME', 'Файл', '*', 'S', '1003', 'N', 'Y', '', '', '', '', '*файл иконки', 'N', 'N'
            ,'', '', '', '3', '', '', '', '', '', '', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('ICONS', 'ICON_ID', 'Код иконки', '10%', 'S', '1001', 'Y', 'Y', '', '', '', '', '**ICON_ID', 'N', 'N', ''
            ,'', '', '1', '', '', '', '', '', '', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('ICONS', 'ICON_PATH', '', '*', 'S', '1004', 'N', 'Y', '', '', '', '', '**ICON_PATH', 'N', 'N', '', '', ''
            ,'3', '', '', '', '', '', '', 'Y', '*', '', '');

Alter Table forms Enable VALIDATE Constraint forms_form_actions_fk;
Alter Table FORMS Enable All Triggers;
/*****************LOOKUPS_LIST*********************/
Alter Table FORMS Disable All Triggers;
Alter Table forms Disable Constraint forms_form_actions_fk;
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
            ,"OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH", "DESCRIPTION", "DOUBLE_CLICK_ACTION_CODE", "LOOKUP_WIDTH"
            ,"APPS_CODE", "EXPORT_ORDER")
     Values ('LOOKUPS_LIST', ''
            ,'Select :field_type lookup_type, a.lookup_code, a.lookup_name, 111 As icon_id
  From &fc_schema_owner..lookups a
 Where :field_type In (''8'', ''10'')
Union All
Select :field_type lookup_type, a.form_code, NVL (a.form_name, a.form_code) form_name, a.icon_id
  From &fc_schema_owner..forms_v a
 Where :field_type In (''9'', ''11'')
'
            ,'Список Списки', 'G', 'Y', '11', '*', '*', '', '', 'Y', '33', '*', '', '', '', 'FC', '10');
/*  Form: LOOKUPS_LIST. Entity: FORM_TABS.  */
/*  Form: LOOKUPS_LIST. Entity: FORM_ACTIONS.  */
/*  Form: LOOKUPS_LIST. Entity: FORM_COLUMNS$.  */

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('4', 'NUMBER', '22', 'ICON_ID', '7', '0', '-127', 'LOOKUPS_LIST', '', '*', '**ICON_ID');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('2', 'VARCHAR2', '1020', 'LOOKUP_CODE', '11', '0', '0', 'LOOKUPS_LIST', '', '*'
            ,'*Ссылка на лукап - формау или простой');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('3', 'VARCHAR2', '1020', 'LOOKUP_NAME', '11', '0', '0', 'LOOKUPS_LIST', '', '*', '*Пользовательское имя');

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
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('LOOKUPS_LIST', 'ICON_ID', 'Иконка', '10%', 'N', '5', 'N', 'Y', '', '', '', '3', '**ICON_ID', 'N', 'N', ''
            ,'', '', '3', '', '', '', '', '', 'L', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('LOOKUPS_LIST', 'LOOKUP_CODE', 'Код', '*', 'S', '10', 'N', 'Y', '', '', '', ''
            ,'*Ссылка на лукап - формау или простой', 'N', 'N', '', '', '', '1', '', '', '', '', '', 'L', 'Y', '*', ''
            ,'');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('LOOKUPS_LIST', 'LOOKUP_NAME', 'Пользовательское имя', '*', 'S', '20', 'N', 'Y', '', '', '', ''
            ,'*Пользовательское имя', 'N', 'N', '', '', '', '2', '', '', '', '1', '', 'L', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('LOOKUPS_LIST', 'LOOKUP_TYPE', 'Тип', '*', 'S', '1001', 'N', 'N', '', '', '', '8'
            ,'*Тип - простой без редактирования, простой с добавлением на лету, SQL, SQL с добавлением', 'N', 'N'
            ,'FORM_COLUMNS.FIELD_TYPE', '', '', '', '', '', '', '', '', 'L', 'Y', '*', '', '');

Alter Table forms Enable VALIDATE Constraint forms_form_actions_fk;
Alter Table FORMS Enable All Triggers;
/*****************REPORTS*********************/
Alter Table FORMS Disable All Triggers;
Alter Table forms Disable Constraint forms_form_actions_fk;
Delete From FORM_COLUMNS
      Where form_code = 'REPORTS';
Delete From FORM_COLUMNS$
      Where form_code = 'REPORTS';
Delete From FORM_ACTIONS
      Where form_code = 'REPORTS';
Delete From FORM_TABS
      Where form_code = 'REPORTS';
Delete From FORMS
      Where form_code = 'REPORTS';
/*  Form: REPORTS. Entity: FORMS.  */

Insert Into FORMS
            ("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID"
            ,"FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR"
            ,"OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH", "DESCRIPTION", "DOUBLE_CLICK_ACTION_CODE", "LOOKUP_WIDTH"
            ,"APPS_CODE", "EXPORT_ORDER")
     Values ('REPORTS', '', 'select * from &fc_schema_owner..REPORT_TEMPLATES', 'Шаблоны отчетов', 'G', 'Y', '', '*'
            ,'*', '', '', 'Y', '19', '*', '', '', '', 'FC', '10');
/*  Form: REPORTS. Entity: FORM_TABS.  */
/*  Form: REPORTS. Entity: FORM_ACTIONS.  */

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('REPORTS', 'DEL', '&fc_schema_owner..REPORTS_PKG.p_delete', 'Удалить', '48', '', '', '3', '130'
            ,'Вы уверенны что хотите удалить запись?', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('REPORTS', 'EDIT', '', 'Редактировать', '50', '', '', '8', '115', 'Вы уверенны?', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('REPORTS', 'INS', '', 'Создать', '47', '', '', '1', '110', '', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('REPORTS', 'REFR', '', 'Обновить', '15', '', '', '4', '10', '', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('REPORTS', 'UPD', '&fc_schema_owner..REPORTS_PKG.p_ins_upd', 'Сохранить', '46', '', '', '2', '120'
            ,'Вы уверенны?', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('REPORTS', 'XMLP'
            ,'xmlp?type=xmlp&ContentType=application/rtf&template=MET&dataClobId=:CLOB_CONTENT&filename=:filename'
            ,'Пещать :report_type_code', '43', '', '', '15', '200', '', '', 'N', 'N', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('REPORTS', 'tmp', '', ':REPORT_TYPE_CODE - xxxx', '', '', '', '10', '140', 'Вы уверенны?', '', 'N', 'N'
            ,'');
/*  Form: REPORTS. Entity: FORM_COLUMNS$.  */

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('3', 'VARCHAR2', '1020', 'APP_CODE', '8', '0', '0', 'REPORTS', '', '*', '**APP_CODE');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('8', 'CLOB', '4000', 'CLOB_CONTENT', '12', '0', '0', 'REPORTS', '', '*', '**CLOB_CONTENT');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('6', 'BLOB', '4000', 'CONTENT', '7', '0', '0', 'REPORTS', '', '*', '**CONTENT');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('5', 'VARCHAR2', '1020', 'CONTENT_TYPE', '12', '0', '0', 'REPORTS', '', '*', '**CONTENT_TYPE');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('7', 'VARCHAR2', '1020', 'FILENAME', '8', '0', '0', 'REPORTS', '', '*', '**FILENAME');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('1', 'NUMBER', '22', 'REPORT_ID', '9', '0', '-127', 'REPORTS', '', '*', '*Идентификатор отчета');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('4', 'VARCHAR2', '1020', 'REPORT_TYPE_CODE', '16', '0', '0', 'REPORTS', '', '*', '**REPORT_TYPE_CODE');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('2', 'NUMBER', '22', 'USER_ID', '7', '0', '-127', 'REPORTS', '', '*', '*Database user id.');
/*  Form: REPORTS. Entity: FORM_COLUMNS.  */

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('REPORTS', 'CLOB_CONTENT', '', '*', 'CLOB', '1008', 'N', 'Y', '', '', '', '', '**CLOB_CONTENT', 'N', 'N'
            ,'', '', '', '', '', '', '', ''
            ,'/constructorapp/xmlp?type=xmlp&ContentType=application/rtf&template=MET&dataClobId=:CLOB_CONTENT', 'L'
            ,'Y', '*', '', '');

Alter Table forms Enable VALIDATE Constraint forms_form_actions_fk;
Alter Table FORMS Enable All Triggers;
/*****************USERS*********************/
Alter Table FORMS Disable All Triggers;
Alter Table forms Disable Constraint forms_form_actions_fk;
Delete From FORM_COLUMNS
      Where form_code = 'USERS';
Delete From FORM_COLUMNS$
      Where form_code = 'USERS';
Delete From FORM_ACTIONS
      Where form_code = 'USERS';
Delete From FORM_TABS
      Where form_code = 'USERS';
Delete From FORMS
      Where form_code = 'USERS';
/*  Form: USERS. Entity: FORMS.  */

Insert Into FORMS
            ("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID"
            ,"FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR"
            ,"OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH", "DESCRIPTION", "DOUBLE_CLICK_ACTION_CODE", "LOOKUP_WIDTH"
            ,"APPS_CODE", "EXPORT_ORDER")
     Values ('USERS', '', 'select * from &fc_schema_owner..users u
--',         'Пользователи', 'G', 'Y', '31', '*', '*', '', '', 'Y', '23', '*', '', '', '', 'FC', '10');
/*  Form: USERS. Entity: FORM_TABS.  */
/*  Form: USERS. Entity: FORM_ACTIONS.  */

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('USERS', 'DEL', '&fc_schema_owner..USERS_PKG.p_delete', 'Удалить', '48', '', '', '3', '130'
            ,'Вы уверенны что хотите удалить запись?', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('USERS', 'EDIT', '', 'Редактировать', '50', '', '', '8', '115', 'Вы уверенны?', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('USERS', 'INS', '', 'Создать', '47', '', '', '1', '110', '', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('USERS', 'REFR', '', 'Обновить', '15', '', '', '4', '10', '', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('USERS', 'UPD', '&fc_schema_owner..USERS_PKG.p_ins_upd', 'Сохранить', '46', '', '', '2', '120'
            ,'Вы уверенны?', '', 'N', 'Y', '');
/*  Form: USERS. Entity: FORM_COLUMNS$.  */

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('6', 'VARCHAR2', '4000', 'EMAIL', '5', '0', '0', 'USERS', '', '*', '*Email id of the employee');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('2', 'VARCHAR2', '4000', 'FIO', '3', '0', '0', 'USERS', '', '*', '*ФИО');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('5', 'NUMBER', '22', 'ORIG_REF_ID', '11', '10', '0', 'USERS', '', '*', '**ORIG_REF_ID');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('4', 'VARCHAR2', '255', 'PASSWORD', '8', '0', '0', 'USERS', '', '*', '*Deprecated-Password for logon');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('3', 'VARCHAR2', '1020', 'USERNAME', '8', '0', '0', 'USERS', '', '*'
            ,'*Identifying name of the registered user');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('1', 'NUMBER', '22', 'USER_ID', '7', '0', '-127', 'USERS', '', '*', '*Database user id.');
/*  Form: USERS. Entity: FORM_COLUMNS.  */

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('USERS', 'EMAIL', 'Email id of the employee', '*', 'S', '1006', 'N', 'Y', '', '', '', ''
            ,'*Email id of the employee', 'N', 'N', '', '', '', '', '', ''
            ,'^([a-zA-Z0-9_.\-+])+@(([a-zA-Z0-9\-])+\.)+[a-zA-Z0-9]{2,4}$', '', '', 'L', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('USERS', 'FIO', 'ФИО', '*', 'S', '1002', 'N', 'Y', '', '', '', '', '*ФИО', 'N', 'N', '', '', '', '3', ''
            ,'', '', '', '', 'L', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('USERS', 'PASSWORD', 'Password', '*', 'S', '1004', 'N', 'Y', '', '', '', ''
            ,'*Deprecated-Password for logon', 'N', 'N', '', '', '', '', '', '', '', '', '', 'L', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('USERS', 'USERNAME', 'User Name', '*', 'S', '1003', 'N', 'Y', '', '', '', ''
            ,'*Identifying name of the registered user', 'N', 'N', '', '', '', '2', '', '', '', '', '', 'L', 'Y', '*'
            ,'', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('USERS', 'USER_ID', 'Database user id.', '*', 'N', '1001', 'Y', 'N', '', '', '', '', '*Database user id.'
            ,'N', 'N', '', '', '', '1', '', '', '', '', '', 'L', 'Y', '*', '', '');

Alter Table forms Enable VALIDATE Constraint forms_form_actions_fk;
Alter Table FORMS Enable All Triggers;
/*****************LOOKUP_ATTRIBUTE_VALUES*********************/
Alter Table FORMS Disable All Triggers;
Alter Table forms Disable Constraint forms_form_actions_fk;
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
            ,"APPS_CODE", "EXPORT_ORDER")
     Values ('LOOKUP_ATTRIBUTE_VALUES', ''
            ,'select * from &fc_schema_owner..LOOKUP_ATTRIBUTE_VALUES lav
where
       lav.lookup_code = :lookup_code
and lav.lookup_value_code = :lookup_value_code'
            ,'Значения атрибутов', 'G', 'Y', '', '*', '*', '', '', 'Y', '9', '*', '', '', '', 'FC', '20');
/*  Form: LOOKUP_ATTRIBUTE_VALUES. Entity: FORM_TABS.  */
/*  Form: LOOKUP_ATTRIBUTE_VALUES. Entity: FORM_ACTIONS.  */

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('LOOKUP_ATTRIBUTE_VALUES', 'DEL', '&fc_schema_owner..LOOKUP_ATTRIBUTE_VALUES_PKG.p_delete', 'Удалить'
            ,'48', '', '', '3', '130', 'Вы уверенны что хотите удалить запись?', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('LOOKUP_ATTRIBUTE_VALUES', 'EDIT', '', 'Редактировать', '50', '', '', '8', '115', 'Вы уверенны?', '', 'N'
            ,'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('LOOKUP_ATTRIBUTE_VALUES', 'INS', '', 'Создать', '47', '', '', '1', '110', '', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('LOOKUP_ATTRIBUTE_VALUES', 'REFR', '', 'Обновить', '15', '', '', '4', '10', '', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('LOOKUP_ATTRIBUTE_VALUES', 'UPD', '&fc_schema_owner..LOOKUP_ATTRIBUTE_VALUES_PKG.p_ins_upd', 'Сохранить'
            ,'46', '', '', '2', '120', 'Вы уверенны?', '', 'N', 'Y', '');
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
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('LOOKUP_ATTRIBUTE_VALUES', 'ATTRIBUTE_CODE', '', '*', 'S', '1003', 'N', 'Y', '', '', '', '9'
            ,'**ATTRIBUTE_CODE', 'N', 'N', 'LOOKUP_ATTRIBUTES', '', '', '', '', '', '', '', '', 'L', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('LOOKUP_ATTRIBUTE_VALUES', 'LOOKUP_CODE', 'Ссылка на лукап - формау или простой', '*', 'S', '1001', 'N'
            ,'N', '', '', '', '', '*Ссылка на лукап - формау или простой', 'N', 'N', '', '', '', '', '', '', '', ''
            ,':lookup_code', 'L', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('LOOKUP_ATTRIBUTE_VALUES', 'LOOKUP_VALUE_CODE', '', '*', 'S', '1002', 'N', 'N', '', '', '', ''
            ,'**LOOKUP_VALUE_CODE', 'N', 'N', '', '', '', '', '', '', '', '', ':lookup_value_code', 'L', 'Y', '*', ''
            ,'');

Alter Table forms Enable VALIDATE Constraint forms_form_actions_fk;
Alter Table FORMS Enable All Triggers;
/*****************LOOKUP_ATTRIBUTES*********************/
Alter Table FORMS Disable All Triggers;
Alter Table forms Disable Constraint forms_form_actions_fk;
Delete From FORM_COLUMNS
      Where form_code = 'LOOKUP_ATTRIBUTES';
Delete From FORM_COLUMNS$
      Where form_code = 'LOOKUP_ATTRIBUTES';
Delete From FORM_ACTIONS
      Where form_code = 'LOOKUP_ATTRIBUTES';
Delete From FORM_TABS
      Where form_code = 'LOOKUP_ATTRIBUTES';
Delete From FORMS
      Where form_code = 'LOOKUP_ATTRIBUTES';
/*  Form: LOOKUP_ATTRIBUTES. Entity: FORMS.  */

Insert Into FORMS
            ("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID"
            ,"FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR"
            ,"OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH", "DESCRIPTION", "DOUBLE_CLICK_ACTION_CODE", "LOOKUP_WIDTH"
            ,"APPS_CODE", "EXPORT_ORDER")
     Values ('LOOKUP_ATTRIBUTES', ''
            ,'select * from &fc_schema_owner..LOOKUP_ATTRIBUTES la
where la.lookup_code = :lookup_code', 'Атрибуты', 'G', 'Y', '', '*', '*', '', '', 'Y', '10', '*', '', '', '', 'FC'
            ,'30');
/*  Form: LOOKUP_ATTRIBUTES. Entity: FORM_TABS.  */
/*  Form: LOOKUP_ATTRIBUTES. Entity: FORM_ACTIONS.  */

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('LOOKUP_ATTRIBUTES', 'DEL', '&fc_schema_owner..LOOKUP_ATTRIBUTES_PKG.p_delete', 'Удалить', '48', '', ''
            ,'3', '130', 'Вы уверенны что хотите удалить запись?', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('LOOKUP_ATTRIBUTES', 'EDIT', '', 'Редактировать', '50', '', '', '8', '115', 'Вы уверенны?', '', 'N', 'Y'
            ,'');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('LOOKUP_ATTRIBUTES', 'INS', '', 'Создать', '47', '', '', '1', '110', '', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('LOOKUP_ATTRIBUTES', 'REFR', '', 'Обновить', '15', '', '', '4', '10', '', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('LOOKUP_ATTRIBUTES', 'UPD', '&fc_schema_owner..LOOKUP_ATTRIBUTES_PKG.p_ins_upd', 'Сохранить', '46', '', ''
            ,'2', '120', 'Вы уверенны?', '', 'N', 'Y', '');
/*  Form: LOOKUP_ATTRIBUTES. Entity: FORM_COLUMNS$.  */

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('2', 'VARCHAR2', '1020', 'ATTRIBUTE_CODE', '14', '0', '0', 'LOOKUP_ATTRIBUTES', 'Y', '*', '*Код атрибута');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('3', 'VARCHAR2', '1020', 'ATTRIBUTE_NAME', '14', '0', '0', 'LOOKUP_ATTRIBUTES', '', '*'
            ,'*Name of the attribute');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('4', 'VARCHAR2', '4', 'ATTRIBUTE_TYPE', '14', '0', '0', 'LOOKUP_ATTRIBUTES', '', '*', '*N/D/C/B');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('1', 'VARCHAR2', '1020', 'LOOKUP_CODE', '11', '0', '0', 'LOOKUP_ATTRIBUTES', 'Y', '*'
            ,'*Ссылка на лукап - формау или простой');
/*  Form: LOOKUP_ATTRIBUTES. Entity: FORM_COLUMNS.  */

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('LOOKUP_ATTRIBUTES', 'ATTRIBUTE_CODE', '', '*', 'S', '1002', 'N', 'Y', '', '', '', '', '**ATTRIBUTE_CODE'
            ,'N', 'N', '', '', '', '1', '', '', '', '', '', 'L', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('LOOKUP_ATTRIBUTES', 'ATTRIBUTE_NAME', 'Name of the attribute', '*', 'S', '1003', 'N', 'Y', '', '', '', ''
            ,'*Name of the attribute', 'N', 'N', '', '', '', '2', '', '', '', '', '', 'L', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('LOOKUP_ATTRIBUTES', 'ATTRIBUTE_TYPE', '', '*', 'S', '1004', 'N', 'Y', '', '', '', '8', '**ATTRIBUTE_TYPE'
            ,'N', 'N', 'FORM_COLUMNS.DATA_TYPE', '', '', '3', '', '', '', '', '', 'L', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('LOOKUP_ATTRIBUTES', 'LOOKUP_CODE', 'Ссылка на лукап - формау или простой', '*', 'S', '1001', 'N', 'N', ''
            ,'', '', '', '*Ссылка на лукап - формау или простой', 'N', 'N', '', '', '', '3', '', '', '', ''
            ,':lookup_code', 'L', 'Y', '*', '', '');

Alter Table forms Enable VALIDATE Constraint forms_form_actions_fk;
Alter Table FORMS Enable All Triggers;
/*****************LOOKUP_VALUES*********************/
Alter Table FORMS Disable All Triggers;
Alter Table forms Disable Constraint forms_form_actions_fk;
Delete From FORM_COLUMNS
      Where form_code = 'LOOKUP_VALUES';
Delete From FORM_COLUMNS$
      Where form_code = 'LOOKUP_VALUES';
Delete From FORM_ACTIONS
      Where form_code = 'LOOKUP_VALUES';
Delete From FORM_TABS
      Where form_code = 'LOOKUP_VALUES';
Delete From FORMS
      Where form_code = 'LOOKUP_VALUES';
/*  Form: LOOKUP_VALUES. Entity: FORMS.  */

Insert Into FORMS
            ("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID"
            ,"FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR"
            ,"OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH", "DESCRIPTION", "DOUBLE_CLICK_ACTION_CODE", "LOOKUP_WIDTH"
            ,"APPS_CODE", "EXPORT_ORDER")
     Values ('LOOKUP_VALUES', '', 'SELECT * FROM &fc_schema_owner..lookup_values a where a.lookup_code=:lookup_code'
            ,'Детальная Значения списков', 'G', 'Y', '4', '*', '45%', '', '', 'Y', '40', '*', '', '', '', 'FC', '40');
/*  Form: LOOKUP_VALUES. Entity: FORM_TABS.  */

Insert Into FORM_TABS
            ("FORM_CODE", "TAB_CODE", "CHILD_FORM_CODE", "TAB_POSITION", "TAB_NAME", "NUMBER_OF_COLUMNS", "ICON_ID"
            ,"TAB_TYPE", "TAB_DISPLAY_NUMBER")
     Values ('LOOKUP_VALUES', 'LOOKUP_ATTRIBUTE_VALUES', 'LOOKUP_ATTRIBUTE_VALUES', 'B', '', '', '2', '2', '');
/*  Form: LOOKUP_VALUES. Entity: FORM_ACTIONS.  */

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('LOOKUP_VALUES', 'DEL', '&fc_schema_owner..LOOKUP_VALUES_PKG.P_DELETE', 'Удалить', '48', '', '', '3'
            ,'130', 'Вы уверенны что хотите удалить запись?', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('LOOKUP_VALUES', 'EDIT', '', 'Редактировать', '50', '', '', '8', '115', 'Вы уверенны?', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('LOOKUP_VALUES', 'FILTER', '', 'Фильтр', '45', '', '', '9', '199', '', 'Ctrl+Alt+Shift+F11', 'Y', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('LOOKUP_VALUES', 'GRID_EXPORT', '', 'Экспорт таблицы', '44', '', '', '12', '310', '', '', 'N', 'N', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('LOOKUP_VALUES', 'GRID_PRINT', '', 'Печать', '43', '', '', '14', '330', '', '', 'N', 'N', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('LOOKUP_VALUES', 'INS', '', 'Создать', '47', '', '', '1', '110', '', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('LOOKUP_VALUES', 'REFRESH', '', 'Обновить', '15', '', '', '4', '150', '', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('LOOKUP_VALUES', 'ROW_EXPORT', '', 'Экспорт записи', '44', '', '', '13', '320', '', '', 'N', 'N', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('LOOKUP_VALUES', 'UPD', '&fc_schema_owner..LOOKUP_VALUES_PKG.P_INS_UPD', 'Сохранить', '46', '', '', '2'
            ,'120', 'Вы уверенны?', '', 'N', 'Y', '');
/*  Form: LOOKUP_VALUES. Entity: FORM_COLUMNS$.  */

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('1', 'VARCHAR2', '1020', 'LOOKUP_CODE', '11', '0', '0', 'LOOKUP_VALUES', 'Y', '*'
            ,'*Ссылка на лукап - формау или простой');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('3', 'VARCHAR2', '1020', 'LOOKUP_DISPLAY_VALUE', '20', '0', '0', 'LOOKUP_VALUES', '', '*'
            ,'*Поле запроса, отображаемое пользователю - для длинных лукапов');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('2', 'VARCHAR2', '1020', 'LOOKUP_VALUE_CODE', '17', '0', '0', 'LOOKUP_VALUES', 'Y', '*'
            ,'**LOOKUP_VALUE_CODE');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('4', 'NUMBER', '22', 'LOOKUP_VALUE_ID', '15', '0', '-127', 'LOOKUP_VALUES', 'Y', '*', '**LOOKUP_VALUE_ID');
/*  Form: LOOKUP_VALUES. Entity: FORM_COLUMNS.  */

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('LOOKUP_VALUES', 'LOOKUP_CODE', 'Код списка', '*', 'S', '1001', 'Y', 'N', '', '', '', '9'
            ,'*Текстовый идентфикатор (ID)', 'N', 'N', '', '', '', '', '', '', '', '', ':lookup_code', '', 'Y', '*', ''
            ,'');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('LOOKUP_VALUES', 'LOOKUP_DISPLAY_VALUE', 'Значение', '*', 'S', '1003', 'N', 'Y', '', '', '', ''
            ,'**LOOKUP_DISPLAY_VALUE', 'N', 'N', '', '', '', '', '', '', '', '', '', '', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('LOOKUP_VALUES', 'LOOKUP_VALUE_CODE', 'Код', '20%', 'S', '1002', 'Y', 'Y', '', '', '', '9'
            ,'**LOOKUP_VALUE_CODE', 'N', 'N', '', '', '', '', '', '', '', '1', '', '', 'Y', '*', '', '');

Alter Table forms Enable VALIDATE Constraint forms_form_actions_fk;
Alter Table FORMS Enable All Triggers;
/*****************LOOKUPS*********************/
Alter Table FORMS Disable All Triggers;
Alter Table forms Disable Constraint forms_form_actions_fk;
Delete From FORM_COLUMNS
      Where form_code = 'LOOKUPS';
Delete From FORM_COLUMNS$
      Where form_code = 'LOOKUPS';
Delete From FORM_ACTIONS
      Where form_code = 'LOOKUPS';
Delete From FORM_TABS
      Where form_code = 'LOOKUPS';
Delete From FORMS
      Where form_code = 'LOOKUPS';
/*  Form: LOOKUPS. Entity: FORMS.  */

Insert Into FORMS
            ("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID"
            ,"FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR"
            ,"OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH", "DESCRIPTION", "DOUBLE_CLICK_ACTION_CODE", "LOOKUP_WIDTH"
            ,"APPS_CODE", "EXPORT_ORDER")
     Values ('LOOKUPS', '', 'SELECT * FROM &fc_schema_owner..lookups a
---',        'Списки', 'G', 'Y', '28', '30%', '*', 'L', '', 'N', '58', '120', '', 'DET_NEW_WND', '', 'FC', '50');
/*  Form: LOOKUPS. Entity: FORM_TABS.  */

Insert Into FORM_TABS
            ("FORM_CODE", "TAB_CODE", "CHILD_FORM_CODE", "TAB_POSITION", "TAB_NAME", "NUMBER_OF_COLUMNS", "ICON_ID"
            ,"TAB_TYPE", "TAB_DISPLAY_NUMBER")
     Values ('LOOKUPS', 'LOOKUPS_1', 'LOOKUP_VALUES', 'R', 'Значения', '', '39', '2', '1');

Insert Into FORM_TABS
            ("FORM_CODE", "TAB_CODE", "CHILD_FORM_CODE", "TAB_POSITION", "TAB_NAME", "NUMBER_OF_COLUMNS", "ICON_ID"
            ,"TAB_TYPE", "TAB_DISPLAY_NUMBER")
     Values ('LOOKUPS', 'LOOKUP_ATTRIBUTES', 'LOOKUP_ATTRIBUTES', 'R', 'Атрибуты', '', '', '2', '2');
/*  Form: LOOKUPS. Entity: FORM_ACTIONS.  */

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('LOOKUPS', 'DEL', '&fc_schema_owner..LOOKUPS_PKG.p_delete', 'Удалить', '48', '', '', '3', '130'
            ,'Вы уверенны что хотите удалить запись?', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('LOOKUPS', 'DET_NEW_TAB', '', 'Открыть :lookup_name', '103', '', '', '10', '150', '', '', 'N', 'N'
            ,'LOOKUP_VALUES');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('LOOKUPS', 'DET_NEW_WND', '', 'Открыть ":lookup_name" в окне', '103', '', '', '11', '170', '', '', 'Y'
            ,'N', 'LOOKUP_VALUES');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('LOOKUPS', 'EDIT', '', 'Редактировать', '50', '', '', '8', '115', '', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('LOOKUPS', 'INS', '', 'Создать', '47', '', '', '1', '110', '', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('LOOKUPS', 'NEXT', '', 'Вперед', '53', '', '', '6', '190', '', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('LOOKUPS', 'PREV', '', 'Назад', '54', '', '', '5', '180', '', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('LOOKUPS', 'REFRESH', '', 'Обновить', '55', '', '', '4', '10', '', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('LOOKUPS', 'UPD', '&fc_schema_owner..LOOKUPS_PKG.P_INS_UPD', 'Сохранить', '46', '', '', '2', '120'
            ,'Вы уверенны?', '', 'N', 'Y', '');
/*  Form: LOOKUPS. Entity: FORM_COLUMNS$.  */

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('1', 'VARCHAR2', '1020', 'LOOKUP_CODE', '11', '0', '0', 'LOOKUPS', '', '120'
            ,'*Ссылка на лукап - формау или простой');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('2', 'VARCHAR2', '1020', 'LOOKUP_NAME', '11', '0', '0', 'LOOKUPS', '', '120', '*Пользовательское имя');
/*  Form: LOOKUPS. Entity: FORM_COLUMNS.  */

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('LOOKUPS', 'LOOKUP_CODE', 'Код', '120', 'S', '1001', 'Y', 'Y', '', '', '', ''
            ,'*Текстовый идентфикатор (ID)', 'N', 'N', '', '', '', '', '', '', '', '1', '', 'L', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('LOOKUPS', 'LOOKUP_NAME', 'Наименование', '*', 'S', '1002', 'N', 'Y', '', '', '', ''
            ,'*Пользовательское имя', 'N', 'N', '', '', '', '', '', '', '', '', '', '', 'Y', '*', '', '');

Alter Table forms Enable VALIDATE Constraint forms_form_actions_fk;
Alter Table FORMS Enable All Triggers;
/*****************FORM_ACTIONS*********************/
Alter Table FORMS Disable All Triggers;
Alter Table forms Disable Constraint forms_form_actions_fk;
Delete From FORM_COLUMNS
      Where form_code = 'FORM_ACTIONS';
Delete From FORM_COLUMNS$
      Where form_code = 'FORM_ACTIONS';
Delete From FORM_ACTIONS
      Where form_code = 'FORM_ACTIONS';
Delete From FORM_TABS
      Where form_code = 'FORM_ACTIONS';
Delete From FORMS
      Where form_code = 'FORM_ACTIONS';
/*  Form: FORM_ACTIONS. Entity: FORMS.  */

Insert Into FORMS
            ("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID"
            ,"FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR"
            ,"OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH", "DESCRIPTION", "DOUBLE_CLICK_ACTION_CODE", "LOOKUP_WIDTH"
            ,"APPS_CODE", "EXPORT_ORDER")
     Values ('FORM_ACTIONS', ''
            ,'SELECT *
  FROM &fc_schema_owner..form_actions a
 Where DECODE (:p_$master_form_code, ''FORMS'', :form_code, ''FORMS2'', :form_code_for_filter,''MENUS'',:form_code_for_filter, a.form_code) = a.form_code
--'
            ,'Детальная Действия', 'G', 'Y', '4', '*', '*', '', '', 'Y', '54', '*', '', '', '', 'FC', '60');
/*  Form: FORM_ACTIONS. Entity: FORM_TABS.  */
/*  Form: FORM_ACTIONS. Entity: FORM_ACTIONS.  */

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('FORM_ACTIONS', 'DEL', '&fc_schema_owner..FORM_ACTIONS_PKG.p_delete', 'Удалить', '48', '', '', '3', '130'
            ,'Вы уверенны что хотите удалить запись?', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('FORM_ACTIONS', 'EDIT', '', 'Редактировать', '50', '', '', '8', '115', 'Вы уверенны?', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('FORM_ACTIONS', 'INS', '', 'Создать', '47', '', '', '1', '110', '', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('FORM_ACTIONS', 'REFR', '', 'Обновить', '15', '', '', '4', '10', '', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('FORM_ACTIONS', 'UPD', '&fc_schema_owner..FORM_ACTIONS_PKG.p_ins_upd', 'Сохранить', '46', '', '', '2'
            ,'120', 'Вы уверенны?', '', 'N', 'Y', '');
/*  Form: FORM_ACTIONS. Entity: FORM_COLUMNS$.  */

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('2', 'VARCHAR2', '1020', 'ACTION_CODE', '11', '0', '0', 'FORM_ACTIONS', 'Y', '*', '**ACTION_CODE');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('4', 'VARCHAR2', '1020', 'ACTION_DISPLAY_NAME', '19', '0', '0', 'FORM_ACTIONS', '', '*'
            ,'**ACTION_DISPLAY_NAME');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('8', 'VARCHAR2', '8', 'ACTION_TYPE', '11', '0', '0', 'FORM_ACTIONS', '', '*', '**ACTION_TYPE');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('14', 'VARCHAR2', '1020', 'CHILD_FORM_CODE', '15', '0', '0', 'FORM_ACTIONS', '', '*'
            ,'*Вызов дочерней формы в новом табе/окне');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('10', 'VARCHAR2', '4000', 'CONFIRM_TEXT', '12', '0', '0', 'FORM_ACTIONS', '', '*', '**CONFIRM_TEXT');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('7', 'VARCHAR2', '1020', 'DEFAULT_OLD_PARAM_PREFIX', '24', '0', '0', 'FORM_ACTIONS', '', '*'
            ,'**DEFAULT_OLD_PARAM_PREFIX');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('6', 'VARCHAR2', '1020', 'DEFAULT_PARAM_PREFIX', '20', '0', '0', 'FORM_ACTIONS', '', '*'
            ,'**DEFAULT_PARAM_PREFIX');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('9', 'NUMBER', '22', 'DISPLAY_NUMBER', '14', '0', '-127', 'FORM_ACTIONS', '', '*', '**DISPLAY_NUMBER');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('13', 'VARCHAR2', '4', 'DISPLAY_ON_TOOLBAR', '18', '0', '0', 'FORM_ACTIONS', '', '*'
            ,'**DISPLAY_ON_TOOLBAR');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('1', 'VARCHAR2', '1020', 'FORM_CODE', '9', '0', '0', 'FORM_ACTIONS', 'Y', '*', '*Идентификатор форм');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('11', 'VARCHAR2', '1020', 'HOT_KEY', '7', '0', '0', 'FORM_ACTIONS', '', '*'
            ,'*Горячая клавиша  - строка вида [Ctrl+][Alt+][Shift+]Chr. Регистр не важен');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('5', 'NUMBER', '22', 'ICON_ID', '7', '0', '-127', 'FORM_ACTIONS', '', '*', '**ICON_ID');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('3', 'VARCHAR2', '1020', 'PROCEDURE_NAME', '14', '0', '0', 'FORM_ACTIONS', '', '*'
            ,'*Name of the procedure');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('12', 'VARCHAR2', '4', 'SHOW_SEPARATOR_BELOW', '20', '0', '0', 'FORM_ACTIONS', '', '*'
            ,'**SHOW_SEPARATOR_BELOW');
/*  Form: FORM_ACTIONS. Entity: FORM_COLUMNS.  */

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_ACTIONS', 'ACTION_CODE', 'Код действия', '*', 'S', '1002', 'Y', 'Y', '', '', '', '', '**ACTION_CODE'
            ,'N', 'N', '', '', '', '', '', '', '', '', '', '', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_ACTIONS', 'ACTION_DISPLAY_NAME', 'Наименование', '*', 'S', '1004', 'N', 'Y', '', '', '', ''
            ,'**ACTION_DISPLAY_NAME', 'N', 'N', '', '', '', '', '', '', '', '', '', '', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_ACTIONS', 'ACTION_TYPE', 'Тип действия', '*', 'S', '1008', 'N', 'Y', '', '', '', '8'
            ,'**ACTION_TYPE', 'N', 'N', 'FORM_ACTIONS.ACTION_TYPE', '', '', '', '', '', '', '', '', '', 'Y', '*', ''
            ,'');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_ACTIONS', 'CHILD_FORM_CODE', 'Дочерняя форма', '*', 'S', '1014', 'N', 'Y', '', '', '', '9'
            ,'*Вызов дочерней формы в новом табе/окне', 'N', 'N', 'FORMS_LIST', '', '', '', '', '', '', '', '', 'L'
            ,'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_ACTIONS', 'CONFIRM_TEXT', 'Текст подтверждения', '*', 'S', '1010', 'N', 'Y', '', '', '', ''
            ,'**CONFIRM_TEXT', 'N', 'N', '', '', '', '', '', '', '', '', '', '', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_ACTIONS', 'DEFAULT_OLD_PARAM_PREFIX', 'Старый префикс по умолчанию', '*', 'S', '1007', 'N', 'Y', ''
            ,'', '', '', '**DEFAULT_OLD_PARAM_PREFIX', 'N', 'N', '', '', '', '', '', '', '', '', '', '', 'Y', '*', ''
            ,'');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_ACTIONS', 'DEFAULT_PARAM_PREFIX', 'Префикс по умолчанию', '*', 'S', '1006', 'N', 'Y', '', '', '', ''
            ,'**DEFAULT_PARAM_PREFIX', 'N', 'N', '', '', '', '', '', '', '', '', '', '', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_ACTIONS', 'DISPLAY_NUMBER', 'Порядок', '*', 'N', '10', 'N', 'Y', '', '', '', '', '**DISPLAY_NUMBER'
            ,'N', 'N', '', '', '', '', '', '', '', '1', '', 'L', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_ACTIONS', 'DISPLAY_ON_TOOLBAR', '', '*', 'B', '1013', 'N', 'Y', '', '', '', ''
            ,'**DISPLAY_ON_TOOLBAR', 'N', 'N', '', '', '', '', '', '', '', '', '', 'L', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_ACTIONS', 'FORM_CODE', 'Код формы', '*', 'S', '1001', 'Y', 'N', '', '', '', ''
            ,'*Идентификатор форм', 'N', 'N', '', '', '', '', '', '', '', '', ':form_code_for_filter', '', 'Y', '*', ''
            ,'');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_ACTIONS', 'ICON_ID', 'Иконка', '*', 'N', '1005', 'N', 'Y', '', '', '', '9', '**ICON_ID', 'N', 'N'
            ,'ICONS', '', '', '', '', '', '', '', '', '', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_ACTIONS', 'PROCEDURE_NAME', 'PL/SQL Процедура', '*', 'S', '1003', 'N', 'Y', '', '', '', ''
            ,'*Name of the package or type subprogram', 'N', 'N', '', '', '', '', '', '', '', '', '', '', 'Y', '*', ''
            ,'');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_ACTIONS', 'SHOW_SEPARATOR_BELOW', '', '*', 'B', '1012', 'N', 'Y', '', '', '', ''
            ,'**SHOW_SEPARATOR_BELOW', 'N', 'N', '', '', '', '', '', '', '', '', '', 'L', 'Y', '*', '', '');

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>Код действия.</b></font></span><div>Описание настройки.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_ACTIONS'
      And column_code = 'ACTION_CODE';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>Наименование.</b></font></span><div>Описание настройки.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_ACTIONS'
      And column_code = 'ACTION_DISPLAY_NAME';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>Тип действия.</b></font></span><div>Описание настройки.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_ACTIONS'
      And column_code = 'ACTION_TYPE';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>Дочерняя форма.</b></font></span><div>Описание настройки.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_ACTIONS'
      And column_code = 'CHILD_FORM_CODE';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>Текст подтверждения.</b></font></span><div>Описание настройки.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_ACTIONS'
      And column_code = 'CONFIRM_TEXT';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>Старый префикс по умолчанию.</b></font></span><div>Описание настройки.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_ACTIONS'
      And column_code = 'DEFAULT_OLD_PARAM_PREFIX';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>Префикс по умолчанию.</b></font></span><div>Описание настройки.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_ACTIONS'
      And column_code = 'DEFAULT_PARAM_PREFIX';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>Порядок.</b></font></span><div>Описание настройки.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_ACTIONS'
      And column_code = 'DISPLAY_NUMBER';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>DISPLAY_ON_TOOLBAR.</b></font></span><div>Описание настройки.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_ACTIONS'
      And column_code = 'DISPLAY_ON_TOOLBAR';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>Иконка.</b></font></span><div>Описание настройки.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_ACTIONS'
      And column_code = 'ICON_ID';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>PL/SQL Процедура.</b></font></span><div>Описание настройки.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_ACTIONS'
      And column_code = 'PROCEDURE_NAME';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>SHOW_SEPARATOR_BELOW.</b></font></span><div>Описание настройки.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_ACTIONS'
      And column_code = 'SHOW_SEPARATOR_BELOW';
End;
/

Alter Table forms Enable VALIDATE Constraint forms_form_actions_fk;
Alter Table FORMS Enable All Triggers;
/*****************FORMS*********************/
Alter Table FORMS Disable All Triggers;
Alter Table forms Disable Constraint forms_form_actions_fk;
Delete From FORM_COLUMNS
      Where form_code = 'FORMS';
Delete From FORM_COLUMNS$
      Where form_code = 'FORMS';
Delete From FORM_ACTIONS
      Where form_code = 'FORMS';
Delete From FORM_TABS
      Where form_code = 'FORMS';
Delete From FORMS
      Where form_code = 'FORMS';
/*  Form: FORMS. Entity: FORMS.  */

Insert Into FORMS
            ("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID"
            ,"FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR"
            ,"OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH", "DESCRIPTION", "DOUBLE_CLICK_ACTION_CODE", "LOOKUP_WIDTH"
            ,"APPS_CODE", "EXPORT_ORDER")
     Values ('FORMS', 'Ctrl+Shift+q'
            ,'Select a.*, &fc_schema_owner..form_utils.get_inserts (a.form_code) form_dml
      ,&fc_schema_owner..form_utils.get_form_pkg_clob (a.form_code) As gen_pkg
  From &fc_schema_owner..forms a
 Where DECODE (:p_$master_form_code, ''FORMS2'', :form_code_for_filter, ''MENUS'', :form_code_for_filter, a.form_code) =
                                                                                                             a.form_code
-----
'
            ,'Детальная Свойства формы', 'G', 'Y', '4', '0%', '*', 'B', 'B', 'N', '162', '*', '', '', '', 'FC', '70');
/*  Form: FORMS. Entity: FORM_TABS.  */

Insert Into FORM_TABS
            ("FORM_CODE", "TAB_CODE", "CHILD_FORM_CODE", "TAB_POSITION", "TAB_NAME", "NUMBER_OF_COLUMNS", "ICON_ID"
            ,"TAB_TYPE", "TAB_DISPLAY_NUMBER")
     Values ('FORMS', 'DML', '', 'R', 'DML', '', '17', '1', '30');

Insert Into FORM_TABS
            ("FORM_CODE", "TAB_CODE", "CHILD_FORM_CODE", "TAB_POSITION", "TAB_NAME", "NUMBER_OF_COLUMNS", "ICON_ID"
            ,"TAB_TYPE", "TAB_DISPLAY_NUMBER")
     Values ('FORMS', 'PKG', '', 'R', 'PKG', '', '29', '1', '40');

Insert Into FORM_TABS
            ("FORM_CODE", "TAB_CODE", "CHILD_FORM_CODE", "TAB_POSITION", "TAB_NAME", "NUMBER_OF_COLUMNS", "ICON_ID"
            ,"TAB_TYPE", "TAB_DISPLAY_NUMBER")
     Values ('FORMS', 'SQL', '', 'R', 'Основные', '4', '50', '1', '10');

Insert Into FORM_TABS
            ("FORM_CODE", "TAB_CODE", "CHILD_FORM_CODE", "TAB_POSITION", "TAB_NAME", "NUMBER_OF_COLUMNS", "ICON_ID"
            ,"TAB_TYPE", "TAB_DISPLAY_NUMBER")
     Values ('FORMS', 'SQL_TEXT', '', 'R', 'Запрос', '', '23', '1', '20');
/*  Form: FORMS. Entity: FORM_ACTIONS.  */

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('FORMS', 'NEXT', '', 'Вперед', '53', '', '', '6', '40', '', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('FORMS', 'PREV', '', 'Назад', '54', '', '', '5', '30', '', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('FORMS', 'REFRESH', '', 'Обновить', '55', '', '', '4', '10', '', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('FORMS', 'UPD', '&fc_schema_owner..FORMS_PKG.P_INSERT_UPDATE', 'Сохранить', '46', '', '', '2', '120'
            ,'Вы уверенны?', '', 'N', 'Y', '');
/*  Form: FORMS. Entity: FORM_COLUMNS$.  */

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('18', 'VARCHAR2', '1020', 'APPS_CODE', '9', '0', '0', 'FORMS', '', '*'
            ,'*Код приложения. Пока только для облегчения скриптов генерации');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('10', 'VARCHAR2', '8', 'BOTTOM_TABS_ORIENTATION', '23', '0', '0', 'FORMS', '', '*'
            ,'*ориентация нижних табиков детализации. см. FORMS.TABS_ORIENTATION');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('14', 'VARCHAR2', '120', 'DEFAULT_COLUMN_WIDTH', '20', '0', '0', 'FORMS', '', '*'
            ,'*Ширина полей по умолчанию');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('15', 'CLOB', '4000', 'DESCRIPTION', '11', '0', '0', 'FORMS', '', '*', '*Description of the subscription');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('16', 'VARCHAR2', '1020', 'DOUBLE_CLICK_ACTION_CODE', '24', '0', '0', 'FORMS', '', '*'
            ,'*Действие по двойному щелчку на записи. По умолчанию - редактирование');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('1', 'VARCHAR2', '1020', 'FORM_CODE', '9', '0', '0', 'FORMS', 'Y', '*', '*Идентификатор форм');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('19', 'CLOB', '4000', 'FORM_DML', '8', '0', '0', 'FORMS', '', '*', '**FORM_DML');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('9', 'VARCHAR2', '120', 'FORM_HEIGHT', '11', '0', '0', 'FORMS', '', '*'
            ,'*высота в пикселях или процентах. * - авто');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('4', 'VARCHAR2', '1020', 'FORM_NAME', '9', '0', '0', 'FORMS', '', '*', '*Имя формы для пользователя');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('5', 'VARCHAR2', '4', 'FORM_TYPE', '9', '0', '0', 'FORMS', '', '*', '*Тип показываемой формы');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('8', 'VARCHAR2', '120', 'FORM_WIDTH', '10', '0', '0', 'FORMS', '', '*'
            ,'*ширина в пикселях или процентах. * - авто');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('20', 'CLOB', '4000', 'GEN_PKG', '7', '0', '0', 'FORMS', '', '*', '**GEN_PKG');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('2', 'VARCHAR2', '400', 'HOT_KEY', '7', '0', '0', 'FORMS', '', '*'
            ,'*Горячая клавиша  - строка вида [Ctrl+][Alt+][Shift+]Chr. Регистр не важен');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('7', 'NUMBER', '22', 'ICON_ID', '7', '0', '-127', 'FORMS', '', '*', '**ICON_ID');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('17', 'NUMBER', '22', 'LOOKUP_WIDTH', '12', '0', '-127', 'FORMS', '', '*'
            ,'*Ширина лукапа (если форма выступает в роли лукапа)');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('13', 'NUMBER', '22', 'OBJECT_VERSION_NUMBER', '21', '0', '-127', 'FORMS', '', '*'
            ,'**OBJECT_VERSION_NUMBER');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('12', 'VARCHAR2', '4', 'SHOW_BOTTOM_TOOLBAR', '19', '0', '0', 'FORMS', '', '*'
            ,'*Показывать нижний тулбар?');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('6', 'VARCHAR2', '4', 'SHOW_TREE_ROOT_NODE', '19', '0', '0', 'FORMS', '', '*'
            ,'*Показывать ли корневой узел для дерева?');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('11', 'VARCHAR2', '8', 'SIDE_TABS_ORIENTATION', '21', '0', '0', 'FORMS', '', '*'
            ,'*ориентация боковых табиков детализации. см. FORMS.TABS_ORIENTATION');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('3', 'VARCHAR2', '4000', 'SQL_TEXT', '8', '0', '0', 'FORMS', '', '*'
            ,'*Order by во внешнем запросе не используйте, иначе при сортировке лететь будет..');
/*  Form: FORMS. Entity: FORM_COLUMNS.  */

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORMS', 'APPS_CODE', 'Код приложения', '*', 'S', '1018', 'N', 'N', '', '', 'SQL', ''
            ,'Код приложения. Пока только для облегчения скриптов генерации', 'N', 'N', '', '', '', '', '', '', '', ''
            ,'', 'L', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORMS', 'BOTTOM_TABS_ORIENTATION', 'ориентация нижних табиков', '*', 'S', '1011', 'N', 'N', '', '', 'SQL'
            ,'10', 'Ориентация нижних табиков детализации. см. FORMS.TABS_ORIENTATION', 'N', 'N'
            ,'FORMS.TABS_ORIENTATION', '', '', '', '', '', '', '', '', 'L', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORMS', 'DEFAULT_COLUMN_WIDTH', 'Ширина полей по умолчанию', '*', 'S', '1015', 'N', 'N', '', '', 'SQL'
            ,'', '*Ширина полей по умолчанию', 'N', 'N', '', '', '', '', '', '', '', '', '', '', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORMS', 'DESCRIPTION', 'Описание', '*', 'S', '5', 'N', 'N', '', '', 'SQL_TEXT', '5', 'Описание', 'N', 'N'
            ,'', '', '200', '', '', '', '', '', '', 'T', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORMS', 'DOUBLE_CLICK_ACTION_CODE', 'Действие по двойному щелчку', '*', 'S', '1020', 'N', 'N', '', ''
            ,'SQL', '9', '*Действие по двойному щелчку на записи. По умолчанию - редактирование', 'N', 'N'
            ,'DBLCLICK_FORM_ACT_LIST', '', '', '', '', '', '', '', '', 'L', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORMS', 'FORM_CODE', 'Код формы', '25%', 'S', '3', 'Y', 'N', '', '1', 'SQL', '', 'Идентификатор формы'
            ,'N', 'N', '', '', '', '1', '', '', '', '', '', 'L', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORMS', 'FORM_DML', '', '*', 'S', '1016', 'N', 'N', '', '', 'DML', '4', '**FORM_DML', 'N', 'N', '', ''
            ,'500', '', '', '', '', '', '', 'T', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORMS', 'FORM_HEIGHT', 'Высота формы', '*', 'S', '1010', 'N', 'N', '', '', 'SQL', ''
            ,'Высота в пикселях или процентах. * - авто', 'N', 'N', '', '', '', '', '', '', '', '', '', 'L', 'Y', '*'
            ,'', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORMS', 'FORM_NAME', 'Пользовательское имя формы', '40%', 'S', '2', 'N', 'N', '', '', 'SQL', ''
            ,'Имя формы для пользователя', 'N', 'N', '', '', '', '', '', '', '', '', '', 'L', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORMS', 'FORM_TYPE', 'Тип формы', '*', 'S', '1006', 'N', 'N', '', '', 'SQL', '8'
            ,'Тип показываемой формы', 'N', 'N', 'FORMS.FORM_TYPE', '', '', '', '', '', '', '', '', 'L', 'Y', '*', ''
            ,'');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORMS', 'FORM_WIDTH', 'Ширина формы', '*', 'S', '1009', 'N', 'N', '', '', 'SQL', ''
            ,'Ширина в пикселях или процентах. * - авто', 'N', 'N', '', '', '', '', '', '', '', '', '', 'L', 'Y', '*'
            ,'', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORMS', 'GEN_PKG', '', '*', 'S', '1019', 'N', 'N', '', '', 'PKG', '4', '**GEN_PKG', 'N', 'N', '', ''
            ,'500', '', '', '', '', '', '', 'T', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORMS', 'HOT_KEY', 'Горячая клавиша', '*', 'S', '8', 'N', 'N', '', '', 'SQL', ''
            ,'Горячая клавиша  - строка вида [Ctrl+][Alt+][Shift+]Chr. Регистр не важен', 'N', 'N', '', '', '', '', ''
            ,'', '', '', '', 'L', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORMS', 'ICON_ID', 'Иконка', '*', 'S', '1008', 'N', 'N', '', '', 'SQL', '9', 'Иконка', 'N', 'N', 'ICONS'
            ,'', '', '', '', '', '', '', '', 'L', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORMS', 'LOOKUP_WIDTH', 'Ширина лукапа', '*', 'N', '1017', 'N', 'Y', '', '', 'SQL', ''
            ,'*Ширина лукапа (если форма выступает в роли лукапа)', 'N', 'N', '', '', '', '', '', '', '', '', '', 'L'
            ,'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORMS', 'OBJECT_VERSION_NUMBER', '', '*', 'N', '1014', 'N', 'N', '', '', '', ''
            ,'**OBJECT_VERSION_NUMBER', 'N', 'N', '', '', '', '', '', '', '', '', '', 'L', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORMS', 'SHOW_BOTTOM_TOOLBAR', 'Показывать нижний тулбар', '*', 'B', '1013', 'N', 'N', '', '', 'SQL', ''
            ,'*Показывать нижний тулбар?', 'N', 'N', '', '', '', '', '', '', '', '', '', '', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORMS', 'SHOW_TREE_ROOT_NODE', 'Показывать ли корневой узел для дерева?', '*', 'B', '1007', 'N', 'N', ''
            ,'', 'SQL', '', 'Показывать ли корневой узел для дерева?', 'N', 'N', '', '', '', '', '', '', '', '', ''
            ,'L', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORMS', 'SIDE_TABS_ORIENTATION', 'ориентация боковых табиков', '*', 'S', '1012', 'N', 'N', '', '', 'SQL'
            ,'10', '*ориентация боковых табиков детализации. см. FORMS.TABS_ORIENTATION', 'N', 'N'
            ,'FORMS.TABS_ORIENTATION', '', '', '', '', '', '', '', '', 'L', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORMS', 'SQL_TEXT', 'Текст запроса', '4000', 'S', '6', 'N', 'N', '', '', 'SQL_TEXT', '4'
            ,'*Order by во внешнем запросе не используйте, иначе при сортировке лететь будет..', 'N', 'N', '', ''
            ,'200', '', '', '', '', '', '', 'T', 'Y', '*', '', '');

Declare
   l_clob   Clob := 'zxrtyr';
Begin
   Update FORMS
      Set description = l_clob
    Where form_code = 'FORMS';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>ориентация нижних табиков.</b></font></span><div>Ориентация нижних табиков детализации - см. FORMS.TABS_ORIENTATION.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORMS'
      And column_code = 'BOTTOM_TABS_ORIENTATION';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>Ширина полей по умолчанию.</b></font></span><div>Описание настройки.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORMS'
      And column_code = 'DEFAULT_COLUMN_WIDTH';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>Описание.</b></font></span><div>Описание формы - всплывающая подсказка в меню.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORMS'
      And column_code = 'DESCRIPTION';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>Действие по двойному щелчку.</b></font></span><div>Описание настройки.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORMS'
      And column_code = 'DOUBLE_CLICK_ACTION_CODE';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>Код формы.</b></font></span><div>Внутренний&nbsp;идентификатор&nbsp;формы. Первичный ключ для дочерних форм (полей формы, вкладок, действий).</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORMS'
      And column_code = 'FORM_CODE';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>FORM_DML.</b></font></span><div>Описание настройки.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORMS'
      And column_code = 'FORM_DML';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>Высота формы.</b></font></span><div>Высота в пикселях или процентах. "*" - авто.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORMS'
      And column_code = 'FORM_HEIGHT';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>Пользовательское имя формы.</b></font></span><div>Имя формы, отображаемое во вкладках, в т.ч. динамических формах детализации, меню, при отсутствии явного переопределения в этих сущностях.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORMS'
      And column_code = 'FORM_NAME';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>Тип формы.</b></font></span><div>Тип формы: грид (табличный вид), дерево. В перспективе - матричная форма, диаграмма.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORMS'
      And column_code = 'FORM_TYPE';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>Ширина формы.</b></font></span><div>Ширина в пикселях или процентах. "*" - авто.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORMS'
      And column_code = 'FORM_WIDTH';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>Горячая клавиша.</b></font></span><div>Комбинация клавиш для вызова формы - строка вида [Ctrl+][Alt+][Shift+]Chr. Регистр не важен.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORMS'
      And column_code = 'HOT_KEY';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>Иконка.</b></font></span><div>Иконка, отображаемая в меню и вкладках.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORMS'
      And column_code = 'ICON_ID';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>Ширина лукапа.</b></font></span><div>Описание настройки.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORMS'
      And column_code = 'LOOKUP_WIDTH';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>OBJECT_VERSION_NUMBER.</b></font></span><div>Описание настройки.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORMS'
      And column_code = 'OBJECT_VERSION_NUMBER';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>Показывать нижний тулбар.</b></font></span><div>Описание настройки.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORMS'
      And column_code = 'SHOW_BOTTOM_TOOLBAR';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>Показывать ли корневой узел для дерева?.</b></font></span><div>Описание настройки.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORMS'
      And column_code = 'SHOW_TREE_ROOT_NODE';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>ориентация боковых табиков.</b></font></span><div>Описание настройки.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORMS'
      And column_code = 'SIDE_TABS_ORIENTATION';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>Текст запроса.</b></font></span><div>Текас SQL-запроса. На основании разбора данного запроса формируются данные формы "Колонки" (таблица FORM_COLUMNS).</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORMS'
      And column_code = 'SQL_TEXT';
End;
/

Alter Table forms Enable VALIDATE Constraint forms_form_actions_fk;
Alter Table FORMS Enable All Triggers;
/*****************FORM_COLUMNS*********************/
Alter Table FORMS Disable All Triggers;
Alter Table forms Disable Constraint forms_form_actions_fk;
Delete From FORM_COLUMNS
      Where form_code = 'FORM_COLUMNS';
Delete From FORM_COLUMNS$
      Where form_code = 'FORM_COLUMNS';
Delete From FORM_ACTIONS
      Where form_code = 'FORM_COLUMNS';
Delete From FORM_TABS
      Where form_code = 'FORM_COLUMNS';
Delete From FORMS
      Where form_code = 'FORM_COLUMNS';
/*  Form: FORM_COLUMNS. Entity: FORMS.  */

Insert Into FORMS
            ("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID"
            ,"FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR"
            ,"OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH", "DESCRIPTION", "DOUBLE_CLICK_ACTION_CODE", "LOOKUP_WIDTH"
            ,"APPS_CODE", "EXPORT_ORDER")
     Values ('FORM_COLUMNS', ''
            ,'SELECT   t.*, NVL ( (SELECT   NVL (f.form_name, form_code)
                       FROM   &fc_schema_owner..forms f
                      WHERE   f.form_code = t.lookup_code AND t.field_type IN (''9'', ''11'')),
              (SELECT   l.lookup_name
                 FROM   &fc_schema_owner..lookups l
                WHERE   t.lookup_code = l.lookup_code AND t.field_type IN (''8'', ''10'')))
                 lookup_name
  FROM   Table (&fc_schema_owner..form_utils.describe_form_columns_pl (DECODE (
                                                        :p_$master_form_code,
                                                        ''FORMS2'', :form_code_for_filter,
                                                        ''MENUS'', :form_code_for_filter,
                                                        :form_code
                                                     ))) t
/*************/'
            ,'Детальная Колонки', 'G', 'Y', '4', '35%', '*', '', 'B', 'Y', '338', '*', '', '', '', 'FC', '70');
/*  Form: FORM_COLUMNS. Entity: FORM_TABS.  */

Insert Into FORM_TABS
            ("FORM_CODE", "TAB_CODE", "CHILD_FORM_CODE", "TAB_POSITION", "TAB_NAME", "NUMBER_OF_COLUMNS", "ICON_ID"
            ,"TAB_TYPE", "TAB_DISPLAY_NUMBER")
     Values ('FORM_COLUMNS', 'ADD', 'LOOKUPS', 'R', 'Дополнительные', '4', '28', '1', '2');

Insert Into FORM_TABS
            ("FORM_CODE", "TAB_CODE", "CHILD_FORM_CODE", "TAB_POSITION", "TAB_NAME", "NUMBER_OF_COLUMNS", "ICON_ID"
            ,"TAB_TYPE", "TAB_DISPLAY_NUMBER")
     Values ('FORM_COLUMNS', 'COL_ATTRS', 'FORM_COLUMN_ATTR_VALS', 'R', 'Атрибуты', '', '12', '2', '');

Insert Into FORM_TABS
            ("FORM_CODE", "TAB_CODE", "CHILD_FORM_CODE", "TAB_POSITION", "TAB_NAME", "NUMBER_OF_COLUMNS", "ICON_ID"
            ,"TAB_TYPE", "TAB_DISPLAY_NUMBER")
     Values ('FORM_COLUMNS', 'HELP', '', '', 'Помощь', '6', '43', '1', '3');

Insert Into FORM_TABS
            ("FORM_CODE", "TAB_CODE", "CHILD_FORM_CODE", "TAB_POSITION", "TAB_NAME", "NUMBER_OF_COLUMNS", "ICON_ID"
            ,"TAB_TYPE", "TAB_DISPLAY_NUMBER")
     Values ('FORM_COLUMNS', 'MAIN', '', 'R', 'Основные', '6', '20', '1', '1');
/*  Form: FORM_COLUMNS. Entity: FORM_ACTIONS.  */

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('FORM_COLUMNS', 'DEL', '&fc_schema_owner..FORM_COLUMNS_PKG.P_DELETE', 'Удалить', '48', '', '', '3', '130'
            ,'Вы уверенны что хотите удалить запись?', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('FORM_COLUMNS', 'EDIT', '', 'Редактировать', '50', '', '', '8', '115', 'Вы уверенны?', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('FORM_COLUMNS', 'INS', '', 'Создать', '47', '', '', '1', '110', '', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('FORM_COLUMNS', 'UPD', '&fc_schema_owner..FORM_COLUMNS_PKG.P_INS_UPD', 'Сохранить', '46', '', '', '2'
            ,'120', 'Вы уверенны?', '', 'N', 'Y', '');
/*  Form: FORM_COLUMNS. Entity: FORM_COLUMNS$.  */

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('3', 'VARCHAR2', '1020', 'COLUMN_CODE', '11', '0', '0', 'FORM_COLUMNS', 'Y', '*'
            ,'*Идентификатор поля (из запроса)');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('4', 'VARCHAR2', '1020', 'COLUMN_DATA_TYPE', '16', '0', '0', 'FORM_COLUMNS', '', '*'
            ,'*Тип данных (FORM_COLUMNS.DATA_TYPE)');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('13', 'VARCHAR2', '8000', 'COLUMN_DESCRIPTION', '18', '0', '0', 'FORM_COLUMNS', '', '*'
            ,'*Описание поля (подсказка для пользователя)');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('1', 'NUMBER', '22', 'COLUMN_DISPLAY_NUMBER', '21', '0', '0', 'FORM_COLUMNS', '', '*'
            ,'*Порядковый номер отображения в таблице');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('6', 'VARCHAR2', '1020', 'COLUMN_DISPLAY_SIZE', '19', '0', '0', 'FORM_COLUMNS', '', '*'
            ,'*Ширина поля в писькелях');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('5', 'VARCHAR2', '1020', 'COLUMN_USER_NAME', '16', '0', '0', 'FORM_COLUMNS', '', '*'
            ,'*Пользовательское имя поля');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('25', 'VARCHAR2', '40', 'DEFAULT_ORDERBY_NUMBER', '22', '0', '0', 'FORM_COLUMNS', '', '*'
            ,'*Порядок сортировки при открытии формы. "-" после цифры - сортировка по убыванию');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('26', 'VARCHAR2', '1020', 'DEFAULT_VALUE', '13', '0', '0', 'FORM_COLUMNS', '', '*'
            ,'*Default value for the argument');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('28', 'VARCHAR2', '40', 'EDITOR_COLS_SPAN', '16', '0', '0', 'FORM_COLUMNS', '', '*'
            ,'*Редактор - количество колонок, занимаемых полем (item.setColSpan)');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('29', 'VARCHAR2', '4', 'EDITOR_END_ROW_FLAG', '19', '0', '0', 'FORM_COLUMNS', '', '*', '*item.setEndRow');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('20', 'VARCHAR2', '1020', 'EDITOR_HEIGHT', '13', '0', '0', 'FORM_COLUMNS', '', '*'
            ,'*Высота поля в закладке редактирования');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('31', 'VARCHAR2', '1020', 'EDITOR_ON_ENTER_KEY_ACTION', '26', '0', '0', 'FORM_COLUMNS', '', '*'
            ,'*Действие по нажатию Enter');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('11', 'VARCHAR2', '1020', 'EDITOR_TAB_CODE', '15', '0', '0', 'FORM_COLUMNS', '', '*'
            ,'*Ссылка на закладку формы редактирования. Если не указано - показывается только в гриде');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('27', 'VARCHAR2', '4', 'EDITOR_TITLE_ORIENTATION', '24', '0', '0', 'FORM_COLUMNS', '', '*'
            ,'*item.setTitleOrientation');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('16', 'VARCHAR2', '4', 'EXISTS_IN_METADATA_FLAG', '23', '0', '0', 'FORM_COLUMNS', '', '*'
            ,'**EXISTS_IN_METADATA_FLAG');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('17', 'VARCHAR2', '4', 'EXISTS_IN_QUERY_FLAG', '20', '0', '0', 'FORM_COLUMNS', '', '*'
            ,'**EXISTS_IN_QUERY_FLAG');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('12', 'VARCHAR2', '8', 'FIELD_TYPE', '10', '0', '0', 'FORM_COLUMNS', '', '*'
            ,'*Тип поля, общий для дерева и грида');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('2', 'VARCHAR2', '1020', 'FORM_CODE', '9', '0', '0', 'FORM_COLUMNS', 'Y', '*', '*Идентификатор форм');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('22', 'CLOB', '32767', 'HELP_TEXT', '9', '0', '0', 'FORM_COLUMNS', '', '*'
            ,'*HTML текст для подсказки в интерфейсе');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('19', 'VARCHAR2', '1020', 'HOVER_COLUMN_CODE', '17', '0', '0', 'FORM_COLUMNS', '', '*'
            ,'*Поле той же формы, которое содержит подсказку. Если SHOW_HOVER_FLAG = ''Y'' и HOVER_COLUMN_CODE - подсказка берется из текущего поля (COLUMN_CODE)');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('14', 'VARCHAR2', '4', 'IS_FROZEN_FLAG', '14', '0', '0', 'FORM_COLUMNS', '', '*', '*Замораживать поле?');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('18', 'VARCHAR2', '1020', 'LOOKUP_CODE', '11', '0', '0', 'FORM_COLUMNS', '', '*'
            ,'*Ссылка на лукап - формау или простой');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('30', 'VARCHAR2', '1020', 'LOOKUP_DISPLAY_VALUE', '20', '0', '0', 'FORM_COLUMNS', '', '*'
            ,'*Поле запроса, отображаемое пользователю - для длинных лукапов');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('21', 'VARCHAR2', '4', 'LOOKUP_FIELD_TYPE', '17', '0', '0', 'FORM_COLUMNS', '', '*'
            ,'*См. Lookup FORM_COLUMNS.LOOKUP_FIELD_TYPE');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('32', 'VARCHAR2', '1020', 'LOOKUP_NAME', '11', '0', '0', 'FORM_COLUMNS', '', '*', '*Пользовательское имя');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('7', 'VARCHAR2', '4', 'PIMARY_KEY_FLAG', '15', '0', '0', 'FORM_COLUMNS', '', '*'
            ,'*Признак того, что поле является первичным ключем (Y). Пусто - не является.');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('15', 'VARCHAR2', '4', 'SHOW_HOVER_FLAG', '15', '0', '0', 'FORM_COLUMNS', '', '*'
            ,'*Показывать всплывающую подсказку-значение поля');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('8', 'VARCHAR2', '4', 'SHOW_ON_GRID', '12', '0', '0', 'FORM_COLUMNS', '', '*', '*Показывать в гриде');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('23', 'VARCHAR2', '1020', 'TEXT_MASK', '9', '0', '0', 'FORM_COLUMNS', '', '*'
            ,'*Текстовая маска для поля. См. описание в интерфейсе');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('10', 'VARCHAR2', '8', 'TREE_FIELD_TYPE', '15', '0', '0', 'FORM_COLUMNS', '', '*'
            ,'*Тип поля для дерева (Id, ParentId, ChildCount...)');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('9', 'VARCHAR2', '8000', 'TREE_INITIALIZATION_VALUE', '25', '0', '0', 'FORM_COLUMNS', '', '*'
            ,'*Если не пусто и тип формы - "дерево" - используется при первом вызове дерева для инициализации. Аналогично конструкции Start With древовидных запросов');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('24', 'VARCHAR2', '1020', 'VALIDATION_REGEXP', '17', '0', '0', 'FORM_COLUMNS', '', '*'
            ,'*Регулярное выражение для клиентской валидации');
/*  Form: FORM_COLUMNS. Entity: FORM_COLUMNS.  */

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMNS', 'COLUMN_CODE', 'Код', '40%', 'S', '30', 'Y', 'Y', '', '', 'MAIN', ''
            ,'*Идентификатор поля (из запроса)', 'N', 'Y', '', 'COLUMN_DESCRIPTION', '', '', '', '', '', '', '', ''
            ,'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMNS', 'COLUMN_DATA_TYPE', 'Тип данных', '40', 'S', '50', 'N', 'N', '', '', 'MAIN', '8'
            ,'*Тип данных', 'N', 'N', 'FORM_COLUMNS.DATA_TYPE', '', '', '', '', '', '', '', '', 'L', 'N', '2', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMNS', 'COLUMN_DESCRIPTION', 'Описание', '150', 'S', '900', 'N', 'N', '', '', 'HELP', ''
            ,'Краткое описание поля (всплывающая подсказка для пользователя)', 'N', 'N', '', '', '', '', '', '', '', ''
            ,'', '', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMNS', 'COLUMN_DISPLAY_NUMBER', '№', '22', 'N', '15', 'N', 'Y', '', '', 'MAIN', ''
            ,'*Порядковый номер отображения в таблице', 'N', 'N', '', '', '', '', '', '', '', '1', '', 'L', 'N', '1'
            ,'', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMNS', 'COLUMN_DISPLAY_SIZE', 'Ширина', '40', 'S', '60', 'N', 'N', '', '', 'MAIN', ''
            ,'Ширина поля в пикселях, процентах или * - авто', 'N', 'N', '', '', '', '', '', '', '', '', '', 'L', 'Y'
            ,'1', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMNS', 'COLUMN_USER_NAME', 'Польз. имя', '*', 'S', '45', 'N', 'Y', '', '', 'MAIN', ''
            ,'*Пользовательское имя поля', 'N', 'Y', '', '', '', '', '', '', '', '', '', 'L', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMNS', 'DEFAULT_ORDERBY_NUMBER', '№ сортировки', '*', 'S', '1025', 'N', 'N', '', '', 'MAIN', ''
            ,'*Порядок сортировки при открытии формы. "-" после цифры - сортировка по убыванию', 'N', 'N', '', '', ''
            ,'', '', '', '', '', '', 'L', 'N', '1', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMNS', 'DEFAULT_VALUE', 'По умолчанию', '*', 'S', '1026', 'N', 'N', '', '', 'MAIN', ''
            ,'Значение по умолчанию для новых записей', 'N', 'N', '', '', '', '', '', '', '', '', '', 'L', 'Y', '2', ''
            ,'');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMNS', 'EDITOR_COLS_SPAN', 'Редактор - кол-во колонок', '*', 'S', '1028', 'N', 'N', '', '', 'ADD'
            ,'', '*Редактор - количество колонок, занимаемых полем (item.setColSpan)', 'N', 'N', '', '', '', '', '', ''
            ,'', '', '', '', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMNS', 'EDITOR_END_ROW_FLAG', 'Редактор - с конца строки', '*', 'B', '1029', 'N', 'N', '', ''
            ,'ADD', '', '***item.setEndRow', 'N', 'N', '', '', '', '', '', '', '', '', '', '', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMNS', 'EDITOR_HEIGHT', 'Высота поля', '*', 'S', '1020', 'N', 'N', '', '', 'ADD', ''
            ,'*Высота поля в закладке редактирования', 'N', 'N', '', '', '', '', '', '', '', '', '', '', 'Y', '*', ''
            ,'');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMNS', 'EDITOR_ON_ENTER_KEY_ACTION', 'Действие по нажатию Enter', '*', 'S', '1031', 'N', 'N', ''
            ,'', 'ADD', '9', '*Действие по нажатию Enter', 'N', 'N', 'DBLCLICK_FORM_ACT_LIST', '', '', '', '', '', ''
            ,'', '', 'L', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMNS', 'EDITOR_TAB_CODE', 'Закладка', '80', 'S', '80', 'N', 'N', '', '', 'MAIN', '9'
            ,'*Идентификатор закладки', 'N', 'N', 'FORM_TABS_LIST', '', '', '', '', '', '', '', '', '', 'Y', '*', ''
            ,'');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMNS', 'EDITOR_TITLE_ORIENTATION', 'TitleOrientation', '*', 'S', '1027', 'N', 'N', '', '', 'ADD'
            ,'', '*item.setTitleOrientation', 'N', 'N', '', '', '', '', '', '', '', '', '', '', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMNS', 'EXISTS_IN_METADATA_FLAG', 'В настройках?', '*', 'B', '1016', 'N', 'Y', '', '', '', ''
            ,'Есть ли настройки для данного поля в таблице FORM_COLUMNS', 'N', 'Y', '', '', '', '', '', '', '', '', ''
            ,'', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMNS', 'EXISTS_IN_QUERY_FLAG', 'В запросе?', '*', 'B', '1017', 'N', 'Y', '', '', '', ''
            ,'Существует ли поле в запросе?', 'N', 'Y', '', '', '', '', '', '', '', '', '', '', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMNS', 'FIELD_TYPE', 'Тип поля', '40', 'S', '90', 'N', 'N', '', '', 'MAIN', '10'
            ,'*Тип поля, общий для дерева и грида', 'N', 'N', 'FORM_COLUMNS.FIELD_TYPE', '', '', '', '', '', '', '', ''
            ,'L', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMNS', 'FORM_CODE', 'Форма', '100', 'S', '20', 'Y', 'N', '', '1', 'MAIN', '9'
            ,'*Идентификатор форм', 'N', 'N', 'FORMS_LIST', '', '', '1', '', '', '', '', ':form_code_for_filter', 'L'
            ,'Y', '2', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMNS', 'HELP_TEXT', 'Will become item help.', '*', 'S', '1022', 'N', 'N', '', '', 'HELP', '5'
            ,'*Will become item help.', 'N', 'N', '', '', '400', '', '', '', '', '', '', 'T', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMNS', 'HOVER_COLUMN_CODE', 'Поле подсказки', '*', 'S', '875', 'N', 'N', '', '', 'HELP', '9'
            ,'*Поле той же формы, которое содержит подсказку. Если SHOW_HOVER_FLAG = ''Y'' и HOVER_COLUMN_CODE - подсказка берется из текущего поля (COLUMN_CODE)'
            ,'N', 'N', 'COLUMNS_LIST', '', '', '', '', '', '', '', '', '', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMNS', 'IS_FROZEN_FLAG', 'Заморозить', '80', 'B', '850', 'N', 'N', '', '', 'MAIN', ''
            ,'*Замораживать поле?', 'N', 'N', '', '', '', '', '', '', '', '', '', 'T', 'N', '1', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMNS', 'LOOKUP_CODE', 'Список', '*', 'S', '160', 'N', 'N', '', '', 'MAIN', '9'
            ,'*Текстовый идентфикатор (ID)', 'N', 'N', 'LOOKUPS_LIST', '', '', '', '', '', '', '', '', 'L', 'Y', '*'
            ,'LOOKUP_NAME', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMNS', 'LOOKUP_DISPLAY_VALUE', 'Списки: отображаемое поле', '*', 'S', '1030', 'N', 'N', '', ''
            ,'ADD', '9', '*Поле запроса, отображаемое пользователю - для длинных лукапов', 'N', 'N', 'COLUMNS_LIST', ''
            ,'', '', '', '', '', '', '', 'L', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMNS', 'LOOKUP_FIELD_TYPE', 'Тип поля в списке', '*', 'S', '1022', 'N', 'N', '', '', 'MAIN', '8'
            ,'Если форма используется как Lookup - какое из полей является идентификатором и будет сохранено в БД, какое поле будет отображаться пользователю.'
            ,'N', 'N', 'FORM_COLUMNS.LOOKUP_FIELD_TYPE', '', '', '', '', '', '', '', '', '', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMNS', 'LOOKUP_NAME', 'Пользовательское имя', '*', 'S', '1031', 'N', 'N', '', '', '', ''
            ,'*Пользовательское имя', 'N', 'N', '', '', '', '', '', '', '', '', '', 'L', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMNS', 'PIMARY_KEY_FLAG', 'Первичн. ключ', '80', 'B', '860', 'N', 'N', '', '', 'MAIN', ''
            ,'*Признак того, что поле является первичным ключем (Y). Пусто - не является.', 'N', 'N', '', '', '', ''
            ,'', '', '', '', '', 'T', 'N', '1', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMNS', 'SHOW_HOVER_FLAG', 'Подсказка', '80', 'B', '870', 'N', 'N', '', '', 'HELP', ''
            ,'*Показывать всплывающую подсказку-значение поля', 'N', 'N', '', '', '', '', '', '', '', '', '', '', 'Y'
            ,'*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMNS', 'SHOW_ON_GRID', 'Отображать в таблице', '80', 'B', '880', 'N', 'N', '', '', 'MAIN', ''
            ,'Показывать в гриде', 'N', 'N', '', '', '', '', '', '', '', '', '', 'T', 'Y', '1', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMNS', 'TEXT_MASK', 'Маска', '*', 'S', '1023', 'N', 'N', '', '', 'ADD', ''
            ,'*Текстовая маска для поля. См. описание в интерфейсе', 'N', 'N', '', '', '', '', '', '', '', '', '', ''
            ,'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMNS', 'TREE_FIELD_TYPE', 'Тип для дерева', '40', 'S', '70', 'N', 'N', '', '', 'ADD', '8'
            ,'*Тип поля для дерева (Id, ParentId, ChildCount...)', 'N', 'N', 'FORM_COLUMNS.TREE_FIELD_TYPE', '', '', ''
            ,'', '', '', '', '', 'L', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMNS', 'TREE_INITIALIZATION_VALUE', 'Иниц. дерева', '80', 'S', '1000', 'N', 'N', '', '', 'ADD'
            ,''
            ,'*Если не пусто и тип формы - "дерево" - используется при первом вызове дерева для инициализации. Аналогично конструкции Start With древовидных запросов'
            ,'N', 'N', '', '', '', '', '', '', '', '', '', '', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMNS', 'VALIDATION_REGEXP', 'Валидация', '*', 'S', '1024', 'N', 'N', '', '', 'ADD', ''
            ,'*Регулярное выражение для клиентской валидации', 'N', 'N', '', '', '', '', '', '', '', '', '', 'L', 'Y'
            ,'*', '', '');

Declare
   l_clob   Clob := '<br>';
Begin
   Update FORMS
      Set description = l_clob
    Where form_code = 'FORM_COLUMNS';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>Код поля.</b></font></span><div>Внутренний идентификатор столбца запроса - уникален в пределах формы.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_COLUMNS'
      And column_code = 'COLUMN_CODE';
End;
/

Declare
   l_clob   Clob
      := '<font class="Apple-style-span" face="''times new roman'', times, serif"><span class="Apple-style-span" style="font-size: medium;"><b>Тип данных.</b></span></font><div>Пока не используется. Автоматически подставляется БД при разборе запроса.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_COLUMNS'
      And column_code = 'COLUMN_DATA_TYPE';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-family: Arial; font-size: 13px; "><h2><font size="-1">com.smartgwt.client.docs</font>&nbsp;<br>Interface SqlVsJPA</h2><hr><dl><dt><pre>public interface <b>SqlVsJPA</b></pre></dt></dl><p></p><h3>SQL DataSource vs JPA, EJB, Ibatis and other technologies</h3>If you are free to choose which persistence mechanism your application will use, you should consider using the SmartGWT SQL DataSource instead of a more heavyweight, bean-based solution. This article discusses the advantages of doing so.<p><b>Simplicity</b></p></span>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_COLUMNS'
      And column_code = 'COLUMN_DESCRIPTION';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium;"><font class="Apple-style-span" face="''times new roman'', times, serif"><b>№</b></font></span><div>Отвечает за порядок отображения столбца в таблице и в форме редактирования.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_COLUMNS'
      And column_code = 'COLUMN_DISPLAY_NUMBER';
End;
/

Declare
   l_clob   Clob
      := '<b><font class="Apple-style-span" face="''times new roman'', times, serif"><span class="Apple-style-span" style="font-size: medium;">Ширина</span></font></b>.<div>Ширина столбцах в виде целого числа либо в процентах.</div><div>В случае, если указанно целое число, ширина столбца определяется в пикселях.</div><div>Если указана ширина в процентах - ширина определяется как отношение ширины столбца к общей ширине видимых полей таблицы.</div><div>Значение "<b>*</b>" - автоматический подбор ширины.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_COLUMNS'
      And column_code = 'COLUMN_DISPLAY_SIZE';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="white-space: pre; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b><span class="Apple-style-span" style="font-size: medium;">Польз. имя.</span></b></font></span><div><span class="Apple-style-span" style="white-space: pre;"><font class="Apple-style-span" face="''times new roman'', times, serif"><span class="Apple-style-span" style="font-size: small;">Имя столбца, отображаемое пользователю. Если не указано - отображается значение поля <i>COLUMN_CODE</i>.</span></font></span></div><div><font class="Apple-style-span" face="''times new roman'', times, serif"><span class="Apple-style-span" style="font-size: small; white-space: pre;"><br></span></font></div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_COLUMNS'
      And column_code = 'COLUMN_USER_NAME';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>№ сортировки.</b></font></span><div>Описание настройки.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_COLUMNS'
      And column_code = 'DEFAULT_ORDERBY_NUMBER';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>По умолчанию.</b></font></span><div>Описание настройки.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_COLUMNS'
      And column_code = 'DEFAULT_VALUE';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>Редактор - кол-во колонок.</b></font></span><div>Описание настройки.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_COLUMNS'
      And column_code = 'EDITOR_COLS_SPAN';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>Редактор - с конца строки.</b></font></span><div>Описание настройки.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_COLUMNS'
      And column_code = 'EDITOR_END_ROW_FLAG';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>Высота поля.</b></font></span><div>Описание настройки.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_COLUMNS'
      And column_code = 'EDITOR_HEIGHT';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>Действие по нажатию Enter.</b></font></span><div>Описание настройки.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_COLUMNS'
      And column_code = 'EDITOR_ON_ENTER_KEY_ACTION';
End;
/

Declare
   l_clob   Clob
      := '<b><font class="Apple-style-span" face="''times new roman'', times, serif"><span class="Apple-style-span" style="font-size: medium;">Закладка.</span></font></b><div>Ссылка на вкладку формы редактирования.</div><div><div>В случае, если поле заполнено - поле отображается и в таблице (гриде), и в форме редактирования записи.</div><div>При необходимости отобразить поле только в форме редактирования - используйте свойство<i> SHOW_ON_GRID</i> ("<b>Отображать</b>")</div></div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_COLUMNS'
      And column_code = 'EDITOR_TAB_CODE';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>TitleOrientation.</b></font></span><div>Описание настройки.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_COLUMNS'
      And column_code = 'EDITOR_TITLE_ORIENTATION';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>В настройках?.</b></font></span><div>Описание настройки.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_COLUMNS'
      And column_code = 'EXISTS_IN_METADATA_FLAG';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>В запросе?.</b></font></span><div>Описание настройки.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_COLUMNS'
      And column_code = 'EXISTS_IN_QUERY_FLAG';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="white-space: pre; "><font class="Apple-style-span" face="''times new roman'', times, serif"><span class="Apple-style-span" style="font-size: medium;"><b>Тип поля.</b></span></font></span><div><span class="Apple-style-span" style="white-space: pre;">Используется для определения специального поведения при отрисовке формы.</span></div><div><span class="Apple-style-span" style="white-space: pre;">В данный момент определены такие типы:</span></div><div><span class="Apple-style-span" style="white-space: pre;"><br></span></div><div><span class="Apple-style-span" style="white-space: pre;"><b>Динамическая подчиненная форма одиночная (с обновлением) </b>- поле возвращает код формы детализации. При изменении кода формы производится построение новой формы детализации.</span></div><div><span class="Apple-style-span" style="white-space: pre;"><span class="Apple-tab-span" style="white-space:pre">	</span>Если код формы не изменился - происходит только обновление данных формы по данным строки мастер-формы.</span></div><div><span class="Apple-style-span" style="white-space: pre;"><span class="Apple-tab-span" style="white-space:pre">	</span><b>Пример:</b> <i>FORMS2.DETAIL_FORM.</i></span></div><div><span class="Apple-style-span" style="white-space: pre;">
<b>Динамическая подчиненная форма множественная (без обновлнения)</b> -&nbsp;поле возвращает код формы детализации. При изменении кода формы <b>всегда</b> производится</span></div><div><span class="Apple-style-span" style="white-space: pre;"><span class="Apple-tab-span" style="white-space:pre">	</span>построение новой формы детализации.<span class="Apple-style-span" style="white-space: normal; "><div><span class="Apple-style-span" style="white-space: pre; "><span class="Apple-tab-span" style="white-space: pre; ">	</span><b>Пример:</b>&nbsp;<i>FORMS2.DETAIL_FORM_MULTI.</i></span></div><div><span class="Apple-style-span" style="white-space: pre;"><br></span></div></span><b>Иконка </b>-&nbsp;xx</span></div><div><span class="Apple-style-span" style="white-space: pre;"><span class="Apple-tab-span" style="white-space:pre">	</span>ыы</span></div><div><span class="Apple-style-span" style="white-space: pre;"><span class="Apple-tab-span" style="white-space:pre">	</span><b>Пример:</b> вв
<b>Текстовый редактор<span class="Apple-style-span" style="font-weight: normal; "> -&nbsp;xx</span><span class="Apple-style-span" style="font-weight: normal; white-space: normal; "><div><span class="Apple-style-span" style="white-space: pre; "><span class="Apple-tab-span" style="white-space: pre; ">	</span>ыы</span></div><div><span class="Apple-style-span" style="white-space: pre; "><span class="Apple-tab-span" style="white-space: pre; ">	</span><b>Пример:</b> вв</span></div></span>
HTML editor<span class="Apple-style-span" style="font-weight: normal; "> -&nbsp;xx</span><span class="Apple-style-span" style="font-weight: normal; white-space: normal; "><div><span class="Apple-style-span" style="white-space: pre; "><span class="Apple-tab-span" style="white-space: pre; ">	</span>ыы</span></div><div><span class="Apple-style-span" style="white-space: pre; "><span class="Apple-tab-span" style="white-space: pre; ">	</span><b>Пример:</b> вв</span></div></span>
Заголовок формы (нередактируемый)<span class="Apple-style-span" style="font-weight: normal; "> -&nbsp;xx</span><span class="Apple-style-span" style="font-weight: normal; white-space: normal; "><div><span class="Apple-style-span" style="white-space: pre; "><span class="Apple-tab-span" style="white-space: pre; ">	</span>ыы</span></div><div><span class="Apple-style-span" style="white-space: pre; "><span class="Apple-tab-span" style="white-space: pre; ">	</span><b>Пример:</b> вв</span></div></span>
iFrame<span class="Apple-style-span" style="font-weight: normal; "> -&nbsp;xx</span><span class="Apple-style-span" style="font-weight: normal; white-space: normal; "><div><span class="Apple-style-span" style="white-space: pre; "><span class="Apple-tab-span" style="white-space: pre; ">	</span>ыы</span></div><div><span class="Apple-style-span" style="white-space: pre; "><span class="Apple-tab-span" style="white-space: pre; ">	</span><b>Пример:</b> вв</span></div></span>
Lookup простой<span class="Apple-style-span" style="font-weight: normal; "> -&nbsp;xx</span><span class="Apple-style-span" style="font-weight: normal; white-space: normal; "><div><span class="Apple-style-span" style="white-space: pre; "><span class="Apple-tab-span" style="white-space: pre; ">	</span>ыы</span></div><div><span class="Apple-style-span" style="white-space: pre; "><span class="Apple-tab-span" style="white-space: pre; ">	</span><b>Пример:</b> вв</span></div></span>
Lookup-форма<span class="Apple-style-span" style="font-weight: normal; "> -&nbsp;xx</span></b></span><span class="Apple-style-span" style="white-space: pre;"><b>
</b></span></div><div><span class="Apple-style-span" style="white-space: pre; "><span class="Apple-tab-span" style="white-space: pre; ">	</span>ыы</span></div><div><span class="Apple-style-span" style="white-space: pre; "><span class="Apple-tab-span" style="white-space: pre; ">	</span><b>Пример:</b> вв</span></div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_COLUMNS'
      And column_code = 'FIELD_TYPE';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="border-collapse: separate; color: rgb(0, 0, 0); font-family: ''Times New Roman''; font-size: medium; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; orphans: 2; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px;"><span class="Apple-style-span" style="font-family: arial,sans-serif; font-size: 13px;"><h2 style="font-size: large;"><span class="Apple-style-span" style="font-family: Arial, sans-serif; font-size: 11px; font-weight: normal; color: rgb(51, 51, 51); "><span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>Форма.</b></font></span><div>Ссылка на форму-владелец данного поля.</div></span></h2></span></span>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_COLUMNS'
      And column_code = 'FORM_CODE';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>Will become item help..</b></font></span><div>Описание настройки.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_COLUMNS'
      And column_code = 'HELP_TEXT';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>Поле подсказки.</b></font></span><div>Описание настройки.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_COLUMNS'
      And column_code = 'HOVER_COLUMN_CODE';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>Заморозить.</b></font></span><div>Описание настройки.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_COLUMNS'
      And column_code = 'IS_FROZEN_FLAG';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>Список.</b></font></span><div>Описание настройки.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_COLUMNS'
      And column_code = 'LOOKUP_CODE';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>Списки: отображаемое поле.</b></font></span><div>Описание настройки.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_COLUMNS'
      And column_code = 'LOOKUP_DISPLAY_VALUE';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>Тип поля в списке.</b></font></span><div>Описание настройки.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_COLUMNS'
      And column_code = 'LOOKUP_FIELD_TYPE';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>Первичн. ключ.</b></font></span><div>Описание настройки.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_COLUMNS'
      And column_code = 'PIMARY_KEY_FLAG';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>Подсказка.</b></font></span><div>Описание настройки.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_COLUMNS'
      And column_code = 'SHOW_HOVER_FLAG';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>Отображать в таблице.</b></font></span><div>Описание настройки.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_COLUMNS'
      And column_code = 'SHOW_ON_GRID';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="border-collapse: separate; color: rgb(0, 0, 0); font-family: ''Times New Roman''; font-size: medium; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; orphans: 2; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px;"><span class="Apple-style-span" style="color: rgb(51, 51, 51); font-family: Verdana,sans-serif; font-size: 11px;"><p>TextItems support a masked entry to restrict and format entry.</p><p>Overview of available mask characters</p><p><table class="normal" style="font-family: Verdana,sans-serif; font-size: 11px; color: rgb(51, 51, 51);"><tbody><tr><th>Character</th><th>Description</th></tr><tr><td>0</td><td>Digit (0 through 9) or plus [+] or minus [-] signs</td></tr><tr><td>9</td><td>Digit or space</td></tr><tr><td>#</td><td>Digit</td></tr><tr><td>L</td><td>Letter (A through Z)</td></tr><tr><td>?</td><td>Letter (A through Z) or space</td></tr><tr><td>A</td><td>Letter or digit</td></tr><tr><td>a</td><td>Letter or digit</td></tr><tr><td>C</td><td>Any character or space</td></tr><tr><td>&nbsp;</td></tr><tr><td>&lt;</td><td>Causes all characters that follow to be converted to lowercase</td></tr><tr><td>&gt;</td><td>Causes all characters that follow to be converted to uppercase</td></tr></tbody></table></p><p>Any character not matching one of the above mask characters or that is escaped with a backslash (\) is considered to be a literal.</p><p>Custom mask characters can be defined by standard regular expression character set or range. For example, a hexadecimal color code mask could be:</p><ul><li>Color: \#&gt;[0-9A-F][0-9A-F][0-9A-F][0-9A-F][0-9A-F][0-9A-F]</li></ul></span></span>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_COLUMNS'
      And column_code = 'TEXT_MASK';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="white-space: pre; "><font class="Apple-style-span" face="''times new roman'', times, serif"><span class="Apple-style-span" style="font-size: medium;"><b>Тип для дерева.</b></span></font></span><div><span class="Apple-style-span" style="white-space: pre;">Для форм с типом "T" ("Дерево") определяет тип столбца, например - идентификатор записи,</span></div><div><span class="Apple-style-span" style="white-space: pre;">ссылка на родителя, количество дочерних узлов, является ли узлом или конечным элементом, иконка и др.</span></div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_COLUMNS'
      And column_code = 'TREE_FIELD_TYPE';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>Иниц. дерева.</b></font></span><div>Описание настройки.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_COLUMNS'
      And column_code = 'TREE_INITIALIZATION_VALUE';
End;
/

Declare
   l_clob   Clob
      := '<div><b>Например</b>, проверка правильности e-mail:</div><div>^([a-zA-Z0-9_.\-+])+@(([a-zA-Z0-9\-])+\.)+[a-zA-Z0-9]{2,4}$</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_COLUMNS'
      And column_code = 'VALIDATION_REGEXP';
End;
/

Alter Table forms Enable VALIDATE Constraint forms_form_actions_fk;
Alter Table FORMS Enable All Triggers;
/*****************FORM_COLUMN_ATTR_VALS*********************/
Alter Table FORMS Disable All Triggers;
Alter Table forms Disable Constraint forms_form_actions_fk;
Delete From FORM_COLUMNS
      Where form_code = 'FORM_COLUMN_ATTR_VALS';
Delete From FORM_COLUMNS$
      Where form_code = 'FORM_COLUMN_ATTR_VALS';
Delete From FORM_ACTIONS
      Where form_code = 'FORM_COLUMN_ATTR_VALS';
Delete From FORM_TABS
      Where form_code = 'FORM_COLUMN_ATTR_VALS';
Delete From FORMS
      Where form_code = 'FORM_COLUMN_ATTR_VALS';
/*  Form: FORM_COLUMN_ATTR_VALS. Entity: FORMS.  */

Insert Into FORMS
            ("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID"
            ,"FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR"
            ,"OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH", "DESCRIPTION", "DOUBLE_CLICK_ACTION_CODE", "LOOKUP_WIDTH"
            ,"APPS_CODE", "EXPORT_ORDER")
     Values ('FORM_COLUMN_ATTR_VALS', ''
            ,'Select a.form_column_attr_val_id, a.form_code, a.column_code, a.attribute_code, a.attribute_value
  From &fc_schema_owner..form_column_attr_vals a
 Where a.form_code = :form_code
   And a.column_code = :column_code
--
'
            ,'Дополнительные атрибуты колонки', 'G', 'Y', '', '*', '*', '', '', 'Y', '7', '*', '', '', '', 'FC', '80');
/*  Form: FORM_COLUMN_ATTR_VALS. Entity: FORM_TABS.  */
/*  Form: FORM_COLUMN_ATTR_VALS. Entity: FORM_ACTIONS.  */

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('FORM_COLUMN_ATTR_VALS', 'DEL', '&fc_schema_owner..FORM_COLUMN_ATTR_VALS_PKG.p_delete', 'Удалить', '48'
            ,'', '', '3', '130', 'Вы уверенны что хотите удалить запись?', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('FORM_COLUMN_ATTR_VALS', 'EDIT', '', 'Редактировать', '50', '', '', '8', '115', 'Вы уверенны?', '', 'N'
            ,'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('FORM_COLUMN_ATTR_VALS', 'INS', '', 'Создать', '47', '', '', '1', '110', '', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('FORM_COLUMN_ATTR_VALS', 'REFR', '', 'Обновить', '15', '', '', '4', '10', '', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('FORM_COLUMN_ATTR_VALS', 'UPD', '&fc_schema_owner..FORM_COLUMN_ATTR_VALS_PKG.p_ins_upd', 'Сохранить', '46'
            ,'', '', '2', '120', 'Вы уверенны?', '', 'N', 'Y', '');
/*  Form: FORM_COLUMN_ATTR_VALS. Entity: FORM_COLUMNS$.  */

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('4', 'VARCHAR2', '1020', 'ATTRIBUTE_CODE', '14', '0', '0', 'FORM_COLUMN_ATTR_VALS', '', '*'
            ,'*Код атрибута');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('5', 'VARCHAR2', '1020', 'ATTRIBUTE_VALUE', '15', '0', '0', 'FORM_COLUMN_ATTR_VALS', '', '*'
            ,'*значение атрибута');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('3', 'VARCHAR2', '1020', 'COLUMN_CODE', '11', '0', '0', 'FORM_COLUMN_ATTR_VALS', '', '*'
            ,'*Идентификатор поля (из запроса)');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('2', 'VARCHAR2', '1020', 'FORM_CODE', '9', '0', '0', 'FORM_COLUMN_ATTR_VALS', '', '*'
            ,'*Идентификатор форм');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('1', 'NUMBER', '22', 'FORM_COLUMN_ATTR_VAL_ID', '23', '0', '-127', 'FORM_COLUMN_ATTR_VALS', '', '*', '*Id');
/*  Form: FORM_COLUMN_ATTR_VALS. Entity: FORM_COLUMNS.  */

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMN_ATTR_VALS', 'COLUMN_CODE', 'Идентификатор поля (из запроса)', '*', 'S', '1003', 'N', 'N', ''
            ,'', '', '', '*Идентификатор поля (из запроса)', 'N', 'N', '', '', '', '', '', '', '', '', ':COLUMN_CODE'
            ,'L', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMN_ATTR_VALS', 'FORM_CODE', 'Идентификатор форм', '*', 'S', '1002', 'N', 'N', '', '', '', ''
            ,'*Идентификатор форм', 'N', 'N', '', '', '', '', '', '', '', '', ':FORM_CODE', 'L', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMN_ATTR_VALS', 'FORM_COLUMN_ATTR_VAL_ID', 'Id', '*', 'N', '1001', 'Y', 'N', '', '', '', ''
            ,'*Id', 'N', 'N', '', '', '', '', '', '', '', '', '', 'L', 'Y', '*', '', '');

Alter Table forms Enable VALIDATE Constraint forms_form_actions_fk;
Alter Table FORMS Enable All Triggers;
/*****************APPS_ROLE_MENUS*********************/
Alter Table FORMS Disable All Triggers;
Alter Table forms Disable Constraint forms_form_actions_fk;
Delete From FORM_COLUMNS
      Where form_code = 'APPS_ROLE_MENUS';
Delete From FORM_COLUMNS$
      Where form_code = 'APPS_ROLE_MENUS';
Delete From FORM_ACTIONS
      Where form_code = 'APPS_ROLE_MENUS';
Delete From FORM_TABS
      Where form_code = 'APPS_ROLE_MENUS';
Delete From FORMS
      Where form_code = 'APPS_ROLE_MENUS';
/*  Form: APPS_ROLE_MENUS. Entity: FORMS.  */

Insert Into FORMS
            ("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID"
            ,"FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR"
            ,"OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH", "DESCRIPTION", "DOUBLE_CLICK_ACTION_CODE", "LOOKUP_WIDTH"
            ,"APPS_CODE", "EXPORT_ORDER")
     Values ('APPS_ROLE_MENUS', ''
            ,'Select a.*, a.parent_menu_code as parent
  From &fc_schema_owner..apps_role_menus a
 Where NVL (a.parent_menu_code, ''###'') = NVL (:menu_code, ''###'')

/*
Select     a.*, a.parent_menu_code As Parent
      From &fc_schema_owner..apps_role_menus a
Start With (    a.parent_menu_code Is Null
            And :p_$master_form_code Is Null)
        Or (    :p_$master_form_code = ''X''
            And a.menu_code = ''M1'')
Connect By Prior a.menu_code = a.parent_menu_code
*/'
            ,'Меню для роли', 'T', 'Y', '23', '*', '*', '', '', 'Y', '21', '*', '', '', '', 'FC', '90');
/*  Form: APPS_ROLE_MENUS. Entity: FORM_TABS.  */
/*  Form: APPS_ROLE_MENUS. Entity: FORM_ACTIONS.  */

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('APPS_ROLE_MENUS', 'DEL', '&fc_schema_owner..APPS_ROLE_MENUS_PKG.p_delete', 'Удалить', '48', '', '', '3'
            ,'130', 'Вы уверенны что хотите удалить запись?', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('APPS_ROLE_MENUS', 'EDIT', '', 'Редактировать', '50', '', '', '8', '115', 'Вы уверенны?', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('APPS_ROLE_MENUS', 'INS', '', 'Создать', '47', '', '', '1', '110', '', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('APPS_ROLE_MENUS', 'REFR', '', 'Обновить', '15', '', '', '4', '10', '', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('APPS_ROLE_MENUS', 'UPD', '&fc_schema_owner..APPS_ROLE_MENUS_PKG.p_ins_upd', 'Сохранить', '46', '', ''
            ,'2', '120', 'Вы уверенны?', '', 'N', 'Y', '');
/*  Form: APPS_ROLE_MENUS. Entity: FORM_COLUMNS$.  */

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('1', 'NUMBER', '22', 'APP_MENU_ID', '11', '0', '-127', 'APPS_ROLE_MENUS', '', '*', '**APP_MENU_ID');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('7', 'VARCHAR2', '4000', 'DISPLAY_NAME', '12', '0', '0', 'APPS_ROLE_MENUS', '', '*'
            ,'*Имя поля в приказе. Перекрывает значение attribute_types.attribute_name');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('6', 'VARCHAR2', '4000', 'ENABLED_FLAG', '12', '0', '0', 'APPS_ROLE_MENUS', '', '*', '**ENABLED_FLAG');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('5', 'VARCHAR2', '4000', 'FORM_CODE', '9', '0', '0', 'APPS_ROLE_MENUS', '', '*', '*Идентификатор форм');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('2', 'VARCHAR2', '4000', 'MENU_CODE', '9', '0', '0', 'APPS_ROLE_MENUS', '', '*', '*Код меню');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('8', 'VARCHAR2', '4000', 'PARENT', '6', '0', '0', 'APPS_ROLE_MENUS', '', '*', '**PARENT');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('3', 'VARCHAR2', '4000', 'PARENT_MENU_CODE', '16', '0', '0', 'APPS_ROLE_MENUS', '', '*'
            ,'*Ссылка на пункт меню-родитель');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('4', 'NUMBER', '22', 'POSITION', '8', '9', '0', 'APPS_ROLE_MENUS', '', '*'
            ,'*9 - Относительная позиция в ветви дерева');
/*  Form: APPS_ROLE_MENUS. Entity: FORM_COLUMNS.  */

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('APPS_ROLE_MENUS', 'APP_MENU_ID', '', '*', 'N', '1001', 'Y', 'N', '', '', '', '', '**APP_MENU_ID', 'N'
            ,'N', '', '', '', '', '', '', '', '1', '', 'L', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('APPS_ROLE_MENUS', 'DISPLAY_NAME', 'Имя', '*', 'S', '1007', 'N', 'Y', '', '', '', ''
            ,'Если не указано - берется имя формы, затем код меню', 'N', 'Y', '', '', '', '', '', '', '', '', '', 'L'
            ,'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('APPS_ROLE_MENUS', 'ENABLED_FLAG', '', '*', 'B', '1006', 'N', 'Y', '', '', '', '', '**ENABLED_FLAG', 'N'
            ,'N', '', '', '', '', '', '', '', '', '', 'L', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('APPS_ROLE_MENUS', 'FORM_CODE', 'Форма', '*', 'S', '1005', 'N', 'Y', '', '', '', '9'
            ,'*Идентификатор форм', 'N', 'N', 'FORMS_LIST', '', '', '', '', '', '', '', '', 'L', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('APPS_ROLE_MENUS', 'MENU_CODE', 'Код меню', '*', 'S', '1002', 'N', 'Y', '', '1', '', '', '*Код меню', 'N'
            ,'N', '', '', '', '', '', '', '', '', '', 'L', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('APPS_ROLE_MENUS', 'PARENT', '', '*', 'S', '1007', 'N', 'N', '', '2', '', '', '**PARENT', 'N', 'N', '', ''
            ,'', '', '', '', '', '', '', 'L', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('APPS_ROLE_MENUS', 'PARENT_MENU_CODE', 'Меню-родитель', '*', 'S', '1003', 'N', 'Y', '', '', '', ''
            ,'*Ссылка на пункт меню-родитель', 'N', 'N', '', '', '', '', '', '', '', '', '', 'L', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('APPS_ROLE_MENUS', 'POSITION', 'Позиция', '*', 'S', '1004', 'N', 'Y', '', '', '', ''
            ,'*9 - Относительная позиция в ветви дерева', 'N', 'N', '', '', '', '', '', '', '', '', '', 'L', 'Y', '*'
            ,'', '');

Alter Table forms Enable VALIDATE Constraint forms_form_actions_fk;
Alter Table FORMS Enable All Triggers;
/*****************APPS_ROLE_USERS*********************/
Alter Table FORMS Disable All Triggers;
Alter Table forms Disable Constraint forms_form_actions_fk;
Delete From FORM_COLUMNS
      Where form_code = 'APPS_ROLE_USERS';
Delete From FORM_COLUMNS$
      Where form_code = 'APPS_ROLE_USERS';
Delete From FORM_ACTIONS
      Where form_code = 'APPS_ROLE_USERS';
Delete From FORM_TABS
      Where form_code = 'APPS_ROLE_USERS';
Delete From FORMS
      Where form_code = 'APPS_ROLE_USERS';
/*  Form: APPS_ROLE_USERS. Entity: FORMS.  */

Insert Into FORMS
            ("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID"
            ,"FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR"
            ,"OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH", "DESCRIPTION", "DOUBLE_CLICK_ACTION_CODE", "LOOKUP_WIDTH"
            ,"APPS_CODE", "EXPORT_ORDER")
     Values ('APPS_ROLE_USERS', ''
            ,'Select *
  From apps_role_users aru
 Where (    aru.role_code = :role_code
        And :p_$master_form_code = ''APPS_ROLES'')
    Or :p_$master_form_code Is Null
'
            ,'Пользователи роли', 'G', 'Y', '32', '*', '*', '', '', 'Y', '8', '*', '', '', '', 'FC', '90');
/*  Form: APPS_ROLE_USERS. Entity: FORM_TABS.  */
/*  Form: APPS_ROLE_USERS. Entity: FORM_ACTIONS.  */

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('APPS_ROLE_USERS', 'DEL', '&fc_schema_owner..APPS_ROLE_USERS_PKG.p_delete', 'Удалить', '48', '', '', '3'
            ,'130', 'Вы уверенны что хотите удалить запись?', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('APPS_ROLE_USERS', 'EDIT', '', 'Редактировать', '50', '', '', '8', '115', 'Вы уверенны?', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('APPS_ROLE_USERS', 'INS', '', 'Создать', '47', '', '', '1', '110', '', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('APPS_ROLE_USERS', 'REFR', '', 'Обновить', '15', '', '', '4', '10', '', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('APPS_ROLE_USERS', 'UPD', '&fc_schema_owner..APPS_ROLE_USERS_PKG.p_ins_upd', 'Сохранить', '46', '', ''
            ,'2', '120', 'Вы уверенны?', '', 'N', 'Y', '');
/*  Form: APPS_ROLE_USERS. Entity: FORM_COLUMNS$.  */

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('3', 'VARCHAR2', '4000', 'APPS_CODE', '9', '0', '0', 'APPS_ROLE_USERS', '', '*', '**APPS_CODE');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('1', 'NUMBER', '22', 'APP_ROLE_USER_ID', '16', '0', '-127', 'APPS_ROLE_USERS', '', '*'
            ,'**APP_ROLE_USER_ID');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('2', 'VARCHAR2', '4000', 'ROLE_CODE', '9', '0', '0', 'APPS_ROLE_USERS', '', '*', '**ROLE_CODE');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('4', 'NUMBER', '22', 'USER_ID', '7', '0', '-127', 'APPS_ROLE_USERS', '', '*', '*Database user id.');
/*  Form: APPS_ROLE_USERS. Entity: FORM_COLUMNS.  */

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('APPS_ROLE_USERS', 'APP_ROLE_USER_ID', '', '*', 'N', '1001', 'Y', 'N', '', '', '', ''
            ,'**APP_ROLE_USER_ID', 'N', 'N', '', '', '', '', '', '', '', '', '', 'L', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('APPS_ROLE_USERS', 'ROLE_CODE', '', '*', 'S', '1002', 'N', 'Y', '', '', '', '9', '**ROLE_CODE', 'N', 'N'
            ,'APPS_ROLES', '', '', '', '', '', '', '', '', 'L', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('APPS_ROLE_USERS', 'USER_ID', 'Database user id.', '*', 'N', '1004', 'N', 'Y', '', '', '', '9'
            ,'*Database user id.', 'N', 'N', 'USERS', '', '', '', '', '', '', '', '', 'L', 'Y', '*', '', '');

Alter Table forms Enable VALIDATE Constraint forms_form_actions_fk;
Alter Table FORMS Enable All Triggers;
/*****************APPS_ROLES*********************/
Alter Table FORMS Disable All Triggers;
Alter Table forms Disable Constraint forms_form_actions_fk;
Delete From FORM_COLUMNS
      Where form_code = 'APPS_ROLES';
Delete From FORM_COLUMNS$
      Where form_code = 'APPS_ROLES';
Delete From FORM_ACTIONS
      Where form_code = 'APPS_ROLES';
Delete From FORM_TABS
      Where form_code = 'APPS_ROLES';
Delete From FORMS
      Where form_code = 'APPS_ROLES';
/*  Form: APPS_ROLES. Entity: FORMS.  */

Insert Into FORMS
            ("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID"
            ,"FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR"
            ,"OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH", "DESCRIPTION", "DOUBLE_CLICK_ACTION_CODE", "LOOKUP_WIDTH"
            ,"APPS_CODE", "EXPORT_ORDER")
     Values ('APPS_ROLES', '', 'select *
  from &fc_schema_owner..apps_roles
',           'Роли приложения', 'G', 'Y', '42', '*', '*', '', '', 'Y', '15', '*', '', '', '', 'FC', '100');
/*  Form: APPS_ROLES. Entity: FORM_TABS.  */

Insert Into FORM_TABS
            ("FORM_CODE", "TAB_CODE", "CHILD_FORM_CODE", "TAB_POSITION", "TAB_NAME", "NUMBER_OF_COLUMNS", "ICON_ID"
            ,"TAB_TYPE", "TAB_DISPLAY_NUMBER")
     Values ('APPS_ROLES', 'MENUS', 'APPS_ROLE_MENUS', 'R', '', '', '', '2', '1');

Insert Into FORM_TABS
            ("FORM_CODE", "TAB_CODE", "CHILD_FORM_CODE", "TAB_POSITION", "TAB_NAME", "NUMBER_OF_COLUMNS", "ICON_ID"
            ,"TAB_TYPE", "TAB_DISPLAY_NUMBER")
     Values ('APPS_ROLES', 'USERS', 'APPS_ROLE_USERS', 'R', '', '', '', '2', '2');
/*  Form: APPS_ROLES. Entity: FORM_ACTIONS.  */

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('APPS_ROLES', 'DEL', '&fc_schema_owner..APPS_ROLES_PKG.p_delete', 'Удалить', '48', '', '', '3', '130'
            ,'Вы уверенны что хотите удалить запись?', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('APPS_ROLES', 'EDIT', '', 'Редактировать', '50', '', '', '8', '115', 'Вы уверенны?', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('APPS_ROLES', 'INS', '', 'Создать', '47', '', '', '1', '110', '', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('APPS_ROLES', 'REFR', '', 'Обновить', '15', '', '', '4', '10', '', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('APPS_ROLES', 'UPD', '&fc_schema_owner..APPS_ROLES_PKG.p_ins_upd', 'Сохранить', '46', '', '', '2', '120'
            ,'Вы уверенны?', '', 'N', 'Y', '');
/*  Form: APPS_ROLES. Entity: FORM_COLUMNS$.  */

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('4', 'VARCHAR2', '4000', 'APPS_CODE', '9', '0', '0', 'APPS_ROLES', '', '*', '**APPS_CODE');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('1', 'NUMBER', '22', 'APPS_ROLE_ID', '12', '0', '-127', 'APPS_ROLES', '', '*', '**APPS_ROLE_ID');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('2', 'VARCHAR2', '4000', 'ROLE_CODE', '9', '0', '0', 'APPS_ROLES', '', '*', '**ROLE_CODE');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('3', 'VARCHAR2', '4000', 'ROLE_NAME', '9', '0', '0', 'APPS_ROLES', '', '*', '** Для всех ролей');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('5', 'VARCHAR2', '4000', 'ROOT_MENU_CODE', '14', '0', '0', 'APPS_ROLES', '', '*', '**ROOT_MENU_CODE');
/*  Form: APPS_ROLES. Entity: FORM_COLUMNS.  */

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('APPS_ROLES', 'APPS_CODE', '', '*', 'S', '1004', 'N', 'Y', '', '', '', '', '**APPS_CODE', 'N', 'N', '', ''
            ,'', '3', '', '', '', '', '', 'L', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('APPS_ROLES', 'APPS_ROLE_ID', '', '*', 'N', '1001', 'Y', 'N', '', '', '', '', '**APPS_ROLE_ID', 'N', 'N'
            ,'', '', '', '', '', '', '', '', '', 'L', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('APPS_ROLES', 'ROLE_CODE', '', '*', 'S', '1002', 'N', 'Y', '', '', '', '', '**ROLE_CODE', 'N', 'N', '', ''
            ,'', '1', '', '', '', '', '', 'L', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('APPS_ROLES', 'ROLE_NAME', 'Наименование', '*', 'S', '1003', 'N', 'Y', '', '', '', '', '** Для всех ролей'
            ,'N', 'N', '', '', '', '2', '', '', '', '', '', 'L', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('APPS_ROLES', 'ROOT_MENU_CODE', '', '*', 'S', '1005', 'N', 'Y', '', '', '', '', '**ROOT_MENU_CODE', 'N'
            ,'N', '', '', '', '3', '', '', '', '', '', 'L', 'Y', '*', '', '');

Alter Table forms Enable VALIDATE Constraint forms_form_actions_fk;
Alter Table FORMS Enable All Triggers;
/*****************FORMS2*********************/
Alter Table FORMS Disable All Triggers;
Alter Table forms Disable Constraint forms_form_actions_fk;
Delete From FORM_COLUMNS
      Where form_code = 'FORMS2';
Delete From FORM_COLUMNS$
      Where form_code = 'FORMS2';
Delete From FORM_ACTIONS
      Where form_code = 'FORMS2';
Delete From FORM_TABS
      Where form_code = 'FORMS2';
Delete From FORMS
      Where form_code = 'FORMS2';
/*  Form: FORMS2. Entity: FORMS.  */

Insert Into FORMS
            ("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID"
            ,"FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR"
            ,"OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH", "DESCRIPTION", "DOUBLE_CLICK_ACTION_CODE", "LOOKUP_WIDTH"
            ,"APPS_CODE", "EXPORT_ORDER")
     Values ('FORMS2', 'shift+alt+ctrl+f'
            ,'Select t.*, DECODE (child_count, 0, 0, 1) is_folder, NVL (t.parent_code, t.code) form_code_for_filter
      ,DECODE (entity_type
              ,''DATA'', ''FORMS''
              ,''COLUMNS'', ''FORM_COLUMNS''
              ,''TABS'', ''FORM_TABS''
              ,''ACTIONS'', ''FORM_ACTIONS''
----              ,''FORM'', t.code
              ) detail_form
      ,DECODE (entity_type, ''FORM'', t.code) detail_form_multi
  From (Select ''FORM'' entity_type, Null parent_code, a.form_code code, NVL (a.form_name, a.form_code) user_name
              ,a.icon_id, 1 child_count, a.description
          From &fc_schema_owner..forms_v a
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
            ,'Конструктор форм', 'T', 'Y', '28', '20%', '*', '', '', 'Y', '153', '*', '', '', '', 'FC', '100');
/*  Form: FORMS2. Entity: FORM_TABS.  */

Insert Into FORM_TABS
            ("FORM_CODE", "TAB_CODE", "CHILD_FORM_CODE", "TAB_POSITION", "TAB_NAME", "NUMBER_OF_COLUMNS", "ICON_ID"
            ,"TAB_TYPE", "TAB_DISPLAY_NUMBER")
     Values ('FORMS2', 'RDET', '', 'R', '', '', '', '3', '');

Insert Into FORM_TABS
            ("FORM_CODE", "TAB_CODE", "CHILD_FORM_CODE", "TAB_POSITION", "TAB_NAME", "NUMBER_OF_COLUMNS", "ICON_ID"
            ,"TAB_TYPE", "TAB_DISPLAY_NUMBER")
     Values ('FORMS2', 'SETUP', '', 'R', 'Настройка', '', '18', '3', '');
/*  Form: FORMS2. Entity: FORM_ACTIONS.  */

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('FORMS2', 'DEL', '&fc_schema_owner..FORMS2_PKG.P_DELETE', 'Удалить', '48', '', '', '3', '130'
            ,'Вы уверенны что хотите удалить запись?', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('FORMS2', 'EDIT', '', 'Редактировать', '50', '', '', '8', '115', 'Вы уверенны?', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('FORMS2', 'INS', '', 'Создать', '47', '', '', '1', '110', '', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('FORMS2', 'REFR', '', 'Обновить', '15', '', '', '4', '10', '', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('FORMS2', 'UPD', '&fc_schema_owner..FORMS2_PKG.P_INSERT', 'Сохранить', '46', '', '', '2', '120'
            ,'Вы уверенны?', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('FORMS2', 'АДЕК', '', 'Фильтр', '25', '', '', '9', '190', 'Вы уверенны?', '', 'N', 'Y', '');
/*  Form: FORMS2. Entity: FORM_COLUMNS$.  */

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('6', 'NUMBER', '2', 'CHILD_COUNT', '11', '0', '-127', 'FORMS2', '', '*'
            ,'*5 - Количество дочерних элементов у текущего узла (0 - ветвь не имеет подэлементов);');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('3', 'VARCHAR2', '1020', 'CODE', '4', '0', '0', 'FORMS2', '', '*', '*Наименование');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('7', 'CLOB', '4000', 'DESCRIPTION', '11', '0', '0', 'FORMS2', '', '*', '*Description of the subscription');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('10', 'VARCHAR2', '12', 'DETAIL_FORM', '11', '0', '0', 'FORMS2', '', '*', '**DETAIL_FORM');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('11', 'VARCHAR2', '1020', 'DETAIL_FORM_MULTI', '17', '0', '0', 'FORMS2', '', '*', '**DETAIL_FORM_MULTI');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('1', 'VARCHAR2', '28', 'ENTITY_TYPE', '11', '0', '0', 'FORMS2', '', '*', '**ENTITY_TYPE');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('9', 'VARCHAR2', '2000', 'FORM_CODE_FOR_FILTER', '20', '0', '0', 'FORMS2', '', '*'
            ,'**FORM_CODE_FOR_FILTER');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('5', 'NUMBER', '22', 'ICON_ID', '7', '0', '-127', 'FORMS2', '', '*', '**ICON_ID');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('8', 'NUMBER', '2', 'IS_FOLDER', '9', '0', '0', 'FORMS2', '', '*', '**IS_FOLDER');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('2', 'VARCHAR2', '2000', 'PARENT_CODE', '11', '0', '0', 'FORMS2', '', '*', '**PARENT_CODE');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('4', 'VARCHAR2', '1020', 'USER_NAME', '9', '0', '0', 'FORMS2', '', '*', '** Для всех пользователей');
/*  Form: FORMS2. Entity: FORM_COLUMNS.  */

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORMS2', 'CHILD_COUNT', '', '*', 'S', '1006', 'N', 'N', '', '', '', '', '**CHILD_COUNT', 'N', 'N', '', ''
            ,'', '', '', '', '', '', '', '', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORMS2', 'CODE', '', '0%', 'S', '1003', 'Y', 'N', '', '1', '', '', '**CODE', 'N', 'N', '', '', '', '', ''
            ,'', '', '', '', '', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORMS2', 'DESCRIPTION', 'Описание', '0%', 'S', '2', 'N', 'N', '', '', '', '5'
            ,'*Description of the subscription', 'N', 'N', '', 'USER_NAME', '200', '', '', '', '', '', '', '', 'Y', '*'
            ,'', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORMS2', 'DETAIL_FORM', '', '*', 'S', '1009', 'N', 'N', '', '', 'SETUP', '1', '**DETAIL_FORM', 'N', 'N'
            ,'', '', '', '', '', '', '', '', '', '', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORMS2', 'DETAIL_FORM_MULTI', 'Просмотр формы', '*', 'S', '1010', 'N', 'N', '', '', 'RDET', '2'
            ,'**DETAIL_FORM_MULTI', 'N', 'N', '', '', '', '', '', '', '', '', '', '', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORMS2', 'ENTITY_TYPE', 'ss3', '0%', 'S', '1001', 'N', 'N', '', '', '', '', '**ENTITY_TYPE', 'N', 'N', ''
            ,'', '', '', '', '', '', '', '', 'L', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORMS2', 'FORM_CODE_FOR_FILTER', '', '*', 'S', '1008', 'N', 'N', '', '', '', '', '**FORM_CODE_FOR_FILTER'
            ,'N', 'N', '', '', '', '', '', '', '', '', '', '', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORMS2', 'ICON_ID', '', '*', 'S', '1005', 'N', 'N', '', '4', '', '', '**ICON_ID', 'N', 'N', '', '', ''
            ,'', '', '', '', '', '', '', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORMS2', 'IS_FOLDER', '', '*', 'B', '1007', 'N', 'N', '', '3', '', '', '**IS_FOLDER', 'N', 'N', '', ''
            ,'', '', '', '', '', '', '', '', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORMS2', 'PARENT_CODE', '', '0%', 'S', '1002', 'N', 'N', '', '2', '', '', '**PARENT_CODE', 'N', 'N', ''
            ,'', '', '', '', '', '', '', '', '', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORMS2', 'USER_NAME', 'Список форм', '*', 'S', '1', 'N', 'Y', '', '', '', '6'
            ,'** Для всех пользователей', 'N', 'Y', '', 'DESCRIPTION', '', '', '', '', '', '1', '', '', 'Y', '*', ''
            ,'');

Alter Table forms Enable VALIDATE Constraint forms_form_actions_fk;
Alter Table FORMS Enable All Triggers;
/*****************MENUS*********************/
Alter Table FORMS Disable All Triggers;
Alter Table forms Disable Constraint forms_form_actions_fk;
Delete From FORM_COLUMNS
      Where form_code = 'MENUS';
Delete From FORM_COLUMNS$
      Where form_code = 'MENUS';
Delete From FORM_ACTIONS
      Where form_code = 'MENUS';
Delete From FORM_TABS
      Where form_code = 'MENUS';
Delete From FORMS
      Where form_code = 'MENUS';
/*  Form: MENUS. Entity: FORMS.  */

Insert Into FORMS
            ("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID"
            ,"FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR"
            ,"OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH", "DESCRIPTION", "DOUBLE_CLICK_ACTION_CODE", "LOOKUP_WIDTH"
            ,"APPS_CODE", "EXPORT_ORDER")
     Values ('MENUS', 'Ctrl+Alt+Shift+K'
            ,'select * from table(&fc_schema_owner..menus_pkg.p_get_menu_tree(:menu_code,:element_type,:form_display))
------------'
            ,'Конструктор', 'T', 'Y', '28', '25%', '*', '', 'T', 'N', '295', '*', '', '', '', 'FC', '100');
/*  Form: MENUS. Entity: FORM_TABS.  */

Insert Into FORM_TABS
            ("FORM_CODE", "TAB_CODE", "CHILD_FORM_CODE", "TAB_POSITION", "TAB_NAME", "NUMBER_OF_COLUMNS", "ICON_ID"
            ,"TAB_TYPE", "TAB_DISPLAY_NUMBER")
     Values ('MENUS', 'DET', '', 'R', '', '', '', '3', '3');

Insert Into FORM_TABS
            ("FORM_CODE", "TAB_CODE", "CHILD_FORM_CODE", "TAB_POSITION", "TAB_NAME", "NUMBER_OF_COLUMNS", "ICON_ID"
            ,"TAB_TYPE", "TAB_DISPLAY_NUMBER")
     Values ('MENUS', 'FORMS', '', 'R', '', '', '', '3', '2');

Insert Into FORM_TABS
            ("FORM_CODE", "TAB_CODE", "CHILD_FORM_CODE", "TAB_POSITION", "TAB_NAME", "NUMBER_OF_COLUMNS", "ICON_ID"
            ,"TAB_TYPE", "TAB_DISPLAY_NUMBER")
     Values ('MENUS', 'SETTINGS', '', 'R', 'Настройка', '', '16', '3', '1');
/*  Form: MENUS. Entity: FORM_ACTIONS.  */

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('MENUS', 'DEL', '&fc_schema_owner..MENUS_PKG.P_DELETE_MENU', 'Папка', '48', '', '', '3', '130'
            ,'Вы уверенны что хотите удалить запись?', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('MENUS', 'DELFORM', '&fc_schema_owner..MENUS_PKG.P_DELETE_FORM', 'Форма', '48', '', '', '3', '130'
            ,'Вы уверенны что хотите удалить запись?', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('MENUS', 'EDIT', '', 'Редактировать', '50', '', '', '8', '115', 'Вы уверенны?', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('MENUS', 'INS', '', 'Создать', '47', '', '', '1', '110', '', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('MENUS', 'INSSIBL', '&fc_schema_owner..MENUS_PKG.P_INS_SIBL', 'Брат', '47', '', '', '7', '112'
            ,'Вы уверенны?', '', 'Y', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('MENUS', 'INSUPD', '&fc_schema_owner..MENUS_PKG.P_INS_CHLD', 'Дочка', '47', '', '', '7', '111'
            ,'Вы уверенны?', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('MENUS', 'REFR', '', 'Обновить', '15', '', '', '4', '10', '', 'Alt+R', 'Y', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('MENUS', 'UPD', '&fc_schema_owner..MENUS_PKG.P_UPDATE', 'Сохранить', '46', '', '', '2', '120'
            ,'Вы уверенны?', '', 'Y', 'Y', '');
/*  Form: MENUS. Entity: FORM_COLUMNS$.  */

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('11', 'VARCHAR2', '400', 'ELEMENT_TYPE', '12', '0', '0', 'MENUS', '', '*', '**ELEMENT_TYPE');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('12', 'VARCHAR2', '1020', 'FORM_CODE_FOR_FILTER', '20', '0', '0', 'MENUS', '', '*'
            ,'**FORM_CODE_FOR_FILTER');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('6', 'VARCHAR2', '1020', 'FORM_DISPLAY', '12', '0', '0', 'MENUS', '', '*', '**FORM_DISPLAY');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('7', 'VARCHAR2', '1020', 'FORM_DISPLAY_STAT', '17', '0', '0', 'MENUS', '', '*', '**FORM_DISPLAY_STAT');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('9', 'NUMBER', '22', 'ICON_ID', '7', '0', '0', 'MENUS', '', '*', '**ICON_ID');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('10', 'NUMBER', '22', 'IS_FOLDER', '9', '0', '0', 'MENUS', '', '*', '**IS_FOLDER');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('1', 'VARCHAR2', '1020', 'MENU_CODE', '9', '0', '0', 'MENUS', 'Y', '*', '*Код меню');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('5', 'VARCHAR2', '1020', 'MENU_FORM_CODE', '14', '0', '0', 'MENUS', '', '*'
            ,'*Ссылка на форму (для конечных узлов)');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('2', 'VARCHAR2', '1020', 'MENU_NAME', '9', '0', '0', 'MENUS', '', '*'
            ,'*Пользовательское наименование меню');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('8', 'NUMBER', '22', 'MENU_POSITION', '13', '0', '0', 'MENUS', '', '*'
            ,'*Позиция пунктов на одном уровне. Если не указано - то сначала нумерованные, потом по наименованию');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('4', 'VARCHAR2', '1020', 'PARENT_DISPLAY', '14', '0', '0', 'MENUS', '', '*', '**PARENT_DISPLAY');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('3', 'VARCHAR2', '1020', 'PARENT_MENU_CODE', '16', '0', '0', 'MENUS', '', '*'
            ,'*Ссылка на пункт меню-родитель');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('13', 'VARCHAR2', '4', 'SHOW_IN_NAVIGATOR', '17', '0', '0', 'MENUS', '', '*', '*Показывать в навигаторе');
/*  Form: MENUS. Entity: FORM_COLUMNS.  */

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('MENUS', 'ELEMENT_TYPE', '', '*', 'S', '1010', 'N', 'N', '', '', '', '8', '**ELEMENT_TYPE', 'N', 'N'
            ,'FORMS.EDITOR_POSITION', '', '', '', '', '', '', '', '', 'L', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('MENUS', 'FORM_CODE_FOR_FILTER', 'Колонка для фильтра', '100', 'S', '7', 'N', 'Y', '', '', '', ''
            ,'**FORM_CODE_FOR_FILTER', 'N', 'N', '', '', '', '', '', '', '', '', '', 'L', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('MENUS', 'FORM_DISPLAY', '', '*', 'S', '9', 'N', 'N', '', '', 'DET', '2', '**FORM_DISPLAY', 'N', 'N', ''
            ,'', '', '', '', '', '', '', '', 'L', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('MENUS', 'FORM_DISPLAY_STAT', '', '*', 'S', '10', 'N', 'N', '', '', 'SETTINGS', '1', '**FORM_DISPLAY_STAT'
            ,'N', 'N', '', '', '', '', '', '', '', '', 'FORM_DISPLAY_STAT', 'L', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('MENUS', 'ICON_ID', '', '*', 'N', '66', 'N', 'N', '', '4', '', '', '**ICON_ID', 'N', 'N', '', '', '', ''
            ,'', '', '', '', '', 'L', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('MENUS', 'IS_FOLDER', '', '*', 'B', '9', 'N', 'N', '', '3', '', '', '**IS_FOLDER', 'N', 'N', '', '', ''
            ,'', '', '', '', '', '', 'L', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('MENUS', 'MENU_CODE', 'Код меню', '150', 'S', '4', 'Y', 'Y', '', '1', '', '6', '*Код меню', 'N', 'N', ''
            ,'', '', '1', '', '', '', '', '', '', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('MENUS', 'MENU_FORM_CODE', 'Форма', '200', 'S', '3', 'N', 'Y', '', '', 'FORMS', '9'
            ,'*Ссылка на форму (для конечных узлов)', 'N', 'N', 'FORMS_LIST', '', '', '', '', '', '', '', '', 'L', 'Y'
            ,'*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('MENUS', 'MENU_NAME', 'Имяs', '200', 'S', '2', 'N', 'Y', '', '', '', ''
            ,'*Пользовательское наименование меню', 'N', 'N', '', '', '', '', '', '', '', '1', '', 'L', 'Y', '*', ''
            ,'');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('MENUS', 'MENU_POSITION', 'Позиция в узле', '100', 'N', '6', 'N', 'Y', '', '', '', ''
            ,'*Позиция пунктов на одном уровне. Если не указано - то сначала нумерованные, потом по наименованию', 'N'
            ,'N', '', '', '', '', '', '', '', '1', '', 'L', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('MENUS', 'PARENT_DISPLAY', 'Родитель', '100', 'S', '5', 'N', 'Y', '', '', '', '', '**PARENT_DISPLAY', 'N'
            ,'N', '', '', '', '', '', '', '', '', '', '', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('MENUS', 'PARENT_MENU_CODE', 'Ссылка на пункт меню-родитель', '*', 'S', '9', 'N', 'Y', '', '2', '', ''
            ,'*Ссылка на пункт меню-родитель', 'N', 'N', '', '', '', '', '', '', '', '', '', 'L', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('MENUS', 'SHOW_IN_NAVIGATOR', 'Показывать в навигаторе', '150', 'B', '7', 'N', 'Y', '', '', '', ''
            ,'*Показывать в навигаторе', 'N', 'N', '', '', '', '', '', '', '', '', '', '', 'Y', '*', '', '');

Alter Table forms Enable VALIDATE Constraint forms_form_actions_fk;
Alter Table FORMS Enable All Triggers;

