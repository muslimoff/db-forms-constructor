-- Start of DDL Script for Package FC.MENUS_PKG
-- Generated 10.04.2010 22:28:05 from FC@VM_XE

Create Or Replace 
PACKAGE menus_pkg As

  Procedure p_ins_chld(p_menu_code Varchar2, p_element_type varchar2);
  Procedure p_ins_sibl(p_menu_code Varchar2, p_element_type varchar2);
  procedure p_update(p_menu_code         menus.menu_code%type,
                     p_menu_name         menus.menu_name%type,
                     p_parent_display    menus.parent_menu_code%type,
                     p_menu_form_code    menus.menu_form_code%type,
                     p_menu_position     menus.menu_position%type,
                     p_element_type      varchar2,
                     p_show_in_navigator varchar2);

  Procedure p_delete_menu(p_menu_code Varchar2, p_element_type varchar2);
  Procedure p_delete_form(p_menu_code Varchar2, p_element_type varchar2);

  Type menu_tree_record Is Record(
    menu_code            menus.menu_code%type,
    menu_name            menus.menu_name%type,
    parent_menu_code     menus.parent_menu_code%type,
    parent_display       menus.parent_menu_code%type,
    menu_form_code       menus.menu_form_code%type,
    form_display         menus.menu_form_code%type,
    form_display_stat    menus.menu_form_code%type,
    menu_position        menus.menu_position%type,
    icon_id              icons.icon_id%type,
    is_folder            number,
    element_type         varchar2(100),
    form_code_for_filter menus.menu_form_code%type,
    show_in_navigator    menus.show_in_navigator%type);

  Type menu_tree_table Is Table Of menu_tree_record;

  Function p_get_menu_tree(p_menu_code    varchar2,
                           p_element_type varchar2,
                           p_form_display varchar2) Return menu_tree_table
    Pipelined;

End;
/


