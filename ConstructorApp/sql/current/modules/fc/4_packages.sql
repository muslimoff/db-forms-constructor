DROP PACKAGE applications_pkg
/

CREATE OR REPLACE 
PACKAGE applications_pkg As
   --���� �� �������� - ����� ��������� ������������ ������
   Procedure create_new_application (p_schema_name In Varchar2, p_tablespace_name In Varchar2 Default 'FC');

   Function get_fc_schema
      Return Varchar2;
End applications_pkg;
/

GRANT EXECUTE ON applications_pkg TO fc_admin
/

CREATE OR REPLACE 
PACKAGE BODY applications_pkg As
   g_fc_schema   Varchar2 (30);

   Function get_fc_schema
      Return Varchar2 Is
-- ������� ���������� ��� �����
      Result   Varchar2 (30);
   Begin
/*      Select username
        Into Result
        From user_users
       Where user_id = USERENV ('SCHEMAID');

      Return Result;*/
      Return g_fc_schema;
   End;

   Procedure create_new_application (p_schema_name In Varchar2, p_tablespace_name In Varchar2 Default 'FC') Is
   Begin
      Execute Immediate    'Create USER '
                        || p_schema_name
                        || ' Identified By '
                        || p_schema_name
                        || ' DEFAULT Tablespace '
                        || p_tablespace_name
                        || ' Temporary Tablespace temp';

      Null;
   End;
Begin
   Select username
     Into g_fc_schema
     From user_users
    Where user_id = USERENV ('SCHEMAID');
End applications_pkg;
/

DROP PACKAGE apps_role_menus_pkg
/

CREATE OR REPLACE 
PACKAGE apps_role_menus_pkg As
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

GRANT EXECUTE ON apps_role_menus_pkg TO fc_admin
/

CREATE OR REPLACE 
PACKAGE BODY apps_role_menus_pkg As
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
   Begin
      If users_pkg.get_user_id = -1 Then
         For cr In (With m As
                         (
                            Select NVL2 (a.Rowid, a.menu_code, f.form_code) As menu_code, a.menu_name As menu_name
                                  ,NVL2 (a.Rowid, a.parent_menu_code, 'XXX') As parent_menu_code, a.menu_position
                                  ,NVL (a.show_in_navigator, 'Y') As show_in_navigator, f.icon_id, f.hot_key
                                  ,f.form_code, NVL (f.form_name, f.form_code) As form_name, f.description
                              From menus a Full Outer Join forms f On a.menu_form_code = f.form_code
                            Union All
                            Select 'XXX' As menu_code, '������' As menu_name, Null As parent_menu_code
                                  ,Null As menu_position, 'Y' As show_in_navigator, Null As icon_id, Null As hot_key
                                  ,'XXXX' As form_code, 'XXXXX' As form_name, Null As description
                              From DUAL)
                    Select     Level lvl, m.menu_code, m.parent_menu_code, m.menu_position, m.show_in_navigator
                              ,NVL (NVL (m.menu_name, m.form_name), m.menu_code) As menu_name, m.form_code
                              ,m.form_name, m.icon_id, m.hot_key, (Select                 --�������� � CLOB
                                                                          description
                                                                     From forms f
                                                                    Where f.form_code = m.form_code) description
                              , (Select Count (*)
                                   From m m1
                                  Where m1.parent_menu_code = m.menu_code) child_count
                          From m
                    Connect By Prior m.menu_code = m.parent_menu_code
                    Start With m.parent_menu_code Is Null
                      --ORDER SIBLINGS BY   m.parent_menu_code, m.menu_position, menu_name
                    Order By   lvl, m.parent_menu_code, m.menu_position, menu_name) Loop
            Pipe Row (cr);
         End Loop;
      Else
         For cr In (With t1 As
                         (
                            Select aru.app_role_user_id, aru.role_code, aru.apps_code, aru.user_id, ar.role_name
                                  ,ar.root_menu_code
                              From apps_role_users aru, apps_roles ar
                             Where aru.user_id = users_pkg.get_user_id
                               And ar.role_code = aru.role_code
                               And ar.apps_code = aru.apps_code)
                        ,t2 As
                         (
                            Select m.menu_code
                                  ,NVL (m.parent_menu_code, t1.role_code || '_' || t1.apps_code) As parent_menu_code
                                  ,m.Position, m.enabled_flag
                                  ,NVL (NVL (NVL (m.display_name, f.form_name), t1.role_name)
                                       ,m.menu_code
                                       ) As display_name
                                  ,f.form_code, f.form_name, f.icon_id, f.hot_key, f.description
                              From apps_role_menus m Left Join t1 On t1.root_menu_code = m.menu_code
                                   Left Join forms f On f.form_code = m.form_code
                             Where 'Y' = m.enabled_flag
                            Union All
                            Select t1.role_code || '_' || t1.apps_code As menu_code, Null As parent_menu_code
                                  ,Null As Position, 'Y' As enabled_flag, t1.role_name As display_name
                                  ,Null As form_code, Null As form_name, Null As icon_id, Null As hot_key
                                  ,Null As description
                              From t1)
                    Select     Level lvl, menu_code, parent_menu_code, Position, enabled_flag, display_name, form_code
                              ,form_name, icon_id, hot_key, description
                              , (Select Count (*)
                                   From t2 x
                                  Where y.menu_code = x.parent_menu_code) child_count
                          From t2 y
                    Start With parent_menu_code Is Null
                    Connect By Prior menu_code = parent_menu_code
                      Order Siblings By Position, display_name, menu_code) Loop
            Pipe Row (cr);
         End Loop;
      End If;

      Return;
   End get_menu_list;
End apps_role_menus_pkg;
/

DROP PACKAGE apps_role_users_pkg
/

CREATE OR REPLACE 
PACKAGE apps_role_users_pkg As
   Procedure p_ins_upd (
      p_app_role_user_id   In Out   Number
     ,p_role_code          In Out   Varchar2
     ,p_apps_code          In Out   Varchar2
     ,p_user_id            In Out   Number
   );

   Procedure p_delete (p_app_role_user_id In Out Number);
End apps_role_users_pkg;
/


CREATE OR REPLACE 
PACKAGE BODY apps_role_users_pkg As
   Procedure p_ins_upd (
      p_app_role_user_id   In Out   Number
     ,p_role_code          In Out   Varchar2
     ,p_apps_code          In Out   Varchar2
     ,p_user_id            In Out   Number
   ) Is
   Begin
      Update apps_role_users
         Set role_code = p_role_code
            ,apps_code = p_apps_code
            ,user_id = p_user_id
       Where app_role_user_id = p_app_role_user_id;

      If Sql%Rowcount = 0 Then
         Select main_sq.Nextval
           Into p_app_role_user_id
           From DUAL;

         Insert Into apps_role_users
                     (app_role_user_id, role_code, apps_code, user_id)
              Values (p_app_role_user_id, p_role_code, p_apps_code, p_user_id);
      End If;
   End p_ins_upd;

   Procedure p_delete (p_app_role_user_id In Out Number) Is
   Begin
      Delete From apps_role_users
            Where app_role_user_id = p_app_role_user_id;
   End p_delete;
End apps_role_users_pkg;
/

DROP PACKAGE apps_roles_pkg
/

CREATE OR REPLACE 
PACKAGE apps_roles_pkg As
   Procedure p_ins_upd (
      p_apps_role_id     In Out   Number
     ,p_role_code        In Out   Varchar2
     ,p_role_name        In Out   Varchar2
     ,p_apps_code        In Out   Varchar2
     ,p_root_menu_code   In Out   Varchar2
   );

   Procedure p_delete (p_apps_role_id In Out Number);
End apps_roles_pkg;
/


CREATE OR REPLACE 
PACKAGE BODY apps_roles_pkg As
   Procedure p_ins_upd (
      p_apps_role_id     In Out   Number
     ,p_role_code        In Out   Varchar2
     ,p_role_name        In Out   Varchar2
     ,p_apps_code        In Out   Varchar2
     ,p_root_menu_code   In Out   Varchar2
   ) Is
   Begin
      Update apps_roles
         Set role_code = p_role_code
            ,role_name = p_role_name
            ,apps_code = p_apps_code
            ,root_menu_code = p_root_menu_code
       Where apps_role_id = p_apps_role_id;

      If Sql%Rowcount = 0 Then
         Select main_sq.Nextval
           Into p_apps_role_id
           From DUAL;

         Insert Into apps_roles
                     (apps_role_id, role_code, role_name, apps_code, root_menu_code)
              Values (p_apps_role_id, p_role_code, p_role_name, p_apps_code, p_root_menu_code);
      End If;
   End p_ins_upd;

   Procedure p_delete (p_apps_role_id In Out Number) Is
   Begin
      Delete From apps_roles
            Where apps_role_id = p_apps_role_id;
   End p_delete;
End apps_roles_pkg;
/

DROP PACKAGE form_actions_pkg
/

CREATE OR REPLACE 
PACKAGE form_actions_pkg Is
   -- Author  : V.SAFRONOV
   -- Created : 23.12.2009 11:05:23
   -- Purpose :

   -- Public type declarations
   Procedure p_ins_upd (
      p_form_code                  form_actions.form_code%Type
     ,p_action_code                form_actions.action_code%Type
     ,p_procedure_name             form_actions.procedure_name%Type
     ,p_action_display_name        form_actions.action_display_name%Type
     ,p_icon_id                    form_actions.icon_id%Type
     ,p_default_param_prefix       form_actions.default_param_prefix%Type
     ,p_default_old_param_prefix   form_actions.default_old_param_prefix%Type
     ,p_action_type                form_actions.action_type%Type
     ,p_confirm_text               form_actions.confirm_text%Type
     ,p_display_number             form_actions.display_number%Type
     ,p_hot_key                    form_actions.hot_key%Type
     ,p_show_separator_below       form_actions.show_separator_below%Type
     ,p_display_on_toolbar         form_actions.display_on_toolbar%Type
     ,p_child_form_code            form_actions.child_form_code%Type
   );

   Procedure p_delete (p_form_code form_actions.form_code%Type, p_action_code form_actions.action_code%Type);
End FORM_ACTIONS_PKG;
/

GRANT EXECUTE ON form_actions_pkg TO fc_admin
/

CREATE OR REPLACE 
PACKAGE BODY form_actions_pkg Is
   Procedure p_ins_upd (
      p_form_code                  form_actions.form_code%Type
     ,p_action_code                form_actions.action_code%Type
     ,p_procedure_name             form_actions.procedure_name%Type
     ,p_action_display_name        form_actions.action_display_name%Type
     ,p_icon_id                    form_actions.icon_id%Type
     ,p_default_param_prefix       form_actions.default_param_prefix%Type
     ,p_default_old_param_prefix   form_actions.default_old_param_prefix%Type
     ,p_action_type                form_actions.action_type%Type
     ,p_confirm_text               form_actions.confirm_text%Type
     ,p_display_number             form_actions.display_number%Type
     ,p_hot_key                    form_actions.hot_key%Type
     ,p_show_separator_below       form_actions.show_separator_below%Type
     ,p_display_on_toolbar         form_actions.display_on_toolbar%Type
     ,p_child_form_code            form_actions.child_form_code%Type
   ) As
   Begin
      form_utils.check_nulls (args_t (p_form_code, p_action_code)
                             ,args_t ('�� ������ ��� �����', '�� ������ ��� ��������')
                             );

      Update form_actions fa
         Set fa.form_code = p_form_code
            ,fa.action_code = p_action_code
            ,fa.procedure_name = p_procedure_name
            ,fa.action_display_name = p_action_display_name
            ,fa.icon_id = p_icon_id
            ,fa.default_param_prefix = p_default_param_prefix
            ,fa.default_old_param_prefix = p_default_old_param_prefix
            ,fa.action_type = p_action_type
            ,fa.confirm_text = p_confirm_text
            ,fa.display_number = p_display_number
            ,hot_key = p_hot_key
            ,show_separator_below = p_show_separator_below
            ,display_on_toolbar = p_display_on_toolbar
            ,child_form_code = p_child_form_code
       Where fa.form_code = p_form_code
         And fa.action_code = p_action_code;

      If Sql%Rowcount = 0 Then
         Insert Into form_actions fao
                     (form_code, action_code, procedure_name, action_display_name, icon_id, default_param_prefix
                     ,default_old_param_prefix, action_type, display_number, hot_key, show_separator_below
                     ,display_on_toolbar, child_form_code)
              Values (p_form_code, p_action_code, p_procedure_name, p_action_display_name, p_icon_id
                     ,p_default_param_prefix, p_default_old_param_prefix, p_action_type, p_display_number, p_hot_key
                     ,p_show_separator_below, p_display_on_toolbar, p_child_form_code);
      End If;

      Update forms f
         Set f.object_version_number = f.object_version_number + 1
       Where f.form_code = p_form_code;
   End p_ins_upd;

   Procedure p_delete (p_form_code form_actions.form_code%Type, p_action_code form_actions.action_code%Type) As
   Begin
      Delete From form_actions fao
            Where fao.form_code = p_form_code
              And fao.action_code = p_action_code;

      Update forms f
         Set f.object_version_number = f.object_version_number + 1
       Where f.form_code = p_form_code;
   End p_delete;
End FORM_ACTIONS_PKG;
/

DROP PACKAGE form_auth_cur_user_utlis_pkg
/

CREATE OR REPLACE 
PACKAGE form_auth_cur_user_utlis_pkg Authid Current_user As
   Type arguments_r Is Record (
      Position        all_arguments.Position%Type
     ,argument_name   Varchar2 (2000)
     ,in_flag         Varchar2 (1)
     ,out_flag        Varchar2 (1)
     ,data_type       Varchar2 (2000)
   );

   Type arguments_t Is Table Of arguments_r;

   Function get_proc_args (p_procedure_name Varchar2)
      Return arguments_t Pipelined;

   Function describe_columns (p_sql_text Varchar2, p_form_code Varchar2 Default Null)
      Return DBMS_SQL.desc_tab;
End form_auth_cur_user_utlis_pkg;
/

GRANT EXECUTE ON form_auth_cur_user_utlis_pkg TO fc_admin
/

CREATE OR REPLACE 
PACKAGE BODY form_auth_cur_user_utlis_pkg As
   Function get_proc_args (p_procedure_name Varchar2)
      Return arguments_t Pipelined Is
      l_procedure_name   Varchar2 (2000) := p_procedure_name;
      l_owner            Varchar2 (2000);
      l_package_name     Varchar2 (2000);
      l_object_name      Varchar2 (2000);
      l_res              arguments_r;
   Begin
      DBMS_OUTPUT.put_line (SUBSTR ('Value of l_procedure_name=' || l_procedure_name, 1, 255));
      l_procedure_name    := form_utils.replace_user_variables (l_procedure_name);
      DBMS_OUTPUT.put_line (SUBSTR ('Value of l_procedure_name=' || l_procedure_name, 1, 255));
      l_owner             := UPPER (text_utils_pkg.word (l_procedure_name, -3, 1, '.'));
      l_package_name      := UPPER (text_utils_pkg.word (l_procedure_name, -2, 1, '.'));
      l_object_name       := UPPER (text_utils_pkg.word (l_procedure_name, -1, 1, '.'));
      l_owner             := NVL (l_owner, User);
      DBMS_OUTPUT.put_line (SUBSTR ('Value of l_owner=' || l_owner, 1, 255));
      DBMS_OUTPUT.put_line (SUBSTR ('Value of l_package_name=' || l_package_name, 1, 255));
      DBMS_OUTPUT.put_line (SUBSTR ('Value of l_object_name=' || l_object_name, 1, 255));

      For cr In (Select   a.Position, a.argument_name, DECODE (a.in_out, 'IN/OUT', 'Y', 'IN', 'Y') in_flag
                         ,DECODE (a.in_out, 'IN/OUT', 'Y', 'OUT', 'Y') out_flag, a.data_type
                     From all_arguments a
                    Where a.package_name = l_package_name
                      And a.object_name = l_object_name
                      And a.owner = l_owner
                      And a.Position != 0
                      And a.argument_name Is Not Null
                 Order By a.Position, a.Sequence) Loop
         l_res.Position         := cr.Position;
         l_res.argument_name    := cr.argument_name;
         l_res.in_flag          := cr.in_flag;
         l_res.out_flag         := cr.out_flag;
         l_res.data_type        :=
            Case
               When cr.data_type = 'NUMBER' Then 'N'
               When cr.data_type = 'VARCHAR2' Then 'S'
               When cr.data_type = 'CHAR' Then 'S'
               When cr.data_type = 'DATE' Then 'D'
               Else cr.data_type
            End;
         Pipe Row (l_res);
      End Loop;

      Return;
   End;

   Function describe_columns (p_sql_text Varchar2, p_form_code Varchar2 Default Null)
      Return DBMS_SQL.desc_tab Is
      cur          Number;
      col_count    Pls_integer;
      l_result     DBMS_SQL.desc_tab;
      l_sql_text   Varchar2 (4000)   := form_utils.get_extended_sql_text (p_sql_text);
   Begin
