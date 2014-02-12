-- Start of DDL Script for Package FC22.APPS_ROLE_MENUS_PKG
-- Generated 17.11.2013 3:21:00 from FC22@KZM_HRDEV

Create Or Replace Package apps_role_menus_pkg As
   g_resp_id   Number;

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

   Type t_apps_role_menus Is Table Of apps_role_menus%Rowtype;

   --
   Procedure p_ins_chld (p_app_menu_id In Out Number, p_menu_code In Out Varchar2);

   --
   Procedure p_ins_upd (
      p_app_menu_id          In Out   Number
     ,p_menu_code            In Out   Varchar2
     ,p_parent_menu_code     In Out   Varchar2
     ,p_position             In Out   Varchar2
     ,p_form_code            In Out   Varchar2
     ,p_enabled_flag         In Out   Varchar2
     ,p_display_name         In Out   Varchar2
     ,p_root_menu_code       In Out   Varchar2
     ,p_entity_type          In Out   Varchar2
     ,p_master_form_code     In Out   Varchar2
     ,p_parent_form_code     In Out   Varchar2
     ,p_entity_path          In Out   Varchar2
     ,p_parent_entity_path   In Out   Varchar2
     ,p_object_code          In Out   Varchar2
     ,p_is_frozen_flag       In Out   Varchar2
   );

   Procedure p_delete (p_app_menu_id In Out Number);

   Function get_menu_list
      Return menus_t Pipelined;

   Function get_apps_role_menus (
      p_root_menu_code     In   Varchar2
     ,p_menu_code          In   Varchar2
     ,p_parent_menu_code   In   Varchar2
     ,p_form_code          In   Varchar2
     ,p_entity_type        In   Varchar2
     ,p_master_form_code   In   Varchar2
     ,p_parent_form_code   In   Varchar2
     ,p_entity_path        In   Varchar2
   )
      Return t_apps_role_menus Pipelined;

   --
   Function get_resp_id
      Return Number;
--
End apps_role_menus_pkg;
/

