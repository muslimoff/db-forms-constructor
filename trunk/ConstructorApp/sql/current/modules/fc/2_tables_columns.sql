Alter Table "APPLICATIONS" Add "SCHEMA_NAME" Varchar2(400);
Alter Table "APPLICATIONS" Add "APPS_DESCRIPTION" Varchar2(4000);
Alter Table "APPLICATIONS" Add "APPS_NAME" Varchar2(4000);
Alter Table "APPLICATIONS" Add "APPS_CODE" Varchar2(800);
Alter Table "APPLICATIONS" Add "DEFAULT_TABLE_PREFIX" Varchar2(40);
Alter Table "APPS_PRIVS" Add "APPS_CODE" Varchar2(800);
Alter Table "APPS_PRIVS" Add "FORM_CODE" Varchar2(1020);
Alter Table "APPS_ROLES" Add "APPS_ROLE_ID" Number(22, 0);
Alter Table "APPS_ROLES" Add "ROLE_CODE" Varchar2(4000);
Alter Table "APPS_ROLES" Add "ROLE_NAME" Varchar2(4000);
Alter Table "APPS_ROLES" Add "APPS_CODE" Varchar2(4000);
Alter Table "APPS_ROLES" Add "ROOT_MENU_CODE" Varchar2(4000);
Alter Table "APPS_ROLE_MENUS" Add "APP_MENU_ID" Number(22, 0);
Alter Table "APPS_ROLE_MENUS" Add "MENU_CODE" Varchar2(4000);
Alter Table "APPS_ROLE_MENUS" Add "PARENT_MENU_CODE" Varchar2(4000);
Alter Table "APPS_ROLE_MENUS" Add "POSITION" Number(22, 9);
Alter Table "APPS_ROLE_MENUS" Add "FORM_CODE" Varchar2(4000);
Alter Table "APPS_ROLE_MENUS" Add "ENABLED_FLAG" Varchar2(4000);
Alter Table "APPS_ROLE_MENUS" Add "DISPLAY_NAME" Varchar2(4000);
Alter Table "APPS_ROLE_USERS" Add "APP_ROLE_USER_ID" Number(22, 0);
Alter Table "APPS_ROLE_USERS" Add "ROLE_CODE" Varchar2(4000);
Alter Table "APPS_ROLE_USERS" Add "APPS_CODE" Varchar2(4000);
Alter Table "APPS_ROLE_USERS" Add "USER_ID" Number(22, 0);
Alter Table "BINDS_V" Add "FORM_CODE" Varchar2(1020);
Alter Table "BINDS_V" Add "POSITION" Number(22, 0);
Alter Table "BINDS_V" Add "DATATYPE" Varchar2(1020);
Alter Table "BINDS_V" Add "MAX_LENGTH" Number(22, 0);
Alter Table "BINDS_V" Add "ARRAY_LEN" Number(22, 0);
Alter Table "BINDS_V" Add "BIND_NAME" Varchar2(1020);
Alter Table "FORMS" Add "FORM_CODE" Varchar2(1020);
Alter Table "FORMS" Add "HOT_KEY" Varchar2(400);
Alter Table "FORMS" Add "SQL_TEXT" Varchar2(4000);
Alter Table "FORMS" Add "FORM_NAME" Varchar2(1020);
Alter Table "FORMS" Add "FORM_TYPE" Varchar2(4);
Alter Table "FORMS" Add "SHOW_TREE_ROOT_NODE" Varchar2(4);
Alter Table "FORMS" Add "ICON_ID" Number(22, 0);
Alter Table "FORMS" Add "FORM_WIDTH" Varchar2(120);
Alter Table "FORMS" Add "FORM_HEIGHT" Varchar2(120);
Alter Table "FORMS" Add "BOTTOM_TABS_ORIENTATION" Varchar2(8);
Alter Table "FORMS" Add "SIDE_TABS_ORIENTATION" Varchar2(8);
Alter Table "FORMS" Add "SHOW_BOTTOM_TOOLBAR" Varchar2(4);
Alter Table "FORMS" Add "OBJECT_VERSION_NUMBER" Number(22, 0);
Alter Table "FORMS" Add "DEFAULT_COLUMN_WIDTH" Varchar2(120);
Alter Table "FORMS" Add "DESCRIPTION" CLOB;
Alter Table "FORMS" Add "DOUBLE_CLICK_ACTION_CODE" Varchar2(1020);
Alter Table "FORMS" Add "LOOKUP_WIDTH" Number(22, 0);
Alter Table "FORMS" Add "APPS_CODE" Varchar2(1020);
Alter Table "FORMS" Add "EXPORT_ORDER" Number(22, 0);
Alter Table "FORMS_V" Add "APPS_CODE" Varchar2(1020);
Alter Table "FORMS_V" Add "EXPORT_ORDER" Number(22, 0);
Alter Table "FORMS_V" Add "FORM_CODE" Varchar2(1020);
Alter Table "FORMS_V" Add "HOT_KEY" Varchar2(400);
Alter Table "FORMS_V" Add "SQL_TEXT" Varchar2(4000);
Alter Table "FORMS_V" Add "FORM_NAME" Varchar2(1020);
Alter Table "FORMS_V" Add "DESCRIPTION" CLOB;
Alter Table "FORMS_V" Add "FORM_TYPE" Varchar2(4);
Alter Table "FORMS_V" Add "SHOW_TREE_ROOT_NODE" Varchar2(4);
Alter Table "FORMS_V" Add "ICON_ID" Number(22, 0);
Alter Table "FORMS_V" Add "FORM_WIDTH" Varchar2(120);
Alter Table "FORMS_V" Add "FORM_HEIGHT" Varchar2(120);
Alter Table "FORMS_V" Add "BOTTOM_TABS_ORIENTATION" Varchar2(8);
Alter Table "FORMS_V" Add "SIDE_TABS_ORIENTATION" Varchar2(8);
Alter Table "FORMS_V" Add "SHOW_BOTTOM_TOOLBAR" Varchar2(4);
Alter Table "FORMS_V" Add "OBJECT_VERSION_NUMBER" Number(22, 0);
Alter Table "FORMS_V" Add "DEFAULT_COLUMN_WIDTH" Varchar2(120);
Alter Table "FORMS_V" Add "DOUBLE_CLICK_ACTION_CODE" Varchar2(1020);
Alter Table "FORMS_V" Add "LOOKUP_WIDTH" Number(22, 0);
Alter Table "FORM_ACTIONS" Add "FORM_CODE" Varchar2(1020);
Alter Table "FORM_ACTIONS" Add "ACTION_CODE" Varchar2(1020);
Alter Table "FORM_ACTIONS" Add "PROCEDURE_NAME" Varchar2(1020);
Alter Table "FORM_ACTIONS" Add "ACTION_DISPLAY_NAME" Varchar2(1020);
Alter Table "FORM_ACTIONS" Add "ICON_ID" Number(22, 0);
Alter Table "FORM_ACTIONS" Add "DEFAULT_PARAM_PREFIX" Varchar2(1020);
Alter Table "FORM_ACTIONS" Add "DEFAULT_OLD_PARAM_PREFIX" Varchar2(1020);
Alter Table "FORM_ACTIONS" Add "ACTION_TYPE" Varchar2(8);
Alter Table "FORM_ACTIONS" Add "DISPLAY_NUMBER" Number(22, 0);
Alter Table "FORM_ACTIONS" Add "CONFIRM_TEXT" Varchar2(4000);
Alter Table "FORM_ACTIONS" Add "HOT_KEY" Varchar2(1020);
Alter Table "FORM_ACTIONS" Add "SHOW_SEPARATOR_BELOW" Varchar2(4);
Alter Table "FORM_ACTIONS" Add "DISPLAY_ON_TOOLBAR" Varchar2(4);
Alter Table "FORM_ACTIONS" Add "CHILD_FORM_CODE" Varchar2(1020);
Alter Table "FORM_COLUMNS" Add "FORM_CODE" Varchar2(1020);
Alter Table "FORM_COLUMNS" Add "COLUMN_CODE" Varchar2(1020);
Alter Table "FORM_COLUMNS" Add "COLUMN_USER_NAME" Varchar2(1020);
Alter Table "FORM_COLUMNS" Add "COLUMN_DISPLAY_SIZE" Varchar2(1020);
Alter Table "FORM_COLUMNS" Add "COLUMN_DATA_TYPE" Varchar2(1020);
Alter Table "FORM_COLUMNS" Add "COLUMN_DISPLAY_NUMBER" Number(22, 0);
Alter Table "FORM_COLUMNS" Add "PIMARY_KEY_FLAG" Varchar2(4);
Alter Table "FORM_COLUMNS" Add "SHOW_ON_GRID" Varchar2(4);
Alter Table "FORM_COLUMNS" Add "TREE_INITIALIZATION_VALUE" Varchar2(4000);
Alter Table "FORM_COLUMNS" Add "TREE_FIELD_TYPE" Varchar2(8);
Alter Table "FORM_COLUMNS" Add "EDITOR_TAB_CODE" Varchar2(1020);
Alter Table "FORM_COLUMNS" Add "FIELD_TYPE" Varchar2(8);
Alter Table "FORM_COLUMNS" Add "COLUMN_DESCRIPTION" Varchar2(4000);
Alter Table "FORM_COLUMNS" Add "IS_FROZEN_FLAG" Varchar2(4);
Alter Table "FORM_COLUMNS" Add "SHOW_HOVER_FLAG" Varchar2(4);
Alter Table "FORM_COLUMNS" Add "LOOKUP_CODE" Varchar2(1020);
Alter Table "FORM_COLUMNS" Add "HOVER_COLUMN_CODE" Varchar2(1020);
Alter Table "FORM_COLUMNS" Add "EDITOR_HEIGHT" Varchar2(1020);
Alter Table "FORM_COLUMNS" Add "LOOKUP_FIELD_TYPE" Varchar2(4);
Alter Table "FORM_COLUMNS" Add "HELP_TEXT" CLOB;
Alter Table "FORM_COLUMNS" Add "TEXT_MASK" Varchar2(1020);
Alter Table "FORM_COLUMNS" Add "VALIDATION_REGEXP" Varchar2(1020);
Alter Table "FORM_COLUMNS" Add "DEFAULT_ORDERBY_NUMBER" Varchar2(40);
Alter Table "FORM_COLUMNS" Add "DEFAULT_VALUE" Varchar2(1020);
Alter Table "FORM_COLUMNS" Add "EDITOR_TITLE_ORIENTATION" Varchar2(4);
Alter Table "FORM_COLUMNS" Add "EDITOR_END_ROW_FLAG" Varchar2(4);
Alter Table "FORM_COLUMNS" Add "EDITOR_COLS_SPAN" Varchar2(40);
Alter Table "FORM_COLUMNS" Add "LOOKUP_DISPLAY_VALUE" Varchar2(1020);
Alter Table "FORM_COLUMNS" Add "EDITOR_ON_ENTER_KEY_ACTION" Varchar2(1020);
Alter Table "FORM_COLUMNS$" Add "COL_NUM" Number(22, 0);
Alter Table "FORM_COLUMNS$" Add "COL_TYPE" Varchar2(1020);
Alter Table "FORM_COLUMNS$" Add "COL_MAX_LEN" Number(22, 0);
Alter Table "FORM_COLUMNS$" Add "COL_NAME" Varchar2(4000);
Alter Table "FORM_COLUMNS$" Add "COL_NAME_LEN" Number(22, 0);
Alter Table "FORM_COLUMNS$" Add "COL_PRECISION" Number(22, 0);
Alter Table "FORM_COLUMNS$" Add "COL_SCALE" Number(22, 0);
Alter Table "FORM_COLUMNS$" Add "FORM_CODE" Varchar2(1020);
Alter Table "FORM_COLUMNS$" Add "PIMARY_KEY_FLAG" Varchar2(4);
Alter Table "FORM_COLUMNS$" Add "DEFAULT_COLUMN_WIDTH" Varchar2(120);
Alter Table "FORM_COLUMNS$" Add "COLUMN_DESCRIPTION" Varchar2(4000);
Alter Table "FORM_COLUMN_ATTR_VALS" Add "FORM_COLUMN_ATTR_VAL_ID" Number(22, 0);
Alter Table "FORM_COLUMN_ATTR_VALS" Add "FORM_CODE" Varchar2(1020);
Alter Table "FORM_COLUMN_ATTR_VALS" Add "COLUMN_CODE" Varchar2(1020);
Alter Table "FORM_COLUMN_ATTR_VALS" Add "ATTRIBUTE_CODE" Varchar2(1020);
Alter Table "FORM_COLUMN_ATTR_VALS" Add "ATTRIBUTE_VALUE" Varchar2(1020);
Alter Table "FORM_PROPS" Add "PROPERTY_LEVEL" Varchar2(4000);
Alter Table "FORM_PROPS" Add "PROPERTY_CODE" Varchar2(4000);
Alter Table "FORM_PROPS" Add "PROPERTY_NAME" Varchar2(4000);
Alter Table "FORM_PROPS" Add "DESCRIPTION" Varchar2(4000);
Alter Table "FORM_PROPS" Add "HELP_TEXT" CLOB;
Alter Table "FORM_PROPS" Add "PROP_DATATYPE" Varchar2(4000);
Alter Table "FORM_PROPS" Add "PROPERTY_ID" Number(22, 0);
Alter Table "FORM_PROP_VALUES" Add "PROP_VALUE_ID" Number(22, 0);
Alter Table "FORM_PROP_VALUES" Add "FORM_CODE" Varchar2(4000);
Alter Table "FORM_PROP_VALUES" Add "PROPERTY_LEVEL" Varchar2(4000);
Alter Table "FORM_PROP_VALUES" Add "PROPERTY_CODE" Varchar2(4000);
Alter Table "FORM_PROP_VALUES" Add "PROP_VAL_LEVEL" Varchar2(4000);
Alter Table "FORM_PROP_VALUES" Add "VALUE_CHAR" Varchar2(4000);
Alter Table "FORM_PROP_VALUES" Add "VALUE_NUMBER" Number(22, 0);
Alter Table "FORM_PROP_VALUES" Add "VALUE_DATE" Date;
Alter Table "FORM_PROP_VALUES" Add "VALUE_CLOB" CLOB;
Alter Table "FORM_TABS" Add "FORM_CODE" Varchar2(1020);
Alter Table "FORM_TABS" Add "TAB_CODE" Varchar2(1020);
Alter Table "FORM_TABS" Add "CHILD_FORM_CODE" Varchar2(1020);
Alter Table "FORM_TABS" Add "TAB_POSITION" Varchar2(4);
Alter Table "FORM_TABS" Add "TAB_NAME" Varchar2(1020);
Alter Table "FORM_TABS" Add "NUMBER_OF_COLUMNS" Number(22, 0);
Alter Table "FORM_TABS" Add "ICON_ID" Number(22, 0);
Alter Table "FORM_TABS" Add "TAB_TYPE" Varchar2(8);
Alter Table "FORM_TABS" Add "TAB_DISPLAY_NUMBER" Number(22, 0);
Alter Table "FORM_TABS_V" Add "FORM_CODE" Varchar2(1020);
Alter Table "FORM_TABS_V" Add "TAB_CODE" Varchar2(1020);
Alter Table "FORM_TABS_V" Add "CHILD_FORM_CODE" Varchar2(1020);
Alter Table "FORM_TABS_V" Add "TAB_POSITION" Varchar2(4);
Alter Table "FORM_TABS_V" Add "TAB_NAME" Varchar2(1020);
Alter Table "FORM_TABS_V" Add "NUMBER_OF_COLUMNS" Number(22, 0);
Alter Table "FORM_TABS_V" Add "ICON_ID" Number(22, 0);
Alter Table "FORM_TABS_V" Add "TAB_TYPE" Varchar2(8);
Alter Table "FORM_TABS_V" Add "TAB_DISPLAY_NUMBER" Number(22, 0);
Alter Table "FORM_TAB_PARENT_EXCLNS" Add "FORM_CODE" Varchar2(4000);
Alter Table "FORM_TAB_PARENT_EXCLNS" Add "TAB_CODE" Varchar2(4000);
Alter Table "FORM_TAB_PARENT_EXCLNS" Add "PARENT_FORM_CODE" Varchar2(4000);
Alter Table "FORM_TAB_PARENT_EXCLNS" Add "INCLUDED_FLAG" Varchar2(8);
Alter Table "FORM_TAB_PARENT_EXCLNS" Add "EXCLN_ID" Number(22, 0);
Alter Table "GLOBAL_PARAMS" Add "PARAM_NAME" Varchar2(1020);
Alter Table "GLOBAL_PARAMS" Add "PARAM_VALUE" Varchar2(1020);
Alter Table "ICONS" Add "ICON_ID" Number(22, 0);
Alter Table "ICONS" Add "ICON_FILE_NAME" Varchar2(4000);
Alter Table "ICONS" Add "ICON_PATH" Varchar2(1020);
Alter Table "LOOKUPS" Add "LOOKUP_CODE" Varchar2(1020);
Alter Table "LOOKUPS" Add "LOOKUP_NAME" Varchar2(1020);
Alter Table "LOOKUP_ATTRIBUTES" Add "LOOKUP_CODE" Varchar2(1020);
Alter Table "LOOKUP_ATTRIBUTES" Add "ATTRIBUTE_CODE" Varchar2(1020);
Alter Table "LOOKUP_ATTRIBUTES" Add "ATTRIBUTE_NAME" Varchar2(1020);
Alter Table "LOOKUP_ATTRIBUTES" Add "ATTRIBUTE_TYPE" Varchar2(4);
Alter Table "LOOKUP_ATTRIBUTE_VALUES" Add "LOOKUP_CODE" Varchar2(1020);
Alter Table "LOOKUP_ATTRIBUTE_VALUES" Add "LOOKUP_VALUE_CODE" Varchar2(1020);
Alter Table "LOOKUP_ATTRIBUTE_VALUES" Add "ATTRIBUTE_CODE" Varchar2(1020);
Alter Table "LOOKUP_ATTRIBUTE_VALUES" Add "ATTRIBUTE_VALUE_NUMBER" Number(22, 0);
Alter Table "LOOKUP_ATTRIBUTE_VALUES" Add "ATTRIBUTE_VALUE_CHAR" Varchar2(4000);
Alter Table "LOOKUP_ATTRIBUTE_VALUES" Add "ATTRIBUTE_VALUE_DATE" Date;
Alter Table "LOOKUP_VALUES" Add "LOOKUP_CODE" Varchar2(1020);
Alter Table "LOOKUP_VALUES" Add "LOOKUP_VALUE_CODE" Varchar2(1020);
Alter Table "LOOKUP_VALUES" Add "LOOKUP_DISPLAY_VALUE" Varchar2(1020);
Alter Table "LOOKUP_VALUES" Add "LOOKUP_VALUE_ID" Number(22, 0);
Alter Table "MENUS" Add "MENU_CODE" Varchar2(1020);
Alter Table "MENUS" Add "MENU_NAME" Varchar2(1020);
Alter Table "MENUS" Add "PARENT_MENU_CODE" Varchar2(1020);
Alter Table "MENUS" Add "MENU_FORM_CODE" Varchar2(1020);
Alter Table "MENUS" Add "MENU_POSITION" Number(22, 0);
Alter Table "MENUS" Add "SHOW_IN_NAVIGATOR" Varchar2(4);
Alter Table "REPORT_TEMPLATES" Add "REPORT_ID" Number(22, 0);
Alter Table "REPORT_TEMPLATES" Add "USER_ID" Number(22, 0);
Alter Table "REPORT_TEMPLATES" Add "APP_CODE" Varchar2(1020);
Alter Table "REPORT_TEMPLATES" Add "REPORT_TYPE_CODE" Varchar2(1020);
Alter Table "REPORT_TEMPLATES" Add "CONTENT_TYPE" Varchar2(1020);
Alter Table "REPORT_TEMPLATES" Add "CONTENT" BLOB;
Alter Table "REPORT_TEMPLATES" Add "FILENAME" Varchar2(1020);
Alter Table "REPORT_TEMPLATES" Add "CLOB_CONTENT" CLOB;
Alter Table "TMP1" Add "LVL" Number(22, 0);
Alter Table "TMP1" Add "MENU_CODE" Varchar2(1020);
Alter Table "TMP1" Add "PARENT_MENU_CODE" Varchar2(1020);
Alter Table "TMP1" Add "MENU_POSITION" Number(22, 0);
Alter Table "TMP1" Add "SHOW_IN_NAVIGATOR" Varchar2(4);
Alter Table "TMP1" Add "MENU_NAME" Varchar2(1020);
Alter Table "TMP1" Add "FORM_CODE" Varchar2(1020);
Alter Table "TMP1" Add "FORM_NAME" Varchar2(1020);
Alter Table "TMP1" Add "ICON_ID" Number(22, 0);
Alter Table "TMP1" Add "HOT_KEY" Varchar2(400);
Alter Table "TMP1" Add "DESCRIPTION" CLOB;
Alter Table "TMP1" Add "CHILD_COUNT" Number(22, 0);
Alter Table "USERS" Add "USER_ID" Number(22, 0);
Alter Table "USERS" Add "FIO" Varchar2(4000);
Alter Table "USERS" Add "USERNAME" Varchar2(1020);
Alter Table "USERS" Add "PASSWORD" Varchar2(255);
Alter Table "USERS" Add "ORIG_REF_ID" Number(22, 10);
Alter Table "USERS" Add "EMAIL" Varchar2(4000);