--      raise_application_error (-20001, 'User:' || User);
      cur    := DBMS_SQL.open_cursor;
      DBMS_SQL.parse (cur, l_sql_text, DBMS_SQL.native);
      DBMS_SQL.describe_columns (cur, col_count, l_result);
      /* �������� � Oracle 9.2 - ��� ������� v$sql_cursor.child_handle - ����� �� ������ ������ ��� �������������
            For Binds In (Select Distinct p_form_code form_code, m.Position, get_datatype_as_string (m.datatype) datatype
                                         --
                                          ,m.max_length, m.array_len, m.bind_name
                                     From v$sql_bind_metadata m, v$sql_cursor c
                                    Where c.child_handle = m.address
                                      And c.curno = cur
                                 Order By m.Position) Loop
               g_bind_variables (Binds.form_code || Binds.Position)    := Binds;
            End Loop;
      */
      DBMS_SQL.close_cursor (cur);
      Return l_result;
   Exception
      When Others Then
         DBMS_OUTPUT.put_line (SQLERRM);
         DBMS_OUTPUT.put_line (SUBSTR ('Value of l_sql_text=' || l_sql_text, 1, 255));

         If DBMS_SQL.is_open (cur) Then
            DBMS_SQL.close_cursor (cur);
         End If;

         l_result.Delete;
--TODO
--         Raise;
         Return l_result;
   End describe_columns;
End form_auth_cur_user_utlis_pkg;
/

DROP PACKAGE form_column_actions_pkg
/

CREATE OR REPLACE 
PACKAGE form_column_actions_pkg As
   Procedure p_ins_upd (
      p_form_column_action_id   In Out   Number
     ,p_form_code               In Out   Varchar2
     ,p_column_code             In Out   Varchar2
     ,p_action_code             In Out   Varchar2
     ,p_action_key_code         In Out   Varchar2
     ,p_col_action_type_code    In Out   Varchar2
   );

   Procedure p_delete (
      p_form_column_action_id   In Out   Number
     ,p_form_code               In Out   Varchar2
     ,p_column_code             In Out   Varchar2
     ,p_action_code             In Out   Varchar2
     ,p_action_key_code         In Out   Varchar2
     ,p_col_action_type_code    In Out   Varchar2
   );
End form_column_actions_pkg;
/

GRANT EXECUTE ON form_column_actions_pkg TO fc_admin
/

CREATE OR REPLACE 
PACKAGE BODY form_column_actions_pkg As
   Procedure p_ins_upd (
      p_form_column_action_id   In Out   Number
     ,p_form_code               In Out   Varchar2
     ,p_column_code             In Out   Varchar2
     ,p_action_code             In Out   Varchar2
     ,p_action_key_code         In Out   Varchar2
     ,p_col_action_type_code    In Out   Varchar2
   ) Is
   Begin
      Update form_column_actions
         Set form_code = p_form_code
            ,column_code = p_column_code
            ,action_code = p_action_code
            ,action_key_code = p_action_key_code
            ,col_action_type_code = p_col_action_type_code
       Where form_column_action_id = p_form_column_action_id;

      If Sql%Rowcount = 0 Then
         Select main_sq.Nextval
           Into p_form_column_action_id
           From DUAL;

         Insert Into form_column_actions
                     (form_column_action_id, form_code, column_code, action_code, action_key_code
                     ,col_action_type_code)
              Values (p_form_column_action_id, p_form_code, p_column_code, p_action_code, p_action_key_code
                     ,p_col_action_type_code);
      End If;
   End p_ins_upd;

   Procedure p_delete (
      p_form_column_action_id   In Out   Number
     ,p_form_code               In Out   Varchar2
     ,p_column_code             In Out   Varchar2
     ,p_action_code             In Out   Varchar2
     ,p_action_key_code         In Out   Varchar2
     ,p_col_action_type_code    In Out   Varchar2
   ) Is
   Begin
      Delete From form_column_actions
            Where form_column_action_id = p_form_column_action_id;
   End p_delete;
End form_column_actions_pkg;
/

DROP PACKAGE form_column_attr_vals_pkg
/

CREATE OR REPLACE 
PACKAGE form_column_attr_vals_pkg As
   Procedure p_ins_upd (
      p_form_column_attr_val_id   In Out   Number
     ,p_form_code                 In Out   Varchar2
     ,p_column_code               In Out   Varchar2
     ,p_attribute_code            In Out   Varchar2
     ,p_attribute_value           In Out   Varchar2
   );

   Procedure p_delete (
      p_form_column_attr_val_id   In Out   Number
     ,p_form_code                 In Out   Varchar2
     ,p_column_code               In Out   Varchar2
     ,p_attribute_code            In Out   Varchar2
     ,p_attribute_value           In Out   Varchar2
   );
End FORM_COLUMN_ATTR_VALS_PKG;
/

GRANT EXECUTE ON form_column_attr_vals_pkg TO fc_admin
/

CREATE OR REPLACE 
PACKAGE BODY form_column_attr_vals_pkg As
   Procedure p_ins_upd (
      p_form_column_attr_val_id   In Out   Number
     ,p_form_code                 In Out   Varchar2
     ,p_column_code               In Out   Varchar2
     ,p_attribute_code            In Out   Varchar2
     ,p_attribute_value           In Out   Varchar2
   ) Is
   Begin
      Update form_column_attr_vals
         Set form_code = p_form_code
            ,column_code = p_column_code
            ,attribute_code = p_attribute_code
            ,attribute_value = p_attribute_value
       Where form_column_attr_val_id = p_form_column_attr_val_id;

      If Sql%Rowcount = 0 Then
         Select main_sq.Nextval
           Into p_form_column_attr_val_id
           From DUAL;

         Insert Into form_column_attr_vals
                     (form_column_attr_val_id, form_code, column_code, attribute_code, attribute_value)
              Values (p_form_column_attr_val_id, p_form_code, p_column_code, p_attribute_code, p_attribute_value);
      End If;
   End p_ins_upd;

   Procedure p_delete (
      p_form_column_attr_val_id   In Out   Number
     ,p_form_code                 In Out   Varchar2
     ,p_column_code               In Out   Varchar2
     ,p_attribute_code            In Out   Varchar2
     ,p_attribute_value           In Out   Varchar2
   ) Is
   Begin
      Delete From form_column_attr_vals
            Where form_column_attr_val_id = p_form_column_attr_val_id;
   End p_delete;
End FORM_COLUMN_ATTR_VALS_PKG;
/

DROP PACKAGE form_columns_pkg
/

CREATE OR REPLACE 
PACKAGE form_columns_pkg As
   Procedure p_delete (p_form_code form_columns.form_code%Type, p_column_code form_columns.column_code%Type);

   Procedure p_ins_upd (
      p_form_code                          form_columns.form_code%Type
     ,p_column_code                        form_columns.column_code%Type
     ,p_column_user_name                   form_columns.column_user_name%Type
     ,p_column_display_size                form_columns.column_display_size%Type
     ,p_column_display_number              form_columns.column_display_number%Type
     ,p_pimary_key_flag                    form_columns.pimary_key_flag%Type
     ,p_show_on_grid                       form_columns.show_on_grid%Type
     ,p_tree_field_type                    form_columns.tree_field_type%Type
     ,p_editor_tab_code                    form_columns.editor_tab_code%Type
     ,p_field_type                         form_columns.field_type%Type
     ,p_column_description                 form_columns.column_description%Type
     ,p_is_frozen_flag                     form_columns.is_frozen_flag%Type
     ,p_show_hover_flag                    form_columns.show_hover_flag%Type
     ,p_column_data_type                   form_columns.column_data_type%Type
     ,p_exists_in_metadata_flag      Out   Varchar2
     ,p_lookup_code                        form_columns.lookup_code%Type
     ,p_hover_column_code                  form_columns.hover_column_code%Type
     ,p_editor_height                      form_columns.editor_height%Type
     ,p_lookup_field_type                  form_columns.lookup_field_type%Type
     ,p_help_text                          form_columns.help_text%Type
     ,p_text_mask                          form_columns.text_mask%Type
     ,p_validation_regexp                  form_columns.validation_regexp%Type
     ,p_default_orderby_number             form_columns.default_orderby_number%Type
     ,p_default_value                      form_columns.DEFAULT_VALUE%Type
     ,p_editor_title_orientation           form_columns.editor_title_orientation%Type
     ,p_editor_cols_span                   form_columns.editor_cols_span%Type
     ,p_editor_end_row_flag                form_columns.editor_end_row_flag%Type
     ,p_lookup_display_value               form_columns.lookup_display_value%Type
     ,p_editor_on_enter_key_action         form_columns.editor_on_enter_key_action%Type
   );
End;
/

GRANT EXECUTE ON form_columns_pkg TO fc_admin
/

CREATE OR REPLACE 
PACKAGE BODY form_columns_pkg As
   /*
   SELECT a.form_code, a.column_code, a.column_user_name,
          a.column_display_size, a.column_data_type,
          a.column_display_number, a.pimary_key_flag, a.show_on_grid,
          a.tree_initialization_value, a.tree_field_type,
          a.editor_tab_code, a.field_type, a.column_description
     FROM form_columns a
   */
   Procedure p_ins_upd (
      p_form_code                          form_columns.form_code%Type
     ,p_column_code                        form_columns.column_code%Type
     ,p_column_user_name                   form_columns.column_user_name%Type
     ,p_column_display_size                form_columns.column_display_size%Type
     ,p_column_display_number              form_columns.column_display_number%Type
     ,p_pimary_key_flag                    form_columns.pimary_key_flag%Type
     ,p_show_on_grid                       form_columns.show_on_grid%Type
     ,p_tree_field_type                    form_columns.tree_field_type%Type
     ,p_editor_tab_code                    form_columns.editor_tab_code%Type
     ,p_field_type                         form_columns.field_type%Type
     ,p_column_description                 form_columns.column_description%Type
     ,p_is_frozen_flag                     form_columns.is_frozen_flag%Type
     ,p_show_hover_flag                    form_columns.show_hover_flag%Type
     ,p_column_data_type                   form_columns.column_data_type%Type
     ,p_exists_in_metadata_flag      Out   Varchar2
     ,p_lookup_code                        form_columns.lookup_code%Type
     ,p_hover_column_code                  form_columns.hover_column_code%Type
     ,p_editor_height                      form_columns.editor_height%Type
     ,p_lookup_field_type                  form_columns.lookup_field_type%Type
     ,p_help_text                          form_columns.help_text%Type
     ,p_text_mask                          form_columns.text_mask%Type
     ,p_validation_regexp                  form_columns.validation_regexp%Type
     ,p_default_orderby_number             form_columns.default_orderby_number%Type
     ,p_default_value                      form_columns.DEFAULT_VALUE%Type
     ,p_editor_title_orientation           form_columns.editor_title_orientation%Type
     ,p_editor_cols_span                   form_columns.editor_cols_span%Type
     ,p_editor_end_row_flag                form_columns.editor_end_row_flag%Type
     ,p_lookup_display_value               form_columns.lookup_display_value%Type
     ,p_editor_on_enter_key_action         form_columns.editor_on_enter_key_action%Type
   ) Is
   Begin
      form_utils.check_nulls (args_t (p_form_code, p_column_code)
                             ,args_t ('�� ������ ��� �����', '�� ������ ��� �������')
                             );

      Update form_columns fc
         Set fc.column_user_name = p_column_user_name
            ,fc.column_display_size = p_column_display_size
            ,fc.column_display_number = p_column_display_number
            ,fc.pimary_key_flag = p_pimary_key_flag
            ,fc.show_on_grid = p_show_on_grid
            ,fc.tree_field_type = p_tree_field_type
            ,fc.editor_tab_code = p_editor_tab_code
            ,fc.field_type = p_field_type
            ,fc.column_description = p_column_description
            ,fc.is_frozen_flag = p_is_frozen_flag
            ,fc.show_hover_flag = p_show_hover_flag
            ,fc.column_data_type = p_column_data_type
            ,fc.lookup_code = p_lookup_code
            ,fc.hover_column_code = p_hover_column_code
            ,fc.editor_height = p_editor_height
            ,fc.lookup_field_type = p_lookup_field_type
            ,fc.help_text = p_help_text
            ,fc.text_mask = p_text_mask
            ,fc.validation_regexp = p_validation_regexp
            ,fc.default_orderby_number = p_default_orderby_number
            ,fc.DEFAULT_VALUE = p_default_value
            ,fc.editor_title_orientation = p_editor_title_orientation
            ,fc.editor_cols_span = p_editor_cols_span
            ,fc.editor_end_row_flag = p_editor_end_row_flag
            ,fc.lookup_display_value = p_lookup_display_value
            ,fc.editor_on_enter_key_action = p_editor_on_enter_key_action
       Where fc.form_code = p_form_code
         And fc.column_code = p_column_code;

      If Sql%Rowcount = 0 Then
         Insert Into form_columns
                     (form_code, column_code, column_user_name, column_display_size, column_display_number
                     ,pimary_key_flag, show_on_grid, tree_field_type, editor_tab_code, field_type, column_description
                     ,is_frozen_flag, show_hover_flag, column_data_type, lookup_code, hover_column_code, editor_height
                     ,lookup_field_type, help_text, text_mask, validation_regexp, default_orderby_number
                     ,DEFAULT_VALUE, editor_title_orientation, editor_cols_span, editor_end_row_flag
                     ,lookup_display_value, editor_on_enter_key_action)
              Values (p_form_code, p_column_code, p_column_user_name, p_column_display_size, p_column_display_number
                     ,p_pimary_key_flag, p_show_on_grid, p_tree_field_type, p_editor_tab_code, p_field_type
                     ,p_column_description, p_is_frozen_flag, p_show_hover_flag, p_column_data_type, p_lookup_code
                     ,p_hover_column_code, p_editor_height, p_lookup_field_type, p_help_text, p_text_mask
                     ,p_validation_regexp, p_default_orderby_number, p_default_value, p_editor_title_orientation
                     ,p_editor_cols_span, p_editor_end_row_flag, p_lookup_display_value, p_editor_on_enter_key_action);
      End If;

      p_exists_in_metadata_flag    := 'Y';

      Update forms f
         Set f.object_version_number = f.object_version_number + 1
       Where f.form_code = p_form_code;
   --      raise_application_error (-20001, 'p_is_frozen_flag:' || p_is_frozen_flag);
   End p_ins_upd;

   Procedure p_delete (p_form_code form_columns.form_code%Type, p_column_code form_columns.column_code%Type) As
   Begin
      Delete From form_columns fc
            Where fc.form_code = p_form_code
              And fc.column_code = p_column_code;

      Update forms f
         Set f.object_version_number = f.object_version_number + 1
       Where f.form_code = p_form_code;
   End p_delete;
