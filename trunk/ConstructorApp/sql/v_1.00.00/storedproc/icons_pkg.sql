-- Start of DDL Script for Package FC.ICONS_PKG
-- Generated 10.04.2010 22:27:13 from FC@VM_XE

Create Or Replace 
PACKAGE icons_pkg Is
   -- Author  : V.SAFRONOV
   -- Created : 23.12.2009 11:05:23
   -- Purpose :

   -- Public type declarations
   Procedure p_ins_upd (
      p_icon_id          icons.icon_id%Type
     ,p_icon_file_name   icons.icon_file_name%Type
     ,p_icon_path        icons.icon_path%Type
   );

   Procedure p_delete (p_icon_id icons.icon_id%Type);
End ICONS_PKG;
/


Create Or Replace 
PACKAGE BODY icons_pkg Is
   Procedure p_ins_upd (
      p_icon_id          icons.icon_id%Type
     ,p_icon_file_name   icons.icon_file_name%Type
     ,p_icon_path        icons.icon_path%Type
   ) As
   Begin
      form_utils.check_nulls (args_t (p_icon_id, p_icon_file_name)
                             ,args_t ('Не указан код иконки', 'Не указан файл иконки')
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


-- End of DDL Script for Package FC.ICONS_PKG

