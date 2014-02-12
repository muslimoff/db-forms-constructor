
Alter Table FORMS Disable All Triggers;
Alter Table forms Disable Constraint forms_form_actions_fk;
delete from APPS_PRIVS where form_code = 'LOOKUPS_LIST';
delete from FORM_COLUMN_LOOKUP_MAP where form_code = 'LOOKUPS_LIST';
delete from FORM_COLUMN_ACTIONS where form_code = 'LOOKUPS_LIST';
delete from FORM_TAB_CHILDS_ALLOWED where form_code = 'LOOKUPS_LIST';
delete from FORM_TAB_PARENT_EXCLNS where form_code = 'LOOKUPS_LIST';
delete from FORM_COLUMN_ATTR_VALS where form_code = 'LOOKUPS_LIST';
delete from FORM_COLUMNS where form_code = 'LOOKUPS_LIST';
delete from FORM_COLUMNS$ where form_code = 'LOOKUPS_LIST';
delete from FORM_ACTIONS where form_code = 'LOOKUPS_LIST';
delete from FORM_TABS where form_code = 'LOOKUPS_LIST';
delete from FORMS where form_code = 'LOOKUPS_LIST';
/*  Form: LOOKUPS_LIST. Entity: FORMS.  */

insert into FORMS("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID", "FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR", "OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH", "DESCRIPTION", "DOUBLE_CLICK_ACTION_CODE", "LOOKUP_WIDTH", "APPS_CODE", "EXPORT_ORDER", "LOOKUP_HEIGHT", "DRAGDROP_ACTION_CODE", "DATA_PAGE_SIZE") values (
'LOOKUPS_LIST'
,''
,'Select :field_type lookup_type, a.lookup_code, a.lookup_name, 111 As icon_id
  From &fc_schema_owner..lookups a
 Where :field_type In (''8'', ''10'')
Union All
Select :field_type lookup_type, a.form_code, NVL (a.form_name, a.form_code) form_name, a.icon_id
  From &fc_schema_owner..forms_v a
 Where :field_type In (''9'', ''16'')
'
,'Список Списки'
,'G'
,'Y'
,'11'
,'*'
,'*'
,''
,''
,'Y'
,'35'
,'*'
,''
,''
,''
,'FC'
,'10'
,''
,''
,'');
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
,'*?????? ?? ????? - ?????? ??? ???????');

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
,'*???????????????? ???');

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

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT") values (
'LOOKUPS_LIST'
,'ICON_ID'
,'Иконка'
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
,''
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT") values (
'LOOKUPS_LIST'
,'LOOKUP_CODE'
,'Код'
,'*'
,'S'
,'10'
,'N'
,'Y'
,''
,''
,''
,''
,'*Ссылка на лукап - формау или простой'
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
,''
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT") values (
'LOOKUPS_LIST'
,'LOOKUP_NAME'
,'Пользовательское имя'
,'*'
,'S'
,'20'
,'N'
,'Y'
,''
,''
,''
,''
,'*Пользовательское имя'
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
,''
,''
,'');

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT") values (
'LOOKUPS_LIST'
,'LOOKUP_TYPE'
,'Тип'
,'*'
,'S'
,'1001'
,'N'
,'N'
,''
,''
,''
,'8'
,'*Тип - простой без редактирования, простой с добавлением на лету, SQL, SQL с добавлением'
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
,''
,''
,'');
/*  Form: LOOKUPS_LIST. Entity: FORM_COLUMN_ATTR_VALS.  */
/*  Form: LOOKUPS_LIST. Entity: FORM_TAB_PARENT_EXCLNS.  */
/*  Form: LOOKUPS_LIST. Entity: FORM_TAB_CHILDS_ALLOWED.  */
/*  Form: LOOKUPS_LIST. Entity: FORM_COLUMN_ACTIONS.  */
/*  Form: LOOKUPS_LIST. Entity: FORM_COLUMN_LOOKUP_MAP.  */
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
