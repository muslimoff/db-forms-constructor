
Alter Table FORMS Disable All Triggers;
Alter Table forms Disable Constraint forms_form_actions_fk;
delete from APPS_PRIVS where form_code = 'SCHED_LIST_X';
delete from FORM_TAB_CHILDS_ALLOWED where form_code = 'SCHED_LIST_X';
delete from FORM_TAB_PARENT_EXCLNS where form_code = 'SCHED_LIST_X';
delete from FORM_COLUMN_ATTR_VALS where form_code = 'SCHED_LIST_X';
delete from FORM_COLUMNS where form_code = 'SCHED_LIST_X';
delete from FORM_COLUMNS$ where form_code = 'SCHED_LIST_X';
delete from FORM_ACTIONS where form_code = 'SCHED_LIST_X';
delete from FORM_TABS where form_code = 'SCHED_LIST_X';
delete from FORMS where form_code = 'SCHED_LIST_X';
/*  Form: SCHED_LIST_X. Entity: FORMS.  */

insert into FORMS("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID", "FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR", "OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH", "DESCRIPTION", "DOUBLE_CLICK_ACTION_CODE", "LOOKUP_WIDTH", "APPS_CODE", "EXPORT_ORDER", "LOOKUP_HEIGHT", "DRAGDROP_ACTION_CODE", "DATA_PAGE_SIZE") values (
'SCHED_LIST_X'
,''
,'Select q.Schedule_Id, q.Schedule_Code, q.Schedule_Type
  From (Select d.Assignment_Id As Schedule_Id
              ,Pap.Person_Id As Schedule_Type_Id
              ,Last_Value(d.Assignment_Number) Over(Partition By d.Assignment_Id Order By d.Effective_Start_Date) As Schedule_Code
              ,Pap.Last_Name || ''  ('' || d.Assignment_Number || '')'' As Schedule_Type
          From Hr.Per_All_Assignments_f a
          Join Apps.Per_Position_Extra_Info e
            On e.Position_Id = a.Position_Id
          Join Hr.Per_All_People_f Pap
            On Pap.Person_Id = To_Number(e.Poei_Information2)
           And e.Information_Type = ''XXHR_VALID_SCHEDULES''
          Join Apps.Per_All_Assignments_f d
            On d.Assignment_Id = To_Number(e.Poei_Information3)
         Where a.Assignment_Id = :Assignment_Id
           And a.Position_Id = :Position_Id) q --
 Group By q.Schedule_Id
         ,q.Schedule_Code
         ,q.Schedule_Type_Id
         ,q.Schedule_Type
'
,'Графики - список'
,'G'
,'Y'
,''
,'25%'
,'*'
,''
,''
,'N'
,'25'
,'*'
,''
,''
,'450'
,'TC'
,'100'
,''
,''
,'');
/*  Form: SCHED_LIST_X. Entity: FORM_TABS.  */
/*  Form: SCHED_LIST_X. Entity: FORM_ACTIONS.  */

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT", "PARENT_ACTION_CODE", "DISPLAY_IN_CONTEXT_MENU", "AUTOCOMMIT", "STATUS_BUTTON_PARAM", "STATUS_MSG_LEVEL_PARAM", "STATUS_MSG_TXT_PARAM") values (
'SCHED_LIST_X'
,'DEL'
,'..SCHED_LIST_X_PKG.p_delete'
,'Удалить'
,'48'
,''
,''
,'3'
,'130'
,'Вы уверены что хотите удалить запись?'
,''
,'Y'
,'Y'
,''
,''
,''
,'Y'
,'Y'
,''
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT", "PARENT_ACTION_CODE", "DISPLAY_IN_CONTEXT_MENU", "AUTOCOMMIT", "STATUS_BUTTON_PARAM", "STATUS_MSG_LEVEL_PARAM", "STATUS_MSG_TXT_PARAM") values (
'SCHED_LIST_X'
,'EDIT'
,''
,'Редактировать'
,'50'
,''
,''
,'8'
,'115'
,'Вы уверены?'
,''
,'N'
,'Y'
,''
,''
,''
,'Y'
,'Y'
,''
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT", "PARENT_ACTION_CODE", "DISPLAY_IN_CONTEXT_MENU", "AUTOCOMMIT", "STATUS_BUTTON_PARAM", "STATUS_MSG_LEVEL_PARAM", "STATUS_MSG_TXT_PARAM") values (
'SCHED_LIST_X'
,'EXP'
,''
,'Экспорт'
,'122'
,''
,''
,'12'
,'200'
,'Вы уверены?'
,''
,'N'
,'N'
,''
,''
,''
,'Y'
,'N'
,''
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT", "PARENT_ACTION_CODE", "DISPLAY_IN_CONTEXT_MENU", "AUTOCOMMIT", "STATUS_BUTTON_PARAM", "STATUS_MSG_LEVEL_PARAM", "STATUS_MSG_TXT_PARAM") values (
'SCHED_LIST_X'
,'INS'
,''
,'Создать'
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
,''
,''
,'Y'
,'Y'
,''
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT", "PARENT_ACTION_CODE", "DISPLAY_IN_CONTEXT_MENU", "AUTOCOMMIT", "STATUS_BUTTON_PARAM", "STATUS_MSG_LEVEL_PARAM", "STATUS_MSG_TXT_PARAM") values (
'SCHED_LIST_X'
,'REFR'
,''
,'Обновить'
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
,''
,''
,'Y'
,'Y'
,''
,''
,'');

