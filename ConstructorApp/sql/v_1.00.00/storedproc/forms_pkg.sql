-- Start of DDL Script for Package FC.FORMS_PKG
-- Generated 10.04.2010 22:26:53 from FC@VM_XE

Create Or Replace 
PACKAGE forms_pkg As
  Procedure p_insert_update(p_form_code               forms.form_code%Type,
                            p_hot_key                 forms.hot_key%Type,
                            p_sql_text                forms.sql_text%Type,
                            p_form_name               forms.form_name%Type,
                            p_description             forms.description%Type,
                            p_form_type               In Out forms.form_type%Type,
                            p_show_tree_root_node     In Out forms.show_tree_root_node%Type,
                            p_icon_id                 forms.icon_id%Type,
                            p_form_width              In Out forms.form_width%Type,
                            p_form_height             In Out forms.form_height%Type,
                            p_bottom_tabs_orientation forms.bottom_tabs_orientation%Type,
                            p_side_tabs_orientation   forms.side_tabs_orientation%Type,
                            p_show_bottom_toolbar     forms.show_bottom_toolbar%Type,
                            p_default_column_width    In Out forms.default_column_width%Type,
                            p_object_version_number   Out forms.object_version_number%Type);

  Procedure generate_package(p_form_code forms.form_code%Type);
End FORMS_PKG;
/


Create Or Replace 
PACKAGE BODY forms_pkg As
  /*
  SELECT a.form_code, a.hot_key, a.sql_text, a.form_name, a.description,
         a.form_type, a.show_tree_root_node, a.icon_id, a.form_width,
         a.form_height, a.bottom_tabs_orientation,
         a.side_tabs_orientation, a.show_bottom_toolbar,
         a.object_version_number, a.default_column_width
    FROM forms a
    */
  Procedure p_insert_update(p_form_code               forms.form_code%Type,
                            p_hot_key                 forms.hot_key%Type,
                            p_sql_text                forms.sql_text%Type,
                            p_form_name               forms.form_name%Type,
                            p_description             forms.description%Type,
                            p_form_type               In Out forms.form_type%Type,
                            p_show_tree_root_node     In Out forms.show_tree_root_node%Type,
                            p_icon_id                 forms.icon_id%Type,
                            p_form_width              In Out forms.form_width%Type,
                            p_form_height             In Out forms.form_height%Type,
                            p_bottom_tabs_orientation forms.bottom_tabs_orientation%Type,
                            p_side_tabs_orientation   forms.side_tabs_orientation%Type,
                            p_show_bottom_toolbar     forms.show_bottom_toolbar%Type,
                            p_default_column_width    In Out forms.default_column_width%Type,
                            p_object_version_number   Out forms.object_version_number%Type) Is
  Begin
    --еще - см. триггер на табличке
    form_utils.check_nulls(args_t(p_form_code),
                           args_t('Не указан код формы'));
  
    Update forms a
       Set a.hot_key                 = p_hot_key,
           a.sql_text                = p_sql_text,
           a.form_name               = p_form_name,
           a.description             = p_description,
           a.form_type               = p_form_type,
           a.show_tree_root_node     = p_show_tree_root_node,
           a.icon_id                 = p_icon_id,
           a.form_width              = p_form_width,
           a.form_height             = p_form_height,
           a.bottom_tabs_orientation = p_bottom_tabs_orientation,
           a.side_tabs_orientation   = p_side_tabs_orientation,
           a.show_bottom_toolbar     = p_show_bottom_toolbar,
           a.object_version_number   = a.object_version_number + 1,
           a.default_column_width    = p_default_column_width
     Where a.form_code = p_form_code;
  
    If Sql%Rowcount = 0 Then
      Insert Into forms
        (form_code,
         hot_key,
         sql_text,
         form_name,
         description,
         form_type,
         show_tree_root_node,
         icon_id,
         form_width,
         form_height,
         bottom_tabs_orientation,
         side_tabs_orientation,
         show_bottom_toolbar,
         default_column_width,
         object_version_number)
      Values
        (p_form_code,
         p_hot_key,
         p_sql_text,
         p_form_name,
         p_description,
         p_form_type,
         p_show_tree_root_node,
         p_icon_id,
         p_form_width,
         p_form_height,
         p_bottom_tabs_orientation,
         p_side_tabs_orientation,
         p_show_bottom_toolbar,
         p_default_column_width,
         1)
      Returning object_version_number Into p_object_version_number;
    
      Null;
    End If;
  End p_insert_update;

  Procedure generate_package(p_form_code forms.form_code%Type) Is
    l_proc_param Varchar2(4000);
    l_upd_set    Varchar2(4000);
    l_into_cl    Varchar2(4000);
    l_val_cl     Varchar2(4000);
    l_proc_def   Varchar2(4000);
  Begin
    Select SUBSTR(Replace(stragg(LOWER(',p_' || column_code || ' in out ' ||
                                       p_form_code || '.' || column_code ||
                                       '%type')),
                          ' / ',
                          CHR(10)),
                  2) proc_param,
           SUBSTR(Replace(stragg(LOWER(',' || column_code || ' = ' || 'p_' ||
                                       column_code)),
                          ' / ',
                          CHR(10)),
                  2) upd_set,
           SUBSTR(Replace(stragg(LOWER(',' || column_code)), ' / ', CHR(10)),
                  2) into_cl,
           SUBSTR(Replace(stragg(LOWER(',p_' || column_code)),
                          ' / ',
                          CHR(10)),
                  2) val_cl
      Into l_proc_param, l_upd_set, l_into_cl, l_val_cl
      From Table(form_utils.describe_form_columns_pl(p_form_code))
     Order By form_code, column_display_number, column_code;
  
    l_proc_def := 'procedure p_update(' || l_proc_param || ')';
    DBMS_OUTPUT.put_line(l_proc_def);
  End generate_package;
End FORMS_PKG;
/


-- End of DDL Script for Package FC.FORMS_PKG

