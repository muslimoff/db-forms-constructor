set define off
PROMPT ================================TABLES START==================================
@@_00_sequences.sql
PROMPT ================================TABLES:GLOBALS================================
@@global_params.sql
@@icons.sql
@@report_templates.sql

PROMPT ================================TABLES:LOOKUPS================================
@@lookups.sql
@@lookup_values.sql
@@lookup_attributes.sql
@@lookup_attribute_values.sql

PROMPT ================================TABLES:FORMS==================================
@@forms.sql
@@form_columns$.sql
@@form_columns.sql

@@form_actions.sql
@@form_column_actions.sql
@@form_column_lookup_map.sql

@@form_tabs.sql
@@form_tab_childs_allowed.sql
@@form_tab_parent_exclns.sql

@@form_props.sql
@@form_prop_values.sql

PROMPT ================================TABLES:ROLES==================================
@@applications.sql
@@users.sql
@@apps_privs.sql
@@apps_roles.sql
@@apps_role_menus.sql
@@apps_role_users.sql
@@menus.sql

PROMPT ================================TABLES CONSTRAINTS============================
@@_99_constraints_after.sql 

PROMPT ================================TABLES END====================================


set define on