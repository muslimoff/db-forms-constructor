
Alter Table FORMS Disable All Triggers;
Alter Table forms Disable Constraint forms_form_actions_fk;
Delete From APPS_PRIVS
      Where form_code = 'FORMS';
Delete From FORM_COLUMN_LOOKUP_MAP
      Where form_code = 'FORMS';
Delete From FORM_COLUMN_ACTIONS
      Where form_code = 'FORMS';
Delete From FORM_TAB_CHILDS_ALLOWED
      Where form_code = 'FORMS';
Delete From FORM_TAB_PARENT_EXCLNS
      Where form_code = 'FORMS';
Delete From FORM_COLUMN_ATTR_VALS
      Where form_code = 'FORMS';
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
            ,"APPS_CODE", "EXPORT_ORDER", "LOOKUP_HEIGHT", "DRAGDROP_ACTION_CODE", "DATA_PAGE_SIZE")
     Values ('FORMS', 'Ctrl+Shift+q'
            ,'Select a.*, &fc_schema_owner..form_utils.get_inserts (a.form_code) form_dml
      ,&fc_schema_owner..form_utils.get_form_pkg_clob (a.form_code) As gen_pkg
--      ,form_utils.get_dbms_output () as dbms_output
  From &fc_schema_owner..forms a
 Where DECODE (:p_$master_form_code, ''FORMS2'', :form_code_for_filter, ''MENUS'', :form_code, a.form_code) = a.form_code
---------'
            ,'��������� �������� �����', 'G', 'Y', '4', '0%', '*', 'B', 'B', 'N', '232', '*', '', '', '', 'FC', '70'
            ,'', '', '');
/*  Form: FORMS. Entity: FORM_TABS.  */

Insert Into FORM_TABS
            ("FORM_CODE", "TAB_CODE", "CHILD_FORM_CODE", "TAB_POSITION", "TAB_NAME", "NUMBER_OF_COLUMNS", "ICON_ID"
            ,"TAB_TYPE", "TAB_DISPLAY_NUMBER")
     Values ('FORMS', 'DBMS_OUTPUT', 'FC_DBMS_OUTPUT_VIEWER', 'R', 'DBMS_OUTPUT', '', '44', '2', '50');

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
     Values ('FORMS', 'SQL', '', 'R', '��������', '4', '50', '1', '10');

Insert Into FORM_TABS
            ("FORM_CODE", "TAB_CODE", "CHILD_FORM_CODE", "TAB_POSITION", "TAB_NAME", "NUMBER_OF_COLUMNS", "ICON_ID"
            ,"TAB_TYPE", "TAB_DISPLAY_NUMBER")
     Values ('FORMS', 'SQL_TEXT', '', 'R', '������', '', '23', '1', '20');
/*  Form: FORMS. Entity: FORM_ACTIONS.  */

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT", "PARENT_ACTION_CODE"
            ,"DISPLAY_IN_CONTEXT_MENU", "AUTOCOMMIT", "STATUS_BUTTON_PARAM", "STATUS_MSG_LEVEL_PARAM"
            ,"STATUS_MSG_TXT_PARAM")
     Values ('FORMS', 'EXP', '', '�������', '2', '', '', '12', '200', '', '', 'N', 'Y', '', '', '', 'Y', 'Y', '', ''
            ,'');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT", "PARENT_ACTION_CODE"
            ,"DISPLAY_IN_CONTEXT_MENU", "AUTOCOMMIT", "STATUS_BUTTON_PARAM", "STATUS_MSG_LEVEL_PARAM"
            ,"STATUS_MSG_TXT_PARAM")
     Values ('FORMS', 'NEXT', '', '������', '53', '', '', '6', '40', '', '', 'N', 'Y', '', '', '', 'Y', 'Y', '', '', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT", "PARENT_ACTION_CODE"
            ,"DISPLAY_IN_CONTEXT_MENU", "AUTOCOMMIT", "STATUS_BUTTON_PARAM", "STATUS_MSG_LEVEL_PARAM"
            ,"STATUS_MSG_TXT_PARAM")
     Values ('FORMS', 'PREV', '', '�����', '54', '', '', '5', '30', '', '', 'N', 'Y', '', '', '', 'Y', 'Y', '', '', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT", "PARENT_ACTION_CODE"
            ,"DISPLAY_IN_CONTEXT_MENU", "AUTOCOMMIT", "STATUS_BUTTON_PARAM", "STATUS_MSG_LEVEL_PARAM"
            ,"STATUS_MSG_TXT_PARAM")
     Values ('FORMS', 'REFRESH', '', '��������', '55', '', '', '4', '10', '', '', 'N', 'Y', '', '', '', 'Y', 'Y', ''
            ,'', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE", "URL_TEXT", "PARENT_ACTION_CODE"
            ,"DISPLAY_IN_CONTEXT_MENU", "AUTOCOMMIT", "STATUS_BUTTON_PARAM", "STATUS_MSG_LEVEL_PARAM"
            ,"STATUS_MSG_TXT_PARAM")
     Values ('FORMS', 'UPD', '&fc_schema_owner..FORMS_PKG.P_INSERT_UPDATE', '���������', '46', '', '', '2', '120'
            ,'�� �������?', '', 'N', 'Y', '', '', '', 'Y', 'Y', '', '', '');
