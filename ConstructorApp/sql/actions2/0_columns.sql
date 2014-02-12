Alter Table form_actions Add autocommit Varchar2(1) DEFAULT 'Y';
Alter Table form_actions Add status_button_param            Varchar2(255);
Alter Table form_actions Add status_msg_level_param         Varchar2(255);
Alter Table form_actions Add status_msg_txt_param           Varchar2(4000);
Comment On Column form_actions.autocommit Is 'Автокоммит';
Comment On Column form_actions.child_form_code Is 'Вызов дочерней формы в новом табе/окне';
Comment On Column form_actions.display_in_context_menu Is 'Отображать в контекстном меню?';
Comment On Column form_actions.parent_action_code Is 'Действие-родитель. Для выполнения последовательности действий';
Comment On Column form_actions.status_button_param Is 'Имя параметра PL/SQL процедуры для передачи номера кнопки для (статуса WARN)';
Comment On Column form_actions.status_msg_level_param Is 'Имя параметра PL/SQL процедуры для передачи статуса выполнения (Пусто-OK, 1-WARN, 2-ERR, 3-CANCEL)';
Comment On Column form_actions.status_msg_txt_param Is 'Имя параметра PL/SQL процедуры для передачи текста сообщения и кнопок';

Alter Table form_actions Drop Column status_parameter_name;