Comment On Column "FORMS"."FORM_CODE" Is '��������� ������������� �����';
Comment On Column "FORMS"."HOT_KEY" Is '������� �������  - ������ ���� [Ctrl+][Alt+][Shift+]Chr. ������� �� �����';
Comment On Column "FORMS"."SQL_TEXT" Is 'Order by �� ������� ������� �� �����������, ����� ��� ���������� ������ �����..';
Comment On Column "FORMS"."FORM_NAME" Is '��� ����� ��� ������������';
Comment On Column "FORMS"."FORM_TYPE" Is '��� �����. G-����, T-������...';
Comment On Column "FORMS"."SHOW_TREE_ROOT_NODE" Is '���������� �� �������� ���� ��� ������?';
Comment On Column "FORMS"."FORM_WIDTH" Is '������ � �������� ��� ���������. * - ����';
Comment On Column "FORMS"."FORM_HEIGHT" Is '������ � �������� ��� ���������. * - ����';
Comment On Column "FORMS"."BOTTOM_TABS_ORIENTATION" Is '���������� ������ ������� �����������. ��. FORMS.TABS_ORIENTATION';
Comment On Column "FORMS"."SIDE_TABS_ORIENTATION" Is '���������� ������� ������� �����������. ��. FORMS.TABS_ORIENTATION';
Comment On Column "FORMS"."SHOW_BOTTOM_TOOLBAR" Is '���������� ������ ������?';
Comment On Column "FORMS"."DEFAULT_COLUMN_WIDTH" Is '������ ����� �� ���������';
Comment On Column "FORMS"."DESCRIPTION" Is '�������� �����... ��� ����������� ��� ��������� ������ � �.�';
Comment On Column "FORMS"."DOUBLE_CLICK_ACTION_CODE" Is '�������� �� �������� ������ �� ������. �� ��������� - ��������������';
Comment On Column "FORMS"."LOOKUP_WIDTH" Is '������ ������ (���� ����� ��������� � ���� ������)';
Comment On Column "FORMS"."APPS_CODE" Is '��� ����������. ���� ������ ��� ��������� ��������� ��������';
Comment On Column "FORMS"."EXPORT_ORDER" Is '���������� ����� ��� ��������� ��������';
Comment On Column "FORM_ACTIONS"."CHILD_FORM_CODE" Is '����� �������� ����� � ����� ����/����';
Comment On Column "FORM_COLUMNS"."FORM_CODE" Is '������������� ����';
Comment On Column "FORM_COLUMNS"."COLUMN_CODE" Is '������������� ���� (�� �������)';
Comment On Column "FORM_COLUMNS"."COLUMN_USER_NAME" Is '���������������� ��� ����';
Comment On Column "FORM_COLUMNS"."COLUMN_DISPLAY_SIZE" Is '������ ���� � ���������';
Comment On Column "FORM_COLUMNS"."COLUMN_DATA_TYPE" Is '��� ������ (FORM_COLUMNS.DATA_TYPE)';
Comment On Column "FORM_COLUMNS"."COLUMN_DISPLAY_NUMBER" Is '���������� ����� ����������� � �������';
Comment On Column "FORM_COLUMNS"."PIMARY_KEY_FLAG" Is '������� ����, ��� ���� �������� ��������� ������ (Y). ����� - �� ��������.';
Comment On Column "FORM_COLUMNS"."SHOW_ON_GRID" Is '���������� � �����';
Comment On Column "FORM_COLUMNS"."TREE_INITIALIZATION_VALUE" Is '���� �� ����� � ��� ����� - "������" - ������������ ��� ������ ������ ������ ��� �������������. ���������� ����������� Start With ����������� ��������';
Comment On Column "FORM_COLUMNS"."TREE_FIELD_TYPE" Is '��� ���� ��� ������ (Id, ParentId, ChildCount...)';
Comment On Column "FORM_COLUMNS"."EDITOR_TAB_CODE" Is '������ �� �������� ����� ��������������. ���� �� ������� - ������������ ������ � �����';
Comment On Column "FORM_COLUMNS"."FIELD_TYPE" Is '��� ����, ����� ��� ������ � �����';
Comment On Column "FORM_COLUMNS"."COLUMN_DESCRIPTION" Is '�������� ���� (��������� ��� ������������)';
Comment On Column "FORM_COLUMNS"."IS_FROZEN_FLAG" Is '������������ ����?';
Comment On Column "FORM_COLUMNS"."SHOW_HOVER_FLAG" Is '���������� ����������� ���������-�������� ����';
Comment On Column "FORM_COLUMNS"."LOOKUP_CODE" Is '������ �� ����� - ������ ��� �������';
Comment On Column "FORM_COLUMNS"."HOVER_COLUMN_CODE" Is '���� ��� �� �����, ������� �������� ���������. ���� SHOW_HOVER_FLAG = ''Y'' � HOVER_COLUMN_CODE - ��������� ������� �� �������� ���� (COLUMN_CODE)';
Comment On Column "FORM_COLUMNS"."EDITOR_HEIGHT" Is '������ ���� � �������� ��������������';
Comment On Column "FORM_COLUMNS"."LOOKUP_FIELD_TYPE" Is '��. Lookup FORM_COLUMNS.LOOKUP_FIELD_TYPE';
Comment On Column "FORM_COLUMNS"."HELP_TEXT" Is '�������� ���� � HTML';
Comment On Column "FORM_COLUMNS"."TEXT_MASK" Is '��������� ����� ��� ����. ��. �������� � ����������';
Comment On Column "FORM_COLUMNS"."VALIDATION_REGEXP" Is '���������� ��������� ��� ���������� ���������';
Comment On Column "FORM_COLUMNS"."DEFAULT_ORDERBY_NUMBER" Is '������� ���������� ��� �������� �����. "-" ����� ����� - ���������� �� ��������';
Comment On Column "FORM_COLUMNS"."DEFAULT_VALUE" Is '�������� �� ��������� ��� ����� �������';
Comment On Column "FORM_COLUMNS"."EDITOR_TITLE_ORIENTATION" Is 'item.setTitleOrientation';
Comment On Column "FORM_COLUMNS"."EDITOR_END_ROW_FLAG" Is 'item.setEndRow';
Comment On Column "FORM_COLUMNS"."EDITOR_COLS_SPAN" Is '�������� - ���������� �������, ���������� ����� (item.setColSpan)';
Comment On Column "FORM_COLUMNS"."LOOKUP_DISPLAY_VALUE" Is '���� �������, ������������ ������������ - ��� ������� �������';
Comment On Column "FORM_COLUMNS"."EDITOR_ON_ENTER_KEY_ACTION" Is '�������� �� ������� Enter';
Comment On Column "FORM_COLUMN_ATTR_VALS"."FORM_COLUMN_ATTR_VAL_ID" Is 'Id';
Comment On Column "FORM_COLUMN_ATTR_VALS"."FORM_CODE" Is '������������� ����';
Comment On Column "FORM_COLUMN_ATTR_VALS"."COLUMN_CODE" Is '������������� ���� (�� �������)';
Comment On Column "FORM_COLUMN_ATTR_VALS"."ATTRIBUTE_CODE" Is '��� ��������';
Comment On Column "FORM_COLUMN_ATTR_VALS"."ATTRIBUTE_VALUE" Is '�������� ��������';
Comment On Column "FORM_PROPS"."PROPERTY_LEVEL" Is 'FORM->TAB->COLUMN-ACTION';
Comment On Column "FORM_PROPS"."PROPERTY_CODE" Is '���� SQL_TEXT';
Comment On Column "FORM_PROPS"."PROPERTY_NAME" Is '���� "����� �������"';
Comment On Column "FORM_PROPS"."DESCRIPTION" Is '��������, ��� ���������';
Comment On Column "FORM_PROPS"."HELP_TEXT" Is 'HTML ����� ��� ��������� � ����������';
Comment On Column "FORM_PROPS"."PROP_DATATYPE" Is '��� ������ N(umber) D(ate) S(tring) B(oolean) L(OB)';
Comment On Column "FORM_PROPS"."PROPERTY_ID" Is 'ID';
Comment On Column "FORM_PROP_VALUES"."PROP_VAL_LEVEL" Is 'SYSTEM->APP->PARENT_FORM->ROLE->USER (System - ��� ������ �������� FORM_COLUMNS$). �������� � ������������';
Comment On Column "FORM_TABS"."FORM_CODE" Is '������������� ����';
Comment On Column "FORM_TABS"."TAB_CODE" Is '������������� ��������';
Comment On Column "FORM_TABS"."TAB_POSITION" Is 'Lookup FORMS.EDITOR_POSITION';
Comment On Column "FORM_TABS"."TAB_NAME" Is '���������������� ��� ��������';
Comment On Column "FORM_TABS"."NUMBER_OF_COLUMNS" Is '��. com.smartgwt.client.widgets.form.DynamicForm   setNumCols';
Comment On Column "FORM_TABS"."TAB_DISPLAY_NUMBER" Is '������� ����������';
Comment On Column "FORM_TAB_PARENT_EXCLNS"."EXCLN_ID" Is 'ID';
Comment On Column "ICONS"."ICON_FILE_NAME" Is '���� ������ �� ���� default_icon_path';
Comment On Column "LOOKUPS"."LOOKUP_CODE" Is '��������� ������������ (ID)';
Comment On Column "LOOKUPS"."LOOKUP_NAME" Is '���������������� ���';
Comment On Column "MENUS"."MENU_CODE" Is '��� ����';
Comment On Column "MENUS"."MENU_NAME" Is '���������������� ������������ ����';
Comment On Column "MENUS"."PARENT_MENU_CODE" Is '������ �� ����� ����-��������';
Comment On Column "MENUS"."MENU_FORM_CODE" Is '������ �� ����� (��� �������� �����)';
Comment On Column "MENUS"."MENU_POSITION" Is '������� ������� �� ����� ������. ���� �� ������� - �� ������� ������������, ����� �� ������������';
Comment On Column "MENUS"."SHOW_IN_NAVIGATOR" Is '���������� � ����������';

