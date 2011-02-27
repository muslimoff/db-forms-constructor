
/*****************COLUMNS_LIST*********************/

Alter Table FORMS Disable All Triggers;
Alter Table forms Disable Constraint forms_form_actions_fk;
delete from APPS_PRIVS where form_code = 'COLUMNS_LIST';
delete from FORM_TAB_PARENT_EXCLNS where form_code = 'COLUMNS_LIST';
delete from FORM_COLUMN_ATTR_VALS where form_code = 'COLUMNS_LIST';
delete from FORM_COLUMNS where form_code = 'COLUMNS_LIST';
delete from FORM_COLUMNS$ where form_code = 'COLUMNS_LIST';
delete from FORM_ACTIONS where form_code = 'COLUMNS_LIST';
delete from FORM_TABS where form_code = 'COLUMNS_LIST';
delete from FORMS where form_code = 'COLUMNS_LIST';
/*  Form: COLUMNS_LIST. Entity: FORMS.  */

insert into FORMS("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID", "FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR", "OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH", "DESCRIPTION", "DOUBLE_CLICK_ACTION_CODE", "LOOKUP_WIDTH", "APPS_CODE", "EXPORT_ORDER") values (
'COLUMNS_LIST'
,''
,'Select   column_code, NVL (column_user_name, column_code) column_user_name
    From Table (&fc_schema_owner..form_utils.describe_form_columns_pl (:form_code))
'
,'������ �������'
,'G'
,'Y'
,'11'
,'*'
,'*'
,''
,''
,'Y'
,'10'
,'*'
,''
,''
,''
,'FC'
,'10');
/*  Form: COLUMNS_LIST. Entity: FORM_TABS.  */
/*  Form: COLUMNS_LIST. Entity: FORM_ACTIONS.  */
/*  Form: COLUMNS_LIST. Entity: FORM_COLUMNS$.  */

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'1'
,'VARCHAR2'
,'1020'
,'COLUMN_CODE'
,'11'
,'0'
,'0'
,'COLUMNS_LIST'
,''
,'*'
,'*������������� ���� (�� �������)');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'2'
,'VARCHAR2'
,'1020'
,'COLUMN_USER_NAME'
,'16'
,'0'
,'0'
,'COLUMNS_LIST'
,''
,'*'
,'*���������������� ��� ����');
/*  Form: COLUMNS_LIST. Entity: FORM_COLUMNS.  */

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'COLUMNS_LIST'
,'COLUMN_CODE'
,''
,'*'
,'S'
,'1001'
,'N'
,'Y'
,''
,''
,''
,''
,'*������������� ���� (�� �������)'
,'N'
,'N'
,''
,''
,''
,'1'
,''
,''
,''
,''
,''
,''
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'COLUMNS_LIST'
,'COLUMN_USER_NAME'
,''
,'*'
,'S'
,'1002'
,'N'
,'Y'
,''
,''
,''
,''
,'*���������������� ��� ����'
,'N'
,'N'
,''
,''
,''
,'2'
,''
,''
,''
,''
,''
,''
,'Y'
,'*'
,''
,'');
/*  Form: COLUMNS_LIST. Entity: FORM_COLUMN_ATTR_VALS.  */
/*  Form: COLUMNS_LIST. Entity: FORM_TAB_PARENT_EXCLNS.  */
/*  Form: COLUMNS_LIST. Entity: APPS_PRIVS.  */

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'SC'
,'COLUMNS_LIST');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'BF'
,'COLUMNS_LIST');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'AAHR'
,'COLUMNS_LIST');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'TC'
,'COLUMNS_LIST');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'INS'
,'COLUMNS_LIST');



Alter Table forms Enable VALIDATE Constraint forms_form_actions_fk;
Alter Table FORMS Enable All Triggers;

/*****************DBLCLICK_FORM_ACT_LIST*********************/

Alter Table FORMS Disable All Triggers;
Alter Table forms Disable Constraint forms_form_actions_fk;
delete from APPS_PRIVS where form_code = 'DBLCLICK_FORM_ACT_LIST';
delete from FORM_TAB_PARENT_EXCLNS where form_code = 'DBLCLICK_FORM_ACT_LIST';
delete from FORM_COLUMN_ATTR_VALS where form_code = 'DBLCLICK_FORM_ACT_LIST';
delete from FORM_COLUMNS where form_code = 'DBLCLICK_FORM_ACT_LIST';
delete from FORM_COLUMNS$ where form_code = 'DBLCLICK_FORM_ACT_LIST';
delete from FORM_ACTIONS where form_code = 'DBLCLICK_FORM_ACT_LIST';
delete from FORM_TABS where form_code = 'DBLCLICK_FORM_ACT_LIST';
delete from FORMS where form_code = 'DBLCLICK_FORM_ACT_LIST';
/*  Form: DBLCLICK_FORM_ACT_LIST. Entity: FORMS.  */

insert into FORMS("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID", "FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR", "OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH", "DESCRIPTION", "DOUBLE_CLICK_ACTION_CODE", "LOOKUP_WIDTH", "APPS_CODE", "EXPORT_ORDER") values (
'DBLCLICK_FORM_ACT_LIST'
,''
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
,'������ �������� (��.������)'
,'G'
,'Y'
,'11'
,'*'
,'*'
,''
,''
,'Y'
,'12'
,'*'
,''
,''
,''
,'FC'
,'10');
/*  Form: DBLCLICK_FORM_ACT_LIST. Entity: FORM_TABS.  */
/*  Form: DBLCLICK_FORM_ACT_LIST. Entity: FORM_ACTIONS.  */

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'DBLCLICK_FORM_ACT_LIST'
,'REFR'
,''
,'��������'
,'15'
,''
,''
,'4'
,'10'
,''
,''
,'N'
,'Y'
,''
,'');
/*  Form: DBLCLICK_FORM_ACT_LIST. Entity: FORM_COLUMNS$.  */

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'1'
,'VARCHAR2'
,'1020'
,'ACTION_CODE'
,'11'
,'0'
,'0'
,'DBLCLICK_FORM_ACT_LIST'
,''
,'*'
,'**ACTION_CODE');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'2'
,'VARCHAR2'
,'1020'
,'ACTION_DISPLAY_NAME'
,'19'
,'0'
,'0'
,'DBLCLICK_FORM_ACT_LIST'
,''
,'*'
,'**ACTION_DISPLAY_NAME');
/*  Form: DBLCLICK_FORM_ACT_LIST. Entity: FORM_COLUMNS.  */

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'DBLCLICK_FORM_ACT_LIST'
,'ACTION_CODE'
,'���'
,'*'
,'S'
,'1001'
,'N'
,'Y'
,''
,''
,''
,''
,'**ACTION_CODE'
,'N'
,'N'
,''
,''
,''
,'1'
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'DBLCLICK_FORM_ACT_LIST'
,'ACTION_DISPLAY_NAME'
,'������������'
,'*'
,'S'
,'1002'
,'N'
,'Y'
,''
,''
,''
,''
,'**ACTION_DISPLAY_NAME'
,'N'
,'N'
,''
,''
,''
,'2'
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');
/*  Form: DBLCLICK_FORM_ACT_LIST. Entity: FORM_COLUMN_ATTR_VALS.  */
/*  Form: DBLCLICK_FORM_ACT_LIST. Entity: FORM_TAB_PARENT_EXCLNS.  */
/*  Form: DBLCLICK_FORM_ACT_LIST. Entity: APPS_PRIVS.  */

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'SC'
,'DBLCLICK_FORM_ACT_LIST');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'TC'
,'DBLCLICK_FORM_ACT_LIST');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'AAHR'
,'DBLCLICK_FORM_ACT_LIST');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'INS'
,'DBLCLICK_FORM_ACT_LIST');



Alter Table forms Enable VALIDATE Constraint forms_form_actions_fk;
Alter Table FORMS Enable All Triggers;

/*****************FORMS_LIST*********************/

Alter Table FORMS Disable All Triggers;
Alter Table forms Disable Constraint forms_form_actions_fk;
delete from APPS_PRIVS where form_code = 'FORMS_LIST';
delete from FORM_TAB_PARENT_EXCLNS where form_code = 'FORMS_LIST';
delete from FORM_COLUMN_ATTR_VALS where form_code = 'FORMS_LIST';
delete from FORM_COLUMNS where form_code = 'FORMS_LIST';
delete from FORM_COLUMNS$ where form_code = 'FORMS_LIST';
delete from FORM_ACTIONS where form_code = 'FORMS_LIST';
delete from FORM_TABS where form_code = 'FORMS_LIST';
delete from FORMS where form_code = 'FORMS_LIST';
/*  Form: FORMS_LIST. Entity: FORMS.  */

insert into FORMS("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID", "FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR", "OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH", "DESCRIPTION", "DOUBLE_CLICK_ACTION_CODE", "LOOKUP_WIDTH", "APPS_CODE", "EXPORT_ORDER") values (
'FORMS_LIST'
,''
,'Select a.form_code, NVL (a.form_name, a.form_code) form_name, a.hot_key, a.icon_id
  From &fc_schema_owner..forms_v a'
,'������ �����'
,'G'
,'Y'
,'11'
,'*'
,'*'
,''
,''
,'Y'
,'23'
,'*'
,''
,''
,'250'
,'FC'
,'10');
/*  Form: FORMS_LIST. Entity: FORM_TABS.  */
/*  Form: FORMS_LIST. Entity: FORM_ACTIONS.  */
/*  Form: FORMS_LIST. Entity: FORM_COLUMNS$.  */

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'1'
,'VARCHAR2'
,'1020'
,'FORM_CODE'
,'9'
,'0'
,'0'
,'FORMS_LIST'
,''
,'*'
,'*������������� ����');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'2'
,'VARCHAR2'
,'1020'
,'FORM_NAME'
,'9'
,'0'
,'0'
,'FORMS_LIST'
,''
,'*'
,'*��� ����� ��� ������������');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'3'
,'VARCHAR2'
,'400'
,'HOT_KEY'
,'7'
,'0'
,'0'
,'FORMS_LIST'
,''
,'*'
,'*������� �������  - ������ ���� [Ctrl+][Alt+][Shift+]Chr. ������� �� �����');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'4'
,'NUMBER'
,'22'
,'ICON_ID'
,'7'
,'0'
,'-127'
,'FORMS_LIST'
,''
,'*'
,'**ICON_ID');
/*  Form: FORMS_LIST. Entity: FORM_COLUMNS.  */

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORMS_LIST'
,'FORM_CODE'
,''
,'*'
,'S'
,'1001'
,'N'
,'N'
,''
,''
,''
,''
,'*������������� ����'
,'N'
,'N'
,''
,''
,''
,'1'
,''
,''
,''
,''
,''
,''
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORMS_LIST'
,'FORM_NAME'
,'�����'
,'*'
,'S'
,'1002'
,'N'
,'Y'
,''
,''
,''
,''
,'*��� ����� ��� ������������'
,'N'
,'N'
,''
,''
,''
,'2'
,''
,''
,''
,''
,''
,''
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORMS_LIST'
,'HOT_KEY'
,''
,'*'
,'S'
,'1003'
,'N'
,'N'
,''
,''
,''
,''
,'*������� �������  - ������ ���� [Ctrl+][Alt+][Shift+]Chr. ������� �� �����'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORMS_LIST'
,'ICON_ID'
,'Icon'
,'20%'
,'N'
,'5'
,'N'
,'Y'
,''
,''
,''
,'3'
,'**ICON_ID'
,'N'
,'N'
,''
,''
,''
,'3'
,''
,''
,''
,''
,''
,''
,'Y'
,'*'
,''
,'');
/*  Form: FORMS_LIST. Entity: FORM_COLUMN_ATTR_VALS.  */
/*  Form: FORMS_LIST. Entity: FORM_TAB_PARENT_EXCLNS.  */
/*  Form: FORMS_LIST. Entity: APPS_PRIVS.  */

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'SC'
,'FORMS_LIST');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'BF'
,'FORMS_LIST');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'AAHR'
,'FORMS_LIST');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'TC'
,'FORMS_LIST');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'INS'
,'FORMS_LIST');



Alter Table forms Enable VALIDATE Constraint forms_form_actions_fk;
Alter Table FORMS Enable All Triggers;

/*****************FORM_TABS*********************/

Alter Table FORMS Disable All Triggers;
Alter Table forms Disable Constraint forms_form_actions_fk;
delete from APPS_PRIVS where form_code = 'FORM_TABS';
delete from FORM_TAB_PARENT_EXCLNS where form_code = 'FORM_TABS';
delete from FORM_COLUMN_ATTR_VALS where form_code = 'FORM_TABS';
delete from FORM_COLUMNS where form_code = 'FORM_TABS';
delete from FORM_COLUMNS$ where form_code = 'FORM_TABS';
delete from FORM_ACTIONS where form_code = 'FORM_TABS';
delete from FORM_TABS where form_code = 'FORM_TABS';
delete from FORMS where form_code = 'FORM_TABS';
/*  Form: FORM_TABS. Entity: FORMS.  */

insert into FORMS("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID", "FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR", "OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH", "DESCRIPTION", "DOUBLE_CLICK_ACTION_CODE", "LOOKUP_WIDTH", "APPS_CODE", "EXPORT_ORDER") values (
'FORM_TABS'
,'shift+alt+ctrl+a'
,'Select *
  From &fc_schema_owner..form_tabs a
 Where DECODE (:p_$master_form_code, ''FORMS'', :form_code, ''FORMS2'', :form_code_for_filter,''MENUS'',:form_code_for_filter, a.form_code) = a.form_code
'
,'��������� �������'
,'G'
,'Y'
,'4'
,'*'
,'*'
,''
,''
,'Y'
,'70'
,'*'
,''
,''
,''
,'FC'
,'10');
/*  Form: FORM_TABS. Entity: FORM_TABS.  */

insert into FORM_TABS("FORM_CODE", "TAB_CODE", "CHILD_FORM_CODE", "TAB_POSITION", "TAB_NAME", "NUMBER_OF_COLUMNS", "ICON_ID", "TAB_TYPE", "TAB_DISPLAY_NUMBER") values (
'FORM_TABS'
,'EXCL'
,'FORM_TAB_PARENT_EXCLNS'
,'B'
,'���������� �������'
,''
,'13'
,'2'
,'');
/*  Form: FORM_TABS. Entity: FORM_ACTIONS.  */

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'FORM_TABS'
,'DEL'
,'&fc_schema_owner..FORM_TABS_PKG.p_delete'
,'�������'
,'48'
,''
,''
,'3'
,'130'
,'�� �������� ��� ������ ������� ������?'
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'FORM_TABS'
,'EDIT'
,''
,'�������������'
,'50'
,''
,''
,'8'
,'115'
,'�� ��������?'
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'FORM_TABS'
,'INS'
,''
,'�������'
,'47'
,''
,''
,'1'
,'110'
,''
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'FORM_TABS'
,'REFR'
,''
,'��������'
,'15'
,''
,''
,'4'
,'10'
,''
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'FORM_TABS'
,'UPD'
,'&fc_schema_owner..FORM_TABS_PKG.p_ins_upd'
,'���������'
,'46'
,''
,''
,'2'
,'120'
,'�� ��������?'
,''
,'N'
,'Y'
,''
,'');
/*  Form: FORM_TABS. Entity: FORM_COLUMNS$.  */

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'3'
,'VARCHAR2'
,'1020'
,'CHILD_FORM_CODE'
,'15'
,'0'
,'0'
,'FORM_TABS'
,''
,'*'
,'*����� �������� ����� � ����� ����/����');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'1'
,'VARCHAR2'
,'1020'
,'FORM_CODE'
,'9'
,'0'
,'0'
,'FORM_TABS'
,'Y'
,'*'
,'*������������� ����');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'7'
,'NUMBER'
,'22'
,'ICON_ID'
,'7'
,'0'
,'-127'
,'FORM_TABS'
,''
,'*'
,'**ICON_ID');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'6'
,'NUMBER'
,'22'
,'NUMBER_OF_COLUMNS'
,'17'
,'0'
,'-127'
,'FORM_TABS'
,''
,'*'
,'*��. com.smartgwt.client.widgets.form.DynamicForm   setNumCols');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'2'
,'VARCHAR2'
,'1020'
,'TAB_CODE'
,'8'
,'0'
,'0'
,'FORM_TABS'
,'Y'
,'*'
,'*������������� ��������');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'9'
,'NUMBER'
,'22'
,'TAB_DISPLAY_NUMBER'
,'18'
,'0'
,'-127'
,'FORM_TABS'
,''
,'*'
,'*������� ����������');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'5'
,'VARCHAR2'
,'1020'
,'TAB_NAME'
,'8'
,'0'
,'0'
,'FORM_TABS'
,''
,'*'
,'*���������������� ��� ��������');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'4'
,'VARCHAR2'
,'4'
,'TAB_POSITION'
,'12'
,'0'
,'0'
,'FORM_TABS'
,''
,'*'
,'*Lookup FORMS.EDITOR_POSITION');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'8'
,'VARCHAR2'
,'8'
,'TAB_TYPE'
,'8'
,'0'
,'0'
,'FORM_TABS'
,''
,'*'
,'**TAB_TYPE');
/*  Form: FORM_TABS. Entity: FORM_COLUMNS.  */

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_TABS'
,'CHILD_FORM_CODE'
,'�������� �����'
,'*'
,'S'
,'1003'
,'N'
,'Y'
,''
,''
,''
,'9'
,'**CHILD_FORM_CODE'
,'N'
,'N'
,'FORMS_LIST'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_TABS'
,'FORM_CODE'
,'��� �����'
,'*'
,'S'
,'1001'
,'Y'
,'N'
,''
,'1'
,''
,''
,'*������������� ����'
,'N'
,'N'
,''
,''
,''
,'1'
,''
,''
,''
,''
,':form_code_for_filter'
,''
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_TABS'
,'ICON_ID'
,'������'
,'*'
,'N'
,'1007'
,'N'
,'Y'
,''
,''
,''
,'9'
,'**ICON_ID'
,'N'
,'N'
,'ICONS'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_TABS'
,'NUMBER_OF_COLUMNS'
,'���������� �������'
,'*'
,'N'
,'1006'
,'N'
,'Y'
,''
,''
,''
,''
,'*��. com.smartgwt.client.widgets.form.DynamicForm   setNumCols'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_TABS'
,'TAB_CODE'
,'��� ��������'
,'*'
,'S'
,'1002'
,'Y'
,'Y'
,''
,'1'
,''
,''
,'*������������� ��������'
,'N'
,'N'
,''
,''
,''
,'1'
,''
,''
,''
,''
,''
,''
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_TABS'
,'TAB_NAME'
,'������������'
,'*'
,'S'
,'1005'
,'N'
,'Y'
,''
,''
,''
,''
,'*���������������� ��� ��������'
,'N'
,'N'
,''
,''
,''
,'2'
,''
,''
,''
,''
,''
,''
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_TABS'
,'TAB_POSITION'
,'�������'
,'*'
,'S'
,'1004'
,'N'
,'Y'
,''
,''
,''
,'8'
,'*Lookup FORMS.EDITOR_POSITION'
,'N'
,'N'
,'FORMS.EDITOR_POSITION'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_TABS'
,'TAB_TYPE'
,'��� ��������'
,'*'
,'S'
,'1008'
,'N'
,'Y'
,''
,''
,''
,'8'
,'**TAB_TYPE'
,'N'
,'N'
,'FORM_TABS.TAB_TYPE'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'Y'
,'*'
,''
,'');
/*  Form: FORM_TABS. Entity: FORM_COLUMN_ATTR_VALS.  */
/*  Form: FORM_TABS. Entity: FORM_TAB_PARENT_EXCLNS.  */
/*  Form: FORM_TABS. Entity: APPS_PRIVS.  */

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'SC'
,'FORM_TABS');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'BF'
,'FORM_TABS');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'AAHR'
,'FORM_TABS');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'TC'
,'FORM_TABS');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'INS'
,'FORM_TABS');


Declare l_clob   Clob := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>�������� �����.</b></font></span><div>�������� ���������.</div>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORM_TABS' and column_code = 'CHILD_FORM_CODE'; End;
/
Declare l_clob   Clob := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>������.</b></font></span><div>�������� ���������.</div>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORM_TABS' and column_code = 'ICON_ID'; End;
/
Declare l_clob   Clob := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>���������� �������.</b></font></span><div>�������� ���������.</div>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORM_TABS' and column_code = 'NUMBER_OF_COLUMNS'; End;
/
Declare l_clob   Clob := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>��� ��������.</b></font></span><div>�������� ���������.</div>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORM_TABS' and column_code = 'TAB_CODE'; End;
/
Declare l_clob   Clob := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>������������.</b></font></span><div>�������� ���������.</div>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORM_TABS' and column_code = 'TAB_NAME'; End;
/
Declare l_clob   Clob := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>�������.</b></font></span><div>�������� ���������.</div>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORM_TABS' and column_code = 'TAB_POSITION'; End;
/
Declare l_clob   Clob := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>��� ��������.</b></font></span><div>�������� ���������.</div>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORM_TABS' and column_code = 'TAB_TYPE'; End;
/

Alter Table forms Enable VALIDATE Constraint forms_form_actions_fk;
Alter Table FORMS Enable All Triggers;

/*****************FORM_TABS_LIST*********************/

Alter Table FORMS Disable All Triggers;
Alter Table forms Disable Constraint forms_form_actions_fk;
delete from APPS_PRIVS where form_code = 'FORM_TABS_LIST';
delete from FORM_TAB_PARENT_EXCLNS where form_code = 'FORM_TABS_LIST';
delete from FORM_COLUMN_ATTR_VALS where form_code = 'FORM_TABS_LIST';
delete from FORM_COLUMNS where form_code = 'FORM_TABS_LIST';
delete from FORM_COLUMNS$ where form_code = 'FORM_TABS_LIST';
delete from FORM_ACTIONS where form_code = 'FORM_TABS_LIST';
delete from FORM_TABS where form_code = 'FORM_TABS_LIST';
delete from FORMS where form_code = 'FORM_TABS_LIST';
/*  Form: FORM_TABS_LIST. Entity: FORMS.  */

insert into FORMS("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID", "FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR", "OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH", "DESCRIPTION", "DOUBLE_CLICK_ACTION_CODE", "LOOKUP_WIDTH", "APPS_CODE", "EXPORT_ORDER") values (
'FORM_TABS_LIST'
,''
,'Select   a.form_code, a.tab_code, NVL (a.tab_name, a.tab_code) tab_name, a.tab_type
    From &fc_schema_owner..form_tabs_v a
   Where
--a.form_code = NVL (:form_code, a.form_code)
a.form_code = :form_code
Order By a.tab_display_number
'
,'������ �������'
,'G'
,'Y'
,'11'
,'*'
,'*'
,''
,''
,'Y'
,'17'
,'*'
,''
,''
,''
,'FC'
,'10');
/*  Form: FORM_TABS_LIST. Entity: FORM_TABS.  */
/*  Form: FORM_TABS_LIST. Entity: FORM_ACTIONS.  */
/*  Form: FORM_TABS_LIST. Entity: FORM_COLUMNS$.  */

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'1'
,'VARCHAR2'
,'1020'
,'FORM_CODE'
,'9'
,'0'
,'0'
,'FORM_TABS_LIST'
,''
,'*'
,'*������������� ����');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'2'
,'VARCHAR2'
,'1020'
,'TAB_CODE'
,'8'
,'0'
,'0'
,'FORM_TABS_LIST'
,''
,'*'
,'*������������� ��������');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'3'
,'VARCHAR2'
,'1020'
,'TAB_NAME'
,'8'
,'0'
,'0'
,'FORM_TABS_LIST'
,''
,'*'
,'*���������������� ��� ��������');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'4'
,'VARCHAR2'
,'8'
,'TAB_TYPE'
,'8'
,'0'
,'0'
,'FORM_TABS_LIST'
,''
,'*'
,'**TAB_TYPE');
/*  Form: FORM_TABS_LIST. Entity: FORM_COLUMNS.  */

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_TABS_LIST'
,'FORM_CODE'
,''
,'*'
,'S'
,'1001'
,'N'
,'N'
,''
,''
,''
,''
,'*������������� ����'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_TABS_LIST'
,'TAB_CODE'
,'���'
,'*'
,'S'
,'1002'
,'N'
,'Y'
,''
,''
,''
,''
,'*������������� ��������'
,'N'
,'N'
,''
,''
,''
,'1'
,''
,''
,''
,''
,''
,''
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_TABS_LIST'
,'TAB_NAME'
,'���'
,'*'
,'S'
,'1003'
,'N'
,'Y'
,''
,''
,''
,''
,'*���������������� ��� ��������'
,'N'
,'N'
,''
,''
,''
,'2'
,''
,''
,''
,''
,''
,''
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_TABS_LIST'
,'TAB_TYPE'
,'���'
,'*'
,'S'
,'1004'
,'N'
,'Y'
,''
,''
,''
,'8'
,'**TAB_TYPE'
,'N'
,'N'
,'FORM_TABS.TAB_TYPE'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'Y'
,'*'
,''
,'');
/*  Form: FORM_TABS_LIST. Entity: FORM_COLUMN_ATTR_VALS.  */
/*  Form: FORM_TABS_LIST. Entity: FORM_TAB_PARENT_EXCLNS.  */
/*  Form: FORM_TABS_LIST. Entity: APPS_PRIVS.  */

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'SC'
,'FORM_TABS_LIST');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'BF'
,'FORM_TABS_LIST');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'AAHR'
,'FORM_TABS_LIST');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'TC'
,'FORM_TABS_LIST');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'INS'
,'FORM_TABS_LIST');



Alter Table forms Enable VALIDATE Constraint forms_form_actions_fk;
Alter Table FORMS Enable All Triggers;

