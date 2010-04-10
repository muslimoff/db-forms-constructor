-- Start of DDL Script for Table FC.FORM_COLUMNS
-- Generated 10.04.2010 20:51:05 from FC@VM_XE

Create Table form_columns
    (form_code                      Varchar2(255),
    column_code                    Varchar2(255),
    column_user_name               Varchar2(255),
    column_display_size            Varchar2(255),
    column_data_type               Varchar2(255) Default 'S',
    column_display_number          Number,
    pimary_key_flag                Varchar2(1),
    show_on_grid                   Varchar2(1) Default 'Y',
    tree_initialization_value      Varchar2(2000),
    tree_field_type                Varchar2(2),
    editor_tab_code                Varchar2(255),
    field_type                     Varchar2(2),
    column_description             Varchar2(2000),
    is_frozen_flag                 Varchar2(1) Default 'N',
    show_hover_flag                Varchar2(1) Default 'N',
    lookup_code                    Varchar2(255),
    hover_column_code              Varchar2(255),
    editor_height                  Varchar2(255),
    lookup_field_type              Varchar2(1),
    help_text                      CLOB,
    text_mask                      Varchar2(255),
    validation_regexp              Varchar2(255),
    default_orderby_number         Varchar2(10),
    default_value                  Varchar2(255),
    editor_title_orientation       Varchar2(1) Default NULL,
    editor_end_row_flag            Varchar2(1) Default 'Y',
    editor_cols_span               Varchar2(10) Default '*',
    lookup_display_value           Varchar2(255))
/

-- Grants for Table
Grant Select On form_columns To sys
/




-- Constraints for FORM_COLUMNS

Alter Table form_columns
Add Constraint form_columns_uk Unique (form_code, column_code)
Using Index
/




-- Comments for FORM_COLUMNS

Comment On Column form_columns.column_code Is 'Идентификатор поля (из запроса)'
/
Comment On Column form_columns.column_data_type Is 'Тип данных (FORM_COLUMNS.DATA_TYPE)'
/
Comment On Column form_columns.column_description Is 'Описание поля (подсказка для пользователя)'
/
Comment On Column form_columns.column_display_number Is 'Порядковый номер отображения в таблице'
/
Comment On Column form_columns.column_display_size Is 'Ширина поля в писькелях'
/
Comment On Column form_columns.column_user_name Is 'Пользовательское имя поля'
/
Comment On Column form_columns.default_orderby_number Is 'Порядок сортировки при открытии формы. "-" после цифры - сортировка по убыванию'
/
Comment On Column form_columns.default_value Is 'Значение по умолчанию для новых записей'
/
Comment On Column form_columns.editor_cols_span Is 'Редактор - количество колонок, занимаемых полем (item.setColSpan)'
/
Comment On Column form_columns.editor_end_row_flag Is 'item.setEndRow'
/
Comment On Column form_columns.editor_height Is 'Высота поля в закладке редактирования'
/
Comment On Column form_columns.editor_tab_code Is 'Ссылка на закладку формы редактирования. Если не указано - показывается только в гриде'
/
Comment On Column form_columns.editor_title_orientation Is 'item.setTitleOrientation'
/
Comment On Column form_columns.field_type Is 'Тип поля, общий для дерева и грида'
/
Comment On Column form_columns.form_code Is 'Идентификатор форм'
/
Comment On Column form_columns.help_text Is 'Описание поля в HTML'
/
Comment On Column form_columns.hover_column_code Is 'Поле той же формы, которое содержит подсказку. Если SHOW_HOVER_FLAG = ''Y'' и HOVER_COLUMN_CODE - подсказка берется из текущего поля (COLUMN_CODE)'
/
Comment On Column form_columns.is_frozen_flag Is 'Замораживать поле?'
/
Comment On Column form_columns.lookup_code Is 'Ссылка на лукап - формау или простой'
/
Comment On Column form_columns.lookup_display_value Is 'Поле запроса, отображаемое пользователю - для длинных лукапов'
/
Comment On Column form_columns.lookup_field_type Is 'См. Lookup FORM_COLUMNS.LOOKUP_FIELD_TYPE'
/
Comment On Column form_columns.pimary_key_flag Is 'Признак того, что поле является первичным ключем (Y). Пусто - не является.'
/
Comment On Column form_columns.show_hover_flag Is 'Показывать всплывающую подсказку-значение поля'
/
Comment On Column form_columns.show_on_grid Is 'Показывать в гриде'
/
Comment On Column form_columns.text_mask Is 'Текстовая маска для поля. См. описание в интерфейсе'
/
Comment On Column form_columns.tree_field_type Is 'Тип поля для дерева (Id, ParentId, ChildCount...)'
/
Comment On Column form_columns.tree_initialization_value Is 'Если не пусто и тип формы - "дерево" - используется при первом вызове дерева для инициализации. Аналогично конструкции Start With древовидных запросов'
/
Comment On Column form_columns.validation_regexp Is 'Регулярное выражение для клиентской валидации'
/

-- End of DDL Script for Table FC.FORM_COLUMNS

-- Foreign Key
Alter Table form_columns
Add Constraint form_columns_hover_cc_fk Foreign Key (form_code, 
  hover_column_code)
References form_columns$ (form_code,col_name)
Disable Novalidate
/
Alter Table form_columns
Add Constraint form_tabs_fk Foreign Key (form_code, editor_tab_code)
References form_tabs (form_code,tab_code)
/
-- End of DDL script for Foreign Key(s)
