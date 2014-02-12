-- Start of DDL Script for Table FC22.APPLICATIONS
-- Generated 1.08.2012 15:53:18 from FC22@XE

Create Table applications
    (schema_name                    Varchar2(100),
    apps_description               Varchar2(4000),
    apps_name                      Varchar2(4000),
    apps_code                      Varchar2(200),
    default_table_prefix           Varchar2(10))
/

-- End of DDL Script for Table FC22.APPLICATIONS

-- Start of DDL Script for Table FC22.APPS_PRIVS
-- Generated 1.08.2012 15:53:18 from FC22@XE

Create Table apps_privs
    (apps_code                      Varchar2(200),
    form_code                      Varchar2(255))
/

-- End of DDL Script for Table FC22.APPS_PRIVS

-- Start of DDL Script for Table FC22.APPS_ROLE_MENUS
-- Generated 1.08.2012 15:53:18 from FC22@XE

Create Table apps_role_menus
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
-- Generated 1.08.2012 15:53:18 from FC22@XE

Create Table apps_role_users
    (app_role_user_id               Number,
    role_code                      Varchar2(4000),
    apps_code                      Varchar2(4000),
    user_id                        Number)
/

-- End of DDL Script for Table FC22.APPS_ROLE_USERS

-- Start of DDL Script for Table FC22.APPS_ROLES
-- Generated 1.08.2012 15:53:18 from FC22@XE

Create Table apps_roles
    (apps_role_id                   Number,
    role_code                      Varchar2(4000),
    role_name                      Varchar2(4000),
    apps_code                      Varchar2(4000),
    root_menu_code                 Varchar2(4000))
/

-- End of DDL Script for Table FC22.APPS_ROLES

-- Start of DDL Script for Table FC22.FORM_ACTIONS
-- Generated 1.08.2012 15:53:18 from FC22@XE

Create Table form_actions
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

-- Start of DDL Script for Table FC22.FORM_COLUMN_ACTIONS
-- Generated 1.08.2012 15:53:18 from FC22@XE

Create Table form_column_actions
    (form_column_action_id          Number,
    form_code                      Varchar2(255) NOT NULL,
    column_code                    Varchar2(255) NOT NULL,
    action_code                    Varchar2(255) NOT NULL,
    action_key_code                Varchar2(255),
    col_action_type_code           Varchar2(255) NOT NULL)
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
-- Start of DDL Script for Table FC22.FORM_COLUMN_ATTR_VALS
-- Generated 1.08.2012 15:53:18 from FC22@XE

Create Table form_column_attr_vals
    (form_column_attr_val_id        Number,
    form_code                      Varchar2(255),
    column_code                    Varchar2(255),
    attribute_code                 Varchar2(255),
    attribute_value                Varchar2(255))
/

-- Comments for FORM_COLUMN_ATTR_VALS

Comment On Table form_column_attr_vals Is 'Дополнительные атрибуты колонки'
/
Comment On Column form_column_attr_vals.attribute_code Is 'Код атрибута'
/
Comment On Column form_column_attr_vals.attribute_value Is 'значение атрибута'
/
Comment On Column form_column_attr_vals.column_code Is 'Идентификатор поля (из запроса)'
/
Comment On Column form_column_attr_vals.form_code Is 'Идентификатор форм'
/
Comment On Column form_column_attr_vals.form_column_attr_val_id Is 'Id'
/
-- End of DDL Script for Table FC22.FORM_COLUMN_ATTR_VALS

-- Start of DDL Script for Table FC22.FORM_COLUMNS
-- Generated 1.08.2012 15:53:18 from FC22@XE

Create Table form_columns
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
Comment On Column form_columns.DEFAULT_VALUE Is 'Значение по умолчанию для новых записей'
/
Comment On Column form_columns.editor_cols_span Is 'Редактор - количество колонок, занимаемых полем (item.setColSpan)'
/
Comment On Column form_columns.editor_end_row_flag Is 'item.setEndRow'
/
Comment On Column form_columns.editor_height Is 'Высота поля в закладке редактирования'
/
Comment On Column form_columns.editor_on_enter_key_action Is 'Действие по нажатию Enter'
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
-- End of DDL Script for Table FC22.FORM_COLUMNS

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
-- Start of DDL Script for Table FC22.FORM_COLUMNS$
-- Generated 1.08.2012 15:53:18 from FC22@XE

