Create Table menus
    (menu_code                      Varchar2(255) Not Null,
    menu_name                      Varchar2(255),
    parent_menu_code               Varchar2(255),
    menu_form_code                 Varchar2(255),
    menu_position                  Number,
    show_in_navigator              Varchar2(1) Default 'N')
/


-- Constraints for MENUS

Alter Table menus
Add Constraint menus_pk Primary Key (menu_code)
Using Index
/


-- Comments for MENUS

Comment On Column menus.menu_code Is 'Код меню'
/
Comment On Column menus.menu_form_code Is 'Ссылка на форму (для конечных узлов)'
/
Comment On Column menus.menu_name Is 'Пользовательское наименование меню'
/
Comment On Column menus.menu_position Is 'Позиция пунктов на одном уровне. Если не указано - то сначала нумерованные, потом по наименованию'
/
Comment On Column menus.parent_menu_code Is 'Ссылка на пункт меню-родитель'
/
Comment On Column menus.show_in_navigator Is 'Показывать в навигаторе'
/

-- End of DDL Script for Table FC22.MENUS