Create Or Replace 
PACKAGE BODY menus_pkg As
  Procedure p_ins_chld(p_menu_code Varchar2, p_element_type varchar2) As
    l_menu_name Varchar2(32000);
  Begin
    if p_element_type in ('FORM', 'FOLDER') then
      Select p_menu_code || '_' || menu_sq.Nextval
        Into l_menu_name
        From DUAL;
    
      form_utils.check_nulls(args_t(p_menu_code),
                             args_t('Не указан код меню'));
    
      Insert Into menus
        (parent_menu_code, menu_code, menu_name)
      Values
        (p_menu_code, l_menu_name, l_menu_name);
    else
      form_utils.err_message('Вы не можете системным элементам добавлять дочерние элементы');
    end if;
  
  End p_ins_chld;

  Procedure p_ins_sibl(p_menu_code Varchar2, p_element_type varchar2) As
    l_menu_name        Varchar2(32000);
    l_parent_menu_code Varchar2(32000);
  Begin
    if p_element_type in ('FORM', 'FOLDER') then
      Select parent_menu_code
        Into l_parent_menu_code
        From menus
       Where menu_code = p_menu_code;
    
      Select decode(l_parent_menu_code, null, '', l_parent_menu_code || '_') ||
             menu_sq.Nextval
        Into l_menu_name
        From DUAL;
    
      Insert Into menus
        (parent_menu_code, menu_code, menu_name)
      Values
        (l_parent_menu_code, l_menu_name, l_menu_name);
    else
      form_utils.err_message('Вы не можете системным элементам добавлять дочерние элементы');
    end if;
  End p_ins_sibl;

  Procedure p_update(p_menu_code         menus.menu_code%Type,
                     p_menu_name         menus.menu_name%Type,
                     p_parent_display    menus.parent_menu_code%Type,
                     p_menu_form_code    menus.menu_form_code%Type,
                     p_menu_position     menus.menu_Position%Type,
                     p_element_type      varchar2,
                     p_show_in_navigator varchar2) As
    l_menu_code       menus.menu_code%type := p_menu_code;
    l_cnt             number;
    l_is_folder       varchar2(100);
    l_menu_form_code  forms.form_code%type := p_menu_form_code;
    l_menu_form_code2 forms.form_code%type := p_menu_form_code;
  Begin
  
    if p_element_type in ('FORM', 'FOLDER') or p_element_type is null then
      form_utils.check_nulls(args_t(p_menu_name),
                             args_t('Не указано наименование'));
      if l_menu_code is null then
        Select menu_sq.Nextval Into l_menu_code From DUAL;
      end if;
    
      if p_menu_form_code is not null then
        select count(*)
          into l_cnt
          from forms f
         where f.form_code = p_menu_form_code;
        if l_cnt = 0 then
          forms2_pkg.p_insert(l_menu_form_code2,
                              l_menu_form_code,
                              l_is_folder);
        end if;
      end if;
      Update menus m
         Set menu_code         = l_menu_code,
             menu_name         = p_menu_name,
             parent_menu_code  = p_parent_display,
             menu_form_code    = l_menu_form_code,
             menu_Position     = p_menu_position,
             show_in_navigator = p_show_in_navigator
       Where m.menu_code = p_menu_code;
      If Sql%Rowcount = 0 then
        insert into menus m
          (menu_code,
           menu_name,
           parent_menu_code,
           menu_form_code,
           menu_Position,
           show_in_navigator)
        values
          (l_menu_code,
           p_menu_name,
           p_parent_display,
           l_menu_form_code,
           p_menu_position,
           p_show_in_navigator);
      end if;
    else
      form_utils.err_message('Вы не можете изменять системные элементы = ' ||
                             p_element_type);
    end if;
  
  End p_update;

  Procedure p_delete_menu(p_menu_code Varchar2, p_element_type varchar2) As
    l_cnt Number;
  Begin
    if p_element_type in ('FOLDER', 'FORM') then
      Select Count(*)
        Into l_cnt
        From menus
       Where parent_menu_code = p_menu_code
         And ROWNUM < 2;
    
      If l_cnt > 0 Then
        form_utils.err_message('Удалите все дочерние элементы');
      End If;
    
      Delete From menus m Where m.menu_code = p_menu_code;
    else
      form_utils.err_message('Вы не можете удалить системные элементы');
    end if;
  End p_delete_menu;

  Procedure p_delete_form(p_menu_code Varchar2, p_element_type varchar2) As
    l_menu_form_code forms.form_code%type;
  Begin
    if p_element_type in ('FORM') then
      select menu_form_code
        into l_menu_form_code
        from menus
       where menu_code = p_menu_code;
      FORMS2_PKG.p_delete(l_menu_form_code);
      update menus
         set menu_form_code = null
       where menu_form_code = l_menu_form_code;
    else
      form_utils.err_message('Вы не можете удалить системные элементы');
    end if;
  End p_delete_form;

  Function p_get_menu_tree(p_menu_code    varchar2,
                           p_element_type varchar2,
                           p_form_display varchar2) Return menu_tree_table
    Pipelined as
  begin
    if (p_element_type = 'FORM') then
    
      for rec in (Select 'TABS' menu_code,
                         'Вкладки' menu_name,
                         p_menu_code parent_menu_code,
                         p_menu_code parent_display,
                         'FORM_TABS' menu_form_code,
                         null form_display,
                         'FORM_TABS' form_display_stat,
                         1 menu_position,
                         12 icon_id,
                         0 is_folder,
                         'TABS' element_type,
                         p_form_display form_code_for_filter,
                         'Y' show_in_navigator
                    From DUAL
                  union all
                  select 'ACTIONS' menu_code,
                         'Действия' menu_name,
                         p_menu_code parent_menu_code,
                         p_menu_code parent_display,
                         'FORM_ACTIONS' menu_form_code,
                         null form_display,
                         'FORM_ACTIONS' form_display_stat,
                         2 menu_position,
                         13 icon_id,
                         0 is_folder,
                         'ACTIONS' element_type,
                         p_form_display form_code_for_filter,
                         'Y' show_in_navigator
                    From DUAL
                  union all
                  select 'COLUMNS' menu_code,
                         'Колонки' menu_name,
                         p_menu_code parent_menu_code,
                         p_menu_code parent_display,
                         'FORM_COLUMNS' menu_form_code,
                         null form_display,
                         'FORM_COLUMNS' form_display_stat,
                         3 menu_position,
                         11 icon_id,
                         0 is_folder,
                         'COLUMNS' element_type,
                         p_form_display form_code_for_filter,
                         'Y' show_in_navigator
                    From DUAL
                  union all
                  select 'DATA' menu_code,
                         'Настройки формы' menu_name,
                         p_menu_code parent_menu_code,
                         p_menu_code parent_display,
                         'FORMS' menu_form_code,
                         null form_display,
                         'FORMS' form_display_stat,
                         4 menu_position,
                         14 icon_id,
                         0 is_folder,
                         'DATA' element_type,
                         p_form_display form_code_for_filter,
                         'Y' show_in_navigator
                    From DUAL) loop
        pipe row(rec);
      end loop;
    end if;
    for rec in (select m.menu_code,
                       m.menu_name,
                       m.parent_menu_code,
                       m.parent_menu_code parent_display,
                       m.menu_form_code,
                       m.menu_form_code form_display,
                       null form_display_stat,
                       m.menu_position,
                       nvl(f.icon_id, null) icon_id,
                       decode(m.menu_form_code,
                              null,
                              decode((select count(*)
                                       from menus m2
                                      where m2.parent_menu_code = m.menu_code),
                                     0,
                                     0,
                                     1),
                              1) is_folder,
                       to_char(decode(m.menu_form_code,
                                      null,
                                      'FOLDER',
                                      'FORM')) element_type,
                       null form_code_for_filter,
                       m.show_in_navigator
                  from menus m
                  left join forms f
                    on f.form_code = m.menu_form_code
                 where NVL(m.parent_menu_code, '9999') =
                       NVL(p_menu_code, '9999')) loop
      pipe row(rec);
    
    end loop;
    return;
  end;
End;
/


-- End of DDL Script for Package FC.MENUS_PKG

