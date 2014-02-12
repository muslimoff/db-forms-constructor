-- Start of DDL Script for Table FC22.APPLICATIONS
-- Generated 1.08.2012 15:46:39 from FC22@XE

Create Table fc22.applications
    (schema_name                    Varchar2(100),
    apps_description               Varchar2(4000),
    apps_name                      Varchar2(4000),
    apps_code                      Varchar2(200),
    default_table_prefix           Varchar2(10))
/
-- End of DDL Script for Table FC22.APPLICATIONS

-- Start of DDL Script for Table FC22.APPS_PRIVS
-- Generated 1.08.2012 15:46:39 from FC22@XE

Create Table fc22.apps_privs
    (apps_code                      Varchar2(200),
    form_code                      Varchar2(255))
/
-- End of DDL Script for Table FC22.APPS_PRIVS

-- Start of DDL Script for Table FC22.APPS_ROLE_MENUS
-- Generated 1.08.2012 15:46:39 from FC22@XE

Create Table fc22.apps_role_menus
    (app_menu_id                    Number,
    menu_code                      Varchar2(4000),
    parent_menu_code               Varchar2(4000),
    Position                       Number(9,0),
    form_code                      Varchar2(4000),
    enabled_flag                   Varchar2(4000),
    display_name                   Varchar2(4000))
/
-- End of DDL Script for Table FC22.APPS_ROLE_MENUS

-- Start of DDL Script for Table FC22.APPS_ROLE_USERS
-- Generated 1.08.2012 15:46:39 from FC22@XE

Create Table fc22.apps_role_users
    (app_role_user_id               Number,
    role_code                      Varchar2(4000),
    apps_code                      Varchar2(4000),
    user_id                        Number)
/
-- End of DDL Script for Table FC22.APPS_ROLE_USERS

-- Start of DDL Script for Table FC22.APPS_ROLES
-- Generated 1.08.2012 15:46:39 from FC22@XE

Create Table fc22.apps_roles
    (apps_role_id                   Number,
    role_code                      Varchar2(4000),
    role_name                      Varchar2(4000),
    apps_code                      Varchar2(4000),
    root_menu_code                 Varchar2(4000))
/
-- End of DDL Script for Table FC22.APPS_ROLES

-- Start of DDL Script for Table FC22.FORM_ACTIONS
-- Generated 1.08.2012 15:46:39 from FC22@XE

Create Table fc22.form_actions
    (form_code                      Varchar2(255) NOT NULL,
    action_code                    Varchar2(255) NOT NULL,
    procedure_name                 Varchar2(255),
    action_display_name            Varchar2(255),
    icon_id                        Number,
    default_param_prefix           Varchar2(255),
    default_old_param_prefix       Varchar2(255),
    action_type                    Varchar2(2),
    display_number                 Number,
    confirm_text                   Varchar2(4000) DEFAULT 'Вы уверенны?',
    hot_key                        Varchar2(255),
    show_separator_below           Varchar2(1) DEFAULT 'N',
    display_on_toolbar             Varchar2(1) DEFAULT 'Y',
    child_form_code                Varchar2(255),
    url_text                       Varchar2(4000),
    parent_action_code             Varchar2(255),
    display_in_context_menu        Varchar2(1) DEFAULT 'Y',
    autocommit                     Varchar2(1) DEFAULT 'Y',
    status_button_param            Varchar2(255),
    status_msg_level_param         Varchar2(255),
    status_msg_txt_param           Varchar2(4000))
/
-- Constraints for FC22.FORM_ACTIONS

Alter Table fc22.form_actions
Add Constraint form_actions_pk Primary Key (form_code, action_code)
Using Index
/
-- Comments for FC22.FORM_ACTIONS

Comment On Column fc22.form_actions.autocommit Is 'Автокоммит'
/
Comment On Column fc22.form_actions.child_form_code Is 'Вызов дочерней формы в новом табе/окне'
/
Comment On Column fc22.form_actions.display_in_context_menu Is 'Отображать в контекстном меню?'
/
Comment On Column fc22.form_actions.parent_action_code Is 'Действие-родитель. Для выполнения последовательности действий'
/
Comment On Column fc22.form_actions.status_button_param Is 'Имя параметра PL/SQL процедуры для передачи номера кнопки для (статуса WARN)'
/
Comment On Column fc22.form_actions.status_msg_level_param Is 'Имя параметра PL/SQL процедуры для передачи статуса выполнения (Пусто-OK, 1-WARN, 2-ERR, 3-CANCEL)'
/
Comment On Column fc22.form_actions.status_msg_txt_param Is 'Имя параметра PL/SQL процедуры для передачи текста сообщения и кнопок'
/
Comment On Column fc22.form_actions.url_text Is 'URL после выполнения действия'
/
-- End of DDL Script for Table FC22.FORM_ACTIONS