Create Table form_columns$
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

-- Constraints for FORM_COLUMNS$

Alter Table form_columns$
Add Constraint form_columns$_uk Unique (form_code, col_name)
Using Index
/

-- End of DDL Script for Table FC22.FORM_COLUMNS$

-- Start of DDL Script for Table FC22.FORM_PROP_VALUES
-- Generated 1.08.2012 15:53:18 from FC22@XE

Create Table form_prop_values
    (prop_value_id                  Number,
    form_code                      Varchar2(4000),
    property_level                 Varchar2(4000),
    property_code                  Varchar2(4000),
    prop_val_level                 Varchar2(4000),
    value_char                     Varchar2(4000),
    value_number                   Number,
    value_date                     Date,
    value_clob                     CLOB)
/

-- Comments for FORM_PROP_VALUES

Comment On Column form_prop_values.prop_val_level Is 'SYSTEM->APP->PARENT_FORM->ROLE->USER (System - для замены таблички FORM_COLUMNS$). Подумать о наследовании'
/
-- End of DDL Script for Table FC22.FORM_PROP_VALUES

-- Start of DDL Script for Table FC22.FORM_PROPS
-- Generated 1.08.2012 15:53:18 from FC22@XE

Create Table form_props
    (property_level                 Varchar2(4000),
    property_code                  Varchar2(4000),
    property_name                  Varchar2(4000),
    description                    Varchar2(4000),
    help_text                      CLOB,
    prop_datatype                  Varchar2(4000),
    property_id                    Number)
/

-- Comments for FORM_PROPS

Comment On Column form_props.description Is 'Описание, для подсказки'
/
Comment On Column form_props.help_text Is 'HTML текст для подсказки в интерфейсе'
/
Comment On Column form_props.prop_datatype Is 'Тип данных N(umber) D(ate) S(tring) B(oolean) L(OB)'
/
Comment On Column form_props.property_code Is 'напр SQL_TEXT'
/
Comment On Column form_props.property_id Is 'ID'
/
Comment On Column form_props.property_level Is 'FORM->TAB->COLUMN-ACTION'
/
Comment On Column form_props.property_name Is 'напр "Текст запроса"'
/
-- End of DDL Script for Table FC22.FORM_PROPS

-- Start of DDL Script for Table FC22.FORM_TAB_PARENT_EXCLNS
-- Generated 1.08.2012 15:53:18 from FC22@XE

Create Table form_tab_parent_exclns
    (form_code                      Varchar2(4000),
    tab_code                       Varchar2(4000),
    parent_form_code               Varchar2(4000),
    included_flag                  Varchar2(2),
    excln_id                       Number)
/

-- Comments for FORM_TAB_PARENT_EXCLNS

Comment On Table form_tab_parent_exclns Is 'Select a.child_form_code As form_code, a.tab_code, a.form_code As parent_form_code, ''Y'' As included_flag From form_tabs a Where a.child_form_code = ''INS_INS_INSURED'''
/
Comment On Column form_tab_parent_exclns.excln_id Is 'ID'
/
-- End of DDL Script for Table FC22.FORM_TAB_PARENT_EXCLNS

-- Start of DDL Script for Table FC22.FORM_TABS
-- Generated 1.08.2012 15:53:18 from FC22@XE

Create Table form_tabs
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

-- Constraints for FORM_TABS

Alter Table form_tabs
Add Constraint form_tabs_pk Unique (form_code, tab_code)
Using Index
/

-- Comments for FORM_TABS

Comment On Column form_tabs.form_code Is 'Идентификатор форм'
/
Comment On Column form_tabs.number_of_columns Is 'см. com.smartgwt.client.widgets.form.DynamicForm   setNumCols'
/
Comment On Column form_tabs.tab_code Is 'Идентификатор закладки'
/
Comment On Column form_tabs.tab_display_number Is 'Порядок сортировки'
/
Comment On Column form_tabs.tab_name Is 'Пользовательское имя закладки'
/
Comment On Column form_tabs.tab_position Is 'Lookup FORMS.EDITOR_POSITION'
/
-- End of DDL Script for Table FC22.FORM_TABS

