Insert Into lookups
            ("LOOKUP_CODE", "LOOKUP_NAME")
     Values ('FORM_COLUMNS.ACTION_TYPE', '���� �������� ��� �����')
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
     Values ('FORM_ACTIONS.ACTION_TYPE', '16', '�������� ������ �� ������� (���������)')
/
Insert Into lookup_attribute_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "ATTRIBUTE_CODE", "ATTRIBUTE_VALUE_NUMBER", "ATTRIBUTE_VALUE_CHAR"
            ,"ATTRIBUTE_VALUE_DATE")
     Values ('FORM_ACTIONS.ACTION_TYPE', '16', 'AS_DUBLE_CLICK_ALLOWED', Null, 'Y', Null)
/

