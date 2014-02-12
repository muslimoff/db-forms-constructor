-- Start of DDL Script for Table FC22.FORM_ACTIONS
-- Generated 16.11.2013 23:00:13 from FC22@XE

Create Table form_actions
    (form_code                      Varchar2(255) Not Null,
    action_code                    Varchar2(255) Not Null,
    procedure_name                 Varchar2(255),
    action_display_name            Varchar2(255),
    icon_id                        Number,
    default_param_prefix           Varchar2(255),
    default_old_param_prefix       Varchar2(255),
    action_type                    Varchar2(2),
    display_number                 Number,
    confirm_text                   Varchar2(4000) Default 'Вы уверены?',
    hot_key                        Varchar2(255),
    show_separator_below           Varchar2(1) Default 'N',
    display_on_toolbar             Varchar2(1) Default 'Y',
    child_form_code                Varchar2(255),
    url_text                       Varchar2(4000),
    parent_action_code             Varchar2(255),
    display_in_context_menu        Varchar2(1) Default 'Y',
    autocommit                     Varchar2(1) Default 'Y',
    status_button_param            Varchar2(255),
    status_msg_level_param         Varchar2(255),
    status_msg_txt_param           Varchar2(4000))
/

-- Constraints for FORM_ACTIONS

Alter Table form_actions
Add Constraint form_actions_pk Primary Key (form_code, action_code)
Using Index
/


-- Comments for FORM_ACTIONS

Comment On Column form_actions.autocommit Is 'Автокоммит'
/
Comment On Column form_actions.child_form_code Is 'Вызов дочерней формы в новом табе/окне'
/
Comment On Column form_actions.display_in_context_menu Is 'Отображать в контекстном меню?'
/
Comment On Column form_actions.parent_action_code Is 'Действие-родитель. Для выполнения последовательности действий'
/
Comment On Column form_actions.status_button_param Is 'Имя параметра PL/SQL процедуры для передачи номера кнопки для (статуса WARN)'
/
Comment On Column form_actions.status_msg_level_param Is 'Имя параметра PL/SQL процедуры для передачи статуса выполнения (Пусто-OK, 1-WARN, 2-ERR, 3-CANCEL)'
/
Comment On Column form_actions.status_msg_txt_param Is 'Имя параметра PL/SQL процедуры для передачи текста сообщения и кнопок'
/
Comment On Column form_actions.url_text Is 'URL после выполнения действия'
/

-- End of DDL Script for Table FC22.FORM_ACTIONS