/*****************ICONS*********************/

Alter Table FORMS Disable All Triggers;
Alter Table forms Disable Constraint forms_form_actions_fk;
delete from APPS_PRIVS where form_code = 'ICONS';
delete from FORM_TAB_PARENT_EXCLNS where form_code = 'ICONS';
delete from FORM_COLUMN_ATTR_VALS where form_code = 'ICONS';
delete from FORM_COLUMNS where form_code = 'ICONS';
delete from FORM_COLUMNS$ where form_code = 'ICONS';
delete from FORM_ACTIONS where form_code = 'ICONS';
delete from FORM_TABS where form_code = 'ICONS';
delete from FORMS where form_code = 'ICONS';
/*  Form: ICONS. Entity: FORMS.  */

insert into FORMS("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID", "FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR", "OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH", "DESCRIPTION", "DOUBLE_CLICK_ACTION_CODE", "LOOKUP_WIDTH", "APPS_CODE", "EXPORT_ORDER") values (
'ICONS'
,''
,'Select a.icon_id, a.icon_id icon, a.icon_file_name, a.icon_path
  From &fc_schema_owner..icons a
-----------'
,'������'
,''
,'N'
,'13'
,''
,''
,''
,''
,'N'
,'127'
,''
,''
,''
,''
,'FC'
,'10');
/*  Form: ICONS. Entity: FORM_TABS.  */
/*  Form: ICONS. Entity: FORM_ACTIONS.  */

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'ICONS'
,'CUST_ACT'
,'&fc_schema_owner..ICONS_PKG.p_ins_upd'
,'���-��'
,'22'
,''
,''
,'7'
,'200'
,'�� ��������?'
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'ICONS'
,'DEL'
,'&fc_schema_owner..ICONS_PKG.p_delete'
,'�������'
,'48'
,''
,''
,'3'
,'130'
,'�� �������� ��� ������ ������� ������?'
,''
,'Y'
,'N'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'ICONS'
,'EDIT'
,''
,'�������������'
,'50'
,''
,''
,'8'
,'115'
,'�� ��������?'
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'ICONS'
,'INS'
,''
,'�������'
,'47'
,''
,''
,'1'
,'110'
,''
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'ICONS'
,'NEXT'
,''
,'������'
,'53'
,''
,''
,'6'
,'40'
,''
,''
,'Y'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'ICONS'
,'PREV'
,''
,'�����'
,'54'
,''
,''
,'5'
,'30'
,''
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'ICONS'
,'REFRESH'
,''
,'��������'
,'55'
,''
,''
,'4'
,'10'
,''
,'Alt+R'
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'ICONS'
,'UPD'
,'&fc_schema_owner..ICONS_PKG.p_ins_upd'
,'���������'
,'46'
,''
,''
,'2'
,'120'
,'�� ��������?'
,''
,'N'
,'Y'
,''
,'');
/*  Form: ICONS. Entity: FORM_COLUMNS$.  */

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'2'
,'NUMBER'
,'22'
,'ICON'
,'4'
,'0'
,'-127'
,'ICONS'
,''
,''
,'**ICON');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'3'
,'VARCHAR2'
,'4000'
,'ICON_FILE_NAME'
,'14'
,'0'
,'0'
,'ICONS'
,''
,''
,'*���� ������ �� ���� default_icon_path');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'1'
,'NUMBER'
,'22'
,'ICON_ID'
,'7'
,'0'
,'-127'
,'ICONS'
,''
,''
,'**ICON_ID');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'4'
,'VARCHAR2'
,'1020'
,'ICON_PATH'
,'9'
,'0'
,'0'
,'ICONS'
,''
,''
,'**ICON_PATH');
/*  Form: ICONS. Entity: FORM_COLUMNS.  */

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'ICONS'
,'ICON'
,'�����������'
,'10%'
,'S'
,'1002'
,'N'
,'Y'
,''
,''
,''
,'3'
,'**ICON'
,'N'
,'Y'
,''
,'ICON_FILE_NAME'
,''
,'2'
,''
,''
,''
,''
,''
,''
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'ICONS'
,'ICON_FILE_NAME'
,'����'
,'*'
,'S'
,'1003'
,'N'
,'Y'
,''
,''
,''
,''
,'*���� ������'
,'N'
,'N'
,''
,''
,''
,'3'
,''
,''
,''
,''
,''
,''
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'ICONS'
,'ICON_ID'
,'��� ������'
,'10%'
,'S'
,'1001'
,'Y'
,'Y'
,''
,''
,''
,''
,'**ICON_ID'
,'N'
,'N'
,''
,''
,''
,'1'
,''
,''
,''
,''
,''
,''
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'ICONS'
,'ICON_PATH'
,''
,'*'
,'S'
,'1004'
,'N'
,'Y'
,''
,''
,''
,''
,'**ICON_PATH'
,'N'
,'N'
,''
,''
,''
,'3'
,''
,''
,''
,''
,''
,''
,'Y'
,'*'
,''
,'');
/*  Form: ICONS. Entity: FORM_COLUMN_ATTR_VALS.  */
/*  Form: ICONS. Entity: FORM_TAB_PARENT_EXCLNS.  */
/*  Form: ICONS. Entity: APPS_PRIVS.  */

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'SC'
,'ICONS');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'BF'
,'ICONS');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'AAHR'
,'ICONS');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'TC'
,'ICONS');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'INS'
,'ICONS');



Alter Table forms Enable VALIDATE Constraint forms_form_actions_fk;
Alter Table FORMS Enable All Triggers;

/*****************LOOKUPS_LIST*********************/

Alter Table FORMS Disable All Triggers;
Alter Table forms Disable Constraint forms_form_actions_fk;
delete from APPS_PRIVS where form_code = 'LOOKUPS_LIST';
delete from FORM_TAB_PARENT_EXCLNS where form_code = 'LOOKUPS_LIST';
delete from FORM_COLUMN_ATTR_VALS where form_code = 'LOOKUPS_LIST';
delete from FORM_COLUMNS where form_code = 'LOOKUPS_LIST';
delete from FORM_COLUMNS$ where form_code = 'LOOKUPS_LIST';
delete from FORM_ACTIONS where form_code = 'LOOKUPS_LIST';
delete from FORM_TABS where form_code = 'LOOKUPS_LIST';
delete from FORMS where form_code = 'LOOKUPS_LIST';
/*  Form: LOOKUPS_LIST. Entity: FORMS.  */

insert into FORMS("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID", "FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR", "OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH", "DESCRIPTION", "DOUBLE_CLICK_ACTION_CODE", "LOOKUP_WIDTH", "APPS_CODE", "EXPORT_ORDER") values (
'LOOKUPS_LIST'
,''
,'Select :field_type lookup_type, a.lookup_code, a.lookup_name, 111 As icon_id
  From &fc_schema_owner..lookups a
 Where :field_type In (''8'', ''10'')
Union All
Select :field_type lookup_type, a.form_code, NVL (a.form_name, a.form_code) form_name, a.icon_id
  From &fc_schema_owner..forms_v a
 Where :field_type In (''9'', ''11'')
'
,'������ ������'
,'G'
,'Y'
,'11'
,'*'
,'*'
,''
,''
,'Y'
,'33'
,'*'
,''
,''
,''
,'FC'
,'10');
/*  Form: LOOKUPS_LIST. Entity: FORM_TABS.  */
/*  Form: LOOKUPS_LIST. Entity: FORM_ACTIONS.  */
/*  Form: LOOKUPS_LIST. Entity: FORM_COLUMNS$.  */

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'4'
,'NUMBER'
,'22'
,'ICON_ID'
,'7'
,'0'
,'-127'
,'LOOKUPS_LIST'
,''
,'*'
,'**ICON_ID');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'2'
,'VARCHAR2'
,'1020'
,'LOOKUP_CODE'
,'11'
,'0'
,'0'
,'LOOKUPS_LIST'
,''
,'*'
,'*������ �� ����� - ������ ��� �������');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'3'
,'VARCHAR2'
,'1020'
,'LOOKUP_NAME'
,'11'
,'0'
,'0'
,'LOOKUPS_LIST'
,''
,'*'
,'*���������������� ���');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'1'
,'VARCHAR2'
,'2000'
,'LOOKUP_TYPE'
,'11'
,'0'
,'0'
,'LOOKUPS_LIST'
,''
,'*'
,'**LOOKUP_TYPE');
/*  Form: LOOKUPS_LIST. Entity: FORM_COLUMNS.  */

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'LOOKUPS_LIST'
,'ICON_ID'
,'������'
,'10%'
,'N'
,'5'
,'N'
,'Y'
,''
,''
,''
,'3'
,'**ICON_ID'
,'N'
,'N'
,''
,''
,''
,'3'
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'LOOKUPS_LIST'
,'LOOKUP_CODE'
,'���'
,'*'
,'S'
,'10'
,'N'
,'Y'
,''
,''
,''
,''
,'*������ �� ����� - ������ ��� �������'
,'N'
,'N'
,''
,''
,''
,'1'
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'LOOKUPS_LIST'
,'LOOKUP_NAME'
,'���������������� ���'
,'*'
,'S'
,'20'
,'N'
,'Y'
,''
,''
,''
,''
,'*���������������� ���'
,'N'
,'N'
,''
,''
,''
,'2'
,''
,''
,''
,'1'
,''
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'LOOKUPS_LIST'
,'LOOKUP_TYPE'
,'���'
,'*'
,'S'
,'1001'
,'N'
,'N'
,''
,''
,''
,'8'
,'*��� - ������� ��� ��������������, ������� � ����������� �� ����, SQL, SQL � �����������'
,'N'
,'N'
,'FORM_COLUMNS.FIELD_TYPE'
,''
,''
,''
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');
/*  Form: LOOKUPS_LIST. Entity: FORM_COLUMN_ATTR_VALS.  */
/*  Form: LOOKUPS_LIST. Entity: FORM_TAB_PARENT_EXCLNS.  */
/*  Form: LOOKUPS_LIST. Entity: APPS_PRIVS.  */

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'SC'
,'LOOKUPS_LIST');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'BF'
,'LOOKUPS_LIST');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'AAHR'
,'LOOKUPS_LIST');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'TC'
,'LOOKUPS_LIST');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'INS'
,'LOOKUPS_LIST');



Alter Table forms Enable VALIDATE Constraint forms_form_actions_fk;
Alter Table FORMS Enable All Triggers;

/*****************LOOKUP_VALUES_LIST*********************/

Alter Table FORMS Disable All Triggers;
Alter Table forms Disable Constraint forms_form_actions_fk;
delete from APPS_PRIVS where form_code = 'LOOKUP_VALUES_LIST';
delete from FORM_TAB_PARENT_EXCLNS where form_code = 'LOOKUP_VALUES_LIST';
delete from FORM_COLUMN_ATTR_VALS where form_code = 'LOOKUP_VALUES_LIST';
delete from FORM_COLUMNS where form_code = 'LOOKUP_VALUES_LIST';
delete from FORM_COLUMNS$ where form_code = 'LOOKUP_VALUES_LIST';
delete from FORM_ACTIONS where form_code = 'LOOKUP_VALUES_LIST';
delete from FORM_TABS where form_code = 'LOOKUP_VALUES_LIST';
delete from FORMS where form_code = 'LOOKUP_VALUES_LIST';
/*  Form: LOOKUP_VALUES_LIST. Entity: FORMS.  */

insert into FORMS("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID", "FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR", "OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH", "DESCRIPTION", "DOUBLE_CLICK_ACTION_CODE", "LOOKUP_WIDTH", "APPS_CODE", "EXPORT_ORDER") values (
'LOOKUP_VALUES_LIST'
,''
,'Select l.lookup_value_code, l.lookup_display_value
  From &fc_schema_owner..lookup_values l
 Where l.lookup_code = :lookup_code
   And INSTR (''_'' || NVL (:lookup_value_codes_list, l.lookup_value_code) || ''_'', ''_'' || l.lookup_value_code || ''_'') > 0
   And UPPER (l.lookup_display_value) Like ''%'' || UPPER (NVL (:p$lookup_entered_value, l.lookup_display_value)) || ''%''
'
,'������ ��������'
,'G'
,'Y'
,''
,'*'
,'*'
,''
,''
,'Y'
,'19'
,'*'
,''
,''
,''
,'FC'
,'10');
/*  Form: LOOKUP_VALUES_LIST. Entity: FORM_TABS.  */
/*  Form: LOOKUP_VALUES_LIST. Entity: FORM_ACTIONS.  */

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'LOOKUP_VALUES_LIST'
,'REFR'
,''
,'��������'
,'15'
,''
,''
,'4'
,'10'
,''
,''
,'N'
,'Y'
,''
,'');
/*  Form: LOOKUP_VALUES_LIST. Entity: FORM_COLUMNS$.  */

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'2'
,'VARCHAR2'
,'1020'
,'LOOKUP_DISPLAY_VALUE'
,'20'
,'0'
,'0'
,'LOOKUP_VALUES_LIST'
,''
,'*'
,'*���� �������, ������������ ������������ - ��� ������� �������');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'1'
,'VARCHAR2'
,'1020'
,'LOOKUP_VALUE_CODE'
,'17'
,'0'
,'0'
,'LOOKUP_VALUES_LIST'
,''
,'*'
,'**LOOKUP_VALUE_CODE');
/*  Form: LOOKUP_VALUES_LIST. Entity: FORM_COLUMNS.  */

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'LOOKUP_VALUES_LIST'
,'LOOKUP_DISPLAY_VALUE'
,'��������'
,'*'
,'S'
,'1002'
,'N'
,'Y'
,''
,''
,''
,''
,'*���� �������, ������������ ������������ - ��� ������� �������'
,'N'
,'N'
,''
,''
,''
,'2'
,''
,''
,''
,'1'
,''
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'LOOKUP_VALUES_LIST'
,'LOOKUP_VALUE_CODE'
,'���'
,'30%'
,'S'
,'1001'
,'N'
,'N'
,''
,''
,''
,''
,'**LOOKUP_VALUE_CODE'
,'N'
,'N'
,''
,''
,''
,'1'
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');
/*  Form: LOOKUP_VALUES_LIST. Entity: FORM_COLUMN_ATTR_VALS.  */
/*  Form: LOOKUP_VALUES_LIST. Entity: FORM_TAB_PARENT_EXCLNS.  */
/*  Form: LOOKUP_VALUES_LIST. Entity: APPS_PRIVS.  */

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'SC'
,'LOOKUP_VALUES_LIST');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'TC'
,'LOOKUP_VALUES_LIST');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'AAHR'
,'LOOKUP_VALUES_LIST');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'INS'
,'LOOKUP_VALUES_LIST');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'FC'
,'LOOKUP_VALUES_LIST');



Alter Table forms Enable VALIDATE Constraint forms_form_actions_fk;
Alter Table FORMS Enable All Triggers;

/*****************REPORTS*********************/

Alter Table FORMS Disable All Triggers;
Alter Table forms Disable Constraint forms_form_actions_fk;
delete from APPS_PRIVS where form_code = 'REPORTS';
delete from FORM_TAB_PARENT_EXCLNS where form_code = 'REPORTS';
delete from FORM_COLUMN_ATTR_VALS where form_code = 'REPORTS';
delete from FORM_COLUMNS where form_code = 'REPORTS';
delete from FORM_COLUMNS$ where form_code = 'REPORTS';
delete from FORM_ACTIONS where form_code = 'REPORTS';
delete from FORM_TABS where form_code = 'REPORTS';
delete from FORMS where form_code = 'REPORTS';
/*  Form: REPORTS. Entity: FORMS.  */

insert into FORMS("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID", "FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR", "OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH", "DESCRIPTION", "DOUBLE_CLICK_ACTION_CODE", "LOOKUP_WIDTH", "APPS_CODE", "EXPORT_ORDER") values (
'REPORTS'
,''
,'select * from &fc_schema_owner..REPORT_TEMPLATES'
,'������� �������'
,'G'
,'Y'
,''
,'*'
,'*'
,''
,''
,'Y'
,'25'
,'*'
,''
,''
,''
,'FC'
,'10');
/*  Form: REPORTS. Entity: FORM_TABS.  */
/*  Form: REPORTS. Entity: FORM_ACTIONS.  */

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'REPORTS'
,'DEL'
,'&fc_schema_owner..REPORTS_PKG.p_delete'
,'�������'
,'48'
,''
,''
,'3'
,'130'
,'�� �������� ��� ������ ������� ������?'
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'REPORTS'
,'EDIT'
,''
,'�������������'
,'50'
,''
,''
,'8'
,'115'
,'�� ��������?'
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'REPORTS'
,'INS'
,''
,'�������'
,'47'
,''
,''
,'1'
,'110'
,''
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'REPORTS'
,'REFR'
,''
,'��������'
,'15'
,''
,''
,'4'
,'10'
,''
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'REPORTS'
,'UPD'
,'&fc_schema_owner..REPORTS_PKG.p_ins_upd'
,'���������'
,'46'
,''
,''
,'2'
,'120'
,'�� ��������?'
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'REPORTS'
,'XML'
,'xmlp?type=clob&filename=rep1.xml&ContentType=text/xml&contentDisposition=attachment&dataClobId=:CLOB_CONTENT'
,'���� XML'
,'103'
,''
,''
,'15'
,'210'
,''
,''
,'N'
,'N'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'REPORTS'
,'XMLP'
,'xmlp?type=xmlp&ContentType=application/rtf&template=MET&dataClobId=:CLOB_CONTENT&filename=:filename'
,'������ :report_type_code'
,'43'
,''
,''
,'15'
,'200'
,''
,''
,'N'
,'N'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'REPORTS'
,'tmp'
,''
,':REPORT_TYPE_CODE - xxxx'
,''
,''
,''
,'10'
,'140'
,'�� ��������?'
,''
,'N'
,'N'
,''
,'');
/*  Form: REPORTS. Entity: FORM_COLUMNS$.  */

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'3'
,'VARCHAR2'
,'1020'
,'APP_CODE'
,'8'
,'0'
,'0'
,'REPORTS'
,''
,'*'
,'**APP_CODE');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'8'
,'CLOB'
,'4000'
,'CLOB_CONTENT'
,'12'
,'0'
,'0'
,'REPORTS'
,''
,'*'
,'**CLOB_CONTENT');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'6'
,'BLOB'
,'4000'
,'CONTENT'
,'7'
,'0'
,'0'
,'REPORTS'
,''
,'*'
,'**CONTENT');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'5'
,'VARCHAR2'
,'1020'
,'CONTENT_TYPE'
,'12'
,'0'
,'0'
,'REPORTS'
,''
,'*'
,'**CONTENT_TYPE');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'7'
,'VARCHAR2'
,'1020'
,'FILENAME'
,'8'
,'0'
,'0'
,'REPORTS'
,''
,'*'
,'**FILENAME');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'1'
,'NUMBER'
,'22'
,'REPORT_ID'
,'9'
,'0'
,'-127'
,'REPORTS'
,''
,'*'
,'*������������� ������');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'4'
,'VARCHAR2'
,'1020'
,'REPORT_TYPE_CODE'
,'16'
,'0'
,'0'
,'REPORTS'
,''
,'*'
,'**REPORT_TYPE_CODE');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'2'
,'NUMBER'
,'22'
,'USER_ID'
,'7'
,'0'
,'-127'
,'REPORTS'
,''
,'*'
,'*Database user id.');
/*  Form: REPORTS. Entity: FORM_COLUMNS.  */

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'REPORTS'
,'CLOB_CONTENT'
,''
,'*'
,'CLOB'
,'1008'
,'N'
,'Y'
,''
,''
,''
,''
,'**CLOB_CONTENT'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,'/constructorapp/xmlp?type=xmlp&ContentType=application/rtf&template=MET&dataClobId=:CLOB_CONTENT'
,'L'
,'Y'
,'*'
,''
,'');
/*  Form: REPORTS. Entity: FORM_COLUMN_ATTR_VALS.  */
/*  Form: REPORTS. Entity: FORM_TAB_PARENT_EXCLNS.  */
/*  Form: REPORTS. Entity: APPS_PRIVS.  */

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'SC'
,'REPORTS');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'INS'
,'REPORTS');



Alter Table forms Enable VALIDATE Constraint forms_form_actions_fk;
Alter Table FORMS Enable All Triggers;

/*****************USERS*********************/

Alter Table FORMS Disable All Triggers;
Alter Table forms Disable Constraint forms_form_actions_fk;
delete from APPS_PRIVS where form_code = 'USERS';
delete from FORM_TAB_PARENT_EXCLNS where form_code = 'USERS';
delete from FORM_COLUMN_ATTR_VALS where form_code = 'USERS';
delete from FORM_COLUMNS where form_code = 'USERS';
delete from FORM_COLUMNS$ where form_code = 'USERS';
delete from FORM_ACTIONS where form_code = 'USERS';
delete from FORM_TABS where form_code = 'USERS';
delete from FORMS where form_code = 'USERS';
/*  Form: USERS. Entity: FORMS.  */

insert into FORMS("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID", "FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR", "OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH", "DESCRIPTION", "DOUBLE_CLICK_ACTION_CODE", "LOOKUP_WIDTH", "APPS_CODE", "EXPORT_ORDER") values (
'USERS'
,''
,'select * from &fc_schema_owner..users u
--'
,'������������'
,'G'
,'Y'
,'31'
,'*'
,'*'
,''
,''
,'Y'
,'23'
,'*'
,''
,''
,''
,'FC'
,'10');
/*  Form: USERS. Entity: FORM_TABS.  */
/*  Form: USERS. Entity: FORM_ACTIONS.  */

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'USERS'
,'DEL'
,'&fc_schema_owner..USERS_PKG.p_delete'
,'�������'
,'48'
,''
,''
,'3'
,'130'
,'�� �������� ��� ������ ������� ������?'
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'USERS'
,'EDIT'
,''
,'�������������'
,'50'
,''
,''
,'8'
,'115'
,'�� ��������?'
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'USERS'
,'INS'
,''
,'�������'
,'47'
,''
,''
,'1'
,'110'
,''
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'USERS'
,'REFR'
,''
,'��������'
,'15'
,''
,''
,'4'
,'10'
,''
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'USERS'
,'UPD'
,'&fc_schema_owner..USERS_PKG.p_ins_upd'
,'���������'
,'46'
,''
,''
,'2'
,'120'
,'�� ��������?'
,''
,'N'
,'Y'
,''
,'');
/*  Form: USERS. Entity: FORM_COLUMNS$.  */

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'6'
,'VARCHAR2'
,'4000'
,'EMAIL'
,'5'
,'0'
,'0'
,'USERS'
,''
,'*'
,'*Email id of the employee');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'2'
,'VARCHAR2'
,'4000'
,'FIO'
,'3'
,'0'
,'0'
,'USERS'
,''
,'*'
,'*���');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'5'
,'NUMBER'
,'22'
,'ORIG_REF_ID'
,'11'
,'10'
,'0'
,'USERS'
,''
,'*'
,'**ORIG_REF_ID');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'4'
,'VARCHAR2'
,'255'
,'PASSWORD'
,'8'
,'0'
,'0'
,'USERS'
,''
,'*'
,'*Deprecated-Password for logon');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'3'
,'VARCHAR2'
,'1020'
,'USERNAME'
,'8'
,'0'
,'0'
,'USERS'
,''
,'*'
,'*Identifying name of the registered user');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'1'
,'NUMBER'
,'22'
,'USER_ID'
,'7'
,'0'
,'-127'
,'USERS'
,''
,'*'
,'*Database user id.');
/*  Form: USERS. Entity: FORM_COLUMNS.  */

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'USERS'
,'EMAIL'
,'Email id of the employee'
,'*'
,'S'
,'1006'
,'N'
,'Y'
,''
,''
,''
,''
,'*Email id of the employee'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,'^([a-zA-Z0-9_.\-+])+@(([a-zA-Z0-9\-])+\.)+[a-zA-Z0-9]{2,4}$'
,''
,''
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'USERS'
,'FIO'
,'���'
,'*'
,'S'
,'1002'
,'N'
,'Y'
,''
,''
,''
,''
,'*���'
,'N'
,'N'
,''
,''
,''
,'3'
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'USERS'
,'PASSWORD'
,'Password'
,'*'
,'S'
,'1004'
,'N'
,'Y'
,''
,''
,''
,''
,'*Deprecated-Password for logon'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'USERS'
,'USERNAME'
,'User Name'
,'*'
,'S'
,'1003'
,'N'
,'Y'
,''
,''
,''
,''
,'*Identifying name of the registered user'
,'N'
,'N'
,''
,''
,''
,'2'
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'USERS'
,'USER_ID'
,'Database user id.'
,'*'
,'N'
,'1001'
,'Y'
,'N'
,''
,''
,''
,''
,'*Database user id.'
,'N'
,'N'
,''
,''
,''
,'1'
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');
/*  Form: USERS. Entity: FORM_COLUMN_ATTR_VALS.  */
/*  Form: USERS. Entity: FORM_TAB_PARENT_EXCLNS.  */
/*  Form: USERS. Entity: APPS_PRIVS.  */

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'SC'
,'USERS');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'INS'
,'USERS');



Alter Table forms Enable VALIDATE Constraint forms_form_actions_fk;
Alter Table FORMS Enable All Triggers;

/*****************LOOKUP_ATTRIBUTE_VALUES*********************/

