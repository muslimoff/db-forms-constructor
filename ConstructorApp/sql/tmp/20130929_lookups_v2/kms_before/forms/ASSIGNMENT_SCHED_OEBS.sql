
Alter Table FORMS Disable All Triggers;
Alter Table forms Disable Constraint forms_form_actions_fk;
Delete From APPS_PRIVS
      Where form_code = 'ASSIGNMENT_SCHED_OEBS';
Delete From FORM_TAB_CHILDS_ALLOWED
      Where form_code = 'ASSIGNMENT_SCHED_OEBS';
Delete From FORM_TAB_PARENT_EXCLNS
      Where form_code = 'ASSIGNMENT_SCHED_OEBS';
Delete From FORM_COLUMN_ATTR_VALS
      Where form_code = 'ASSIGNMENT_SCHED_OEBS';
Delete From FORM_COLUMNS
      Where form_code = 'ASSIGNMENT_SCHED_OEBS';
Delete From FORM_COLUMNS$
      Where form_code = 'ASSIGNMENT_SCHED_OEBS';
Delete From FORM_ACTIONS
      Where form_code = 'ASSIGNMENT_SCHED_OEBS';
Delete From FORM_TABS
      Where form_code = 'ASSIGNMENT_SCHED_OEBS';
Delete From FORMS
      Where form_code = 'ASSIGNMENT_SCHED_OEBS';
/*  Form: ASSIGNMENT_SCHED_OEBS. Entity: FORMS.  */

Insert Into FORMS
            ("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID"
            ,"FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR"
            ,"OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH", "DESCRIPTION", "DOUBLE_CLICK_ACTION_CODE", "LOOKUP_WIDTH"
            ,"APPS_CODE", "EXPORT_ORDER", "LOOKUP_HEIGHT", "DRAGDROP_ACTION_CODE", "DATA_PAGE_SIZE")
     Values ('ASSIGNMENT_SCHED_OEBS', ''
            ,'Select t.Id As Assignment_Shedule_Id
      ,t.Assignment_Id
      ,Case
         When t.Effective_Start_Date = To_Date(''01.01.1951'', ''dd.mm.yyyy'') Then
          Null
         Else
          t.Effective_Start_Date
       End As Effective_Start_Date
      ,Case
         When t.Effective_End_Date = Apps.Hr_General.End_Of_Time Then
          Null
         Else
          t.Effective_End_Date
       End As Effective_End_Date
      ,t.Attribute1 As Schedule_Type_Id
      ,t.Attribute2 As Schedule_Id
      ,:Position_Id as Position_Id
       , to_char(t.last_update_date, ''dd.mm.yyyy hh24:mi:ss'') as last_update_date,
       t.last_updated_by,
       t.last_update_login,
       to_char(t.creation_date, ''dd.mm.yyyy hh24:mi:ss'') as creation_date,
       t.created_by,
       ''HXT_ADD_ASSIGN_INFO_F'' as table_name
  From Hxt.Hxt_Add_Assign_Info_f t --
 Where t.Assignment_Id = :Assignment_Id
   And t.Attribute1 Is Not Null
   And t.Attribute2 Is Not Null
'
            ,'Назначение графиков', 'G', 'Y', '', '*', '*', '', '', 'Y', '103', '*', '', '', '', '', '100', '', '', '');
/*  Form: ASSIGNMENT_SCHED_OEBS. Entity: FORM_TABS.  */

Insert Into FORM_TABS
            ("FORM_CODE", "TAB_CODE", "CHILD_FORM_CODE", "TAB_POSITION", "TAB_NAME", "NUMBER_OF_COLUMNS", "ICON_ID"
            ,"TAB_TYPE", "TAB_DISPLAY_NUMBER")
     Values ('ASSIGNMENT_SCHED_OEBS', 'TMP', '', '', 'Даты', '', '', '1', '');
