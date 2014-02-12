
Create Or Replace 
PACKAGE fc22.menus_pkg As
   Procedure p_ins_chld (p_menu_code Varchar2, p_element_type Varchar2);

   Procedure p_ins_sibl (p_menu_code Varchar2, p_element_type Varchar2);

   Procedure p_update (
/*      p_menu_code           menus.menu_code%Type
     ,p_menu_name           menus.menu_name%Type
     ,p_parent_menu_code    menus.parent_menu_code%Type
     ,p_menu_form_code      menus.menu_form_code%Type
     ,p_menu_position       menus.menu_position%Type
     ,p_element_type        Varchar2
     ,p_show_in_navigator   Varchar2
     ,p_menu_form_name      Varchar2*/
      p_menu_code           In Out   menus.menu_code%Type
     ,p_menu_name           In Out   menus.menu_name%Type
     ,p_parent_menu_code             menus.parent_menu_code%Type
     ,p_menu_form_code               forms.form_code%Type
     ,p_menu_form_name               forms.form_name%Type
     ,p_menu_position                menus.menu_Position%Type
     ,p_element_type                 Varchar2
     ,p_show_in_navigator            Varchar2
   );

   Procedure p_delete_menu (p_menu_code Varchar2, p_element_type Varchar2);

   Procedure p_delete_form (p_menu_code Varchar2, p_element_type Varchar2);

   Type menu_tree_record Is Record (
      menu_code           Varchar2 (4000)                                                        --menus.menu_code%Type
     ,menu_name           menus.menu_name%Type
     ,parent_menu_code    Varchar2 (4000)                                                 --menus.parent_menu_code%Type
     ,menu_form_code      menus.menu_form_code%Type
     ,form_display_stat   menus.menu_form_code%Type
     ,menu_position       menus.menu_position%Type
     ,icon_id             icons.icon_id%Type
     ,is_folder           Varchar2 (1)
     ,element_type        Varchar2 (100)
     ,show_in_navigator   menus.show_in_navigator%Type
     ,can_accept_drop     Varchar2 (1)                                 Default 'N'
     ,can_drag            Varchar2 (1)                                 Default 'N'
     ,form_code           forms.form_code%Type
     ,tab_code            form_tabs.tab_code%Type
     ,column_code         form_columns.column_code%Type
     ,action_code         form_actions.action_code%Type
     ,lookup_code         form_columns.lookup_code%Type
   );

   Type menu_tree_table Is Table Of menu_tree_record;

   Function p_get_menu_tree (
      p_menu_code      Varchar2
     ,p_element_type   Varchar2
     ,p_form_display   Varchar2
     ,p_form_code      forms.form_code%Type
     ,p_tab_code       form_tabs.tab_code%Type
     ,p_column_code    form_columns.column_code%Type Default Null
     ,p_action_code    form_actions.action_code%Type Default Null
     ,p_lookup_code    form_columns.lookup_code%Type Default Null
   )
      Return menu_tree_table Pipelined;
End;
/

-- Grants for Package
Grant Execute On fc22.menus_pkg To fc_admin
/