-- Start of DDL Script for Table FC22.FORM_COLUMN_ACTIONS
-- Generated 1.08.2012 15:46:39 from FC22@XE

Create Table fc22.form_column_actions
    (form_column_action_id          Number,
    form_code                      Varchar2(255) NOT NULL,
    column_code                    Varchar2(255) NOT NULL,
    action_code                    Varchar2(255) NOT NULL,
    action_key_code                Varchar2(255),
    col_action_type_code           Varchar2(255) NOT NULL)
/
-- Constraints for FC22.FORM_COLUMN_ACTIONS

Alter Table fc22.form_column_actions
Add Constraint form_column_actions_pk Primary Key (form_code, column_code,
  action_code, col_action_type_code)
Using Index
/


-- Comments for FC22.FORM_COLUMN_ACTIONS

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
-- End of DDL Script for Table FC22.FORM_COLUMN_ACTIONS

-- Foreign Key
Alter Table fc22.form_column_actions
Add Constraint form_cols_acts_actions_fk Foreign Key (form_code, action_code)
References FC22.form_actions (form_code,action_code) On Delete Cascade
/
Alter Table fc22.form_column_actions
Add Constraint form_cols_acts_columns_fk Foreign Key (form_code, column_code)
References FC22.form_columns$ (form_code,col_name) On Delete Cascade
Disable Novalidate
/
-- End of DDL script for Foreign Key(s)
-- Start of DDL Script for Table FC22.FORM_COLUMN_ATTR_VALS
-- Generated 1.08.2012 15:46:39 from FC22@XE

Create Table fc22.form_column_attr_vals
    (form_column_attr_val_id        Number,
    form_code                      Varchar2(255),
    column_code                    Varchar2(255),
    attribute_code                 Varchar2(255),
    attribute_value                Varchar2(255))
/
-- Comments for FC22.FORM_COLUMN_ATTR_VALS

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
-- End of DDL Script for Table FC22.FORM_COLUMN_ATTR_VALS

-- Start of DDL Script for Table FC22.FORM_COLUMNS
-- Generated 1.08.2012 15:46:39 from FC22@XE

Create Table fc22.form_columns
    (form_code                      Varchar2(255),
    column_code                    Varchar2(255),
    column_user_name               Varchar2(255),
    column_display_size            Varchar2(255),
    column_data_type               Varchar2(255) DEFAULT 'S',
    column_display_number          Number,
    pimary_key_flag                Varchar2(1),
    show_on_grid                   Varchar2(1) DEFAULT 'Y',
    tree_initialization_value      Varchar2(2000),
    tree_field_type                Varchar2(2),
    editor_tab_code                Varchar2(255),
    field_type                     Varchar2(2),
    column_description             Varchar2(2000),
    is_frozen_flag                 Varchar2(1) DEFAULT 'N',
    show_hover_flag                Varchar2(1) DEFAULT 'N',
    lookup_code                    Varchar2(255),
    hover_column_code              Varchar2(255),
    editor_height                  Varchar2(255),
    lookup_field_type              Varchar2(1),
    help_text                      CLOB,
    text_mask                      Varchar2(255),
    validation_regexp              Varchar2(255),
    default_orderby_number         Varchar2(10),
    DEFAULT_VALUE                  Varchar2(255),
    editor_title_orientation       Varchar2(1) DEFAULT NULL,
    editor_end_row_flag            Varchar2(1) DEFAULT 'Y',
    editor_cols_span               Varchar2(10) DEFAULT '*',
    lookup_display_value           Varchar2(255),
    editor_on_enter_key_action     Varchar2(255))
  Lob ("Help_Text") Store As Sys_Lob0000034311C00020$$
  (
   Nocache Logging
   Chunk 8192
  )
/
-- Constraints for FC22.FORM_COLUMNS

Alter Table fc22.form_columns
Add Constraint form_columns_uk Unique (form_code, column_code)
Using Index
/


-- Comments for FC22.FORM_COLUMNS