-- Start of DDL Script for Table FC22.FORMS
-- Generated 1.08.2012 15:53:18 from FC22@XE

Create Table forms
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
/

-- Constraints for FORMS

Alter Table forms
Add Constraint forms_pk Primary Key (form_code)
Using Index
/


-- Triggers for FORMS

Create Or Replace Trigger forms_sql_update_aiud
   After Insert Or Delete Or Update Of sql_text
   On forms
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

-- Comments for FORMS

Comment On Table forms Is 'xx'
/
Comment On Column forms.apps_code Is 'Код приложения. Пока только для упрощения генерации скриптов'
/
Comment On Column forms.bottom_tabs_orientation Is 'ориентация нижних табиков детализации. см. FORMS.TABS_ORIENTATION'
/
Comment On Column forms.default_column_width Is 'Ширина полей по умолчанию'
/
Comment On Column forms.description Is 'Описание формы... для коментариев при генерации пакета и т.д'
/
Comment On Column forms.double_click_action_code Is 'Действие по двойному щелчку на записи. По умолчанию - редактирование'
/
Comment On Column forms.export_order Is 'Порядковый номер при генерации скриптов'
/
Comment On Column forms.form_code Is 'Текстовый идентификатор формы'
/
Comment On Column forms.form_height Is 'высота в пикселях или процентах. * - авто'
/
Comment On Column forms.form_name Is 'Имя формы для пользователя'
/
Comment On Column forms.form_type Is 'Тип формы. G-грид, T-дерево...'
/
Comment On Column forms.form_width Is 'ширина в пикселях или процентах. * - авто'
/
Comment On Column forms.hot_key Is 'Горячая клавиша  - строка вида [Ctrl+][Alt+][Shift+]Chr. Регистр не важен'
/
Comment On Column forms.lookup_width Is 'Ширина лукапа (если форма выступает в роли лукапа)'
/
Comment On Column forms.show_bottom_toolbar Is 'Показывать нижний тулбар?'
/
Comment On Column forms.show_tree_root_node Is 'Показывать ли корневой узел для дерева?'
/
Comment On Column forms.side_tabs_orientation Is 'ориентация боковых табиков детализации. см. FORMS.TABS_ORIENTATION'
/
Comment On Column forms.sql_text Is 'Order by во внешнем запросе не используйте, иначе при сортировке лететь будет..'
/
-- End of DDL Script for Table FC22.FORMS

-- Foreign Key
Alter Table forms
Add Constraint forms_form_actions_fk Foreign Key (form_code,
  double_click_action_code)
References form_actions (form_code,action_code)
/
-- End of DDL script for Foreign Key(s)
-- Start of DDL Script for Table FC22.GLOBAL_PARAMS
-- Generated 1.08.2012 15:53:18 from FC22@XE

Create Table global_params
    (param_name                     Varchar2(255),
    param_value                    Varchar2(2000))
/

-- End of DDL Script for Table FC22.GLOBAL_PARAMS

-- Start of DDL Script for Table FC22.ICONS
-- Generated 1.08.2012 15:53:18 from FC22@XE

Create Table icons
    (icon_id                        Number,
    icon_file_name                 Varchar2(4000),
    icon_path                      Varchar2(255))
/

-- Comments for ICONS

Comment On Column icons.icon_file_name Is 'файл иконки по пути default_icon_path'
/
-- End of DDL Script for Table FC22.ICONS

-- Start of DDL Script for Table FC22.LOOKUP_ATTRIBUTE_VALUES
-- Generated 1.08.2012 15:53:18 from FC22@XE

Create Table lookup_attribute_values
    (lookup_code                    Varchar2(255),
    lookup_value_code              Varchar2(255),
    attribute_code                 Varchar2(255),
    attribute_value_number         Number,
    attribute_value_char           Varchar2(2000),
    attribute_value_date           Date)
/

-- Constraints for LOOKUP_ATTRIBUTE_VALUES



-- End of DDL Script for Table FC22.LOOKUP_ATTRIBUTE_VALUES

-- Foreign Key
Alter Table lookup_attribute_values
Add Constraint lookup_attribute_values_fk1 Foreign Key (lookup_code,
  attribute_code)