Create Or Replace 
PACKAGE BODY fc22.menus_pkg As
   Procedure p_ins_chld (p_menu_code Varchar2, p_element_type Varchar2) As
      l_menu_name   Varchar2 (32000);
   Begin
      If p_element_type In ('FORM', 'FOLDER') Then
         Select p_menu_code || '_' || menu_sq.Nextval
           Into l_menu_name
           From DUAL;

         form_utils.check_nulls (args_t (p_menu_code), args_t ('Не указан код меню'));

         Insert Into menus
                     (parent_menu_code, menu_code, menu_name)
              Values (p_menu_code, l_menu_name, l_menu_name);
      Else
         form_utils.err_message ('Вы не можете системным элементам добавлять дочерние элементы');
      End If;
   End p_ins_chld;

   Procedure p_ins_sibl (p_menu_code Varchar2, p_element_type Varchar2) As
      l_menu_name          Varchar2 (32000);
      l_parent_menu_code   Varchar2 (32000);
   Begin
      If p_element_type In ('FORM', 'FOLDER') Then
         Select parent_menu_code
           Into l_parent_menu_code
           From menus
          Where menu_code = p_menu_code;

         Select DECODE (l_parent_menu_code, Null, '', l_parent_menu_code || '_') || menu_sq.Nextval
           Into l_menu_name
           From DUAL;

         Insert Into menus
                     (parent_menu_code, menu_code, menu_name)
              Values (l_parent_menu_code, l_menu_name, l_menu_name);
      Else
         form_utils.err_message ('Вы не можете системным элементам добавлять дочерние элементы');
      End If;
   End p_ins_sibl;

   Procedure p_update (
      p_menu_code           In Out   menus.menu_code%Type
     ,p_menu_name           In Out   menus.menu_name%Type
     ,p_parent_menu_code             menus.parent_menu_code%Type
     ,p_menu_form_code               forms.form_code%Type
     ,p_menu_form_name               forms.form_name%Type
     ,p_menu_position                menus.menu_Position%Type
     ,p_element_type                 Varchar2
     ,p_show_in_navigator            Varchar2
   ) As
      l_menu_code        menus.menu_code%Type   := p_menu_code;
      l_cnt              Number;
      l_is_folder        Varchar2 (100);
      l_menu_form_code   forms.form_code%Type   := NVL (p_menu_form_code, p_menu_form_name);
      l_menu_form_name   forms.form_code%Type   := NVL (p_menu_form_name, p_menu_form_code);
   Begin
      If    p_element_type In ('FORM', 'FOLDER')
         Or p_element_type Is Null Then
         form_utils.check_nulls (args_t (p_menu_name), args_t ('Не указано наименование'));

         If l_menu_code Is Null Then
            Select menu_sq.Nextval
              Into l_menu_code
              From DUAL;
         End If;

         If l_menu_form_name Is Not Null Then
            Select Count (*)
              Into l_cnt
              From forms f
             Where f.form_code = l_menu_form_code;

            Select Count (*) + l_cnt
              Into l_cnt
              From forms f
             Where f.form_name = l_menu_form_name;

            If l_cnt = 0 Then
               forms2_pkg.p_insert (l_menu_form_name, l_menu_form_code, l_is_folder);
            End If;
         End If;

         Update menus m
            Set menu_code = l_menu_code
               ,menu_name = p_menu_name
               ,parent_menu_code = p_parent_menu_code
               ,menu_form_code = l_menu_form_code
               ,menu_Position = p_menu_position
               ,show_in_navigator = p_show_in_navigator
          Where m.menu_code = p_menu_code;

         If Sql%Rowcount = 0 Then
            Insert Into menus m
                        (menu_code, menu_name, parent_menu_code, menu_form_code, menu_Position, show_in_navigator)
                 Values (l_menu_code, p_menu_name, p_parent_menu_code, l_menu_form_code, p_menu_position
                        ,p_show_in_navigator);
         End If;
      Else
         form_utils.err_message ('Вы не можете изменять системные элементы = ' || p_element_type);
      End If;
   End p_update;

   Procedure p_delete_menu (p_menu_code Varchar2, p_element_type Varchar2) As
      l_cnt   Number;
   Begin
      If p_element_type In ('FOLDER', 'FORM') Then
         Select Count (*)
           Into l_cnt
           From menus
          Where parent_menu_code = p_menu_code
            And ROWNUM < 2;

         If l_cnt > 0 Then
            form_utils.err_message ('Удалите все дочерние элементы');
         End If;

         Delete From menus m
               Where m.menu_code = p_menu_code;
      Else
         form_utils.err_message ('Вы не можете удалить системные элементы');
      End If;
   End p_delete_menu;

   Procedure p_delete_form (p_menu_code Varchar2, p_element_type Varchar2) As
      l_menu_form_code   forms.form_code%Type;
   Begin
      If p_element_type In ('FORM') Then
         Select menu_form_code
           Into l_menu_form_code
           From menus
          Where menu_code = p_menu_code;

         FORMS2_PKG.p_delete (l_menu_form_code);

         Update menus
            Set menu_form_code = Null
          Where menu_form_code = l_menu_form_code;
      Else
         form_utils.err_message ('Вы не можете удалить системные элементы');
      End If;
   End p_delete_form;

/*
Структура дерева:
--1. FOLDER level 1
--1.1. FOLDER level n
--1.1.1. FORM
--1.1.1.1. DATA
--1.1.1.1.1. TABS
--1.1.1.1.1.1. TAB
--1.1.1.1.1.1.1. TAB_CHILD_FORMS
--1.1.1.1.1.1.1.1. FORM
--1.1.1.1.1.1.2. TAB_PARENT_EXCLNS
--1.1.1.1.1.1.2.1. FORM
--1.1.1.1.1.1.3. TAB_COLUMNS
--1.1.1.1.1.1.3.1. COLUMN
--1.1.1.1.2. ACTIONS
--1.1.1.1.2.1. ACTION
--1.1.1.1.2.1.1. ACTION_PLSQL
??1.1.1.1.2.1.1.1 ACTION_PLSQL_PARAMS
--1.1.1.1.2.1.2. ACTION_COLUMNS
--1.1.1.1.2.1.2.1. COLUMN
--1.1.1.1.2.1.3. ACTION_CHILD_FORM
--1.1.1.1.2.1.4. ACTION_PARENT_ACTION
--1.1.1.1.2.1.5. ACTION_CHILD_ACTIONS
--1.1.1.1.3. COLUMNS
--1.1.1.1.3.1. COLUMN
--1.1.1.1.3.1.1. COLUMN_ACTIONS
--1.1.1.1.3.1.1.1. ACTION
--1.1.1.1.3.1.2. COLUMN_ATTRIBUTES
%%1.1.1.1.3.1.2.1. COLUMN_ATTRIBUTE
--1.1.1.1.3.1.3. COLUMN_STATIC_LOOKUP        (лукап простой)
--1.1.1.1.3.1.4. COLUMN_FORM_LOOKUP          (лукап-форма)
%%1.1.1.1.3.1.4.1. FORM
--1.1.1.1.3.1.5. COLUMN_TAB                  (вкладка)
%%1.1.1.1.3.1.5.1. TAB
??1.1.1.2. FORM.DEPENDS.ON
??1.1.1.3. FORM.DEPENDENT.OBJECTS

"--" - обработано
"%%" - конечный узел, без детализации
"??" - в работе

Особенности: element_type = 'FORM' - открывать в новом окне, а не в одиночной динамической форме из-за особенностей кеша движка
Переписать обработку внизу
*/
   Function p_get_menu_tree (
      p_menu_code      Varchar2
     ,p_element_type   Varchar2
     ,p_form_display   Varchar2
     ,p_form_code      forms.form_code%Type
     ,p_tab_code       form_tabs.tab_code%Type
     ,p_column_code    form_columns.column_code%Type Default Null
     ,p_action_code    form_actions.action_code%Type Default Null
     ,p_lookup_code    form_columns.lookup_code%Type Default Null
   )
      Return menu_tree_table Pipelined As
      l_rec_tmp        menu_tree_table;
      l_rec            menu_tree_table;
      l_element_type   Varchar2 (200)  := Null;
      l_ps             Varchar2 (2)    := '/';                                                         --path separator
      l_vs             Varchar2 (2)    := ':';                         -- separator between entity type and entity name

      Function append_to_collection (p_complete_collection menu_tree_table, p_part menu_tree_table)
         Return menu_tree_table Is
         l_complete_collection   menu_tree_table;
      Begin
         If p_complete_collection Is Null Then
            l_complete_collection    := p_part;
         Else
            Null;
            l_complete_collection := p_complete_collection multiset union all p_part;
         End If;

         Return l_complete_collection;
      End append_to_collection;

      Procedure append_recs Is
      Begin
         l_rec    := append_to_collection (p_complete_collection => l_rec, p_part => l_rec_tmp);
      End;
   Begin