Comment On Column fc22.form_columns.column_code Is 'Идентификатор поля (из запроса)'
/
Comment On Column fc22.form_columns.column_data_type Is 'Тип данных (FORM_COLUMNS.DATA_TYPE)'
/
Comment On Column fc22.form_columns.column_description Is 'Описание поля (подсказка для пользователя)'
/
Comment On Column fc22.form_columns.column_display_number Is 'Порядковый номер отображения в таблице'
/
Comment On Column fc22.form_columns.column_display_size Is 'Ширина поля в писькелях'
/
Comment On Column fc22.form_columns.column_user_name Is 'Пользовательское имя поля'
/
Comment On Column fc22.form_columns.default_orderby_number Is 'Порядок сортировки при открытии формы. "-" после цифры - сортировка по убыванию'
/
Comment On Column fc22.form_columns.DEFAULT_VALUE Is 'Значение по умолчанию для новых записей'
/
Comment On Column fc22.form_columns.editor_cols_span Is 'Редактор - количество колонок, занимаемых полем (item.setColSpan)'
/
Comment On Column fc22.form_columns.editor_end_row_flag Is 'item.setEndRow'
/
Comment On Column fc22.form_columns.editor_height Is 'Высота поля в закладке редактирования'
/
Comment On Column fc22.form_columns.editor_on_enter_key_action Is 'Действие по нажатию Enter'
/
Comment On Column fc22.form_columns.editor_tab_code Is 'Ссылка на закладку формы редактирования. Если не указано - показывается только в гриде'
/
Comment On Column fc22.form_columns.editor_title_orientation Is 'item.setTitleOrientation'
/
Comment On Column fc22.form_columns.field_type Is 'Тип поля, общий для дерева и грида'
/
Comment On Column fc22.form_columns.form_code Is 'Идентификатор форм'
/
Comment On Column fc22.form_columns.help_text Is 'Описание поля в HTML'
/
Comment On Column fc22.form_columns.hover_column_code Is 'Поле той же формы, которое содержит подсказку. Если SHOW_HOVER_FLAG = ''Y'' и HOVER_COLUMN_CODE - подсказка берется из текущего поля (COLUMN_CODE)'
/
Comment On Column fc22.form_columns.is_frozen_flag Is 'Замораживать поле?'
/
Comment On Column fc22.form_columns.lookup_code Is 'Ссылка на лукап - формау или простой'
/
Comment On Column fc22.form_columns.lookup_display_value Is 'Поле запроса, отображаемое пользователю - для длинных лукапов'
/
Comment On Column fc22.form_columns.lookup_field_type Is 'См. Lookup FORM_COLUMNS.LOOKUP_FIELD_TYPE'
/
Comment On Column fc22.form_columns.pimary_key_flag Is 'Признак того, что поле является первичным ключем (Y). Пусто - не является.'
/
Comment On Column fc22.form_columns.show_hover_flag Is 'Показывать всплывающую подсказку-значение поля'
/
Comment On Column fc22.form_columns.show_on_grid Is 'Показывать в гриде'
/
Comment On Column fc22.form_columns.text_mask Is 'Текстовая маска для поля. См. описание в интерфейсе'
/
Comment On Column fc22.form_columns.tree_field_type Is 'Тип поля для дерева (Id, ParentId, ChildCount...)'
/
Comment On Column fc22.form_columns.tree_initialization_value Is 'Если не пусто и тип формы - "дерево" - используется при первом вызове дерева для инициализации. Аналогично конструкции Start With древовидных запросов'
/
Comment On Column fc22.form_columns.validation_regexp Is 'Регулярное выражение для клиентской валидации'
/
-- End of DDL Script for Table FC22.FORM_COLUMNS

-- Foreign Key
Alter Table fc22.form_columns
Add Constraint form_columns_hover_cc_fk Foreign Key (form_code,
  hover_column_code)
References FC22.form_columns$ (form_code,col_name)
Disable Novalidate
/
Alter Table fc22.form_columns
Add Constraint form_tabs_fk Foreign Key (form_code, editor_tab_code)
References FC22.form_tabs (form_code,tab_code)
/
-- End of DDL script for Foreign Key(s)
-- Start of DDL Script for Table FC22.FORM_COLUMNS$
-- Generated 1.08.2012 15:46:39 from FC22@XE

