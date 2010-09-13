spool log1
set define off
Alter Table forms Disable Constraint forms_form_actions_fk;
@APPS_ROLES.sql
@APPS_ROLE_MENUS.sql
@APPS_ROLE_USERS.sql
@COLUMNS_LIST.sql
@DBLCLICK_FORM_ACT_LIST.sql
@FORMS.sql
@FORMS2.sql
@FORMS_LIST.sql
@FORM_ACTIONS.sql
@FORM_COLUMNS.sql
@FORM_TABS.sql
@FORM_TABS_LIST.sql
@ICONS.sql
@LOOKUPS_LIST.sql
@LOOKUP_ATTRIBUTES.sql
@LOOKUP_ATTRIBUTE_VALUES.sql
@LOOKUP_VALUES.sql
@MENUS.sql
@REPORTS.sql
@USERS.sql

Alter Table forms Enable Constraint forms_form_actions_fk;