insert into FORM_ACTIONS("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX", "DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY", "SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT", "PARENT_ACTION_CODE", "DISPLAY_IN_CONTEXT_MENU", "AUTOCOMMIT", "STATUS_BUTTON_PARAM", "STATUS_MSG_LEVEL_PARAM", "STATUS_MSG_TXT_PARAM") values (
'SCHED_LIST_X'
,'UPD'
,'..SCHED_LIST_X_PKG.p_ins_upd'
,'Сохранить'
,'46'
,''
,''
,'2'
,'120'
,'Вы уверены?'
,''
,'N'
,'Y'
,''
,''
,''
,'Y'
,'Y'
,''
,''
,'');
/*  Form: SCHED_LIST_X. Entity: FORM_COLUMNS$.  */

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'2'
,'VARCHAR2'
,'30'
,'SCHEDULE_CODE'
,'13'
,'0'
,'0'
,'SCHED_LIST_X'
,''
,'*'
,'**SCHEDULE_CODE');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'1'
,'NUMBER'
,'22'
,'SCHEDULE_ID'
,'11'
,'10'
,'0'
,'SCHED_LIST_X'
,''
,'*'
,'**SCHEDULE_ID');

insert into FORM_COLUMNS$("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE", "FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION") values (
'3'
,'VARCHAR2'
,'184'
,'SCHEDULE_TYPE'
,'13'
,'0'
,'0'
,'SCHED_LIST_X'
,''
,'*'
,'*Type of the schedule');
/*  Form: SCHED_LIST_X. Entity: FORM_COLUMNS.  */

insert into FORM_COLUMNS("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE", "COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE", "EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE", "HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP", "DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG", "EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT") values (
'SCHED_LIST_X'
,'SCHEDULE_CODE'
,'Код'
,'*'
,'S'
,'1002'
,'N'
,'Y'
,''
,''
,''
,''
,'**SCHEDULE_CODE'
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
'SCHED_LIST_X'
,'SCHEDULE_ID'
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
,'**SCHEDULE_ID'
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
'SCHED_LIST_X'
,'SCHEDULE_TYPE'
,'График'
,'*'
,'S'
,'1003'
,'N'
,'Y'
,''
,''
,''
,''
,'*Type of the schedule'
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
,''
,''
,'');
/*  Form: SCHED_LIST_X. Entity: FORM_COLUMN_ATTR_VALS.  */
/*  Form: SCHED_LIST_X. Entity: FORM_TAB_PARENT_EXCLNS.  */
/*  Form: SCHED_LIST_X. Entity: FORM_TAB_CHILDS_ALLOWED.  */
/*  Form: SCHED_LIST_X. Entity: APPS_PRIVS.  */

insert into APPS_PRIVS("APPS_CODE", "FORM_CODE") values (
'FC'
,'SCHED_LIST_X');



Alter Table forms Enable VALIDATE Constraint forms_form_actions_fk;
Alter Table FORMS Enable All Triggers;