Alter Table FORMS Disable All Triggers;
Alter Table forms Disable Constraint forms_form_actions_fk;
delete from APPS_PRIVS where form_code = 'LOOKUP_ATTRIBUTE_VALUES';
delete from FORM_TAB_PARENT_EXCLNS where form_code = 'LOOKUP_ATTRIBUTE_VALUES';
delete from FORM_COLUMN_ATTR_VALS where form_code = 'LOOKUP_ATTRIBUTE_VALUES';
delete from FORM_COLUMNS where form_code = 'LOOKUP_ATTRIBUTE_VALUES';
delete from FORM_COLUMNS$ where form_code = 'LOOKUP_ATTRIBUTE_VALUES';
delete from FORM_ACTIONS where form_code = 'LOOKUP_ATTRIBUTE_VALUES';
delete from FORM_TABS where form_code = 'LOOKUP_ATTRIBUTE_VALUES';
delete from FORMS where form_code = 'LOOKUP_ATTRIBUTE_VALUES';
/*  Form: LOOKUP_ATTRIBUTE_VALUES. Entity: FORMS.  */

insert into FORMS("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID", "FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR", "OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH", "DESCRIPTION", "DOUBLE_CLICK_ACTION_CODE", "LOOKUP_WIDTH", "APPS_CODE", "EXPORT_ORDER") values (
'LOOKUP_ATTRIBUTE_VALUES'
,''
,'select * from &fc_schema_owner..LOOKUP_ATTRIBUTE_VALUES lav
where
       lav.lookup_code = :lookup_code
and lav.lookup_value_code = :lookup_value_code'
,'�������� ���������'
,'G'
,'Y'
,''
,'*'
,'*'
,''
,''
,'Y'
,'9'
,'*'
,''
,''
,''
,'FC'
,'20');
/*  Form: LOOKUP_ATTRIBUTE_VALUES. Entity: FORM_TABS.  */
/*  Form: LOOKUP_ATTRIBUTE_VALUES. Entity: FORM_ACTIONS.  */

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'LOOKUP_ATTRIBUTE_VALUES'
,'DEL'
,'&fc_schema_owner..LOOKUP_ATTRIBUTE_VALUES_PKG.p_delete'
,'�������'
,'48'
,''
,''
,'3'
,'130'
,'�� �������� ��� ������ ������� ������?'
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'LOOKUP_ATTRIBUTE_VALUES'
,'EDIT'
,''
,'�������������'
,'50'
,''
,''
,'8'
,'115'
,'�� ��������?'
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'LOOKUP_ATTRIBUTE_VALUES'
,'INS'
,''
,'�������'
,'47'
,''
,''
,'1'
,'110'
,''
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'LOOKUP_ATTRIBUTE_VALUES'
,'REFR'
,''
,'��������'
,'15'
,''
,''
,'4'
,'10'
,''
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'LOOKUP_ATTRIBUTE_VALUES'
,'UPD'
,'&fc_schema_owner..LOOKUP_ATTRIBUTE_VALUES_PKG.p_ins_upd'
,'���������'
,'46'
,''
,''
,'2'
,'120'
,'�� ��������?'
,''
,'N'
,'Y'
,''
,'');
/*  Form: LOOKUP_ATTRIBUTE_VALUES. Entity: FORM_COLUMNS$.  */

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'3'
,'VARCHAR2'
,'1020'
,'ATTRIBUTE_CODE'
,'14'
,'0'
,'0'
,'LOOKUP_ATTRIBUTE_VALUES'
,''
,'*'
,'*��� ��������');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'5'
,'VARCHAR2'
,'4000'
,'ATTRIBUTE_VALUE_CHAR'
,'20'
,'0'
,'0'
,'LOOKUP_ATTRIBUTE_VALUES'
,''
,'*'
,'**ATTRIBUTE_VALUE_CHAR');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'6'
,'DATE'
,'7'
,'ATTRIBUTE_VALUE_DATE'
,'20'
,'0'
,'0'
,'LOOKUP_ATTRIBUTE_VALUES'
,''
,'*'
,'**ATTRIBUTE_VALUE_DATE');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'4'
,'NUMBER'
,'22'
,'ATTRIBUTE_VALUE_NUMBER'
,'22'
,'0'
,'-127'
,'LOOKUP_ATTRIBUTE_VALUES'
,''
,'*'
,'**ATTRIBUTE_VALUE_NUMBER');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'1'
,'VARCHAR2'
,'1020'
,'LOOKUP_CODE'
,'11'
,'0'
,'0'
,'LOOKUP_ATTRIBUTE_VALUES'
,''
,'*'
,'*������ �� ����� - ������ ��� �������');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'2'
,'VARCHAR2'
,'1020'
,'LOOKUP_VALUE_CODE'
,'17'
,'0'
,'0'
,'LOOKUP_ATTRIBUTE_VALUES'
,''
,'*'
,'**LOOKUP_VALUE_CODE');
/*  Form: LOOKUP_ATTRIBUTE_VALUES. Entity: FORM_COLUMNS.  */

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'LOOKUP_ATTRIBUTE_VALUES'
,'ATTRIBUTE_CODE'
,''
,'*'
,'S'
,'1003'
,'N'
,'Y'
,''
,''
,''
,'9'
,'**ATTRIBUTE_CODE'
,'N'
,'N'
,'LOOKUP_ATTRIBUTES'
,''
,''
,''
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'LOOKUP_ATTRIBUTE_VALUES'
,'LOOKUP_CODE'
,'������ �� ����� - ������ ��� �������'
,'*'
,'S'
,'1001'
,'N'
,'N'
,''
,''
,''
,''
,'*������ �� ����� - ������ ��� �������'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,':lookup_code'
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'LOOKUP_ATTRIBUTE_VALUES'
,'LOOKUP_VALUE_CODE'
,''
,'*'
,'S'
,'1002'
,'N'
,'N'
,''
,''
,''
,''
,'**LOOKUP_VALUE_CODE'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,':lookup_value_code'
,'L'
,'Y'
,'*'
,''
,'');
/*  Form: LOOKUP_ATTRIBUTE_VALUES. Entity: FORM_COLUMN_ATTR_VALS.  */
/*  Form: LOOKUP_ATTRIBUTE_VALUES. Entity: FORM_TAB_PARENT_EXCLNS.  */
/*  Form: LOOKUP_ATTRIBUTE_VALUES. Entity: APPS_PRIVS.  */

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'SC'
,'LOOKUP_ATTRIBUTE_VALUES');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'BF'
,'LOOKUP_ATTRIBUTE_VALUES');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'AAHR'
,'LOOKUP_ATTRIBUTE_VALUES');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'TC'
,'LOOKUP_ATTRIBUTE_VALUES');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'INS'
,'LOOKUP_ATTRIBUTE_VALUES');



Alter Table forms Enable VALIDATE Constraint forms_form_actions_fk;
Alter Table FORMS Enable All Triggers;

/*****************LOOKUP_ATTRIBUTES*********************/

Alter Table FORMS Disable All Triggers;
Alter Table forms Disable Constraint forms_form_actions_fk;
delete from APPS_PRIVS where form_code = 'LOOKUP_ATTRIBUTES';
delete from FORM_TAB_PARENT_EXCLNS where form_code = 'LOOKUP_ATTRIBUTES';
delete from FORM_COLUMN_ATTR_VALS where form_code = 'LOOKUP_ATTRIBUTES';
delete from FORM_COLUMNS where form_code = 'LOOKUP_ATTRIBUTES';
delete from FORM_COLUMNS$ where form_code = 'LOOKUP_ATTRIBUTES';
delete from FORM_ACTIONS where form_code = 'LOOKUP_ATTRIBUTES';
delete from FORM_TABS where form_code = 'LOOKUP_ATTRIBUTES';
delete from FORMS where form_code = 'LOOKUP_ATTRIBUTES';
/*  Form: LOOKUP_ATTRIBUTES. Entity: FORMS.  */

insert into FORMS("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID", "FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR", "OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH", "DESCRIPTION", "DOUBLE_CLICK_ACTION_CODE", "LOOKUP_WIDTH", "APPS_CODE", "EXPORT_ORDER") values (
'LOOKUP_ATTRIBUTES'
,''
,'select * from &fc_schema_owner..LOOKUP_ATTRIBUTES la
where la.lookup_code = :lookup_code'
,'��������'
,'G'
,'Y'
,''
,'*'
,'*'
,''
,''
,'Y'
,'10'
,'*'
,''
,''
,''
,'FC'
,'30');
/*  Form: LOOKUP_ATTRIBUTES. Entity: FORM_TABS.  */
/*  Form: LOOKUP_ATTRIBUTES. Entity: FORM_ACTIONS.  */

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'LOOKUP_ATTRIBUTES'
,'DEL'
,'&fc_schema_owner..LOOKUP_ATTRIBUTES_PKG.p_delete'
,'�������'
,'48'
,''
,''
,'3'
,'130'
,'�� �������� ��� ������ ������� ������?'
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'LOOKUP_ATTRIBUTES'
,'EDIT'
,''
,'�������������'
,'50'
,''
,''
,'8'
,'115'
,'�� ��������?'
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'LOOKUP_ATTRIBUTES'
,'INS'
,''
,'�������'
,'47'
,''
,''
,'1'
,'110'
,''
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'LOOKUP_ATTRIBUTES'
,'REFR'
,''
,'��������'
,'15'
,''
,''
,'4'
,'10'
,''
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'LOOKUP_ATTRIBUTES'
,'UPD'
,'&fc_schema_owner..LOOKUP_ATTRIBUTES_PKG.p_ins_upd'
,'���������'
,'46'
,''
,''
,'2'
,'120'
,'�� ��������?'
,''
,'N'
,'Y'
,''
,'');
/*  Form: LOOKUP_ATTRIBUTES. Entity: FORM_COLUMNS$.  */

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'2'
,'VARCHAR2'
,'1020'
,'ATTRIBUTE_CODE'
,'14'
,'0'
,'0'
,'LOOKUP_ATTRIBUTES'
,'Y'
,'*'
,'*��� ��������');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'3'
,'VARCHAR2'
,'1020'
,'ATTRIBUTE_NAME'
,'14'
,'0'
,'0'
,'LOOKUP_ATTRIBUTES'
,''
,'*'
,'*Name of the attribute');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'4'
,'VARCHAR2'
,'4'
,'ATTRIBUTE_TYPE'
,'14'
,'0'
,'0'
,'LOOKUP_ATTRIBUTES'
,''
,'*'
,'*N/D/C/B');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'1'
,'VARCHAR2'
,'1020'
,'LOOKUP_CODE'
,'11'
,'0'
,'0'
,'LOOKUP_ATTRIBUTES'
,'Y'
,'*'
,'*������ �� ����� - ������ ��� �������');
/*  Form: LOOKUP_ATTRIBUTES. Entity: FORM_COLUMNS.  */

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'LOOKUP_ATTRIBUTES'
,'ATTRIBUTE_CODE'
,''
,'*'
,'S'
,'1002'
,'N'
,'Y'
,''
,''
,''
,''
,'**ATTRIBUTE_CODE'
,'N'
,'N'
,''
,''
,''
,'1'
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'LOOKUP_ATTRIBUTES'
,'ATTRIBUTE_NAME'
,'Name of the attribute'
,'*'
,'S'
,'1003'
,'N'
,'Y'
,''
,''
,''
,''
,'*Name of the attribute'
,'N'
,'N'
,''
,''
,''
,'2'
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'LOOKUP_ATTRIBUTES'
,'ATTRIBUTE_TYPE'
,''
,'*'
,'S'
,'1004'
,'N'
,'Y'
,''
,''
,''
,'8'
,'**ATTRIBUTE_TYPE'
,'N'
,'N'
,'FORM_COLUMNS.DATA_TYPE'
,''
,''
,'3'
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'LOOKUP_ATTRIBUTES'
,'LOOKUP_CODE'
,'������ �� ����� - ������ ��� �������'
,'*'
,'S'
,'1001'
,'N'
,'N'
,''
,''
,''
,''
,'*������ �� ����� - ������ ��� �������'
,'N'
,'N'
,''
,''
,''
,'3'
,''
,''
,''
,''
,':lookup_code'
,'L'
,'Y'
,'*'
,''
,'');
/*  Form: LOOKUP_ATTRIBUTES. Entity: FORM_COLUMN_ATTR_VALS.  */
/*  Form: LOOKUP_ATTRIBUTES. Entity: FORM_TAB_PARENT_EXCLNS.  */
/*  Form: LOOKUP_ATTRIBUTES. Entity: APPS_PRIVS.  */

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'SC'
,'LOOKUP_ATTRIBUTES');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'BF'
,'LOOKUP_ATTRIBUTES');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'AAHR'
,'LOOKUP_ATTRIBUTES');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'TC'
,'LOOKUP_ATTRIBUTES');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'INS'
,'LOOKUP_ATTRIBUTES');



Alter Table forms Enable VALIDATE Constraint forms_form_actions_fk;
Alter Table FORMS Enable All Triggers;

/*****************LOOKUP_VALUES*********************/

Alter Table FORMS Disable All Triggers;
Alter Table forms Disable Constraint forms_form_actions_fk;
delete from APPS_PRIVS where form_code = 'LOOKUP_VALUES';
delete from FORM_TAB_PARENT_EXCLNS where form_code = 'LOOKUP_VALUES';
delete from FORM_COLUMN_ATTR_VALS where form_code = 'LOOKUP_VALUES';
delete from FORM_COLUMNS where form_code = 'LOOKUP_VALUES';
delete from FORM_COLUMNS$ where form_code = 'LOOKUP_VALUES';
delete from FORM_ACTIONS where form_code = 'LOOKUP_VALUES';
delete from FORM_TABS where form_code = 'LOOKUP_VALUES';
delete from FORMS where form_code = 'LOOKUP_VALUES';
/*  Form: LOOKUP_VALUES. Entity: FORMS.  */

insert into FORMS("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID", "FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR", "OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH", "DESCRIPTION", "DOUBLE_CLICK_ACTION_CODE", "LOOKUP_WIDTH", "APPS_CODE", "EXPORT_ORDER") values (
'LOOKUP_VALUES'
,''
,'SELECT * FROM &fc_schema_owner..lookup_values a where a.lookup_code=:lookup_code'
,'��������� �������� �������'
,'G'
,'Y'
,'4'
,'*'
,'45%'
,''
,''
,'Y'
,'42'
,'*'
,''
,''
,''
,'FC'
,'40');
/*  Form: LOOKUP_VALUES. Entity: FORM_TABS.  */

insert into FORM_TABS("FORM_CODE", "TAB_CODE", "CHILD_FORM_CODE", "TAB_POSITION", "TAB_NAME", "NUMBER_OF_COLUMNS", "ICON_ID", "TAB_TYPE", "TAB_DISPLAY_NUMBER") values (
'LOOKUP_VALUES'
,'LOOKUP_ATTRIBUTE_VALUES'
,'LOOKUP_ATTRIBUTE_VALUES'
,'B'
,''
,''
,'2'
,'2'
,'');
/*  Form: LOOKUP_VALUES. Entity: FORM_ACTIONS.  */

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'LOOKUP_VALUES'
,'DEL'
,'&fc_schema_owner..LOOKUP_VALUES_PKG.P_DELETE'
,'�������'
,'48'
,''
,''
,'3'
,'130'
,'�� �������� ��� ������ ������� ������?'
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'LOOKUP_VALUES'
,'EDIT'
,''
,'�������������'
,'50'
,''
,''
,'8'
,'115'
,'�� ��������?'
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'LOOKUP_VALUES'
,'FILTER'
,''
,'������'
,'45'
,''
,''
,'9'
,'199'
,''
,'Ctrl+Alt+Shift+F11'
,'Y'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'LOOKUP_VALUES'
,'GRID_EXPORT'
,''
,'������� �������'
,'44'
,''
,''
,'12'
,'310'
,''
,''
,'N'
,'N'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'LOOKUP_VALUES'
,'GRID_PRINT'
,''
,'������'
,'43'
,''
,''
,'14'
,'330'
,''
,''
,'N'
,'N'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'LOOKUP_VALUES'
,'INS'
,''
,'�������'
,'47'
,''
,''
,'1'
,'110'
,''
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'LOOKUP_VALUES'
,'REFRESH'
,''
,'��������'
,'15'
,''
,''
,'4'
,'150'
,''
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'LOOKUP_VALUES'
,'ROW_EXPORT'
,''
,'������� ������'
,'44'
,''
,''
,'13'
,'320'
,''
,''
,'N'
,'N'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'LOOKUP_VALUES'
,'UPD'
,'&fc_schema_owner..LOOKUP_VALUES_PKG.P_INS_UPD'
,'���������'
,'46'
,''
,''
,'2'
,'120'
,'�� ��������?'
,''
,'N'
,'Y'
,''
,'');
/*  Form: LOOKUP_VALUES. Entity: FORM_COLUMNS$.  */

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'1'
,'VARCHAR2'
,'1020'
,'LOOKUP_CODE'
,'11'
,'0'
,'0'
,'LOOKUP_VALUES'
,'Y'
,'*'
,'*������ �� ����� - ������ ��� �������');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'3'
,'VARCHAR2'
,'1020'
,'LOOKUP_DISPLAY_VALUE'
,'20'
,'0'
,'0'
,'LOOKUP_VALUES'
,''
,'*'
,'*���� �������, ������������ ������������ - ��� ������� �������');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'2'
,'VARCHAR2'
,'1020'
,'LOOKUP_VALUE_CODE'
,'17'
,'0'
,'0'
,'LOOKUP_VALUES'
,'Y'
,'*'
,'**LOOKUP_VALUE_CODE');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'4'
,'NUMBER'
,'22'
,'LOOKUP_VALUE_ID'
,'15'
,'0'
,'-127'
,'LOOKUP_VALUES'
,'Y'
,'*'
,'**LOOKUP_VALUE_ID');
/*  Form: LOOKUP_VALUES. Entity: FORM_COLUMNS.  */

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'LOOKUP_VALUES'
,'LOOKUP_CODE'
,'��� ������'
,'*'
,'S'
,'1001'
,'Y'
,'N'
,''
,''
,''
,'9'
,'*��������� ������������ (ID)'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,':lookup_code'
,''
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'LOOKUP_VALUES'
,'LOOKUP_DISPLAY_VALUE'
,'��������'
,'*'
,'S'
,'1003'
,'N'
,'Y'
,''
,''
,''
,''
,'**LOOKUP_DISPLAY_VALUE'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'LOOKUP_VALUES'
,'LOOKUP_VALUE_CODE'
,'���'
,'20%'
,'S'
,'1002'
,'Y'
,'Y'
,''
,'1'
,''
,''
,'**LOOKUP_VALUE_CODE'
,'N'
,'N'
,''
,''
,''
,'1'
,''
,''
,''
,'1'
,''
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'LOOKUP_VALUES'
,'LOOKUP_VALUE_ID'
,''
,'*'
,'N'
,'1004'
,'Y'
,'N'
,''
,'1'
,''
,''
,'**LOOKUP_VALUE_ID'
,'N'
,'N'
,''
,''
,''
,'1'
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');
/*  Form: LOOKUP_VALUES. Entity: FORM_COLUMN_ATTR_VALS.  */
/*  Form: LOOKUP_VALUES. Entity: FORM_TAB_PARENT_EXCLNS.  */
/*  Form: LOOKUP_VALUES. Entity: APPS_PRIVS.  */

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'SC'
,'LOOKUP_VALUES');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'BF'
,'LOOKUP_VALUES');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'AAHR'
,'LOOKUP_VALUES');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'TC'
,'LOOKUP_VALUES');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'INS'
,'LOOKUP_VALUES');



Alter Table forms Enable VALIDATE Constraint forms_form_actions_fk;
Alter Table FORMS Enable All Triggers;

/*****************LOOKUPS*********************/

Alter Table FORMS Disable All Triggers;
Alter Table forms Disable Constraint forms_form_actions_fk;
delete from APPS_PRIVS where form_code = 'LOOKUPS';
delete from FORM_TAB_PARENT_EXCLNS where form_code = 'LOOKUPS';
delete from FORM_COLUMN_ATTR_VALS where form_code = 'LOOKUPS';
delete from FORM_COLUMNS where form_code = 'LOOKUPS';
delete from FORM_COLUMNS$ where form_code = 'LOOKUPS';
delete from FORM_ACTIONS where form_code = 'LOOKUPS';
delete from FORM_TABS where form_code = 'LOOKUPS';
delete from FORMS where form_code = 'LOOKUPS';
/*  Form: LOOKUPS. Entity: FORMS.  */

insert into FORMS("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID", "FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR", "OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH", "DESCRIPTION", "DOUBLE_CLICK_ACTION_CODE", "LOOKUP_WIDTH", "APPS_CODE", "EXPORT_ORDER") values (
'LOOKUPS'
,''
,'SELECT * FROM &fc_schema_owner..lookups a
---'
,'������'
,'G'
,'Y'
,'28'
,'30%'
,'*'
,'L'
,''
,'N'
,'62'
,'120'
,''
,'DET_NEW_WND'
,''
,'FC'
,'50');
/*  Form: LOOKUPS. Entity: FORM_TABS.  */

insert into FORM_TABS("FORM_CODE", "TAB_CODE", "CHILD_FORM_CODE", "TAB_POSITION", "TAB_NAME", "NUMBER_OF_COLUMNS", "ICON_ID", "TAB_TYPE", "TAB_DISPLAY_NUMBER") values (
'LOOKUPS'
,'LOOKUPS_1'
,'LOOKUP_VALUES'
,'R'
,'��������'
,''
,'39'
,'2'
,'1');

insert into FORM_TABS("FORM_CODE", "TAB_CODE", "CHILD_FORM_CODE", "TAB_POSITION", "TAB_NAME", "NUMBER_OF_COLUMNS", "ICON_ID", "TAB_TYPE", "TAB_DISPLAY_NUMBER") values (
'LOOKUPS'
,'LOOKUP_ATTRIBUTES'
,'LOOKUP_ATTRIBUTES'
,'R'
,'��������'
,''
,''
,'2'
,'2');
/*  Form: LOOKUPS. Entity: FORM_ACTIONS.  */

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'LOOKUPS'
,'DEL'
,'&fc_schema_owner..LOOKUPS_PKG.p_delete'
,'�������'
,'48'
,''
,''
,'3'
,'130'
,'�� �������� ��� ������ ������� ������?'
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'LOOKUPS'
,'DET_NEW_TAB'
,''
,'������� :lookup_name'
,'103'
,''
,''
,'10'
,'150'
,''
,''
,'N'
,'N'
,'LOOKUP_VALUES'
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'LOOKUPS'
,'DET_NEW_WND'
,''
,'������� ":lookup_name" � ����'
,'103'
,''
,''
,'11'
,'170'
,''
,''
,'Y'
,'N'
,'LOOKUP_VALUES'
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'LOOKUPS'
,'EDIT'
,''
,'�������������'
,'50'
,''
,''
,'8'
,'115'
,''
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'LOOKUPS'
,'EXPORT'
,''
,'�������'
,'6'
,''
,''
,'12'
,'200'
,''
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'LOOKUPS'
,'INS'
,''
,'�������'
,'47'
,''
,''
,'1'
,'110'
,''
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'LOOKUPS'
,'NEXT'
,''
,'������'
,'53'
,''
,''
,'6'
,'190'
,''
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'LOOKUPS'
,'PREV'
,''
,'�����'
,'54'
,''
,''
,'5'
,'180'
,''
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'LOOKUPS'
,'REFRESH'
,''
,'��������'
,'55'
,''
,''
,'4'
,'10'
,''
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'LOOKUPS'
,'UPD'
,'&fc_schema_owner..LOOKUPS_PKG.P_INS_UPD'
,'���������'
,'46'
,''
,''
,'2'
,'120'
,'�� ��������?'
,''
,'N'
,'Y'
,''
,'');
/*  Form: LOOKUPS. Entity: FORM_COLUMNS$.  */

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'1'
,'VARCHAR2'
,'1020'
,'LOOKUP_CODE'
,'11'
,'0'
,'0'
,'LOOKUPS'
,''
,'120'
,'*������ �� ����� - ������ ��� �������');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'2'
,'VARCHAR2'
,'1020'
,'LOOKUP_NAME'
,'11'
,'0'
,'0'
,'LOOKUPS'
,''
,'120'
,'*���������������� ���');
/*  Form: LOOKUPS. Entity: FORM_COLUMNS.  */

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'LOOKUPS'
,'LOOKUP_CODE'
,'���'
,'120'
,'S'
,'1001'
,'Y'
,'Y'
,''
,''
,''
,''
,'*��������� ������������ (ID)'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,'1'
,''
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'LOOKUPS'
,'LOOKUP_NAME'
,'������������'
,'*'
,'S'
,'1002'
,'N'
,'Y'
,''
,''
,''
,''
,'*���������������� ���'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'Y'
,'*'
,''
,'');
/*  Form: LOOKUPS. Entity: FORM_COLUMN_ATTR_VALS.  */
/*  Form: LOOKUPS. Entity: FORM_TAB_PARENT_EXCLNS.  */
/*  Form: LOOKUPS. Entity: APPS_PRIVS.  */

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'SC'
,'LOOKUPS');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'BF'
,'LOOKUPS');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'AAHR'
,'LOOKUPS');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'TC'
,'LOOKUPS');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'INS'
,'LOOKUPS');



Alter Table forms Enable VALIDATE Constraint forms_form_actions_fk;
Alter Table FORMS Enable All Triggers;

/*****************FORM_ACTIONS*********************/

Alter Table FORMS Disable All Triggers;
Alter Table forms Disable Constraint forms_form_actions_fk;
delete from APPS_PRIVS where form_code = 'FORM_ACTIONS';
delete from FORM_TAB_PARENT_EXCLNS where form_code = 'FORM_ACTIONS';
delete from FORM_COLUMN_ATTR_VALS where form_code = 'FORM_ACTIONS';
delete from FORM_COLUMNS where form_code = 'FORM_ACTIONS';
delete from FORM_COLUMNS$ where form_code = 'FORM_ACTIONS';
delete from FORM_ACTIONS where form_code = 'FORM_ACTIONS';
delete from FORM_TABS where form_code = 'FORM_ACTIONS';
delete from FORMS where form_code = 'FORM_ACTIONS';
/*  Form: FORM_ACTIONS. Entity: FORMS.  */