Create Table fc22.form_columns$
    (col_num                        Number,
    col_type                       Varchar2(255),
    col_max_len                    Number,
    col_name                       Varchar2(4000),
    col_name_len                   Number,
    col_precision                  Number,
    col_scale                      Number,
    form_code                      Varchar2(255),
    pimary_key_flag                Varchar2(1),
    default_column_width           Varchar2(30),
    column_description             Varchar2(4000))
/
-- Constraints for FC22.FORM_COLUMNS$

Alter Table fc22.form_columns$
Add Constraint form_columns$_uk Unique (form_code, col_name)
Using Index
/
-- End of DDL Script for Table FC22.FORM_COLUMNS$

-- Start of DDL Script for Table FC22.FORM_PROP_VALUES
-- Generated 1.08.2012 15:46:40 from FC22@XE

Create Table fc22.form_prop_values
    (prop_value_id                  Number,
    form_code                      Varchar2(4000),
    property_level                 Varchar2(4000),
    property_code                  Varchar2(4000),
    prop_val_level                 Varchar2(4000),
    value_char                     Varchar2(4000),
    value_number                   Number,
    value_date                     Date,
    value_clob                     CLOB)
  Lob ("Value_Clob") Store As Sys_Lob0000038074C00009$$
  (
   Nocache Logging
   Chunk 8192
  )
/
-- Comments for FC22.FORM_PROP_VALUES

Comment On Column fc22.form_prop_values.prop_val_level Is 'SYSTEM->APP->PARENT_FORM->ROLE->USER (System - для замены таблички FORM_COLUMNS$). Подумать о наследовании'
/
-- End of DDL Script for Table FC22.FORM_PROP_VALUES

-- Start of DDL Script for Table FC22.FORM_PROPS
-- Generated 1.08.2012 15:46:40 from FC22@XE

Create Table fc22.form_props
    (property_level                 Varchar2(4000),
    property_code                  Varchar2(4000),
    property_name                  Varchar2(4000),
    description                    Varchar2(4000),
    help_text                      CLOB,
    prop_datatype                  Varchar2(4000),
    property_id                    Number)
  Lob ("Help_Text") Store As Sys_Lob0000038065C00005$$
  (
   Nocache Logging
   Chunk 8192
  )
/
-- Comments for FC22.FORM_PROPS

Comment On Column fc22.form_props.description Is 'Описание, для подсказки'
/
Comment On Column fc22.form_props.help_text Is 'HTML текст для подсказки в интерфейсе'
/
Comment On Column fc22.form_props.prop_datatype Is 'Тип данных N(umber) D(ate) S(tring) B(oolean) L(OB)'
/
Comment On Column fc22.form_props.property_code Is 'напр SQL_TEXT'
/
Comment On Column fc22.form_props.property_id Is 'ID'
/
Comment On Column fc22.form_props.property_level Is 'FORM->TAB->COLUMN-ACTION'
/
Comment On Column fc22.form_props.property_name Is 'напр "Текст запроса"'
/
-- End of DDL Script for Table FC22.FORM_PROPS

-- Start of DDL Script for Table FC22.FORM_TAB_PARENT_EXCLNS
-- Generated 1.08.2012 15:46:40 from FC22@XE

Create Table fc22.form_tab_parent_exclns
    (form_code                      Varchar2(4000),
    tab_code                       Varchar2(4000),
    parent_form_code               Varchar2(4000),
    included_flag                  Varchar2(2),
    excln_id                       Number)
/
-- Comments for FC22.FORM_TAB_PARENT_EXCLNS

Comment On Table fc22.form_tab_parent_exclns Is 'Select a.child_form_code As form_code, a.tab_code, a.form_code As parent_form_code, ''Y'' As included_flag From form_tabs a Where a.child_form_code = ''INS_INS_INSURED'''
/
Comment On Column fc22.form_tab_parent_exclns.excln_id Is 'ID'
/
-- End of DDL Script for Table FC22.FORM_TAB_PARENT_EXCLNS

-- Start of DDL Script for Table FC22.FORM_TABS
-- Generated 1.08.2012 15:46:40 from FC22@XE

Create Table fc22.form_tabs
    (form_code                      Varchar2(255),
    tab_code                       Varchar2(255),
    child_form_code                Varchar2(255),
    tab_position                   Varchar2(1),
    tab_name                       Varchar2(255),
    number_of_columns              Number DEFAULT NULL,
    icon_id                        Number,
    tab_type                       Varchar2(2),
    tab_display_number             Number)
/
-- Constraints for FC22.FORM_TABS

