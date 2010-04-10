With t As
     (
        Select     a.menu_code, a.menu_name, a.parent_menu_code, a.menu_form_code, a.menu_position, a.show_in_navigator
                  , '~' || Ltrim (SYS_CONNECT_BY_PATH (menu_code, '~'), '~') || '~' PATH
              From menus a
        Start With PARENT_MENU_CODE Is Null
        Connect By Prior a.menu_code = a.parent_menu_code)
    ,b As
     (
        Select a.menu_code, a.menu_name, a.parent_menu_code, a.menu_form_code, a.menu_position, a.show_in_navigator
              ,a.PATH
          From t a
         Where a.menu_form_code In
                  ('COLUMNS_LIST'
                  ,'FORM_ACTIONS'
                  ,'FORM_COLUMNS'
                  ,'FORM_TABS'
                  ,'FORM_TABS_LIST'
                  ,'FORMS'
                  ,'FORMS_LIST'
                  ,'FORMS2'
                  ,'ICONS'
                  ,'LOOKUP_VALUES'
                  ,'LOOKUPS'
                  ,'LOOKUPS_LIST'
                  ,'MENUS'
                  ))
Select m.menu_code, m.menu_name, m.parent_menu_code, m.menu_form_code, m.menu_position, m.show_in_navigator
  From menus m, b
 Where INSTR (b.PATH, '~' || m.menu_code || '~') > 0
/