insert into FORMS("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID", "FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR", "OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH", "DESCRIPTION", "DOUBLE_CLICK_ACTION_CODE", "LOOKUP_WIDTH", "APPS_CODE", "EXPORT_ORDER") values (
'FORM_ACTIONS'
,''
,'SELECT *
  FROM &fc_schema_owner..form_actions a
 Where DECODE (:p_$master_form_code, ''FORMS'', :form_code, ''FORMS2'', :form_code_for_filter,''MENUS'',:form_code_for_filter, a.form_code) = a.form_code
--'
,'��������� ��������'
,'G'
,'Y'
,'4'
,'*'
,'*'
,''
,''
,'Y'
,'55'
,'*'
,''
,''
,''
,'FC'
,'60');
/*  Form: FORM_ACTIONS. Entity: FORM_TABS.  */

insert into FORM_TABS("FORM_CODE", "TAB_CODE", "CHILD_FORM_CODE", "TAB_POSITION", "TAB_NAME", "NUMBER_OF_COLUMNS", "ICON_ID", "TAB_TYPE", "TAB_DISPLAY_NUMBER") values (
'FORM_ACTIONS'
,'COLUMN_ACTIONS'
,'FORM_COLUMN_ACTIONS'
,'B'
,'�������� �������'
,''
,'6'
,'2'
,'');
/*  Form: FORM_ACTIONS. Entity: FORM_ACTIONS.  */

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'FORM_ACTIONS'
,'DEL'
,'&fc_schema_owner..FORM_ACTIONS_PKG.p_delete'
,'�������'
,'48'
,''
,''
,'3'
,'130'
,'�� �������� ��� ������ ������� ������?'
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'FORM_ACTIONS'
,'EDIT'
,''
,'�������������'
,'50'
,''
,''
,'8'
,'115'
,'�� ��������?'
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'FORM_ACTIONS'
,'INS'
,''
,'�������'
,'47'
,''
,''
,'1'
,'110'
,''
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'FORM_ACTIONS'
,'REFR'
,''
,'��������'
,'15'
,''
,''
,'4'
,'10'
,''
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'FORM_ACTIONS'
,'UPD'
,'&fc_schema_owner..FORM_ACTIONS_PKG.p_ins_upd'
,'���������'
,'46'
,''
,''
,'2'
,'120'
,'�� ��������?'
,''
,'N'
,'Y'
,''
,'');
/*  Form: FORM_ACTIONS. Entity: FORM_COLUMNS$.  */

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'2'
,'VARCHAR2'
,'1020'
,'ACTION_CODE'
,'11'
,'0'
,'0'
,'FORM_ACTIONS'
,'Y'
,'*'
,'**ACTION_CODE');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'4'
,'VARCHAR2'
,'1020'
,'ACTION_DISPLAY_NAME'
,'19'
,'0'
,'0'
,'FORM_ACTIONS'
,''
,'*'
,'**ACTION_DISPLAY_NAME');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'8'
,'VARCHAR2'
,'8'
,'ACTION_TYPE'
,'11'
,'0'
,'0'
,'FORM_ACTIONS'
,''
,'*'
,'**ACTION_TYPE');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'14'
,'VARCHAR2'
,'1020'
,'CHILD_FORM_CODE'
,'15'
,'0'
,'0'
,'FORM_ACTIONS'
,''
,'*'
,'*����� �������� ����� � ����� ����/����');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'10'
,'VARCHAR2'
,'4000'
,'CONFIRM_TEXT'
,'12'
,'0'
,'0'
,'FORM_ACTIONS'
,''
,'*'
,'**CONFIRM_TEXT');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'7'
,'VARCHAR2'
,'1020'
,'DEFAULT_OLD_PARAM_PREFIX'
,'24'
,'0'
,'0'
,'FORM_ACTIONS'
,''
,'*'
,'**DEFAULT_OLD_PARAM_PREFIX');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'6'
,'VARCHAR2'
,'1020'
,'DEFAULT_PARAM_PREFIX'
,'20'
,'0'
,'0'
,'FORM_ACTIONS'
,''
,'*'
,'**DEFAULT_PARAM_PREFIX');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'9'
,'NUMBER'
,'22'
,'DISPLAY_NUMBER'
,'14'
,'0'
,'-127'
,'FORM_ACTIONS'
,''
,'*'
,'**DISPLAY_NUMBER');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'13'
,'VARCHAR2'
,'4'
,'DISPLAY_ON_TOOLBAR'
,'18'
,'0'
,'0'
,'FORM_ACTIONS'
,''
,'*'
,'**DISPLAY_ON_TOOLBAR');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'1'
,'VARCHAR2'
,'1020'
,'FORM_CODE'
,'9'
,'0'
,'0'
,'FORM_ACTIONS'
,'Y'
,'*'
,'*������������� ����');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'11'
,'VARCHAR2'
,'1020'
,'HOT_KEY'
,'7'
,'0'
,'0'
,'FORM_ACTIONS'
,''
,'*'
,'*������� �������  - ������ ���� [Ctrl+][Alt+][Shift+]Chr. ������� �� �����');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'5'
,'NUMBER'
,'22'
,'ICON_ID'
,'7'
,'0'
,'-127'
,'FORM_ACTIONS'
,''
,'*'
,'**ICON_ID');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'3'
,'VARCHAR2'
,'1020'
,'PROCEDURE_NAME'
,'14'
,'0'
,'0'
,'FORM_ACTIONS'
,''
,'*'
,'*Name of the procedure');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'12'
,'VARCHAR2'
,'4'
,'SHOW_SEPARATOR_BELOW'
,'20'
,'0'
,'0'
,'FORM_ACTIONS'
,''
,'*'
,'**SHOW_SEPARATOR_BELOW');
/*  Form: FORM_ACTIONS. Entity: FORM_COLUMNS.  */

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_ACTIONS'
,'ACTION_CODE'
,'��� ��������'
,'*'
,'S'
,'1002'
,'Y'
,'Y'
,''
,''
,''
,''
,'**ACTION_CODE'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_ACTIONS'
,'ACTION_DISPLAY_NAME'
,'������������'
,'*'
,'S'
,'1004'
,'N'
,'Y'
,''
,''
,''
,''
,'**ACTION_DISPLAY_NAME'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_ACTIONS'
,'ACTION_TYPE'
,'��� ��������'
,'*'
,'S'
,'1008'
,'N'
,'Y'
,''
,''
,''
,'8'
,'**ACTION_TYPE'
,'N'
,'N'
,'FORM_ACTIONS.ACTION_TYPE'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_ACTIONS'
,'CHILD_FORM_CODE'
,'�������� �����'
,'*'
,'S'
,'1014'
,'N'
,'Y'
,''
,''
,''
,'9'
,'*����� �������� ����� � ����� ����/����'
,'N'
,'N'
,'FORMS_LIST'
,''
,''
,''
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_ACTIONS'
,'CONFIRM_TEXT'
,'����� �������������'
,'*'
,'S'
,'1010'
,'N'
,'Y'
,''
,''
,''
,''
,'**CONFIRM_TEXT'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_ACTIONS'
,'DEFAULT_OLD_PARAM_PREFIX'
,'������ ������� �� ���������'
,'*'
,'S'
,'1007'
,'N'
,'Y'
,''
,''
,''
,''
,'**DEFAULT_OLD_PARAM_PREFIX'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_ACTIONS'
,'DEFAULT_PARAM_PREFIX'
,'������� �� ���������'
,'*'
,'S'
,'1006'
,'N'
,'Y'
,''
,''
,''
,''
,'**DEFAULT_PARAM_PREFIX'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_ACTIONS'
,'DISPLAY_NUMBER'
,'�������'
,'*'
,'N'
,'10'
,'N'
,'Y'
,''
,''
,''
,''
,'**DISPLAY_NUMBER'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,'1'
,''
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_ACTIONS'
,'DISPLAY_ON_TOOLBAR'
,''
,'*'
,'B'
,'1013'
,'N'
,'Y'
,''
,''
,''
,''
,'**DISPLAY_ON_TOOLBAR'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_ACTIONS'
,'FORM_CODE'
,'��� �����'
,'*'
,'S'
,'1001'
,'Y'
,'N'
,''
,''
,''
,''
,'*������������� ����'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,':form_code_for_filter'
,''
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_ACTIONS'
,'ICON_ID'
,'������'
,'*'
,'N'
,'1005'
,'N'
,'Y'
,''
,''
,''
,'9'
,'**ICON_ID'
,'N'
,'N'
,'ICONS'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_ACTIONS'
,'PROCEDURE_NAME'
,'PL/SQL ���������'
,'*'
,'S'
,'1003'
,'N'
,'Y'
,''
,''
,''
,''
,'*Name of the package or type subprogram'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_ACTIONS'
,'SHOW_SEPARATOR_BELOW'
,''
,'*'
,'B'
,'1012'
,'N'
,'Y'
,''
,''
,''
,''
,'**SHOW_SEPARATOR_BELOW'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');
/*  Form: FORM_ACTIONS. Entity: FORM_COLUMN_ATTR_VALS.  */
/*  Form: FORM_ACTIONS. Entity: FORM_TAB_PARENT_EXCLNS.  */
/*  Form: FORM_ACTIONS. Entity: APPS_PRIVS.  */

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'SC'
,'FORM_ACTIONS');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'BF'
,'FORM_ACTIONS');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'AAHR'
,'FORM_ACTIONS');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'TC'
,'FORM_ACTIONS');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'INS'
,'FORM_ACTIONS');


Declare l_clob   Clob := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>��� ��������.</b></font></span><div>�������� ���������.</div>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORM_ACTIONS' and column_code = 'ACTION_CODE'; End;
/
Declare l_clob   Clob := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>������������.</b></font></span><div>�������� ���������.</div>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORM_ACTIONS' and column_code = 'ACTION_DISPLAY_NAME'; End;
/
Declare l_clob   Clob := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>��� ��������.</b></font></span><div>�������� ���������.</div>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORM_ACTIONS' and column_code = 'ACTION_TYPE'; End;
/
Declare l_clob   Clob := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>�������� �����.</b></font></span><div>�������� ���������.</div>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORM_ACTIONS' and column_code = 'CHILD_FORM_CODE'; End;
/
Declare l_clob   Clob := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>����� �������������.</b></font></span><div>�������� ���������.</div>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORM_ACTIONS' and column_code = 'CONFIRM_TEXT'; End;
/
Declare l_clob   Clob := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>������ ������� �� ���������.</b></font></span><div>�������� ���������.</div>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORM_ACTIONS' and column_code = 'DEFAULT_OLD_PARAM_PREFIX'; End;
/
Declare l_clob   Clob := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>������� �� ���������.</b></font></span><div>�������� ���������.</div>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORM_ACTIONS' and column_code = 'DEFAULT_PARAM_PREFIX'; End;
/
Declare l_clob   Clob := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>�������.</b></font></span><div>�������� ���������.</div>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORM_ACTIONS' and column_code = 'DISPLAY_NUMBER'; End;
/
Declare l_clob   Clob := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>DISPLAY_ON_TOOLBAR.</b></font></span><div>�������� ���������.</div>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORM_ACTIONS' and column_code = 'DISPLAY_ON_TOOLBAR'; End;
/
Declare l_clob   Clob := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>������.</b></font></span><div>�������� ���������.</div>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORM_ACTIONS' and column_code = 'ICON_ID'; End;
/
Declare l_clob   Clob := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>PL/SQL ���������.</b></font></span><div>�������� ���������.</div>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORM_ACTIONS' and column_code = 'PROCEDURE_NAME'; End;
/
Declare l_clob   Clob := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>SHOW_SEPARATOR_BELOW.</b></font></span><div>�������� ���������.</div>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORM_ACTIONS' and column_code = 'SHOW_SEPARATOR_BELOW'; End;
/

Alter Table forms Enable VALIDATE Constraint forms_form_actions_fk;
Alter Table FORMS Enable All Triggers;

/*****************FORM_COLUMNS*********************/

Alter Table FORMS Disable All Triggers;
Alter Table forms Disable Constraint forms_form_actions_fk;
delete from APPS_PRIVS where form_code = 'FORM_COLUMNS';
delete from FORM_TAB_PARENT_EXCLNS where form_code = 'FORM_COLUMNS';
delete from FORM_COLUMN_ATTR_VALS where form_code = 'FORM_COLUMNS';
delete from FORM_COLUMNS where form_code = 'FORM_COLUMNS';
delete from FORM_COLUMNS$ where form_code = 'FORM_COLUMNS';
delete from FORM_ACTIONS where form_code = 'FORM_COLUMNS';
delete from FORM_TABS where form_code = 'FORM_COLUMNS';
delete from FORMS where form_code = 'FORM_COLUMNS';
/*  Form: FORM_COLUMNS. Entity: FORMS.  */

insert into FORMS("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID", "FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR", "OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH", "DESCRIPTION", "DOUBLE_CLICK_ACTION_CODE", "LOOKUP_WIDTH", "APPS_CODE", "EXPORT_ORDER") values (
'FORM_COLUMNS'
,''
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
,'��������� �������'
,'G'
,'Y'
,'4'
,'35%'
,'*'
,''
,'B'
,'Y'
,'343'
,'*'
,''
,''
,''
,'FC'
,'70');
/*  Form: FORM_COLUMNS. Entity: FORM_TABS.  */

insert into FORM_TABS("FORM_CODE", "TAB_CODE", "CHILD_FORM_CODE", "TAB_POSITION", "TAB_NAME", "NUMBER_OF_COLUMNS", "ICON_ID", "TAB_TYPE", "TAB_DISPLAY_NUMBER") values (
'FORM_COLUMNS'
,'ACTIONS'
,'FORM_COLUMN_ACTIONS'
,'R'
,'��������'
,''
,''
,'2'
,'4');

insert into FORM_TABS("FORM_CODE", "TAB_CODE", "CHILD_FORM_CODE", "TAB_POSITION", "TAB_NAME", "NUMBER_OF_COLUMNS", "ICON_ID", "TAB_TYPE", "TAB_DISPLAY_NUMBER") values (
'FORM_COLUMNS'
,'ADD'
,'LOOKUPS'
,'R'
,'��������������'
,'4'
,'28'
,'1'
,'2');

insert into FORM_TABS("FORM_CODE", "TAB_CODE", "CHILD_FORM_CODE", "TAB_POSITION", "TAB_NAME", "NUMBER_OF_COLUMNS", "ICON_ID", "TAB_TYPE", "TAB_DISPLAY_NUMBER") values (
'FORM_COLUMNS'
,'COL_ATTRS'
,'FORM_COLUMN_ATTR_VALS'
,'R'
,'��������'
,''
,'12'
,'2'
,'');

insert into FORM_TABS("FORM_CODE", "TAB_CODE", "CHILD_FORM_CODE", "TAB_POSITION", "TAB_NAME", "NUMBER_OF_COLUMNS", "ICON_ID", "TAB_TYPE", "TAB_DISPLAY_NUMBER") values (
'FORM_COLUMNS'
,'HELP'
,''
,''
,'������'
,'6'
,'43'
,'1'
,'3');

insert into FORM_TABS("FORM_CODE", "TAB_CODE", "CHILD_FORM_CODE", "TAB_POSITION", "TAB_NAME", "NUMBER_OF_COLUMNS", "ICON_ID", "TAB_TYPE", "TAB_DISPLAY_NUMBER") values (
'FORM_COLUMNS'
,'MAIN'
,''
,'R'
,'��������'
,'6'
,'20'
,'1'
,'1');
/*  Form: FORM_COLUMNS. Entity: FORM_ACTIONS.  */

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'FORM_COLUMNS'
,'DEL'
,'&fc_schema_owner..FORM_COLUMNS_PKG.P_DELETE'
,'�������'
,'48'
,''
,''
,'3'
,'130'
,''
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'FORM_COLUMNS'
,'EDIT'
,''
,'�������������'
,'50'
,''
,''
,'8'
,'115'
,'�� ��������?'
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'FORM_COLUMNS'
,'EXP'
,''
,'�������'
,'43'
,''
,''
,'12'
,'200'
,'�� ��������?'
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'FORM_COLUMNS'
,'INS'
,''
,'�������'
,'47'
,''
,''
,'1'
,'110'
,''
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'FORM_COLUMNS'
,'REFRESH'
,''
,'��������'
,'15'
,''
,''
,'2'
,'10'
,'�� ��������?'
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'FORM_COLUMNS'
,'UPD'
,'&fc_schema_owner..FORM_COLUMNS_PKG.P_INS_UPD'
,'���������'
,'46'
,''
,''
,'2'
,'120'
,'�� ��������?'
,''
,'N'
,'Y'
,''
,'');
/*  Form: FORM_COLUMNS. Entity: FORM_COLUMNS$.  */

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'3'
,'VARCHAR2'
,'1020'
,'COLUMN_CODE'
,'11'
,'0'
,'0'
,'FORM_COLUMNS'
,'Y'
,'*'
,'*������������� ���� (�� �������)');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'4'
,'VARCHAR2'
,'1020'
,'COLUMN_DATA_TYPE'
,'16'
,'0'
,'0'
,'FORM_COLUMNS'
,''
,'*'
,'*��� ������ (FORM_COLUMNS.DATA_TYPE)');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'13'
,'VARCHAR2'
,'8000'
,'COLUMN_DESCRIPTION'
,'18'
,'0'
,'0'
,'FORM_COLUMNS'
,''
,'*'
,'*�������� ���� (��������� ��� ������������)');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'1'
,'NUMBER'
,'22'
,'COLUMN_DISPLAY_NUMBER'
,'21'
,'0'
,'0'
,'FORM_COLUMNS'
,''
,'*'
,'*���������� ����� ����������� � �������');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'6'
,'VARCHAR2'
,'1020'
,'COLUMN_DISPLAY_SIZE'
,'19'
,'0'
,'0'
,'FORM_COLUMNS'
,''
,'*'
,'*������ ���� � ���������');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'5'
,'VARCHAR2'
,'1020'
,'COLUMN_USER_NAME'
,'16'
,'0'
,'0'
,'FORM_COLUMNS'
,''
,'*'
,'*���������������� ��� ����');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'25'
,'VARCHAR2'
,'40'
,'DEFAULT_ORDERBY_NUMBER'
,'22'
,'0'
,'0'
,'FORM_COLUMNS'
,''
,'*'
,'*������� ���������� ��� �������� �����. "-" ����� ����� - ���������� �� ��������');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'26'
,'VARCHAR2'
,'1020'
,'DEFAULT_VALUE'
,'13'
,'0'
,'0'
,'FORM_COLUMNS'
,''
,'*'
,'*Default value for the argument');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'28'
,'VARCHAR2'
,'40'
,'EDITOR_COLS_SPAN'
,'16'
,'0'
,'0'
,'FORM_COLUMNS'
,''
,'*'
,'*�������� - ���������� �������, ���������� ����� (item.setColSpan)');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'29'
,'VARCHAR2'
,'4'
,'EDITOR_END_ROW_FLAG'
,'19'
,'0'
,'0'
,'FORM_COLUMNS'
,''
,'*'
,'*item.setEndRow');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'20'
,'VARCHAR2'
,'1020'
,'EDITOR_HEIGHT'
,'13'
,'0'
,'0'
,'FORM_COLUMNS'
,''
,'*'
,'*������ ���� � �������� ��������������');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'31'
,'VARCHAR2'
,'1020'
,'EDITOR_ON_ENTER_KEY_ACTION'
,'26'
,'0'
,'0'
,'FORM_COLUMNS'
,''
,'*'
,'*�������� �� ������� Enter');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'11'
,'VARCHAR2'
,'1020'
,'EDITOR_TAB_CODE'
,'15'
,'0'
,'0'
,'FORM_COLUMNS'
,''
,'*'
,'*������ �� �������� ����� ��������������. ���� �� ������� - ������������ ������ � �����');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'27'
,'VARCHAR2'
,'4'
,'EDITOR_TITLE_ORIENTATION'
,'24'
,'0'
,'0'
,'FORM_COLUMNS'
,''
,'*'
,'*item.setTitleOrientation');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'16'
,'VARCHAR2'
,'4'
,'EXISTS_IN_METADATA_FLAG'
,'23'
,'0'
,'0'
,'FORM_COLUMNS'
,''
,'*'
,'**EXISTS_IN_METADATA_FLAG');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'17'
,'VARCHAR2'
,'4'
,'EXISTS_IN_QUERY_FLAG'
,'20'
,'0'
,'0'
,'FORM_COLUMNS'
,''
,'*'
,'**EXISTS_IN_QUERY_FLAG');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'12'
,'VARCHAR2'
,'8'
,'FIELD_TYPE'
,'10'
,'0'
,'0'
,'FORM_COLUMNS'
,''
,'*'
,'*��� ����, ����� ��� ������ � �����');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'2'
,'VARCHAR2'
,'1020'
,'FORM_CODE'
,'9'
,'0'
,'0'
,'FORM_COLUMNS'
,'Y'
,'*'
,'*������������� ����');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'22'
,'CLOB'
,'32767'
,'HELP_TEXT'
,'9'
,'0'
,'0'
,'FORM_COLUMNS'
,''
,'*'
,'*HTML ����� ��� ��������� � ����������');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'19'
,'VARCHAR2'
,'1020'
,'HOVER_COLUMN_CODE'
,'17'
,'0'
,'0'
,'FORM_COLUMNS'
,''
,'*'
,'*���� ��� �� �����, ������� �������� ���������. ���� SHOW_HOVER_FLAG = ''Y'' � HOVER_COLUMN_CODE - ��������� ������� �� �������� ���� (COLUMN_CODE)');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'14'
,'VARCHAR2'
,'4'
,'IS_FROZEN_FLAG'
,'14'
,'0'
,'0'
,'FORM_COLUMNS'
,''
,'*'
,'*������������ ����?');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'18'
,'VARCHAR2'
,'1020'
,'LOOKUP_CODE'
,'11'
,'0'
,'0'
,'FORM_COLUMNS'
,''
,'*'
,'*������ �� ����� - ������ ��� �������');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'30'
,'VARCHAR2'
,'1020'
,'LOOKUP_DISPLAY_VALUE'
,'20'
,'0'
,'0'
,'FORM_COLUMNS'
,''
,'*'
,'*���� �������, ������������ ������������ - ��� ������� �������');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'21'
,'VARCHAR2'
,'4'
,'LOOKUP_FIELD_TYPE'
,'17'
,'0'
,'0'
,'FORM_COLUMNS'
,''
,'*'
,'*��. Lookup FORM_COLUMNS.LOOKUP_FIELD_TYPE');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'32'
,'VARCHAR2'
,'1020'
,'LOOKUP_NAME'
,'11'
,'0'
,'0'
,'FORM_COLUMNS'
,''
,'*'
,'*���������������� ���');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'7'
,'VARCHAR2'
,'4'
,'PIMARY_KEY_FLAG'
,'15'
,'0'
,'0'
,'FORM_COLUMNS'
,''
,'*'
,'*������� ����, ��� ���� �������� ��������� ������ (Y). ����� - �� ��������.');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'15'
,'VARCHAR2'
,'4'
,'SHOW_HOVER_FLAG'
,'15'
,'0'
,'0'
,'FORM_COLUMNS'
,''
,'*'
,'*���������� ����������� ���������-�������� ����');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'8'
,'VARCHAR2'
,'4'
,'SHOW_ON_GRID'
,'12'
,'0'
,'0'
,'FORM_COLUMNS'
,''
,'*'
,'*���������� � �����');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'23'
,'VARCHAR2'
,'1020'
,'TEXT_MASK'
,'9'
,'0'
,'0'
,'FORM_COLUMNS'
,''
,'*'
,'*��������� ����� ��� ����. ��. �������� � ����������');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'10'
,'VARCHAR2'
,'8'
,'TREE_FIELD_TYPE'
,'15'
,'0'
,'0'
,'FORM_COLUMNS'
,''
,'*'
,'*��� ���� ��� ������ (Id, ParentId, ChildCount...)');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'9'
,'VARCHAR2'
,'8000'
,'TREE_INITIALIZATION_VALUE'
,'25'
,'0'
,'0'
,'FORM_COLUMNS'
,''
,'*'
,'*���� �� ����� � ��� ����� - "������" - ������������ ��� ������ ������ ������ ��� �������������. ���������� ����������� Start With ����������� ��������');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'24'
,'VARCHAR2'
,'1020'
,'VALIDATION_REGEXP'
,'17'
,'0'
,'0'
,'FORM_COLUMNS'
,''
,'*'
,'*���������� ��������� ��� ���������� ���������');
/*  Form: FORM_COLUMNS. Entity: FORM_COLUMNS.  */

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_COLUMNS'
,'COLUMN_CODE'
,'���'
,'40%'
,'S'
,'30'
,'Y'
,'Y'
,''
,''
,'MAIN'
,''
,'*������������� ���� (�� �������)'
,'N'
,'Y'
,''
,'COLUMN_DESCRIPTION'
,''
,''
,''
,''
,''
,''
,''
,''
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_COLUMNS'
,'COLUMN_DATA_TYPE'
,'��� ������'
,'40'
,'S'
,'50'
,'N'
,'N'
,''
,''
,'MAIN'
,'8'
,'*��� ������'
,'N'
,'N'
,'FORM_COLUMNS.DATA_TYPE'
,''
,''
,''
,''
,''
,''
,''
,''
,'L'
,'N'
,'2'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_COLUMNS'
,'COLUMN_DESCRIPTION'
,'��������'
,'150'
,'S'
,'900'
,'N'
,'N'
,''
,''
,'HELP'
,''
,'������� �������� ���� (����������� ��������� ��� ������������)'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_COLUMNS'
,'COLUMN_DISPLAY_NUMBER'
,'�'
,'22'
,'N'
,'15'
,'N'
,'Y'
,''
,''
,'MAIN'
,''
,'*���������� ����� ����������� � �������'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,'1'
,''
,'L'
,'N'
,'1'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_COLUMNS'
,'COLUMN_DISPLAY_SIZE'
,'������'
,'40'
,'S'
,'60'
,'N'
,'N'
,''
,''
,'MAIN'
,''
,'������ ���� � ��������, ��������� ��� * - ����'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'L'
,'Y'
,'1'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_COLUMNS'
,'COLUMN_USER_NAME'
,'�����. ���'
,'*'
,'S'
,'45'
,'N'
,'Y'
,''
,''
,'MAIN'
,''
,'*���������������� ��� ����'
,'N'
,'Y'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_COLUMNS'
,'DEFAULT_ORDERBY_NUMBER'
,'� ����������'
,'*'
,'S'
,'1025'
,'N'
,'N'
,''
,''
,'MAIN'
,''
,'*������� ���������� ��� �������� �����. "-" ����� ����� - ���������� �� ��������'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'L'
,'N'
,'1'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_COLUMNS'
,'DEFAULT_VALUE'
,'�� ���������'
,'*'
,'S'
,'1026'
,'N'
,'N'
,''
,''
,'MAIN'
,''
,'�������� �� ��������� ��� ����� �������*'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'L'
,'Y'
,'2'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_COLUMNS'
,'EDITOR_COLS_SPAN'
,'�������� - ���-�� �������'
,'*'
,'S'
,'1028'
,'N'
,'N'
,''
,''
,'ADD'
,''
,'*�������� - ���������� �������, ���������� ����� (item.setColSpan)'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_COLUMNS'
,'EDITOR_END_ROW_FLAG'
,'�������� - � ����� ������'
,'*'
,'B'
,'1029'
,'N'
,'N'
,''
,''
,'ADD'
,''
,'***item.setEndRow'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_COLUMNS'
,'EDITOR_HEIGHT'
,'������ ����'
,'*'
,'S'
,'1020'
,'N'
,'N'
,''
,''
,'ADD'
,''
,'*������ ���� � �������� ��������������'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_COLUMNS'
,'EDITOR_ON_ENTER_KEY_ACTION'
,'�������� �� ������� Enter'
,'*'
,'S'
,'1031'
,'N'
,'N'
,''
,''
,'ADD'
,'9'
,'*�������� �� ������� Enter'
,'N'
,'N'
,'DBLCLICK_FORM_ACT_LIST'
,''
,''
,''
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_COLUMNS'
,'EDITOR_TAB_CODE'
,'��������'
,'80'
,'S'
,'80'
,'N'
,'N'
,''
,''
,'MAIN'
,'9'
,'*������������� ��������'
,'N'
,'N'
,'FORM_TABS_LIST'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_COLUMNS'
,'EDITOR_TITLE_ORIENTATION'
,'TitleOrientation'
,'*'
,'S'
,'1027'
,'N'
,'N'
,''
,''
,'ADD'
,''
,'*item.setTitleOrientation'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_COLUMNS'
,'EXISTS_IN_METADATA_FLAG'
,'� ����������?'
,'*'
,'B'
,'1016'
,'N'
,'Y'
,''
,''
,''
,''
,'���� �� ��������� ��� ������� ���� � ������� FORM_COLUMNS'
,'N'
,'Y'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_COLUMNS'
,'EXISTS_IN_QUERY_FLAG'
,'� �������?'
,'*'
,'B'
,'1017'
,'N'
,'Y'
,''
,''
,''
,''
,'���������� �� ���� � �������?'
,'N'
,'Y'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_COLUMNS'
,'FIELD_TYPE'
,'��� ����'
,'40'
,'S'
,'90'
,'N'
,'N'
,''
,''
,'MAIN'
,'10'
,'*��� ����, ����� ��� ������ � �����'
,'N'
,'N'
,'FORM_COLUMNS.FIELD_TYPE'
,''
,''
,''
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_COLUMNS'
,'FORM_CODE'
,'�����'
,'100'
,'S'
,'20'
,'Y'
,'N'
,''
,'1'
,'MAIN'
,'9'
,'*������������� ����'
,'N'
,'N'
,'FORMS_LIST'
,''
,''
,'1'
,''
,''
,''
,''
,':form_code_for_filter'
,'L'
,'Y'
,'2'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_COLUMNS'
,'HELP_TEXT'
,'Will become item help.'
,'*'
,'S'
,'1022'
,'N'
,'N'
,''
,''
,'HELP'
,'5'
,'*Will become item help.'
,'N'
,'N'
,''
,''
,'400'
,''
,''
,''
,''
,''
,''
,'T'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_COLUMNS'
,'HOVER_COLUMN_CODE'
,'���� ���������'
,'*'
,'S'
,'875'
,'N'
,'N'
,''
,''
,'HELP'
,'9'
,'*���� ��� �� �����, ������� �������� ���������. ���� SHOW_HOVER_FLAG = ''Y'' � HOVER_COLUMN_CODE - ��������� ������� �� �������� ���� (COLUMN_CODE)'
,'N'
,'N'
,'COLUMNS_LIST'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_COLUMNS'
,'IS_FROZEN_FLAG'
,'����������'
,'80'
,'B'
,'850'
,'N'
,'N'
,''
,''
,'MAIN'
,''
,'*������������ ����?'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'T'
,'N'
,'1'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_COLUMNS'
,'LOOKUP_CODE'
,'������'
,'*'
,'S'
,'160'
,'N'
,'N'
,''
,''
,'MAIN'
,'9'
,'*��������� ������������ (ID)'
,'N'
,'N'
,'LOOKUPS_LIST'
,''
,''
,''
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,'LOOKUP_NAME'
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_COLUMNS'
,'LOOKUP_DISPLAY_VALUE'
,'������: ������������ ����'
,'*'
,'S'
,'1030'
,'N'
,'N'
,''
,''
,'ADD'
,'9'
,'*���� �������, ������������ ������������ - ��� ������� �������'
,'N'
,'N'
,'COLUMNS_LIST'
,''
,''
,''
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_COLUMNS'
,'LOOKUP_FIELD_TYPE'
,'��� ���� � ������'
,'*'
,'S'
,'1022'
,'N'
,'N'
,''
,''
,'MAIN'
,'8'
,'���� ����� ������������ ��� Lookup - ����� �� ����� �������� ��������������� � ����� ��������� � ��, ����� ���� ����� ������������ ������������.'
,'N'
,'N'
,'FORM_COLUMNS.LOOKUP_FIELD_TYPE'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_COLUMNS'
,'LOOKUP_NAME'
,'���������������� ���'
,'*'
,'S'
,'1031'
,'N'
,'N'
,''
,''
,''
,''
,'*���������������� ���'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_COLUMNS'
,'PIMARY_KEY_FLAG'
,'�������. ����'
,'80'
,'B'
,'860'
,'N'
,'N'
,''
,''
,'MAIN'
,''
,'*������� ����, ��� ���� �������� ��������� ������ (Y). ����� - �� ��������.'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'T'
,'N'
,'1'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_COLUMNS'
,'SHOW_HOVER_FLAG'
,'���������'
,'80'
,'B'
,'870'
,'N'
,'N'
,''
,''
,'HELP'
,''
,'*���������� ����������� ���������-�������� ����'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_COLUMNS'
,'SHOW_ON_GRID'
,'���������� � �������'
,'80'
,'B'
,'880'
,'N'
,'N'
,''
,''
,'MAIN'
,''
,'���������� � �����'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'T'
,'Y'
,'1'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_COLUMNS'
,'TEXT_MASK'
,'�����'
,'*'
,'S'
,'1023'
,'N'
,'N'
,''
,''
,'ADD'
,''
,'*��������� ����� ��� ����. ��. �������� � ����������'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_COLUMNS'
,'TREE_FIELD_TYPE'
,'��� ��� ������'
,'40'
,'S'
,'70'
,'N'
,'N'
,''
,''
,'ADD'
,'8'
,'*��� ���� ��� ������ (Id, ParentId, ChildCount...)'
,'N'
,'N'
,'FORM_COLUMNS.TREE_FIELD_TYPE'
,''
,''
,''
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_COLUMNS'
,'TREE_INITIALIZATION_VALUE'
,'����. ������'
,'80'
,'S'
,'1000'
,'N'
,'N'
,''
,''
,'ADD'
,''
,'*���� �� ����� � ��� ����� - "������" - ������������ ��� ������ ������ ������ ��� �������������. ���������� ����������� Start With ����������� ��������'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_COLUMNS'
,'VALIDATION_REGEXP'
,'���������'
,'*'
,'S'
,'1024'
,'N'
,'N'
,''
,''
,'ADD'
,''
,'*���������� ��������� ��� ���������� ���������'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');
/*  Form: FORM_COLUMNS. Entity: FORM_COLUMN_ATTR_VALS.  */
/*  Form: FORM_COLUMNS. Entity: FORM_TAB_PARENT_EXCLNS.  */
/*  Form: FORM_COLUMNS. Entity: APPS_PRIVS.  */

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'SC'
,'FORM_COLUMNS');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'BF'
,'FORM_COLUMNS');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'AAHR'
,'FORM_COLUMNS');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'TC'
,'FORM_COLUMNS');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'INS'
,'FORM_COLUMNS');


