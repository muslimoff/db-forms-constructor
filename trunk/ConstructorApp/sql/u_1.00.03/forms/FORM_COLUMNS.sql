Alter Table FORMS Disable All Triggers;
Delete From FORM_COLUMNS
      Where form_code = 'FORM_COLUMNS';
Delete From FORM_COLUMNS$
      Where form_code = 'FORM_COLUMNS';
Delete From FORM_ACTIONS
      Where form_code = 'FORM_COLUMNS';
Delete From FORM_TABS
      Where form_code = 'FORM_COLUMNS';
Delete From FORMS
      Where form_code = 'FORM_COLUMNS';
/*  Form: FORM_COLUMNS. Entity: FORMS.  */

Insert Into FORMS
            ("FORM_CODE", "HOT_KEY", "SQL_TEXT", "FORM_NAME", "FORM_TYPE", "SHOW_TREE_ROOT_NODE", "ICON_ID"
            ,"FORM_WIDTH", "FORM_HEIGHT", "BOTTOM_TABS_ORIENTATION", "SIDE_TABS_ORIENTATION", "SHOW_BOTTOM_TOOLBAR"
            ,"OBJECT_VERSION_NUMBER", "DEFAULT_COLUMN_WIDTH", "DESCRIPTION", "DOUBLE_CLICK_ACTION_CODE", "LOOKUP_WIDTH")
     Values ('FORM_COLUMNS', ''
            ,'SELECT   t.*, NVL ( (SELECT   NVL (f.form_name, form_code)
                       FROM   &fc_schema_owner..forms f
                      WHERE   f.form_code = t.lookup_code AND t.field_type IN (''9'', ''11'')),
              (SELECT   l.lookup_name
                 FROM   &fc_schema_owner..lookups l
                WHERE   t.lookup_code = l.lookup_code AND t.field_type IN (''8'', ''10'')))
                 lookup_name
  FROM   Table (&fc_schema_owner..form_utils.describe_form_columns_pl (DECODE (
                                                        :p_$master_form_code,
                                                        ''FORMS2'', :form_code_for_filter,
                                                        ''MENUS'', :form_code_for_filter,
                                                        :form_code
                                                     ))) t
/*************/'
            ,'Детальная Колонки', 'G', 'Y', '4', '35%', '*', '', 'B', 'Y', '338', '*', '', '', '');
/*  Form: FORM_COLUMNS. Entity: FORM_TABS.  */

Insert Into FORM_TABS
            ("FORM_CODE", "TAB_CODE", "CHILD_FORM_CODE", "TAB_POSITION", "TAB_NAME", "NUMBER_OF_COLUMNS", "ICON_ID"
            ,"TAB_TYPE", "TAB_DISPLAY_NUMBER")
     Values ('FORM_COLUMNS', 'ADD', 'LOOKUPS', 'R', 'Дополнительные', '4', '28', '1', '2');

Insert Into FORM_TABS
            ("FORM_CODE", "TAB_CODE", "CHILD_FORM_CODE", "TAB_POSITION", "TAB_NAME", "NUMBER_OF_COLUMNS", "ICON_ID"
            ,"TAB_TYPE", "TAB_DISPLAY_NUMBER")
     Values ('FORM_COLUMNS', 'COL_ATTRS', 'FORM_COLUMN_ATTR_VALS', 'R', 'Атрибуты', '', '12', '2', '');

Insert Into FORM_TABS
            ("FORM_CODE", "TAB_CODE", "CHILD_FORM_CODE", "TAB_POSITION", "TAB_NAME", "NUMBER_OF_COLUMNS", "ICON_ID"
            ,"TAB_TYPE", "TAB_DISPLAY_NUMBER")
     Values ('FORM_COLUMNS', 'HELP', '', '', 'Помощь', '6', '43', '1', '3');

Insert Into FORM_TABS
            ("FORM_CODE", "TAB_CODE", "CHILD_FORM_CODE", "TAB_POSITION", "TAB_NAME", "NUMBER_OF_COLUMNS", "ICON_ID"
            ,"TAB_TYPE", "TAB_DISPLAY_NUMBER")
     Values ('FORM_COLUMNS', 'MAIN', '', 'R', 'Основные', '6', '20', '1', '1');