/*  Form: ASSIGNMENT_SCHED_OEBS. Entity: FORM_ACTIONS.  */

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT", "PARENT_ACTION_CODE"
            ,"DISPLAY_IN_CONTEXT_MENU", "AUTOCOMMIT", "STATUS_BUTTON_PARAM", "STATUS_MSG_LEVEL_PARAM"
            ,"STATUS_MSG_TXT_PARAM")
     Values ('ASSIGNMENT_SCHED_OEBS', 'DEL', 'XXKMS.Xxhxt_Timesheet_Ui_Wrapper.On_Ass_Sched_Del', 'Удалить', '48', ''
            ,'', '3', '130', 'Вы уверены что хотите удалить запись?', '', 'N', 'Y', '', '', '', 'Y', 'Y', '', '', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT", "PARENT_ACTION_CODE"
            ,"DISPLAY_IN_CONTEXT_MENU", "AUTOCOMMIT", "STATUS_BUTTON_PARAM", "STATUS_MSG_LEVEL_PARAM"
            ,"STATUS_MSG_TXT_PARAM")
     Values ('ASSIGNMENT_SCHED_OEBS', 'EDIT', '', 'Редактировать', '50', '', '', '8', '115', '', '', 'N', 'Y', '', ''
            ,'', 'Y', 'Y', '', '', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT", "PARENT_ACTION_CODE"
            ,"DISPLAY_IN_CONTEXT_MENU", "AUTOCOMMIT", "STATUS_BUTTON_PARAM", "STATUS_MSG_LEVEL_PARAM"
            ,"STATUS_MSG_TXT_PARAM")
     Values ('ASSIGNMENT_SCHED_OEBS', 'HLP', '', 'История записи', '12', '', '', '11', '140', '', '', 'N', 'Y'
            ,'REFERENCE', '', '', 'Y', 'N', '', '', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT", "PARENT_ACTION_CODE"
            ,"DISPLAY_IN_CONTEXT_MENU", "AUTOCOMMIT", "STATUS_BUTTON_PARAM", "STATUS_MSG_LEVEL_PARAM"
            ,"STATUS_MSG_TXT_PARAM")
     Values ('ASSIGNMENT_SCHED_OEBS', 'INS', '', 'Создать', '47', '', '', '1', '110', '', '', 'N', 'Y', '', '', '', 'Y'
            ,'Y', '', '', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT", "PARENT_ACTION_CODE"
            ,"DISPLAY_IN_CONTEXT_MENU", "AUTOCOMMIT", "STATUS_BUTTON_PARAM", "STATUS_MSG_LEVEL_PARAM"
            ,"STATUS_MSG_TXT_PARAM")
     Values ('ASSIGNMENT_SCHED_OEBS', 'REFR', '', 'Обновить', '15', '', '', '4', '10', '', '', 'N', 'Y', '', '', 'UPD'
            ,'Y', 'Y', '', '', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT", "PARENT_ACTION_CODE"
            ,"DISPLAY_IN_CONTEXT_MENU", "AUTOCOMMIT", "STATUS_BUTTON_PARAM", "STATUS_MSG_LEVEL_PARAM"
            ,"STATUS_MSG_TXT_PARAM")
     Values ('ASSIGNMENT_SCHED_OEBS', 'UPD', 'XXKMS.Xxhxt_Timesheet_Ui_Wrapper.On_Ass_Sched_Ins_Upd', 'Сохранить', '46'
            ,'', '', '2', '120', 'Вы уверены?', '', 'N', 'Y', '', '', '', 'Y', 'Y', '', '', '');