Alter Table fc22.form_tabs
Add Constraint form_tabs_pk Unique (form_code, tab_code)
Using Index
/
-- Comments for FC22.FORM_TABS

Comment On Column fc22.form_tabs.form_code Is 'Идентификатор форм'
/
Comment On Column fc22.form_tabs.number_of_columns Is 'см. com.smartgwt.client.widgets.form.DynamicForm   setNumCols'
/
Comment On Column fc22.form_tabs.tab_code Is 'Идентификатор закладки'
/
Comment On Column fc22.form_tabs.tab_display_number Is 'Порядок сортировки'
/
Comment On Column fc22.form_tabs.tab_name Is 'Пользовательское имя закладки'
/
Comment On Column fc22.form_tabs.tab_position Is 'Lookup FORMS.EDITOR_POSITION'
/
-- End of DDL Script for Table FC22.FORM_TABS

-- Start of DDL Script for Table FC22.FORMS
-- Generated 1.08.2012 15:46:40 from FC22@XE

Create Table fc22.forms
    (form_code                      Varchar2(255) NOT NULL,
    hot_key                        Varchar2(100),
    sql_text                       Varchar2(4000),
    form_name                      Varchar2(255),
    form_type                      Varchar2(1) DEFAULT 'G',
    show_tree_root_node            Varchar2(1) DEFAULT 'Y',
    icon_id                        Number,
    form_width                     Varchar2(30) DEFAULT '*',
    form_height                    Varchar2(30) DEFAULT '*',
    bottom_tabs_orientation        Varchar2(2) DEFAULT NULL,
    side_tabs_orientation          Varchar2(2),
    show_bottom_toolbar            Varchar2(1) DEFAULT 'Y',
    object_version_number          Number DEFAULT 1,
    default_column_width           Varchar2(30) DEFAULT '*',
    description                    CLOB,
    double_click_action_code       Varchar2(255),
    lookup_width                   Number,
    apps_code                      Varchar2(255),
    export_order                   Number DEFAULT 100)
  Lob ("Description") Store As Sys_Lob0000034300C00015$$
  (
   Nocache Logging
   Chunk 8192
  )
/
-- Constraints for FC22.FORMS

Alter Table fc22.forms
Add Constraint forms_pk Primary Key (form_code)
Using Index
/

-- Triggers for FC22.FORMS

Create Or Replace Trigger fc22.forms_sql_update_aiud
   After Insert Or Delete Or Update Of sql_text
   On fc22.forms
   Referencing New As New Old As Old
   For Each Row
Declare
   --Вызов процедуры перегенерации таблицы FORM_COLUMNS$
   x   Number;
Begin
   If DELETING Then
      form_utils.refresh_temp_columns (:Old.form_code
                                      ,:Old.sql_text
                                      ,:Old.default_column_width
                                      ,p_delete_only_flag      => 'Y'
                                      );
   Elsif    INSERTING
         Or (    UPDATING
             And :Old.sql_text != :New.sql_text) Then
      form_utils.refresh_temp_columns (:New.form_code, :New.sql_text, :New.default_column_width);
   End If;
End FORMS_SQL_UPDATE_AIUD;
/
-- Comments for FC22.FORMS

Comment On Table fc22.forms Is 'xx'
/
Comment On Column fc22.forms.apps_code Is 'Код приложения. Пока только для упрощения генерации скриптов'
/
Comment On Column fc22.forms.bottom_tabs_orientation Is 'ориентация нижних табиков детализации. см. FORMS.TABS_ORIENTATION'
/
Comment On Column fc22.forms.default_column_width Is 'Ширина полей по умолчанию'
/
Comment On Column fc22.forms.description Is 'Описание формы... для коментариев при генерации пакета и т.д'
/
Comment On Column fc22.forms.double_click_action_code Is 'Действие по двойному щелчку на записи. По умолчанию - редактирование'
/
Comment On Column fc22.forms.export_order Is 'Порядковый номер при генерации скриптов'
/
Comment On Column fc22.forms.form_code Is 'Текстовый идентификатор формы'
/
Comment On Column fc22.forms.form_height Is 'высота в пикселях или процентах. * - авто'
/
Comment On Column fc22.forms.form_name Is 'Имя формы для пользователя'
/
Comment On Column fc22.forms.form_type Is 'Тип формы. G-грид, T-дерево...'
/
Comment On Column fc22.forms.form_width Is 'ширина в пикселях или процентах. * - авто'
/
Comment On Column fc22.forms.hot_key Is 'Горячая клавиша  - строка вида [Ctrl+][Alt+][Shift+]Chr. Регистр не важен'
/
Comment On Column fc22.forms.lookup_width Is 'Ширина лукапа (если форма выступает в роли лукапа)'
/
Comment On Column fc22.forms.show_bottom_toolbar Is 'Показывать нижний тулбар?'
/
Comment On Column fc22.forms.show_tree_root_node Is 'Показывать ли корневой узел для дерева?'
/
Comment On Column fc22.forms.side_tabs_orientation Is 'ориентация боковых табиков детализации. см. FORMS.TABS_ORIENTATION'
/
Comment On Column fc22.forms.sql_text Is 'Order by во внешнем запросе не используйте, иначе при сортировке лететь будет..'
/
-- End of DDL Script for Table FC22.FORMS