Declare l_clob   Clob := '<br>'; Begin Update FORMS Set description = l_clob Where form_code = 'FORM_COLUMNS'; End;
/
Declare l_clob   Clob := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>��� ����.</b></font></span><div>���������� ������������� ������� ������� - �������� � �������� �����.</div>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORM_COLUMNS' and column_code = 'COLUMN_CODE'; End;
/
Declare l_clob   Clob := '<font class="Apple-style-span" face="''times new roman'', times, serif"><span class="Apple-style-span" style="font-size: medium;"><b>��� ������.</b></span></font><div>���� �� ������������. ������������� ������������� �� ��� ������� �������.</div>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORM_COLUMNS' and column_code = 'COLUMN_DATA_TYPE'; End;
/
Declare l_clob   Clob := '<span class="Apple-style-span" style="font-family: Arial; font-size: 13px; "><h2><font size="-1">com.smartgwt.client.docs</font>&nbsp;<br>Interface SqlVsJPA</h2><hr><dl><dt><pre>public interface <b>SqlVsJPA</b></pre></dt></dl><p></p><h3>SQL DataSource vs JPA, EJB, Ibatis and other technologies</h3>If you are free to choose which persistence mechanism your application will use, you should consider using the SmartGWT SQL DataSource instead of a more heavyweight, bean-based solution. This article discusses the advantages of doing so.<p><b>Simplicity</b></p></span>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORM_COLUMNS' and column_code = 'COLUMN_DESCRIPTION'; End;
/
Declare l_clob   Clob := '<span class="Apple-style-span" style="font-size: medium;"><font class="Apple-style-span" face="''times new roman'', times, serif"><b>�</b></font></span><div>�������� �� ������� ����������� ������� � ������� � � ����� ��������������.</div>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORM_COLUMNS' and column_code = 'COLUMN_DISPLAY_NUMBER'; End;
/
Declare l_clob   Clob := '<b><font class="Apple-style-span" face="''times new roman'', times, serif"><span class="Apple-style-span" style="font-size: medium;">������</span></font></b>.<div>������ �������� � ���� ������ ����� ���� � ���������.</div><div>� ������, ���� �������� ����� �����, ������ ������� ������������ � ��������.</div><div>���� ������� ������ � ��������� - ������ ������������ ��� ��������� ������ ������� � ����� ������ ������� ����� �������.</div><div>�������� "<b>*</b>" - �������������� ������ ������.</div>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORM_COLUMNS' and column_code = 'COLUMN_DISPLAY_SIZE'; End;
/
Declare l_clob   Clob := '<span class="Apple-style-span" style="white-space: pre; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b><span class="Apple-style-span" style="font-size: medium;">�����. ���.</span></b></font></span><div><span class="Apple-style-span" style="white-space: pre;"><font class="Apple-style-span" face="''times new roman'', times, serif"><span class="Apple-style-span" style="font-size: small;">��� �������, ������������ ������������. ���� �� ������� - ������������ �������� ���� <i>COLUMN_CODE</i>.</span></font></span></div><div><font class="Apple-style-span" face="''times new roman'', times, serif"><span class="Apple-style-span" style="font-size: small; white-space: pre;"><br></span></font></div>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORM_COLUMNS' and column_code = 'COLUMN_USER_NAME'; End;
/
Declare l_clob   Clob := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>� ����������.</b></font></span><div>�������� ���������.</div>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORM_COLUMNS' and column_code = 'DEFAULT_ORDERBY_NUMBER'; End;
/
Declare l_clob   Clob := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>�� ���������.</b></font></span><div>�������� ���������.</div>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORM_COLUMNS' and column_code = 'DEFAULT_VALUE'; End;
/
Declare l_clob   Clob := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>�������� - ���-�� �������.</b></font></span><div>�������� ���������.</div>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORM_COLUMNS' and column_code = 'EDITOR_COLS_SPAN'; End;
/
Declare l_clob   Clob := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>�������� - � ����� ������.</b></font></span><div>�������� ���������.</div>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORM_COLUMNS' and column_code = 'EDITOR_END_ROW_FLAG'; End;
/
Declare l_clob   Clob := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>������ ����.</b></font></span><div>�������� ���������.</div>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORM_COLUMNS' and column_code = 'EDITOR_HEIGHT'; End;
/
Declare l_clob   Clob := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>�������� �� ������� Enter.</b></font></span><div>�������� ���������.</div>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORM_COLUMNS' and column_code = 'EDITOR_ON_ENTER_KEY_ACTION'; End;
/
Declare l_clob   Clob := '<b><font class="Apple-style-span" face="''times new roman'', times, serif"><span class="Apple-style-span" style="font-size: medium;">��������.</span></font></b><div>������ �� ������� ����� ��������������.</div><div><div>� ������, ���� ���� ��������� - ���� ������������ � � ������� (�����), � � ����� �������������� ������.</div><div>��� ������������� ���������� ���� ������ � ����� �������������� - ����������� ��������<i> SHOW_ON_GRID</i> ("<b>����������</b>")</div></div>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORM_COLUMNS' and column_code = 'EDITOR_TAB_CODE'; End;
/
Declare l_clob   Clob := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>TitleOrientation.</b></font></span><div>�������� ���������.</div>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORM_COLUMNS' and column_code = 'EDITOR_TITLE_ORIENTATION'; End;
/
Declare l_clob   Clob := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>� ����������?.</b></font></span><div>�������� ���������.</div>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORM_COLUMNS' and column_code = 'EXISTS_IN_METADATA_FLAG'; End;
/
Declare l_clob   Clob := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>� �������?.</b></font></span><div>�������� ���������.</div>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORM_COLUMNS' and column_code = 'EXISTS_IN_QUERY_FLAG'; End;
/
Declare l_clob   Clob := '<span class="Apple-style-span" style="white-space: pre; "><font class="Apple-style-span" face="''times new roman'', times, serif"><span class="Apple-style-span" style="font-size: medium;"><b>��� ����.</b></span></font></span><div><span class="Apple-style-span" style="white-space: pre;">������������ ��� ����������� ������������ ��������� ��� ��������� �����.</span></div><div><span class="Apple-style-span" style="white-space: pre;">� ������ ������ ���������� ����� ����:</span></div><div><span class="Apple-style-span" style="white-space: pre;"><br></span></div><div><span class="Apple-style-span" style="white-space: pre;"><b>������������ ����������� ����� ��������� (� �����������) </b>- ���� ���������� ��� ����� �����������. ��� ��������� ���� ����� ������������ ���������� ����� ����� �����������.</span></div><div><span class="Apple-style-span" style="white-space: pre;"><span class="Apple-tab-span" style="white-space:pre">	</span>���� ��� ����� �� ��������� - ���������� ������ ���������� ������ ����� �� ������ ������ ������-�����.</span></div><div><span class="Apple-style-span" style="white-space: pre;"><span class="Apple-tab-span" style="white-space:pre">	</span><b>������:</b> <i>FORMS2.DETAIL_FORM.</i></span></div><div><span class="Apple-style-span" style="white-space: pre;">
<b>������������ ����������� ����� ������������� (��� �����������)</b> -&nbsp;���� ���������� ��� ����� �����������. ��� ��������� ���� ����� <b>������</b> ������������</span></div><div><span class="Apple-style-span" style="white-space: pre;"><span class="Apple-tab-span" style="white-space:pre">	</span>���������� ����� ����� �����������.<span class="Apple-style-span" style="white-space: normal; "><div><span class="Apple-style-span" style="white-space: pre; "><span class="Apple-tab-span" style="white-space: pre; ">	</span><b>������:</b>&nbsp;<i>FORMS2.DETAIL_FORM_MULTI.</i></span></div><div><span class="Apple-style-span" style="white-space: pre;"><br></span></div></span><b>������ </b>-&nbsp;xx</span></div><div><span class="Apple-style-span" style="white-space: pre;"><span class="Apple-tab-span" style="white-space:pre">	</span>��</span></div><div><span class="Apple-style-span" style="white-space: pre;"><span class="Apple-tab-span" style="white-space:pre">	</span><b>������:</b> ��
<b>��������� ��������<span class="Apple-style-span" style="font-weight: normal; "> -&nbsp;xx</span><span class="Apple-style-span" style="font-weight: normal; white-space: normal; "><div><span class="Apple-style-span" style="white-space: pre; "><span class="Apple-tab-span" style="white-space: pre; ">	</span>��</span></div><div><span class="Apple-style-span" style="white-space: pre; "><span class="Apple-tab-span" style="white-space: pre; ">	</span><b>������:</b> ��</span></div></span>
HTML editor<span class="Apple-style-span" style="font-weight: normal; "> -&nbsp;xx</span><span class="Apple-style-span" style="font-weight: normal; white-space: normal; "><div><span class="Apple-style-span" style="white-space: pre; "><span class="Apple-tab-span" style="white-space: pre; ">	</span>��</span></div><div><span class="Apple-style-span" style="white-space: pre; "><span class="Apple-tab-span" style="white-space: pre; ">	</span><b>������:</b> ��</span></div></span>
��������� ����� (���������������)<span class="Apple-style-span" style="font-weight: normal; "> -&nbsp;xx</span><span class="Apple-style-span" style="font-weight: normal; white-space: normal; "><div><span class="Apple-style-span" style="white-space: pre; "><span class="Apple-tab-span" style="white-space: pre; ">	</span>��</span></div><div><span class="Apple-style-span" style="white-space: pre; "><span class="Apple-tab-span" style="white-space: pre; ">	</span><b>������:</b> ��</span></div></span>
iFrame<span class="Apple-style-span" style="font-weight: normal; "> -&nbsp;xx</span><span class="Apple-style-span" style="font-weight: normal; white-space: normal; "><div><span class="Apple-style-span" style="white-space: pre; "><span class="Apple-tab-span" style="white-space: pre; ">	</span>��</span></div><div><span class="Apple-style-span" style="white-space: pre; "><span class="Apple-tab-span" style="white-space: pre; ">	</span><b>������:</b> ��</span></div></span>
Lookup �������<span class="Apple-style-span" style="font-weight: normal; "> -&nbsp;xx</span><span class="Apple-style-span" style="font-weight: normal; white-space: normal; "><div><span class="Apple-style-span" style="white-space: pre; "><span class="Apple-tab-span" style="white-space: pre; ">	</span>��</span></div><div><span class="Apple-style-span" style="white-space: pre; "><span class="Apple-tab-span" style="white-space: pre; ">	</span><b>������:</b> ��</span></div></span>
Lookup-�����<span class="Apple-style-span" style="font-weight: normal; "> -&nbsp;xx</span></b></span><span class="Apple-style-span" style="white-space: pre;"><b>
</b></span></div><div><span class="Apple-style-span" style="white-space: pre; "><span class="Apple-tab-span" style="white-space: pre; ">	</span>��</span></div><div><span class="Apple-style-span" style="white-space: pre; "><span class="Apple-tab-span" style="white-space: pre; ">	</span><b>������:</b> ��</span></div>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORM_COLUMNS' and column_code = 'FIELD_TYPE'; End;
/
Declare l_clob   Clob := '<span class="Apple-style-span" style="border-collapse: separate; color: rgb(0, 0, 0); font-family: ''Times New Roman''; font-size: medium; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; orphans: 2; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px;"><span class="Apple-style-span" style="font-family: arial,sans-serif; font-size: 13px;"><h2 style="font-size: large;"><span class="Apple-style-span" style="font-family: Arial, sans-serif; font-size: 11px; font-weight: normal; color: rgb(51, 51, 51); "><span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>�����.</b></font></span><div>������ �� �����-�������� ������� ����.</div></span></h2></span></span>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORM_COLUMNS' and column_code = 'FORM_CODE'; End;
/
Declare l_clob   Clob := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>Will become item help..</b></font></span><div>�������� ���������.</div>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORM_COLUMNS' and column_code = 'HELP_TEXT'; End;
/
Declare l_clob   Clob := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>���� ���������.</b></font></span><div>�������� ���������.</div>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORM_COLUMNS' and column_code = 'HOVER_COLUMN_CODE'; End;
/
Declare l_clob   Clob := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>����������.</b></font></span><div>�������� ���������.</div>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORM_COLUMNS' and column_code = 'IS_FROZEN_FLAG'; End;
/
Declare l_clob   Clob := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>������.</b></font></span><div>�������� ���������.</div>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORM_COLUMNS' and column_code = 'LOOKUP_CODE'; End;
/
Declare l_clob   Clob := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>������: ������������ ����.</b></font></span><div>�������� ���������.</div>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORM_COLUMNS' and column_code = 'LOOKUP_DISPLAY_VALUE'; End;
/
Declare l_clob   Clob := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>��� ���� � ������.</b></font></span><div>�������� ���������.</div>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORM_COLUMNS' and column_code = 'LOOKUP_FIELD_TYPE'; End;
/
Declare l_clob   Clob := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>�������. ����.</b></font></span><div>�������� ���������.</div>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORM_COLUMNS' and column_code = 'PIMARY_KEY_FLAG'; End;
/
Declare l_clob   Clob := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>���������.</b></font></span><div>�������� ���������.</div>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORM_COLUMNS' and column_code = 'SHOW_HOVER_FLAG'; End;
/
Declare l_clob   Clob := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>���������� � �������.</b></font></span><div>�������� ���������.</div>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORM_COLUMNS' and column_code = 'SHOW_ON_GRID'; End;
/
Declare l_clob   Clob := '<span class="Apple-style-span" style="border-collapse: separate; color: rgb(0, 0, 0); font-family: ''Times New Roman''; font-size: medium; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; orphans: 2; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px;"><span class="Apple-style-span" style="color: rgb(51, 51, 51); font-family: Verdana,sans-serif; font-size: 11px;"><p>TextItems support a masked entry to restrict and format entry.</p><p>Overview of available mask characters</p><p><table class="normal" style="font-family: Verdana,sans-serif; font-size: 11px; color: rgb(51, 51, 51);"><tbody><tr><th>Character</th><th>Description</th></tr><tr><td>0</td><td>Digit (0 through 9) or plus [+] or minus [-] signs</td></tr><tr><td>9</td><td>Digit or space</td></tr><tr><td>#</td><td>Digit</td></tr><tr><td>L</td><td>Letter (A through Z)</td></tr><tr><td>?</td><td>Letter (A through Z) or space</td></tr><tr><td>A</td><td>Letter or digit</td></tr><tr><td>a</td><td>Letter or digit</td></tr><tr><td>C</td><td>Any character or space</td></tr><tr><td>&nbsp;</td></tr><tr><td>&lt;</td><td>Causes all characters that follow to be converted to lowercase</td></tr><tr><td>&gt;</td><td>Causes all characters that follow to be converted to uppercase</td></tr></tbody></table></p><p>Any character not matching one of the above mask characters or that is escaped with a backslash (\) is considered to be a literal.</p><p>Custom mask characters can be defined by standard regular expression character set or range. For example, a hexadecimal color code mask could be:</p><ul><li>Color: \#&gt;[0-9A-F][0-9A-F][0-9A-F][0-9A-F][0-9A-F][0-9A-F]</li></ul></span></span>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORM_COLUMNS' and column_code = 'TEXT_MASK'; End;
/
Declare l_clob   Clob := '<span class="Apple-style-span" style="white-space: pre; "><font class="Apple-style-span" face="''times new roman'', times, serif"><span class="Apple-style-span" style="font-size: medium;"><b>��� ��� ������.</b></span></font></span><div><span class="Apple-style-span" style="white-space: pre;">��� ���� � ����� "T" ("������") ���������� ��� �������, �������� - ������������� ������,</span></div><div><span class="Apple-style-span" style="white-space: pre;">������ �� ��������, ���������� �������� �����, �������� �� ����� ��� �������� ���������, ������ � ��.</span></div>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORM_COLUMNS' and column_code = 'TREE_FIELD_TYPE'; End;
/
Declare l_clob   Clob := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>����. ������.</b></font></span><div>�������� ���������.</div>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORM_COLUMNS' and column_code = 'TREE_INITIALIZATION_VALUE'; End;
/
Declare l_clob   Clob := '<div><b>��������</b>, �������� ������������ e-mail:</div><div>^([a-zA-Z0-9_.\-+])+@(([a-zA-Z0-9\-])+\.)+[a-zA-Z0-9]{2,4}$</div>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORM_COLUMNS' and column_code = 'VALIDATION_REGEXP'; End;
/

