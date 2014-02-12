CREATE OR REPLACE PACKAGE APPS_ROLE_MENUS_PKG As
   Type menu_r Is Record (
      lvl                 Number
     ,menu_code           Varchar2 (255)
     ,parent_menu_code    Varchar2 (255)
     ,menu_position       Number
     ,show_in_navigator   Varchar2 (1)
     ,menu_name           Varchar2 (255)
     ,form_code           Varchar2 (255)
     ,form_name           Varchar2 (255)
     ,icon_id             Number
     ,hot_key             Varchar2 (100)
     ,description         Clob
     ,child_count         Number
   );

   Type menus_t Is Table Of menu_r;

   Procedure p_ins_upd (
      p_app_menu_id        In Out   Number
     ,p_menu_code          In Out   Varchar2
     ,p_parent_menu_code   In Out   Varchar2
     ,p_position           In Out   Varchar2
     ,p_form_code          In Out   Varchar2
     ,p_enabled_flag       In Out   Varchar2
     ,p_display_name       In Out   Varchar2
   );

   Procedure p_delete (p_app_menu_id In Out Number);

   Function get_menu_list
      Return menus_t Pipelined;
End apps_role_menus_pkg;
/
CREATE OR REPLACE PACKAGE BODY APPS_ROLE_MENUS_PKG As
   Procedure p_ins_upd (
      p_app_menu_id        In Out   Number
     ,p_menu_code          In Out   Varchar2
     ,p_parent_menu_code   In Out   Varchar2
     ,p_position           In Out   Varchar2
     ,p_form_code          In Out   Varchar2
     ,p_enabled_flag       In Out   Varchar2
     ,p_display_name       In Out   Varchar2
   ) Is
   Begin
      Update apps_role_menus
         Set menu_code = p_menu_code
            ,parent_menu_code = p_parent_menu_code
            ,Position = p_position
            ,form_code = p_form_code
            ,enabled_flag = p_enabled_flag
            ,display_name = p_display_name
       Where app_menu_id = p_app_menu_id;

      If Sql%Rowcount = 0 Then
         Select main_sq.Nextval
           Into p_app_menu_id
           From DUAL;

         Insert Into apps_role_menus
                     (app_menu_id, menu_code, parent_menu_code, Position, form_code, enabled_flag, display_name)
              Values (p_app_menu_id, p_menu_code, p_parent_menu_code, p_position, p_form_code, p_enabled_flag
                     ,p_display_name);
      End If;
   End p_ins_upd;

   Procedure p_delete (p_app_menu_id In Out Number) Is
   Begin
      Delete From apps_role_menus
            Where app_menu_id = p_app_menu_id;
   End p_delete;

   Function get_menu_list
      Return menus_t Pipelined Is
      l_ebs_responsibility_id   Number := apps.fnd_global.RESP_ID; -- apps.xxfnd_apps_utils_pkg.g_responsibility_id;
      l_ebs_roles_cnt           Number;
   Begin
      Select Count (*)
        Into l_ebs_roles_cnt
        From fc22.apps_roles a
       Where a.external_role_id = l_ebs_responsibility_id;

      If                                                                            /* users_pkg.get_user_id = -1
                                                                                 And l_ebs_responsibility_id != 50659*/
         l_ebs_roles_cnt = 0 Then
         For cr In (Select Level lvl, m.menu_code, m.parent_menu_code, m.menu_position,
                           m.show_in_navigator,
                           nvl(nvl(m.menu_name, m.form_name), m.menu_code) As menu_name, m.form_code,
                           m.form_name, m.icon_id, m.hot_key,
                           (Select --проблема с CLOB
                              description
                               From forms f
                              Where f.form_code = m.form_code) description,
                           (Select Count(*) From menus a Where a.parent_menu_code = m.menu_code) child_count
                      From (Select -- NVL2 (a.Rowid, a.menu_code, f.form_code) As menu_code, a.menu_name As menu_name
                             -- ,NVL2 (a.Rowid, a.parent_menu_code, 'XXX') As parent_menu_code, a.menu_position
                              nvl(a.menu_code, f.form_code) As menu_code, a.menu_name As menu_name,
                              a.parent_menu_code, a.menu_position,
                              nvl(a.show_in_navigator, 'Y') As show_in_navigator, f.icon_id, f.hot_key,
                              f.form_code, nvl(f.form_name, f.form_code) As form_name, f.description
                               From menus a
                               Full Outer Join forms f
                                 On a.menu_form_code = f.form_code
                             Union All
                             Select 'XXX' As menu_code, 'Прочее' As menu_name,
                                    Null As parent_menu_code, Null As menu_position,
                                    'Y' As show_in_navigator, Null As icon_id, Null As hot_key,
                                    'XXXX' As form_code, 'XXXXX' As form_name, Null As description
                               From dual
                              Where 1 = 2
                             --
                             ) m
                    Connect By Prior m.menu_code = m.parent_menu_code
                     Start With m.parent_menu_code Is Null
                     Order By lvl, m.parent_menu_code, m.menu_position, menu_name
                    ) Loop
            Pipe Row (cr);
         End Loop;
      Else
         For cr In (With t As
                         (
                            Select m.menu_code, parent_menu_code, m.Position, m.enabled_flag
                                  ,NVL (NVL (m.display_name, f.form_name), m.menu_code) As display_name, f.form_code
                                  ,f.form_name, f.icon_id, f.hot_key, f.description
                              From apps_role_menus m Left Join forms f On f.form_code = m.form_code
                             Where 'Y' = m.enabled_flag)
                    Select     Level lvl, menu_code, DECODE (Level, 1, Null, y.parent_menu_code) As parent_menu_code
                              ,Position, enabled_flag, display_name, form_code, form_name, icon_id, hot_key
                              ,description, (Select Count (*)
                                               From t x
                                              Where y.menu_code = x.parent_menu_code) child_count
                          From t y
                    Start With y.parent_menu_code = (Select r.root_menu_code
                                                       From apps_roles r
                                                      Where r.external_role_id =                                --51079
                                                                                                l_ebs_responsibility_id)
                    Connect By Prior menu_code = parent_menu_code
                      Order Siblings By Position, display_name, menu_code
                      ) Loop
            Pipe Row (cr);
         End Loop;
      End If;

      Return;
   End get_menu_list;
End apps_role_menus_pkg;
/
