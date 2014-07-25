CREATE OR REPLACE Package FC22.forms_pkg /*Authid Current_user*/ As
   Type form_md_r Is Record (
      form_code                  Varchar2 (255)
     ,hot_key                    Varchar2 (100)
     ,sql_text                   Clob
     ,sql_count_text             Clob
     ,form_name                  Varchar2 (255)
     ,form_type                  Varchar2 (1)
     ,show_tree_root_node        Varchar2 (1)
     ,icon_id                    Number
     ,form_width                 Varchar2 (30)
     ,form_height                Varchar2 (30)
     ,bottom_tabs_orientation    Varchar2 (2)
     ,side_tabs_orientation      Varchar2 (2)
     ,show_bottom_toolbar        Varchar2 (1)
     ,object_version_number      Number
     ,default_column_width       Varchar2 (30)
     ,description                Clob
     ,double_click_action_code   Varchar2 (255)
     ,lookup_width               Number
     ,lookup_height              Number
     ,dragdrop_action_code       Varchar2 (255)
     ,data_page_size             forms.data_page_size%Type
   );

   Type form_md_t Is Table Of form_md_r;

   Procedure p_insert_update (
      p_old_form_code                       forms.form_code%Type
     ,p_form_code                           forms.form_code%Type
     ,p_hot_key                             forms.hot_key%Type
     ,p_sql_text                            forms.sql_text%Type
     ,p_form_name                           forms.form_name%Type
     ,p_description                         forms.description%Type
     ,p_form_type                  In Out   forms.form_type%Type
     ,p_show_tree_root_node        In Out   forms.show_tree_root_node%Type
     ,p_icon_id                             forms.icon_id%Type
     ,p_form_width                 In Out   forms.form_width%Type
     ,p_form_height                In Out   forms.form_height%Type
     ,p_bottom_tabs_orientation             forms.bottom_tabs_orientation%Type
     ,p_side_tabs_orientation               forms.side_tabs_orientation%Type
     ,p_show_bottom_toolbar                 forms.show_bottom_toolbar%Type
     ,p_default_column_width       In Out   forms.default_column_width%Type
     ,p_object_version_number      Out      forms.object_version_number%Type
     ,p_double_click_action_code   In Out   forms.double_click_action_code%Type
     ,p_dragdrop_action_code       In Out   forms.double_click_action_code%Type
     ,p_lookup_width               In Out   forms.lookup_width%Type
     ,p_lookup_height              In Out   forms.lookup_height%Type
     ,p_apps_code                  In Out   forms.apps_code%Type
     ,p_export_order               In Out   forms.export_order%Type
     ,p_data_page_size             In Out   forms.data_page_size%Type
   );

   Procedure generate_package (p_form_code forms.form_code%Type);

   Function get_form_md (
      p_form_code          Varchar2
     ,p_master_form_code   Varchar2 Default Null
     ,p_drilldown_flag     Varchar2 Default Null
   )
      Return form_md_t Pipelined;

   Function get_form_md_tmp (p_form_code Varchar2)
      Return Varchar2;
