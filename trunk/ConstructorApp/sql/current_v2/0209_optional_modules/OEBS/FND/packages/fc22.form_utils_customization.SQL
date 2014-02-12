-- Start of DDL Script for Package FC22.FORM_UTILS_CUSTOMIZATION
-- Generated 17.11.2013 3:00:38 from FC22@KZM_HRDEV

Create Or Replace Package form_utils_customization As
   Type t_form_action_tbl Is Table Of form_actions%Rowtype;

   Procedure customize_column_metadata (
      p_column_number                   Number
     ,p_column_data            In Out   form_utils.column_rec
     ,p_master_form_code                Varchar2 Default Null
     ,p_master_form_tab_code   In       Varchar2 Default Null
   );

   Function customize_form_action (
      p_form_code              In   Varchar2
     ,p_master_form_code       In   Varchar2 Default Null
     ,p_master_form_tab_code   In   Varchar2 Default Null
   )
      Return t_form_action_tbl Pipelined;

   Function customize_form_tabs (p_form_code Varchar2 Default Null, p_master_form_code Varchar2 Default Null)
      Return form_utils.form_tabs_t Pipelined;
End form_utils_customization;
/

Create Or Replace Package Body form_utils_customization As
   g_resp_id      Number;
   g_root_menu    Varchar2 (240);
   g_master_tab   Varchar2 (240);
   g_master_act   Varchar2 (240);

   Procedure set_master_menu (
      p_master_form_code       In   Varchar2 Default Null
     ,p_master_form_tab_code   In   Varchar2 Default Null
   ) As
   Begin
      g_resp_id       := apps_role_menus_pkg.get_resp_id;

      Begin
         Select '/MENU*' || r.root_menu_code
           Into g_root_menu
           From apps_roles_v r
          Where r.external_role_id = g_resp_id;
      Exception
         When Others Then
            g_root_menu    := '/MENU*#';
      End;

      g_master_tab    :=
            NVL (g_root_menu, '#')
         || '/%'
         ||                                                                                                            --
            Case
               When p_master_form_code Is Null Then ''
               Else    '/FORM*'
                    || p_master_form_code
                    ||                                                                                                 --
                       '/TABS*'
                    || p_master_form_code
                    || '*TABS'
                    ||                                                                                                 --
                       '/TAB_FRM*'
                    || p_master_form_code
                    || '*'
                    || p_master_form_tab_code
                    ||                                                                                                 --
                       '%'
            --
            End;
      g_master_act    :=
            NVL (g_root_menu, '#')
         || '/%'
         ||                                                                                                            --
            Case
               When p_master_form_code Is Null Then ''
               Else    '/FORM*'
                    || p_master_form_code
                    ||                                                                                                 --
                       '/ACTIONS*'
                    || p_master_form_code
                    || '*ACTIONS'
                    ||                                                                                                 --
                       '/ACTION*'
                    || p_master_form_code
                    || '*'
                    ||                                                                                                 --
                       '%'
            --
            End;
   End;

   Procedure customize_column_metadata (
      p_column_number                   Number
     ,p_column_data            In Out   form_utils.column_rec
     ,p_master_form_code                Varchar2 Default Null
     ,p_master_form_tab_code   In       Varchar2 Default Null
   ) Is
      l_column_data   form_utils.column_rec;
   Begin
      g_resp_id    := apps_role_menus_pkg.get_resp_id;

      If (p_column_data.form_code = 'MZ_DIMENSION_DEMO1') Then
         matrix_rep_demo_pkg.customize_column_metadata (p_column_number, p_column_data);
      End If;

      Case
         When     p_column_data.form_code = 'INS_INS_INSURED'
              And p_master_form_code = 'INS_INS_CONTRACT'
              And p_column_data.column_code = 'CONTRACT_ID' Then
            p_column_data.show_on_grid    := 'N';
         When     p_column_data.form_code = 'INS_INS_PROGRAM'
              And p_master_form_code = 'INS_INS_CONTRACT'
              And p_column_data.column_code = 'CONTRACT_ID' Then
            p_column_data.show_on_grid    := 'N';
         When     p_column_data.form_code = 'INS_INS_ACCOUNT_LINES'
              And p_master_form_code = 'INS_INS_INSURED'
              And p_column_data.column_code = 'INSURED_ID' Then
            p_column_data.show_on_grid    := 'N';
         When     p_column_data.form_code = 'INS_INS_ACCOUNT_LINES'
              And p_master_form_code = 'INS_INS_INSURED'
              And p_column_data.column_code = 'SEARCH_TEXT' Then
            p_column_data.show_on_grid    := 'N';
         When     p_column_data.form_code = 'INS_INS_ACCOUNT_LINES'
              And p_master_form_code = 'ACCOUNTS_GEN'
              And p_column_data.column_code In ('COMPANY_ID', 'ACCOUNT_NUM') Then
            p_column_data.show_on_grid    := 'N';
         When     p_column_data.form_code = 'INS_INS_ACCOUNT_LINES'
              And p_master_form_code = 'INS_INS_ACCOUNT'
              And p_column_data.column_code In ('COMPANY_ID', 'ACCOUNT_NUM') Then
            p_column_data.show_on_grid    := 'N';
         When     p_column_data.form_code = 'FORM_COLUMN_ACTIONS'
              And p_master_form_code = 'FORM_ACTIONS'
              And p_column_data.column_code In ('FORM_CODE', 'ACTION_CODE') Then
            p_column_data.show_on_grid    := 'N';
         When     p_column_data.form_code = 'FORM_COLUMN_ACTIONS'
              And p_master_form_code = 'FORM_COLUMNS'
              And p_column_data.column_code In ('FORM_CODE', 'COLUMN_CODE') Then
            p_column_data.show_on_grid    := 'N';
         Else
            Null;
      End Case;

      --
      Begin
         l_column_data    := Null;

         For cr In (Select *
                      From fc_customize_columns_g g
                     Where p_column_data.form_code = g.form_code
                       And p_column_data.column_code = g.column_code                                                   --
                                                                    ) Loop
            l_column_data    := cr;
         End Loop;

         If l_column_data.column_code Is Not Null Then
            p_column_data    := l_column_data;
         End If;
      Exception
         When Others Then
            Null;
      End;

      --
      -- p_column_data.column_user_name := p_master_form_code || ' - ' || p_column_data.column_user_name;
      set_master_menu (p_master_form_code, p_master_form_tab_code);

      Begin
         Select t.enabled_flag, NVL (t.display_name, p_column_data.column_user_name)
               ,NVL (t.is_frozen_flag, p_column_data.is_frozen_flag)
           Into p_column_data.show_on_grid, p_column_data.column_user_name, p_column_data.is_frozen_flag
           From apps_role_menus t
          Where t.entity_type In ('COLUMN')
            And (   t.entity_path Like
                          g_master_tab
                       ||                                                                                              --
                          '/FORM*'
                       || p_column_data.form_code
                       ||                                                                                              --
                          '/COLUMNS*'
                       || p_column_data.form_code
                       || '*COLUMNS'
                       ||                                                                                              --
                          '/COLUMN*'
                       || p_column_data.column_code
                       ||                                                                                              --
                          '%'                                                                                          --
                 Or t.entity_path Like
                          g_master_act
                       ||                                                                                              --
                          '/FORM*'
                       || p_column_data.form_code
                       ||                                                                                              --
                          '/COLUMNS*'
                       || p_column_data.form_code
                       || '*COLUMNS'
                       ||                                                                                              --
                          '/COLUMN*'
                       || p_column_data.column_code
                       ||                                                                                              --
                          '%'                                                                                          --
                )
            And t.form_code = p_column_data.form_code
            And t.object_code = p_column_data.column_code;
      Exception
         When Others Then
            Null;
      End;

      --
      Begin
         Select DECODE (t.enabled_flag, 'N', Null, p_column_data.editor_tab_code)
               ,NVL (t.display_name, p_column_data.column_user_name)
               ,NVL (t.is_frozen_flag, p_column_data.is_frozen_flag)
           Into p_column_data.editor_tab_code, p_column_data.column_user_name, p_column_data.is_frozen_flag
           From apps_role_menus t
          Where t.entity_type In ('EDIT_COL')
            And (   t.entity_path Like
                          g_master_tab
                       ||                                                                                              --
                          '/FORM*'
                       || p_column_data.form_code
                       ||                                                                                              --
                          '/TABS*'
                       || p_column_data.form_code
                       || '*TABS'
                       ||                                                                                              --
                          '/TAB_EDT*'
                       || p_column_data.form_code
                       || '%'
                       ||                                                                                              --
                          '/EDIT_COL*'
                       || p_column_data.column_code
                       ||                                                                                              --
                          '%'                                                                                          --
                 Or t.entity_path Like
                          g_master_act
                       ||                                                                                              --
                          '/FORM*'
                       || p_column_data.form_code
                       ||                                                                                              --
                          '/TABS*'
                       || p_column_data.form_code
                       || '*TABS'
                       ||                                                                                              --
                          '/TAB_EDT*'
                       || p_column_data.form_code
                       || '%'
                       ||                                                                                              --
                          '/EDIT_COL*'
                       || p_column_data.column_code
                       ||                                                                                              --
                          '%'                                                                                          --
                )
            And t.form_code = p_column_data.form_code
            And t.object_code = p_column_data.column_code;
      Exception
         When Others Then
            Null;
      End;
   End;

   --
   Function customize_form_action (
      p_form_code              In   Varchar2
     ,p_master_form_code       In   Varchar2 Default Null
     ,p_master_form_tab_code   In   Varchar2 Default Null
   )
      Return t_form_action_tbl Pipelined Is
      l_enabled      Varchar2 (240);
      l_rec          form_actions%Rowtype;
      --
      l_root_menu    Varchar2 (240);
      l_master_tab   Varchar2 (240);
      l_master_act   Varchar2 (240);
   Begin
      set_master_menu (p_master_form_code, p_master_form_tab_code);

      For cr In (Select *
                   From form_actions
                  Where form_code = p_form_code /*And g_resp_id <> 0*/) Loop
         l_rec        := cr;
         l_enabled    := 'Y';

         Begin
            Select NVL (t.enabled_flag, 'Y'), NVL (t.display_name, l_rec.action_display_name)
              Into l_enabled, l_rec.action_display_name
              From apps_role_menus t
             Where t.entity_type = 'ACTION'
               And (   t.entity_path Like
                             g_master_tab
                          ||                                                                                           --
                             '/FORM*'
                          || cr.form_code
                          ||                                                                                           --
                             '/ACTIONS*'
                          || cr.form_code
                          || '*ACTIONS'
                          ||                                                                                           --
                             '/ACTION*'
                          || cr.form_code
                          || '*'
                          || cr.action_code                                                                            --
                    Or                                                                                                 --
                       t.entity_path Like
                             g_master_act
                          ||                                                                                           --
                             '/FORM*'
                          || cr.form_code
                          ||                                                                                           --
                             '/ACTIONS*'
                          || cr.form_code
                          || '*ACTIONS'
                          ||                                                                                           --
                             '/ACTION*'
                          || cr.form_code
                          || '*'
                          || cr.action_code                                                                            --
                   )                                                                                                   --
               And t.form_code = cr.form_code
               And t.object_code = cr.action_code
               And ROWNUM = 1;
         Exception
            When Others Then
               l_enabled    := 'Y';
         End;

         If l_enabled = 'Y' Then
            Pipe Row (l_rec);
         End If;
      End Loop;

      Return;
   End;

   Function customize_form_tabs (p_form_code Varchar2 Default Null, p_master_form_code Varchar2 Default Null)
      Return form_utils.form_tabs_t Pipelined Is
      l_ebs_responsibility_id   Number              := apps_role_menus_pkg.get_resp_id;
      l_enabled                 Varchar2 (240);
      l_rec                     form_tabs%Rowtype;
   Begin
      set_master_menu (p_master_form_code, '');

      For cr In (Select   ft.form_code, ft.tab_code, ft.child_form_code, NVL (ft.tab_position, 'R') tab_position
                         ,NVL (ft.tab_name, (Select NVL (f.form_name, f.form_code)
                                               From forms f
                                              Where f.form_code = ft.child_form_code)) tab_name
                         ,NVL (ft.number_of_columns, 2) number_of_columns
                         ,NVL (ft.icon_id, (Select f.icon_id
                                              From forms f
                                             Where f.form_code = ft.child_form_code)) icon_id, ft.tab_type
                         ,tab_display_number
                     From form_tabs ft
                    Where ft.form_code = NVL (p_form_code, ft.form_code)
                      And Not Exists (
                             Select 1
                               From form_tab_parent_exclns a
                              Where a.form_code = ft.form_code
                                And a.parent_form_code = p_master_form_code
                                And a.included_flag = 'N'
                                And a.tab_code = ft.tab_code)
                 -- And g_resp_id <> 0
                 Order By tab_display_number, tab_name, tab_code) Loop
         l_rec        := cr;
         l_enabled    := 'Y';

         -- TAB_FRM
         Begin
            Select NVL (t.enabled_flag, 'Y'), NVL (t.display_name, l_rec.tab_name)
              Into l_enabled, l_rec.tab_name
              From apps_role_menus t
             Where t.entity_type = 'TAB_FRM'
               And (   t.entity_path Like
                             g_master_tab
                          ||                                                                                           --
                             '/FORM*'
                          || cr.form_code
                          ||                                                                                           --
                             '/TABS*'
                          || cr.form_code
                          || '*TABS'
                          ||                                                                                           --
                             '/TAB_FRM*'
                          || cr.form_code
                          || '*'
                          || cr.tab_code
                          ||                                                                                           --
                             '%'                                                                                       --
                    Or                                                                                                 --
                       t.entity_path Like
                             g_master_act
                          ||                                                                                           --
                             '/FORM*'
                          || cr.form_code
                          ||                                                                                           --
                             '/TABS*'
                          || cr.form_code
                          || '*TABS'
                          ||                                                                                           --
                             '/TAB_FRM*'
                          || cr.form_code
                          || '*'
                          || cr.tab_code
                          ||                                                                                           --
                             '%'                                                                                       --
                   )
               And t.form_code = cr.form_code
               And t.object_code = cr.tab_code;
         Exception
            When Others Then
               l_enabled    := 'Y';
         End;

         -- TAB_EDT
         Begin
            Select NVL (t.enabled_flag, l_enabled), NVL (t.display_name, l_rec.tab_name)
              Into l_enabled, l_rec.tab_name
              From apps_role_menus t
             Where t.entity_type = 'TAB_EDT'
               And (   t.entity_path Like
                             g_master_tab
                          ||                                                                                           --
                             '/FORM*'
                          || cr.form_code
                          ||                                                                                           --
                             '/TABS*'
                          || cr.form_code
                          || '*TABS'
                          ||                                                                                           --
                             '/TAB_EDT*'
                          || cr.form_code
                          || '*'
                          || cr.tab_code
                          ||                                                                                           --
                             '%'                                                                                       --
                    Or                                                                                                 --
                       t.entity_path Like
                             g_master_act
                          ||                                                                                           --
                             '/FORM*'
                          || cr.form_code
                          ||                                                                                           --
                             '/TABS*'
                          || cr.form_code
                          || '*TABS'
                          ||                                                                                           --
                             '/TAB_EDT*'
                          || cr.form_code
                          || '*'
                          || cr.tab_code
                          ||                                                                                           --
                             '%'                                                                                       --
                   )
               And t.form_code = cr.form_code
               And t.object_code = cr.tab_code;
         Exception
            When Others Then
               Null;
         End;

         If l_enabled = 'Y' Then
            Pipe Row (l_rec);
         End If;
      End Loop;

      Return;
   End customize_form_tabs;
End form_utils_customization;
/

-- End of DDL Script for Package FC22.FORM_UTILS_CUSTOMIZATION