/*  Form: ASSIGNMENT_SCHED_OEBS. Entity: FORM_COLUMNS$.  */

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('2', 'NUMBER', '22', 'ASSIGNMENT_ID', '13', '10', '0', 'ASSIGNMENT_SCHED_OEBS', '', '*', '**ASSIGNMENT_ID');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('1', 'NUMBER', '22', 'ASSIGNMENT_SHEDULE_ID', '21', '15', '0', 'ASSIGNMENT_SCHED_OEBS', '', '*'
            ,'**ASSIGNMENT_SHEDULE_ID');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('12', 'NUMBER', '22', 'CREATED_BY', '10', '15', '0', 'ASSIGNMENT_SCHED_OEBS', '', '*'
            ,'*User that created the flavor');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('11', 'VARCHAR2', '19', 'CREATION_DATE', '13', '0', '0', 'ASSIGNMENT_SCHED_OEBS', '', '*'
            ,'*Creation date of the model');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('4', 'DATE', '7', 'EFFECTIVE_END_DATE', '18', '0', '0', 'ASSIGNMENT_SCHED_OEBS', '', '*'
            ,'**EFFECTIVE_END_DATE');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('3', 'DATE', '7', 'EFFECTIVE_START_DATE', '20', '0', '0', 'ASSIGNMENT_SCHED_OEBS', '', '*'
            ,'**EFFECTIVE_START_DATE');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('9', 'NUMBER', '22', 'LAST_UPDATED_BY', '15', '15', '0', 'ASSIGNMENT_SCHED_OEBS', '', '*'
            ,'**LAST_UPDATED_BY');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('8', 'VARCHAR2', '19', 'LAST_UPDATE_DATE', '16', '0', '0', 'ASSIGNMENT_SCHED_OEBS', '', '*'
            ,'**LAST_UPDATE_DATE');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('10', 'NUMBER', '22', 'LAST_UPDATE_LOGIN', '17', '15', '0', 'ASSIGNMENT_SCHED_OEBS', '', '*'
            ,'**LAST_UPDATE_LOGIN');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('7', 'VARCHAR2', '2000', 'POSITION_ID', '11', '0', '0', 'ASSIGNMENT_SCHED_OEBS', '', '*', '**POSITION_ID');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('6', 'VARCHAR2', '150', 'SCHEDULE_ID', '11', '0', '0', 'ASSIGNMENT_SCHED_OEBS', '', '*', '**SCHEDULE_ID');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('5', 'VARCHAR2', '150', 'SCHEDULE_TYPE_ID', '16', '0', '0', 'ASSIGNMENT_SCHED_OEBS', '', '*'
            ,'**SCHEDULE_TYPE_ID');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('13', 'CHAR', '21', 'TABLE_NAME', '10', '0', '0', 'ASSIGNMENT_SCHED_OEBS', '', '*'
            ,'*Clustered table name');
