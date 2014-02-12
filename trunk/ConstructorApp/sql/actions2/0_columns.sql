Alter Table form_actions Add autocommit Varchar2(1) DEFAULT 'Y';
Alter Table form_actions Add status_button_param            Varchar2(255);
Alter Table form_actions Add status_msg_level_param         Varchar2(255);
Alter Table form_actions Add status_msg_txt_param           Varchar2(4000);
Comment On Column form_actions.autocommit Is '����������';
Comment On Column form_actions.child_form_code Is '����� �������� ����� � ����� ����/����';
Comment On Column form_actions.display_in_context_menu Is '���������� � ����������� ����?';
Comment On Column form_actions.parent_action_code Is '��������-��������. ��� ���������� ������������������ ��������';
Comment On Column form_actions.status_button_param Is '��� ��������� PL/SQL ��������� ��� �������� ������ ������ ��� (������� WARN)';
Comment On Column form_actions.status_msg_level_param Is '��� ��������� PL/SQL ��������� ��� �������� ������� ���������� (�����-OK, 1-WARN, 2-ERR, 3-CANCEL)';
Comment On Column form_actions.status_msg_txt_param Is '��� ��������� PL/SQL ��������� ��� �������� ������ ��������� � ������';

Alter Table form_actions Drop Column status_parameter_name;

