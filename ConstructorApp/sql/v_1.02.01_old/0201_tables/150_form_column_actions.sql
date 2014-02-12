Create Table fc22.form_column_actions
    (form_column_action_id          Number,
    form_code                      Varchar2(255) Not Null,
    column_code                    Varchar2(255) Not Null,
    action_code                    Varchar2(255) Not Null,
    action_key_code                Varchar2(255),
    col_action_type_code           Varchar2(255) Not Null)
/

Alter Table fc22.form_column_actions
Add Constraint form_column_actions_pk Primary Key (form_code, column_code, 
  action_code, col_action_type_code)
Using Index
/



Comment On Column fc22.form_column_actions.action_code Is 'Код действия'
/
Comment On Column fc22.form_column_actions.action_key_code Is 'Клавиша (для типа "по нажатию клавиши").'
/
Comment On Column fc22.form_column_actions.col_action_type_code Is 'Тип действия (лукап FORM_COLUMNS.ACTION_TYPE)'
/
Comment On Column fc22.form_column_actions.column_code Is 'Код колонки'
/
Comment On Column fc22.form_column_actions.form_code Is 'Код формы'
/
Comment On Column fc22.form_column_actions.form_column_action_id Is 'Ключ. Для обновления из интерфейса'
/
Alter Table fc22.form_column_actions
Add Constraint form_cols_acts_actions_fk Foreign Key (form_code, action_code)
References FC22.form_actions (form_code,action_code) On Delete Cascade
/
Alter Table fc22.form_column_actions
Add Constraint form_cols_acts_columns_fk Foreign Key (form_code, column_code)
References FC22.form_columns$ (form_code,col_name) On Delete Cascade
Disable Novalidate
/
