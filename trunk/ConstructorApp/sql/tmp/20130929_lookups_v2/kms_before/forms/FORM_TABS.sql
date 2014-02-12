
Alter Table FORMS Disable All Triggers;
Alter Table forms Disable Constraint forms_form_actions_fk;
Delete From APPS_PRIVS
      Where form_code = 'FORM_TABS';
Delete From FORM_TAB_CHILDS_ALLOWED
      Where form_code = 'FORM_TABS';
Delete From FORM_TAB_PARENT_EXCLNS
      Where form_code = 'FORM_TABS';
Delete From FORM_COLUMN_ATTR_VALS
      Where form_code = 'FORM_TABS';
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
            ,"APPS_CODE", "EXPORT_ORDER", "LOOKUP_HEIGHT", "DRAGDROP_ACTION_CODE", "DATA_PAGE_SIZE")
     Values ('FORM_TABS', 'shift+alt+ctrl+a'
            ,'Select *
  From &fc_schema_owner..form_tabs a
 Where DECODE (:p_$master_form_code, ''FORMS'', :form_code, ''FORMS2'', :form_code_for_filter,''MENUS'',:form_code, a.form_code) = a.form_code
   and DECODE (:p_$master_form_code, ''MENUS'',NVL(:tab_code, a.tab_code), a.tab_code) = a.tab_code
'
            ,'Детальная Вкладки', 'G', 'Y', '4', '*', '*', '', '', 'Y', '82', '*', '', '', '', 'FC', '10', '', '', '');
/*  Form: FORM_TABS. Entity: FORM_TABS.  */

Insert Into FORM_TABS
            ("FORM_CODE", "TAB_CODE", "CHILD_FORM_CODE", "TAB_POSITION", "TAB_NAME", "NUMBER_OF_COLUMNS", "ICON_ID"
            ,"TAB_TYPE", "TAB_DISPLAY_NUMBER")
     Values ('FORM_TABS', 'DYN_CHLD_FORMS', 'FORM_TAB_CHILDS_ALLOWED', 'B', '', '', '13', '2', '20');

Insert Into FORM_TABS
            ("FORM_CODE", "TAB_CODE", "CHILD_FORM_CODE", "TAB_POSITION", "TAB_NAME", "NUMBER_OF_COLUMNS", "ICON_ID"
            ,"TAB_TYPE", "TAB_DISPLAY_NUMBER")
     Values ('FORM_TABS', 'EXCL', 'FORM_TAB_PARENT_EXCLNS', 'B', 'Исключение вкладок', '', '13', '2', '10');

Insert Into FORM_TABS
            ("FORM_CODE", "TAB_CODE", "CHILD_FORM_CODE", "TAB_POSITION", "TAB_NAME", "NUMBER_OF_COLUMNS", "ICON_ID"
            ,"TAB_TYPE", "TAB_DISPLAY_NUMBER")
     Values ('FORM_TABS', 'TAB_COLUMNS', 'FORM_COLUMNS', 'B', '', '', '13', '2', '30');
/*  Form: FORM_TABS. Entity: FORM_ACTIONS.  */

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT", "PARENT_ACTION_CODE"
            ,"DISPLAY_IN_CONTEXT_MENU", "AUTOCOMMIT", "STATUS_BUTTON_PARAM", "STATUS_MSG_LEVEL_PARAM"
            ,"STATUS_MSG_TXT_PARAM")
     Values ('FORM_TABS', 'DEL', '&fc_schema_owner..FORM_TABS_PKG.p_delete', 'Удалить', '48', '', '', '3', '130'
            ,'Вы уверены что хотите удалить запись?', '', 'N', 'Y', '', '', '', 'Y', 'Y', '', '', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT", "PARENT_ACTION_CODE"
            ,"DISPLAY_IN_CONTEXT_MENU", "AUTOCOMMIT", "STATUS_BUTTON_PARAM", "STATUS_MSG_LEVEL_PARAM"
            ,"STATUS_MSG_TXT_PARAM")
     Values ('FORM_TABS', 'EDIT', '', 'Редактировать', '50', '', '', '8', '115', 'Вы уверены?', '', 'N', 'Y', '', ''
            ,'', 'Y', 'Y', '', '', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT", "PARENT_ACTION_CODE"
            ,"DISPLAY_IN_CONTEXT_MENU", "AUTOCOMMIT", "STATUS_BUTTON_PARAM", "STATUS_MSG_LEVEL_PARAM"
            ,"STATUS_MSG_TXT_PARAM")
     Values ('FORM_TABS', 'INS', '', 'Создать', '47', '', '', '1', '110', '', '', 'N', 'Y', '', '', '', 'Y', 'Y', ''
            ,'', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT", "PARENT_ACTION_CODE"
            ,"DISPLAY_IN_CONTEXT_MENU", "AUTOCOMMIT", "STATUS_BUTTON_PARAM", "STATUS_MSG_LEVEL_PARAM"
            ,"STATUS_MSG_TXT_PARAM")
     Values ('FORM_TABS', 'REFR', '', 'Обновить', '15', '', '', '4', '10', '', '', 'N', 'Y', '', '', '', 'Y', 'Y', ''
            ,'', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT", "PARENT_ACTION_CODE"
            ,"DISPLAY_IN_CONTEXT_MENU", "AUTOCOMMIT", "STATUS_BUTTON_PARAM", "STATUS_MSG_LEVEL_PARAM"
            ,"STATUS_MSG_TXT_PARAM")
     Values ('FORM_TABS', 'UPD', '&fc_schema_owner..FORM_TABS_PKG.p_ins_upd', 'Сохранить', '46', '', '', '2', '120'
            ,'Вы уверены?', '', 'N', 'Y', '', '', '', 'Y', 'Y', '', '', '');