/*  Form: FORM_COLUMNS. Entity: FORM_ACTIONS.  */

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('FORM_COLUMNS', 'DEL', '&fc_schema_owner..FORM_COLUMNS_PKG.P_DELETE', 'Удалить', '48', '', '', '3', '130'
            ,'Вы уверенны что хотите удалить запись?', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('FORM_COLUMNS', 'EDIT', '', 'Редактировать', '50', '', '', '8', '115', 'Вы уверенны?', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('FORM_COLUMNS', 'INS', '', 'Создать', '47', '', '', '1', '110', '', '', 'N', 'Y', '');

Insert Into FORM_ACTIONS
            ("FORM_CODE", "ACTION_CODE", "PROCEDURE_NAME", "ACTION_DISPLAY_NAME", "ICON_ID", "DEFAULT_PARAM_PREFIX"
            ,"DEFAULT_OLD_PARAM_PREFIX", "ACTION_TYPE", "DISPLAY_NUMBER", "CONFIRM_TEXT", "HOT_KEY"
            ,"SHOW_SEPARATOR_BELOW", "DISPLAY_ON_TOOLBAR", "CHILD_FORM_CODE")
     Values ('FORM_COLUMNS', 'UPD', '&fc_schema_owner..FORM_COLUMNS_PKG.P_INS_UPD', 'Сохранить', '46', '', '', '2'
            ,'120', 'Вы уверенны?', '', 'N', 'Y', '');
/*  Form: FORM_COLUMNS. Entity: FORM_COLUMNS$.  */

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('3', 'VARCHAR2', '1020', 'COLUMN_CODE', '11', '0', '0', 'FORM_COLUMNS', 'Y', '*'
            ,'*Идентификатор поля (из запроса)');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('4', 'VARCHAR2', '1020', 'COLUMN_DATA_TYPE', '16', '0', '0', 'FORM_COLUMNS', '', '*'
            ,'*Тип данных (FORM_COLUMNS.DATA_TYPE)');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('13', 'VARCHAR2', '8000', 'COLUMN_DESCRIPTION', '18', '0', '0', 'FORM_COLUMNS', '', '*'
            ,'*Описание поля (подсказка для пользователя)');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('1', 'NUMBER', '22', 'COLUMN_DISPLAY_NUMBER', '21', '0', '0', 'FORM_COLUMNS', '', '*'
            ,'*Порядковый номер отображения в таблице');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('6', 'VARCHAR2', '1020', 'COLUMN_DISPLAY_SIZE', '19', '0', '0', 'FORM_COLUMNS', '', '*'
            ,'*Ширина поля в писькелях');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('5', 'VARCHAR2', '1020', 'COLUMN_USER_NAME', '16', '0', '0', 'FORM_COLUMNS', '', '*'
            ,'*Пользовательское имя поля');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('25', 'VARCHAR2', '40', 'DEFAULT_ORDERBY_NUMBER', '22', '0', '0', 'FORM_COLUMNS', '', '*'
            ,'*Порядок сортировки при открытии формы. "-" после цифры - сортировка по убыванию');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('26', 'VARCHAR2', '1020', 'DEFAULT_VALUE', '13', '0', '0', 'FORM_COLUMNS', '', '*'
            ,'*Default value for the argument');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('28', 'VARCHAR2', '40', 'EDITOR_COLS_SPAN', '16', '0', '0', 'FORM_COLUMNS', '', '*'
            ,'*Редактор - количество колонок, занимаемых полем (item.setColSpan)');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('29', 'VARCHAR2', '4', 'EDITOR_END_ROW_FLAG', '19', '0', '0', 'FORM_COLUMNS', '', '*', '*item.setEndRow');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('20', 'VARCHAR2', '1020', 'EDITOR_HEIGHT', '13', '0', '0', 'FORM_COLUMNS', '', '*'
            ,'*Высота поля в закладке редактирования');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('31', 'VARCHAR2', '1020', 'EDITOR_ON_ENTER_KEY_ACTION', '26', '0', '0', 'FORM_COLUMNS', '', '*'
            ,'*Действие по нажатию Enter');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('11', 'VARCHAR2', '1020', 'EDITOR_TAB_CODE', '15', '0', '0', 'FORM_COLUMNS', '', '*'
            ,'*Ссылка на закладку формы редактирования. Если не указано - показывается только в гриде');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('27', 'VARCHAR2', '4', 'EDITOR_TITLE_ORIENTATION', '24', '0', '0', 'FORM_COLUMNS', '', '*'
            ,'*item.setTitleOrientation');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('16', 'VARCHAR2', '4', 'EXISTS_IN_METADATA_FLAG', '23', '0', '0', 'FORM_COLUMNS', '', '*'
            ,'**EXISTS_IN_METADATA_FLAG');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('17', 'VARCHAR2', '4', 'EXISTS_IN_QUERY_FLAG', '20', '0', '0', 'FORM_COLUMNS', '', '*'
            ,'**EXISTS_IN_QUERY_FLAG');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('12', 'VARCHAR2', '8', 'FIELD_TYPE', '10', '0', '0', 'FORM_COLUMNS', '', '*'
            ,'*Тип поля, общий для дерева и грида');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('2', 'VARCHAR2', '1020', 'FORM_CODE', '9', '0', '0', 'FORM_COLUMNS', 'Y', '*', '*Идентификатор форм');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('22', 'CLOB', '32767', 'HELP_TEXT', '9', '0', '0', 'FORM_COLUMNS', '', '*'
            ,'*HTML текст для подсказки в интерфейсе');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('19', 'VARCHAR2', '1020', 'HOVER_COLUMN_CODE', '17', '0', '0', 'FORM_COLUMNS', '', '*'
            ,'*Поле той же формы, которое содержит подсказку. Если SHOW_HOVER_FLAG = ''Y'' и HOVER_COLUMN_CODE - подсказка берется из текущего поля (COLUMN_CODE)');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('14', 'VARCHAR2', '4', 'IS_FROZEN_FLAG', '14', '0', '0', 'FORM_COLUMNS', '', '*', '*Замораживать поле?');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('18', 'VARCHAR2', '1020', 'LOOKUP_CODE', '11', '0', '0', 'FORM_COLUMNS', '', '*'
            ,'*Ссылка на лукап - формау или простой');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('30', 'VARCHAR2', '1020', 'LOOKUP_DISPLAY_VALUE', '20', '0', '0', 'FORM_COLUMNS', '', '*'
            ,'*Поле запроса, отображаемое пользователю - для длинных лукапов');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('21', 'VARCHAR2', '4', 'LOOKUP_FIELD_TYPE', '17', '0', '0', 'FORM_COLUMNS', '', '*'
            ,'*См. Lookup FORM_COLUMNS.LOOKUP_FIELD_TYPE');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('32', 'VARCHAR2', '1020', 'LOOKUP_NAME', '11', '0', '0', 'FORM_COLUMNS', '', '*', '*Пользовательское имя');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('7', 'VARCHAR2', '4', 'PIMARY_KEY_FLAG', '15', '0', '0', 'FORM_COLUMNS', '', '*'
            ,'*Признак того, что поле является первичным ключем (Y). Пусто - не является.');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('15', 'VARCHAR2', '4', 'SHOW_HOVER_FLAG', '15', '0', '0', 'FORM_COLUMNS', '', '*'
            ,'*Показывать всплывающую подсказку-значение поля');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('8', 'VARCHAR2', '4', 'SHOW_ON_GRID', '12', '0', '0', 'FORM_COLUMNS', '', '*', '*Показывать в гриде');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('23', 'VARCHAR2', '1020', 'TEXT_MASK', '9', '0', '0', 'FORM_COLUMNS', '', '*'
            ,'*Текстовая маска для поля. См. описание в интерфейсе');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('10', 'VARCHAR2', '8', 'TREE_FIELD_TYPE', '15', '0', '0', 'FORM_COLUMNS', '', '*'
            ,'*Тип поля для дерева (Id, ParentId, ChildCount...)');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('9', 'VARCHAR2', '8000', 'TREE_INITIALIZATION_VALUE', '25', '0', '0', 'FORM_COLUMNS', '', '*'
            ,'*Если не пусто и тип формы - "дерево" - используется при первом вызове дерева для инициализации. Аналогично конструкции Start With древовидных запросов');

Insert Into FORM_COLUMNS$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values ('24', 'VARCHAR2', '1020', 'VALIDATION_REGEXP', '17', '0', '0', 'FORM_COLUMNS', '', '*'
            ,'*Регулярное выражение для клиентской валидации');
/*  Form: FORM_COLUMNS. Entity: FORM_COLUMNS.  */

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMNS', 'COLUMN_CODE', 'Код', '40%', 'S', '30', 'Y', 'Y', '', '', 'MAIN', ''
            ,'*Идентификатор поля (из запроса)', 'N', 'Y', '', 'COLUMN_DESCRIPTION', '', '', '', '', '', '', '', ''
            ,'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMNS', 'COLUMN_DATA_TYPE', 'Тип данных', '40', 'S', '50', 'N', 'N', '', '', 'MAIN', '8'
            ,'*Тип данных', 'N', 'N', 'FORM_COLUMNS.DATA_TYPE', '', '', '', '', '', '', '', '', 'L', 'N', '2', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMNS', 'COLUMN_DESCRIPTION', 'Описание', '150', 'S', '900', 'N', 'N', '', '', 'HELP', ''
            ,'Краткое описание поля (всплывающая подсказка для пользователя)', 'N', 'N', '', '', '', '', '', '', '', ''
            ,'', '', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMNS', 'COLUMN_DISPLAY_NUMBER', '№', '22', 'N', '15', 'N', 'Y', '', '', 'MAIN', ''
            ,'*Порядковый номер отображения в таблице', 'N', 'N', '', '', '', '', '', '', '', '1', '', 'L', 'N', '1'
            ,'', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMNS', 'COLUMN_DISPLAY_SIZE', 'Ширина', '40', 'S', '60', 'N', 'N', '', '', 'MAIN', ''
            ,'Ширина поля в пикселях, процентах или * - авто', 'N', 'N', '', '', '', '', '', '', '', '', '', 'L', 'Y'
            ,'1', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMNS', 'COLUMN_USER_NAME', 'Польз. имя', '*', 'S', '45', 'N', 'Y', '', '', 'MAIN', ''
            ,'*Пользовательское имя поля', 'N', 'Y', '', '', '', '', '', '', '', '', '', 'L', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMNS', 'DEFAULT_ORDERBY_NUMBER', '№ сортировки', '*', 'S', '1025', 'N', 'N', '', '', 'MAIN', ''
            ,'*Порядок сортировки при открытии формы. "-" после цифры - сортировка по убыванию', 'N', 'N', '', '', ''
            ,'', '', '', '', '', '', 'L', 'N', '1', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMNS', 'DEFAULT_VALUE', 'По умолчанию', '*', 'S', '1026', 'N', 'N', '', '', 'MAIN', ''
            ,'Значение по умолчанию для новых записей', 'N', 'N', '', '', '', '', '', '', '', '', '', 'L', 'Y', '2', ''
            ,'');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMNS', 'EDITOR_COLS_SPAN', 'Редактор - кол-во колонок', '*', 'S', '1028', 'N', 'N', '', '', 'ADD'
            ,'', '*Редактор - количество колонок, занимаемых полем (item.setColSpan)', 'N', 'N', '', '', '', '', '', ''
            ,'', '', '', '', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMNS', 'EDITOR_END_ROW_FLAG', 'Редактор - с конца строки', '*', 'B', '1029', 'N', 'N', '', ''
            ,'ADD', '', '***item.setEndRow', 'N', 'N', '', '', '', '', '', '', '', '', '', '', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMNS', 'EDITOR_HEIGHT', 'Высота поля', '*', 'S', '1020', 'N', 'N', '', '', 'ADD', ''
            ,'*Высота поля в закладке редактирования', 'N', 'N', '', '', '', '', '', '', '', '', '', '', 'Y', '*', ''
            ,'');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMNS', 'EDITOR_ON_ENTER_KEY_ACTION', 'Действие по нажатию Enter', '*', 'S', '1031', 'N', 'N', ''
            ,'', 'ADD', '9', '*Действие по нажатию Enter', 'N', 'N', 'DBLCLICK_FORM_ACT_LIST', '', '', '', '', '', ''
            ,'', '', 'L', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMNS', 'EDITOR_TAB_CODE', 'Закладка', '80', 'S', '80', 'N', 'N', '', '', 'MAIN', '9'
            ,'*Идентификатор закладки', 'N', 'N', 'FORM_TABS_LIST', '', '', '', '', '', '', '', '', '', 'Y', '*', ''
            ,'');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMNS', 'EDITOR_TITLE_ORIENTATION', 'TitleOrientation', '*', 'S', '1027', 'N', 'N', '', '', 'ADD'
            ,'', '*item.setTitleOrientation', 'N', 'N', '', '', '', '', '', '', '', '', '', '', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMNS', 'EXISTS_IN_METADATA_FLAG', 'В настройках?', '*', 'B', '1016', 'N', 'Y', '', '', '', ''
            ,'Есть ли настройки для данного поля в таблице FORM_COLUMNS', 'N', 'Y', '', '', '', '', '', '', '', '', ''
            ,'', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMNS', 'EXISTS_IN_QUERY_FLAG', 'В запросе?', '*', 'B', '1017', 'N', 'Y', '', '', '', ''
            ,'Существует ли поле в запросе?', 'N', 'Y', '', '', '', '', '', '', '', '', '', '', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMNS', 'FIELD_TYPE', 'Тип поля', '40', 'S', '90', 'N', 'N', '', '', 'MAIN', '10'
            ,'*Тип поля, общий для дерева и грида', 'N', 'N', 'FORM_COLUMNS.FIELD_TYPE', '', '', '', '', '', '', '', ''
            ,'L', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMNS', 'FORM_CODE', 'Форма', '100', 'S', '20', 'Y', 'N', '', '1', 'MAIN', '9'
            ,'*Идентификатор форм', 'N', 'N', 'FORMS_LIST', '', '', '1', '', '', '', '', ':form_code_for_filter', 'L'
            ,'Y', '2', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMNS', 'HELP_TEXT', 'Will become item help.', '*', 'S', '1022', 'N', 'N', '', '', 'HELP', '5'
            ,'*Will become item help.', 'N', 'N', '', '', '400', '', '', '', '', '', '', 'T', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMNS', 'HOVER_COLUMN_CODE', 'Поле подсказки', '*', 'S', '875', 'N', 'N', '', '', 'HELP', '9'
            ,'*Поле той же формы, которое содержит подсказку. Если SHOW_HOVER_FLAG = ''Y'' и HOVER_COLUMN_CODE - подсказка берется из текущего поля (COLUMN_CODE)'
            ,'N', 'N', 'COLUMNS_LIST', '', '', '', '', '', '', '', '', '', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMNS', 'IS_FROZEN_FLAG', 'Заморозить', '80', 'B', '850', 'N', 'N', '', '', 'MAIN', ''
            ,'*Замораживать поле?', 'N', 'N', '', '', '', '', '', '', '', '', '', 'T', 'N', '1', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMNS', 'LOOKUP_CODE', 'Список', '*', 'S', '160', 'N', 'N', '', '', 'MAIN', '9'
            ,'*Текстовый идентфикатор (ID)', 'N', 'N', 'LOOKUPS_LIST', '', '', '', '', '', '', '', '', 'L', 'Y', '*'
            ,'LOOKUP_NAME', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMNS', 'LOOKUP_DISPLAY_VALUE', 'Списки: отображаемое поле', '*', 'S', '1030', 'N', 'N', '', ''
            ,'ADD', '9', '*Поле запроса, отображаемое пользователю - для длинных лукапов', 'N', 'N', 'COLUMNS_LIST', ''
            ,'', '', '', '', '', '', '', 'L', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMNS', 'LOOKUP_FIELD_TYPE', 'Тип поля в списке', '*', 'S', '1022', 'N', 'N', '', '', 'MAIN', '8'
            ,'Если форма используется как Lookup - какое из полей является идентификатором и будет сохранено в БД, какое поле будет отображаться пользователю.'
            ,'N', 'N', 'FORM_COLUMNS.LOOKUP_FIELD_TYPE', '', '', '', '', '', '', '', '', '', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMNS', 'LOOKUP_NAME', 'Пользовательское имя', '*', 'S', '1031', 'N', 'N', '', '', '', ''
            ,'*Пользовательское имя', 'N', 'N', '', '', '', '', '', '', '', '', '', 'L', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMNS', 'PIMARY_KEY_FLAG', 'Первичн. ключ', '80', 'B', '860', 'N', 'N', '', '', 'MAIN', ''
            ,'*Признак того, что поле является первичным ключем (Y). Пусто - не является.', 'N', 'N', '', '', '', ''
            ,'', '', '', '', '', 'T', 'N', '1', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMNS', 'SHOW_HOVER_FLAG', 'Подсказка', '80', 'B', '870', 'N', 'N', '', '', 'HELP', ''
            ,'*Показывать всплывающую подсказку-значение поля', 'N', 'N', '', '', '', '', '', '', '', '', '', '', 'Y'
            ,'*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMNS', 'SHOW_ON_GRID', 'Отображать в таблице', '80', 'B', '880', 'N', 'N', '', '', 'MAIN', ''
            ,'Показывать в гриде', 'N', 'N', '', '', '', '', '', '', '', '', '', 'T', 'Y', '1', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMNS', 'TEXT_MASK', 'Маска', '*', 'S', '1023', 'N', 'N', '', '', 'ADD', ''
            ,'*Текстовая маска для поля. См. описание в интерфейсе', 'N', 'N', '', '', '', '', '', '', '', '', '', ''
            ,'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMNS', 'TREE_FIELD_TYPE', 'Тип для дерева', '40', 'S', '70', 'N', 'N', '', '', 'ADD', '8'
            ,'*Тип поля для дерева (Id, ParentId, ChildCount...)', 'N', 'N', 'FORM_COLUMNS.TREE_FIELD_TYPE', '', '', ''
            ,'', '', '', '', '', 'L', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMNS', 'TREE_INITIALIZATION_VALUE', 'Иниц. дерева', '80', 'S', '1000', 'N', 'N', '', '', 'ADD'
            ,''
            ,'*Если не пусто и тип формы - "дерево" - используется при первом вызове дерева для инициализации. Аналогично конструкции Start With древовидных запросов'
            ,'N', 'N', '', '', '', '', '', '', '', '', '', '', 'Y', '*', '', '');

