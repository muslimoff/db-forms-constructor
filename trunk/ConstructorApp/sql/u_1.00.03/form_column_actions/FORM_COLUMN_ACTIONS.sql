
Alter Table FORMS Disable All Triggers;
Alter Table forms Disable Constraint forms_form_actions_fk;
Delete From APPS_PRIVS
      Where form_code = 'FORM_COLUMN_ACTIONS';
Delete From FORM_TAB_PARENT_EXCLNS
      Where form_code = 'FORM_COLUMN_ACTIONS';
Delete From FORM_COLUMN_ATTR_VALS
      Where form_code = 'FORM_COLUMN_ACTIONS';
Delete From FORM_COLUMNS
      Where form_code = 'FORM_COLUMN_ACTIONS';
Delete From FORM_COLUMNS$
      Where form_code = 'FORM_COLUMN_ACTIONS';
Delete From FORM_ACTIONS
      Where form_code = 'FORM_COLUMN_ACTIONS';
Delete From FORM_TABS
      Where form_code = 'FORM_COLUMN_ACTIONS';
Delete From FORMS
      Where form_code = 'FORM_COLUMN_ACTIONS';
/*  Form: FORM_COLUMN_ACTIONS. Entity: FORMS.  */

Insert Into FORMS
            ("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID"
            ,"FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR"
            ,"OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH", "DESCRIPTION", "DOUBLE_CLICK_ACTION_CODE", "LOOKUP_WIDTH"
            ,"APPS_CODE", "EXPORT_ORDER")
     Values ('FORM_COLUMN_ACTIONS', ''
            ,'Select *
  From &fc_schema_owner..form_column_actions a
 Where a.action_code = NVL (:action_code, a.action_code)
   And a.form_code = NVL (:form_code, a.form_code)
   And a.column_code = NVL (:column_code, a.column_code)
--'
            ,'', 'G', 'Y', '29', '*', '*', '', '', 'Y', '20', '*', '', '', '', '', '100');
/*  Form: FORM_COLUMN_ACTIONS. Entity: FORM_TABS.  */
/*  Form: FORM_COLUMN_ACTIONS. Entity: FORM_ACTIONS.  */

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('FORM_COLUMN_ACTIONS', 'DEL', '&fc_schema_owner..FORM_COLUMN_ACTIONS_PKG.p_delete', '�������', '48', ''
            ,'', '3', '130', '�� �������� ��� ������ ������� ������?', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('FORM_COLUMN_ACTIONS', 'EDIT', '', '�������������', '50', '', '', '8', '115', '�� ��������?', '', 'N', 'Y'
            ,'');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('FORM_COLUMN_ACTIONS', 'INS', '', '�������', '47', '', '', '1', '110', '', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('FORM_COLUMN_ACTIONS', 'REFR', '', '��������', '15', '', '', '4', '10', '', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('FORM_COLUMN_ACTIONS', 'UPD', '&fc_schema_owner..FORM_COLUMN_ACTIONS_PKG.p_ins_upd', '���������', '46', ''
            ,'', '2', '120', '�� ��������?', '', 'N', 'Y', '');
/*  Form: FORM_COLUMN_ACTIONS. Entity: FORM_COLUMNS$.  */

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('4', 'VARCHAR2', '1020', 'ACTION_CODE', '11', '0', '0', 'FORM_COLUMN_ACTIONS', 'Y', '*', '*��� ��������');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('5', 'VARCHAR2', '1020', 'ACTION_KEY_CODE', '15', '0', '0', 'FORM_COLUMN_ACTIONS', '', '*'
            ,'*������� (��� ���� "�� ������� �������").');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('3', 'VARCHAR2', '1020', 'COLUMN_CODE', '11', '0', '0', 'FORM_COLUMN_ACTIONS', 'Y', '*'
            ,'*������������� ���� (�� �������)');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('6', 'VARCHAR2', '1020', 'COL_ACTION_TYPE_CODE', '20', '0', '0', 'FORM_COLUMN_ACTIONS', '', '*'
            ,'*��� �������� (����� FORM_COLUMNS.ACTION_TYPE)');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('2', 'VARCHAR2', '1020', 'FORM_CODE', '9', '0', '0', 'FORM_COLUMN_ACTIONS', 'Y', '*'
            ,'*������������� ����');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('1', 'NUMBER', '22', 'FORM_COLUMN_ACTION_ID', '21', '0', '-127', 'FORM_COLUMN_ACTIONS', '', '*'
            ,'*����. ��� ���������� �� ����������');
/*  Form: FORM_COLUMN_ACTIONS. Entity: FORM_COLUMNS.  */

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMN_ACTIONS', 'ACTION_CODE', '��� ��������', '*', 'S', '40', 'N', 'Y', '', '1', '', '9'
            ,'*��� ��������', 'N', 'N', 'DBLCLICK_FORM_ACT_LIST', '', '', '1', '', '', '', '', ':ACTION_CODE', 'L', 'Y'
            ,'*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMN_ACTIONS', 'ACTION_KEY_CODE', '������� (��� ���� "�� ������� �������").', '*', 'S', '60', 'N'
            ,'Y', '', '', '', '', '*������� (��� ���� "�� ������� �������").', 'N', 'N', '', '', '', '', '', '', '', ''
            ,'', 'L', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMN_ACTIONS', 'COLUMN_CODE', '������������� ���� (�� �������)', '*', 'S', '30', 'N', 'Y', '', '1'
            ,'', '9', '*������������� ���� (�� �������)', 'N', 'N', 'COLUMNS_LIST', '', '', '1', '', '', '', ''
            ,':COLUMN_CODE', 'L', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMN_ACTIONS', 'COL_ACTION_TYPE_CODE', '��� ��������', '*', 'S', '50', 'N', 'Y', '', '', '', '8'
            ,'*��� �������� (����� FORM_COLUMNS.ACTION_TYPE)', 'N', 'N', 'FORM_COLUMNS.ACTION_TYPE', '', '', '', '', ''
            ,'', '', '', 'L', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMN_ACTIONS', 'FORM_CODE', '������������� ����', '*', 'S', '20', 'N', 'Y', '', '1', '', ''
            ,'*������������� ����', 'N', 'N', '', '', '', '1', '', '', '', '', ':FORM_CODE', 'L', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMN_ACTIONS', 'FORM_COLUMN_ACTION_ID', '����. ��� ���������� �� ����������', '*', 'N', '10', 'Y'
            ,'N', '', '', '', '9', '*����. ��� ���������� �� ����������', 'N', 'N', 'FORM_COLUMNS', '', '', '', '', ''
            ,'', '', '', 'L', 'Y', '*', '', '');
/*  Form: FORM_COLUMN_ACTIONS. Entity: FORM_COLUMN_ATTR_VALS.  */
/*  Form: FORM_COLUMN_ACTIONS. Entity: FORM_TAB_PARENT_EXCLNS.  */
/*  Form: FORM_COLUMN_ACTIONS. Entity: APPS_PRIVS.  */

Insert Into APPS_PRIVS
            ("APPS_CODE", "FORM_CODE")
     Values ('FC', 'FORM_COLUMN_ACTIONS');



Alter Table forms Enable VALIDATE Constraint forms_form_actions_fk;
Alter Table FORMS Enable All Triggers;

