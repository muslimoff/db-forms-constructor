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

Comment On Column fc22.menus.menu_code Is 'Код меню'
/
Comment On Column fc22.menus.menu_form_code Is 'Ссылка на форму (для конечных узлов)'
/
Comment On Column fc22.menus.menu_name Is 'Пользовательское наименование меню'
/
Comment On Column fc22.menus.menu_position Is 'Позиция пунктов на одном уровне. Если не указано - то сначала нумерованные, потом по наименованию'
/
Comment On Column fc22.menus.parent_menu_code Is 'Ссылка на пункт меню-родитель'
/
Comment On Column fc22.menus.show_in_navigator Is 'Показывать в навигаторе'
/