End;
/

DROP PACKAGE form_dml_utils
/

CREATE OR REPLACE 
PACKAGE form_dml_utils Is
   Type parameter_value_rec Is Record (
      parameter_name         Varchar2 (255)
     ,parameter_char_value   Varchar2 (4000)
   );

   Type parameter_values_tbl Is Table Of parameter_value_rec
      Index By Varchar2 (255);

   Procedure init;

   Procedure set_parameter_value (p_parameter_name Varchar2, p_parameter_char_value Varchar2);

   Function execute_form_action (p_procedure_name Varchar2)
      Return Varchar2;
End FORM_DML_UTILS;
/


CREATE OR REPLACE 
PACKAGE BODY form_dml_utils Is
/*
�� ������������. ������� ��� ������ ������ � �����������, ���������������� �� varchar*/
   g_parameter_values   parameter_values_tbl;

   Procedure init Is
   Begin
      g_parameter_values.Delete;
   End init;

   Procedure set_parameter_value (p_parameter_name Varchar2, p_parameter_char_value Varchar2) Is
      l_parameter_value_rec   parameter_value_rec;
   Begin
      If (p_parameter_name Is Null) Then
         raise_application_error (-20001, 'p_parameter_name Is Null');
      End If;

      l_parameter_value_rec.parameter_name          := p_parameter_name;
      l_parameter_value_rec.parameter_char_value    := p_parameter_char_value;
      g_parameter_values (p_parameter_name)         := l_parameter_value_rec;
   End set_parameter_value;

   Function execute_form_action (p_procedure_name Varchar2)
      Return Varchar2 Is
      Type bind_var_tbl Is Table Of parameter_value_rec
         Index By Binary_integer;

      l_bind_var_values    bind_var_tbl;
      l_bind_var_counter   Binary_integer   := 0;
      l_sql_text           Varchar2 (32000) := 'begin ' || p_procedure_name || '(';
      l_message            Varchar2 (4000);
   Begin
      For c In (Select   a.argument_name
                    From all_arguments a
                   Where a.package_name || '.' || a.object_name = UPPER (p_procedure_name)
                     And a.owner = 'FORMS_CONSTRUCTOR'
                     And a.Position != 0
                Order By a.Position, a.Sequence) Loop
         If g_parameter_values.Exists (c.argument_name) Then
            l_sql_text                                :=
                                                    l_sql_text || c.argument_name || ' => :' || c.argument_name || ', ';
            l_bind_var_counter                        := l_bind_var_counter + 1;
            l_bind_var_values (l_bind_var_counter)    := g_parameter_values (c.argument_name);
         End If;
      End Loop;

      l_sql_text    := Rtrim (Rtrim (l_sql_text, ' '), ',');
      l_sql_text    := l_sql_text || '); end;';
      DBMS_OUTPUT.put_line (l_sql_text);

      Declare
         l_curId            Integer        Default DBMS_SQL.open_cursor;
         l_status           Integer;
         l_parameter_name   Varchar2 (255);
      Begin
--         l_message           := l_sql_text;
         DBMS_SQL.parse (l_curId, l_sql_text, DBMS_SQL.native);

         For i In l_bind_var_values.First .. l_bind_var_values.Last Loop
            Null;
            DBMS_SQL.bind_variable (c          => l_curId
                                   ,Name       => l_bind_var_values (i).parameter_name
                                   ,Value      => l_bind_var_values (i).parameter_char_value
                                   );
            DBMS_OUTPUT.put_line (   l_bind_var_values (i).parameter_name
                                  || ' => '
                                  || l_bind_var_values (i).parameter_char_value
                                 );
/*            l_message    :=
                  l_message
               || l_bind_var_values (i).parameter_name
               || ' => '
               || l_bind_var_values (i).parameter_char_value
               || '; ';*/
         End Loop;

         l_status            := DBMS_SQL.Execute (l_curId);
         --OUT
         l_parameter_name    := g_parameter_values.First;

         While True Loop
            Exit When l_parameter_name Is Null;
            DBMS_OUTPUT.put_line (   'parameter_name = '
                                  || l_parameter_name
                                  || '; parameter_value = '
                                  || g_parameter_values (l_parameter_name).parameter_char_value
                                 );

            Begin
               DBMS_SQL.variable_value (c          => l_curId
                                       ,Name       => ':' || l_parameter_name
                                       ,Value      => g_parameter_values (l_parameter_name).parameter_char_value
                                       );
            Exception                                                               --���������� ������������ ����������
               When Others Then
                  Null;
            End;

            l_parameter_name    := g_parameter_values.Next (l_parameter_name);
         End Loop;

         DBMS_SQL.close_cursor (c => l_curId);
      Exception
         When Others Then
            l_message    := SUBSTR (SQLERRM, 1, 4000);
            DBMS_SQL.close_cursor (c => l_curId);
      End;

      Return l_message;
   End execute_form_action;
Begin
   Null;
/* ������ �������� �� varchar-���������
        */
End form_dml_utils;
/

DROP PACKAGE form_tab_parent_exclns_pkg
/

CREATE OR REPLACE 
PACKAGE form_tab_parent_exclns_pkg As
   Procedure p_delete (p_excln_id In Out Number);

   Procedure p_ins_upd (
      p_form_code          In Out   Varchar2
     ,p_tab_code           In Out   Varchar2
     ,p_parent_form_code   In Out   Varchar2
     ,p_included_flag      In Out   Varchar2
     ,p_excln_id           In Out   Number
   );
End form_tab_parent_exclns_pkg;
/

GRANT EXECUTE ON form_tab_parent_exclns_pkg TO fc_admin
/

CREATE OR REPLACE 
PACKAGE BODY form_tab_parent_exclns_pkg As
   Procedure p_ins_upd (
      p_form_code          In Out   Varchar2
     ,p_tab_code           In Out   Varchar2
     ,p_parent_form_code   In Out   Varchar2
     ,p_included_flag      In Out   Varchar2
     ,p_excln_id           In Out   Number
   ) Is
   Begin
      Update form_tab_parent_exclns
         Set form_code = p_form_code
            ,tab_code = p_tab_code
            ,parent_form_code = p_parent_form_code
            ,included_flag = p_included_flag
       Where excln_id = p_excln_id;

      If Sql%Rowcount = 0 Then
         Select main_sq.Nextval
           Into p_excln_id
           From DUAL;

         Insert Into form_tab_parent_exclns
                     (form_code, tab_code, parent_form_code, included_flag, excln_id)
              Values (p_form_code, p_tab_code, p_parent_form_code, p_included_flag, p_excln_id);
      End If;
   End p_ins_upd;

   Procedure p_delete (p_excln_id In Out Number) Is
   Begin
      Delete From form_tab_parent_exclns
            Where excln_id = p_excln_id;
   End p_delete;
End form_tab_parent_exclns_pkg;
/

DROP PACKAGE form_tabs_pkg
/

CREATE OR REPLACE 
package form_tabs_pkg is

  -- Author  : V.SAFRONOV
  -- Created : 23.12.2009 11:05:23
  -- Purpose :

  -- Public type declarations
  Procedure p_ins_upd(p_form_code          form_tabs.form_code%type,
                      p_tab_code           form_tabs.tab_code%type,
                      p_child_form_code    form_tabs.child_form_code%type,
                      p_tab_position       form_tabs.tab_position%type,
                      p_tab_name           form_tabs.tab_name%type,
                      p_number_of_columns  form_tabs.number_of_columns%type,
                      p_icon_id            form_tabs.icon_id%type,
                      p_tab_type           form_tabs.tab_type%type,
                      p_tab_display_number form_tabs.tab_display_number%type);

  Procedure p_delete(p_form_code form_tabs.form_code%type,
                     p_tab_code  form_tabs.tab_code%type);

end FORM_TABS_PKG;
/

GRANT EXECUTE ON form_tabs_pkg TO fc_admin
/

CREATE OR REPLACE 
package body form_tabs_pkg is

  Procedure p_ins_upd(p_form_code          form_tabs.form_code%type,
                      p_tab_code           form_tabs.tab_code%type,
                      p_child_form_code    form_tabs.child_form_code%type,
                      p_tab_position       form_tabs.tab_position%type,
                      p_tab_name           form_tabs.tab_name%type,
                      p_number_of_columns  form_tabs.number_of_columns%type,
                      p_icon_id            form_tabs.icon_id%type,
                      p_tab_type           form_tabs.tab_type%type,
                      p_tab_display_number form_tabs.tab_display_number%type) as
  begin
    form_utils.check_nulls(args_t(p_form_code, p_tab_code),
                           args_t('�� ������ ��� �����',
                                  '�� ������ ��� ��������'));
    Update form_tabs fao
       Set form_code          = p_form_code,
           tab_code           = p_tab_code,
           child_form_code    = p_child_form_code,
           tab_position       = p_tab_position,
           tab_name           = p_tab_name,
           number_of_columns  = p_number_of_columns,
           icon_id            = p_icon_id,
           tab_type           = p_tab_type,
           tab_display_number = p_tab_display_number
     Where fao.form_code = p_form_code
       And fao.tab_code = p_tab_code;

    If Sql%Rowcount = 0 Then
      Insert Into form_tabs fao
        (form_code,
         tab_code,
         child_form_code,
         tab_position,
         tab_name,
         number_of_columns,
         icon_id,
         tab_type,
         tab_display_number)
      Values
        (p_form_code,
         p_tab_code,
         p_child_form_code,
         p_tab_position,
         p_tab_name,
         p_number_of_columns,
         p_icon_id,
         p_tab_type,
         p_tab_display_number);
    End If;
    Update forms f
       Set f.object_version_number = f.object_version_number + 1
     Where f.form_code = p_form_code;

  end p_ins_upd;

  Procedure p_delete(p_form_code form_tabs.form_code%type,
                     p_tab_code  form_tabs.tab_code%type) as
  begin
    delete from form_tabs ft
     where ft.form_code = p_form_code
       and ft.tab_code = p_tab_code;
    Update forms f
       Set f.object_version_number = f.object_version_number + 1
     Where f.form_code = p_form_code;
  end p_delete;

end FORM_TABS_PKG;
/

DROP PACKAGE form_utils
/

CREATE OR REPLACE 
Package form_utils
--Authid Current_user
As
   Type pkg_text_r Is Record (
      pkg_txt        Varchar2 (32000)
     ,pkg_body_txt   Varchar2 (32000)
   );

   Type desc_rec2 Is Record (
      col_num                Integer
     ,col_type               Varchar2 (255)
     ,col_max_len            Integer                                := 0
     ,col_name               Varchar2 (2000)                        := ''
     ,col_name_len           Integer                                := 0
     ,col_precision          Integer                                := 0
     ,col_scale              Integer                                := 0
     ,form_code              forms.form_code%Type
     ,pimary_key_flag        form_columns.pimary_key_flag%Type
     ,default_column_width   forms.default_column_width%Type
     ,column_description     form_columns.column_description%Type
   );

   Type desc_t Is Table Of desc_rec2;

   Type Desc_idx_t Is Table Of desc_rec2
      Index By Binary_integer;

   Type bind_variables_rec Is Record (
      form_code    forms.form_code%Type
     ,Position     Integer
     ,datatype     Varchar2 (255)
     ,max_length   Integer
     ,array_len    Integer
     ,bind_name    Varchar2 (255)
   );

   Type column_rec Is Record (
      column_display_number        form_columns.column_display_number%Type
     ,form_code                    form_columns.form_code%Type
     ,column_code                  form_columns.column_code%Type
     ,column_data_type             form_columns.column_data_type%Type
     ,column_user_name             form_columns.column_user_name%Type
     ,column_display_size          form_columns.column_display_size%Type
     ,pimary_key_flag              form_columns.pimary_key_flag%Type
     ,show_on_grid                 form_columns.show_on_grid%Type
     ,tree_initialization_value    form_columns.tree_initialization_value%Type
     ,tree_field_type              form_columns.tree_field_type%Type
     ,editor_tab_code              form_columns.editor_tab_code%Type
     ,field_type                   form_columns.field_type%Type
     ,column_description           form_columns.column_description%Type
     ,is_frozen_flag               form_columns.is_frozen_flag%Type
     ,show_hover_flag              form_columns.show_hover_flag%Type
     ,exists_in_metadata_flag      Varchar2 (1)
     ,exists_in_query_flag         Varchar2 (1)
     ,lookup_code                  form_columns.lookup_code%Type
     ,hover_column_code            form_columns.hover_column_code%Type
     ,editor_height                form_columns.editor_height%Type
     ,lookup_field_type            form_columns.lookup_field_type%Type
     ,help_text                    form_columns.help_text%Type
     ,text_mask                    form_columns.text_mask%Type
     ,validation_regexp            form_columns.validation_regexp%Type
     ,default_orderby_number       form_columns.default_orderby_number%Type
     ,DEFAULT_VALUE                form_columns.DEFAULT_VALUE%Type
     ,editor_title_orientation     form_columns.editor_title_orientation%Type
     ,editor_cols_span             form_columns.editor_cols_span%Type
     ,editor_end_row_flag          form_columns.editor_end_row_flag%Type
     ,lookup_display_value         form_columns.lookup_display_value%Type
     ,editor_on_enter_key_action   form_columns.editor_on_enter_key_action%Type
   );

   Type form_tab_rec Is Record (
      form_code            form_tabs.form_code%Type
     ,tab_code             form_tabs.tab_code%Type
     ,child_form_code      form_tabs.child_form_code%Type
     ,tab_position         form_tabs.tab_position%Type
     ,tab_name             form_tabs.tab_name%Type
     ,number_of_columns    form_tabs.number_of_columns%Type
     ,icon_id              form_tabs.icon_id%Type
     ,tab_type             form_tabs.tab_type%Type
     ,tab_display_number   form_tabs.tab_display_number%Type
   );

   Type bind_variables_t Is Table Of bind_variables_rec;

   Type bind_variables_idx_t Is Table Of bind_variables_rec
      Index By Varchar2 (256);

   Type columns_t Is Table Of column_rec;

   Type form_tabs_t Is Table Of form_tab_rec;

   /*���������� ������ �������� - ��������� ������� ������� ����� p_form_code.*/
   Function describe_form_columns (p_form_code Varchar2 Default Null)
      Return desc_t Pipelined;

   Function describe_form_columns (p_form_code Varchar2, p_sql_text Varchar2, p_default_column_width Varchar2)
      Return desc_t Pipelined;

   /*���������� ������ �������� - ��������� ������� ������� p_sql_text.*/
   Function describe_query_columns (p_sql_text Varchar2)
      Return desc_t Pipelined;

   /*��������� p_sql_text ��� ��������� �������.*/
   Function get_extended_sql_text (p_sql_text Varchar2)
      Return Varchar2;

   Function get_binds
      Return bind_variables_t Pipelined;

   Function get_datatype_as_string (
      p_type          Integer
     ,p_scale         Integer Default Null
     ,p_precision     Integer Default Null
     ,p_charsetform   Integer Default Null
   )
      Return Varchar2;

   /*Pipelined �-��� - ������ �������� �����.*/
   Function describe_form_columns_pl (p_form_code Varchar2 Default Null, p_master_form_code Varchar2 Default Null)
      Return columns_t Pipelined;

   Procedure refresh_temp_columns (p_form_code Varchar2 Default Null);

   Procedure refresh_temp_columns (
      p_form_code              Varchar2
     ,p_sql_text               Varchar2
     ,p_default_column_width   Varchar2
     ,p_delete_only_flag       Varchar2 Default 'N'
   );

   Procedure err_message (p_err_message Varchar2, p_args args_t Default Null);

   Procedure check_nulls (p_vals args_t, p_msgs args_t);

   /*������������ �������� ������ � ��� ������������ �� ��������� ����, ���������������� �-���� GET_FORM_PKG_CLOB*/
   Procedure generate_form_pkg (
      p_form_code       Varchar2
     ,p_package_owner   Varchar2 Default Null
     ,p_table_name      Varchar2 Default Null
   );

   /*��������� �������� ������� ��� ����� �� ��������� �����*/
   Function get_entity_insetrs (p_entity_type Varchar2, p_form_code Varchar2)
      Return Clob;

   /*��������� �������� ��� �����*/
   Function get_inserts (p_form_code Varchar2)
      Return Clob;

   /*��������� �������� ��� clob-�����*/
   Function get_clob_upd (p_form_code Varchar2 Default Null)
      Return Clob;

   /*������� ������� ����� - �������� � ������� ��� ��������� ����������� ��� �������������� Java ���� �������� ����*/
   Function get_form_tabs (p_form_code Varchar2 Default Null, p_master_form_code Varchar2 Default Null)
      Return form_tabs_t Pipelined;

   /*������ ���������� ���� &var � ������ �������*/
   Function replace_user_variables (p_text Varchar2)
      Return Varchar2;

   /*��������� ������ ��� �����*/
   Function get_form_pkg_clob (
      p_form_code       Varchar2
     ,p_package_owner   Varchar2 Default Null
     ,p_table_name      Varchar2 Default Null
   )
      Return Clob;

   /*������� ���� �� ����� ����������*/
   Function get_app_forms_scripts (p_apps_code Varchar2)
      Return Clob;