Create Or Replace Package Body apps_role_menus_pkg As
   --
   Procedure p_ins_chld (p_app_menu_id In Out Number, p_menu_code In Out Varchar2) As
      l_menu_code   Varchar2 (2000);
      l_cnt         Number;
   Begin
      Select Count (*)
        Into l_cnt
        From apps_role_menus p
       Where p.menu_code = p_menu_code
         And p.form_code Is Null
         And entity_type In ('MENU', 'FORM');

      If l_cnt > 0 Then
         Select main_sq.Nextval
           Into p_app_menu_id
           From DUAL;

         l_menu_code    := p_menu_code || '_' || TO_CHAR (p_app_menu_id);

         Insert Into apps_role_menus
                     (app_menu_id, menu_code, parent_menu_code, Position, form_code, enabled_flag, display_name
                     ,entity_type)
              Values (p_app_menu_id, l_menu_code, p_menu_code, Null, '', 'Y', '', 'MENU');
      Else
         form_utils.err_message ('Вы не можете на данном элементе добавлить дочерние элементы');
      End If;
   End p_ins_chld;

   --
   Procedure p_ins_upd (
      p_app_menu_id          In Out   Number
     ,p_menu_code            In Out   Varchar2
     ,p_parent_menu_code     In Out   Varchar2
     ,p_position             In Out   Varchar2
     ,p_form_code            In Out   Varchar2
     ,p_enabled_flag         In Out   Varchar2
     ,p_display_name         In Out   Varchar2
     ,p_root_menu_code       In Out   Varchar2
     ,p_entity_type          In Out   Varchar2
     ,p_master_form_code     In Out   Varchar2
     ,p_parent_form_code     In Out   Varchar2
     ,p_entity_path          In Out   Varchar2
     ,p_parent_entity_path   In Out   Varchar2
     ,p_object_code          In Out   Varchar2
     ,p_is_frozen_flag       In Out   Varchar2
   ) Is
      l_cnt   Number;
   Begin
      If p_entity_type Is Null Then
         p_entity_type    := 'MENU';
      End If;

      If     p_entity_type = 'MENU'
         And p_form_code Is Not Null Then
         p_entity_type    := 'FORM';
      Elsif     p_entity_type = 'FORM'
            And p_form_code Is Null Then
         p_entity_type    := 'MENU';
      End If;

      Begin
         Select Count (*)
           Into l_cnt
           From apps_role_menus
          Where app_menu_id = p_app_menu_id;
      Exception
         When Others Then
            l_cnt    := 0;
      End;

      If l_cnt > 0 Then
         Update apps_role_menus
            Set menu_code = p_menu_code
               ,parent_menu_code = NVL (p_parent_menu_code, p_root_menu_code)
               ,Position = p_position
               ,form_code = p_form_code
               ,enabled_flag = p_enabled_flag
               ,display_name = p_display_name
               ,entity_type = p_entity_type
               ,master_form_code = p_master_form_code
               ,parent_form_code = p_parent_form_code
               ,entity_path = p_entity_path
               ,parent_entity_path = p_parent_entity_path
               ,object_code = p_object_code
               ,is_frozen_flag = p_is_frozen_flag
          Where app_menu_id = p_app_menu_id;
      Else
         Select main_sq.Nextval
           Into p_app_menu_id
           From DUAL;

         Insert Into apps_role_menus
                     (app_menu_id, menu_code, parent_menu_code, Position, form_code, enabled_flag, display_name
                     ,entity_type, master_form_code, parent_form_code, entity_path, parent_entity_path, object_code
                     ,is_frozen_flag)
              Values (p_app_menu_id, p_menu_code, NVL (p_parent_menu_code, p_root_menu_code), p_position, p_form_code
                     ,p_enabled_flag, p_display_name, p_entity_type, p_master_form_code, p_parent_form_code
                     ,p_entity_path, p_parent_entity_path, p_object_code, p_is_frozen_flag);
      End If;
   End p_ins_upd;

   --
   Procedure p_delete (p_app_menu_id In Out Number) Is
   Begin
      Delete From apps_role_menus
            Where app_menu_id = p_app_menu_id;
   End p_delete;

   --
   Function get_menu_list
      Return menus_t Pipelined Is
      l_ebs_responsibility_id   Number := g_resp_id;
      l_ebs_roles_cnt           Number;
   Begin
      Select Count (*)
        Into l_ebs_roles_cnt
        From fc22.apps_roles_v a
       Where a.external_role_id = l_ebs_responsibility_id;

      If                                           /* users_pkg.get_user_id = -1 And l_ebs_responsibility_id != 50659*/
         l_ebs_roles_cnt = 0 Then
         For cr In
            (Select     Level lvl, m.menu_code, m.parent_menu_code, m.menu_position, m.show_in_navigator
                       ,NVL (NVL (m.menu_name, m.form_name), m.menu_code) As menu_name, m.form_code, m.form_name
                       ,m.icon_id, m.hot_key, (Select                                     --проблема с CLOB
                                                      description
                                                 From forms f
                                                Where f.form_code = m.form_code) description
                       ,Case
                           When menu_code = 'XXX' Then 999
                           Else (Select Count (*)
                                   From menus a
                                  Where a.parent_menu_code = m.menu_code)
                        End child_count
                   From (Select       -- NVL2 (a.Rowid, a.menu_code, f.form_code) As menu_code, a.menu_name As menu_name
                                -- ,NVL2 (a.Rowid, a.parent_menu_code, 'XXX') As parent_menu_code, a.menu_position
                                NVL (a.menu_code, f.form_code) As menu_code, a.menu_name As menu_name
                               ,NVL (a.parent_menu_code, DECODE (a.menu_code, Null, 'XXX')) parent_menu_code
                               ,a.menu_position, NVL (a.show_in_navigator, 'Y') As show_in_navigator, f.icon_id
                               ,f.hot_key, f.form_code, NVL (f.form_name, f.form_code) As form_name, f.description
                           From menus a Full Outer Join forms f On a.menu_form_code = f.form_code
                         Union All
                         Select 'XXX' As menu_code, 'Прочее' As menu_name, Null As parent_menu_code
                               , (Select Max (menu_position) + 10
                                    From menus a) As menu_position, 'Y' As show_in_navigator, Null As icon_id
                               ,Null As hot_key, '' As form_code, '' As form_name, Null As description
                           From DUAL
                          Where 1 = 1
                                     --
                        ) m
             Connect By Prior m.menu_code = m.parent_menu_code
             Start With m.parent_menu_code Is Null
               Order By lvl, m.parent_menu_code, m.menu_position, menu_name) Loop
            If cr.show_in_navigator = 'Y' Then
               Pipe Row (cr);
            End If;
         End Loop;
      Else
         For cr In (With t As
                         (
                            Select m.menu_code, parent_menu_code, m.Position, m.enabled_flag
                                  ,NVL (NVL (m.display_name, f.form_name), m.menu_code) As display_name, f.form_code
                                  ,f.form_name, f.icon_id, f.hot_key, f.description
                              From apps_role_menus m Left Join forms f On f.form_code = m.form_code
                             Where 'Y' = m.enabled_flag
                               And m.entity_type In ('MENU', 'FORM'))
                    Select     Level lvl, menu_code, DECODE (Level, 1, Null, y.parent_menu_code) As parent_menu_code
                              ,Position, enabled_flag, display_name, form_code, form_name, icon_id, hot_key
                              ,description, (Select Count (*)
                                               From t x
                                              Where y.menu_code = x.parent_menu_code) child_count
                          From t y
                    Start With y.parent_menu_code = (Select r.root_menu_code
                                                       From apps_roles_v r
                                                      Where r.external_role_id = l_ebs_responsibility_id)
                    Connect By Prior menu_code = parent_menu_code
                      Order Siblings By Position, display_name, menu_code) Loop
            Pipe Row (cr);
         End Loop;
      End If;

      Return;
   End get_menu_list;

   --
   Function get_apps_role_menus (
      p_root_menu_code     In   Varchar2
     ,p_menu_code          In   Varchar2
     ,p_parent_menu_code   In   Varchar2
     ,p_form_code          In   Varchar2
     ,p_entity_type        In   Varchar2
     ,p_master_form_code   In   Varchar2
     ,p_parent_form_code   In   Varchar2
     ,p_entity_path        In   Varchar2
   )
      Return t_apps_role_menus Pipelined Is
      l_rec   apps_role_menus%Rowtype;
      l_rn    Number;
   Begin
      l_rn    := ROUND (-1000000000 * DBMS_RANDOM.Value);

      If p_root_menu_code Is Not Null Then
         For cr In (With ent As
                         (
                            Select entity_type, NVL (form_code, menu_code) entity_code
                                  , (Select h.entity_type
                                       From apps_role_menus h
                                      Where h.menu_code = r.parent_menu_code) parent_entity_type
                                  ,parent_menu_code parent_entity_code, NVL (display_name, form_code) display_name
                                  ,r.Position display_number, '' master_entity_code, '' master_entity_type, form_code
                                  ,menu_code object_code, app_menu_id, is_frozen_flag, enabled_flag
                              From apps_role_menus r
                             Where entity_type In ('MENU', 'FORM')
                            Union All
                            Select entity_type, form_code || '*' || entity_type entity_code, 'FORM' parent_entity_type
                                  ,form_code parent_entity_code, display_name, Null + 0 display_number
                                  ,'' master_entity_code, '' master_entity_type, form_code, entity_type object_code
                                  ,-1 app_menu_id, 'N' is_frozen_flag, 'Y' enabled_flag
                              From forms
                                  , (Select     DECODE (Level, 1, 'COLUMNS', 2, 'TABS', 3, 'ACTIONS') entity_type
                                               ,DECODE (Level, 1, 'Колонки', 2, 'Вкладки', 3, 'Действия') display_name
                                           From DUAL
                                     Connect By Level <= 3)
                            Union All
                            Select 'COLUMN' entity_type, c.column_code entity_code, 'COLUMNS' parent_entity_type
                                  , c.form_code || '*COLUMNS' parent_entity_code
                                  ,NVL (c.column_user_name, c.column_code) display_name
                                  ,c.column_display_number display_number, '' master_entity_code, '' master_entity_type
                                  ,form_code, c.column_code object_code, -3 app_menu_id, is_frozen_flag
                                  ,show_on_grid enabled_flag
                              From form_columns c
                            Union All
                            Select 'ACTION' entity_type, a.form_code || '*' || a.action_code entity_code
                                  ,'ACTIONS' parent_entity_type, a.form_code || '*ACTIONS' parent_entity_code
                                  ,NVL (a.action_display_name, a.action_code) display_name, a.display_number
                                  ,'' master_entity_code, '' master_entity_type, form_code, a.action_code object_code
                                  ,-3 app_menu_id, 'N' is_frozen_flag, 'Y' enabled_flag
                              From form_actions a
                            Union All
                            Select 'FORM' entity_type, f.form_code entity_code, 'ACTION' parent_entity_type
                                  , t.form_code || '*' || t.action_code parent_entity_code
                                  ,NVL (NVL (t.action_display_name, f.form_name), f.form_code) display_name
                                  , Null + 0 display_number, t.form_code master_entity_code, 'FORM' master_entity_type
                                  ,f.form_code, f.form_code object_code, -4 app_menu_id, 'N' is_frozen_flag
                                  ,'Y' enabled_flag
                              From form_actions t, forms f
                             Where t.child_form_code = f.form_code
                            Union All
                            Select DECODE (t.tab_type, 1, 'TAB_EDT', 3, 'TAB_DYN', 'TAB_FRM') entity_type
                                  , t.form_code || '*' || t.tab_code entity_code, 'TABS' parent_entity_type
                                  , t.form_code || '*TABS' parent_entity_code, NVL (t.tab_name
                                                                                   ,t.tab_code) display_name
                                  ,t.tab_display_number, '' master_entity_code, '' master_entity_type, form_code
                                  ,t.tab_code object_code, -3 app_menu_id, 'N' is_frozen_flag, 'Y' enabled_flag
                              From form_tabs t
                            Union All
                            Select 'FORM' entity_type, f.form_code entity_code, 'TAB_FRM' parent_entity_type
                                  , t.form_code || '*' || t.tab_code parent_entity_code
                                  ,NVL (NVL (t.tab_name, f.form_name), f.form_code) display_name
                                  , Null + 0 display_number, t.form_code master_entity_code, 'FORM' master_entity_type
                                  ,f.form_code, f.form_code object_code, -4 app_menu_id, 'N' is_frozen_flag
                                  ,'Y' enabled_flag
                              From form_tabs t, forms f
                             Where t.child_form_code = f.form_code
                            Union All
                            Select 'EDIT_COL' entity_type, c.column_code entity_code, 'TAB_EDT' parent_entity_type
                                  , t.form_code || '*' || t.tab_code parent_entity_code
                                  ,NVL (c.column_user_name, c.column_code) display_name
                                  ,c.column_display_number display_number, '' master_entity_code, '' master_entity_type
                                  ,c.form_code, c.column_code object_code, -4 app_menu_id, is_frozen_flag
                                  ,DECODE (c.editor_tab_code, Null, 'N', 'Y') enabled_flag
                              From form_tabs t, form_columns c
                             Where t.form_code = c.form_code
                               And t.tab_type = 1
                               And c.editor_tab_code = t.tab_code)
                        ,tr As
                         (
                            Select     entity_type, entity_code, display_name, display_number, parent_entity_type
                                      ,parent_entity_code, master_entity_code, master_entity_type
                                      ,SYS_CONNECT_BY_PATH (entity_type || '*' || entity_code, '/') entity_path
                                      ,Replace (SYS_CONNECT_BY_PATH (entity_type || '*' || entity_code, '/') || '/'
                                               , '/' || entity_type || '*' || entity_code || '/'
                                               ) parent_entity_path
                                      ,Replace (SYS_CONNECT_BY_PATH (master_entity_type || '*' || master_entity_code
                                                                    ,'/'
                                                                    )
                                               ,'/*'
                                               ) master_entity_path
                                      ,form_code, app_menu_id, object_code, is_frozen_flag, enabled_flag
                                  From ent e
                            Start With parent_entity_type Is Null
                                   And parent_entity_code Is Null
                                   And entity_code = p_root_menu_code
                            Connect By Nocycle Prior entity_code = parent_entity_code
                                   And Prior entity_type = parent_entity_type)
                        ,d As
                         (
                            Select app_menu_id, Case
                                      When app_menu_id > 0 Then object_code
                                      Else entity_path
                                   End menu_code, parent_entity_path parent_menu_code, display_name
                                  ,display_number Position, form_code, enabled_flag
                                  ,SUBSTR (master_entity_path, INSTR (master_entity_path, '*', -1) + 1)
                                                                                                       parent_form_code
                                  ,SUBSTR (master_entity_path
                                          , INSTR (master_entity_path, 'FORM') + 5
                                          ,   INSTR (master_entity_path, '/', INSTR (master_entity_path, 'FORM'))
                                            - INSTR (master_entity_path, 'FORM')
                                            - 5
                                          ) master_form_code
                                  ,entity_type, entity_path, parent_entity_path, object_code, is_frozen_flag
                              From tr)
                    Select NVL (r.app_menu_id, d.app_menu_id) app_menu_id, NVL (r.menu_code, d.menu_code) menu_code
                          ,NVL (r.parent_menu_code, d.parent_menu_code) parent_menu_code, d.Position
                          ,NVL (r.form_code, d.form_code) form_code, NVL (r.enabled_flag, d.enabled_flag) enabled_flag
                          ,NVL (r.display_name, d.display_name) display_name, d.parent_form_code, d.master_form_code
                          ,d.entity_type, d.entity_path, d.parent_entity_path, d.object_code
                          ,NVL (r.is_frozen_flag, d.is_frozen_flag) is_frozen_flag
                      From d Left Join apps_role_menus r On r.app_menu_id = d.app_menu_id
                                                        Or d.menu_code = r.menu_code
                     Where (    p_entity_path Is Not Null
                            And d.parent_entity_path = p_entity_path)
                        Or (    p_entity_path Is Null
                            And d.entity_path = '/MENU*' || p_root_menu_code)) Loop
            l_rec    := cr;
            Pipe Row (l_rec);
         End Loop;
      End If;

      Return;
   End;

   --
   Function get_resp_id
      Return Number Is
      Result   Number;
   Begin
      If User = 'APPS' Then
         Result    := NVL (TO_NUMBER (apps.fnd_profile.Value ('XXFC_CURRENT_RESP_ID')), 0);
      Else
         Result    := apps.fnd_global.resp_id;
      End If;

      Return Result;
   Exception
      When Others Then
         Return -1;
   End;
Begin
   g_resp_id    := apps.fnd_global.resp_id;
End apps_role_menus_pkg;
/

-- End of DDL Script for Package FC22.APPS_ROLE_MENUS_PKG