Insert Into FORM_COLUMNS
            ("FORM_CODE", "COLUMN_CODE", "COLUMN_USER_NAME", "COLUMN_DISPLAY_SIZE", "COLUMN_DATA_TYPE"
            ,"COLUMN_DISPLAY_NUMBER", "PIMARY_KEY_FLAG", "SHOW_ON_GRID", "TREE_INITIALIZATION_VALUE", "TREE_FIELD_TYPE"
            ,"EDITOR_TAB_CODE", "FIELD_TYPE", "COLUMN_DESCRIPTION", "IS_FROZEN_FLAG", "SHOW_HOVER_FLAG", "LOOKUP_CODE"
            ,"HOVER_COLUMN_CODE", "EDITOR_HEIGHT", "LOOKUP_FIELD_TYPE", "HELP_TEXT", "TEXT_MASK", "VALIDATION_REGEXP"
            ,"DEFAULT_ORDERBY_NUMBER", "DEFAULT_VALUE", "EDITOR_TITLE_ORIENTATION", "EDITOR_END_ROW_FLAG"
            ,"EDITOR_COLS_SPAN", "LOOKUP_DISPLAY_VALUE", "EDITOR_ON_ENTER_KEY_ACTION")
     Values ('FORM_COLUMNS', 'VALIDATION_REGEXP', 'Валидация', '*', 'S', '1024', 'N', 'N', '', '', 'ADD', ''
            ,'*Регулярное выражение для клиентской валидации', 'N', 'N', '', '', '', '', '', '', '', '', '', 'L', 'Y'
            ,'*', '', '');

