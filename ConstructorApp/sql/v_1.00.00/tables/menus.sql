-- Start of DDL Script for Table FC.MENUS
-- Generated 10.04.2010 20:54:09 from FC@VM_XE

Create Table menus
    (menu_code                      Varchar2(255) Not Null,
    menu_name                      Varchar2(255),
    parent_menu_code               Varchar2(255),
    menu_form_code                 Varchar2(255),
    menu_position                  Number,
    show_in_navigator              Varchar2(1) Default 'N')
/

-- Grants for Table
Grant Select On menus To app_rates
/
Grant Select On menus To mz_so_integration
/




-- Constraints for MENUS

Alter Table menus
Add Constraint menus_pk Primary Key (menu_code)
Using Index
/


-- Comments for MENUS

Comment On Column menus.menu_code Is '��� ����'
/
Comment On Column menus.menu_form_code Is '������ �� ����� (��� �������� �����)'
/
Comment On Column menus.menu_name Is '���������������� ������������ ����'
/
Comment On Column menus.menu_position Is '������� ������� �� ����� ������. ���� �� ������� - �� ������� ������������, ����� �� ������������'
/
Comment On Column menus.parent_menu_code Is '������ �� ����� ����-��������'
/
Comment On Column menus.show_in_navigator Is '���������� � ����������'
/

-- End of DDL Script for Table FC.MENUS