/*  Form: FORMS. Entity: FORM_COLUMNS$.  */

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('18', 'VARCHAR2', '1020', 'APPS_CODE', '9', '0', '0', 'FORMS', '', '*'
            ,'*??? ??????????. ???? ?????? ??? ????????? ????????? ????????');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('10', 'VARCHAR2', '8', 'BOTTOM_TABS_ORIENTATION', '23', '0', '0', 'FORMS', '', '*'
            ,'*?????????? ?????? ??????? ???????????. ??. FORMS.TABS_ORIENTATION');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('22', 'NUMBER', '22', 'DATA_PAGE_SIZE', '14', '0', '-127', 'FORMS', '', '*'
            ,'*When using data paging, how many records to fetch at a time. See com.smartgwt.client.widgets.grid.ListGrid.setDataPageSize');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('14', 'VARCHAR2', '120', 'DEFAULT_COLUMN_WIDTH', '20', '0', '0', 'FORMS', '', '*'
            ,'*?????? ????? ?? ?????????');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('15', 'CLOB', '4000', 'DESCRIPTION', '11', '0', '0', 'FORMS', '', '*'
            ,'*???????? ?????... ??? ??????????? ??? ????????? ?????? ? ?.?');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('16', 'VARCHAR2', '1020', 'DOUBLE_CLICK_ACTION_CODE', '24', '0', '0', 'FORMS', '', '*'
            ,'*???????? ?? ???????? ?????? ?? ??????. ?? ????????? - ??????????????');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('21', 'VARCHAR2', '255', 'DRAGDROP_ACTION_CODE', '20', '0', '0', 'FORMS', '', '*'
            ,'*��� Drag&Drop - ���������� ��������������, ������� ��� ��������, ������� ����� ����������');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('19', 'NUMBER', '22', 'EXPORT_ORDER', '12', '0', '-127', 'FORMS', '', '*'
            ,'*?????????? ????? ??? ????????? ????????');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('1', 'VARCHAR2', '1020', 'FORM_CODE', '9', '0', '0', 'FORMS', 'Y', '*', '*??? ?????');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('23', 'CLOB', '4000', 'FORM_DML', '8', '0', '0', 'FORMS', '', '*', '**FORM_DML');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('9', 'VARCHAR2', '120', 'FORM_HEIGHT', '11', '0', '0', 'FORMS', '', '*'
            ,'*?????? ? ???????? ??? ?????????. * - ????');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('4', 'VARCHAR2', '1020', 'FORM_NAME', '9', '0', '0', 'FORMS', '', '*', '*??? ????? ??? ????????????');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('5', 'VARCHAR2', '4', 'FORM_TYPE', '9', '0', '0', 'FORMS', '', '*', '*??? ?????. G-????, T-??????...');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('8', 'VARCHAR2', '120', 'FORM_WIDTH', '10', '0', '0', 'FORMS', '', '*'
            ,'*?????? ? ???????? ??? ?????????. * - ????');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('24', 'CLOB', '4000', 'GEN_PKG', '7', '0', '0', 'FORMS', '', '*', '**GEN_PKG');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('2', 'VARCHAR2', '400', 'HOT_KEY', '7', '0', '0', 'FORMS', '', '*'
            ,'*??????? ???????  - ?????? ???? [Ctrl+][Alt+][Shift+]Chr. ??????? ?? ?????');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('7', 'NUMBER', '22', 'ICON_ID', '7', '0', '-127', 'FORMS', '', '*', '**ICON_ID');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('20', 'NUMBER', '22', 'LOOKUP_HEIGHT', '13', '0', '-127', 'FORMS', '', '*'
            ,'*������ ������ (���� ����� ��������� � ���� ������)');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('17', 'NUMBER', '22', 'LOOKUP_WIDTH', '12', '0', '-127', 'FORMS', '', '*'
            ,'*?????? ?????? (???? ????? ????????? ? ???? ??????)');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('13', 'NUMBER', '22', 'OBJECT_VERSION_NUMBER', '21', '0', '-127', 'FORMS', '', '*'
            ,'**OBJECT_VERSION_NUMBER');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('12', 'VARCHAR2', '4', 'SHOW_BOTTOM_TOOLBAR', '19', '0', '0', 'FORMS', '', '*'
            ,'*?????????? ?????? ???????');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('6', 'VARCHAR2', '4', 'SHOW_TREE_ROOT_NODE', '19', '0', '0', 'FORMS', '', '*'
            ,'*?????????? ?? ???????? ???? ??? ???????');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('11', 'VARCHAR2', '8', 'SIDE_TABS_ORIENTATION', '21', '0', '0', 'FORMS', '', '*'
            ,'*?????????? ??????? ??????? ???????????. ??. FORMS.TABS_ORIENTATION');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('3', 'VARCHAR2', '4000', 'SQL_TEXT', '8', '0', '0', 'FORMS', '', '*'
            ,'*Order by ?? ??????? ??????? ?? ???????????, ????? ??? ?????????? ?????? ?????..');