/*  Form: FORM_TABS. Entity: FORM_COLUMNS$.  */

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('3', 'VARCHAR2', '1020', 'CHILD_FORM_CODE', '15', '0', '0', 'FORM_TABS', '', '*'
            ,'*????? ???????? ????? ? ????? ????/????');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('1', 'VARCHAR2', '1020', 'FORM_CODE', '9', '0', '0', 'FORM_TABS', 'Y', '*', '*??? ?????');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('7', 'NUMBER', '22', 'ICON_ID', '7', '0', '-127', 'FORM_TABS', '', '*', '**ICON_ID');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('6', 'NUMBER', '22', 'NUMBER_OF_COLUMNS', '17', '0', '-127', 'FORM_TABS', '', '*'
            ,'*??. com.smartgwt.client.widgets.form.DynamicForm   setNumCols');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('2', 'VARCHAR2', '1020', 'TAB_CODE', '8', '0', '0', 'FORM_TABS', 'Y', '*', '*????????????? ????????');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('9', 'NUMBER', '22', 'TAB_DISPLAY_NUMBER', '18', '0', '-127', 'FORM_TABS', '', '*', '*??????? ??????????');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('5', 'VARCHAR2', '1020', 'TAB_NAME', '8', '0', '0', 'FORM_TABS', '', '*', '*???????????????? ??? ????????');

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
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT")
     Values ('FORM_TABS', 'CHILD_FORM_CODE', 'Дочерняя форма', '*', 'S', '1003', 'N', 'Y', '', '', '', '9'
            ,'**CHILD_FORM_CODE', 'N', 'N', 'FORMS_LIST', '', '', '', '', '', '', '', '', '', 'Y', '*', '', '', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT")
     Values ('FORM_TABS', 'FORM_CODE', 'Код формы', '*', 'S', '1001', 'Y', 'N', '', '1', '', '', '*Идентификатор форм'
            ,'N', 'N', '', '', '', '1', '', '', '', '', ':form_code', 'L', 'Y', '*', '', '', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT")
     Values ('FORM_TABS', 'ICON_ID', 'Иконка', '*', 'N', '1007', 'N', 'Y', '', '', '', '9', '**ICON_ID', 'N', 'N'
            ,'ICONS', '', '', '', '', '', '', '', '', '', 'Y', '*', '', '', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT")
     Values ('FORM_TABS', 'NUMBER_OF_COLUMNS', 'Количество колонок', '*', 'N', '1006', 'N', 'Y', '', '', '', ''
            ,'*см. com.smartgwt.client.widgets.form.DynamicForm   setNumCols', 'N', 'N', '', '', '', '', '', '', '', ''
            ,'', '', 'Y', '*', '', '', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT")
     Values ('FORM_TABS', 'TAB_CODE', 'Код закладки', '*', 'S', '1002', 'Y', 'Y', '', '1', '', ''
            ,'*Идентификатор закладки', 'N', 'N', '', '', '', '1', '', '', '', '', '', '', 'Y', '*', '', '', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT")
     Values ('FORM_TABS', 'TAB_DISPLAY_NUMBER', 'Порядок сортировки', '*', 'N', '1009', 'N', 'Y', '', '', '', ''
            ,'*??????? ??????????', 'N', 'N', '', '', '', '', '', '', '', '1', '', 'L', 'Y', '*', '', '', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT")
     Values ('FORM_TABS', 'TAB_NAME', 'Наименование', '*', 'S', '1005', 'N', 'Y', '', '', '', ''
            ,'*Пользовательское имя закладки', 'N', 'N', '', '', '', '2', '', '', '', '', '', '', 'Y', '*', '', '', ''
            ,'');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT")
     Values ('FORM_TABS', 'TAB_POSITION', 'Позиция', '*', 'S', '1004', 'N', 'Y', '', '', '', '8'
            ,'*Lookup FORMS.EDITOR_POSITION', 'N', 'N', 'FORMS.EDITOR_POSITION', '', '', '', '', '', '', '', '', ''
            ,'Y', '*', '', '', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT")
     Values ('FORM_TABS', 'TAB_TYPE', 'Тип закладки', '*', 'S', '1008', 'N', 'Y', '', '', '', '8', '**TAB_TYPE', 'N'
            ,'N', 'FORM_TABS.TAB_TYPE', '', '', '', '', '', '', '', '', '', 'Y', '*', '', '', '', '');
/*  Form: FORM_TABS. Entity: FORM_COLUMN_ATTR_VALS.  */
/*  Form: FORM_TABS. Entity: FORM_TAB_PARENT_EXCLNS.  */
/*  Form: FORM_TABS. Entity: FORM_TAB_CHILDS_ALLOWED.  */
/*  Form: FORM_TABS. Entity: APPS_PRIVS.  */

Insert Into APPS_PRIVS
            ("APPS_CODE", "FORM_CODE")
     Values ('SC', 'FORM_TABS');

Insert Into APPS_PRIVS
            ("APPS_CODE", "FORM_CODE")
     Values ('BF', 'FORM_TABS');

Insert Into APPS_PRIVS
            ("APPS_CODE", "FORM_CODE")
     Values ('AAHR', 'FORM_TABS');

Insert Into APPS_PRIVS
            ("APPS_CODE", "FORM_CODE")
     Values ('TC', 'FORM_TABS');

Insert Into APPS_PRIVS
            ("APPS_CODE", "FORM_CODE")
     Values ('INS', 'FORM_TABS');


Declare
   l_clob   Clob := ' ';
Begin
   Update FORMS
      Set description = l_clob
    Where form_code = 'FORM_TABS';
End;
/

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

