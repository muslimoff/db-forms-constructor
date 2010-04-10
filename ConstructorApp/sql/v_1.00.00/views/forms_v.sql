-- Start of DDL Script for View FC.FORMS_V
-- Generated 10.04.2010 22:54:26 from FC@VM_XE

CREATE force View forms_v (
   form_code,
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
   object_version_number,
   default_column_width )
As
Select a.form_code, a.hot_key, a.sql_text, NVL (a.form_name, a.form_code) form_name, a.description, a.form_type
      ,a.show_tree_root_node, a.icon_id, a.form_width, a.form_height
      ,NVL (a.bottom_tabs_orientation, 'T') bottom_tabs_orientation
      ,NVL (a.side_tabs_orientation, 'T') side_tabs_orientation, NVL (a.show_bottom_toolbar, 'Y') show_bottom_toolbar
      ,a.object_version_number, a.default_column_width
  From forms a
 Where 1 = 1
   And (   SYS_CONTEXT ('USERENV', 'SESSION_USER') = '&fc_user'
        Or a.form_code In (
                          Select ap.form_code
                            From apps_privs ap, APPLICATIONS a
                           Where a.apps_code = ap.apps_code
                             And (a.schema_name In (Select username
                                                      From user_users
                                                     Where user_id = USERENV ('SCHEMAID'))))
       )
/

-- Grants for View
Grant Select On forms_v To app_rates
/
Grant Select On forms_v To mz_so_integration
/

-- End of DDL Script for View FC.FORMS_V