Declare
   l_clob   Clob := '<br>';
Begin
   Update FORMS
      Set description = l_clob
    Where form_code = 'FORM_COLUMNS';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>Код поля.</b></font></span><div>Внутренний идентификатор столбца запроса - уникален в пределах формы.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_COLUMNS'
      And column_code = 'COLUMN_CODE';
End;
/

Declare
   l_clob   Clob
      := '<font class="Apple-style-span" face="''times new roman'', times, serif"><span class="Apple-style-span" style="font-size: medium;"><b>Тип данных.</b></span></font><div>Пока не используется. Автоматически подставляется БД при разборе запроса.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_COLUMNS'
      And column_code = 'COLUMN_DATA_TYPE';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-family: Arial; font-size: 13px; "><h2><font size="-1">com.smartgwt.client.docs</font>&nbsp;<br>Interface SqlVsJPA</h2><hr><dl><dt><pre>public interface <b>SqlVsJPA</b></pre></dt></dl><p></p><h3>SQL DataSource vs JPA, EJB, Ibatis and other technologies</h3>If you are free to choose which persistence mechanism your application will use, you should consider using the SmartGWT SQL DataSource instead of a more heavyweight, bean-based solution. This article discusses the advantages of doing so.<p><b>Simplicity</b></p></span>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_COLUMNS'
      And column_code = 'COLUMN_DESCRIPTION';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium;"><font class="Apple-style-span" face="''times new roman'', times, serif"><b>№</b></font></span><div>Отвечает за порядок отображения столбца в таблице и в форме редактирования.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_COLUMNS'
      And column_code = 'COLUMN_DISPLAY_NUMBER';
