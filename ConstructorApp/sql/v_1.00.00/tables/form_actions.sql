-- Start of DDL Script for Table FC.FORM_ACTIONS
-- Generated 10.04.2010 20:51:24 from FC@VM_XE

Create Table form_actions
    (form_code                      Varchar2(255),
    action_code                    Varchar2(255),
    procedure_name                 Varchar2(255),
    action_display_name            Varchar2(255),
    icon_id                        Number,
    default_param_prefix           Varchar2(255),
    default_old_param_prefix       Varchar2(255),
    action_type                    Varchar2(2),
    display_number                 Number,
    confirm_text                   Varchar2(4000) Default 'Вы уверенны?',
    hot_key                        Varchar2(255),
    show_separator_below           Varchar2(1) Default 'N',
    display_on_toolbar             Varchar2(1) Default 'Y')
/

-- Grants for Table
Grant Select On form_actions To mz_so_integration
/




-- End of DDL Script for Table FC.FORM_ACTIONS

