Create Table form_tab_childs_allowed
    (form_tab_childs_allowed_id     Number,
    form_code                      Varchar2(4000),
    tab_code                       Varchar2(4000),
    child_form_code                Varchar2(4000))
/


-- Comments for FORM_TAB_CHILDS_ALLOWED

Comment On Table form_tab_childs_allowed Is '������ ������������ ����, ������� ����� ���������� �� ������ ����. �������� ���� - ���������� ������ ������������ (������� ����� �������� ����). ������������� ����� ��������: �������� � �������� FORM_TABS ���� "��������� ����� �������������������� ����" � ���� ����� "���" - �������� ��������� �� ������: "������ ����� �� ���������������� � �������� FORM_TAB_CHILDS_ALLOWED"'
/

-- End of DDL Script for Table FC22.FORM_TAB_CHILDS_ALLOWED