End;
/

Declare
   l_clob   Clob
      := '<b><font class="Apple-style-span" face="''times new roman'', times, serif"><span class="Apple-style-span" style="font-size: medium;">Ширина</span></font></b>.<div>Ширина столбцах в виде целого числа либо в процентах.</div><div>В случае, если указанно целое число, ширина столбца определяется в пикселях.</div><div>Если указана ширина в процентах - ширина определяется как отношение ширины столбца к общей ширине видимых полей таблицы.</div><div>Значение "<b>*</b>" - автоматический подбор ширины.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_COLUMNS'
      And column_code = 'COLUMN_DISPLAY_SIZE';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="white-space: pre; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b><span class="Apple-style-span" style="font-size: medium;">Польз. имя.</span></b></font></span><div><span class="Apple-style-span" style="white-space: pre;"><font class="Apple-style-span" face="''times new roman'', times, serif"><span class="Apple-style-span" style="font-size: small;">Имя столбца, отображаемое пользователю. Если не указано - отображается значение поля <i>COLUMN_CODE</i>.</span></font></span></div><div><font class="Apple-style-span" face="''times new roman'', times, serif"><span class="Apple-style-span" style="font-size: small; white-space: pre;"><br></span></font></div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_COLUMNS'
      And column_code = 'COLUMN_USER_NAME';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>№ сортировки.</b></font></span><div>Описание настройки.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_COLUMNS'
      And column_code = 'DEFAULT_ORDERBY_NUMBER';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>По умолчанию.</b></font></span><div>Описание настройки.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_COLUMNS'
      And column_code = 'DEFAULT_VALUE';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>Редактор - кол-во колонок.</b></font></span><div>Описание настройки.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_COLUMNS'
      And column_code = 'EDITOR_COLS_SPAN';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>Редактор - с конца строки.</b></font></span><div>Описание настройки.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_COLUMNS'
      And column_code = 'EDITOR_END_ROW_FLAG';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>Высота поля.</b></font></span><div>Описание настройки.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_COLUMNS'
      And column_code = 'EDITOR_HEIGHT';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>Действие по нажатию Enter.</b></font></span><div>Описание настройки.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_COLUMNS'
      And column_code = 'EDITOR_ON_ENTER_KEY_ACTION';
