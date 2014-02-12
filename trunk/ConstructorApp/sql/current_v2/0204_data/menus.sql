/*Select     a.menu_code, a.menu_name, a.parent_menu_code, a.menu_form_code, a.menu_position, a.show_in_navigator
      From menus a
Start With 
a.menu_name = '���������' --a.parent_menu_code Is Null
Connect By Prior a.menu_code = a.parent_menu_code
  Order Siblings By a.menu_position*/

Truncate Table menus
/
Insert Into menus
            ("MENU_CODE", "MENU_NAME", "PARENT_MENU_CODE", "MENU_FORM_CODE", "MENU_POSITION", "SHOW_IN_NAVIGATOR")
     Values ('114', '���������', Null, Null, 1, 'N')
/
Insert Into menus
            ("MENU_CODE", "MENU_NAME", "PARENT_MENU_CODE", "MENU_FORM_CODE", "MENU_POSITION", "SHOW_IN_NAVIGATOR")
     Values ('114_119', '���������', '114', Null, 1, 'N')
/
Insert Into menus
            ("MENU_CODE", "MENU_NAME", "PARENT_MENU_CODE", "MENU_FORM_CODE", "MENU_POSITION", "SHOW_IN_NAVIGATOR")
     Values ('114_119_1026', '������������ ����� �������', '114_119', 'FORM_TAB_CHILDS_ALLOWED', Null, 'N')
/
Insert Into menus
            ("MENU_CODE", "MENU_NAME", "PARENT_MENU_CODE", "MENU_FORM_CODE", "MENU_POSITION", "SHOW_IN_NAVIGATOR")
     Values ('114_119_123', '�������� �������', '114_119', 'LOOKUP_VALUES', Null, Null)
/
Insert Into menus
            ("MENU_CODE", "MENU_NAME", "PARENT_MENU_CODE", "MENU_FORM_CODE", "MENU_POSITION", "SHOW_IN_NAVIGATOR")
     Values ('114_119_122', '�������', '114_119', 'FORM_TABS', Null, Null)
/
Insert Into menus
            ("MENU_CODE", "MENU_NAME", "PARENT_MENU_CODE", "MENU_FORM_CODE", "MENU_POSITION", "SHOW_IN_NAVIGATOR")
     Values ('114_119_125', '�������� �����', '114_119', 'FORMS', Null, Null)
/
Insert Into menus
            ("MENU_CODE", "MENU_NAME", "PARENT_MENU_CODE", "MENU_FORM_CODE", "MENU_POSITION", "SHOW_IN_NAVIGATOR")
     Values ('114_119_121', '��������', '114_119', 'FORM_ACTIONS', Null, Null)
/
Insert Into menus
            ("MENU_CODE", "MENU_NAME", "PARENT_MENU_CODE", "MENU_FORM_CODE", "MENU_POSITION", "SHOW_IN_NAVIGATOR")
     Values ('114_119_124', '�������', '114_119', 'FORM_COLUMNS', Null, Null)
/
Insert Into menus
            ("MENU_CODE", "MENU_NAME", "PARENT_MENU_CODE", "MENU_FORM_CODE", "MENU_POSITION", "SHOW_IN_NAVIGATOR")
     Values ('114_119_1089', 'FORM_COLUMN_LOOKUP_MAP', '114_119', 'FORM_COLUMN_LOOKUP_MAP', Null, 'N')
/
Insert Into menus
            ("MENU_CODE", "MENU_NAME", "PARENT_MENU_CODE", "MENU_FORM_CODE", "MENU_POSITION", "SHOW_IN_NAVIGATOR")
     Values ('114_119_640', '�������� ���������', '114_119', 'LOOKUP_ATTRIBUTE_VALUES', Null, 'N')
/
Insert Into menus
            ("MENU_CODE", "MENU_NAME", "PARENT_MENU_CODE", "MENU_FORM_CODE", "MENU_POSITION", "SHOW_IN_NAVIGATOR")
     Values ('114_119_641', '��������', '114_119', 'LOOKUP_ATTRIBUTES', Null, 'N')
/
Insert Into menus
            ("MENU_CODE", "MENU_NAME", "PARENT_MENU_CODE", "MENU_FORM_CODE", "MENU_POSITION", "SHOW_IN_NAVIGATOR")
     Values ('114_119_840', '�������������� �������� �������', '114_119', 'FORM_COLUMN_ATTR_VALS', Null, 'N')
/
Insert Into menus
            ("MENU_CODE", "MENU_NAME", "PARENT_MENU_CODE", "MENU_FORM_CODE", "MENU_POSITION", "SHOW_IN_NAVIGATOR")
     Values ('114_119_700', 'REPORTS', '114_119', 'REPORTS', Null, 'N')
/
Insert Into menus
            ("MENU_CODE", "MENU_NAME", "PARENT_MENU_CODE", "MENU_FORM_CODE", "MENU_POSITION", "SHOW_IN_NAVIGATOR")
     Values ('114_119_860', '���������� �������', '114_119', 'FORM_TAB_PARENT_EXCLNS', Null, 'N')
/
Insert Into menus
            ("MENU_CODE", "MENU_NAME", "PARENT_MENU_CODE", "MENU_FORM_CODE", "MENU_POSITION", "SHOW_IN_NAVIGATOR")
     Values ('114_119_932', 'FORM_COLUMN_ACTIONS', '114_119', 'FORM_COLUMN_ACTIONS', Null, 'N')
/
Insert Into menus
            ("MENU_CODE", "MENU_NAME", "PARENT_MENU_CODE", "MENU_FORM_CODE", "MENU_POSITION", "SHOW_IN_NAVIGATOR")
     Values ('983_1048', 'FC_DBMS_OUTPUT_VIEWER', '114_119', 'FC_DBMS_OUTPUT_VIEWER', Null, 'N')
