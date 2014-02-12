Create Table fc22.form_column_attr_vals
    (form_column_attr_val_id        Number,
    form_code                      Varchar2(255),
    column_code                    Varchar2(255),
    attribute_code                 Varchar2(255),
    attribute_value                Varchar2(255))
/

Comment On Table fc22.form_column_attr_vals Is 'Дополнительные атрибуты колонки'
/
Comment On Column fc22.form_column_attr_vals.attribute_code Is 'Код атрибута'
/
Comment On Column fc22.form_column_attr_vals.attribute_value Is 'значение атрибута'
/
Comment On Column fc22.form_column_attr_vals.column_code Is 'Идентификатор поля (из запроса)'
/
Comment On Column fc22.form_column_attr_vals.form_code Is 'Идентификатор форм'
/
Comment On Column fc22.form_column_attr_vals.form_column_attr_val_id Is 'Id'
/