Alter Table forms Enable VALIDATE Constraint forms_form_actions_fk;
Alter Table FORMS Enable All Triggers;

/*****************FORMS*********************/

Alter Table FORMS Disable All Triggers;
Alter Table forms Disable Constraint forms_form_actions_fk;
delete from APPS_PRIVS where form_code = 'FORMS';
delete from FORM_TAB_PARENT_EXCLNS where form_code = 'FORMS';
delete from FORM_COLUMN_ATTR_VALS where form_code = 'FORMS';
delete from FORM_COLUMNS where form_code = 'FORMS';
delete from FORM_COLUMNS$ where form_code = 'FORMS';
delete from FORM_ACTIONS where form_code = 'FORMS';
delete from FORM_TABS where form_code = 'FORMS';
delete from FORMS where form_code = 'FORMS';
/*  Form: FORMS. Entity: FORMS.  */

insert into FORMS("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID", "FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR", "OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH", "DESCRIPTION", "DOUBLE_CLICK_ACTION_CODE", "LOOKUP_WIDTH", "APPS_CODE", "EXPORT_ORDER") values (
'FORMS'
,'Ctrl+Shift+q'
,'Select a.*, &fc_schema_owner..form_utils.get_inserts (a.form_code) form_dml
      ,&fc_schema_owner..form_utils.get_form_pkg_clob (a.form_code) As gen_pkg
  From &fc_schema_owner..forms a
 Where DECODE (:p_$master_form_code, ''FORMS2'', :form_code_for_filter, ''MENUS'', :form_code_for_filter, a.form_code) =
                                                                                                             a.form_code
-----
'
,'��������� �������� �����'
,'G'
,'Y'
,'4'
,'0%'
,'*'
,'B'
,'B'
,'N'
,'164'
,'*'
,''
,''
,''
,'FC'
,'70');
/*  Form: FORMS. Entity: FORM_TABS.  */

insert into FORM_TABS("FORM_CODE", "TAB_CODE", "CHILD_FORM_CODE", "TAB_POSITION", "TAB_NAME", "NUMBER_OF_COLUMNS", "ICON_ID", "TAB_TYPE", "TAB_DISPLAY_NUMBER") values (
'FORMS'
,'DML'
,''
,'R'
,'DML'
,''
,'17'
,'1'
,'30');

insert into FORM_TABS("FORM_CODE", "TAB_CODE", "CHILD_FORM_CODE", "TAB_POSITION", "TAB_NAME", "NUMBER_OF_COLUMNS", "ICON_ID", "TAB_TYPE", "TAB_DISPLAY_NUMBER") values (
'FORMS'
,'PKG'
,''
,'R'
,'PKG'
,''
,'29'
,'1'
,'40');

insert into FORM_TABS("FORM_CODE", "TAB_CODE", "CHILD_FORM_CODE", "TAB_POSITION", "TAB_NAME", "NUMBER_OF_COLUMNS", "ICON_ID", "TAB_TYPE", "TAB_DISPLAY_NUMBER") values (
'FORMS'
,'SQL'
,''
,'R'
,'��������'
,'4'
,'50'
,'1'
,'10');

insert into FORM_TABS("FORM_CODE", "TAB_CODE", "CHILD_FORM_CODE", "TAB_POSITION", "TAB_NAME", "NUMBER_OF_COLUMNS", "ICON_ID", "TAB_TYPE", "TAB_DISPLAY_NUMBER") values (
'FORMS'
,'SQL_TEXT'
,''
,'R'
,'������'
,''
,'23'
,'1'
,'20');
/*  Form: FORMS. Entity: FORM_ACTIONS.  */

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'FORMS'
,'EXP'
,''
,'�������'
,'2'
,''
,''
,'12'
,'200'
,''
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'FORMS'
,'NEXT'
,''
,'������'
,'53'
,''
,''
,'6'
,'40'
,''
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'FORMS'
,'PREV'
,''
,'�����'
,'54'
,''
,''
,'5'
,'30'
,''
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'FORMS'
,'REFRESH'
,''
,'��������'
,'55'
,''
,''
,'4'
,'10'
,''
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'FORMS'
,'UPD'
,'&fc_schema_owner..FORMS_PKG.P_INSERT_UPDATE'
,'���������'
,'46'
,''
,''
,'2'
,'120'
,'�� ��������?'
,''
,'N'
,'Y'
,''
,'');
/*  Form: FORMS. Entity: FORM_COLUMNS$.  */

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'18'
,'VARCHAR2'
,'1020'
,'APPS_CODE'
,'9'
,'0'
,'0'
,'FORMS'
,''
,'*'
,'*��� ����������. ���� ������ ��� ���������� �������� ���������');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'10'
,'VARCHAR2'
,'8'
,'BOTTOM_TABS_ORIENTATION'
,'23'
,'0'
,'0'
,'FORMS'
,''
,'*'
,'*���������� ������ ������� �����������. ��. FORMS.TABS_ORIENTATION');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'14'
,'VARCHAR2'
,'120'
,'DEFAULT_COLUMN_WIDTH'
,'20'
,'0'
,'0'
,'FORMS'
,''
,'*'
,'*������ ����� �� ���������');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'15'
,'CLOB'
,'4000'
,'DESCRIPTION'
,'11'
,'0'
,'0'
,'FORMS'
,''
,'*'
,'*Description of the subscription');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'16'
,'VARCHAR2'
,'1020'
,'DOUBLE_CLICK_ACTION_CODE'
,'24'
,'0'
,'0'
,'FORMS'
,''
,'*'
,'*�������� �� �������� ������ �� ������. �� ��������� - ��������������');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'1'
,'VARCHAR2'
,'1020'
,'FORM_CODE'
,'9'
,'0'
,'0'
,'FORMS'
,'Y'
,'*'
,'*������������� ����');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'19'
,'CLOB'
,'4000'
,'FORM_DML'
,'8'
,'0'
,'0'
,'FORMS'
,''
,'*'
,'**FORM_DML');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'9'
,'VARCHAR2'
,'120'
,'FORM_HEIGHT'
,'11'
,'0'
,'0'
,'FORMS'
,''
,'*'
,'*������ � �������� ��� ���������. * - ����');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'4'
,'VARCHAR2'
,'1020'
,'FORM_NAME'
,'9'
,'0'
,'0'
,'FORMS'
,''
,'*'
,'*��� ����� ��� ������������');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'5'
,'VARCHAR2'
,'4'
,'FORM_TYPE'
,'9'
,'0'
,'0'
,'FORMS'
,''
,'*'
,'*��� ������������ �����');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'8'
,'VARCHAR2'
,'120'
,'FORM_WIDTH'
,'10'
,'0'
,'0'
,'FORMS'
,''
,'*'
,'*������ � �������� ��� ���������. * - ����');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'20'
,'CLOB'
,'4000'
,'GEN_PKG'
,'7'
,'0'
,'0'
,'FORMS'
,''
,'*'
,'**GEN_PKG');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'2'
,'VARCHAR2'
,'400'
,'HOT_KEY'
,'7'
,'0'
,'0'
,'FORMS'
,''
,'*'
,'*������� �������  - ������ ���� [Ctrl+][Alt+][Shift+]Chr. ������� �� �����');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'7'
,'NUMBER'
,'22'
,'ICON_ID'
,'7'
,'0'
,'-127'
,'FORMS'
,''
,'*'
,'**ICON_ID');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'17'
,'NUMBER'
,'22'
,'LOOKUP_WIDTH'
,'12'
,'0'
,'-127'
,'FORMS'
,''
,'*'
,'*������ ������ (���� ����� ��������� � ���� ������)');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'13'
,'NUMBER'
,'22'
,'OBJECT_VERSION_NUMBER'
,'21'
,'0'
,'-127'
,'FORMS'
,''
,'*'
,'**OBJECT_VERSION_NUMBER');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'12'
,'VARCHAR2'
,'4'
,'SHOW_BOTTOM_TOOLBAR'
,'19'
,'0'
,'0'
,'FORMS'
,''
,'*'
,'*���������� ������ ������?');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'6'
,'VARCHAR2'
,'4'
,'SHOW_TREE_ROOT_NODE'
,'19'
,'0'
,'0'
,'FORMS'
,''
,'*'
,'*���������� �� �������� ���� ��� ������?');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'11'
,'VARCHAR2'
,'8'
,'SIDE_TABS_ORIENTATION'
,'21'
,'0'
,'0'
,'FORMS'
,''
,'*'
,'*���������� ������� ������� �����������. ��. FORMS.TABS_ORIENTATION');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'3'
,'VARCHAR2'
,'4000'
,'SQL_TEXT'
,'8'
,'0'
,'0'
,'FORMS'
,''
,'*'
,'*Order by �� ������� ������� �� �����������, ����� ��� ���������� ������ �����..');
/*  Form: FORMS. Entity: FORM_COLUMNS.  */

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORMS'
,'APPS_CODE'
,'��� ����������'
,'*'
,'S'
,'1018'
,'N'
,'N'
,''
,''
,'SQL'
,''
,'��� ����������. ���� ������ ��� ���������� �������� ���������'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORMS'
,'BOTTOM_TABS_ORIENTATION'
,'���������� ������ �������'
,'*'
,'S'
,'1011'
,'N'
,'N'
,''
,''
,'SQL'
,'10'
,'���������� ������ ������� �����������. ��. FORMS.TABS_ORIENTATION'
,'N'
,'N'
,'FORMS.TABS_ORIENTATION'
,''
,''
,''
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORMS'
,'DEFAULT_COLUMN_WIDTH'
,'������ ����� �� ���������'
,'*'
,'S'
,'1015'
,'N'
,'N'
,''
,''
,'SQL'
,''
,'*������ ����� �� ���������'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORMS'
,'DESCRIPTION'
,'��������'
,'*'
,'S'
,'5'
,'N'
,'N'
,''
,''
,'SQL_TEXT'
,'5'
,'��������'
,'N'
,'N'
,''
,''
,'200'
,''
,''
,''
,''
,''
,''
,'T'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORMS'
,'DOUBLE_CLICK_ACTION_CODE'
,'�������� �� �������� ������'
,'*'
,'S'
,'1020'
,'N'
,'N'
,''
,''
,'SQL'
,'9'
,'*�������� �� �������� ������ �� ������. �� ��������� - ��������������'
,'N'
,'N'
,'DBLCLICK_FORM_ACT_LIST'
,''
,''
,''
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORMS'
,'FORM_CODE'
,'��� �����'
,'25%'
,'S'
,'3'
,'Y'
,'N'
,''
,'1'
,'SQL'
,''
,'������������� �����'
,'N'
,'N'
,''
,''
,''
,'1'
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORMS'
,'FORM_DML'
,''
,'*'
,'S'
,'1016'
,'N'
,'N'
,''
,''
,'DML'
,'4'
,'**FORM_DML'
,'N'
,'N'
,''
,''
,'500'
,''
,''
,''
,''
,''
,''
,'T'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORMS'
,'FORM_HEIGHT'
,'������ �����'
,'*'
,'S'
,'1010'
,'N'
,'N'
,''
,''
,'SQL'
,''
,'������ � �������� ��� ���������. * - ����'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORMS'
,'FORM_NAME'
,'���������������� ��� �����'
,'40%'
,'S'
,'2'
,'N'
,'N'
,''
,''
,'SQL'
,''
,'��� ����� ��� ������������'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORMS'
,'FORM_TYPE'
,'��� �����'
,'*'
,'S'
,'1006'
,'N'
,'N'
,''
,''
,'SQL'
,'8'
,'��� ������������ �����'
,'N'
,'N'
,'FORMS.FORM_TYPE'
,''
,''
,''
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORMS'
,'FORM_WIDTH'
,'������ �����'
,'*'
,'S'
,'1009'
,'N'
,'N'
,''
,''
,'SQL'
,''
,'������ � �������� ��� ���������. * - ����'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORMS'
,'GEN_PKG'
,''
,'*'
,'S'
,'1019'
,'N'
,'N'
,''
,''
,'PKG'
,'4'
,'**GEN_PKG'
,'N'
,'N'
,''
,''
,'500'
,''
,''
,''
,''
,''
,''
,'T'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORMS'
,'HOT_KEY'
,'������� �������'
,'*'
,'S'
,'8'
,'N'
,'N'
,''
,''
,'SQL'
,''
,'������� �������  - ������ ���� [Ctrl+][Alt+][Shift+]Chr. ������� �� �����'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORMS'
,'ICON_ID'
,'������'
,'*'
,'S'
,'1008'
,'N'
,'N'
,''
,''
,'SQL'
,'9'
,'������'
,'N'
,'N'
,'ICONS'
,''
,''
,''
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORMS'
,'LOOKUP_WIDTH'
,'������ ������'
,'*'
,'N'
,'1017'
,'N'
,'Y'
,''
,''
,'SQL'
,''
,'*������ ������ (���� ����� ��������� � ���� ������)'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORMS'
,'OBJECT_VERSION_NUMBER'
,''
,'*'
,'N'
,'1014'
,'N'
,'N'
,''
,''
,''
,''
,'**OBJECT_VERSION_NUMBER'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORMS'
,'SHOW_BOTTOM_TOOLBAR'
,'���������� ������ ������'
,'*'
,'B'
,'1013'
,'N'
,'N'
,''
,''
,'SQL'
,''
,'*���������� ������ ������?'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORMS'
,'SHOW_TREE_ROOT_NODE'
,'���������� �� �������� ���� ��� ������?'
,'*'
,'B'
,'1007'
,'N'
,'N'
,''
,''
,'SQL'
,''
,'���������� �� �������� ���� ��� ������?'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORMS'
,'SIDE_TABS_ORIENTATION'
,'���������� ������� �������'
,'*'
,'S'
,'1012'
,'N'
,'N'
,''
,''
,'SQL'
,'10'
,'*���������� ������� ������� �����������. ��. FORMS.TABS_ORIENTATION'
,'N'
,'N'
,'FORMS.TABS_ORIENTATION'
,''
,''
,''
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORMS'
,'SQL_TEXT'
,'����� �������'
,'4000'
,'S'
,'6'
,'N'
,'N'
,''
,''
,'SQL_TEXT'
,'4'
,'*Order by �� ������� ������� �� �����������, ����� ��� ���������� ������ �����..'
,'N'
,'N'
,''
,''
,'200'
,''
,''
,''
,''
,''
,''
,'T'
,'Y'
,'*'
,''
,'');
/*  Form: FORMS. Entity: FORM_COLUMN_ATTR_VALS.  */
/*  Form: FORMS. Entity: FORM_TAB_PARENT_EXCLNS.  */
/*  Form: FORMS. Entity: APPS_PRIVS.  */

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'SC'
,'FORMS');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'BF'
,'FORMS');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'AAHR'
,'FORMS');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'TC'
,'FORMS');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'INS'
,'FORMS');


Declare l_clob   Clob := 'zxrtyr'; Begin Update FORMS Set description = l_clob Where form_code = 'FORMS'; End;
/
Declare l_clob   Clob := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>���������� ������ �������.</b></font></span><div>���������� ������ ������� ����������� - ��. FORMS.TABS_ORIENTATION.</div>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORMS' and column_code = 'BOTTOM_TABS_ORIENTATION'; End;
/
Declare l_clob   Clob := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>������ ����� �� ���������.</b></font></span><div>�������� ���������.</div>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORMS' and column_code = 'DEFAULT_COLUMN_WIDTH'; End;
/
Declare l_clob   Clob := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>��������.</b></font></span><div>�������� ����� - ����������� ��������� � ����.</div>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORMS' and column_code = 'DESCRIPTION'; End;
/
Declare l_clob   Clob := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>�������� �� �������� ������.</b></font></span><div>�������� ���������.</div>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORMS' and column_code = 'DOUBLE_CLICK_ACTION_CODE'; End;
/
Declare l_clob   Clob := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>��� �����.</b></font></span><div>����������&nbsp;�������������&nbsp;�����. ��������� ���� ��� �������� ���� (����� �����, �������, ��������).</div>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORMS' and column_code = 'FORM_CODE'; End;
/
Declare l_clob   Clob := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>FORM_DML.</b></font></span><div>�������� ���������.</div>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORMS' and column_code = 'FORM_DML'; End;
/
Declare l_clob   Clob := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>������ �����.</b></font></span><div>������ � �������� ��� ���������. "*" - ����.</div>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORMS' and column_code = 'FORM_HEIGHT'; End;
/
Declare l_clob   Clob := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>���������������� ��� �����.</b></font></span><div>��� �����, ������������ �� ��������, � �.�. ������������ ������ �����������, ����, ��� ���������� ������ ��������������� � ���� ���������.</div>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORMS' and column_code = 'FORM_NAME'; End;
/
Declare l_clob   Clob := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>��� �����.</b></font></span><div>��� �����: ���� (��������� ���), ������. � ����������� - ��������� �����, ���������.</div>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORMS' and column_code = 'FORM_TYPE'; End;
/
Declare l_clob   Clob := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>������ �����.</b></font></span><div>������ � �������� ��� ���������. "*" - ����.</div>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORMS' and column_code = 'FORM_WIDTH'; End;
/
Declare l_clob   Clob := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>������� �������.</b></font></span><div>���������� ������ ��� ������ ����� - ������ ���� [Ctrl+][Alt+][Shift+]Chr. ������� �� �����.</div>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORMS' and column_code = 'HOT_KEY'; End;
/
Declare l_clob   Clob := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>������.</b></font></span><div>������, ������������ � ���� � ��������.</div>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORMS' and column_code = 'ICON_ID'; End;
/
Declare l_clob   Clob := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>������ ������.</b></font></span><div>�������� ���������.</div>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORMS' and column_code = 'LOOKUP_WIDTH'; End;
/
Declare l_clob   Clob := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>OBJECT_VERSION_NUMBER.</b></font></span><div>�������� ���������.</div>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORMS' and column_code = 'OBJECT_VERSION_NUMBER'; End;
/
Declare l_clob   Clob := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>���������� ������ ������.</b></font></span><div>�������� ���������.</div>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORMS' and column_code = 'SHOW_BOTTOM_TOOLBAR'; End;
/
Declare l_clob   Clob := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>���������� �� �������� ���� ��� ������?.</b></font></span><div>�������� ���������.</div>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORMS' and column_code = 'SHOW_TREE_ROOT_NODE'; End;
/
Declare l_clob   Clob := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>���������� ������� �������.</b></font></span><div>�������� ���������.</div>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORMS' and column_code = 'SIDE_TABS_ORIENTATION'; End;
/
Declare l_clob   Clob := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>����� �������.</b></font></span><div>����� SQL-�������. �� ��������� ������� ������� ������� ����������� ������ ����� "�������" (������� FORM_COLUMNS).</div>';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = 'FORMS' and column_code = 'SQL_TEXT'; End;
/

Alter Table forms Enable VALIDATE Constraint forms_form_actions_fk;
Alter Table FORMS Enable All Triggers;

/*****************FORM_COLUMN_ATTR_VALS*********************/

Alter Table FORMS Disable All Triggers;
Alter Table forms Disable Constraint forms_form_actions_fk;
delete from APPS_PRIVS where form_code = 'FORM_COLUMN_ATTR_VALS';
delete from FORM_TAB_PARENT_EXCLNS where form_code = 'FORM_COLUMN_ATTR_VALS';
delete from FORM_COLUMN_ATTR_VALS where form_code = 'FORM_COLUMN_ATTR_VALS';
delete from FORM_COLUMNS where form_code = 'FORM_COLUMN_ATTR_VALS';
delete from FORM_COLUMNS$ where form_code = 'FORM_COLUMN_ATTR_VALS';
delete from FORM_ACTIONS where form_code = 'FORM_COLUMN_ATTR_VALS';
delete from FORM_TABS where form_code = 'FORM_COLUMN_ATTR_VALS';
delete from FORMS where form_code = 'FORM_COLUMN_ATTR_VALS';
/*  Form: FORM_COLUMN_ATTR_VALS. Entity: FORMS.  */

insert into FORMS("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID", "FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR", "OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH", "DESCRIPTION", "DOUBLE_CLICK_ACTION_CODE", "LOOKUP_WIDTH", "APPS_CODE", "EXPORT_ORDER") values (
'FORM_COLUMN_ATTR_VALS'
,''
,'Select a.form_column_attr_val_id, a.form_code, a.column_code, a.attribute_code, a.attribute_value
  From &fc_schema_owner..form_column_attr_vals a
 Where a.form_code = :form_code
   And a.column_code = :column_code
--
'
,'�������������� �������� �������'
,'G'
,'Y'
,''
,'*'
,'*'
,''
,''
,'Y'
,'7'
,'*'
,''
,''
,''
,'FC'
,'80');
/*  Form: FORM_COLUMN_ATTR_VALS. Entity: FORM_TABS.  */
/*  Form: FORM_COLUMN_ATTR_VALS. Entity: FORM_ACTIONS.  */

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'FORM_COLUMN_ATTR_VALS'
,'DEL'
,'&fc_schema_owner..FORM_COLUMN_ATTR_VALS_PKG.p_delete'
,'�������'
,'48'
,''
,''
,'3'
,'130'
,'�� �������� ��� ������ ������� ������?'
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'FORM_COLUMN_ATTR_VALS'
,'EDIT'
,''
,'�������������'
,'50'
,''
,''
,'8'
,'115'
,'�� ��������?'
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'FORM_COLUMN_ATTR_VALS'
,'INS'
,''
,'�������'
,'47'
,''
,''
,'1'
,'110'
,''
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'FORM_COLUMN_ATTR_VALS'
,'REFR'
,''
,'��������'
,'15'
,''
,''
,'4'
,'10'
,''
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'FORM_COLUMN_ATTR_VALS'
,'UPD'
,'&fc_schema_owner..FORM_COLUMN_ATTR_VALS_PKG.p_ins_upd'
,'���������'
,'46'
,''
,''
,'2'
,'120'
,'�� ��������?'
,''
,'N'
,'Y'
,''
,'');
/*  Form: FORM_COLUMN_ATTR_VALS. Entity: FORM_COLUMNS$.  */

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'4'
,'VARCHAR2'
,'1020'
,'ATTRIBUTE_CODE'
,'14'
,'0'
,'0'
,'FORM_COLUMN_ATTR_VALS'
,''
,'*'
,'*��� ��������');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'5'
,'VARCHAR2'
,'1020'
,'ATTRIBUTE_VALUE'
,'15'
,'0'
,'0'
,'FORM_COLUMN_ATTR_VALS'
,''
,'*'
,'*�������� ��������');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'3'
,'VARCHAR2'
,'1020'
,'COLUMN_CODE'
,'11'
,'0'
,'0'
,'FORM_COLUMN_ATTR_VALS'
,''
,'*'
,'*������������� ���� (�� �������)');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'2'
,'VARCHAR2'
,'1020'
,'FORM_CODE'
,'9'
,'0'
,'0'
,'FORM_COLUMN_ATTR_VALS'
,''
,'*'
,'*������������� ����');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'1'
,'NUMBER'
,'22'
,'FORM_COLUMN_ATTR_VAL_ID'
,'23'
,'0'
,'-127'
,'FORM_COLUMN_ATTR_VALS'
,''
,'*'
,'*Id');
/*  Form: FORM_COLUMN_ATTR_VALS. Entity: FORM_COLUMNS.  */

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_COLUMN_ATTR_VALS'
,'COLUMN_CODE'
,'������������� ���� (�� �������)'
,'*'
,'S'
,'1003'
,'N'
,'N'
,''
,''
,''
,''
,'*������������� ���� (�� �������)'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,':COLUMN_CODE'
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_COLUMN_ATTR_VALS'
,'FORM_CODE'
,'������������� ����'
,'*'
,'S'
,'1002'
,'N'
,'N'
,''
,''
,''
,''
,'*������������� ����'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,':FORM_CODE'
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_COLUMN_ATTR_VALS'
,'FORM_COLUMN_ATTR_VAL_ID'
,'Id'
,'*'
,'N'
,'1001'
,'Y'
,'N'
,''
,''
,''
,''
,'*Id'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');
/*  Form: FORM_COLUMN_ATTR_VALS. Entity: FORM_COLUMN_ATTR_VALS.  */
/*  Form: FORM_COLUMN_ATTR_VALS. Entity: FORM_TAB_PARENT_EXCLNS.  */
/*  Form: FORM_COLUMN_ATTR_VALS. Entity: APPS_PRIVS.  */

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'SC'
,'FORM_COLUMN_ATTR_VALS');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'FC'
,'FORM_COLUMN_ATTR_VALS');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'INS'
,'FORM_COLUMN_ATTR_VALS');



Alter Table forms Enable VALIDATE Constraint forms_form_actions_fk;
Alter Table FORMS Enable All Triggers;

/*****************APPS_ROLE_MENUS*********************/

Alter Table FORMS Disable All Triggers;
Alter Table forms Disable Constraint forms_form_actions_fk;
delete from APPS_PRIVS where form_code = 'APPS_ROLE_MENUS';
delete from FORM_TAB_PARENT_EXCLNS where form_code = 'APPS_ROLE_MENUS';
delete from FORM_COLUMN_ATTR_VALS where form_code = 'APPS_ROLE_MENUS';
delete from FORM_COLUMNS where form_code = 'APPS_ROLE_MENUS';
delete from FORM_COLUMNS$ where form_code = 'APPS_ROLE_MENUS';
delete from FORM_ACTIONS where form_code = 'APPS_ROLE_MENUS';
delete from FORM_TABS where form_code = 'APPS_ROLE_MENUS';
delete from FORMS where form_code = 'APPS_ROLE_MENUS';
/*  Form: APPS_ROLE_MENUS. Entity: FORMS.  */