/*  Form: ASSIGNMENT_SCHED_OEBS. Entity: FORM_COLUMNS.  */

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT")
     Values ('ASSIGNMENT_SCHED_OEBS', 'ASSIGNMENT_ID'
            ,'Assignemnt ID of task Assignment for which the audit records belongs to', '*', 'N', '1002', 'N', 'N', ''
            ,'1', '', '', '*Assignemnt ID of task Assignment for which the audit records belongs to', 'N', 'N', '', ''
            ,'', '1', '', '', '', '', ':assignment_id', 'L', 'Y', '*', '', '', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT")
     Values ('ASSIGNMENT_SCHED_OEBS', 'ASSIGNMENT_SHEDULE_ID', '', '*', 'N', '1001', 'Y', 'N', '', '1', '', ''
            ,'**ASSIGNMENT_SHEDULE_ID', 'N', 'N', '', '', '', '1', '', '', '', '', '', 'L', 'Y', '*', '', '', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT")
     Values ('ASSIGNMENT_SCHED_OEBS', 'CREATED_BY', 'User that created the flavor', '*', 'N', '1012', 'N', 'N', '', ''
            ,'', '', '*User that created the flavor', 'N', 'N', '', '', '', '', '', '', '', '', '', 'L', 'Y', '*', ''
            ,'', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT")
     Values ('ASSIGNMENT_SCHED_OEBS', 'CREATION_DATE', 'Creation date of the model', '*', 'S', '1011', 'N', 'N', '', ''
            ,'', '', '*Creation date of the model', 'N', 'N', '', '', '', '', '', '', '', '', '', 'L', 'Y', '*', '', ''
            ,'', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT")
     Values ('ASSIGNMENT_SCHED_OEBS', 'EFFECTIVE_END_DATE', 'Дата по', '', 'D', '1004', 'N', 'Y', '', '', 'TMP', '', ''
            ,'N', 'N', '', '', '', '', '', '', '', '', '', '', 'N', '', '', '', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT")
     Values ('ASSIGNMENT_SCHED_OEBS', 'EFFECTIVE_START_DATE', 'Дата с', '*', 'D', '1003', 'N', 'Y', '', '1', 'TMP', ''
            ,'*Effective start date', 'N', 'N', '', '', '', '1', '', '', '', '', '', 'L', 'Y', '*', '', '', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT")
     Values ('ASSIGNMENT_SCHED_OEBS', 'LAST_UPDATED_BY', '', '*', 'N', '1009', 'N', 'N', '', '', '', ''
            ,'**LAST_UPDATED_BY', 'N', 'N', '', '', '', '', '', '', '', '', '', 'L', 'Y', '*', '', '', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT")
     Values ('ASSIGNMENT_SCHED_OEBS', 'LAST_UPDATE_DATE', '', '*', 'S', '1008', 'N', 'N', '', '', '', ''
            ,'**LAST_UPDATE_DATE', 'N', 'N', '', '', '', '', '', '', '', '', '', 'L', 'Y', '*', '', '', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT")
     Values ('ASSIGNMENT_SCHED_OEBS', 'LAST_UPDATE_LOGIN', '', '*', 'N', '1010', 'N', 'N', '', '', '', ''
            ,'**LAST_UPDATE_LOGIN', 'N', 'N', '', '', '', '', '', '', '', '', '', 'L', 'Y', '*', '', '', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT")
     Values ('ASSIGNMENT_SCHED_OEBS', 'POSITION_ID', '', '*', 'S', '1007', 'N', 'N', '', '', '', '', '**POSITION_ID'
            ,'N', 'N', '', '', '', '', '', '', '', '', ':Position_Id', 'L', 'Y', '*', '', '', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT")
     Values ('ASSIGNMENT_SCHED_OEBS', 'SCHEDULE_ID', 'График', '*', 'N', '1005', 'N', 'Y', '', '', 'TMP', '9'
            ,'*Campaign Schedule id for which call information is summarized', 'N', 'N', 'SCHED_LIST_X', '', '', '', ''
            ,'', '', '', '', 'L', 'Y', '*', '', '', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT")
     Values ('ASSIGNMENT_SCHED_OEBS', 'SCHEDULE_TYPE_ID', '', '*', 'N', '1005', 'N', 'N', '', '', '', ''
            ,'**SCHEDULE_TYPE_ID', 'N', 'N', '', '', '', '', '', '', '', '', '', 'L', 'Y', '*', '', '', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT")
     Values ('ASSIGNMENT_SCHED_OEBS', 'TABLE_NAME', 'Clustered table name', '*', 'S', '1013', 'N', 'N', '', '', '', ''
            ,'*Clustered table name', 'N', 'N', '', '', '', '', '', '', '', '', '', 'L', 'Y', '*', '', '', '', '');
/*  Form: ASSIGNMENT_SCHED_OEBS. Entity: FORM_COLUMN_ATTR_VALS.  */
/*  Form: ASSIGNMENT_SCHED_OEBS. Entity: FORM_TAB_PARENT_EXCLNS.  */
/*  Form: ASSIGNMENT_SCHED_OEBS. Entity: FORM_TAB_CHILDS_ALLOWED.  */
/*  Form: ASSIGNMENT_SCHED_OEBS. Entity: APPS_PRIVS.  */


Declare
   l_clob   Clob := ' ';
Begin
   Update FORMS
      Set description = l_clob
    Where form_code = 'ASSIGNMENT_SCHED_OEBS';
End;
/

Alter Table forms Enable VALIDATE Constraint forms_form_actions_fk;
Alter Table FORMS Enable All Triggers;

