Create Table form_column_actions
    (form_column_action_id          Number,
    form_code                      Varchar2(255) Not Null,
    column_code                    Varchar2(255) Not Null,
    action_code                    Varchar2(255) Not Null,
    action_key_code                Varchar2(255),
    col_action_type_code           Varchar2(255) Not Null)
/

-- Grants for Table
Grant Select On form_column_actions To fc_admin
/




-- Constraints for FORM_COLUMN_ACTIONS

Alter Table form_column_actions
Add Constraint form_column_actions_pk Primary Key (form_code, column_code, 
  action_code, col_action_type_code)
Using Index
/




-- Comments for FORM_COLUMN_ACTIONS

Comment On Column form_column_actions.action_code Is 'Код действия'
/
Comment On Column form_column_actions.action_key_code Is 'Клавиша (для типа "по нажатию клавиши").'
/
Comment On Column form_column_actions.col_action_type_code Is 'Тип действия (лукап FORM_COLUMNS.ACTION_TYPE)'
/
Comment On Column form_column_actions.column_code Is 'Код колонки'
/
Comment On Column form_column_actions.form_code Is 'Код формы'
/
Comment On Column form_column_actions.form_column_action_id Is 'Ключ. Для обновления из интерфейса'
/

-- End of DDL Script for Table FC22.FORM_COLUMN_ACTIONS

-- Foreign Key
Alter Table form_column_actions
Add Constraint form_cols_acts_actions_fk Foreign Key (form_code, action_code)
References form_actions (form_code,action_code) On Delete Cascade
/
Alter Table form_column_actions
Add Constraint form_cols_acts_columns_fk Foreign Key (form_code, column_code)
References form_columns$ (form_code,col_name) On Delete Cascade
Disable Novalidate
/
-- End of DDL script for Foreign Key(s)
