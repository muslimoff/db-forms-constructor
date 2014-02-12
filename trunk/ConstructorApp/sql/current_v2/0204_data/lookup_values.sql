/*Select   a.lookup_code, a.lookup_value_code, a.lookup_display_value
    From lookup_values a
   Where a.lookup_code In (Select a.lookup_code
                             From lookups a
                            Where a.apps_code = 'FC')
Order By a.lookup_code, a.lookup_value_code
*/

Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORMS.EDITOR_POSITION', 'B', '�����')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORMS.EDITOR_POSITION', 'R', '������')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORMS.FORM_TYPE', 'G', '����')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORMS.FORM_TYPE', 'T', '������')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORMS.TABS_ORIENTATION', 'B', '�����')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORMS.TABS_ORIENTATION', 'H', '������')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORMS.TABS_ORIENTATION', 'L', '�����')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORMS.TABS_ORIENTATION', 'R', '������')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORMS.TABS_ORIENTATION', 'T', '������')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_ACTIONS.ACTION_TYPE', '1', '�������')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_ACTIONS.ACTION_TYPE', '10', '������� �������� ����� � ����� ����')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_ACTIONS.ACTION_TYPE', '11', '������� �������� ����� � ����� ����')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_ACTIONS.ACTION_TYPE', '12', '������� �������')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_ACTIONS.ACTION_TYPE', '13', '**������� ������')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_ACTIONS.ACTION_TYPE', '14', '**������')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_ACTIONS.ACTION_TYPE', '15', '������� URL � ����')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_ACTIONS.ACTION_TYPE', '16', '�������� ������ �� ������� (���������)')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_ACTIONS.ACTION_TYPE', '17', '������� ������� �����')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_ACTIONS.ACTION_TYPE', '18', '�������� ����� ������')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_ACTIONS.ACTION_TYPE', '2', '���������� (Update)')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_ACTIONS.ACTION_TYPE', '3', '��������')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_ACTIONS.ACTION_TYPE', '4', 'Refresh')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_ACTIONS.ACTION_TYPE', '5', '������� �� ���������� ������')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_ACTIONS.ACTION_TYPE', '6', '������� �� ��������� ������')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_ACTIONS.ACTION_TYPE', '7', 'PL/SQL ��������� �� ������������ ������')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_ACTIONS.ACTION_TYPE', '8', '������������� ������')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_ACTIONS.ACTION_TYPE', '9', '������')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_ACTIONS.ACTION_TYPE', '99', 'TestAction')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.ACTION_TYPE', '1', '�� ������� �������')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.ACTION_TYPE', '2', '��� ����� � ����')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.ACTION_TYPE', '3', '��� ������ �� ����')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.ACTION_TYPE', '4', '����� ������ �� ������')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.DATA_TYPE', 'B', 'Boolean')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.DATA_TYPE', 'D', 'Date')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.DATA_TYPE', 'N', 'Number')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.DATA_TYPE', 'S', 'String')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.DISPLAY_TYPE', 'B', '� � ������� � � ����� ��������������')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.DISPLAY_TYPE', 'E', '������ ����� ��������������')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.DISPLAY_TYPE', 'G', '������ � �������')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.FIELD_TYPE', '1', '������������ ����������� ����� ��������� (� �����������)')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.FIELD_TYPE', '10', 'Lookup ������� (���������� �� ��������)')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.FIELD_TYPE', '11', 'Link')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.FIELD_TYPE', '12', '[������ ����������. OUT. ����� ���������]')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.FIELD_TYPE', '13', '[������ ����������. IN. ����� ������ (������� ������)]')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.FIELD_TYPE', '14', '[������ ����������. OUT. ������� ���������]')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.FIELD_TYPE', '15', '�������� ���� (���� ������ PL/SQL)')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.FIELD_TYPE', '16', 'Lookup-�����')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.FIELD_TYPE', '2', '������������ ����������� ����� ������������� (��� �����������)')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.FIELD_TYPE', '3', '������')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.FIELD_TYPE', '4', '��������� ��������')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.FIELD_TYPE', '5', 'HTML editor')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.FIELD_TYPE', '6', '��������� ����� (���������������)')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.FIELD_TYPE', '7', 'iFrame')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.FIELD_TYPE', '8', 'Lookup ������� (���������� �� ����)')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.FIELD_TYPE', '9', '!!!��������!!! Lookup-�����')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.FIELD_TYPE', '99', 'PickTreeList')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.LOOKUP_FIELD_TYPE', '1', '������������� (���������� � �� ��� ����������)')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.LOOKUP_FIELD_TYPE', '2', '�������� - ������������ ������������')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.LOOKUP_FIELD_TYPE', '3', '�������������� ������������ ����')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.TREE_FIELD_TYPE', '1', '������������� ������')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.TREE_FIELD_TYPE', '2', '������������� ��������')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.TREE_FIELD_TYPE', '3', '�������, �������� �� ���������� ��� �������� ���������')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.TREE_FIELD_TYPE', '4', '������')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.TREE_FIELD_TYPE', '5', '���������� �������� ��������� � �������� ����')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.TREE_FIELD_TYPE', '6', '���� canAcceptDrop (��������� �� ��������� ���� ��� ��������������)')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.TREE_FIELD_TYPE', '7', '���� canDrag (��������� �� ���������������)')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMN_LOOKUP_MAP.MAPPING_TYPE', 'COLUMN', '�������')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMN_LOOKUP_MAP.MAPPING_TYPE', 'CONSTANT', '���������')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_TABS.TAB_TYPE', '1', '�������� ����')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_TABS.TAB_TYPE', '2', '����������� ����������� �����')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_TABS.TAB_TYPE', '3', '������������ ����������� �����')
/