/*  Form: FORMS. Entity: FORM_COLUMNS.  */

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT")
     Values ('FORMS', 'APPS_CODE', '��� ����������', '*', 'S', '220', 'N', 'N', '', '', 'SQL', ''
            ,'��� ����������. ���� ������ ��� ���������� �������� ���������', 'N', 'N', '', '', '', '', '', '', '', ''
            ,'', 'L', 'Y', '*', '', '', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT")
     Values ('FORMS', 'BOTTOM_TABS_ORIENTATION', '���������� ������ �������', '*', 'S', '150', 'N', 'N', '', '', 'SQL'
            ,'10', '���������� ������ ������� �����������. ��. FORMS.TABS_ORIENTATION', 'N', 'N'
            ,'FORMS.TABS_ORIENTATION', '', '', '', '', '', '', '', '', 'L', 'N', '1', '', '', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT")
     Values ('FORMS', 'DATA_PAGE_SIZE', '����� � �������', '*', 'N', '1022', 'N', 'Y', '', '', 'SQL', ''
            ,'**When using data paging, how many records to fetch at a time. See com.smartgwt.client.widgets.grid.ListGrid.setDataPageSize'
            ,'N', 'Y', '', '', '', '', '', '', '', '', '', 'L', 'Y', '*', '', '', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT")
     Values ('FORMS', 'DEFAULT_COLUMN_WIDTH', '������ ����� �� ���������', '*', 'S', '190', 'N', 'N', '', '', 'SQL', ''
            ,'*������ ����� �� ���������', 'N', 'N', '', '', '', '', '', '', '', '', '', 'L', 'Y', '*', '', '', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT")
     Values ('FORMS', 'DESCRIPTION', '��������', '*', 'S', '5', 'N', 'N', '', '', 'SQL_TEXT', '5', '��������', 'N', 'N'
            ,'', '', '200', '', '', '', '', '', '', 'T', 'Y', '*', '', '', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT")
     Values ('FORMS', 'DOUBLE_CLICK_ACTION_CODE', '�������� �� �������� ������', '*', 'S', '250', 'N', 'N', '', ''
            ,'SQL', '16', '*�������� �� �������� ������ �� ������. �� ��������� - ��������������', 'N', 'N'
            ,'DBLCLICK_FORM_ACT_LIST', '', '', '', '', '', '', '', '', 'L', 'Y', '*', '', '', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT")
     Values ('FORMS', 'DRAGDROP_ACTION_CODE', '�������� ��� Drag&Drop � ������', '*', 'S', '260', 'N', 'Y', '', ''
            ,'SQL', '16', '*��� Drag&Drop - ���������� ��������������, ������� ��� ��������, ������� ����� ����������'
            ,'N', 'N', 'DBLCLICK_FORM_ACT_LIST', '', '', '', '', '', '', '', '', 'L', 'Y', '*', '', '', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT")
     Values ('FORMS', 'EXPORT_ORDER', '� ��� ����.��������', '*', 'N', '230', 'N', 'Y', '', '', 'SQL', ''
            ,'���������� ����� ����� ��� ����.�������� ����� ����������', 'N', 'N', '', '', '', '', '', '', '', '', ''
            ,'L', 'Y', '*', '', '', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT")
     Values ('FORMS', 'FORM_CODE', '��� �����', '25%', 'S', '3', 'Y', 'N', '', '1', 'SQL', '', '������������� �����'
            ,'N', 'N', '', '', '', '1', '', '', '', '', '', 'L', 'Y', '*', '', '', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT")
     Values ('FORMS', 'FORM_DML', '', '*', 'S', '600', 'N', 'N', '', '', 'DML', '15', '**FORM_DML', 'N', 'N', '', ''
            ,'500', '', '', '', '', '', '', 'T', 'Y', '*', '', '', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT")
     Values ('FORMS', 'FORM_HEIGHT', '������ �����', '*', 'S', '140', 'N', 'N', '', '', 'SQL', ''
            ,'������ � �������� ��� ���������. * - ����', 'N', 'N', '', '', '', '', '', '', '', '', '', 'L', 'Y', '1'
            ,'', '', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT")
     Values ('FORMS', 'FORM_NAME', '���������������� ��� �����', '40%', 'S', '2', 'N', 'Y', '', '', 'SQL', ''
            ,'��� ����� ��� ������������', 'N', 'N', '', '', '', '', '', '', '', '', '', 'L', 'Y', '*', '', '', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT")
     Values ('FORMS', 'FORM_TYPE', '��� �����', '*', 'S', '100', 'N', 'N', '', '', 'SQL', '8', '��� ������������ �����'
            ,'N', 'N', 'FORMS.FORM_TYPE', '', '', '', '', '', '', '', '', 'L', 'Y', '*', '', '', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT")
     Values ('FORMS', 'FORM_WIDTH', '������ �����', '*', 'S', '130', 'N', 'N', '', '', 'SQL', ''
            ,'������ � �������� ��� ���������. * - ����', 'N', 'N', '', '', '', '', '', '', '', '', '', 'L', 'N', '1'
            ,'', '', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT")
     Values ('FORMS', 'GEN_PKG', '', '*', 'S', '700', 'N', 'N', '', '', 'PKG', '15', '**GEN_PKG', 'N', 'N', '', ''
            ,'500', '', '', '', '', '', '', 'T', 'Y', '*', '', '', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT")
     Values ('FORMS', 'HOT_KEY', '������� �������', '*', 'S', '8', 'N', 'N', '', '', 'SQL', ''
            ,'������� �������  - ������ ���� [Ctrl+][Alt+][Shift+]Chr. ������� �� �����', 'N', 'N', '', '', '', '', ''
            ,'', '', '', '', 'L', 'Y', '*', '', '', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT")
     Values ('FORMS', 'ICON_ID', '������', '*', 'S', '120', 'N', 'N', '', '', 'SQL', '16', '������', 'N', 'N', 'ICONS'
            ,'', '', '', '', '', '', '', '', 'L', 'Y', '*', '', '', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT")
     Values ('FORMS', 'LOOKUP_HEIGHT', '������ ������', '*', 'N', '180', 'N', 'Y', '', '', 'SQL', ''
            ,'*������ ������ (���� ����� ��������� � ���� ������)', 'N', 'N', '', '', '', '', '', '', '', '', '', 'L'
            ,'Y', '1', '', '', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT")
     Values ('FORMS', 'LOOKUP_WIDTH', '������ ������', '*', 'N', '170', 'N', 'Y', '', '', 'SQL', ''
            ,'*������ ������ (���� ����� ��������� � ���� ������)', 'N', 'N', '', '', '', '', '', '', '', '', '', 'L'
            ,'N', '1', '', '', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT")
     Values ('FORMS', 'OBJECT_VERSION_NUMBER', '', '*', 'N', '225', 'N', 'N', '', '', '', '', '**OBJECT_VERSION_NUMBER'
            ,'N', 'N', '', '', '', '', '', '', '', '', '', 'L', 'Y', '*', '', '', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT")
     Values ('FORMS', 'SHOW_BOTTOM_TOOLBAR', '���������� ������ ������', '*', 'B', '240', 'N', 'N', '', '', 'SQL', ''
            ,'*���������� ������ ������?', 'N', 'N', '', '', '', '', '', '', '', '', '', 'L', 'Y', '*', '', '', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT")
     Values ('FORMS', 'SHOW_TREE_ROOT_NODE', '���������� �� �������� ���� ��� ������?', '*', 'B', '110', 'N', 'N', ''
            ,'', 'SQL', '', '���������� �� �������� ���� ��� ������?', 'N', 'N', '', '', '', '', '', '', '', '', ''
            ,'L', 'Y', '*', '', '', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT")
     Values ('FORMS', 'SIDE_TABS_ORIENTATION', '���������� ������� �������', '*', 'S', '160', 'N', 'N', '', '', 'SQL'
            ,'10', '*���������� ������� ������� �����������. ��. FORMS.TABS_ORIENTATION', 'N', 'N'
            ,'FORMS.TABS_ORIENTATION', '', '', '', '', '', '', '', '', 'L', 'Y', '1', '', '', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION", "LOOKUP_WIDTH", "LOOKUP_HEIGHT")
     Values ('FORMS', 'SQL_TEXT', '����� �������', '4000', 'S', '6', 'N', 'Y', '', '', 'SQL_TEXT', '15'
            ,'*Order by �� ������� ������� �� �����������, ����� ��� ���������� ������ �����..', 'N', 'N', '', ''
            ,'200', '', '', '', '', '', '', 'T', 'Y', '*', '', '', '', '');
/*  Form: FORMS. Entity: FORM_COLUMN_ATTR_VALS.  */
/*  Form: FORMS. Entity: FORM_TAB_PARENT_EXCLNS.  */
/*  Form: FORMS. Entity: FORM_TAB_CHILDS_ALLOWED.  */
/*  Form: FORMS. Entity: FORM_COLUMN_ACTIONS.  */
/*  Form: FORMS. Entity: FORM_COLUMN_LOOKUP_MAP.  */

Insert Into FORM_COLUMN_LOOKUP_MAP
            ("FORM_COLUMN_LOOKUP_MAP_ID", "FORM_CODE", "COLUMN_CODE", "LOOKUP_FORM_CODE", "LOOKUP_FORM_COLUMN_CODE"
            ,"MAPPING_TYPE", "CONSTANT_VALUE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DISPLAY_NUMBER"
            ,"SHOW_ON_GRID", "COLUMN_CODE_TO_MAPPING")
     Values ('20492', 'FORMS', 'DOUBLE_CLICK_ACTION_CODE', 'DBLCLICK_FORM_ACT_LIST', 'ACTION_CODE', 'COLUMN', '', '���'
            ,'*', '1001', 'Y', 'DOUBLE_CLICK_ACTION_CODE');

Insert Into FORM_COLUMN_LOOKUP_MAP
            ("FORM_COLUMN_LOOKUP_MAP_ID", "FORM_CODE", "COLUMN_CODE", "LOOKUP_FORM_CODE", "LOOKUP_FORM_COLUMN_CODE"
            ,"MAPPING_TYPE", "CONSTANT_VALUE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DISPLAY_NUMBER"
            ,"SHOW_ON_GRID", "COLUMN_CODE_TO_MAPPING")
     Values ('20493', 'FORMS', 'DRAGDROP_ACTION_CODE', 'DBLCLICK_FORM_ACT_LIST', 'ACTION_CODE', 'COLUMN', '', '���'
            ,'*', '1001', 'Y', 'DRAGDROP_ACTION_CODE');

Insert Into FORM_COLUMN_LOOKUP_MAP
            ("FORM_COLUMN_LOOKUP_MAP_ID", "FORM_CODE", "COLUMN_CODE", "LOOKUP_FORM_CODE", "LOOKUP_FORM_COLUMN_CODE"
            ,"MAPPING_TYPE", "CONSTANT_VALUE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DISPLAY_NUMBER"
            ,"SHOW_ON_GRID", "COLUMN_CODE_TO_MAPPING")
     Values ('20491', 'FORMS', 'ICON_ID', 'ICONS', 'ICON_ID', 'COLUMN', '', '��� ������', '10%', '1001', 'Y', 'ICON_ID');
/*  Form: FORMS. Entity: APPS_PRIVS.  */

Insert Into APPS_PRIVS
            ("APPS_CODE", "FORM_CODE")
     Values ('SC', 'FORMS');

Insert Into APPS_PRIVS
            ("APPS_CODE", "FORM_CODE")
     Values ('BF', 'FORMS');

Insert Into APPS_PRIVS
            ("APPS_CODE", "FORM_CODE")
     Values ('AAHR', 'FORMS');

Insert Into APPS_PRIVS
            ("APPS_CODE", "FORM_CODE")
     Values ('TC', 'FORMS');

Insert Into APPS_PRIVS
            ("APPS_CODE", "FORM_CODE")
     Values ('INS', 'FORMS');


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
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>���������� ������ �������.</b></font></span><div>���������� ������ ������� ����������� - ��. FORMS.TABS_ORIENTATION.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORMS'
      And column_code = 'BOTTOM_TABS_ORIENTATION';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>����� � �������.</b></font></span><div>When using data paging, how many records to fetch at a time. See com.smartgwt.client.widgets.grid.ListGrid.setDataPageSize</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORMS'
      And column_code = 'DATA_PAGE_SIZE';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>������ ����� �� ���������.</b></font></span><div>�� ��������� - "*" - ��� ����� (�� ���������������� �������������) ���� ����� ����� ����� �������� "*", �.�. �� ������ ����� ����������� ������������� ��� ���������� � ����� ��� ���������� (��. �������� ������� �����).</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORMS'
      And column_code = 'DEFAULT_COLUMN_WIDTH';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>��������.</b></font></span><div>�������� ����� - ����������� ��������� � ����.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORMS'
      And column_code = 'DESCRIPTION';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>�������� �� �������� ������.</b></font></span><div>�������� ���������.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORMS'
      And column_code = 'DOUBLE_CLICK_ACTION_CODE';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>�������� ��� Drag&Drop � ������.</b></font></span><div>��������, ������� ����� ���������� ��� ���������� Drag&Drop.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORMS'
      And column_code = 'DRAGDROP_ACTION_CODE';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>��� �����.</b></font></span><div>����������&nbsp;�������������&nbsp;�����. ��������� ���� ��� �������� ���� (����� �����, �������, ��������).</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORMS'
      And column_code = 'FORM_CODE';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>FORM_DML.</b></font></span><div>�������� ���������.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORMS'
      And column_code = 'FORM_DML';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>������ �����.</b></font></span><div>������ � �������� ��� ���������. "*" - ����.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORMS'
      And column_code = 'FORM_HEIGHT';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>���������������� ��� �����.</b></font></span><div>��� �����, ������������ �� ��������, � �.�. ������������ ������ �����������, ����, ��� ���������� ������ ��������������� � ���� ���������.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORMS'
      And column_code = 'FORM_NAME';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>��� �����.</b></font></span><div>��� �����: ���� (��������� ���), ������. � ����������� - ��������� �����, ���������.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORMS'
      And column_code = 'FORM_TYPE';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>������ �����.</b></font></span><div>������ � �������� ��� ���������. "*" - ����.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORMS'
      And column_code = 'FORM_WIDTH';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>������� �������.</b></font></span><div>���������� ������ ��� ������ ����� - ������ ���� [Ctrl+][Alt+][Shift+]Chr. ������� �� �����.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORMS'
      And column_code = 'HOT_KEY';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>������.</b></font></span><div>������, ������������ � ���� � ��������.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORMS'
      And column_code = 'ICON_ID';
End;
/

Declare
   l_clob   Clob := '��';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORMS'
      And column_code = 'LOOKUP_HEIGHT';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>������ ������.</b></font></span><div>�������� ���������.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORMS'
      And column_code = 'LOOKUP_WIDTH';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>OBJECT_VERSION_NUMBER.</b></font></span><div>�������� ���������.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORMS'
      And column_code = 'OBJECT_VERSION_NUMBER';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>���������� ������ ������.</b></font></span><div>�������� ���������.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORMS'
      And column_code = 'SHOW_BOTTOM_TOOLBAR';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>���������� �� �������� ���� ��� ������?.</b></font></span><div>�������� ���������.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORMS'
      And column_code = 'SHOW_TREE_ROOT_NODE';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>���������� ������� �������.</b></font></span><div>�������� ���������.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORMS'
      And column_code = 'SIDE_TABS_ORIENTATION';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>����� �������.</b></font></span><div>����� SQL-�������. �� ��������� ������� ������� ������� ����������� ������ ����� "�������" (������� FORM_COLUMNS).</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORMS'
      And column_code = 'SQL_TEXT';
End;
/

Alter Table forms Enable VALIDATE Constraint forms_form_actions_fk;
Alter Table FORMS Enable All Triggers;