insert into FORMS("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID", "FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR", "OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH", "DESCRIPTION", "DOUBLE_CLICK_ACTION_CODE", "LOOKUP_WIDTH", "APPS_CODE", "EXPORT_ORDER") values (
'APPS_ROLE_MENUS'
,''
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
,'���� ��� ����'
,'T'
,'Y'
,'23'
,'*'
,'*'
,''
,''
,'Y'
,'21'
,'*'
,''
,''
,''
,'FC'
,'90');
/*  Form: APPS_ROLE_MENUS. Entity: FORM_TABS.  */
/*  Form: APPS_ROLE_MENUS. Entity: FORM_ACTIONS.  */

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'APPS_ROLE_MENUS'
,'DEL'
,'&fc_schema_owner..APPS_ROLE_MENUS_PKG.p_delete'
,'�������'
,'48'
,''
,''
,'3'
,'130'
,'�� �������� ��� ������ ������� ������?'
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'APPS_ROLE_MENUS'
,'EDIT'
,''
,'�������������'
,'50'
,''
,''
,'8'
,'115'
,'�� ��������?'
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'APPS_ROLE_MENUS'
,'INS'
,''
,'�������'
,'47'
,''
,''
,'1'
,'110'
,''
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'APPS_ROLE_MENUS'
,'REFR'
,''
,'��������'
,'15'
,''
,''
,'4'
,'10'
,''
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'APPS_ROLE_MENUS'
,'UPD'
,'&fc_schema_owner..APPS_ROLE_MENUS_PKG.p_ins_upd'
,'���������'
,'46'
,''
,''
,'2'
,'120'
,'�� ��������?'
,''
,'N'
,'Y'
,''
,'');
/*  Form: APPS_ROLE_MENUS. Entity: FORM_COLUMNS$.  */

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'1'
,'NUMBER'
,'22'
,'APP_MENU_ID'
,'11'
,'0'
,'-127'
,'APPS_ROLE_MENUS'
,''
,'*'
,'**APP_MENU_ID');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'7'
,'VARCHAR2'
,'4000'
,'DISPLAY_NAME'
,'12'
,'0'
,'0'
,'APPS_ROLE_MENUS'
,''
,'*'
,'*��� ���� � �������. ����������� �������� attribute_types.attribute_name');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'6'
,'VARCHAR2'
,'4000'
,'ENABLED_FLAG'
,'12'
,'0'
,'0'
,'APPS_ROLE_MENUS'
,''
,'*'
,'**ENABLED_FLAG');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'5'
,'VARCHAR2'
,'4000'
,'FORM_CODE'
,'9'
,'0'
,'0'
,'APPS_ROLE_MENUS'
,''
,'*'
,'*������������� ����');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'2'
,'VARCHAR2'
,'4000'
,'MENU_CODE'
,'9'
,'0'
,'0'
,'APPS_ROLE_MENUS'
,''
,'*'
,'*��� ����');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'8'
,'VARCHAR2'
,'4000'
,'PARENT'
,'6'
,'0'
,'0'
,'APPS_ROLE_MENUS'
,''
,'*'
,'**PARENT');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'3'
,'VARCHAR2'
,'4000'
,'PARENT_MENU_CODE'
,'16'
,'0'
,'0'
,'APPS_ROLE_MENUS'
,''
,'*'
,'*������ �� ����� ����-��������');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'4'
,'NUMBER'
,'22'
,'POSITION'
,'8'
,'9'
,'0'
,'APPS_ROLE_MENUS'
,''
,'*'
,'*9 - ������������� ������� � ����� ������');
/*  Form: APPS_ROLE_MENUS. Entity: FORM_COLUMNS.  */

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'APPS_ROLE_MENUS'
,'APP_MENU_ID'
,''
,'*'
,'N'
,'1001'
,'Y'
,'N'
,''
,''
,''
,''
,'**APP_MENU_ID'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,'1'
,''
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'APPS_ROLE_MENUS'
,'DISPLAY_NAME'
,'���'
,'*'
,'S'
,'1007'
,'N'
,'Y'
,''
,''
,''
,''
,'���� �� ������� - ������� ��� �����, ����� ��� ����'
,'N'
,'Y'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'APPS_ROLE_MENUS'
,'ENABLED_FLAG'
,''
,'*'
,'B'
,'1006'
,'N'
,'Y'
,''
,''
,''
,''
,'**ENABLED_FLAG'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'APPS_ROLE_MENUS'
,'FORM_CODE'
,'�����'
,'*'
,'S'
,'1005'
,'N'
,'Y'
,''
,''
,''
,'9'
,'*������������� ����'
,'N'
,'N'
,'FORMS_LIST'
,''
,''
,''
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'APPS_ROLE_MENUS'
,'MENU_CODE'
,'��� ����'
,'*'
,'S'
,'1002'
,'N'
,'Y'
,''
,'1'
,''
,''
,'*��� ����'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'APPS_ROLE_MENUS'
,'PARENT'
,''
,'*'
,'S'
,'1007'
,'N'
,'N'
,''
,'2'
,''
,''
,'**PARENT'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'APPS_ROLE_MENUS'
,'PARENT_MENU_CODE'
,'����-��������'
,'*'
,'S'
,'1003'
,'N'
,'Y'
,''
,''
,''
,''
,'*������ �� ����� ����-��������'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'APPS_ROLE_MENUS'
,'POSITION'
,'�������'
,'*'
,'S'
,'1004'
,'N'
,'Y'
,''
,''
,''
,''
,'*9 - ������������� ������� � ����� ������'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');
/*  Form: APPS_ROLE_MENUS. Entity: FORM_COLUMN_ATTR_VALS.  */
/*  Form: APPS_ROLE_MENUS. Entity: FORM_TAB_PARENT_EXCLNS.  */
/*  Form: APPS_ROLE_MENUS. Entity: APPS_PRIVS.  */

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'SC'
,'APPS_ROLE_MENUS');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'INS'
,'APPS_ROLE_MENUS');



Alter Table forms Enable VALIDATE Constraint forms_form_actions_fk;
Alter Table FORMS Enable All Triggers;

/*****************APPS_ROLE_USERS*********************/

Alter Table FORMS Disable All Triggers;
Alter Table forms Disable Constraint forms_form_actions_fk;
delete from APPS_PRIVS where form_code = 'APPS_ROLE_USERS';
delete from FORM_TAB_PARENT_EXCLNS where form_code = 'APPS_ROLE_USERS';
delete from FORM_COLUMN_ATTR_VALS where form_code = 'APPS_ROLE_USERS';
delete from FORM_COLUMNS where form_code = 'APPS_ROLE_USERS';
delete from FORM_COLUMNS$ where form_code = 'APPS_ROLE_USERS';
delete from FORM_ACTIONS where form_code = 'APPS_ROLE_USERS';
delete from FORM_TABS where form_code = 'APPS_ROLE_USERS';
delete from FORMS where form_code = 'APPS_ROLE_USERS';
/*  Form: APPS_ROLE_USERS. Entity: FORMS.  */

insert into FORMS("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID", "FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR", "OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH", "DESCRIPTION", "DOUBLE_CLICK_ACTION_CODE", "LOOKUP_WIDTH", "APPS_CODE", "EXPORT_ORDER") values (
'APPS_ROLE_USERS'
,''
,'Select *
  From apps_role_users aru
 Where (    aru.role_code = :role_code
        And :p_$master_form_code = ''APPS_ROLES'')
    Or :p_$master_form_code Is Null
'
,'������������ ����'
,'G'
,'Y'
,'32'
,'*'
,'*'
,''
,''
,'Y'
,'8'
,'*'
,''
,''
,''
,'FC'
,'90');
/*  Form: APPS_ROLE_USERS. Entity: FORM_TABS.  */
/*  Form: APPS_ROLE_USERS. Entity: FORM_ACTIONS.  */

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'APPS_ROLE_USERS'
,'DEL'
,'&fc_schema_owner..APPS_ROLE_USERS_PKG.p_delete'
,'�������'
,'48'
,''
,''
,'3'
,'130'
,'�� �������� ��� ������ ������� ������?'
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'APPS_ROLE_USERS'
,'EDIT'
,''
,'�������������'
,'50'
,''
,''
,'8'
,'115'
,'�� ��������?'
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'APPS_ROLE_USERS'
,'INS'
,''
,'�������'
,'47'
,''
,''
,'1'
,'110'
,''
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'APPS_ROLE_USERS'
,'REFR'
,''
,'��������'
,'15'
,''
,''
,'4'
,'10'
,''
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'APPS_ROLE_USERS'
,'UPD'
,'&fc_schema_owner..APPS_ROLE_USERS_PKG.p_ins_upd'
,'���������'
,'46'
,''
,''
,'2'
,'120'
,'�� ��������?'
,''
,'N'
,'Y'
,''
,'');
/*  Form: APPS_ROLE_USERS. Entity: FORM_COLUMNS$.  */

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'3'
,'VARCHAR2'
,'4000'
,'APPS_CODE'
,'9'
,'0'
,'0'
,'APPS_ROLE_USERS'
,''
,'*'
,'**APPS_CODE');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'1'
,'NUMBER'
,'22'
,'APP_ROLE_USER_ID'
,'16'
,'0'
,'-127'
,'APPS_ROLE_USERS'
,''
,'*'
,'**APP_ROLE_USER_ID');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'2'
,'VARCHAR2'
,'4000'
,'ROLE_CODE'
,'9'
,'0'
,'0'
,'APPS_ROLE_USERS'
,''
,'*'
,'**ROLE_CODE');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'4'
,'NUMBER'
,'22'
,'USER_ID'
,'7'
,'0'
,'-127'
,'APPS_ROLE_USERS'
,''
,'*'
,'*Database user id.');
/*  Form: APPS_ROLE_USERS. Entity: FORM_COLUMNS.  */

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'APPS_ROLE_USERS'
,'APP_ROLE_USER_ID'
,''
,'*'
,'N'
,'1001'
,'Y'
,'N'
,''
,''
,''
,''
,'**APP_ROLE_USER_ID'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'APPS_ROLE_USERS'
,'ROLE_CODE'
,''
,'*'
,'S'
,'1002'
,'N'
,'Y'
,''
,''
,''
,'9'
,'**ROLE_CODE'
,'N'
,'N'
,'APPS_ROLES'
,''
,''
,''
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'APPS_ROLE_USERS'
,'USER_ID'
,'Database user id.'
,'*'
,'N'
,'1004'
,'N'
,'Y'
,''
,''
,''
,'9'
,'*Database user id.'
,'N'
,'N'
,'USERS'
,''
,''
,''
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');
/*  Form: APPS_ROLE_USERS. Entity: FORM_COLUMN_ATTR_VALS.  */
/*  Form: APPS_ROLE_USERS. Entity: FORM_TAB_PARENT_EXCLNS.  */
/*  Form: APPS_ROLE_USERS. Entity: APPS_PRIVS.  */

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'SC'
,'APPS_ROLE_USERS');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'INS'
,'APPS_ROLE_USERS');



Alter Table forms Enable VALIDATE Constraint forms_form_actions_fk;
Alter Table FORMS Enable All Triggers;

/*****************APPS_ROLES*********************/

Alter Table FORMS Disable All Triggers;
Alter Table forms Disable Constraint forms_form_actions_fk;
delete from APPS_PRIVS where form_code = 'APPS_ROLES';
delete from FORM_TAB_PARENT_EXCLNS where form_code = 'APPS_ROLES';
delete from FORM_COLUMN_ATTR_VALS where form_code = 'APPS_ROLES';
delete from FORM_COLUMNS where form_code = 'APPS_ROLES';
delete from FORM_COLUMNS$ where form_code = 'APPS_ROLES';
delete from FORM_ACTIONS where form_code = 'APPS_ROLES';
delete from FORM_TABS where form_code = 'APPS_ROLES';
delete from FORMS where form_code = 'APPS_ROLES';
/*  Form: APPS_ROLES. Entity: FORMS.  */

insert into FORMS("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID", "FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR", "OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH", "DESCRIPTION", "DOUBLE_CLICK_ACTION_CODE", "LOOKUP_WIDTH", "APPS_CODE", "EXPORT_ORDER") values (
'APPS_ROLES'
,''
,'select *
  from &fc_schema_owner..apps_roles
'
,'���� ����������'
,'G'
,'Y'
,'42'
,'*'
,'*'
,''
,''
,'Y'
,'15'
,'*'
,''
,''
,''
,'FC'
,'100');
/*  Form: APPS_ROLES. Entity: FORM_TABS.  */

insert into FORM_TABS("FORM_CODE", "TAB_CODE", "CHILD_FORM_CODE", "TAB_POSITION", "TAB_NAME", "NUMBER_OF_COLUMNS", "ICON_ID", "TAB_TYPE", "TAB_DISPLAY_NUMBER") values (
'APPS_ROLES'
,'MENUS'
,'APPS_ROLE_MENUS'
,'R'
,''
,''
,''
,'2'
,'1');

insert into FORM_TABS("FORM_CODE", "TAB_CODE", "CHILD_FORM_CODE", "TAB_POSITION", "TAB_NAME", "NUMBER_OF_COLUMNS", "ICON_ID", "TAB_TYPE", "TAB_DISPLAY_NUMBER") values (
'APPS_ROLES'
,'USERS'
,'APPS_ROLE_USERS'
,'R'
,''
,''
,''
,'2'
,'2');
/*  Form: APPS_ROLES. Entity: FORM_ACTIONS.  */

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'APPS_ROLES'
,'DEL'
,'&fc_schema_owner..APPS_ROLES_PKG.p_delete'
,'�������'
,'48'
,''
,''
,'3'
,'130'
,'�� �������� ��� ������ ������� ������?'
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'APPS_ROLES'
,'EDIT'
,''
,'�������������'
,'50'
,''
,''
,'8'
,'115'
,'�� ��������?'
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'APPS_ROLES'
,'INS'
,''
,'�������'
,'47'
,''
,''
,'1'
,'110'
,''
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'APPS_ROLES'
,'REFR'
,''
,'��������'
,'15'
,''
,''
,'4'
,'10'
,''
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'APPS_ROLES'
,'UPD'
,'&fc_schema_owner..APPS_ROLES_PKG.p_ins_upd'
,'���������'
,'46'
,''
,''
,'2'
,'120'
,'�� ��������?'
,''
,'N'
,'Y'
,''
,'');
/*  Form: APPS_ROLES. Entity: FORM_COLUMNS$.  */

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'4'
,'VARCHAR2'
,'4000'
,'APPS_CODE'
,'9'
,'0'
,'0'
,'APPS_ROLES'
,''
,'*'
,'**APPS_CODE');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'1'
,'NUMBER'
,'22'
,'APPS_ROLE_ID'
,'12'
,'0'
,'-127'
,'APPS_ROLES'
,''
,'*'
,'**APPS_ROLE_ID');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'2'
,'VARCHAR2'
,'4000'
,'ROLE_CODE'
,'9'
,'0'
,'0'
,'APPS_ROLES'
,''
,'*'
,'**ROLE_CODE');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'3'
,'VARCHAR2'
,'4000'
,'ROLE_NAME'
,'9'
,'0'
,'0'
,'APPS_ROLES'
,''
,'*'
,'** ��� ���� �����');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'5'
,'VARCHAR2'
,'4000'
,'ROOT_MENU_CODE'
,'14'
,'0'
,'0'
,'APPS_ROLES'
,''
,'*'
,'**ROOT_MENU_CODE');
/*  Form: APPS_ROLES. Entity: FORM_COLUMNS.  */

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'APPS_ROLES'
,'APPS_CODE'
,''
,'*'
,'S'
,'1004'
,'N'
,'Y'
,''
,''
,''
,''
,'**APPS_CODE'
,'N'
,'N'
,''
,''
,''
,'3'
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'APPS_ROLES'
,'APPS_ROLE_ID'
,''
,'*'
,'N'
,'1001'
,'Y'
,'N'
,''
,''
,''
,''
,'**APPS_ROLE_ID'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'APPS_ROLES'
,'ROLE_CODE'
,''
,'*'
,'S'
,'1002'
,'N'
,'Y'
,''
,''
,''
,''
,'**ROLE_CODE'
,'N'
,'N'
,''
,''
,''
,'1'
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'APPS_ROLES'
,'ROLE_NAME'
,'������������'
,'*'
,'S'
,'1003'
,'N'
,'Y'
,''
,''
,''
,''
,'** ��� ���� �����'
,'N'
,'N'
,''
,''
,''
,'2'
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'APPS_ROLES'
,'ROOT_MENU_CODE'
,''
,'*'
,'S'
,'1005'
,'N'
,'Y'
,''
,''
,''
,''
,'**ROOT_MENU_CODE'
,'N'
,'N'
,''
,''
,''
,'3'
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');
/*  Form: APPS_ROLES. Entity: FORM_COLUMN_ATTR_VALS.  */
/*  Form: APPS_ROLES. Entity: FORM_TAB_PARENT_EXCLNS.  */
/*  Form: APPS_ROLES. Entity: APPS_PRIVS.  */

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'SC'
,'APPS_ROLES');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'INS'
,'APPS_ROLES');



Alter Table forms Enable VALIDATE Constraint forms_form_actions_fk;
Alter Table FORMS Enable All Triggers;

/*****************FORM_COLUMN_ACTIONS*********************/

Alter Table FORMS Disable All Triggers;
Alter Table forms Disable Constraint forms_form_actions_fk;
delete from APPS_PRIVS where form_code = 'FORM_COLUMN_ACTIONS';
delete from FORM_TAB_PARENT_EXCLNS where form_code = 'FORM_COLUMN_ACTIONS';
delete from FORM_COLUMN_ATTR_VALS where form_code = 'FORM_COLUMN_ACTIONS';
delete from FORM_COLUMNS where form_code = 'FORM_COLUMN_ACTIONS';
delete from FORM_COLUMNS$ where form_code = 'FORM_COLUMN_ACTIONS';
delete from FORM_ACTIONS where form_code = 'FORM_COLUMN_ACTIONS';
delete from FORM_TABS where form_code = 'FORM_COLUMN_ACTIONS';
delete from FORMS where form_code = 'FORM_COLUMN_ACTIONS';
/*  Form: FORM_COLUMN_ACTIONS. Entity: FORMS.  */

insert into FORMS("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID", "FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR", "OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH", "DESCRIPTION", "DOUBLE_CLICK_ACTION_CODE", "LOOKUP_WIDTH", "APPS_CODE", "EXPORT_ORDER") values (
'FORM_COLUMN_ACTIONS'
,''
,'Select *
  From &fc_schema_owner..form_column_actions a
 Where a.action_code = NVL (:action_code, a.action_code)
   And a.form_code = NVL (:form_code, a.form_code)
   And a.column_code = NVL (:column_code, a.column_code)
--'
,''
,'G'
,'Y'
,'29'
,'*'
,'*'
,''
,''
,'Y'
,'20'
,'*'
,''
,''
,''
,'FC'
,'100');
/*  Form: FORM_COLUMN_ACTIONS. Entity: FORM_TABS.  */
/*  Form: FORM_COLUMN_ACTIONS. Entity: FORM_ACTIONS.  */

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'FORM_COLUMN_ACTIONS'
,'DEL'
,'&fc_schema_owner..FORM_COLUMN_ACTIONS_PKG.p_delete'
,'�������'
,'48'
,''
,''
,'3'
,'130'
,'�� �������� ��� ������ ������� ������?'
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'FORM_COLUMN_ACTIONS'
,'EDIT'
,''
,'�������������'
,'50'
,''
,''
,'8'
,'115'
,'�� ��������?'
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'FORM_COLUMN_ACTIONS'
,'INS'
,''
,'�������'
,'47'
,''
,''
,'1'
,'110'
,''
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'FORM_COLUMN_ACTIONS'
,'REFR'
,''
,'��������'
,'15'
,''
,''
,'4'
,'10'
,''
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'FORM_COLUMN_ACTIONS'
,'UPD'
,'&fc_schema_owner..FORM_COLUMN_ACTIONS_PKG.p_ins_upd'
,'���������'
,'46'
,''
,''
,'2'
,'120'
,'�� ��������?'
,''
,'N'
,'Y'
,''
,'');
/*  Form: FORM_COLUMN_ACTIONS. Entity: FORM_COLUMNS$.  */

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'4'
,'VARCHAR2'
,'1020'
,'ACTION_CODE'
,'11'
,'0'
,'0'
,'FORM_COLUMN_ACTIONS'
,'Y'
,'*'
,'*��� ��������');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'5'
,'VARCHAR2'
,'1020'
,'ACTION_KEY_CODE'
,'15'
,'0'
,'0'
,'FORM_COLUMN_ACTIONS'
,''
,'*'
,'*������� (��� ���� "�� ������� �������").');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'3'
,'VARCHAR2'
,'1020'
,'COLUMN_CODE'
,'11'
,'0'
,'0'
,'FORM_COLUMN_ACTIONS'
,'Y'
,'*'
,'*������������� ���� (�� �������)');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'6'
,'VARCHAR2'
,'1020'
,'COL_ACTION_TYPE_CODE'
,'20'
,'0'
,'0'
,'FORM_COLUMN_ACTIONS'
,''
,'*'
,'*��� �������� (����� FORM_COLUMNS.ACTION_TYPE)');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'2'
,'VARCHAR2'
,'1020'
,'FORM_CODE'
,'9'
,'0'
,'0'
,'FORM_COLUMN_ACTIONS'
,'Y'
,'*'
,'*������������� ����');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'1'
,'NUMBER'
,'22'
,'FORM_COLUMN_ACTION_ID'
,'21'
,'0'
,'-127'
,'FORM_COLUMN_ACTIONS'
,''
,'*'
,'*����. ��� ���������� �� ����������');
/*  Form: FORM_COLUMN_ACTIONS. Entity: FORM_COLUMNS.  */

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_COLUMN_ACTIONS'
,'ACTION_CODE'
,'��� ��������'
,'*'
,'S'
,'40'
,'N'
,'Y'
,''
,'1'
,''
,'9'
,'*��� ��������'
,'N'
,'N'
,'DBLCLICK_FORM_ACT_LIST'
,''
,''
,'1'
,''
,''
,''
,''
,':ACTION_CODE'
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_COLUMN_ACTIONS'
,'ACTION_KEY_CODE'
,'������� (��� ���� "�� ������� �������").'
,'*'
,'S'
,'60'
,'N'
,'Y'
,''
,''
,''
,''
,'*������� (��� ���� "�� ������� �������").'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_COLUMN_ACTIONS'
,'COLUMN_CODE'
,'������������� ���� (�� �������)'
,'*'
,'S'
,'30'
,'N'
,'Y'
,''
,'1'
,''
,'9'
,'*������������� ���� (�� �������)'
,'N'
,'N'
,'COLUMNS_LIST'
,''
,''
,'1'
,''
,''
,''
,''
,':COLUMN_CODE'
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_COLUMN_ACTIONS'
,'COL_ACTION_TYPE_CODE'
,'��� ��������'
,'*'
,'S'
,'50'
,'N'
,'Y'
,''
,''
,''
,'8'
,'*��� �������� (����� FORM_COLUMNS.ACTION_TYPE)'
,'N'
,'N'
,'FORM_COLUMNS.ACTION_TYPE'
,''
,''
,''
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_COLUMN_ACTIONS'
,'FORM_CODE'
,'������������� ����'
,'*'
,'S'
,'20'
,'N'
,'Y'
,''
,'1'
,''
,''
,'*������������� ����'
,'N'
,'N'
,''
,''
,''
,'1'
,''
,''
,''
,''
,':FORM_CODE'
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_COLUMN_ACTIONS'
,'FORM_COLUMN_ACTION_ID'
,'����. ��� ���������� �� ����������'
,'*'
,'N'
,'10'
,'Y'
,'N'
,''
,''
,''
,'9'
,'*����. ��� ���������� �� ����������'
,'N'
,'N'
,'FORM_COLUMNS'
,''
,''
,''
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');
/*  Form: FORM_COLUMN_ACTIONS. Entity: FORM_COLUMN_ATTR_VALS.  */
/*  Form: FORM_COLUMN_ACTIONS. Entity: FORM_TAB_PARENT_EXCLNS.  */
/*  Form: FORM_COLUMN_ACTIONS. Entity: APPS_PRIVS.  */

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'FC'
,'FORM_COLUMN_ACTIONS');



Alter Table forms Enable VALIDATE Constraint forms_form_actions_fk;
Alter Table FORMS Enable All Triggers;

/*****************FORMS2*********************/

Alter Table FORMS Disable All Triggers;
Alter Table forms Disable Constraint forms_form_actions_fk;
delete from APPS_PRIVS where form_code = 'FORMS2';
delete from FORM_TAB_PARENT_EXCLNS where form_code = 'FORMS2';
delete from FORM_COLUMN_ATTR_VALS where form_code = 'FORMS2';
delete from FORM_COLUMNS where form_code = 'FORMS2';
delete from FORM_COLUMNS$ where form_code = 'FORMS2';
delete from FORM_ACTIONS where form_code = 'FORMS2';
delete from FORM_TABS where form_code = 'FORMS2';
delete from FORMS where form_code = 'FORMS2';
/*  Form: FORMS2. Entity: FORMS.  */

