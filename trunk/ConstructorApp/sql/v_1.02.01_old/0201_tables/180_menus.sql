Create Table fc22.menus
    (menu_code                      Varchar2(255) Not Null,
    menu_name                      Varchar2(255),
    parent_menu_code               Varchar2(255),
    menu_form_code                 Varchar2(255),
    menu_position                  Number,
    show_in_navigator              Varchar2(1) Default 'N')
/

Alter Table fc22.menus
Add Constraint menus_pk Primary Key (menu_code)
Using Index
/

Comment On Column fc22.menus.menu_code Is '��� ����'
/
Comment On Column fc22.menus.menu_form_code Is '������ �� ����� (��� �������� �����)'
/
Comment On Column fc22.menus.menu_name Is '���������������� ������������ ����'
/
Comment On Column fc22.menus.menu_position Is '������� ������� �� ����� ������. ���� �� ������� - �� ������� ������������, ����� �� ������������'
/
Comment On Column fc22.menus.parent_menu_code Is '������ �� ����� ����-��������'
/
Comment On Column fc22.menus.show_in_navigator Is '���������� � ����������'
/
