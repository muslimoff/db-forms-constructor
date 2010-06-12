--tables
Alter Table forms Add double_click_action_code       Varchar2(255);
Alter Table forms Add  lookup_width                   Number;
/
--constraints
Alter Table form_actions
Add Constraint form_actions_pk Primary Key (form_code, action_code)
Using Index;
Alter Table forms
Add Constraint forms_form_actions_fk Foreign Key (form_code,
  double_click_action_code)
References form_actions (form_code,action_code)
/
--comments
Comment On Column form_actions.child_form_code Is '����� �������� ����� � ����� ����/����';
Comment On Column forms.double_click_action_code Is '�������� �� �������� ������ �� ������. �� ��������� - ��������������';
Comment On Column forms.lookup_width Is '������ ������ (���� ����� ��������� � ���� ������)'
/
--data
Insert Into lookup_attributes
            (lookup_code, attribute_code, attribute_name, attribute_type)
     Values ('FORM_ACTIONS.ACTION_TYPE', 'AS_DUBLE_CLICK_ALLOWED', '����� �������������� ��� �������� ������', 'B')
/
Insert Into lookup_attribute_values
            (lookup_code, lookup_value_code, attribute_code, attribute_value_number, attribute_value_char
            ,attribute_value_date)
     Values ('FORM_ACTIONS.ACTION_TYPE', '10', 'AS_DUBLE_CLICK_ALLOWED', Null, 'Y', Null);
Insert Into lookup_attribute_values
            (lookup_code, lookup_value_code, attribute_code, attribute_value_number, attribute_value_char
            ,attribute_value_date)
     Values ('FORM_ACTIONS.ACTION_TYPE', '11', 'AS_DUBLE_CLICK_ALLOWED', Null, 'Y', Null);
Insert Into lookup_attribute_values
            (lookup_code, lookup_value_code, attribute_code, attribute_value_number, attribute_value_char
            ,attribute_value_date)
     Values ('FORM_ACTIONS.ACTION_TYPE', '8', 'AS_DUBLE_CLICK_ALLOWED', Null, 'Y', Null)
/

