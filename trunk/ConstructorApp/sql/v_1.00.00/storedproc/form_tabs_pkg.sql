-- Start of DDL Script for Package FC.FORM_TABS_PKG
-- Generated 10.04.2010 22:25:46 from FC@VM_XE

Create Or Replace 
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


Create Or Replace 
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
                           args_t('Не указан код формы',
                                  'Не указан код закладки'));
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


-- End of DDL Script for Package FC.FORM_TABS_PKG

