Create Or Replace Package apps_role_menus_pkg As
  Type menu_r Is Record(
     lvl               Number
    ,menu_code         Varchar2(255)
    ,parent_menu_code  Varchar2(255)
    ,menu_position     Number
    ,show_in_navigator Varchar2(1)
    ,menu_name         Varchar2(255)
    ,form_code         Varchar2(255)
    ,form_name         Varchar2(255)
    ,icon_id           Number
    ,hot_key           Varchar2(100)
    ,description       Clob
    ,child_count       Number);

  Type menus_t Is Table Of menu_r;
  Type t_apps_role_menus Is Table Of apps_role_menus%Rowtype;

  --
  Procedure p_ins_chld(p_app_menu_id In Out Number
                      ,p_menu_code   In Out Varchar2);
  --
  Procedure p_ins_upd(p_app_menu_id      In Out Number
                     ,p_menu_code        In Out Varchar2
                     ,p_parent_menu_code In Out Varchar2
                     ,p_position         In Out Varchar2
                     ,p_form_code        In Out Varchar2
                     ,p_enabled_flag     In Out Varchar2
                     ,p_display_name     In Out Varchar2
                     ,p_root_menu_code   In Out Varchar2
                     ,p_entity_type      In Out Varchar2
                     ,p_master_form_code In Out Varchar2
                     ,p_parent_form_code In Out Varchar2);

  Procedure p_delete(p_app_menu_id In Out Number);

  Function get_menu_list Return menus_t
    Pipelined;
  Function get_apps_role_menus(p_root_menu_code   In Varchar2
                              ,p_menu_code        In Varchar2
                              ,p_parent_menu_code In Varchar2
                              ,p_form_code        In Varchar2
                              ,p_entity_type      In Varchar2
                              ,p_master_form_code In Varchar2
                              ,p_parent_form_code In Varchar2)
    Return t_apps_role_menus
    Pipelined;
  --
  Function get_action_enabled_flag(p_action_code      In Varchar2
                                  ,p_form_code        In Varchar2
                                  ,p_master_form_code In Varchar2 Default Null)
    Return Varchar2;
  --