End;
/

Declare
   l_clob   Clob
      := '<b><font class="Apple-style-span" face="''times new roman'', times, serif"><span class="Apple-style-span" style="font-size: medium;">Закладка.</span></font></b><div>Ссылка на вкладку формы редактирования.</div><div><div>В случае, если поле заполнено - поле отображается и в таблице (гриде), и в форме редактирования записи.</div><div>При необходимости отобразить поле только в форме редактирования - используйте свойство<i> SHOW_ON_GRID</i> ("<b>Отображать</b>")</div></div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_COLUMNS'
      And column_code = 'EDITOR_TAB_CODE';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>TitleOrientation.</b></font></span><div>Описание настройки.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_COLUMNS'
      And column_code = 'EDITOR_TITLE_ORIENTATION';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>В настройках?.</b></font></span><div>Описание настройки.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_COLUMNS'
      And column_code = 'EXISTS_IN_METADATA_FLAG';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>В запросе?.</b></font></span><div>Описание настройки.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_COLUMNS'
      And column_code = 'EXISTS_IN_QUERY_FLAG';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="white-space: pre; "><font class="Apple-style-span" face="''times new roman'', times, serif"><span class="Apple-style-span" style="font-size: medium;"><b>Тип поля.</b></span></font></span><div><span class="Apple-style-span" style="white-space: pre;">Используется для определения специального поведения при отрисовке формы.</span></div><div><span class="Apple-style-span" style="white-space: pre;">В данный момент определены такие типы:</span></div><div><span class="Apple-style-span" style="white-space: pre;"><br></span></div><div><span class="Apple-style-span" style="white-space: pre;"><b>Динамическая подчиненная форма одиночная (с обновлением) </b>- поле возвращает код формы детализации. При изменении кода формы производится построение новой формы детализации.</span></div><div><span class="Apple-style-span" style="white-space: pre;"><span class="Apple-tab-span" style="white-space:pre">	</span>Если код формы не изменился - происходит только обновление данных формы по данным строки мастер-формы.</span></div><div><span class="Apple-style-span" style="white-space: pre;"><span class="Apple-tab-span" style="white-space:pre">	</span><b>Пример:</b> <i>FORMS2.DETAIL_FORM.</i></span></div><div><span class="Apple-style-span" style="white-space: pre;">