insert into FORMS("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID", "FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR", "OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH", "DESCRIPTION", "DOUBLE_CLICK_ACTION_CODE", "LOOKUP_WIDTH", "APPS_CODE", "EXPORT_ORDER") values (
'FORMS2'
,'shift+alt+ctrl+f'
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
        Select ''COLUMNS'' entity_type, :code parent_code, ''COLUMNS'' code, ''�������'', 11 icon_id, 0 child_count
              ,Null description
          From DUAL x
         Where :code Is Not Null
           And ''FORM'' = :entity_type
        Union All
        Select ''TABS'' entity_type, :code parent_code, ''TABS'' code, ''�������'', 12 icon_id, 0 child_count
              ,Null description
          From DUAL x
         Where :code Is Not Null
           And ''FORM'' = :entity_type
        Union All
        Select ''ACTIONS'' entity_type, :code parent_code, ''ACTIONS'' code, ''��������'', 13 icon_id, 0 child_count
              ,Null description
          From DUAL x
         Where :code Is Not Null
           And ''FORM'' = :entity_type
        Union All
        Select ''DATA'' entity_type, :code parent_code, ''DATA'' code, ''��������� �����'', 14 icon_id, 0 child_count
              ,Null description
          From DUAL x
         Where :code Is Not Null
           And ''FORM'' = :entity_type) t order by t.USER_NAME'
,'����������� ����'
,'T'
,'Y'
,'28'
,'20%'
,'*'
,''
,''
,'Y'
,'153'
,'*'
,''
,''
,''
,'FC'
,'100');
/*  Form: FORMS2. Entity: FORM_TABS.  */

insert into FORM_TABS("FORM_CODE", "TAB_CODE", "CHILD_FORM_CODE", "TAB_POSITION", "TAB_NAME", "NUMBER_OF_COLUMNS", "ICON_ID", "TAB_TYPE", "TAB_DISPLAY_NUMBER") values (
'FORMS2'
,'RDET'
,''
,'R'
,''
,''
,''
,'3'
,'');

insert into FORM_TABS("FORM_CODE", "TAB_CODE", "CHILD_FORM_CODE", "TAB_POSITION", "TAB_NAME", "NUMBER_OF_COLUMNS", "ICON_ID", "TAB_TYPE", "TAB_DISPLAY_NUMBER") values (
'FORMS2'
,'SETUP'
,''
,'R'
,'���������'
,''
,'18'
,'3'
,'');
/*  Form: FORMS2. Entity: FORM_ACTIONS.  */

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'FORMS2'
,'DEL'
,'&fc_schema_owner..FORMS2_PKG.P_DELETE'
,'�������'
,'48'
,''
,''
,'3'
,'130'
,'�� �������� ��� ������ ������� ������?'
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'FORMS2'
,'EDIT'
,''
,'�������������'
,'50'
,''
,''
,'8'
,'115'
,'�� ��������?'
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'FORMS2'
,'INS'
,''
,'�������'
,'47'
,''
,''
,'1'
,'110'
,''
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'FORMS2'
,'REFR'
,''
,'��������'
,'15'
,''
,''
,'4'
,'10'
,''
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'FORMS2'
,'UPD'
,'&fc_schema_owner..FORMS2_PKG.P_INSERT'
,'���������'
,'46'
,''
,''
,'2'
,'120'
,'�� ��������?'
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'FORMS2'
,'����'
,''
,'������'
,'25'
,''
,''
,'9'
,'190'
,'�� ��������?'
,''
,'N'
,'Y'
,''
,'');
/*  Form: FORMS2. Entity: FORM_COLUMNS$.  */

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'6'
,'NUMBER'
,'2'
,'CHILD_COUNT'
,'11'
,'0'
,'-127'
,'FORMS2'
,''
,'*'
,'*5 - ���������� �������� ��������� � �������� ���� (0 - ����� �� ����� ������������);');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'3'
,'VARCHAR2'
,'1020'
,'CODE'
,'4'
,'0'
,'0'
,'FORMS2'
,''
,'*'
,'*������������');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'7'
,'CLOB'
,'4000'
,'DESCRIPTION'
,'11'
,'0'
,'0'
,'FORMS2'
,''
,'*'
,'*Description of the subscription');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'10'
,'VARCHAR2'
,'12'
,'DETAIL_FORM'
,'11'
,'0'
,'0'
,'FORMS2'
,''
,'*'
,'**DETAIL_FORM');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'11'
,'VARCHAR2'
,'1020'
,'DETAIL_FORM_MULTI'
,'17'
,'0'
,'0'
,'FORMS2'
,''
,'*'
,'**DETAIL_FORM_MULTI');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'1'
,'VARCHAR2'
,'28'
,'ENTITY_TYPE'
,'11'
,'0'
,'0'
,'FORMS2'
,''
,'*'
,'**ENTITY_TYPE');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'9'
,'VARCHAR2'
,'2000'
,'FORM_CODE_FOR_FILTER'
,'20'
,'0'
,'0'
,'FORMS2'
,''
,'*'
,'**FORM_CODE_FOR_FILTER');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'5'
,'NUMBER'
,'22'
,'ICON_ID'
,'7'
,'0'
,'-127'
,'FORMS2'
,''
,'*'
,'**ICON_ID');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'8'
,'NUMBER'
,'2'
,'IS_FOLDER'
,'9'
,'0'
,'0'
,'FORMS2'
,''
,'*'
,'**IS_FOLDER');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'2'
,'VARCHAR2'
,'2000'
,'PARENT_CODE'
,'11'
,'0'
,'0'
,'FORMS2'
,''
,'*'
,'**PARENT_CODE');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'4'
,'VARCHAR2'
,'1020'
,'USER_NAME'
,'9'
,'0'
,'0'
,'FORMS2'
,''
,'*'
,'** ��� ���� �������������');
/*  Form: FORMS2. Entity: FORM_COLUMNS.  */

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORMS2'
,'CHILD_COUNT'
,''
,'*'
,'S'
,'1006'
,'N'
,'N'
,''
,''
,''
,''
,'**CHILD_COUNT'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORMS2'
,'CODE'
,''
,'0%'
,'S'
,'1003'
,'Y'
,'N'
,''
,'1'
,''
,''
,'**CODE'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORMS2'
,'DESCRIPTION'
,'��������'
,'0%'
,'S'
,'2'
,'N'
,'N'
,''
,''
,''
,'5'
,'*Description of the subscription'
,'N'
,'N'
,''
,'USER_NAME'
,'200'
,''
,''
,''
,''
,''
,''
,''
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORMS2'
,'DETAIL_FORM'
,''
,'*'
,'S'
,'1009'
,'N'
,'N'
,''
,''
,'SETUP'
,'1'
,'**DETAIL_FORM'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORMS2'
,'DETAIL_FORM_MULTI'
,'�������� �����'
,'*'
,'S'
,'1010'
,'N'
,'N'
,''
,''
,'RDET'
,'2'
,'**DETAIL_FORM_MULTI'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORMS2'
,'ENTITY_TYPE'
,'ss3'
,'0%'
,'S'
,'1001'
,'N'
,'N'
,''
,''
,''
,''
,'**ENTITY_TYPE'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORMS2'
,'FORM_CODE_FOR_FILTER'
,''
,'*'
,'S'
,'1008'
,'N'
,'N'
,''
,''
,''
,''
,'**FORM_CODE_FOR_FILTER'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORMS2'
,'ICON_ID'
,''
,'*'
,'S'
,'1005'
,'N'
,'N'
,''
,'4'
,''
,''
,'**ICON_ID'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORMS2'
,'IS_FOLDER'
,''
,'*'
,'B'
,'1007'
,'N'
,'N'
,''
,'3'
,''
,''
,'**IS_FOLDER'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORMS2'
,'PARENT_CODE'
,''
,'0%'
,'S'
,'1002'
,'N'
,'N'
,''
,'2'
,''
,''
,'**PARENT_CODE'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORMS2'
,'USER_NAME'
,'������ ����'
,'*'
,'S'
,'1'
,'N'
,'Y'
,''
,''
,''
,'6'
,'** ��� ���� �������������'
,'N'
,'Y'
,''
,'DESCRIPTION'
,''
,''
,''
,''
,''
,'1'
,''
,''
,'Y'
,'*'
,''
,'');
/*  Form: FORMS2. Entity: FORM_COLUMN_ATTR_VALS.  */
/*  Form: FORMS2. Entity: FORM_TAB_PARENT_EXCLNS.  */
/*  Form: FORMS2. Entity: APPS_PRIVS.  */

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'SC'
,'FORMS2');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'BF'
,'FORMS2');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'AAHR'
,'FORMS2');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'TC'
,'FORMS2');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'INS'
,'FORMS2');



Alter Table forms Enable VALIDATE Constraint forms_form_actions_fk;
Alter Table FORMS Enable All Triggers;

/*****************FORM_TAB_PARENT_EXCLNS*********************/

Alter Table FORMS Disable All Triggers;
Alter Table forms Disable Constraint forms_form_actions_fk;
delete from APPS_PRIVS where form_code = 'FORM_TAB_PARENT_EXCLNS';
delete from FORM_TAB_PARENT_EXCLNS where form_code = 'FORM_TAB_PARENT_EXCLNS';
delete from FORM_COLUMN_ATTR_VALS where form_code = 'FORM_TAB_PARENT_EXCLNS';
delete from FORM_COLUMNS where form_code = 'FORM_TAB_PARENT_EXCLNS';
delete from FORM_COLUMNS$ where form_code = 'FORM_TAB_PARENT_EXCLNS';
delete from FORM_ACTIONS where form_code = 'FORM_TAB_PARENT_EXCLNS';
delete from FORM_TABS where form_code = 'FORM_TAB_PARENT_EXCLNS';
delete from FORMS where form_code = 'FORM_TAB_PARENT_EXCLNS';
/*  Form: FORM_TAB_PARENT_EXCLNS. Entity: FORMS.  */

insert into FORMS("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID", "FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR", "OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH", "DESCRIPTION", "DOUBLE_CLICK_ACTION_CODE", "LOOKUP_WIDTH", "APPS_CODE", "EXPORT_ORDER") values (
'FORM_TAB_PARENT_EXCLNS'
,''
,'Select *
  From &fc_schema_owner..FORM_TAB_PARENT_EXCLNS ftpe
 Where ftpe.form_code = :form_code
   And ftpe.tab_code = :tab_code
'
,'���������� �������'
,'G'
,'Y'
,''
,'*'
,'*'
,''
,''
,'Y'
,'14'
,'*'
,''
,''
,''
,'FC'
,'100');
/*  Form: FORM_TAB_PARENT_EXCLNS. Entity: FORM_TABS.  */
/*  Form: FORM_TAB_PARENT_EXCLNS. Entity: FORM_ACTIONS.  */

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'FORM_TAB_PARENT_EXCLNS'
,'DEL'
,'&fc_schema_owner..FORM_TAB_PARENT_EXCLNS_PKG.p_delete'
,'�������'
,'48'
,''
,''
,'3'
,'130'
,'�� �������� ��� ������ ������� ������?'
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'FORM_TAB_PARENT_EXCLNS'
,'EDIT'
,''
,'�������������'
,'50'
,''
,''
,'8'
,'115'
,'�� ��������?'
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'FORM_TAB_PARENT_EXCLNS'
,'INS'
,''
,'�������'
,'47'
,''
,''
,'1'
,'110'
,''
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'FORM_TAB_PARENT_EXCLNS'
,'REFR'
,''
,'��������'
,'15'
,''
,''
,'4'
,'10'
,''
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'FORM_TAB_PARENT_EXCLNS'
,'UPD'
,'&fc_schema_owner..FORM_TAB_PARENT_EXCLNS_PKG.p_ins_upd'
,'���������'
,'46'
,''
,''
,'2'
,'120'
,'�� ��������?'
,''
,'N'
,'Y'
,''
,'');
/*  Form: FORM_TAB_PARENT_EXCLNS. Entity: FORM_COLUMNS$.  */

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'5'
,'NUMBER'
,'22'
,'EXCLN_ID'
,'8'
,'0'
,'-127'
,'FORM_TAB_PARENT_EXCLNS'
,''
,'*'
,'*ID');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'1'
,'VARCHAR2'
,'4000'
,'FORM_CODE'
,'9'
,'0'
,'0'
,'FORM_TAB_PARENT_EXCLNS'
,''
,'*'
,'*������������� ����');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'4'
,'VARCHAR2'
,'8'
,'INCLUDED_FLAG'
,'13'
,'0'
,'0'
,'FORM_TAB_PARENT_EXCLNS'
,''
,'*'
,'**INCLUDED_FLAG');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'3'
,'VARCHAR2'
,'4000'
,'PARENT_FORM_CODE'
,'16'
,'0'
,'0'
,'FORM_TAB_PARENT_EXCLNS'
,''
,'*'
,'**PARENT_FORM_CODE');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'2'
,'VARCHAR2'
,'4000'
,'TAB_CODE'
,'8'
,'0'
,'0'
,'FORM_TAB_PARENT_EXCLNS'
,''
,'*'
,'*������������� ��������');
/*  Form: FORM_TAB_PARENT_EXCLNS. Entity: FORM_COLUMNS.  */

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_TAB_PARENT_EXCLNS'
,'EXCLN_ID'
,'ID'
,'*'
,'N'
,'1005'
,'Y'
,'N'
,''
,''
,''
,''
,'*ID'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_TAB_PARENT_EXCLNS'
,'FORM_CODE'
,'������������� ����'
,'*'
,'S'
,'1001'
,'N'
,'N'
,''
,''
,''
,''
,'*������������� ����'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,':FORM_CODE'
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_TAB_PARENT_EXCLNS'
,'INCLUDED_FLAG'
,''
,'*'
,'B'
,'1004'
,'N'
,'Y'
,''
,''
,''
,''
,'**INCLUDED_FLAG'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_TAB_PARENT_EXCLNS'
,'PARENT_FORM_CODE'
,''
,'*'
,'S'
,'1003'
,'N'
,'Y'
,''
,''
,''
,'9'
,'**PARENT_FORM_CODE'
,'N'
,'N'
,'FORMS_LIST'
,''
,''
,''
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'FORM_TAB_PARENT_EXCLNS'
,'TAB_CODE'
,'������������� ��������'
,'*'
,'S'
,'1002'
,'N'
,'N'
,''
,''
,''
,''
,'*������������� ��������'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,':TAB_CODE'
,'L'
,'Y'
,'*'
,''
,'');
/*  Form: FORM_TAB_PARENT_EXCLNS. Entity: FORM_COLUMN_ATTR_VALS.  */
/*  Form: FORM_TAB_PARENT_EXCLNS. Entity: FORM_TAB_PARENT_EXCLNS.  */
/*  Form: FORM_TAB_PARENT_EXCLNS. Entity: APPS_PRIVS.  */

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'SC'
,'FORM_TAB_PARENT_EXCLNS');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'INS'
,'FORM_TAB_PARENT_EXCLNS');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'FC'
,'FORM_TAB_PARENT_EXCLNS');


Declare l_clob   Clob := '���������� �� ����� ������� � ������ ���� ���� � �� �� ����� ����� ��������� ��� ������� �����, ��� � ��� �����������.'; Begin Update FORMS Set description = l_clob Where form_code = 'FORM_TAB_PARENT_EXCLNS'; End;
/

Alter Table forms Enable VALIDATE Constraint forms_form_actions_fk;
Alter Table FORMS Enable All Triggers;

/*****************MENUS*********************/

Alter Table FORMS Disable All Triggers;
Alter Table forms Disable Constraint forms_form_actions_fk;
delete from APPS_PRIVS where form_code = 'MENUS';
delete from FORM_TAB_PARENT_EXCLNS where form_code = 'MENUS';
delete from FORM_COLUMN_ATTR_VALS where form_code = 'MENUS';
delete from FORM_COLUMNS where form_code = 'MENUS';
delete from FORM_COLUMNS$ where form_code = 'MENUS';
delete from FORM_ACTIONS where form_code = 'MENUS';
delete from FORM_TABS where form_code = 'MENUS';
delete from FORMS where form_code = 'MENUS';
/*  Form: MENUS. Entity: FORMS.  */

insert into FORMS("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID", "FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR", "OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH", "DESCRIPTION", "DOUBLE_CLICK_ACTION_CODE", "LOOKUP_WIDTH", "APPS_CODE", "EXPORT_ORDER") values (
'MENUS'
,'Ctrl+Alt+Shift+K'
,'select * from table(&fc_schema_owner..menus_pkg.p_get_menu_tree(:menu_code,:element_type,:form_display))
------------'
,'�����������'
,'T'
,'Y'
,'28'
,'25%'
,'*'
,''
,'T'
,'N'
,'296'
,'*'
,''
,''
,''
,'FC'
,'100');
/*  Form: MENUS. Entity: FORM_TABS.  */

insert into FORM_TABS("FORM_CODE", "TAB_CODE", "CHILD_FORM_CODE", "TAB_POSITION", "TAB_NAME", "NUMBER_OF_COLUMNS", "ICON_ID", "TAB_TYPE", "TAB_DISPLAY_NUMBER") values (
'MENUS'
,'DET'
,''
,'R'
,''
,''
,''
,'3'
,'3');

insert into FORM_TABS("FORM_CODE", "TAB_CODE", "CHILD_FORM_CODE", "TAB_POSITION", "TAB_NAME", "NUMBER_OF_COLUMNS", "ICON_ID", "TAB_TYPE", "TAB_DISPLAY_NUMBER") values (
'MENUS'
,'FORMS'
,''
,'R'
,''
,''
,''
,'3'
,'2');

insert into FORM_TABS("FORM_CODE", "TAB_CODE", "CHILD_FORM_CODE", "TAB_POSITION", "TAB_NAME", "NUMBER_OF_COLUMNS", "ICON_ID", "TAB_TYPE", "TAB_DISPLAY_NUMBER") values (
'MENUS'
,'SETTINGS'
,''
,'R'
,'���������'
,''
,'16'
,'3'
,'1');
/*  Form: MENUS. Entity: FORM_ACTIONS.  */

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'MENUS'
,'DEL'
,'&fc_schema_owner..MENUS_PKG.P_DELETE_MENU'
,'�����'
,'48'
,''
,''
,'3'
,'130'
,'�� �������� ��� ������ ������� ������?'
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'MENUS'
,'DELFORM'
,'&fc_schema_owner..MENUS_PKG.P_DELETE_FORM'
,'�����'
,'48'
,''
,''
,'3'
,'130'
,'�� �������� ��� ������ ������� ������?'
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'MENUS'
,'EDIT'
,''
,'�������������'
,'50'
,''
,''
,'8'
,'115'
,'�� ��������?'
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'MENUS'
,'INS'
,''
,'�������'
,'47'
,''
,''
,'1'
,'110'
,''
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'MENUS'
,'INSSIBL'
,'&fc_schema_owner..MENUS_PKG.P_INS_SIBL'
,'����'
,'47'
,''
,''
,'7'
,'112'
,'�� ��������?'
,''
,'Y'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'MENUS'
,'INSUPD'
,'&fc_schema_owner..MENUS_PKG.P_INS_CHLD'
,'�����'
,'47'
,''
,''
,'7'
,'111'
,'�� ��������?'
,''
,'N'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'MENUS'
,'REFR'
,''
,'��������'
,'15'
,''
,''
,'4'
,'10'
,''
,'Alt+R'
,'Y'
,'Y'
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT") values (
'MENUS'
,'UPD'
,'&fc_schema_owner..MENUS_PKG.P_UPDATE'
,'���������'
,'46'
,''
,''
,'2'
,'120'
,'�� ��������?'
,''
,'Y'
,'Y'
,''
,'');
/*  Form: MENUS. Entity: FORM_COLUMNS$.  */

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'11'
,'VARCHAR2'
,'400'
,'ELEMENT_TYPE'
,'12'
,'0'
,'0'
,'MENUS'
,''
,'*'
,'**ELEMENT_TYPE');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'12'
,'VARCHAR2'
,'1020'
,'FORM_CODE_FOR_FILTER'
,'20'
,'0'
,'0'
,'MENUS'
,''
,'*'
,'**FORM_CODE_FOR_FILTER');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'6'
,'VARCHAR2'
,'1020'
,'FORM_DISPLAY'
,'12'
,'0'
,'0'
,'MENUS'
,''
,'*'
,'**FORM_DISPLAY');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'7'
,'VARCHAR2'
,'1020'
,'FORM_DISPLAY_STAT'
,'17'
,'0'
,'0'
,'MENUS'
,''
,'*'
,'**FORM_DISPLAY_STAT');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'9'
,'NUMBER'
,'22'
,'ICON_ID'
,'7'
,'0'
,'0'
,'MENUS'
,''
,'*'
,'**ICON_ID');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'10'
,'NUMBER'
,'22'
,'IS_FOLDER'
,'9'
,'0'
,'0'
,'MENUS'
,''
,'*'
,'**IS_FOLDER');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'1'
,'VARCHAR2'
,'1020'
,'MENU_CODE'
,'9'
,'0'
,'0'
,'MENUS'
,'Y'
,'*'
,'*��� ����');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'5'
,'VARCHAR2'
,'1020'
,'MENU_FORM_CODE'
,'14'
,'0'
,'0'
,'MENUS'
,''
,'*'
,'*������ �� ����� (��� �������� �����)');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'2'
,'VARCHAR2'
,'1020'
,'MENU_NAME'
,'9'
,'0'
,'0'
,'MENUS'
,''
,'*'
,'*���������������� ������������ ����');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'8'
,'NUMBER'
,'22'
,'MENU_POSITION'
,'13'
,'0'
,'0'
,'MENUS'
,''
,'*'
,'*������� ������� �� ����� ������. ���� �� ������� - �� ������� ������������, ����� �� ������������');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'4'
,'VARCHAR2'
,'1020'
,'PARENT_DISPLAY'
,'14'
,'0'
,'0'
,'MENUS'
,''
,'*'
,'**PARENT_DISPLAY');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'3'
,'VARCHAR2'
,'1020'
,'PARENT_MENU_CODE'
,'16'
,'0'
,'0'
,'MENUS'
,''
,'*'
,'*������ �� ����� ����-��������');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'13'
,'VARCHAR2'
,'4'
,'SHOW_IN_NAVIGATOR'
,'17'
,'0'
,'0'
,'MENUS'
,''
,'*'
,'*���������� � ����������');
/*  Form: MENUS. Entity: FORM_COLUMNS.  */

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'MENUS'
,'ELEMENT_TYPE'
,''
,'*'
,'S'
,'1010'
,'N'
,'N'
,''
,''
,''
,'8'
,'**ELEMENT_TYPE'
,'N'
,'N'
,'FORMS.EDITOR_POSITION'
,''
,''
,''
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'MENUS'
,'FORM_CODE_FOR_FILTER'
,'������� ��� �������'
,'100'
,'S'
,'7'
,'N'
,'Y'
,''
,''
,''
,''
,'**FORM_CODE_FOR_FILTER'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'MENUS'
,'FORM_DISPLAY'
,''
,'*'
,'S'
,'9'
,'N'
,'N'
,''
,''
,'DET'
,'2'
,'**FORM_DISPLAY'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'MENUS'
,'FORM_DISPLAY_STAT'
,''
,'*'
,'S'
,'10'
,'N'
,'N'
,''
,''
,'SETTINGS'
,'1'
,'**FORM_DISPLAY_STAT'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,'FORM_DISPLAY_STAT'
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'MENUS'
,'ICON_ID'
,''
,'*'
,'N'
,'66'
,'N'
,'N'
,''
,'4'
,''
,''
,'**ICON_ID'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'MENUS'
,'IS_FOLDER'
,''
,'*'
,'B'
,'9'
,'N'
,'N'
,''
,'3'
,''
,''
,'**IS_FOLDER'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'MENUS'
,'MENU_CODE'
,'��� ����'
,'150'
,'S'
,'4'
,'Y'
,'Y'
,''
,'1'
,''
,'6'
,'*��� ����'
,'N'
,'N'
,''
,''
,''
,'1'
,''
,''
,''
,''
,''
,''
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'MENUS'
,'MENU_FORM_CODE'
,'�����'
,'200'
,'S'
,'3'
,'N'
,'Y'
,''
,''
,'FORMS'
,'9'
,'*������ �� ����� (��� �������� �����)'
,'N'
,'N'
,'FORMS_LIST'
,''
,''
,''
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'MENUS'
,'MENU_NAME'
,'���'
,'200'
,'S'
,'2'
,'N'
,'Y'
,''
,''
,''
,''
,'*���������������� ������������ ����'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,'1'
,''
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'MENUS'
,'MENU_POSITION'
,'������� � ����'
,'100'
,'N'
,'6'
,'N'
,'Y'
,''
,''
,''
,''
,'*������� ������� �� ����� ������. ���� �� ������� - �� ������� ������������, ����� �� ������������'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,'1'
,''
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'MENUS'
,'PARENT_DISPLAY'
,'��������'
,'100'
,'S'
,'5'
,'N'
,'Y'
,''
,''
,''
,''
,'**PARENT_DISPLAY'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'MENUS'
,'PARENT_MENU_CODE'
,'������ �� ����� ����-��������'
,'*'
,'S'
,'9'
,'N'
,'Y'
,''
,'2'
,''
,''
,'*������ �� ����� ����-��������'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'L'
,'Y'
,'*'
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION") values (
'MENUS'
,'SHOW_IN_NAVIGATOR'
,'���������� � ����������'
,'150'
,'B'
,'7'
,'N'
,'Y'
,''
,''
,''
,''
,'*���������� � ����������'
,'N'
,'N'
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'Y'
,'*'
,''
,'');
/*  Form: MENUS. Entity: FORM_COLUMN_ATTR_VALS.  */
/*  Form: MENUS. Entity: FORM_TAB_PARENT_EXCLNS.  */
/*  Form: MENUS. Entity: APPS_PRIVS.  */

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'SC'
,'MENUS');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'BF'
,'MENUS');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'AAHR'
,'MENUS');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'TC'
,'MENUS');

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'INS'
,'MENUS');



Alter Table forms Enable VALIDATE Constraint forms_form_actions_fk;
Alter Table FORMS Enable All Triggers;