End apps_role_menus_pkg;
/
Create Or Replace Package Body apps_role_menus_pkg As
  --
  Procedure p_ins_chld(p_app_menu_id In Out Number
                      ,p_menu_code   In Out Varchar2) As
    l_menu_code Varchar2(2000);
    l_cnt       Number;
  Begin
    Select Count(*)
      Into l_cnt
      From apps_role_menus p
     Where p.menu_code = p_menu_code
       And p.form_code Is Null
       And entity_type In ('MENU', 'FORM');
  
    If l_cnt > 0 Then
      Select main_sq.nextval Into p_app_menu_id From dual;
      l_menu_code := p_menu_code || '_' || to_char(p_app_menu_id);
    
      Insert Into apps_role_menus
        (app_menu_id, menu_code, parent_menu_code, position, form_code,
         enabled_flag, display_name, entity_type)
      Values
        (p_app_menu_id, l_menu_code, p_menu_code, Null, '', 'Y', '', 'MENU');
    Else
      form_utils.err_message('Вы не можете на данном элементе добавлить дочерние элементы');
    End If;
  End p_ins_chld;
  --
  Procedure p_ins_upd(p_app_menu_id      In Out Number
                     ,p_menu_code        In Out Varchar2
                     ,p_parent_menu_code In Out Varchar2
                     ,p_position         In Out Varchar2
                     ,p_form_code        In Out Varchar2
                     ,p_enabled_flag     In Out Varchar2
                     ,p_display_name     In Out Varchar2
                     ,p_root_menu_code   In Out Varchar2
                     ,p_entity_type      In Out Varchar2
                     ,p_master_form_code In Out Varchar2
                     ,p_parent_form_code In Out Varchar2) Is
  Begin
    If p_entity_type Is Null Then
      p_entity_type := 'MENU';
    End If;
    If p_entity_type = 'MENU' And p_form_code Is Not Null Then
      p_entity_type := 'FORM';
    Elsif p_entity_type = 'FORM' And p_form_code Is Null Then
      p_entity_type := 'MENU';
    End If;
    Update apps_role_menus
       Set menu_code = p_menu_code,
           parent_menu_code = nvl(p_parent_menu_code, p_root_menu_code),
           position = p_position, form_code = p_form_code,
           enabled_flag = p_enabled_flag, display_name = p_display_name,
           entity_type = p_entity_type, master_form_code = p_master_form_code,
           parent_form_code = p_parent_form_code
     Where app_menu_id = p_app_menu_id;
  
    If Sql%Rowcount = 0 Then
      Select main_sq.nextval Into p_app_menu_id From dual;
    
      Insert Into apps_role_menus
        (app_menu_id, menu_code, parent_menu_code, position, form_code,
         enabled_flag, display_name, entity_type, master_form_code,
         parent_form_code)
      Values
        (p_app_menu_id, p_menu_code, nvl(p_parent_menu_code, p_root_menu_code),
         p_position, p_form_code, p_enabled_flag, p_display_name, p_entity_type,
         p_master_form_code, p_parent_form_code);
    End If;
  End p_ins_upd;
  --
  Procedure p_delete(p_app_menu_id In Out Number) Is
  Begin
    Delete From apps_role_menus Where app_menu_id = p_app_menu_id;
  End p_delete;

  Function get_menu_list Return menus_t
    Pipelined Is
    l_ebs_responsibility_id Number := apps.fnd_global.resp_id; -- apps.xxfnd_apps_utils_pkg.g_responsibility_id;
    l_ebs_roles_cnt         Number;
  Begin
    Select Count(*)
      Into l_ebs_roles_cnt
      From fc22.apps_roles a
     Where a.external_role_id = l_ebs_responsibility_id;
  
    If /* users_pkg.get_user_id = -1
                                                                                                                                                         And l_ebs_responsibility_id != 50659*/
     l_ebs_roles_cnt = 0 Then
      For cr In (Select Level lvl, m.menu_code, m.parent_menu_code,
                        m.menu_position, m.show_in_navigator,
                        nvl(nvl(m.menu_name, m.form_name), m.menu_code) As menu_name,
                        m.form_code, m.form_name, m.icon_id, m.hot_key,
                        (Select --проблема с CLOB
                           description
                            From forms f
                           Where f.form_code = m.form_code) description,
                        (Select Count(*)
                            From menus a
                           Where a.parent_menu_code = m.menu_code) child_count
                   From (Select -- NVL2 (a.Rowid, a.menu_code, f.form_code) As menu_code, a.menu_name As menu_name
                          -- ,NVL2 (a.Rowid, a.parent_menu_code, 'XXX') As parent_menu_code, a.menu_position
                           nvl(a.menu_code, f.form_code) As menu_code,
                           a.menu_name As menu_name, a.parent_menu_code,
                           a.menu_position,
                           nvl(a.show_in_navigator, 'Y') As show_in_navigator,
                           f.icon_id, f.hot_key, f.form_code,
                           nvl(f.form_name, f.form_code) As form_name,
                           f.description
                            From menus a
                            Full Outer Join forms f
                              On a.menu_form_code = f.form_code
                          Union All
                          Select 'XXX' As menu_code, 'Прочее' As menu_name,
                                 Null As parent_menu_code, Null As menu_position,
                                 'Y' As show_in_navigator, Null As icon_id,
                                 Null As hot_key, 'XXXX' As form_code,
                                 'XXXXX' As form_name, Null As description
                            From dual
                           Where 1 = 2
                          --
                          ) m
                 Connect By Prior m.menu_code = m.parent_menu_code
                  Start With m.parent_menu_code Is Null
                  Order By lvl, m.parent_menu_code, m.menu_position, menu_name) Loop
        Pipe Row(cr);
      End Loop;
    Else
      For cr In (With t As
                    (Select m.menu_code, parent_menu_code, m.position,
                           m.enabled_flag,
                           nvl(nvl(m.display_name, f.form_name), m.menu_code) As display_name,
                           f.form_code, f.form_name, f.icon_id, f.hot_key,
                           f.description
                      From apps_role_menus m
                      Left Join forms f
                        On f.form_code = m.form_code
                     Where 'Y' = m.enabled_flag
                       And m.entity_type In ('MENU', 'FORM'))
                   Select Level lvl, menu_code,
                          decode(Level, 1, Null, y.parent_menu_code) As parent_menu_code,
                          position, enabled_flag, display_name, form_code,
                          form_name, icon_id, hot_key, description,
                          (Select Count(*)
                              From t x
                             Where y.menu_code = x.parent_menu_code) child_count
                     From t y
                    Start With y.parent_menu_code =
                               (Select r.root_menu_code
                                  From apps_roles r
                                 Where r.external_role_id =
                                       l_ebs_responsibility_id)
                   Connect By Prior menu_code = parent_menu_code
                    Order Siblings By position, display_name, menu_code) Loop
        Pipe Row(cr);
      End Loop;
    End If;
  
    Return;
  End get_menu_list;
  --
  Function get_apps_role_menus(p_root_menu_code   In Varchar2
                              ,p_menu_code        In Varchar2
                              ,p_parent_menu_code In Varchar2
                              ,p_form_code        In Varchar2
                              ,p_entity_type      In Varchar2
                              ,p_master_form_code In Varchar2
                              ,p_parent_form_code In Varchar2)
    Return t_apps_role_menus
    Pipelined Is
    l_rec apps_role_menus%Rowtype;
    l_rn  Number;
  Begin
    l_rn := round(-1000000000 * dbms_random.value);
    For cr In (Select nvl(r.app_menu_id, d.app_menu_id) app_menu_id, d.menu_code,
                      d.parent_menu_code, d.position,
                      nvl(r.form_code, d.form_code) form_code,
                      nvl(r.enabled_flag, d.enabled_flag) enabled_flag,
                      nvl(r.display_name, d.display_name) display_name,
                      d.entity_type, d.master_form_code, d.parent_form_code
                 From (Select app_menu_id, menu_code, parent_menu_code, position,
                               form_code, enabled_flag, display_name, entity_type,
                               master_form_code, parent_form_code
                          From apps_role_menus r
                         Where ((p_menu_code Is Null And
                               r.menu_code = p_root_menu_code) Or
                               (p_menu_code Is Not Null And
                               r.parent_menu_code = p_menu_code))
                           And entity_type In ('MENU', 'FORM')
                        Union All
                        Select l_rn app_menu_id,
                               decode(Level, 1, 'COLUMNS', 2, 'TABS', 3, 'ACTIONS',
                                       'DATA') menu_code,
                               p_parent_menu_code parent_menu_code, Null position,
                               p_form_code form_code, 'Y' enabled_flag,
                               decode(Level, 1, 'Колонки', 2, 'Вкладки', 3,
                                       'Действия', 'Настройки формы') display_name,
                               decode(Level, 1, 'COLUMNS', 2, 'TABS', 3, 'ACTIONS',
                                       'DATA') entity_type,
                               p_master_form_code master_form_code,
                               p_form_code parent_form_code
                          From dual
                         Where p_form_code Is Not Null
                           And p_entity_type In ('FORM', 'CHLD_FORM')
                        Connect By Level <= 3
                        Union All
                        Select l_rn app_menu_id, c.column_code menu_code,
                               p_parent_menu_code parent_menu_code, Null position,
                               c.form_code form_code, c.show_on_grid enabled_flag,
                               c.column_user_name display_name,
                               'COLUMN' entity_type,
                               p_master_form_code master_form_code,
                               p_parent_form_code parent_form_code
                          From form_columns c
                         Where c.form_code = p_form_code
                           And p_menu_code = 'COLUMNS'
                        Union All
                        Select l_rn app_menu_id, t.tab_code menu_code,
                               p_parent_menu_code parent_menu_code, Null position,
                               t.child_form_code form_code, 'Y' enabled_flag,
                               t.tab_name display_name,
                               decode(t.tab_type, 1, 'EDIT_FRM', 'TAB') entity_type,
                               p_master_form_code master_form_code,
                               p_parent_form_code parent_form_code
                          From form_tabs t
                         Where t.form_code = p_form_code
                           And p_menu_code = 'TABS'
                        Union All
                        Select l_rn app_menu_id, f.form_code menu_code,
                               p_parent_menu_code parent_menu_code, Null position,
                               f.form_code form_code, 'Y' enabled_flag,
                               f.form_name display_name, 'CHLD_FORM' entity_type,
                               p_parent_form_code master_form_code,
                               p_parent_form_code parent_form_code
                          From forms f
                         Where '/' || p_form_code || '/' Like
                               '%/' || f.form_code || '/%'
                           And p_entity_type = 'TAB'
                        Union All
                        Select l_rn app_menu_id, c.column_code menu_code,
                               p_parent_menu_code parent_menu_code, Null position,
                               c.form_code form_code, 'Y' enabled_flag,
                               c.column_user_name display_name,
                               'EDIT_COL' entity_type,
                               p_master_form_code master_form_code,
                               p_parent_form_code parent_form_code
                          From form_columns c
                         Where c.form_code = p_parent_form_code
                           And c.editor_tab_code = p_menu_code
                           And p_entity_type = 'EDIT_FRM'
                        Union All
                        Select l_rn app_menu_id, a.action_code menu_code,
                               p_parent_menu_code parent_menu_code, Null position,
                               a.form_code form_code,
                               Case
                                 When a.display_in_context_menu = 'Y' Then
                                  'Y'
                                 When a.display_on_toolbar = 'Y' Then
                                  'Y'
                                 Else
                                  'N'
                               End enabled_flag, a.action_display_name display_name,
                               'ACTION' entity_type,
                               p_master_form_code master_form_code,
                               p_parent_form_code parent_form_code
                          From form_actions a
                         Where a.form_code = p_form_code
                           And p_entity_type = 'ACTIONS') d
                 Left Join apps_role_menus r
                   On 1 = 1
                  And d.menu_code = r.menu_code
                  And d.parent_menu_code = r.parent_menu_code
                  And d.entity_type = r.entity_type
                  And nvl(d.form_code, '#') = nvl(r.form_code, '#')
                  And nvl(d.master_form_code, '#') =
                      nvl(r.master_form_code, '#')
                  And nvl(d.parent_form_code, '#') =
                      nvl(r.parent_form_code, '#')
               --
               ) Loop
      l_rec := cr;
      Pipe Row(l_rec);
    End Loop;
    Return;
  End;
  --
  Function get_action_enabled_flag(p_action_code      In Varchar2
                                  ,p_form_code        In Varchar2
                                  ,p_master_form_code In Varchar2 Default Null)
    Return Varchar2 Is
    Result Varchar2(240);
  Begin
    Select t.enabled_flag
      Into Result
      From apps_role_menus t
     Where t.entity_type In ('ACTION')
       And (p_master_form_code Is Null Or
           t.master_form_code = p_master_form_code)
       And t.form_code = p_form_code
       And t.menu_code = p_action_code
     Start With t.parent_menu_code =
                (Select r.root_menu_code
                   From apps_roles r
                  Where r.external_role_id = apps.fnd_global.resp_id)
    Connect By Prior t.menu_code = t.parent_menu_code;
    Return Result;
  Exception
    When Others Then
      Return 'Y';
  End;
  --
End apps_role_menus_pkg;
/