/
Insert Into menus
            ("MENU_CODE", "MENU_NAME", "PARENT_MENU_CODE", "MENU_FORM_CODE", "MENU_POSITION", "SHOW_IN_NAVIGATOR")
     Values ('114_115', '�����������', '114', 'MENUS', 2, 'N')
/
Insert Into menus
            ("MENU_CODE", "MENU_NAME", "PARENT_MENU_CODE", "MENU_FORM_CODE", "MENU_POSITION", "SHOW_IN_NAVIGATOR")
     Values ('MC001_22_30', '������', '114', 'LOOKUPS', 2, 'Y')
/
Insert Into menus
            ("MENU_CODE", "MENU_NAME", "PARENT_MENU_CODE", "MENU_FORM_CODE", "MENU_POSITION", "SHOW_IN_NAVIGATOR")
     Values ('MC001_22_320', '������', '114', Null, Null, 'N')
/
Insert Into menus
            ("MENU_CODE", "MENU_NAME", "PARENT_MENU_CODE", "MENU_FORM_CODE", "MENU_POSITION", "SHOW_IN_NAVIGATOR")
     Values ('MC001_22_320_341', '������ �����', 'MC001_22_320', 'FORMS_LIST', Null, 'N')
/
Insert Into menus
            ("MENU_CODE", "MENU_NAME", "PARENT_MENU_CODE", "MENU_FORM_CODE", "MENU_POSITION", "SHOW_IN_NAVIGATOR")
     Values ('MC001_22_340', '������', 'MC001_22_320', 'ICONS', Null, 'N')
/
Insert Into menus
            ("MENU_CODE", "MENU_NAME", "PARENT_MENU_CODE", "MENU_FORM_CODE", "MENU_POSITION", "SHOW_IN_NAVIGATOR")
     Values ('MC001_22_320_344', '������ ������', 'MC001_22_320', 'LOOKUPS_LIST', Null, 'N')
/
Insert Into menus
            ("MENU_CODE", "MENU_NAME", "PARENT_MENU_CODE", "MENU_FORM_CODE", "MENU_POSITION", "SHOW_IN_NAVIGATOR")
     Values ('MC001_22_320_345', '������ �������', 'MC001_22_320', 'FORM_TABS_LIST', Null, 'N')
/
Insert Into menus
            ("MENU_CODE", "MENU_NAME", "PARENT_MENU_CODE", "MENU_FORM_CODE", "MENU_POSITION", "SHOW_IN_NAVIGATOR")
     Values ('MC001_22_320_342', '������ �������', 'MC001_22_320', 'COLUMNS_LIST', Null, 'N')
/
Insert Into menus
            ("MENU_CODE", "MENU_NAME", "PARENT_MENU_CODE", "MENU_FORM_CODE", "MENU_POSITION", "SHOW_IN_NAVIGATOR")
     Values ('MC001_22_320_642', '������ �������� (��.������)', 'MC001_22_320', 'DBLCLICK_FORM_ACT_LIST', Null, 'N')
/
Insert Into menus
            ("MENU_CODE", "MENU_NAME", "PARENT_MENU_CODE", "MENU_FORM_CODE", "MENU_POSITION", "SHOW_IN_NAVIGATOR")
     Values ('MC001_22_320_880', 'LOOKUP_VALUES_LIST', 'MC001_22_320', 'LOOKUP_VALUES_LIST', Null, 'N')
/
Insert Into menus
            ("MENU_CODE", "MENU_NAME", "PARENT_MENU_CODE", "MENU_FORM_CODE", "MENU_POSITION", "SHOW_IN_NAVIGATOR")
     Values ('114_343', '����������� ����', '114', 'FORMS2', Null, 'N')
/
Insert Into menus
            ("MENU_CODE", "MENU_NAME", "PARENT_MENU_CODE", "MENU_FORM_CODE", "MENU_POSITION", "SHOW_IN_NAVIGATOR")
     Values ('114_620', '������', '114', Null, Null, 'N')
/
Insert Into menus
            ("MENU_CODE", "MENU_NAME", "PARENT_MENU_CODE", "MENU_FORM_CODE", "MENU_POSITION", "SHOW_IN_NAVIGATOR")
     Values ('114_620_720', '���������', '114_620', Null, Null, 'N')
/
Insert Into menus
            ("MENU_CODE", "MENU_NAME", "PARENT_MENU_CODE", "MENU_FORM_CODE", "MENU_POSITION", "SHOW_IN_NAVIGATOR")
     Values ('114_501', '������������ ����', '114_620_720', 'APPS_ROLE_USERS', Null, 'N')
/
Insert Into menus
            ("MENU_CODE", "MENU_NAME", "PARENT_MENU_CODE", "MENU_FORM_CODE", "MENU_POSITION", "SHOW_IN_NAVIGATOR")
     Values ('114_503', '���� ��� ����', '114_620_720', 'APPS_ROLE_MENUS', Null, 'N')
/
Insert Into menus
            ("MENU_CODE", "MENU_NAME", "PARENT_MENU_CODE", "MENU_FORM_CODE", "MENU_POSITION", "SHOW_IN_NAVIGATOR")
     Values ('114_480', 'Users', '114_620', 'USERS', Null, 'N')
/
Insert Into menus
            ("MENU_CODE", "MENU_NAME", "PARENT_MENU_CODE", "MENU_FORM_CODE", "MENU_POSITION", "SHOW_IN_NAVIGATOR")
     Values ('114_500', '���� ����������', '114_620', 'APPS_ROLES', Null, 'N')
/

