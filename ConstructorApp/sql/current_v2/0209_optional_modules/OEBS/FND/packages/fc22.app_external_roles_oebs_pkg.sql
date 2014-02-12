-- Start of DDL Script for Package FC22.APP_EXTERNAL_ROLES_OEBS_PKG
-- Generated 17.11.2013 3:02:36 from FC22@KZM_HRDEV

Create Or Replace Package app_external_roles_oebs_pkg As
   Procedure p_ins_upd (
      p_app_external_role_id   In Out   Number
     ,p_role_code              In Out   Varchar2
     ,p_external_role_id       In Out   Number
     ,p_responsibility_key     In Out   Varchar2
     ,p_responsibility_name    In Out   Varchar2
   );

   Procedure p_delete (
      p_app_external_role_id   In Out   Number
     ,p_role_code              In Out   Varchar2
     ,p_external_role_id       In Out   Number
     ,p_responsibility_key     In Out   Varchar2
     ,p_responsibility_name    In Out   Varchar2
   );
End APP_EXTERNAL_ROLES_OEBS_PKG;
/

Create Or Replace Package Body app_external_roles_oebs_pkg As
   Procedure p_ins_upd (
      p_app_external_role_id   In Out   Number
     ,p_role_code              In Out   Varchar2
     ,p_external_role_id       In Out   Number
     ,p_responsibility_key     In Out   Varchar2
     ,p_responsibility_name    In Out   Varchar2
   ) Is
   Begin
      Update APP_EXTERNAL_ROLES
         Set app_external_role_id = p_app_external_role_id
            ,role_code = p_role_code
            ,external_role_id = p_external_role_id
       Where app_external_role_id = p_app_external_role_id;

      If Sql%Rowcount = 0 Then
         Select main_sq.Nextval
           Into p_app_external_role_id
           From DUAL;

         Insert Into APP_EXTERNAL_ROLES
                     (app_external_role_id, role_code, external_role_id)
              Values (p_app_external_role_id, p_role_code, p_external_role_id);
      End If;
   End p_ins_upd;

   Procedure p_delete (
      p_app_external_role_id   In Out   Number
     ,p_role_code              In Out   Varchar2
     ,p_external_role_id       In Out   Number
     ,p_responsibility_key     In Out   Varchar2
     ,p_responsibility_name    In Out   Varchar2
   ) Is
   Begin
      Delete From APP_EXTERNAL_ROLES
            Where app_external_role_id = p_app_external_role_id;
   End p_delete;
End APP_EXTERNAL_ROLES_OEBS_PKG;
/

-- End of DDL Script for Package FC22.APP_EXTERNAL_ROLES_OEBS_PKG