/*������� ������� ������ �� �����*/
   Function get_table_cols_scripts (p_schema Varchar2)
      Return Clob;
End form_utils;
/

GRANT EXECUTE ON form_utils TO ins
/
GRANT EXECUTE ON form_utils TO fc_admin
/

CREATE OR REPLACE 
PACKAGE BODY      form_utils As
   g_bind_variables   bind_variables_idx_t;

   Cursor forms_cur (c_form_code Varchar2) Is
      Select NVL (c_form_code, f.form_code) form_code, f.sql_text, f.default_column_width
        From forms f
       Where f.form_code = NVL (c_form_code, f.form_code);

   Function get_datatype_as_string (
      p_type          Integer
     ,p_scale         Integer Default Null
     ,p_precision     Integer Default Null
     ,p_charsetform   Integer Default Null
   )
      Return Varchar2 Is
      l_res   Varchar2 (255);
   Begin
      Select DECODE (p_type
                    ,1, DECODE (p_charsetform, 2, 'NVARCHAR2', 'VARCHAR2')
                    ,2, DECODE (p_scale, Null, DECODE (p_precision, Null, 'NUMBER', 'FLOAT'), 'NUMBER')
                    ,8, 'LONG'
                    ,9, DECODE (p_charsetform, 2, 'NCHAR VARYING', 'VARCHAR')
                    ,12, 'DATE'
                    ,23, 'RAW'
                    ,24, 'LONG RAW'
                    ,69, 'ROWID'
                    ,96, DECODE (p_charsetform, 2, 'NCHAR', 'CHAR')
                    ,100, 'BINARY_FLOAT'
                    ,101, 'BINARY_DOUBLE'
                    ,105, 'MLSLABEL'
                    ,106, 'MLSLABEL'
                    ,112, DECODE (p_charsetform, 2, 'NCLOB', 'CLOB')
                    ,113, 'BLOB'
                    ,114, 'BFILE'
                    ,115, 'CFILE'
                    ,178, 'TIME(' || p_scale || ')'
                    ,179, 'TIME(' || p_scale || ')' || ' WITH TIME ZONE'
                    ,180, 'TIMESTAMP(' || p_scale || ')'
                    ,181, 'TIMESTAMP(' || p_scale || ')' || ' WITH TIME ZONE'
                    ,231, 'TIMESTAMP(' || p_scale || ')' || ' WITH LOCAL TIME ZONE'
                    ,182, 'INTERVAL YEAR(' || p_precision || ') TO MONTH'
                    ,183, 'INTERVAL DAY(' || p_precision || ') TO SECOND(' || p_scale || ')'
                    ,208, 'UROWID'
                    ,'UNDEFINED'
                    )
        Into l_res
        /*,58,111,121,122,123, NVL2 (ac.synobj#, (Select o.Name From obj$ o Where o.obj# = ac.synobj#), ot.Name)*/
      From   DUAL;

      Return l_res;
   End get_datatype_as_string;

   Function replace_user_variables (p_text Varchar2)
      Return Varchar2 Is
      l_res   Varchar2 (32000) := p_text;
   Begin
      l_res    := REGEXP_REPLACE (l_res, '&fc_schema_owner.', applications_pkg.get_fc_schema, 1, 0, 'i');
      l_res    := REGEXP_REPLACE (l_res, '&db_username.', User, 1, 0, 'i');
      Return l_res;
   End;

   Function get_extended_sql_text (p_sql_text Varchar2)
      Return Varchar2 Is
      l_result              Varchar2 (4000);
      l_last_order_by_pos   Number;
   Begin
      --�������� ��������� order by, ����� ���������� �� ������...
      l_last_order_by_pos    := REGEXP_INSTR (p_sql_text, '(order\s+by.+)$', 1, 1, 0, 'i');

      If l_last_order_by_pos > 0 Then
         l_result    := SUBSTR (p_sql_text, 1, l_last_order_by_pos - 1);
      Else
         l_result    := p_sql_text;
      End If;

      l_result               := replace_user_variables (l_result);
      Return l_result;
   --Return 'select row_number() over(order by 2) - 0 rn, t.*, count(*) over() cnt from (' || p_sql_text || ') t';
   End get_extended_sql_text;

/*   Function describe_columns (p_sql_text Varchar2, p_form_code Varchar2 Default Null)
      Return DBMS_SQL.desc_tab Is
      cur          Number;
      col_count    Pls_integer;
      l_result     DBMS_SQL.desc_tab;
      l_sql_text   Varchar2 (4000)   := get_extended_sql_text (p_sql_text);
   Begin
      cur    := DBMS_SQL.open_cursor;
      DBMS_SQL.parse (cur, l_sql_text, DBMS_SQL.native);
      DBMS_SQL.describe_columns (cur, col_count, l_result);
      / * �������� � Oracle 9.2 - ��� ������� v$sql_cursor.child_handle - ����� �� ������ ������ ��� �������������
            For Binds In (Select Distinct p_form_code form_code, m.Position, get_datatype_as_string (m.datatype) datatype
                                         --
                                          ,m.max_length, m.array_len, m.bind_name
                                     From v$sql_bind_metadata m, v$sql_cursor c
                                    Where c.child_handle = m.address
                                      And c.curno = cur
                                 Order By m.Position) Loop
               g_bind_variables (Binds.form_code || Binds.Position)    := Binds;
            End Loop;
      * /
      DBMS_SQL.close_cursor (cur);
      raise_application_error(-20001, 'User:'||user);
      Return l_result;
   Exception
      When Others Then
         DBMS_OUTPUT.put_line (SQLERRM);
         DBMS_OUTPUT.put_line (SUBSTR ('Value of l_sql_text=' || l_sql_text, 1, 255));

         If DBMS_SQL.is_open (cur) Then
            DBMS_SQL.close_cursor (cur);
         End If;

         l_result.Delete;
         Return l_result;
   End describe_columns;*/
   Function get_binds
      Return bind_variables_t Pipelined Is
      l_str   Varchar2 (256) := g_bind_variables.First;
   Begin
      Loop
         Pipe Row (g_bind_variables (l_str));
         Exit When l_str = g_bind_variables.Last;
         l_str    := g_bind_variables.Next (l_str);
      End Loop;

      Return;
   End get_binds;

   Function convert_to_desc_t_idx (dsc DBMS_SQL.desc_tab, p_form_code Varchar2 Default Null)
      Return desc_idx_t Is
      l_result   desc_idx_t;
   Begin
      For i In dsc.First .. dsc.Last Loop
         l_result (i).form_code        := p_form_code;
         l_result (i).col_num          := i;
         l_result (i).col_max_len      := dsc (i).col_max_len;
         l_result (i).col_name         := dsc (i).col_name;
         l_result (i).col_name_len     := dsc (i).col_name_len;
         l_result (i).col_precision    := dsc (i).col_precision;
         l_result (i).col_scale        := dsc (i).col_scale;
         l_result (i).col_type         :=
            get_datatype_as_string (dsc (i).col_type, dsc (i).col_scale, dsc (i).col_precision
                                   ,dsc (i).col_charsetform);
      End Loop;

      Return l_result;
   End convert_to_desc_t_idx;

   Function describe_query_columns (p_sql_text Varchar2)
      Return desc_t Pipelined Is
      src        desc_idx_t := convert_to_desc_t_idx (form_auth_cur_user_utlis_pkg.describe_columns (p_sql_text));
      l_result   desc_rec2;
   Begin
      For i In src.First .. src.Last Loop
         Pipe Row (src (i));
      End Loop;

      Return;
   End describe_query_columns;

   Function describe_form_columns_pl (p_form_code Varchar2 Default Null, p_master_form_code Varchar2 Default Null)
      Return columns_t Pipelined Is
      i   Binary_integer := 1;
   Begin
      For cc In (Select   NVL (stat.column_display_number, 1000 + dyn.col_num) column_display_number
                         ,NVL (stat.form_code, dyn.form_code) form_code
                         ,NVL (stat.column_code, dyn.col_name) column_code
                         ,NVL (stat.column_data_type, dyn.col_type) column_data_type
                         ,NVL (stat.column_user_name
                              ,SUBSTR (Ltrim (Replace (dyn.column_description, dyn.col_name, ''), '*'), 1, 100)
                              ) column_user_name
                         ,NVL (NVL (stat.column_display_size, default_column_width), '*')
                         ,NVL (stat.pimary_key_flag, dyn.pimary_key_flag) pimary_key_flag
                         ,NVL (stat.show_on_grid, 'Y') show_on_grid, stat.tree_initialization_value
                         ,NVL (stat.tree_field_type, DECODE (dyn.pimary_key_flag, 'Y', 1)) tree_field_type
                         ,stat.editor_tab_code, stat.field_type
                         ,NVL (stat.column_description, dyn.column_description) column_description
                         ,NVL (stat.is_frozen_flag, 'N'), NVL (stat.show_hover_flag, 'N')
                         ,NVL2 (stat.column_code, 'Y', 'N') exists_in_metadata_flag
                         ,NVL2 (dyn.col_name, 'Y', 'N') exists_in_query_flag, stat.lookup_code, stat.hover_column_code
                         ,stat.editor_height, NVL (stat.lookup_field_type, DECODE (dyn.pimary_key_flag, 'Y', 1))
                         ,stat.help_text, stat.text_mask, stat.validation_regexp, stat.default_orderby_number
                         ,stat.DEFAULT_VALUE
                         ,NVL (stat.editor_title_orientation
                              ,DECODE (stat.field_type, '4', 'T', '5', 'T', 'L')
                              ) editor_title_orientation
                         ,NVL (stat.editor_cols_span, '*') editor_cols_span
                         ,NVL (stat.editor_end_row_flag, 'Y') editor_end_row_flag, stat.lookup_display_value
                         ,stat.editor_on_enter_key_action
                     From (Select *
                             From form_columns c
                            Where c.form_code = NVL (p_form_code, c.form_code)
/*  And Exists (Select 1
                                                                                                                                                                                                                                                                                                                                                                                                                                                                From forms_v f
                                                                                                                                                                                                                                                                                                                                                                                                                                                               Where f.form_code = c.form_code)*/
                          ) stat
                          Full Outer Join
                          (Select *
                             From form_columns$ c
                            Where c.form_code = NVL (p_form_code, c.form_code)) dyn
                          On stat.form_code = dyn.form_code
                        And dyn.col_name = stat.column_code
                 Order By form_code, column_display_number, column_code) Loop
         cc.column_data_type    :=
            Case
               When cc.column_data_type = 'NUMBER' Then 'N'
               When cc.column_data_type = 'VARCHAR2' Then 'S'
               When cc.column_data_type = 'CHAR' Then 'S'
               When cc.column_data_type = 'DATE' Then 'D'
               Else cc.column_data_type
            End;
         --User Hook
         DBMS_OUTPUT.put_line ('form_code = ' || cc.form_code);
         form_utils_customization.customize_column_metadata (i, cc, p_master_form_code);
         Pipe Row (cc);
         i                      := i + 1;
      End Loop;

      Return;
   End describe_form_columns_pl;

   Procedure refresh_temp_columns (
      p_form_code              Varchar2
     ,p_sql_text               Varchar2
     ,p_default_column_width   Varchar2
     ,p_delete_only_flag       Varchar2 Default 'N'
   ) Is
   Begin
      Delete From form_columns$ a
            Where p_form_code = a.form_code;

      If 'Y' != p_delete_only_flag Then
         For cr In (Select col_num, col_type, col_max_len, col_name, col_name_len, col_precision, col_scale, form_code
                          ,pimary_key_flag, default_column_width, column_description
                      From Table (form_utils.describe_form_columns (p_form_code, p_sql_text, p_default_column_width))) Loop
            Insert Into form_columns$
                        (col_num, col_type, col_max_len, col_name, col_name_len, col_precision, col_scale, form_code
                        ,pimary_key_flag, default_column_width, column_description)
                 Values (cr.col_num, cr.col_type, cr.col_max_len, cr.col_name, cr.col_name_len, cr.col_precision
                        ,cr.col_scale, cr.form_code, cr.pimary_key_flag, cr.default_column_width
                        ,cr.column_description);
         /*Select *
         From Table (form_utils.describe_form_columns (p_form_code, p_sql_text, p_default_column_width));*/
         End Loop;
      End If;
   End;

   Procedure refresh_temp_columns (p_form_code Varchar2 Default Null) Is
   Begin
      For cur In forms_cur (p_form_code) Loop
         refresh_temp_columns (cur.form_code, cur.sql_text, cur.default_column_width);
      End Loop;
   End;

   Function describe_form_columns (p_form_code Varchar2, p_sql_text Varchar2, p_default_column_width Varchar2)
      --�� ����� �����
   Return desc_t Pipelined Is
      src              desc_idx_t;
      l_result         desc_rec2;

      Type primary_keys_type Is Table Of Binary_integer
         Index By Varchar2 (100);

      l_primary_keys   primary_keys_type;
   Begin
      Begin
         src    :=
            convert_to_desc_t_idx (form_auth_cur_user_utlis_pkg.describe_columns (p_sql_text, p_form_code)
                                  ,p_form_code);

         -- �������� �������� ��������� �����, �����������, ��� ��� ����� ������������� ����� ��������. Owner ���� �� �����������
         For cp In (Select   cc.column_name, cc.Position
                        From all_constraints c, all_cons_columns cc
                       Where c.table_name = p_form_code
                         And c.constraint_type In ('U', 'P')
                         And c.owner = cc.owner
                         And c.table_name = cc.table_name
                         And c.constraint_name = cc.constraint_name
                    Order By cc.Position) Loop
            l_primary_keys (cp.column_name)    := cp.Position;
         End Loop;

         For i In src.First .. src.Last Loop
            If l_primary_keys.Exists (src (i).col_name) Then
               src (i).pimary_key_flag    := 'Y';
            End If;

            --���� ��� ���� ����� �������� � ������ ������:)���� �������� ��� ���� ��������� ����������
            Select '*' || NVL (Min (cm.comments), '*' || src (i).col_name)
              Into src (i).column_description
              From all_col_comments cm
             Where cm.column_name = src (i).col_name                              --NVL (stat.column_code, dyn.col_name)
               And cm.comments Is Not Null;

            src (i).default_column_width    := p_default_column_width;
            Pipe Row (src (i));
         End Loop;
      Exception
         When Others Then
            DBMS_OUTPUT.put_line ('Error on form: ' || p_form_code);
            DBMS_OUTPUT.put_line (SQLERRM);