--raise_application_error (-20001 ,'p_menu_code=' || p_menu_code || 'p_element_type=' || p_element_type || 'p_form_display=' || p_form_display || 'p_form_code_for_filter=' || p_form_code_for_filter );
      If (p_element_type = 'FORM') Then
         Begin
            --1.1.1.1. DATA
            l_element_type    := 'DATA';

            Select p_menu_code || l_ps || l_element_type As menu_code, '<i>Настройки формы</i>' menu_name
                  ,p_menu_code parent_menu_code, Null As menu_form_code, 'FORMS' form_display_stat, 1 menu_position
                  ,14 icon_id, 'Y' is_folder, l_element_type element_type, 'Y' show_in_navigator
                  ,'N' As can_accept_drop, 'N' As can_drag, p_form_display As form_code, Null || '' As tab_code
                  ,p_column_code As column_code, p_action_code As p_action_code, p_lookup_code As lookup_code
            Bulk Collect Into l_rec_tmp
              From DUAL;

            append_recs ();
            l_element_type    := 'FORM_DEPENDS_ON';

            Select p_menu_code || l_ps || l_element_type As menu_code, '<i>В работе: Depends On</i>' menu_name
                  ,p_menu_code parent_menu_code, '' menu_form_code, '' form_display_stat, 2 menu_position, 18 icon_id
                  ,'N' is_folder, l_element_type element_type, 'Y' show_in_navigator, 'N' As can_accept_drop
                  ,'N' As can_drag, p_form_display As form_code, Null || '' As tab_code, p_column_code As column_code
                  ,p_action_code As p_action_code, p_lookup_code As lookup_code
            Bulk Collect Into l_rec_tmp
              From DUAL;

            append_recs ();
            l_element_type    := 'FORM_DEPENDENT_OBJECTS';

            Select p_menu_code || l_ps || l_element_type As menu_code, '<i>В работе: Dependent Objects</i>' menu_name
                  ,p_menu_code parent_menu_code, '' menu_form_code, '' form_display_stat, 3 menu_position, 19 icon_id
                  ,'N' is_folder, l_element_type element_type, 'Y' show_in_navigator, 'N' As can_accept_drop
                  ,'N' As can_drag, p_form_display As form_code, Null || '' As tab_code, p_column_code As column_code
                  ,p_action_code As p_action_code, p_lookup_code As lookup_code
            Bulk Collect Into l_rec_tmp
              From DUAL;

            append_recs ();
         End;
      Elsif (p_element_type = 'DATA') Then
         Begin
            --1.1.1.1.3. COLUMNS
            l_element_type    := 'COLUMNS';

            Select p_menu_code || l_ps || l_element_type As menu_code
                  , '<i>Колонки [<b>' || Count (*) || '</b>]</i>' As menu_name, p_menu_code parent_menu_code
                  ,Null As menu_form_code, 'FORM_COLUMNS' form_display_stat, 1 menu_position, 11 icon_id
                  ,DECODE (Count (*), 0, 'N', 'Y') is_folder, l_element_type element_type, 'Y' show_in_navigator
                  ,'N' As can_accept_drop, 'N' As can_drag, p_form_code As form_code, p_tab_code As tab_code
                  ,p_column_code As column_code, p_action_code As p_action_code, p_lookup_code As lookup_code
            Bulk Collect Into l_rec_tmp
              From Table (form_utils.describe_form_columns_pl (p_form_code)) c;

            append_recs ();
            --1.1.1.1.2. ACTIONS
            l_element_type    := 'ACTIONS';

            Select p_menu_code || l_ps || l_element_type As menu_code
                  , '<i>Действия [<b>' || Count (*) || '</b>]</i>' As menu_name, p_menu_code As parent_menu_code
                  ,Null As menu_form_code, 'FORM_ACTIONS' As form_display_stat, 2 As menu_position, 13 As icon_id
                  ,DECODE (Count (*), 0, 'N', 'Y') As is_folder, l_element_type As element_type
                  ,'Y' As show_in_navigator, 'N' As can_accept_drop, 'N' As can_drag, p_form_code As form_code
                  ,p_tab_code As tab_code, p_column_code As column_code, p_action_code As p_action_code
                  ,p_lookup_code As lookup_code
            Bulk Collect Into l_rec_tmp
              From FORM_ACTIONS c
             Where c.form_code = p_form_code;

            append_recs ();
            --1.1.1.1.1. TABS
            l_element_type    := 'TABS';

            Select p_menu_code || l_ps || l_element_type As menu_code
                  , '<i>Вкладки [<b>' || Count (*) || '</b>]</i>' As menu_name, p_menu_code As parent_menu_code
                  ,Null As menu_form_code, 'FORM_TABS' As form_display_stat, 3 As menu_position, 12 As icon_id
                  ,DECODE (Count (*), 0, 'N', 'Y') As is_folder, l_element_type As element_type
                  ,'Y' As show_in_navigator, 'N' As can_accept_drop, 'N' As can_drag, p_form_code As form_code
                  ,p_tab_code As tab_code, p_column_code As column_code, p_action_code As p_action_code
                  ,p_lookup_code As lookup_code
            Bulk Collect Into l_rec_tmp
              From FORM_TABS c
             Where c.form_code = p_form_code;

            append_recs ();
         End;
      Elsif (p_element_type In ('COLUMNS', 'ACTION_COLUMNS', 'TAB_COLUMNS')) Then
         Begin
            --1.1.1.1.3.1. COLUMN
            --1.1.1.1.1.1.3.1. COLUMN
            --1.1.1.1.2.1.2.1. COLUMN
            l_element_type    := 'COLUMN';

            Select p_menu_code || l_ps || l_element_type || l_vs || c.column_code As menu_code
                  ,DECODE (c.exists_in_metadata_flag
                          ,'Y', c.column_user_name || ' [<b>' || c.column_code || '</b>]'
                          , ' <font color="red">[<b>' || c.column_code || '</b>]</font>'
                          ) As menu_name
                  ,p_menu_code As parent_menu_code, Null As menu_form_code, 'FORM_COLUMNS' As form_display_stat
                  ,c.column_display_number As menu_position, 11 icon_id
                  ,Case
                      -- 1. Действия поля
                   When 0 != (Select Count (*)
                                From form_column_actions fca
                               Where fca.form_code = c.form_code
                                 And fca.column_code = c.column_code) Then 'Y'
                      --2. аттрибуты
                   When 0 != (Select Count (*)
                                From form_column_attr_vals fcav
                               Where fcav.form_code = c.form_code
                                 And fcav.column_code = c.column_code) Then 'Y'
                      -- 3. лукап простой
                   When c.lookup_code Is Not Null
                   And c.field_type In (8, 10) Then 'Y'
                      -- 4. лукап-форма
                   When c.lookup_code Is Not Null
                   And c.field_type In (9, 16) Then 'Y'
                      -- 5. вкладка
                   When c.editor_tab_code Is Not Null Then 'Y'
                      Else 'N'
                   End As is_folder
                  ,l_element_type As element_type, 'Y' As show_in_navigator, 'N' As can_accept_drop, 'N' As can_drag
                  ,p_form_code As form_code, p_tab_code As tab_code, c.column_code As column_code
                  ,p_action_code As p_action_code, p_lookup_code As lookup_code
            Bulk Collect Into l_rec_tmp
              From Table (form_utils.describe_form_columns_pl (p_form_code)) c
             Where (   (    p_element_type = 'ACTION_COLUMNS'
                        And Exists (
                               Select 1
                                 From form_column_actions fca
                                Where fca.form_code = c.form_code
                                  And fca.column_code = c.column_code
                                  And fca.action_code = p_action_code)
                       )
                    Or (    p_element_type = 'TAB_COLUMNS'
                        And c.editor_tab_code = p_tab_code)
                    Or p_element_type Not In ('ACTION_COLUMNS', 'TAB_COLUMNS')
                   );

            append_recs ();
         End;
      Elsif (p_element_type = 'COLUMN') Then
         Begin
            --1.1.1.1.3.1.1. COLUMN_ACTIONS
            l_element_type    := 'COLUMN_ACTIONS';

            Select   p_menu_code || l_ps || l_element_type As menu_code
                    , '<i>ColumnActions [<b>' || Count (Distinct c.action_code) || '</b>]</i>' As menu_name
                    ,p_menu_code As parent_menu_code, Null As menu_form_code
                    ,'FORM_COLUMN_ACTIONS' As form_display_stat, 1 As menu_position, 14 As icon_id, 'Y' As is_folder
                    ,l_element_type As element_type, 'Y' As show_in_navigator, 'N' As can_accept_drop, 'N' As can_drag
                    ,p_form_code As form_code, p_tab_code As tab_code, p_column_code As column_code
                    ,p_action_code As p_action_code, p_lookup_code As lookup_code
            Bulk Collect Into l_rec_tmp
                From form_column_actions c
               Where c.form_code = p_form_code
                 And c.column_code = p_column_code
            Group By c.form_code, c.column_code
              Having Count (*) != 0;

            append_recs ();
            --1.1.1.1.3.1.2. COLUMN_ATTRIBUTES
            l_element_type    := 'COLUMN_ATTRIBUTES';

            Select   p_menu_code || l_ps || l_element_type As menu_code
                    , '<i>ColumnAttributes [<b>' || Count (Distinct c.attribute_code) || '</b>]</i>' As menu_name
                    ,p_menu_code As parent_menu_code, Null As menu_form_code
                    ,'FORM_COLUMN_ATTR_VALS' As form_display_stat, 1 As menu_position, 14 As icon_id, 'Y' As is_folder
                    ,l_element_type As element_type, 'Y' As show_in_navigator, 'N' As can_accept_drop, 'N' As can_drag
                    ,p_form_code As form_code, p_tab_code As tab_code, p_column_code As column_code
                    ,p_action_code As p_action_code, p_lookup_code As lookup_code
            Bulk Collect Into l_rec_tmp
                From form_column_attr_vals c
               Where c.form_code = p_form_code
                 And c.column_code = p_column_code
            Group By c.form_code, c.column_code
              Having Count (*) != 0;

            append_recs ();
            --1.1.1.1.3.1.3. COLUMN_STATIC_LOOKUP        (лукап простой)
            l_element_type    := 'COLUMN_STATIC_LOOKUP';

            Select p_menu_code || l_ps || l_element_type || l_vs || c.lookup_code As menu_code
                  , '<i>StaticLookup: [<b>' || c.lookup_code || '</b>]</i>' As menu_name
                  ,p_menu_code As parent_menu_code, Null As menu_form_code, 'LOOKUPS' As form_display_stat
                  ,1 As menu_position, 14 As icon_id, 'N' As is_folder, l_element_type As element_type
                  ,'Y' As show_in_navigator, 'N' As can_accept_drop, 'N' As can_drag, p_form_code As form_code
                  ,p_tab_code As tab_code, p_column_code As column_code, p_action_code As p_action_code
                  ,c.lookup_code As lookup_code
            Bulk Collect Into l_rec_tmp
              From form_columns c
             Where c.form_code = p_form_code
               And c.column_code = p_column_code
               And c.field_type In (8, 10)
               And c.lookup_code Is Not Null;

            append_recs ();
            --1.1.1.1.3.1.4. COLUMN_FORM_LOOKUP          (лукап-форма)
            l_element_type    := 'FORM';                                                           -- COLUMN_FORM_LOOKUP

            Select p_menu_code || l_ps || l_element_type || l_vs || c.form_code As menu_code
                  , '<i>FormLookup: ' || f.form_name || '[<b>' || f.form_code || '</b>]</i>' As menu_name
                  ,p_menu_code As parent_menu_code                                                                     --
                  ,c.lookup_code As menu_form_code, Null As form_display_stat, 1 As menu_position
                  ,NVL (f.icon_id, Null) As icon_id, 'Y' As is_folder, l_element_type As element_type
                  ,'Y' As show_in_navigator, 'N' As can_accept_drop, 'N' As can_drag, f.form_code As form_code
                  ,'' As tab_code, '' As column_code, '' As p_action_code, '' As lookup_code
            Bulk Collect Into l_rec_tmp
              From form_columns c, forms f
             Where c.form_code = p_form_code
               And c.column_code = p_column_code
               And c.lookup_code = f.form_code
               And c.field_type In (9, 16);

            append_recs ();
            --1.1.1.1.3.1.5. COLUMN_TAB                  (вкладка)
            l_element_type    := 'TAB';

            Select p_menu_code || l_ps || l_element_type || l_vs || t.tab_code As menu_code
                  , '<i>Tab: ' || t.tab_name || ' [<b>' || t.tab_code || '</b>]</i>' As menu_name
                  ,p_menu_code As parent_menu_code, Null As menu_form_code, 'FORM_TABS' As form_display_stat
                  ,t.tab_display_number As menu_position, t.icon_id As icon_id, 'Y' is_folder
                  ,l_element_type As element_type, 'Y' As show_in_navigator, 'N' As can_accept_drop, 'N' As can_drag
                  ,t.form_code As form_code, t.tab_code As tab_code, '' As column_code, '' As p_action_code
                  ,'' As lookup_code
            Bulk Collect Into l_rec_tmp
              From form_columns c, FORM_TABS t
             Where t.tab_code = c.editor_tab_code
               And t.form_code = c.form_code
               And c.form_code = p_form_code
               And c.column_code = p_column_code;

            append_recs ();
         End;
      Elsif (p_element_type = 'COLUMN_ATTRIBUTES') Then
         Begin
            --1.1.1.1.3.1.2.1. COLUMN_ATTRIBUTE
            l_element_type    := 'COLUMN_ATTRIBUTE';

            Select p_menu_code || l_ps || l_element_type || l_vs || c.form_column_attr_val_id As menu_code
                  , '<i>' || c.attribute_code || ' = <b>' || c.attribute_value || '</b></i>' As menu_name
                  ,p_menu_code As parent_menu_code, Null As menu_form_code, '' As form_display_stat
                  ,1 As menu_position, 14 As icon_id, 'N' As is_folder, l_element_type As element_type
                  ,'Y' As show_in_navigator, 'N' As can_accept_drop, 'N' As can_drag, p_form_code As form_code
                  ,p_tab_code As tab_code, p_column_code As column_code, p_action_code As p_action_code
                  ,p_lookup_code As lookup_code
            Bulk Collect Into l_rec_tmp
              From form_column_attr_vals c
             Where c.form_code = p_form_code
               And c.column_code = p_column_code;

            append_recs ();
         End;
      Elsif (p_element_type In ('ACTIONS', 'COLUMN_ACTIONS', 'ACTION_CHILD_ACTIONS')) Then
         Begin
            --1.1.1.1.2.1. ACTION
            --1.1.1.1.3.1.1.1. ACTION
            l_element_type    := 'ACTION';

            Select p_menu_code || l_ps || l_element_type || l_vs || c.action_code As menu_code
                  , c.action_display_name || ' [<b>' || c.action_code || '</b>]' As menu_name
                  ,p_menu_code parent_menu_code, Null As menu_form_code, 'FORM_ACTIONS' As form_display_stat
                  ,c.display_number As menu_position, c.icon_id As icon_id
                  ,Case
                      When
                          --1.1.1.1.2.1.1. ACTION_PLSQL
                          procedure_name Is Not Null Then 'Y'
                      When
                          --1.1.1.1.2.1.2. ACTION_COLUMNS
                          0 != (Select Count (*)
                                  From form_column_actions fca
                                 Where fca.form_code = c.form_code
                                   And fca.action_code = c.action_code) Then 'Y'
                      When
                          --1.1.1.1.2.1.3. ACTION_CHILD_FORM
                          child_form_code Is Not Null Then 'Y'
                      When
                          --1.1.1.1.2.1.4. ACTION_PARENT_ACTION
                          parent_action_code Is Not Null Then 'Y'
                      When
                          --1.1.1.1.2.1.5. ACTION_CHILD_ACTIONS
                          0 != (Select Count (*)
                                  From form_actions c1
                                 Where c1.parent_action_code = c.action_code
                                   And c1.form_code = c.form_code) Then 'Y'
                      Else 'N'
                   End As is_folder
                  ,l_element_type As element_type, 'Y' As show_in_navigator, 'N' As can_accept_drop, 'N' As can_drag
                  ,p_form_code As form_code, p_tab_code As tab_code, p_column_code As column_code
                  ,c.action_code As action_code, p_lookup_code As lookup_code
            Bulk Collect Into l_rec_tmp
              From form_actions c
             Where c.form_code = p_form_code
               And (   (    p_element_type = 'COLUMN_ACTIONS'
                        And Exists (
                               Select 1
                                 From form_column_actions fca
                                Where fca.form_code = c.form_code
                                  And fca.column_code = p_column_code
                                  And fca.action_code = c.action_code)
                       )
                    Or (    p_element_type = 'ACTION_CHILD_ACTIONS'
                        And Exists (
                               Select 1
                                 From form_actions c1
                                Where c1.form_code = c.form_code
                                  And c1.action_code = p_action_code
                                  And c1.action_code = c.parent_action_code)
                       )
                    Or p_element_type Not In ('COLUMN_ACTIONS', 'ACTION_CHILD_ACTIONS')
                   );

            append_recs ();
         End;
      Elsif (p_element_type = 'ACTION') Then
         Begin
            --1.1.1.1.2.1.1. ACTION_PLSQL
            l_element_type    := 'ACTION_PLSQL';

            Select p_menu_code || l_ps || l_element_type As menu_code
                  , '<i>В работе! PL/SQL [<b>' || c.procedure_name || '</b>]</i>' As menu_name
                  ,p_menu_code As parent_menu_code, Null As menu_form_code, '' As form_display_stat
                  ,1 As menu_position, 11 As icon_id, 'Y' As is_folder, l_element_type As element_type
                  ,'Y' As show_in_navigator, 'N' As can_accept_drop, 'N' As can_drag, p_form_code As form_code
                  ,p_tab_code As tab_code, p_column_code As column_code, p_action_code As p_action_code
                  ,p_lookup_code As lookup_code
            Bulk Collect Into l_rec_tmp
              From form_actions c
             Where c.form_code = p_form_code
               And c.action_code = p_action_code
               And procedure_name Is Not Null;

            append_recs ();
            --1.1.1.1.2.1.2. ACTION_COLUMNS
            l_element_type    := 'ACTION_COLUMNS';

            Select   p_menu_code || l_ps || l_element_type As menu_code
                    , '<i>Колонки (триггеры) [<b>' || Count (Distinct c.column_code) || '</b>]</i>' As menu_name
                    ,p_menu_code As parent_menu_code, Null As menu_form_code
                    ,'FORM_COLUMN_ACTIONS' As form_display_stat, 2 As menu_position, 14 As icon_id, 'Y' As is_folder
                    ,l_element_type As element_type, 'Y' show_in_navigator, 'N' As can_accept_drop, 'N' As can_drag
                    ,p_form_code As form_code, p_tab_code As tab_code, p_column_code As column_code
                    ,p_action_code As p_action_code, p_lookup_code As lookup_code
            Bulk Collect Into l_rec_tmp
                From form_column_actions c
               Where c.form_code = p_form_code
                 And c.action_code = p_action_code
            Group By c.form_code, c.action_code
              Having Count (*) != 0;

            append_recs ();
            --1.1.1.1.2.1.3. ACTION_CHILD_FORM
            l_element_type    := 'FORM';                                                             --ACTION_CHILD_FORM

            Select p_menu_code || l_ps || l_element_type || l_vs || c.form_code As menu_code
                  , '<i>ChildForm: ' || f.form_name || '[<b>' || f.form_code || '</b>]</i>' As menu_name
                  ,p_menu_code As parent_menu_code                                                                     --
                  ,f.form_code As menu_form_code, Null As form_display_stat, 3 As menu_position
                  ,NVL (f.icon_id, Null) As icon_id, 'Y' As is_folder, l_element_type As element_type
                  ,'Y' As show_in_navigator, 'N' As can_accept_drop, 'N' As can_drag, f.form_code As form_code
                  ,'' As tab_code, '' As column_code, '' As p_action_code, '' As lookup_code
            Bulk Collect Into l_rec_tmp
              From form_actions c, forms f
             Where c.form_code = p_form_code
               And c.action_code = p_action_code
               And c.child_form_code = f.form_code;

            append_recs ();
            --1.1.1.1.2.1.4. ACTION_PARENT_ACTION
            l_element_type    := 'ACTION';                                                        --ACTION_PARENT_ACTION

            Select p_menu_code || l_ps || l_element_type || l_vs || p.action_code As menu_code
                  , '<i>ParentAction: ' || p.action_display_name || '[<b>' || p.action_code || '</b>]</i>' As menu_name
                  ,p_menu_code As parent_menu_code                                                                     --
                  ,'' As menu_form_code, 'FORM_ACTIONS' As form_display_stat, 3 As menu_position
                  ,NVL (p.icon_id, Null) As icon_id, 'Y' As is_folder, l_element_type As element_type
                  ,'Y' As show_in_navigator, 'N' As can_accept_drop, 'N' As can_drag, p_form_code As form_code
                  ,'' As tab_code, '' As column_code, p.action_code As p_action_code, '' As lookup_code
            Bulk Collect Into l_rec_tmp
              From form_actions c, form_actions p
             Where c.form_code = p_form_code
               And c.parent_action_code = p.action_code
               And c.action_code = p_action_code;

            append_recs ();
            --1.1.1.1.2.1.5. ACTION_CHILD_ACTIONS
            l_element_type    := 'ACTION_CHILD_ACTIONS';

            Select   p_menu_code || l_ps || l_element_type As menu_code
                    , '<i>ChildActions [<b>' || Count (Distinct c.action_code) || '</b>]</i>' As menu_name
                    ,p_menu_code As parent_menu_code, Null As menu_form_code, Null
                                                                                  --'FORM_ACTIONS'
                     As form_display_stat, 5 As menu_position, 14 As icon_id, 'Y' As is_folder
                    ,l_element_type As element_type, 'Y' show_in_navigator, 'N' As can_accept_drop, 'N' As can_drag
                    ,p_form_code As form_code, p_tab_code As tab_code, p_column_code As column_code
                    ,p_action_code As p_action_code, p_lookup_code As lookup_code
            Bulk Collect Into l_rec_tmp
                From form_actions c
               Where c.form_code = p_form_code
                 And c.parent_action_code = p_action_code
            Group By c.form_code, c.parent_action_code
              Having Count (*) != 0;

            append_recs ();
         End;
      Elsif (p_element_type = 'ACTION_PLSQL') Then
         Begin
            --
            l_element_type    := 'ACTION_PLSQL_PARAM';

            Select p_menu_code || l_ps || l_element_type || l_vs || p.argument_name As menu_code
                  ,    p.argument_name
                    || ' [<b>'
                    || DECODE (NVL (p.in_flag, 'N') || NVL (p.out_flag, 'N')
                              ,'YY', 'In/Out'
                              ,'YN', 'In'
                              ,'NN', 'In'
                              ,'NY', 'Out'
                              )
                    || '</b>] '
                    || p.data_type As menu_name
                  ,p_menu_code As parent_menu_code, Null As menu_form_code, '' As form_display_stat
                  ,p.Position As menu_position, 14 As icon_id, 'N' is_folder, l_element_type As element_type
                  ,'Y' As show_in_navigator, 'N' As can_accept_drop, 'N' As can_drag, p_form_code As form_code
                  ,p_tab_code As tab_code, p_column_code As column_code, p_action_code As p_action_code
                  ,p_lookup_code As lookup_code
            Bulk Collect Into l_rec_tmp
              From form_actions fa, Table (form_auth_cur_user_utlis_pkg.get_proc_args (fa.procedure_name)) p
             Where fa.form_code = p_form_code
               And fa.action_code = p_action_code;

            append_recs ();
         End;
      Elsif (p_element_type = 'TABS') Then
         Begin
            --1.1.1.1.1.1. TAB
            l_element_type    := 'TAB';                                                          --ACTION_CHILD_ACTIONS

            Select p_menu_code || l_ps || l_element_type || l_vs || c.tab_code As menu_code
                  , c.tab_name || ' [<b>' || c.tab_code || '</b>]' As menu_name, p_menu_code As parent_menu_code
                  ,Null As menu_form_code, 'FORM_TABS' As form_display_stat, c.tab_display_number As menu_position
                  ,c.icon_id As icon_id, 'Y' is_folder, l_element_type As element_type, 'Y' As show_in_navigator
                  ,'N' As can_accept_drop, 'N' As can_drag, c.form_code As form_code, c.tab_code As tab_code
                  ,p_column_code As column_code, p_action_code As p_action_code, p_lookup_code As lookup_code
            Bulk Collect Into l_rec_tmp
              From FORM_TABS c
             Where c.form_code = p_form_code;

            append_recs ();
         End;
      Elsif (p_element_type = 'TAB') Then
         Begin
            --1.1.1.1.1.1.1. TAB_CHILD_FORMS
            l_element_type    := 'TAB_CHILD_FORMS';

            With t As
                 (
                    Select t.child_form_code As form_code
                      From form_tabs t
                     Where t.form_code = p_form_code
                       And t.tab_code = p_tab_code
                       And t.child_form_code Is Not Null
                    Union
                    Select t.child_form_code As form_code
                      From FORM_TAB_CHILDS_ALLOWED t
                     Where t.form_code = p_form_code
                       And t.tab_code = p_tab_code)
            Select p_menu_code || l_ps || l_element_type As menu_code
                  , '<i>Дочерние формы [<b>' || Count (*) || '</b>]</i>' As menu_name, p_menu_code As parent_menu_code
                  ,Null As menu_form_code, '' As form_display_stat, 1 As menu_position, 11 As icon_id
                  ,DECODE (Count (*), 0, 'N', 'Y') As is_folder, l_element_type As element_type
                  ,'Y' As show_in_navigator, 'N' As can_accept_drop, 'N' As can_drag, p_form_code As form_code
                  ,p_tab_code As tab_code, p_column_code As column_code, p_action_code As p_action_code
                  ,p_lookup_code As lookup_code
            Bulk Collect Into l_rec_tmp
              From t;

            append_recs ();
            --1.1.1.1.1.1.2. TAB_PARENT_EXCLNS
            l_element_type    := 'TAB_PARENT_EXCLNS';

            Select p_menu_code || l_ps || l_element_type As menu_code
                  , '<i>Исключить для форм [<b>' || Count (*) || '</b>]</i>' As menu_name
                  ,p_menu_code As parent_menu_code, Null As menu_form_code
                  ,'FORM_TAB_PARENT_EXCLNS' As form_display_stat, 2 As menu_position, 14 As icon_id
                  ,DECODE (Count (*), 0, 'N', 'Y') As is_folder, l_element_type As element_type
                  ,'Y' As show_in_navigator, 'N' As can_accept_drop, 'N' As can_drag, p_form_code As form_code
                  ,p_tab_code As tab_code, p_column_code As column_code, p_action_code As p_action_code
                  ,p_lookup_code As lookup_code
            Bulk Collect Into l_rec_tmp
              From FORM_TAB_PARENT_EXCLNS c
             Where c.form_code = p_form_code
               And c.tab_code = p_tab_code;

            append_recs ();
            --1.1.1.1.1.1.3. TAB_COLUMNS
            l_element_type    := 'TAB_COLUMNS';

            Select p_menu_code || l_ps || l_element_type As menu_code
                  , '<i>Зависимые столбцы [<b>' || Count (*) || '</b>]</i>' menu_name, p_menu_code parent_menu_code
                  ,Null As menu_form_code, 'FORM_COLUMNS' form_display_stat, 3 menu_position, 14 icon_id
                  ,DECODE (Count (*), 0, 'N', 'Y') is_folder, l_element_type As element_type, 'Y' show_in_navigator
                  ,'N' As can_accept_drop, 'N' As can_drag, p_form_code As form_code, p_tab_code As tab_code
                  ,p_column_code As column_code, p_action_code As p_action_code, p_lookup_code As lookup_code
            Bulk Collect Into l_rec_tmp
              From FORM_columns c
             Where c.form_code = p_form_code
               And c.editor_tab_code = p_tab_code;

            append_recs ();
         End;
      Elsif (p_element_type In ('TAB_CHILD_FORMS', 'TAB_PARENT_EXCLNS')) Then
         Begin
            --1.1.1.1.1.1.1.1. FORM
            --1.1.1.1.1.1.2.1. FORM
            l_element_type    := 'FORM';

            With t As
                 (
                    Select t.child_form_code As form_code
                      From form_tabs t
                     Where t.form_code = p_form_code
                       And t.tab_code = p_tab_code
                       And p_element_type = 'TAB_CHILD_FORMS'
                       And t.child_form_code Is Not Null
                    Union
                    Select t.parent_form_code As form_code
                      From FORM_TAB_PARENT_EXCLNS t
                     Where t.form_code = p_form_code
                       And t.tab_code = p_tab_code
                       And p_element_type = 'TAB_PARENT_EXCLNS'
                    Union
                    Select t.child_form_code As form_code
                      From FORM_TAB_CHILDS_ALLOWED t
                     Where t.form_code = p_form_code
                       And t.tab_code = p_tab_code
                       And p_element_type = 'TAB_CHILD_FORMS')
                ,c As
                 (Select f.form_code, f.form_name, f.icon_id, ROW_NUMBER () Over (Order By f.form_code) As pos
                    From t, forms f
                   Where t.form_code = f.form_code)
            Select p_menu_code || l_ps || l_element_type || l_vs || c.form_code As menu_code
                  , c.form_name || ' [<b>' || c.form_code || '</b>]' As menu_name, p_menu_code As parent_menu_code
                  ,c.form_code As menu_form_code, Null As form_display_stat, c.pos As menu_position
                  ,NVL (c.icon_id, Null) As icon_id, 'Y' As is_folder, l_element_type As element_type
                  ,'Y' As show_in_navigator, 'N' As can_accept_drop, 'N' As can_drag, p_form_code As form_code
                  ,p_tab_code As tab_code, p_column_code As column_code, p_action_code As p_action_code
                  ,p_lookup_code As lookup_code
            Bulk Collect Into l_rec_tmp
              From c;

            append_recs ();
         End;
      Else
         Begin
            --1. FOLDER level 1
            --1.1. FOLDER level n
            --1.1.1. FORM
            Select m.menu_code, m.menu_name, m.parent_menu_code, m.menu_form_code, Null As form_display_stat
                  ,m.menu_position, NVL (f.icon_id, Null) As icon_id
                  ,DECODE (m.menu_form_code
                          ,Null, DECODE ((Select Count (*)
                                            From menus m2
                                           Where m2.parent_menu_code = m.menu_code), 0, 'N', 'Y')
                          ,'Y'
                          ) As is_folder
                  ,TO_CHAR (DECODE (m.menu_form_code, Null, 'FOLDER', 'FORM')) As element_type, m.show_in_navigator
                  ,DECODE (m.menu_form_code, Null, 'Y', 'N') As can_accept_drop, 'Y' As can_drag
                  ,p_form_code As form_code, p_tab_code As tab_code, p_column_code As column_code
                  ,p_action_code As p_action_code, p_lookup_code As lookup_code
            Bulk Collect Into l_rec_tmp
              From menus m Left Join forms f On f.form_code = m.menu_form_code
             Where NVL (m.parent_menu_code, '9999') = NVL (p_menu_code, '9999');

            append_recs ();
         End;
      End If;

      If     l_rec Is Not Null
         And l_rec.Count != 0 Then
         Declare
            ll_entity_code   Varchar2 (4000);
         Begin
            For i In l_rec.First .. l_rec.Last Loop
               --Отсекаем циклические ветки (в пути уже свтречалось имя данной сущности
               ll_entity_code    := Replace (l_rec (i).menu_code, l_rec (i).parent_menu_code);

               If     ll_entity_code Like '%' || l_vs || '%'
                  And l_rec (i).parent_menu_code Like '%' || ll_entity_code || '%' Then
                  l_rec (i).is_folder    := 'N';
                  l_rec (i).menu_name    := '' || l_rec (i).menu_name;
               End If;

               Pipe Row (l_rec (i));
            End Loop;
         End;
      End If;

      Return;
   End;
End;
/


-- End of DDL Script for Package FC22.MENUS_PKG