-- Foreign Key
Alter Table fc22.forms
Add Constraint forms_form_actions_fk Foreign Key (form_code,
  double_click_action_code)
References FC22.form_actions (form_code,action_code)
/
-- End of DDL script for Foreign Key(s)
-- Start of DDL Script for Table FC22.GLOBAL_PARAMS
-- Generated 1.08.2012 15:46:40 from FC22@XE

Create Table fc22.global_params
    (param_name                     Varchar2(255),
    param_value                    Varchar2(2000))
/
-- End of DDL Script for Table FC22.GLOBAL_PARAMS

-- Start of DDL Script for Table FC22.ICONS
-- Generated 1.08.2012 15:46:40 from FC22@XE

Create Table fc22.icons
    (icon_id                        Number,
    icon_file_name                 Varchar2(4000),
    icon_path                      Varchar2(255))
/
-- Comments for FC22.ICONS

Comment On Column fc22.icons.icon_file_name Is 'файл иконки по пути default_icon_path'
/
-- End of DDL Script for Table FC22.ICONS

-- Start of DDL Script for Table FC22.LOOKUP_ATTRIBUTE_VALUES
-- Generated 1.08.2012 15:46:40 from FC22@XE

Create Table fc22.lookup_attribute_values
    (lookup_code                    Varchar2(255),
    lookup_value_code              Varchar2(255),
    attribute_code                 Varchar2(255),
    attribute_value_number         Number,
    attribute_value_char           Varchar2(2000),
    attribute_value_date           Date)
/
-- Constraints for FC22.LOOKUP_ATTRIBUTE_VALUES



-- End of DDL Script for Table FC22.LOOKUP_ATTRIBUTE_VALUES

-- Foreign Key
Alter Table fc22.lookup_attribute_values
Add Constraint lookup_attribute_values_fk1 Foreign Key (lookup_code,
  attribute_code)
References FC22.lookup_attributes (lookup_code,attribute_code)
/
Alter Table fc22.lookup_attribute_values
Add Constraint lookup_attribute_values_fk2 Foreign Key (lookup_code,
  lookup_value_code)
References FC22.lookup_values (lookup_code,lookup_value_code)
/
-- End of DDL script for Foreign Key(s)
-- Start of DDL Script for Table FC22.LOOKUP_ATTRIBUTES
-- Generated 1.08.2012 15:46:40 from FC22@XE

Create Table fc22.lookup_attributes
    (lookup_code                    Varchar2(255),
    attribute_code                 Varchar2(255),
    attribute_name                 Varchar2(255),
    attribute_type                 Varchar2(1))
/
-- Constraints for FC22.LOOKUP_ATTRIBUTES

Alter Table fc22.lookup_attributes
Add Constraint lookup_attribute_uk Unique (lookup_code, attribute_code)
Using Index
/
-- End of DDL Script for Table FC22.LOOKUP_ATTRIBUTES

-- Start of DDL Script for Table FC22.LOOKUP_VALUES
-- Generated 1.08.2012 15:46:40 from FC22@XE

Create Table fc22.lookup_values
    (lookup_code                    Varchar2(255),
    lookup_value_code              Varchar2(255),
    lookup_display_value           Varchar2(255),
    lookup_value_id                Number NOT NULL)
/
-- Constraints for FC22.LOOKUP_VALUES

Alter Table fc22.lookup_values
Add Constraint lookup_value_id_pk Primary Key (lookup_value_id)
Using Index
/
Alter Table fc22.lookup_values
Add Constraint lookup_value_uk Unique (lookup_code, lookup_value_code)
Using Index
/
-- Triggers for FC22.LOOKUP_VALUES