References lookup_attributes (lookup_code,attribute_code)
/
Alter Table lookup_attribute_values
Add Constraint lookup_attribute_values_fk2 Foreign Key (lookup_code,
  lookup_value_code)
References lookup_values (lookup_code,lookup_value_code)
/
-- End of DDL script for Foreign Key(s)
-- Start of DDL Script for Table FC22.LOOKUP_ATTRIBUTES
-- Generated 1.08.2012 15:53:18 from FC22@XE

Create Table lookup_attributes
    (lookup_code                    Varchar2(255),
    attribute_code                 Varchar2(255),
    attribute_name                 Varchar2(255),
    attribute_type                 Varchar2(1))
/

-- Constraints for LOOKUP_ATTRIBUTES

Alter Table lookup_attributes
Add Constraint lookup_attribute_uk Unique (lookup_code, attribute_code)
Using Index
/

-- End of DDL Script for Table FC22.LOOKUP_ATTRIBUTES

-- Start of DDL Script for Table FC22.LOOKUP_VALUES
-- Generated 1.08.2012 15:53:18 from FC22@XE

Create Table lookup_values
    (lookup_code                    Varchar2(255),
    lookup_value_code              Varchar2(255),
    lookup_display_value           Varchar2(255),
    lookup_value_id                Number NOT NULL)
/

-- Constraints for LOOKUP_VALUES

Alter Table lookup_values
Add Constraint lookup_value_id_pk Primary Key (lookup_value_id)
Using Index
/
Alter Table lookup_values
Add Constraint lookup_value_uk Unique (lookup_code, lookup_value_code)
Using Index
/

-- Triggers for LOOKUP_VALUES

Create Or Replace Trigger lookup_values_biud
   Before Insert Or Delete Or Update
   On lookup_values
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
-- Generated 1.08.2012 15:53:18 from FC22@XE

Create Table lookups
    (lookup_code                    Varchar2(255),
    lookup_name                    Varchar2(255))
/

-- Comments for LOOKUPS

Comment On Column lookups.lookup_code Is 'Текстовый идентфикатор (ID)'
/
Comment On Column lookups.lookup_name Is 'Пользовательское имя'
/
-- End of DDL Script for Table FC22.LOOKUPS

-- Start of DDL Script for Table FC22.MENUS
-- Generated 1.08.2012 15:53:18 from FC22@XE

Create Table menus
    (menu_code                      Varchar2(255) NOT NULL,
    menu_name                      Varchar2(255),
    parent_menu_code               Varchar2(255),
    menu_form_code                 Varchar2(255),
    menu_position                  Number,
    show_in_navigator              Varchar2(1) DEFAULT 'N')
/

-- Constraints for MENUS

Alter Table menus
Add Constraint menus_pk Primary Key (menu_code)
Using Index
/

-- Comments for MENUS

Comment On Column menus.menu_code Is 'Код меню'
/
Comment On Column menus.menu_form_code Is 'Ссылка на форму (для конечных узлов)'
/
Comment On Column menus.menu_name Is 'Пользовательское наименование меню'
/
Comment On Column menus.menu_position Is 'Позиция пунктов на одном уровне. Если не указано - то сначала нумерованные, потом по наименованию'
/
Comment On Column menus.parent_menu_code Is 'Ссылка на пункт меню-родитель'
/
Comment On Column menus.show_in_navigator Is 'Показывать в навигаторе'
/
-- End of DDL Script for Table FC22.MENUS

-- Start of DDL Script for Table FC22.REPORT_TEMPLATES
-- Generated 1.08.2012 15:53:18 from FC22@XE

Create Table report_templates
    (report_id                      Number,
    user_id                        Number,
    app_code                       Varchar2(255),
    report_type_code               Varchar2(255),
    content_type                   Varchar2(255),
    content                        BLOB,
    filename                       Varchar2(255),
    clob_content                   CLOB)
/

-- End of DDL Script for Table FC22.REPORT_TEMPLATES

-- Start of DDL Script for Table FC22.USERS
-- Generated 1.08.2012 15:53:19 from FC22@XE

Create Table users
    (user_id                        Number,
    fio                            Varchar2(4000),
    username                       Varchar2(255),
    Password                       Varchar2(255),
    orig_ref_id                    Number(10,0),
    email                          Varchar2(4000))
/

-- End of DDL Script for Table FC22.USERS