<b>Динамическая подчиненная форма множественная (без обновлнения)</b> -&nbsp;поле возвращает код формы детализации. При изменении кода формы <b>всегда</b> производится</span></div><div><span class="Apple-style-span" style="white-space: pre;"><span class="Apple-tab-span" style="white-space:pre">	</span>построение новой формы детализации.<span class="Apple-style-span" style="white-space: normal; "><div><span class="Apple-style-span" style="white-space: pre; "><span class="Apple-tab-span" style="white-space: pre; ">	</span><b>Пример:</b>&nbsp;<i>FORMS2.DETAIL_FORM_MULTI.</i></span></div><div><span class="Apple-style-span" style="white-space: pre;"><br></span></div></span><b>Иконка </b>-&nbsp;xx</span></div><div><span class="Apple-style-span" style="white-space: pre;"><span class="Apple-tab-span" style="white-space:pre">	</span>ыы</span></div><div><span class="Apple-style-span" style="white-space: pre;"><span class="Apple-tab-span" style="white-space:pre">	</span><b>Пример:</b> вв
<b>Текстовый редактор<span class="Apple-style-span" style="font-weight: normal; "> -&nbsp;xx</span><span class="Apple-style-span" style="font-weight: normal; white-space: normal; "><div><span class="Apple-style-span" style="white-space: pre; "><span class="Apple-tab-span" style="white-space: pre; ">	</span>ыы</span></div><div><span class="Apple-style-span" style="white-space: pre; "><span class="Apple-tab-span" style="white-space: pre; ">	</span><b>Пример:</b> вв</span></div></span>
HTML editor<span class="Apple-style-span" style="font-weight: normal; "> -&nbsp;xx</span><span class="Apple-style-span" style="font-weight: normal; white-space: normal; "><div><span class="Apple-style-span" style="white-space: pre; "><span class="Apple-tab-span" style="white-space: pre; ">	</span>ыы</span></div><div><span class="Apple-style-span" style="white-space: pre; "><span class="Apple-tab-span" style="white-space: pre; ">	</span><b>Пример:</b> вв</span></div></span>
Заголовок формы (нередактируемый)<span class="Apple-style-span" style="font-weight: normal; "> -&nbsp;xx</span><span class="Apple-style-span" style="font-weight: normal; white-space: normal; "><div><span class="Apple-style-span" style="white-space: pre; "><span class="Apple-tab-span" style="white-space: pre; ">	</span>ыы</span></div><div><span class="Apple-style-span" style="white-space: pre; "><span class="Apple-tab-span" style="white-space: pre; ">	</span><b>Пример:</b> вв</span></div></span>
iFrame<span class="Apple-style-span" style="font-weight: normal; "> -&nbsp;xx</span><span class="Apple-style-span" style="font-weight: normal; white-space: normal; "><div><span class="Apple-style-span" style="white-space: pre; "><span class="Apple-tab-span" style="white-space: pre; ">	</span>ыы</span></div><div><span class="Apple-style-span" style="white-space: pre; "><span class="Apple-tab-span" style="white-space: pre; ">	</span><b>Пример:</b> вв</span></div></span>
Lookup простой<span class="Apple-style-span" style="font-weight: normal; "> -&nbsp;xx</span><span class="Apple-style-span" style="font-weight: normal; white-space: normal; "><div><span class="Apple-style-span" style="white-space: pre; "><span class="Apple-tab-span" style="white-space: pre; ">	</span>ыы</span></div><div><span class="Apple-style-span" style="white-space: pre; "><span class="Apple-tab-span" style="white-space: pre; ">	</span><b>Пример:</b> вв</span></div></span>
Lookup-форма<span class="Apple-style-span" style="font-weight: normal; "> -&nbsp;xx</span></b></span><span class="Apple-style-span" style="white-space: pre;"><b>
</b></span></div><div><span class="Apple-style-span" style="white-space: pre; "><span class="Apple-tab-span" style="white-space: pre; ">	</span>ыы</span></div><div><span class="Apple-style-span" style="white-space: pre; "><span class="Apple-tab-span" style="white-space: pre; ">	</span><b>Пример:</b> вв</span></div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_COLUMNS'
      And column_code = 'FIELD_TYPE';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="border-collapse: separate; color: rgb(0, 0, 0); font-family: ''Times New Roman''; font-size: medium; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; orphans: 2; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px;"><span class="Apple-style-span" style="font-family: arial,sans-serif; font-size: 13px;"><h2 style="font-size: large;"><span class="Apple-style-span" style="font-family: Arial, sans-serif; font-size: 11px; font-weight: normal; color: rgb(51, 51, 51); "><span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>Форма.</b></font></span><div>Ссылка на форму-владелец данного поля.</div></span></h2></span></span>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_COLUMNS'
      And column_code = 'FORM_CODE';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>Will become item help..</b></font></span><div>Описание настройки.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_COLUMNS'
      And column_code = 'HELP_TEXT';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>Поле подсказки.</b></font></span><div>Описание настройки.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_COLUMNS'
      And column_code = 'HOVER_COLUMN_CODE';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>Заморозить.</b></font></span><div>Описание настройки.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_COLUMNS'
      And column_code = 'IS_FROZEN_FLAG';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>Список.</b></font></span><div>Описание настройки.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_COLUMNS'
      And column_code = 'LOOKUP_CODE';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>Списки: отображаемое поле.</b></font></span><div>Описание настройки.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_COLUMNS'
      And column_code = 'LOOKUP_DISPLAY_VALUE';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>Тип поля в списке.</b></font></span><div>Описание настройки.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_COLUMNS'
      And column_code = 'LOOKUP_FIELD_TYPE';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>Первичн. ключ.</b></font></span><div>Описание настройки.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_COLUMNS'
      And column_code = 'PIMARY_KEY_FLAG';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>Подсказка.</b></font></span><div>Описание настройки.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_COLUMNS'
      And column_code = 'SHOW_HOVER_FLAG';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>Отображать в таблице.</b></font></span><div>Описание настройки.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_COLUMNS'
      And column_code = 'SHOW_ON_GRID';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="border-collapse: separate; color: rgb(0, 0, 0); font-family: ''Times New Roman''; font-size: medium; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; orphans: 2; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px;"><span class="Apple-style-span" style="color: rgb(51, 51, 51); font-family: Verdana,sans-serif; font-size: 11px;"><p>TextItems support a masked entry to restrict and format entry.</p><p>Overview of available mask characters</p><p><table class="normal" style="font-family: Verdana,sans-serif; font-size: 11px; color: rgb(51, 51, 51);"><tbody><tr><th>Character</th><th>Description</th></tr><tr><td>0</td><td>Digit (0 through 9) or plus [+] or minus [-] signs</td></tr><tr><td>9</td><td>Digit or space</td></tr><tr><td>#</td><td>Digit</td></tr><tr><td>L</td><td>Letter (A through Z)</td></tr><tr><td>?</td><td>Letter (A through Z) or space</td></tr><tr><td>A</td><td>Letter or digit</td></tr><tr><td>a</td><td>Letter or digit</td></tr><tr><td>C</td><td>Any character or space</td></tr><tr><td>&nbsp;</td></tr><tr><td>&lt;</td><td>Causes all characters that follow to be converted to lowercase</td></tr><tr><td>&gt;</td><td>Causes all characters that follow to be converted to uppercase</td></tr></tbody></table></p><p>Any character not matching one of the above mask characters or that is escaped with a backslash (\) is considered to be a literal.</p><p>Custom mask characters can be defined by standard regular expression character set or range. For example, a hexadecimal color code mask could be:</p><ul><li>Color: \#&gt;[0-9A-F][0-9A-F][0-9A-F][0-9A-F][0-9A-F][0-9A-F]</li></ul></span></span>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_COLUMNS'
      And column_code = 'TEXT_MASK';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="white-space: pre; "><font class="Apple-style-span" face="''times new roman'', times, serif"><span class="Apple-style-span" style="font-size: medium;"><b>Тип для дерева.</b></span></font></span><div><span class="Apple-style-span" style="white-space: pre;">Для форм с типом "T" ("Дерево") определяет тип столбца, например - идентификатор записи,</span></div><div><span class="Apple-style-span" style="white-space: pre;">ссылка на родителя, количество дочерних узлов, является ли узлом или конечным элементом, иконка и др.</span></div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_COLUMNS'
      And column_code = 'TREE_FIELD_TYPE';
End;
/

Declare
   l_clob   Clob
      := '<span class="Apple-style-span" style="font-size: medium; "><font class="Apple-style-span" face="''times new roman'', times, serif"><b>Иниц. дерева.</b></font></span><div>Описание настройки.</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_COLUMNS'
      And column_code = 'TREE_INITIALIZATION_VALUE';
End;
/

Declare
   l_clob   Clob
      := '<div><b>Например</b>, проверка правильности e-mail:</div><div>^([a-zA-Z0-9_.\-+])+@(([a-zA-Z0-9\-])+\.)+[a-zA-Z0-9]{2,4}$</div>';
Begin
   Update FORM_COLUMNS
      Set help_text = l_clob
    Where form_code = 'FORM_COLUMNS'
      And column_code = 'VALIDATION_REGEXP';
End;
/

Alter Table FORMS Enable All Triggers;

