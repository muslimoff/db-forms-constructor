DROP VIEW binds_v
/

CREATE OR REPLACE VIEW binds_v (
   form_code,
   position,
   datatype,
   max_length,
   array_len,
   bind_name )
AS
Select "FORM_CODE", "POSITION", "DATATYPE", "MAX_LENGTH", "ARRAY_LEN", "BIND_NAME"
     From Table (form_utils.get_binds ())
/

DROP VIEW form_tabs_v
/

CREATE OR REPLACE VIEW form_tabs_v (
   form_code,
   tab_code,
   child_form_code,
   tab_position,
   tab_name,
   number_of_columns,
   icon_id,
   tab_type,
   tab_display_number )
AS
Select ft.form_code, ft.tab_code, ft.child_form_code, NVL (ft.tab_position, 'R') tab_position
         ,NVL (ft.tab_name, (Select NVL (f.form_name, f.form_code)
                               From forms f
                              Where f.form_code = ft.child_form_code)) tab_name
         ,NVL (ft.number_of_columns, 2) number_of_columns
         ,NVL (ft.icon_id, (Select f.icon_id
                              From forms f
                             Where f.form_code = ft.child_form_code)) icon_id, ft.tab_type, tab_display_number
     From form_tabs ft
/

GRANT SELECT ON form_tabs_v TO mz_so_integration
/
GRANT SELECT ON form_tabs_v TO tc
/
GRANT SELECT ON form_tabs_v TO ins
/
GRANT SELECT ON form_tabs_v TO aahr_orders
/
GRANT SELECT ON form_tabs_v TO bf
/
GRANT SELECT ON form_tabs_v TO fc_admin
/
DROP VIEW forms_v
/

CREATE OR REPLACE VIEW forms_v (
   apps_code,
   export_order,
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
   default_column_width,
   double_click_action_code,
   lookup_width )
AS
Select a.apps_code, a.export_order, a.form_code, a.hot_key, a.sql_text, NVL (a.form_name, a.form_code) form_name
         ,a.description, a.form_type, a.show_tree_root_node, a.icon_id, a.form_width, a.form_height
         ,NVL (a.bottom_tabs_orientation, 'T') bottom_tabs_orientation
         ,NVL (a.side_tabs_orientation, 'T') side_tabs_orientation, NVL (a.show_bottom_toolbar
                                                                        ,'Y') show_bottom_toolbar
         ,a.object_version_number, a.default_column_width, double_click_action_code, lookup_width
     From forms a
    Where 1 = 1
      And (   SYS_CONTEXT ('USERENV', 'SESSION_USER') = applications_pkg.get_fc_schema ()
           Or a.form_code In (Select ap.form_code
                                From apps_privs ap, APPLICATIONS a
                               Where a.apps_code = ap.apps_code
                                 And (a.schema_name = User))
          )
/

GRANT SELECT ON forms_v TO app_rates
/
GRANT SELECT ON forms_v TO mz_so_integration
/
GRANT SELECT ON forms_v TO tc
/
GRANT SELECT ON forms_v TO ins
/
GRANT SELECT ON forms_v TO aahr_orders
/
GRANT SELECT ON forms_v TO bf
/
GRANT SELECT ON forms_v TO fc_admin
/
