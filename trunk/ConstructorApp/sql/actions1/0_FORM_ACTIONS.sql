Alter Table form_actions Add url_text                       Varchar2(4000);
Alter Table form_actions Add parent_action_code             Varchar2(255);
Alter Table form_actions Add status_parameter_name          Varchar2(255);
Alter Table form_actions Add display_in_context_menu        Varchar2(1) DEFAULT 'Y';
Comment On Column form_actions.url_text Is 'URL ����� ���������� ��������';
Comment On Column form_actions.parent_action_code Is '��������-��������. ��� ���������� ������������������ ��������';
Comment On Column form_actions.status_parameter_name Is '��� ��������� PL/SQL ��������� ��� �������� ������ ������ �� ����� � ��������� �� ������';
Comment On Column form_actions.display_in_context_menu Is '���������� � ����������� ����?';

