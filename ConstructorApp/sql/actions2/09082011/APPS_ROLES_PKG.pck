CREATE OR REPLACE PACKAGE APPS_ROLES_PKG As
   Procedure p_ins_upd (
      p_apps_role_id     In Out   Number
     ,p_role_code        In Out   Varchar2
     ,p_role_name        In Out   Varchar2
     ,p_apps_code        In Out   Varchar2
     ,p_root_menu_code   In Out   Varchar2
     ,p_external_role_id In Out   Varchar2
   );

   Procedure p_delete (p_apps_role_id In Out Number);
End apps_roles_pkg;
/
CREATE OR REPLACE PACKAGE BODY APPS_ROLES_PKG As
   Procedure p_ins_upd (
      p_apps_role_id     In Out   Number
     ,p_role_code        In Out   Varchar2
     ,p_role_name        In Out   Varchar2
     ,p_apps_code        In Out   Varchar2
     ,p_root_menu_code   In Out   Varchar2
     ,p_external_role_id In Out   Varchar2
   ) Is
   Begin
      Update apps_roles
         Set role_code = p_role_code
            ,role_name = p_role_name
            ,apps_code = p_apps_code
            ,root_menu_code = p_root_menu_code
            ,external_role_id = p_external_role_id
       Where apps_role_id = p_apps_role_id;

      If Sql%Rowcount = 0 Then
         Select main_sq.Nextval
           Into p_apps_role_id
           From DUAL;

         Insert Into apps_roles
                     (apps_role_id, role_code, role_name, apps_code, root_menu_code, external_role_id)
              Values (p_apps_role_id, p_role_code, p_role_name, p_apps_code, p_root_menu_code
                     ,p_external_role_id);
      End If;
   End p_ins_upd;

   Procedure p_delete (p_apps_role_id In Out Number) Is
   Begin
      Delete From apps_roles
            Where apps_role_id = p_apps_role_id;
   End p_delete;
End apps_roles_pkg;
/
