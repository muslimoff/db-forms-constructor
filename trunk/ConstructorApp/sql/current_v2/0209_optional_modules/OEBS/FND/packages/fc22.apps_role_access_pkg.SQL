-- Start of DDL Script for Package FC22.APPS_ROLE_ACCESS_PKG
-- Generated 17.11.2013 3:03:20 from FC22@KZM_HRDEV

Create Or Replace Package apps_role_access_pkg Is
   -- Author  : USER
   -- Created : 08.09.2013 8:03:14
   -- Purpose :

   -- Public type declarations
   Type apps_obj_t Is Table Of apps_obj_g%Rowtype;

   Type apps_obj_t_pl Is Table Of apps_obj_g%Rowtype
      Index By Binary_integer;

   g_apps_obj_t   apps_obj_t_pl;
   g_refresh      Varchar2 (15) := 'N';

   -- Public function and procedure declarations
   Function get_apps_objects (p_form_code In Varchar2 Default Null)
      Return apps_obj_t Pipelined;

   --
   Function get_child_apps_objects (p_entity_path In Varchar2 Default Null)
      Return apps_obj_t Pipelined;
End apps_role_access_pkg;
/

Create Or Replace Package Body apps_role_access_pkg Is
   -- Private declarations
   Cursor apps_obj_cur (c_form_code Varchar2) Is
      With ent As
           (
              Select 'FORM' entity_type, form_code entity_code, '' parent_entity_type, '' parent_entity_code
                    ,NVL (f.form_name, form_code) display_name, Null + 0 display_number, '' master_entity_code
                    ,'' master_entity_type
                From forms f
              Union All
              Select entity_type, form_code || '*' || entity_type entity_code, 'FORM' parent_entity_type
                    ,form_code parent_entity_code, display_name, Null + 0 display_number, '' master_entity_code
                    ,'' master_entity_type
                From forms
                    , (Select     DECODE (Level, 1, 'COLUMNS', 2, 'TABS', 3, 'ACTIONS') entity_type
                                 ,DECODE (Level, 1, 'Колонки', 2, 'Вкладки', 3, 'Действия') display_name
                             From DUAL
                       Connect By Level <= 3)
              Union All
              Select entity_type entity_type, f.form_code || '*' || entity_type entity_code
                    ,'TAB_FRM' parent_entity_type, t.form_code || '*' || t.tab_code parent_entity_code, display_name
                    , Null + 0 display_number, t.form_code master_entity_code, 'FORM' master_entity_type
                From form_tabs t
                    ,forms f
                    , (Select     DECODE (Level, 1, 'COLUMNS', 2, 'TABS', 3, 'ACTIONS') entity_type
                                 ,DECODE (Level, 1, 'Колонки', 2, 'Вкладки', 3, 'Действия') display_name
                             From DUAL
                       Connect By Level <= 3)
               Where t.child_form_code = f.form_code
              Union All
              Select 'COLUMN' entity_type, c.column_code entity_code, 'COLUMNS' parent_entity_type
                    , c.form_code || '*COLUMNS' parent_entity_code, NVL (c.column_user_name
                                                                        ,c.column_code) display_name
                    ,c.column_display_number display_number, '' master_entity_code, '' master_entity_type
                From form_columns c
              Union All
              Select 'ACTION' entity_type, a.action_code entity_code, 'ACTIONS' parent_entity_type
                    , a.form_code || '*ACTIONS' parent_entity_code
                    ,NVL (a.action_display_name, a.action_code) display_name, a.display_number, '' master_entity_code
                    ,'' master_entity_type
                From form_actions a
              Union All
              Select DECODE (t.tab_type, 1, 'TAB_EDT', 3, 'TAB_DYN', 'TAB_FRM') entity_type
                    , t.form_code || '*' || t.tab_code entity_code, 'TABS' parent_entity_type
                    , t.form_code || '*TABS' parent_entity_code, NVL (t.tab_name, t.tab_code) display_name
                    ,t.tab_display_number, '' master_entity_code, '' master_entity_type
                From form_tabs t
              Union All
              Select 'FORM' entity_type, f.form_code entity_code, 'TAB_FRM' parent_entity_type
                    , t.form_code || '*' || t.tab_code parent_entity_code
                    ,NVL (NVL (t.tab_name, f.form_name), f.form_code) display_name, Null + 0 display_number
                    ,t.form_code master_entity_code, 'FORM' master_entity_type
                From form_tabs t, forms f
               Where t.child_form_code = f.form_code
              Union All
              Select 'EDIT_COL' entity_type, c.column_code entity_code, 'TAB_EDT' parent_entity_type
                    , t.form_code || '*' || t.tab_code parent_entity_code
                    ,NVL (c.column_user_name, c.column_code) display_name, c.column_display_number display_number
                    ,'' master_entity_code, '' master_entity_type
                From form_tabs t, form_columns c
               Where t.form_code = c.form_code
                 And t.tab_type = 1
                 And c.editor_tab_code = t.tab_code)
      Select     entity_type, entity_code, display_name, display_number, parent_entity_type, parent_entity_code
                ,master_entity_code, master_entity_type
                ,SYS_CONNECT_BY_PATH (entity_type || '*' || entity_code, '/') entity_path
                ,Replace (SYS_CONNECT_BY_PATH (entity_type || '*' || entity_code, '/') || '/'
                         , '/' || entity_type || '*' || entity_code || '/'
                         ) parent_entity_path
                ,Replace (SYS_CONNECT_BY_PATH (master_entity_type || '*' || master_entity_code, '/')
                         ,'/*'
                         ) master_entity_path
            From ent e
      Start With parent_entity_type Is Null
             And parent_entity_code Is Null
             And entity_code = NVL (c_form_code, entity_code)
      Connect By Nocycle Prior entity_code = parent_entity_code
             And Prior entity_type = parent_entity_type;

   --
   Procedure Init_apps_obj As
      i   Number := 1;
   Begin
      If    g_refresh = 'Y'
         Or g_apps_obj_t.Count = 0 Then
         g_apps_obj_t.Delete;
         i    := 0;

         For cr In apps_obj_cur ('') Loop
            i                   := i + 1;
            g_apps_obj_t (i)    := cr;
         End Loop;
      End If;
   End;

   --
   Function get_apps_objects (p_form_code In Varchar2 Default Null)
      Return apps_obj_t Pipelined Is
   Begin
      Init_apps_obj;

      For cr In g_apps_obj_t.First .. g_apps_obj_t.Last Loop
         If g_apps_obj_t.Exists (cr) Then
            If g_apps_obj_t (cr).entity_path Like '/FORM*' || UPPER (p_form_code) || '%' Then
               Pipe Row (g_apps_obj_t (cr));
            End If;
         End If;
      End Loop;

      Return;
   End;

   --
   Function get_child_apps_objects (p_entity_path In Varchar2 Default Null)
      Return apps_obj_t Pipelined Is
   Begin
      Init_apps_obj;

      For cr In g_apps_obj_t.First .. g_apps_obj_t.Last Loop
         If g_apps_obj_t.Exists (cr) Then
            If NVL (g_apps_obj_t (cr).parent_entity_path, '#') = NVL (p_entity_path, '#') Then
               Pipe Row (g_apps_obj_t (cr));
            End If;
         End If;
      End Loop;

      Return;
   End;
Begin
   -- Initialization
   Null;
End apps_role_access_pkg;
/

-- End of DDL Script for Package FC22.APPS_ROLE_ACCESS_PKG