End FORMS_PKG;
/
CREATE OR REPLACE PACKAGE BODY FC22.FORMS_PKG As
   Procedure p_insert_update (
      p_old_form_code                       forms.form_code%Type
     ,p_form_code                           forms.form_code%Type
     ,p_hot_key                             forms.hot_key%Type
     ,p_sql_text                            forms.sql_text%Type
     ,p_form_name                           forms.form_name%Type
     ,p_description                         forms.description%Type
     ,p_form_type                  In Out   forms.form_type%Type
     ,p_show_tree_root_node        In Out   forms.show_tree_root_node%Type
     ,p_icon_id                             forms.icon_id%Type
     ,p_form_width                 In Out   forms.form_width%Type
     ,p_form_height                In Out   forms.form_height%Type
     ,p_bottom_tabs_orientation             forms.bottom_tabs_orientation%Type
     ,p_side_tabs_orientation               forms.side_tabs_orientation%Type
     ,p_show_bottom_toolbar                 forms.show_bottom_toolbar%Type
     ,p_default_column_width       In Out   forms.default_column_width%Type
     ,p_object_version_number      Out      forms.object_version_number%Type
     ,p_double_click_action_code   In Out   forms.double_click_action_code%Type
     ,p_dragdrop_action_code       In Out   forms.double_click_action_code%Type
     ,p_lookup_width               In Out   forms.lookup_width%Type
     ,p_lookup_height              In Out   forms.lookup_height%Type
     ,p_apps_code                  In Out   forms.apps_code%Type
     ,p_export_order               In Out   forms.export_order%Type
     ,p_data_page_size             In Out   forms.data_page_size%Type
   ) Is
   Begin
      --еще - см. триггер на табличке
      form_utils.check_nulls (args_t (p_form_code), args_t ('Не указан код формы'));

      Update forms a
         Set a.hot_key = p_hot_key
            ,a.sql_text = p_sql_text
            ,a.form_name = p_form_name
            ,a.description = p_description
            ,a.form_type = p_form_type
            ,a.show_tree_root_node = p_show_tree_root_node
            ,a.icon_id = p_icon_id
            ,a.form_width = p_form_width
            ,a.form_height = p_form_height
            ,a.bottom_tabs_orientation = p_bottom_tabs_orientation
            ,a.side_tabs_orientation = p_side_tabs_orientation
            ,a.show_bottom_toolbar = p_show_bottom_toolbar
            ,a.object_version_number = a.object_version_number + 1
            ,a.default_column_width = p_default_column_width
            ,a.double_click_action_code = p_double_click_action_code
            ,a.lookup_width = p_lookup_width
            ,a.lookup_height = p_lookup_height
            ,a.apps_code = p_apps_code
            ,a.export_order = p_export_order
            ,a.dragdrop_action_code = p_dragdrop_action_code
            ,a.data_page_size = p_data_page_size
       Where a.form_code = p_form_code;

      If Sql%Rowcount = 0 Then
         Insert Into forms
                     (form_code, hot_key, sql_text, form_name, description, form_type, show_tree_root_node, icon_id
                     ,form_width, form_height, bottom_tabs_orientation, side_tabs_orientation, show_bottom_toolbar
                     ,default_column_width, object_version_number, double_click_action_code, lookup_width
                     ,lookup_height, apps_code, export_order, dragdrop_action_code, data_page_size)
              Values (p_form_code, p_hot_key, p_sql_text, p_form_name, p_description, p_form_type
                     ,p_show_tree_root_node, p_icon_id, p_form_width, p_form_height, p_bottom_tabs_orientation
                     ,p_side_tabs_orientation, p_show_bottom_toolbar, p_default_column_width, 1
                     ,p_double_click_action_code, p_lookup_width, p_lookup_height, p_apps_code, p_export_order
                     ,p_dragdrop_action_code, p_data_page_size)
           Returning object_version_number
                Into p_object_version_number;

         Null;
      End If;
   End p_insert_update;

   Procedure generate_package (p_form_code forms.form_code%Type) Is
      l_proc_param   Varchar2 (4000);
      l_upd_set      Varchar2 (4000);
      l_into_cl      Varchar2 (4000);
      l_val_cl       Varchar2 (4000);
      l_proc_def     Varchar2 (4000);
   Begin
      Select   SUBSTR (Replace (stragg (LOWER (   ',p_'
                                               || column_code
                                               || ' in out '
                                               || p_form_code
                                               || '.'
                                               || column_code
                                               || '%type'
                                              )
                                       )
                               ,' / '
                               ,CHR (10)
                               )
                      ,2
                      ) proc_param
              ,SUBSTR (Replace (stragg (LOWER (',' || column_code || ' = ' || 'p_' || column_code)), ' / ', CHR (10))
                      ,2
                      ) upd_set
              ,SUBSTR (Replace (stragg (LOWER (',' || column_code)), ' / ', CHR (10)), 2) into_cl
              ,SUBSTR (Replace (stragg (LOWER (',p_' || column_code)), ' / ', CHR (10)), 2) val_cl
          Into l_proc_param, l_upd_set, l_into_cl, l_val_cl
          From Table (form_utils.describe_form_columns_pl (p_form_code))
      Order By form_code, column_display_number, column_code;

      l_proc_def    := 'procedure p_update(' || l_proc_param || ')';
      DBMS_OUTPUT.put_line (l_proc_def);
   End generate_package;

   Function get_form_md (
      p_form_code          Varchar2
     ,p_master_form_code   Varchar2 Default Null
     ,p_drilldown_flag     Varchar2 Default Null
   )
      Return form_md_t Pipelined Is
      l_row    form_md_r;
      l_clob   Clob;
   Begin
      DBMS_APPLICATION_INFO.set_action ('FMD,FORM:' || p_form_code);

      /*!!! TODO Проблема  - SQL_TEXT Varchar2(2000)*/
      /*!!! TODO Проблема  - Authid Current_user */
      For cr In (Select a.form_code, a.hot_key, l_clob || a.sql_text, l_clob || a.sql_count_text, a.form_name, a.form_type, a.show_tree_root_node
                       ,a.icon_id, a.form_width, a.form_height, a.bottom_tabs_orientation, a.side_tabs_orientation
                       ,a.show_bottom_toolbar, a.object_version_number, a.default_column_width, a.description
                       ,a.double_click_action_code, a.lookup_width, a.lookup_height, a.dragdrop_action_code
                       ,a.data_page_size
                   From forms_v a
                  Where a.form_code = p_form_code) Loop
         l_row    := cr;

         If (   (    p_form_code = p_master_form_code
                 And 'Y' = p_drilldown_flag)
             Or (    p_form_code = 'INS_INS_INSURED'
                 And p_master_form_code = 'INS_INS_VISITS')
            ) Then
            l_row.form_width     := '0%';
            l_row.form_height    := '0%';
         End If;

         Pipe Row (l_row);
      End Loop;

      --DBMS_APPLICATION_INFO.set_action ('');
      Return;
   Exception
      When Others Then
         DBMS_OUTPUT.put_line (SQLERRM);
         Return;
   End get_form_md;

   Function get_form_md_tmp (p_form_code Varchar2)
      Return Varchar2 Is
      l_clob   Clob;
      l_cnt    Number := 0;
   Begin
      For cr In (Select a.form_code, a.hot_key, l_clob || a.sql_text, a.form_name, a.form_type, a.show_tree_root_node
                       ,a.icon_id, a.form_width, a.form_height, a.bottom_tabs_orientation, a.side_tabs_orientation
                       ,a.show_bottom_toolbar, a.object_version_number, a.default_column_width, a.description
                       ,a.double_click_action_code, a.lookup_width
                   From forms_v a
                  Where a.form_code = p_form_code) Loop
         Null;
         l_cnt    := l_cnt + 1;
      End Loop;

      Return l_cnt;
   End;
End FORMS_PKG;
/