Create Or Replace Trigger fc22.lookup_values_biud
   Before Insert Or Delete Or Update
   On fc22.lookup_values
   Referencing New As New Old As Old
   For Each Row
Begin
   If INSERTING Then
      Select main_sq.Nextval
        Into :New.lookup_value_id
        From DUAL;
   End If;
End;
/
-- End of DDL Script for Table FC22.LOOKUP_VALUES

-- Start of DDL Script for Table FC22.LOOKUPS
-- Generated 1.08.2012 15:46:40 from FC22@XE

Create Table fc22.lookups
    (lookup_code                    Varchar2(255),
    lookup_name                    Varchar2(255))
/
-- Comments for FC22.LOOKUPS

Comment On Column fc22.lookups.lookup_code Is 'Текстовый идентфикатор (ID)'
/
Comment On Column fc22.lookups.lookup_name Is 'Пользовательское имя'
/
-- End of DDL Script for Table FC22.LOOKUPS

-- Start of DDL Script for Table FC22.MENUS
-- Generated 1.08.2012 15:46:40 from FC22@XE

Create Table fc22.menus
    (menu_code                      Varchar2(255) NOT NULL,
    menu_name                      Varchar2(255),
    parent_menu_code               Varchar2(255),
    menu_form_code                 Varchar2(255),
    menu_position                  Number,
    show_in_navigator              Varchar2(1) DEFAULT 'N')
/
-- Constraints for FC22.MENUS

Alter Table fc22.menus
Add Constraint menus_pk Primary Key (menu_code)
Using Index
/
-- Comments for FC22.MENUS

Comment On Column fc22.menus.menu_code Is 'Код меню'
/
Comment On Column fc22.menus.menu_form_code Is 'Ссылка на форму (для конечных узлов)'
/
Comment On Column fc22.menus.menu_name Is 'Пользовательское наименование меню'
/
Comment On Column fc22.menus.menu_position Is 'Позиция пунктов на одном уровне. Если не указано - то сначала нумерованные, потом по наименованию'
/
Comment On Column fc22.menus.parent_menu_code Is 'Ссылка на пункт меню-родитель'
/
Comment On Column fc22.menus.show_in_navigator Is 'Показывать в навигаторе'
/
-- End of DDL Script for Table FC22.MENUS

-- Start of DDL Script for Table FC22.REPORT_TEMPLATES
-- Generated 1.08.2012 15:46:40 from FC22@XE

Create Table fc22.report_templates
    (report_id                      Number,
    user_id                        Number,
    app_code                       Varchar2(255),
    report_type_code               Varchar2(255),
    content_type                   Varchar2(255),
    content                        BLOB,
    filename                       Varchar2(255),
    clob_content                   CLOB)
  Lob ("Content") Store As Sys_Lob0000039462C00006$$
  (
   Nocache Logging
   Chunk 8192
  )
  Lob ("Clob_Content") Store As Sys_Lob0000039462C00008$$
  (
   Nocache Logging
   Chunk 8192
  )
/
-- End of DDL Script for Table FC22.REPORT_TEMPLATES

-- Start of DDL Script for Table FC22.TMP1
-- Generated 1.08.2012 15:46:40 from FC22@XE

Create Table fc22.tmp1
    (lvl                            Number,
    menu_code                      Varchar2(255),
    parent_menu_code               Varchar2(255),
    menu_position                  Number,
    show_in_navigator              Varchar2(1),
    menu_name                      Varchar2(255),
    form_code                      Varchar2(255),
    form_name                      Varchar2(255),
    icon_id                        Number,
    hot_key                        Varchar2(100),
    description                    CLOB,
    child_count                    Number)
  Lob ("Description") Store As Sys_Lob0000037330C00011$$
  (
   Nocache Logging
   Chunk 8192
   Pctversion 10
  )
/
-- End of DDL Script for Table FC22.TMP1

-- Start of DDL Script for Table FC22.USERS
-- Generated 1.08.2012 15:46:40 from FC22@XE

Create Table fc22.users
    (user_id                        Number,
    fio                            Varchar2(4000),
    username                       Varchar2(255),
    Password                       Varchar2(255),
    orig_ref_id                    Number(10,0),
    email                          Varchar2(4000))
/
-- End of DDL Script for Table FC22.USERS