--TODO
--            Raise;
      End;
   End describe_form_columns;

   Function describe_form_columns (p_form_code Varchar2 Default Null)
      Return desc_t Pipelined Is
   Begin
      For cur In forms_cur (p_form_code) Loop
         For cf In (Select *
                      From Table (form_utils.describe_form_columns (cur.form_code
                                                                   ,cur.sql_text
                                                                   ,cur.default_column_width
                                                                   )
                                 )) Loop
            Pipe Row (cf);
         End Loop;
      End Loop;

      Return;
   End describe_form_columns;

   Function get_form_pkg_text (
      p_form_code       Varchar2
     ,p_package_owner   Varchar2 Default Null
     ,p_table_name      Varchar2 Default Null
   )
      Return pkg_text_r Is
      l_param_list       Varchar2 (4000);
      l_upd_set_list     Varchar2 (4000);
      l_upd_where_list   Varchar2 (4000);
      l_ins_col_list     Varchar2 (4000);
      l_ins_vals_list    Varchar2 (4000);
      l_owner_prefix     Varchar2 (4000);
      l_pkg_suffix       Varchar2 (4000) := '_PKG';
      l_pkg_name         Varchar2 (4000);
      l_table_name       Varchar2 (4000);
      l_pkg_end_name     Varchar2 (4000);
      l_res              pkg_text_r;
   Begin
      For cc In (Select   NVL2 (p_package_owner, p_package_owner || '.', '') owner_prefix
                         ,LOWER (column_code) column_code
                         ,DECODE (column_data_type, 'N', 'number', 'varchar2') column_data_type
                     From Table (form_utils.describe_form_columns_pl (p_form_code)) t
                 Order By column_display_number) Loop
         l_param_list        :=
                          l_param_list || CHR (10) || ',' || 'p_' || cc.column_code || ' in out '
                          || cc.column_data_type;
         l_upd_set_list      := l_upd_set_list || CHR (10) || ',' || cc.column_code || ' = p_' || cc.column_code;
         l_upd_where_list    := l_upd_where_list || CHR (10) || ' and ' || cc.column_code || ' = p_' || cc.column_code;
         l_ins_col_list      := l_ins_col_list || CHR (10) || ',' || cc.column_code;
         l_ins_vals_list     := l_ins_vals_list || CHR (10) || ',' || 'p_' || cc.column_code;
         l_owner_prefix      := cc.owner_prefix;
      End Loop;

      l_param_list          := SUBSTR (l_param_list, 3);
      l_upd_set_list        := SUBSTR (l_upd_set_list, 3);
      l_upd_where_list      := SUBSTR (l_upd_where_list, 7);
      l_ins_col_list        := SUBSTR (l_ins_col_list, 3);
      l_ins_vals_list       := SUBSTR (l_ins_vals_list, 3);
      l_table_name          := UPPER (l_owner_prefix || NVL (p_table_name, p_form_code));
      l_pkg_name            := l_table_name || l_pkg_suffix;
      l_pkg_end_name        := UPPER (NVL (p_table_name, p_form_code)) || l_pkg_suffix;
      l_res.pkg_txt         :=
            Replace (Xmltype ('<x/>').getClobVal (), '<x/>', '')
         || 'create package '
         || l_pkg_name
         || ' as '
         || ' end '
         || l_pkg_end_name
         || ';';
      l_res.pkg_body_txt    :=
            Replace (Xmltype ('<x/>').getClobVal (), '<x/>', '')
         || 'create package body '
         || l_pkg_name
         || ' as '
         || 'procedure p_ins_upd ('
         || l_param_list
         || ') is begin update '
         || l_table_name
         || ' set '
         || l_upd_set_list
         || ' where '
         || l_upd_where_list
         || '; if sql%rowcount=0 then Select main_sq.Nextval Into p_id From dual; '
         || 'insert into '
         || l_table_name
         || '('
         || l_ins_col_list
         || ') values('
         || l_ins_vals_list
         || '); end if; end p_ins_upd;'
         || 'procedure p_delete ('
         || l_param_list
         || ') is begin delete from '
         || l_table_name
         || ' where '
         || l_upd_where_list
         || '; end p_delete;'
         || ' end '
         || l_pkg_end_name
         || ';';
      Return l_res;
   End get_form_pkg_text;

   Function get_form_pkg_clob (
      p_form_code       Varchar2
     ,p_package_owner   Varchar2 Default Null
     ,p_table_name      Varchar2 Default Null
   )
      Return Clob Is
      l_pkg   pkg_text_r := get_form_pkg_text (p_form_code, p_package_owner, p_table_name);
      l_res   Clob;
   Begin
      l_res    := l_pkg.pkg_txt || '
/
' ||              l_pkg.pkg_body_txt || '
/
';
      Return l_res;
   End get_form_pkg_clob;

   Procedure generate_form_pkg (
      p_form_code       Varchar2
     ,p_package_owner   Varchar2 Default Null
     ,p_table_name      Varchar2 Default Null
   ) Is
      l_pkg   pkg_text_r := get_form_pkg_text (p_form_code, p_package_owner, p_table_name);
   Begin
      Begin
         Execute Immediate l_pkg.pkg_txt;
      Exception
         When Others Then
            DBMS_OUTPUT.put_line (SQLERRM);
      End;

      Begin
         Execute Immediate l_pkg.pkg_body_txt;
      Exception
         When Others Then
            DBMS_OUTPUT.put_line (SQLERRM);
      End;
   End generate_form_pkg;

   --f("�� ������� ������� %1 �� ���� %2. ������� ������� ������� %1"
   --,"sdfds",sysdate
   --)
   Procedure err_message (p_err_message Varchar2, p_args args_t Default Null) As
   Begin
      raise_application_error (-20001, TEXT_UTILS.format (p_err_message, p_args));
   End err_message;

   Procedure check_nulls (p_vals args_t, p_msgs args_t) As
      l_msg   Varchar2 (32000) := Null;
   Begin
      For i In 1 .. p_vals.Count Loop
         If p_vals (i) Is Null Then
            l_msg    := l_msg || p_msgs (i) || CHR (10);
         End If;
      End Loop;

      If l_msg Is Not Null Then
         err_message (l_msg);
      End If;
   End check_nulls;

   Function get_entity_insetrs (p_entity_type Varchar2, p_form_code Varchar2)
      Return Clob Is
      Type charArr Is Table Of Varchar2 (32000)
         Index By Binary_integer;

      l_res        Clob              := '/*  Form: ' || p_form_code || '. Entity: ' || p_entity_type || '.  */';
      l_str        Varchar2 (32000);
      l_ins_into   Varchar2 (32000);
      p_select     Varchar2 (2000)   := 'select * from ' || p_entity_type || ' where form_code=:p_form_code';
      l_char_arr   charArr;
      l_tmp        Clob;
      c            Integer;
      col_cnt      Integer;
      rows_cnt     Integer;
      desc_t       DBMS_SQL.DESC_TAB;
   Begin
      c             := DBMS_SQL.open_cursor;
      DBMS_SQL.PARSE (c, p_select, DBMS_SQL.NATIVE);
      DBMS_SQL.DESCRIBE_COLUMNS (c, col_cnt, desc_t);

      For j In 1 .. col_cnt Loop
         l_str    := l_str || ', "' || desc_t (j).col_name || '"';

         If DBMS_TYPES.typecode_clob = desc_t (j).col_type Then
            DBMS_SQL.define_column (c, j, l_tmp);
         Else
            l_char_arr (j)    := Null;
            DBMS_SQL.define_column (c, j, l_char_arr (j), 32000);
         End If;
      End Loop;

      l_ins_into    :=
            CHR (10) || CHR (10) || 'insert into ' || p_entity_type || '(' || SUBSTR (l_str, 3) || ') values ('
            || CHR (10);
      DBMS_SQL.bind_variable (c, 'p_form_code', p_form_code);
      rows_cnt      := DBMS_SQL.Execute (c);

      Loop
         If DBMS_SQL.fetch_rows (c) = 0 Then
            Exit;
         End If;

         l_res    := l_res || l_ins_into;

         For j In 1 .. col_cnt Loop
            If j != 1 Then
               l_res    := l_res || CHR (10) || ',';
            End If;

            --�������� � �������� Clob
            If DBMS_TYPES.typecode_clob = desc_t (j).col_type Then
               DBMS_SQL.COLUMN_VALUE (c, j, l_tmp);
--               l_res    := l_res || '''' || Replace (l_tmp, '''', '''''') || '''';
               l_res    := l_res || '''' || Null || '''';
            Else
               DBMS_SQL.COLUMN_VALUE (c, j, l_char_arr (j));
               l_res    := l_res || '''' || Replace (l_char_arr (j), '''', '''''') || '''';
            End If;
         End Loop;

         l_res    := l_res || ');';
      End Loop;

      DBMS_SQL.close_cursor (c);
      Return l_res;
   End get_entity_insetrs;

   Function get_clob_upd (p_form_code Varchar2 Default Null)
      Return Clob Is
      l_res   Clob;
   Begin
      For cr In (Select    'Declare l_clob   Clob := '''
                        || Replace (f.description, '''', '''''')
                        || '''; Begin Update FORMS Set description = l_clob Where form_code = '''
                        || NVL (p_form_code, f.form_code)
                        || '''; End;'
                        || CHR (10)
                        || CHR (47) txt
                   From forms f
                  Where f.description Is Not Null
                    And f.form_code = NVL (p_form_code, f.form_code)) Loop
         l_res    := l_res || CHR (10) || cr.txt;
      End Loop;

      For cr In (Select    'Declare l_clob   Clob := '''
                        || Replace (f.help_text, '''', '''''')
                        || ''';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = '''
                        || NVL (p_form_code, f.form_code)
                        || ''' and column_code = '''
                        || f.column_code
                        || '''; End;'
                        || CHR (10)
                        || CHR (47) txt
                   From form_columns f
                  Where f.help_text Is Not Null
                    And f.form_code = NVL (p_form_code, f.form_code)) Loop
         l_res    := l_res || CHR (10) || cr.txt;
      End Loop;

      Return l_res;
   End get_clob_upd;

   Function get_inserts (p_form_code Varchar2)
      Return Clob Is
      Type t Is Table Of Varchar2 (2000);

      l_tables_list   t
         := t ('FORMS'
              ,'FORM_TABS'
              ,'FORM_ACTIONS'
              ,'FORM_COLUMNS$'
              ,'FORM_COLUMNS'
              ,'FORM_COLUMN_ATTR_VALS'
              ,'FORM_TAB_PARENT_EXCLNS'
              ,'APPS_PRIVS'
              );
      l_res           Clob;
   Begin
      For i In Reverse l_tables_list.First .. l_tables_list.Last Loop
         l_res    :=
             l_res || 'delete from ' || l_tables_list (i) || ' where form_code = ''' || p_form_code || ''';'
             || CHR (10);
      End Loop;

      For i In l_tables_list.First .. l_tables_list.Last Loop
         l_res    := l_res || form_utils.get_entity_insetrs (l_tables_list (i), p_form_code) || CHR (10);
      End Loop;

      l_res    :=
            '
Alter Table FORMS Disable All Triggers;
Alter Table forms Disable Constraint forms_form_actions_fk;'
         || CHR (10)
         || l_res
         || CHR (10)
         || get_clob_upd (p_form_code)
         || CHR (10)
         || '
Alter Table forms Enable VALIDATE Constraint forms_form_actions_fk;
Alter Table FORMS Enable All Triggers;';
      Return l_res;
   End get_inserts;

   Function get_form_tabs (p_form_code Varchar2 Default Null, p_master_form_code Varchar2 Default Null)
      Return form_tabs_t Pipelined Is
   Begin
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
                      --�� ���������� ������, ������� �� ����� ����������, ���� ���� �����-��������
                      And Not Exists (
                             Select 1
                               From form_tab_parent_exclns a
                              Where a.form_code = ft.form_code
                                And a.parent_form_code = p_master_form_code
                                And a.included_flag = 'N'
                                And a.tab_code = ft.tab_code)
                 Order By tab_display_number, tab_name, tab_code) Loop
         Pipe Row (cr);
      End Loop;

      Return;
   End get_form_tabs;

   Function get_app_forms_scripts (p_apps_code Varchar2)
      Return Clob Is
      l_res   Clob;
   Begin
      For cr In (Select   a.export_order, a.form_code, a.form_name, FORM_UTILS.get_inserts (a.form_code)
                                                                                                        As form_script
                     From forms a
                    Where a.apps_code = p_apps_code
                 Order By a.export_order, a.form_code) Loop
         l_res    := l_res || CHR (10) || '/*****************' || cr.form_code || '*********************/' || CHR (10);
         l_res    := l_res || cr.form_script || CHR (10);
      End Loop;

      Return l_res;
   End get_app_forms_scripts;

   Function get_table_cols_scripts (p_schema Varchar2)
      Return Clob Is
      l_cols           Clob;
      l_col_comments   Clob;
      l_res            Clob;
   Begin
      For cr In (With t As
                      (
                         Select   utc.table_name, utc.column_name, utc.data_type, utc.data_length, utc.data_precision
                                 ,utc.data_scale, ucc.comments
                             From all_tab_columns utc, all_col_comments ucc
                            Where utc.table_name = ucc.table_name
                              And utc.column_name = ucc.column_name
                              And utc.owner = ucc.owner
                              And utc.owner = p_schema
                              And utc.table_name Not In ('SQLN_EXPLAIN_PLAN')
                         Order By utc.table_name, utc.column_id)
                 Select t.table_name, t.column_name
                       ,    'alter table "'
                         || t.table_name
                         || '" add "'
                         || t.column_name
                         || '" '
                         || LOWER (   t.data_type
                                   || DECODE (t.data_type
                                             ,'VARCHAR2', '(' || t.data_length || ')'
                                             ,'NUMBER', '(' || t.data_length || ', ' || NVL (t.data_precision, 0) || ')'
                                             )
                                  )
                         || ';' As colmn
                       ,DECODE (t.comments
                               ,Null, Null
                               ,    'Comment On Column "'
                                 || t.table_name
                                 || '"."'
                                 || t.column_name
                                 || '" is '''
                                 || Replace (t.comments, '''', '''''')
                                 || ''';'
                               ) col_comments
                   From t) Loop
         l_cols    := l_cols || cr.colmn || CHR (10);

         If cr.col_comments Is Not Null Then
            l_col_comments    := l_col_comments || cr.col_comments || CHR (10);
         End If;

         l_res     := l_cols || CHR (10) || l_col_comments;
      End Loop;

      Return l_res;
   End get_table_cols_scripts;
End FORM_UTILS;
/

DROP PACKAGE form_utils_customization
/

CREATE OR REPLACE 
Package form_utils_customization As
   Procedure customize_column_metadata (
      p_column_number               Number
     ,p_column_data        In Out   form_utils.column_rec
     ,p_master_form_code            Varchar2 Default Null
   );
End form_utils_customization;
/


CREATE OR REPLACE 
PACKAGE BODY form_utils_customization As
   Procedure customize_column_metadata (
      p_column_number               Number
     ,p_column_data        In Out   form_utils.column_rec
     ,p_master_form_code            Varchar2 Default Null
   ) Is
   Begin
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
   End;
End form_utils_customization;
/

DROP PACKAGE forms_pkg
/

CREATE OR REPLACE 
Package forms_pkg /*Authid Current_user*/ As
   Type form_md_r Is Record (
      form_code                  Varchar2 (255)
     ,hot_key                    Varchar2 (100)
     ,sql_text                   Clob
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
     ,p_lookup_width               In Out   forms.lookup_width%Type
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

GRANT EXECUTE ON forms_pkg TO ins
/
GRANT EXECUTE ON forms_pkg TO fc_admin
/

CREATE OR REPLACE 
PACKAGE BODY forms_pkg As
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
     ,p_lookup_width               In Out   forms.lookup_width%Type
   ) Is
   Begin
      --��� - ��. ������� �� ��������
      form_utils.check_nulls (args_t (p_form_code), args_t ('�� ������ ��� �����'));

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
       Where a.form_code = p_form_code;

      If Sql%Rowcount = 0 Then
         Insert Into forms
                     (form_code, hot_key, sql_text, form_name, description, form_type, show_tree_root_node, icon_id
                     ,form_width, form_height, bottom_tabs_orientation, side_tabs_orientation, show_bottom_toolbar
                     ,default_column_width, object_version_number, double_click_action_code, lookup_width)
              Values (p_form_code, p_hot_key, p_sql_text, p_form_name, p_description, p_form_type
                     ,p_show_tree_root_node, p_icon_id, p_form_width, p_form_height, p_bottom_tabs_orientation
                     ,p_side_tabs_orientation, p_show_bottom_toolbar, p_default_column_width, 1
                     ,p_double_click_action_code, p_lookup_width)
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
      /*!!! TODO ��������  - SQL_TEXT Varchar2(2000)*/
      /*!!! TODO ��������  - Authid Current_user */
      For cr In (Select a.form_code, a.hot_key, l_clob || a.sql_text, a.form_name, a.form_type, a.show_tree_root_node
                       ,a.icon_id, a.form_width, a.form_height, a.bottom_tabs_orientation, a.side_tabs_orientation
                       ,a.show_bottom_toolbar, a.object_version_number, a.default_column_width, a.description
                       ,a.double_click_action_code, a.lookup_width
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

DROP PACKAGE forms2_pkg
/

CREATE OR REPLACE 
PACKAGE forms2_pkg As
  Procedure p_delete(p_code Varchar2);

  Procedure p_insert(p_user_name In Out Varchar2,
                     p_code      Out Varchar2,
                     p_is_folder Out Varchar2);
End;
/


CREATE OR REPLACE 
PACKAGE BODY forms2_pkg As
   Procedure p_insert (p_user_name In Out Varchar2, p_code Out Varchar2, p_is_folder Out Varchar2) Is
      l_app_code               APPLICATIONS.apps_code%Type;
      l_default_table_prefix   APPLICATIONS.default_table_prefix%Type;
      l_current_user           Varchar2 (30)                            := SYS_CONTEXT ('USERENV', 'SESSION_USER');
      l_table_descr            Varchar2 (100);
   Begin
      form_utils.check_nulls (args_t (p_user_name), args_t ('�� ������� ��� �����'));

      Begin
         Select a.apps_code, a.default_table_prefix
           Into l_app_code, l_default_table_prefix
           From APPLICATIONS a
          Where 1 = 1
            And a.schema_name = l_current_user;
      Exception
         When NO_DATA_FOUND Then
            Null;
      End;

      Begin
         Select SUBSTR (t.comments, 1, 100)
           Into l_table_descr
           From all_tab_comments t
          Where t.owner = l_current_user
            And t.table_name = UPPER (p_user_name);
      Exception
         When NO_DATA_FOUND Then
            Null;
      End;

      p_is_folder    := 1;
      p_code         := l_default_table_prefix || UPPER (p_user_name);

      Insert Into forms
                  (form_code, object_version_number, sql_text, form_name)
           Values (p_code, 1, 'select * from ' || l_current_user || '.' || UPPER (p_user_name), l_table_descr);

      If 1 = 1 Then
         Insert Into apps_privs
              Values (l_app_code, p_code);
      --         raise_application_error (-20002, USERENV ('SCHEMAID') || 'xxx' || Sql%Rowcount);
      End If;

      Begin
         form_utils.generate_form_pkg (p_code, l_current_user, p_user_name);
      Exception
         When Others Then
            DBMS_OUTPUT.put_line (SQLERRM);
      End;

      Insert Into form_actions
         Select p_code, a.action_code, Replace (a.procedure_name, 'FORM_ACTIONS', p_code) procedure_name
               ,a.action_display_name, a.icon_id, a.default_param_prefix, a.default_old_param_prefix, a.action_type
               ,a.display_number, a.confirm_text, a.hot_key, a.show_separator_below, a.display_on_toolbar
               ,a.child_form_code
           From form_actions a
          Where a.form_code = 'FORM_ACTIONS';
   End p_insert;

   Procedure p_delete (p_code Varchar2) Is
      l_form_code   forms.form_code%Type   := p_code;
   Begin
      Delete From form_actions a
            Where a.form_code = l_form_code;

      Delete From apps_privs a
            Where a.form_code = l_form_code;

      Delete From form_columns a
            Where a.form_code = l_form_code;

      Delete From form_columns$ a
            Where a.form_code = l_form_code;

      Delete From form_tabs a
            Where a.form_code = l_form_code;

      Delete From forms a
            Where a.form_code = l_form_code;
   End p_delete;
End;
/

DROP PACKAGE icons_pkg
/

CREATE OR REPLACE 
PACKAGE icons_pkg
/**
 * The header comment describes the goal of the package.
 * 
 * @author t. lorbeer
 * @since 1.0
 */
Is

   /**
    * This is the description for the first procedure in this package.
    *
    * @param bookingDate
    *    the booking date
    *
    * @see getBookingDate
    *
    * @exception date_is_null
    *    occurse when <i>bookingDate</i> is null.
    */
   Procedure p_ins_upd (
      p_icon_id          icons.icon_id%Type
     ,p_icon_file_name   icons.icon_file_name%Type
     ,p_icon_path        icons.icon_path%Type
   );

   Procedure p_delete (p_icon_id icons.icon_id%Type);
End ICONS_PKG;
/


CREATE OR REPLACE 
PACKAGE BODY icons_pkg Is
   Procedure p_ins_upd (
      p_icon_id          icons.icon_id%Type
     ,p_icon_file_name   icons.icon_file_name%Type
     ,p_icon_path        icons.icon_path%Type
   ) As
   Begin
      form_utils.check_nulls (args_t (p_icon_id, p_icon_file_name)
                             ,args_t ('�� ������ ��� ������', '�� ������ ���� ������')
                             );

      Update icons i
         Set icon_id = p_icon_id
            ,icon_file_name = p_icon_file_name
            ,icon_path = p_icon_path
       Where i.icon_id = p_icon_id;

      If Sql%Rowcount = 0 Then
         Insert Into icons i
                     (icon_id, icon_file_name, icon_path)
              Values (p_icon_id, p_icon_file_name, p_icon_path);
      End If;
   End p_ins_upd;

   Procedure p_delete (p_icon_id icons.icon_id%Type) As
   Begin
      Delete From icons i
            Where i.icon_id = p_icon_id;
   End p_delete;
End ICONS_PKG;
/

DROP PACKAGE lookup_attribute_values_pkg
/

CREATE OR REPLACE 
PACKAGE lookup_attribute_values_pkg As
   Procedure p_ins_upd (
      p_lookup_code              In Out   Varchar2
     ,p_lookup_value_code        In Out   Varchar2
     ,p_attribute_code           In Out   Varchar2
     ,p_attribute_value_number   In Out   Number
     ,p_attribute_value_char     In Out   Varchar2
     ,p_attribute_value_date     In Out   Varchar2
   );

   Procedure p_delete (p_lookup_code In Out Varchar2, p_lookup_value_code In Varchar2, p_attribute_code In Varchar2);
End LOOKUP_ATTRIBUTE_VALUES_PKG;
/

GRANT EXECUTE ON lookup_attribute_values_pkg TO fc_admin
/

CREATE OR REPLACE 
PACKAGE BODY lookup_attribute_values_pkg As
   Procedure p_delete (p_lookup_code In Out Varchar2, p_lookup_value_code In Varchar2, p_attribute_code In Varchar2) Is
   Begin
      Delete From lookup_attribute_values
            Where lookup_code = p_lookup_code
              And lookup_value_code = p_lookup_value_code
              And attribute_code = p_attribute_code;
   End p_delete;

   Procedure p_ins_upd (
      p_lookup_code              In Out   Varchar2
     ,p_lookup_value_code        In Out   Varchar2
     ,p_attribute_code           In Out   Varchar2
     ,p_attribute_value_number   In Out   Number
     ,p_attribute_value_char     In Out   Varchar2
     ,p_attribute_value_date     In Out   Varchar2
   ) Is
   Begin
      Update    lookup_attribute_values
            Set lookup_code = p_lookup_code
               ,lookup_value_code = p_lookup_value_code
               ,attribute_code = p_attribute_code
               ,attribute_value_number = p_attribute_value_number
               ,attribute_value_char = p_attribute_value_char
               ,attribute_value_date = p_attribute_value_date
          Where lookup_code = p_lookup_code
            And lookup_value_code = p_lookup_value_code
            And attribute_code = p_attribute_code
      Returning lookup_code, lookup_value_code, attribute_code, attribute_value_number, attribute_value_char
               ,attribute_value_date
           Into p_lookup_code, p_lookup_value_code, p_attribute_code, p_attribute_value_number, p_attribute_value_char
               ,p_attribute_value_date;

      If Sql%Rowcount = 0 Then
         Insert Into lookup_attribute_values
                     (lookup_code, lookup_value_code, attribute_code, attribute_value_number, attribute_value_char
                     ,attribute_value_date)
              Values (p_lookup_code, p_lookup_value_code, p_attribute_code, p_attribute_value_number
                     ,p_attribute_value_char, p_attribute_value_date)
           Returning lookup_code, lookup_value_code, attribute_code, attribute_value_number
                    ,attribute_value_char, attribute_value_date
                Into p_lookup_code, p_lookup_value_code, p_attribute_code, p_attribute_value_number
                    ,p_attribute_value_char, p_attribute_value_date;
      End If;
   End p_ins_upd;
End lookup_attribute_values_pkg;
/

DROP PACKAGE lookup_attributes_pkg
/

CREATE OR REPLACE 
Package lookup_attributes_pkg As
   Procedure p_delete (
      p_lookup_code      In Out   Varchar2
     ,p_attribute_code   In Out   Varchar2
     ,p_attribute_name   In Out   Varchar2
     ,p_attribute_type   In Out   Varchar2
   );

   Procedure p_ins_upd (
      p_lookup_code      In Out   Varchar2
     ,p_attribute_code   In Out   Varchar2
     ,p_attribute_name   In Out   Varchar2
     ,p_attribute_type   In Out   Varchar2
   );
End LOOKUP_ATTRIBUTES_PKG;
/


CREATE OR REPLACE 
Package Body lookup_attributes_pkg As
   Procedure p_delete (
      p_lookup_code      In Out   Varchar2
     ,p_attribute_code   In Out   Varchar2
     ,p_attribute_name   In Out   Varchar2
     ,p_attribute_type   In Out   Varchar2
   ) Is
   Begin
      Delete From LOOKUP_ATTRIBUTES
            Where lookup_code = p_lookup_code
              And attribute_code = p_attribute_code
              And attribute_name = p_attribute_name
              And attribute_type = p_attribute_type;
   End p_delete;

   Procedure p_ins_upd (
      p_lookup_code      In Out   Varchar2
     ,p_attribute_code   In Out   Varchar2
     ,p_attribute_name   In Out   Varchar2
     ,p_attribute_type   In Out   Varchar2
   ) Is
   Begin
      Update    LOOKUP_ATTRIBUTES
            Set lookup_code = p_lookup_code
               ,attribute_code = p_attribute_code
               ,attribute_name = p_attribute_name
               ,attribute_type = p_attribute_type
          Where lookup_code = p_lookup_code
            And attribute_code = p_attribute_code
      Returning lookup_code, attribute_code, attribute_name, attribute_type
           Into p_lookup_code, p_attribute_code, p_attribute_name, p_attribute_type;

      If Sql%Rowcount = 0 Then
         Insert Into LOOKUP_ATTRIBUTES
                     (lookup_code, attribute_code, attribute_name, attribute_type)
              Values (p_lookup_code, p_attribute_code, p_attribute_name, p_attribute_type)
           Returning lookup_code, attribute_code, attribute_name, attribute_type
                Into p_lookup_code, p_attribute_code, p_attribute_name, p_attribute_type;
      End If;
   End;
End LOOKUP_ATTRIBUTES_PKG;
/

DROP PACKAGE lookup_values_pkg
/

CREATE OR REPLACE 
PACKAGE lookup_values_pkg As
   Procedure p_ins_upd (
      p_lookup_code            In Out   Varchar2
     ,p_lookup_value_code      In Out   Varchar2
     ,p_lookup_display_value   In Out   Varchar2
     ,p_lookup_value_id        In Out   Number
   );

   Procedure p_delete (p_lookup_value_id In Out Number);
End LOOKUP_VALUES_PKG;
/

GRANT EXECUTE ON lookup_values_pkg TO fc_admin
/

CREATE OR REPLACE 
PACKAGE BODY lookup_values_pkg As
   Procedure p_ins_upd (
      p_lookup_code            In Out   Varchar2
     ,p_lookup_value_code      In Out   Varchar2
     ,p_lookup_display_value   In Out   Varchar2
     ,p_lookup_value_id        In Out   Number
   ) Is
   Begin
      form_utils.check_nulls (args_t (p_lookup_code), args_t ('�� ������ ��� ������'));

      Update lookup_values
         Set lookup_code = p_lookup_code
            ,lookup_value_code = p_lookup_value_code
            ,lookup_display_value = p_lookup_display_value
       Where lookup_value_id = p_lookup_value_id;

      If Sql%Rowcount = 0 Then
         Select main_sq.Nextval
           Into p_lookup_value_id
           From DUAL;

         Select NVL (p_lookup_value_code, main_sq.Nextval)
           Into p_lookup_value_code
           From DUAL;

         Insert Into lookup_values
                     (lookup_code, lookup_value_code, lookup_display_value, lookup_value_id)
              Values (p_lookup_code, p_lookup_value_code, p_lookup_display_value, p_lookup_value_id);
      End If;
   End p_ins_upd;

   Procedure p_delete (p_lookup_value_id In Out Number) Is
   Begin
      Delete From lookup_values
            Where lookup_value_id = p_lookup_value_id;
   End p_delete;
End lookup_values_pkg;
/

DROP PACKAGE lookup_values_pkg_old
/

CREATE OR REPLACE 
Package lookup_values_pkg_old As
   Procedure p_ins_upd (
      p_lookup_code                     Varchar2
     ,p_lookup_value_code               Varchar2
     ,p_lookup_display_value            Varchar2
     ,p_lookup_value_id        In Out   Number
   );

   Procedure p_delete (p_lookup_code Varchar2, p_lookup_value_code Varchar2);
End lookup_values_pkg_old;
/


CREATE OR REPLACE 
Package Body lookup_values_pkg_old As
   /*
   SELECT a.lookup_code, a.lookup_value_code, a.lookup_display_value
     FROM lookup_values a
   */
   Procedure p_ins_upd (
      p_lookup_code                     Varchar2
     ,p_lookup_value_code               Varchar2
     ,p_lookup_display_value            Varchar2
     ,p_lookup_value_id        In Out   Number
   ) Is
   Begin
      form_utils.check_nulls (args_t (p_lookup_code, p_lookup_value_code)
                             ,args_t ('�� ������ ��� ������', '�� ������� �������� ������')
                             );

      Update lookup_values lv
         Set lookup_display_value = p_lookup_display_value
       Where lv.lookup_code = p_lookup_code
         And lv.lookup_value_code = p_lookup_value_code;

      If     Sql%Rowcount = 0
         And p_lookup_code Is Not Null
         And p_lookup_value_code Is Not Null Then
         Insert Into lookup_values
                     (lookup_code, lookup_value_code, lookup_display_value)
              Values (p_lookup_code, p_lookup_value_code, p_lookup_display_value)
           Returning lookup_value_id
                Into p_lookup_value_id;
      End If;
   End p_ins_upd;

   Procedure p_delete (p_lookup_code Varchar2, p_lookup_value_code Varchar2) Is
   Begin
      Delete From lookup_values lv
            Where lv.lookup_code = p_lookup_code
              And lv.lookup_value_code = p_lookup_value_code;
   End p_delete;
End lookup_values_pkg_old;
/

DROP PACKAGE lookups_pkg
/

CREATE OR REPLACE 
PACKAGE lookups_pkg As
  Procedure p_ins_upd(p_lookup_code In Out Varchar2,
                      p_lookup_name Varchar2);
  Procedure p_delete(p_lookup_code Varchar2);
End;
/


CREATE OR REPLACE 
PACKAGE BODY lookups_pkg As
  Procedure p_ins_upd(p_lookup_code In Out Varchar2,
                      p_lookup_name Varchar2) Is
  Begin
    form_utils.check_nulls(args_t(p_lookup_code),
                           args_t('�� ������ ��� ������'));
    Update lookups l
       Set lookup_name = p_lookup_name
     Where l.lookup_code = p_lookup_code;

    If Sql%Rowcount = 0 And p_lookup_code || p_lookup_name Is Not Null Then
      p_lookup_code := NVL(p_lookup_code, UPPER(p_lookup_name));

      Insert Into lookups
        (lookup_code, lookup_name)
      Values
        (p_lookup_code, p_lookup_name);
    End If;
  End;
  Procedure p_delete(p_lookup_code Varchar2) as
  begin
    delete from LOOKUP_VALUES where lookup_code = p_lookup_code;
    delete from LOOKUPS where lookup_code = p_lookup_code;
  end;
End;
/

DROP PACKAGE matrix_rep_demo_pkg
/

CREATE OR REPLACE 
PACKAGE matrix_rep_demo_pkg As
   Type dim_rec Is Record (
      rn                Binary_integer
     ,dimension_name    Varchar2 (200)
     ,dimension_value   Varchar2 (200)
   );

   Type dim_t Is Table Of dim_rec
      Index By Binary_integer;

   Type result_rec Is Record (
      v_dimension_name    Varchar2 (200)
     ,v_dimension_value   Varchar2 (200)
     ,c01                 Varchar2 (200)
     ,c02                 Varchar2 (200)
     ,c03                 Varchar2 (200)
     ,c04                 Varchar2 (200)
     ,c05                 Varchar2 (200)
     ,c06                 Varchar2 (200)
     ,c07                 Varchar2 (200)
     ,c08                 Varchar2 (200)
     ,c09                 Varchar2 (200)
     ,c10                 Varchar2 (200)
     ,c11                 Varchar2 (200)
     ,c12                 Varchar2 (200)
     ,c13                 Varchar2 (200)
     ,c14                 Varchar2 (200)
     ,c15                 Varchar2 (200)
     ,c16                 Varchar2 (200)
     ,c17                 Varchar2 (200)
     ,c18                 Varchar2 (200)
     ,c19                 Varchar2 (200)
     ,c20                 Varchar2 (200)
     ,c21                 Varchar2 (200)
     ,c22                 Varchar2 (200)
     ,c23                 Varchar2 (200)
     ,c24                 Varchar2 (200)
     ,c25                 Varchar2 (200)
     ,c26                 Varchar2 (200)
     ,c27                 Varchar2 (200)
     ,c28                 Varchar2 (200)
     ,c29                 Varchar2 (200)
     ,c30                 Varchar2 (200)
   );

   Type result_t Is Table Of result_rec;

   Function get_query_as_matrix (p_sql_text_vertical Varchar2 Default Null, p_sql_text_horizontal Varchar2 Default Null)
      Return result_t Pipelined;

   Procedure customize_column_metadata (p_column_number Number, p_column_data In Out form_utils.column_rec);
End matrix_rep_demo_pkg;
/


CREATE OR REPLACE 
PACKAGE BODY matrix_rep_demo_pkg As
   Type cur_type Is Ref Cursor;

   g_dim_t        dim_t;
   g_sel_param1   Varchar2 (4000) := 'FORM_COLUMNS';
   g_sel_param2   Varchar2 (4000);

/*   g_base_sql_text   Varchar2 (4000)
      := '
Select   a.column_code dimension_name, a.column_display_number dimension_value
                  From form_columns a
                 Where a.form_code = :g_sel_param1
              Order By dimension_name
';
*/
   Function get_ordered_sql (p_sql_text Varchar2)
      Return Varchar2 Is
   Begin
      Return 'Select ROWNUM rn, a1.* From (' || p_sql_text || ') a1';
   End get_ordered_sql;

   Function get_matrix_sql_text (p_sql_text_vertical Varchar2, p_sql_text_horizontal Varchar2)
      Return Varchar2 Is
   Begin
      Return    '
with t3 as (
        Select t1.rn v_rn, t1.dimension_name v_dimension_name, t1.dimension_value v_dimension_value, t2.rn h_rn
              ,t2.dimension_name h_dimension_name, t2.dimension_value h_dimension_value
              , t1.dimension_value + t2.dimension_value agg_value
          From ('
             || p_sql_text_vertical
             || ') t1, ('
             || p_sql_text_horizontal
             || ') t2
         Where 1 = 1)
Select   t3.v_dimension_name, t3.v_dimension_value, Max (DECODE (h_rn, 1, t3.agg_value)) c01
        ,Max (DECODE (h_rn, 2, t3.agg_value)) c02, Max (DECODE (h_rn, 3, t3.agg_value)) c03
        ,Max (DECODE (h_rn, 4, t3.agg_value)) c04, Max (DECODE (h_rn, 5, t3.agg_value)) c05
        ,Max (DECODE (h_rn, 6, t3.agg_value)) c06, Max (DECODE (h_rn, 7, t3.agg_value)) c07
        ,Max (DECODE (h_rn, 8, t3.agg_value)) c08, Max (DECODE (h_rn, 9, t3.agg_value)) c09
        ,Max (DECODE (h_rn, 10, t3.agg_value)) c10, Max (DECODE (h_rn, 11, t3.agg_value)) c11
        ,Max (DECODE (h_rn, 12, t3.agg_value)) c12, Max (DECODE (h_rn, 13, t3.agg_value)) c13
        ,Max (DECODE (h_rn, 14, t3.agg_value)) c14, Max (DECODE (h_rn, 15, t3.agg_value)) c15
        ,Max (DECODE (h_rn, 16, t3.agg_value)) c16, Max (DECODE (h_rn, 17, t3.agg_value)) c17
        ,Max (DECODE (h_rn, 18, t3.agg_value)) c18, Max (DECODE (h_rn, 19, t3.agg_value)) c19
        ,Max (DECODE (h_rn, 20, t3.agg_value)) c20, Max (DECODE (h_rn, 21, t3.agg_value)) c21
        ,Max (DECODE (h_rn, 22, t3.agg_value)) c22, Max (DECODE (h_rn, 23, t3.agg_value)) c23
        ,Max (DECODE (h_rn, 24, t3.agg_value)) c24, Max (DECODE (h_rn, 25, t3.agg_value)) c25
        ,Max (DECODE (h_rn, 26, t3.agg_value)) c26, Max (DECODE (h_rn, 27, t3.agg_value)) c27
        ,Max (DECODE (h_rn, 28, t3.agg_value)) c28, Max (DECODE (h_rn, 29, t3.agg_value)) c29
        ,Max (DECODE (h_rn, 30, t3.agg_value)) c30
    From t3
Group By v_dimension_value, v_rn, v_dimension_name
Order By v_rn
';
   End get_matrix_sql_text;

   Procedure fill_horizontal_props (p_sql_text_horizontal Varchar2) Is
      c           cur_type;
      l_res_rec   dim_rec;
   Begin
      Open c For get_ordered_sql (p_sql_text_horizontal);                                        -- Using g_sel_param2;

      Loop
         Fetch c
          Into l_res_rec;

         Exit When c%Notfound;
         DBMS_OUTPUT.put_line (l_res_rec.rn || ':' || l_res_rec.dimension_name || '=' || l_res_rec.dimension_value);
         g_dim_t (l_res_rec.rn)    := l_res_rec;
      End Loop;

      Close c;
   End fill_horizontal_props;

   Function get_query_as_matrix (p_sql_text_vertical Varchar2 Default Null, p_sql_text_horizontal Varchar2 Default Null)
      Return result_t Pipelined Is
      c           cur_type;
      l_res_rec   result_rec;
   Begin
      fill_horizontal_props (p_sql_text_horizontal);

      Open c For get_matrix_sql_text (get_ordered_sql (p_sql_text_vertical), get_ordered_sql (p_sql_text_horizontal));

--      Using g_sel_param1, g_sel_param2;
      Loop
         Fetch c
          Into l_res_rec;

         Exit When c%Notfound;
         Pipe Row (l_res_rec);
      End Loop;

      Close c;

      Return;
   End get_query_as_matrix;

   Procedure customize_column_metadata (p_column_number Number, p_column_data In Out form_utils.column_rec) Is
      l_form_sql   Varchar2 (4000);
   Begin
      --���� ��� ������ � ��������
      If p_column_number = 1 Then
         g_dim_t.Delete;

         Select f.sql_text
           Into l_form_sql
           From forms f
          Where f.form_code = p_column_data.form_code;

         Execute Immediate l_form_sql;
      End If;

      If REGEXP_LIKE (p_column_data.column_code, 'C[0-9]{2}') Then
         Declare
            l_dim_rec   dim_rec;
         Begin
            l_dim_rec                           := g_dim_t (SUBSTR (p_column_data.column_code, 2) + 0);
            p_column_data.column_user_name      := l_dim_rec.dimension_name;
            p_column_data.column_description    := l_dim_rec.dimension_name || '-' || l_dim_rec.dimension_value;
            p_column_data.show_hover_flag       := 'Y';
            p_column_data.show_on_grid          := 'Y';
         Exception
            When NO_DATA_FOUND Then
               p_column_data.show_on_grid    := 'N';
         End;
      Else
         Null;                           --DBMS_OUTPUT.put_line (p_column_data.column_code || 'yyyyyyyyyyyyyyyyyyyyy');
      End If;
   End customize_column_metadata;
End matrix_rep_demo_pkg;
/

DROP PACKAGE menus_pkg
/

CREATE OR REPLACE 
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

GRANT EXECUTE ON menus_pkg TO fc_admin
/

CREATE OR REPLACE 
PACKAGE BODY menus_pkg As
  Procedure p_ins_chld(p_menu_code Varchar2, p_element_type varchar2) As
    l_menu_name Varchar2(32000);
  Begin
    if p_element_type in ('FORM', 'FOLDER') then
      Select p_menu_code || '_' || menu_sq.Nextval
        Into l_menu_name
        From DUAL;

      form_utils.check_nulls(args_t(p_menu_code),
                             args_t('�� ������ ��� ����'));

      Insert Into menus
        (parent_menu_code, menu_code, menu_name)
      Values
        (p_menu_code, l_menu_name, l_menu_name);
    else
      form_utils.err_message('�� �� ������ ��������� ��������� ��������� �������� ��������');
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
      form_utils.err_message('�� �� ������ ��������� ��������� ��������� �������� ��������');
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
                             args_t('�� ������� ������������'));
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
      form_utils.err_message('�� �� ������ �������� ��������� �������� = ' ||
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
        form_utils.err_message('������� ��� �������� ��������');
      End If;

      Delete From menus m Where m.menu_code = p_menu_code;
    else
      form_utils.err_message('�� �� ������ ������� ��������� ��������');
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
      form_utils.err_message('�� �� ������ ������� ��������� ��������');
    end if;
  End p_delete_form;

  Function p_get_menu_tree(p_menu_code    varchar2,
                           p_element_type varchar2,
                           p_form_display varchar2) Return menu_tree_table
    Pipelined as
  begin
    if (p_element_type = 'FORM') then

      for rec in (Select 'TABS' menu_code,
                         '�������' menu_name,
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
                         '��������' menu_name,
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
                         '�������' menu_name,
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
                         '��������� �����' menu_name,
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

DROP PACKAGE "S�HEDULE_SHIFTS_PKG"
/

CREATE OR REPLACE 
package "S�HEDULE_SHIFTS_PKG"�HEDULE_SHIFTS_PKG as  end S�HEDULE_SHIFTS_PKG;
/


DROP PACKAGE test_form_pkg
/

CREATE OR REPLACE 
PACKAGE test_form_pkg As
   Procedure p_default_values (p_num In Out Number, p_dt In Out Date, p_txt In Out Varchar2, p_txt2 In Out Varchar2);

   Procedure p_validate_lookup (p_num In Out Number, p_dt In Out Date, p_txt In Out Varchar2, p_txt2 In Out Varchar2);

   Procedure p_delete;
End TEST_FORM_PKG;
/


CREATE OR REPLACE 
PACKAGE BODY test_form_pkg As
   Procedure p_default_values (p_num In Out Number, p_dt In Out Date, p_txt In Out Varchar2, p_txt2 In Out Varchar2) Is
   Begin
      p_num    := DBMS_RANDOM.Value (0, 1000);
      p_dt     := TRUNC (SYSDATE) + p_num;
      p_txt    := TO_CHAR (p_dt);
   End p_default_values;

   Procedure p_validate_lookup (p_num In Out Number, p_dt In Out Date, p_txt In Out Varchar2, p_txt2 In Out Varchar2) Is
   Begin
      p_default_values (p_num, p_dt, p_txt, p_txt2);
   End p_validate_lookup;

   Procedure p_delete Is
   Begin
      Null;
      raise_application_error (-20009, 'xxxxxxxxxxx');
   End;
End TEST_FORM_PKG;
/

DROP PACKAGE text_utils
/

CREATE OR REPLACE 
package text_utils is

  -- Author  : V.SAFRONOV
  -- Created : 23.12.2009 14:52:14
  -- Purpose :

  -- Public type declarations

  function format(p_str varchar2, p_args args_t default null) return varchar2;

end TEXT_UTILS;
/


CREATE OR REPLACE 
package body text_utils is

  function format(p_str varchar2, p_args args_t default null) return varchar2 as
    l_str varchar2(32000) := p_str;
  begin
    if p_args is not null then
      for i in 1 .. p_args.count loop
        l_str := replace(l_str, '%' || i, p_args(i));
      end loop;
    end if;
    return l_str;
  end;

end TEXT_UTILS;
/

DROP PACKAGE text_utils_pkg
/

CREATE OR REPLACE 
PACKAGE text_utils_pkg Is
   Type t_words_arr Is Table Of Varchar2 (4000);

   Type vchar_t Is Table Of Varchar2 (2000)
      Index By Varchar2 (20);

--- ������:
--  1.  ����������� � ������������, ������ ������ ��� 1 ������.
--  2.  ��� ������������� �������� word_num ������ �������� ��� SUBSTR (�����)
   Function del_mul_separators                         --������� �������� ������������� ����������� � ������ ����������
                              (
      strng   In   Varchar2                                                                           --�������� ������
     ,symb    In   Char Default ' '                                                                --������-�����������
   )
      Return Varchar2;

   Function word_count                                               --������� ���������� ���-�� ����, ����������� symb
                      (
      strng   In   Varchar2                                                                           --�������� ������
     ,symb    In   Char Default ' '                                                                --������-�����������
   )
      Return Number;

   Function word                                                                             --������� ���������� �����
                (
      strng      In   Varchar2                                                                        --�������� ������
     ,word_num   In   Number                                                                     --����� ����� � ������
     ,words      In   Number Default 99                                                                  -- ���-�� ����
     ,symb       In   Char Default ' '                                                            -- ������-�����������
   )
      Return Varchar2;

   Function separators (strng In Varchar2                                                             --�������� ������
                                         , symb In Char Default ' '                                --������-�����������
                                                                   )
      Return Varchar2;

   Function WORDS (strng In Varchar2, symb In Char Default ' ')
      Return t_words_arr Pipelined;

   Function get_translated_str (s_rus Varchar2)
      Return Varchar2;

   Function remove_numbers (strng In Varchar2)
      Return Varchar2;

   Function remove_letters (strng In Varchar2)
      Return Number;

   Function get_reverse_str (p_str Varchar2)
      Return Varchar2;
End text_utils_pkg;
/

GRANT EXECUTE ON text_utils_pkg TO fc_admin
/

CREATE OR REPLACE 
PACKAGE BODY text_utils_pkg Is
   l_nums   vchar_t;

------------------------
   Function del_mul_separators_old (strng In Varchar2,                                                --�������� ������
                                                      symb In Char Default ' '                     --������-�����������
                                                                              )
      Return Varchar2
--������� �������� ������������� ����������� � ������ ����������
--���� symb ������ ���� ������ 1. ����� ��������. �����.
/*
--- ��� �����, ��� ��� �������...
Select Replace (Replace (Replace ('aa     bb            cc', ' ', ' _'), '_ '), '_') d
  From DUAL;*/
   As
      result_str   Varchar2 (2000);
      temp_str     Varchar2 (2000);
      cnt          Binary_integer;
      max_loop     Number          Default 7;                         --���-�� ��������. 7 ���������� ��� 500 ��������.
                                                                      --�������� ����� ���� �� �������������.
   Begin
      result_str    := strng;

      For cnt In 1 .. max_loop Loop
         result_str    :=
                Replace (result_str, SUBSTR (TRANSLATE ('xxxxxxxxxx', '_x', '_' || symb), 1, max_loop - cnt + 1), symb);
      End Loop;

      result_str    := Ltrim (Rtrim (result_str, symb), symb);
      Return result_str;
   End del_mul_separators_old;

   Function del_mul_separators (strng In Varchar2,                                                     --�������� ������
                                                  symb In Char Default ' '                          --������-�����������
                                                                          )
      Return Varchar2
--������� �������� ������������� ����������� � ������ ����������
--���� symb ������ ���� ������ 1. ����� ��������. �����.
   As
      result_str   Varchar2 (2000);
      l_hlp_sym    Varchar2 (1)    := '`';
   Begin
      result_str    := Replace (Replace (Replace (strng, symb, symb || l_hlp_sym), l_hlp_sym || symb), l_hlp_sym);
      result_str    := Ltrim (Rtrim (result_str, symb), symb);
      Return result_str;
   End del_mul_separators;

------------------------
   Function word_count (strng In Varchar2, symb In Char Default ' ')
--������� ���������� ���-�� ����, ����������� symb
   Return Number As
      result_str   Varchar2 (2000);
      temp_str     Varchar2 (2000);
      cnt          Binary_integer;
   Begin
      temp_str    := del_mul_separators (strng, symb);                              --������� ������������� �����������
      cnt         := Length (temp_str) - Length (TRANSLATE (temp_str, CHR (0) || symb, CHR (0))) + 1;
--       + LENGTH(symb);
      Return cnt;
   End word_count;

------------------------
   Function word (
      strng      In   Varchar2
     ,                                                                                                 --�������� ������
      word_num   In   Number
     ,                                                                                                     --����� �����
      words      In   Number Default 99
     ,                                                                                                    -- ���-�� ����
      symb       In   Char Default ' '                                                             -- ������-�����������
   )
      Return Varchar2 As
      first_symb_pos   Number;                                                       -- ������� ������� ������� � �����
      last_symb_pos    Number;                                                    -- ������� ���������� ������� � �����
      sgn_word_num     Number;                                                             -- ���� <0 �� � ����� ������
      abs_word_num     Number;
      word_count       Number;                                                            -- ����� ���-�� ���� � ������
      max_words        Number;                                                                                        --
      result_str       Varchar2 (2000);
      temp_str         Varchar2 (2000);
   Begin
      sgn_word_num    := SIGN (word_num);
      abs_word_num    := ABS (word_num);
      word_count      := text_utils_pkg.word_count (strng, symb);
      temp_str        := symb || del_mul_separators (strng, symb) || symb;          --������� ������������� �����������

      If    (abs_word_num > word_count)
         Or word_num = 0 Then
         result_str    := Null;
         Return result_str;
      End If;

      If (words + abs_word_num > word_count) Then
         max_words    := word_count - abs_word_num + 1;
      Else
         max_words    := words;
      End If;

      If sgn_word_num > 0 Then
         first_symb_pos    := INSTR (temp_str, symb, sgn_word_num, abs_word_num) + 1;
--      first_symb_pos := INSTR (temp_str, symb, sgn_word_num, abs_word_num    ) + length(symb);
         last_symb_pos     := INSTR (temp_str, symb, sgn_word_num, abs_word_num + max_words);
      Else
         first_symb_pos    := INSTR (temp_str, symb, sgn_word_num, abs_word_num + max_words) + 1;
--      first_symb_pos := INSTR (temp_str, symb, sgn_word_num, abs_word_num + max_words) + + length(symb);
         last_symb_pos     := INSTR (temp_str, symb, sgn_word_num, abs_word_num);
      End If;

      result_str      := SUBSTR (temp_str, first_symb_pos, last_symb_pos - first_symb_pos);
      Return result_str;
   End word;

--- ������� ������������ ������ ���� �� ������
   Function words (strng In Varchar2, symb In Char Default ' ')
      Return t_words_arr Pipelined Is
      n_count   Number;
   Begin
      n_count    := WORD_COUNT (strng, symb);

      For i In 1 .. n_count Loop
         Pipe Row (WORD (strng, i, 1, symb));
      End Loop;

      Return;
   End words;

------------------------
   Function separators (strng In Varchar2, symb In Char Default ' ')
      Return Varchar2 As
      result_str   Varchar2 (2000);
   Begin
      result_str    :=
         TRANSLATE (strng
                   ,'1 "`.,=-/()*'''
                   , '1' || symb || symb || symb || symb || symb || symb || symb || symb || symb || symb || symb || symb
                   );
      Return result_str;
   End separators;

------------------------
-- ������� ��� ����� �� ���������
   Function remove_letters (strng In Varchar2)
      Return Number As
      result_str   Number;
   Begin
      result_str    := TO_NUMBER (TRANSLATE (strng, '1QWERTYUIOPASDFGHJKLZXCVBNMqwertyuiopasdfghjklzxcvbnm', '1'));
      Return result_str;
   End remove_letters;

------------------------
-- ������� ��� ����� �� ���������
   Function remove_numbers (strng In Varchar2)
      Return Varchar2 As
      result_str   Varchar2 (2000);
   Begin
      result_str    := TRANSLATE (strng, 'A0123456789', 'A');
      Return result_str;
   End remove_numbers;

------------------------
-- ������� ���������� ������ � ���������
   Function get_translated_str (s_rus Varchar2)
      Return Varchar2 As
      Type abc Is Table Of Varchar2 (4)
         Index By Binary_integer;

      abc1     abc;
      Result   Varchar2 (4000);
   Begin
      If s_rus Is Null Then
         Result    := s_rus;
         Return Result;
      End If;

      abc1 (ASCII ('�'))    := 'a';
      abc1 (ASCII ('�'))    := 'b';
      abc1 (ASCII ('�'))    := 'v';
      abc1 (ASCII ('�'))    := 'g';
      abc1 (ASCII ('�'))    := 'd';
      abc1 (ASCII ('�'))    := 'e';
      abc1 (ASCII ('�'))    := 'e';
      abc1 (ASCII ('�'))    := 'zh';
      abc1 (ASCII ('�'))    := 'z';
      abc1 (ASCII ('�'))    := 'i';
      abc1 (ASCII ('�'))    := 'y';
      abc1 (ASCII ('�'))    := 'k';
      abc1 (ASCII ('�'))    := 'l';
      abc1 (ASCII ('�'))    := 'm';
      abc1 (ASCII ('�'))    := 'n';
      abc1 (ASCII ('�'))    := 'o';
      abc1 (ASCII ('�'))    := 'p';
      abc1 (ASCII ('�'))    := 'r';
      abc1 (ASCII ('�'))    := 's';
      abc1 (ASCII ('�'))    := 't';
      abc1 (ASCII ('�'))    := 'u';
      abc1 (ASCII ('�'))    := 'f';
      abc1 (ASCII ('�'))    := 'h';
      abc1 (ASCII ('�'))    := 'c';
      abc1 (ASCII ('�'))    := 'ch';
      abc1 (ASCII ('�'))    := 'sh';
      abc1 (ASCII ('�'))    := 'sch';
      abc1 (ASCII ('�'))    := '';
      abc1 (ASCII ('�'))    := 'y';
      abc1 (ASCII ('�'))    := '';
      abc1 (ASCII ('�'))    := 'e';
      abc1 (ASCII ('�'))    := 'yu';
      abc1 (ASCII ('�'))    := 'ya';
      abc1 (ASCII ('�'))    := 'A';
      abc1 (ASCII ('�'))    := 'B';
      abc1 (ASCII ('�'))    := 'V';
      abc1 (ASCII ('�'))    := 'G';
      abc1 (ASCII ('�'))    := 'D';
      abc1 (ASCII ('�'))    := 'E';
      abc1 (ASCII ('�'))    := 'E';
      abc1 (ASCII ('�'))    := 'ZH';
      abc1 (ASCII ('�'))    := 'Z';
      abc1 (ASCII ('�'))    := 'I';
      abc1 (ASCII ('�'))    := 'Y';
      abc1 (ASCII ('�'))    := 'K';
      abc1 (ASCII ('�'))    := 'L';
      abc1 (ASCII ('�'))    := 'M';
      abc1 (ASCII ('�'))    := 'N';
      abc1 (ASCII ('�'))    := 'O';
      abc1 (ASCII ('�'))    := 'P';
      abc1 (ASCII ('�'))    := 'R';
      abc1 (ASCII ('�'))    := 'S';
      abc1 (ASCII ('�'))    := 'T';
      abc1 (ASCII ('�'))    := 'U';
      abc1 (ASCII ('�'))    := 'F';
      abc1 (ASCII ('�'))    := 'H';
      abc1 (ASCII ('�'))    := 'C';
      abc1 (ASCII ('�'))    := 'CH';
      abc1 (ASCII ('�'))    := 'SH';
      abc1 (ASCII ('�'))    := 'SCH';
      abc1 (ASCII ('�'))    := '';
      abc1 (ASCII ('�'))    := 'Y';
      abc1 (ASCII ('�'))    := '';
      abc1 (ASCII ('�'))    := 'E';
      abc1 (ASCII ('�'))    := 'YU';
      abc1 (ASCII ('�'))    := 'YA';

      For i In 1 .. Length (s_rus) Loop
         Begin
            Result    := Result || abc1 (ASCII (SUBSTR (s_rus, i, 1)));
         Exception
            When NO_DATA_FOUND Then
               Result    := Result || SUBSTR (s_rus, i, 1);
            When Others Then
               Raise;
         End;
      End Loop;

      Return Result;
   End get_translated_str;

   Function get_reverse_str (p_str Varchar2)
      Return Varchar2 Is
      l_res   Varchar2 (32000);
   Begin
      For i In 1 .. Length (p_str) Loop
         l_res    := l_res || SUBSTR (p_str, -i, 1);
      End Loop;

      Return l_res;
   End get_reverse_str;
Begin
   For cr In (Select lookup_value_code + 0 As digit, lv.lookup_display_value As chars
                From lookup_values lv
               Where lv.lookup_code = 'HR_NUMBERS_KZ') Loop
      l_nums (cr.digit)    := cr.chars;
   End Loop;

   l_nums (0)    := Null;
End text_utils_pkg;
/

DROP PACKAGE users_pkg
/

CREATE OR REPLACE 
PACKAGE      users_pkg As
/**
* ������ � ��������������
* @headcom
*/
   Procedure p_delete (p_user_id In Number);

   Procedure p_ins_upd (
      p_user_id        In Out   Number
     ,p_fio            In Out   Varchar2
     ,p_old_username   In       Varchar2
     ,p_username       In Out   Varchar2
     ,p_old_password   In       Varchar2
     ,p_password       In Out   Varchar2
     ,p_orig_ref_id    In Out   Number
     ,p_email          In Out   Varchar2
   );

   Function validate_login (p_username Varchar2, p_password Varchar2, p_url_params Varchar2)
      Return Varchar2;

   Function get_hash_pass (p_username Varchar2, p_password Varchar2)
      Return Varchar2;

   Function get_user_id
      Return users.user_id%Type;

   Procedure user_operation_allowed_check (p_user_id In Number, p_table_name Varchar2);
End USERS_PKG;
/

GRANT EXECUTE ON users_pkg TO ins
/
GRANT EXECUTE ON users_pkg TO fc_admin
/

CREATE OR REPLACE 
PACKAGE BODY      users_pkg As
   g_user_id   users.user_id%Type   := -1;

   Function get_user_id
      Return users.user_id%Type Is
   Begin
      Return g_user_id;
   End get_user_id;

   Function get_hash_pass (p_username Varchar2, p_password Varchar2)
      Return Varchar2 Is
   Begin
      Return RAWTOHEX (UTL_RAW.cast_to_raw (Sys.DBMS_OBFUSCATION_TOOLKIT.MD5 (input_string      =>    p_password
                                                                                                   || UPPER (p_username)
                                                                             )
                                           )
                      );
   End get_hash_pass;

   Function validate_login (p_username Varchar2, p_password Varchar2, p_url_params Varchar2)
      Return Varchar2 Is
      l_password        Varchar2 (4000);
      l_is_valid_flag   Varchar2 (1)    := 'N';
   Begin
      Begin
         Select u.Password, u.user_id
           Into l_password, g_user_id
           From users u
          Where UPPER (u.username) = UPPER (p_username);

         If l_password = get_hash_pass (p_username => UPPER (p_username), p_password => p_password) Then
            l_is_valid_flag    := 'Y';
         Else
            g_user_id          := -1;
            l_is_valid_flag    := 'N';
         End If;
      Exception
         When Others Then
            DBMS_OUTPUT.put_line (SQLERRM);
      End;

      Return l_is_valid_flag;
   End validate_login;

   Procedure p_ins_upd (
      p_user_id        In Out   Number
     ,p_fio            In Out   Varchar2
     ,p_old_username   In       Varchar2
     ,p_username       In Out   Varchar2
     ,p_old_password   In       Varchar2
     ,p_password       In Out   Varchar2
     ,p_orig_ref_id    In Out   Number
     ,p_email          In Out   Varchar2
   ) Is
      /*
   Update users u
      Set u.Password = users_pkg.get_hash_pass (u.username, 'qwerty')
    Where user_id = p_user_id;
      */
   Begin
      --TODO ��� ����� UserName ��������� ���������� ������
      If NVL (p_old_password, '#$#$#') != NVL (p_password, '#$#$#') Then
         p_password    := get_hash_pass (p_username => p_username, p_password => p_password);
      End If;

      Update users u
         Set u.fio = p_fio
            ,u.username = p_username
            ,u.Password = p_password
            ,u.orig_ref_id = p_orig_ref_id
            ,u.email = p_email
       Where user_id = p_user_id;

      If 0 = Sql%Rowcount Then
         Select main_sq.Nextval
           Into p_user_id
           From DUAL;

         Insert Into users
                     (user_id, fio, username, Password, orig_ref_id, email)
              Values (p_user_id, p_fio, p_username, p_password, p_orig_ref_id, p_email);
      End If;
   End p_ins_upd;

   Procedure p_delete (p_user_id In Number) Is
   Begin
      Delete From users u
            Where u.user_id = p_user_id;
   End p_delete;

   Procedure user_operation_allowed_check (p_user_id In Number, p_table_name Varchar2) Is
      l_cnt   Number;
   Begin
      /*��������*/
      Select Count (*)
        Into l_cnt
        From apps_role_users a
       Where A.user_id = p_user_id
         And A.role_code = 'INS_ADMIN';

      If     l_cnt = 0
         And p_table_name Not In
                         ('INS_VISITS', 'INS_VISIT_RESULTS', 'INS_ACCOUNT_LINES', 'INS_MEDICAL_SERVICE', 'INS_COMPANY') Then
         raise_application_error (-20001, '��� �������!!');
      End If;
   End;
End USERS_PKG;
/

