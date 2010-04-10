Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (1, 'VARCHAR2', 1020, 'COLUMN_CODE', 11, 0, 0, 'COLUMNS_LIST', Null, '*'
            ,'*Идентификатор поля (из запроса)')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (2, 'VARCHAR2', 1020, 'COLUMN_USER_NAME', 16, 0, 0, 'COLUMNS_LIST', Null, '*', '*Пользовательское имя поля')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (1, 'VARCHAR2', 28, 'ENTITY_TYPE', 11, 0, 0, 'FORMS2', Null, '*', '**ENTITY_TYPE')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (2, 'VARCHAR2', 2000, 'PARENT_CODE', 11, 0, 0, 'FORMS2', Null, '*', '**PARENT_CODE')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (3, 'VARCHAR2', 1020, 'CODE', 4, 0, 0, 'FORMS2', Null, '*', '**CODE')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (4, 'VARCHAR2', 1020, 'USER_NAME', 9, 0, 0, 'FORMS2', Null, '*', '** Для всех пользователей')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (5, 'NUMBER', 22, 'ICON_ID', 7, 0, -127, 'FORMS2', Null, '*', '**ICON_ID')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (6, 'NUMBER', 2, 'CHILD_COUNT', 11, 0, -127, 'FORMS2', Null, '*'
            ,'*5 - Количество дочерних элементов у текущего узла (0 - ветвь не имеет подэлементов);')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (7, 'CLOB', 4000, 'DESCRIPTION', 11, 0, 0, 'FORMS2', Null, '*', '*Description of the subscription')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (8, 'NUMBER', 2, 'IS_FOLDER', 9, 0, 0, 'FORMS2', Null, '*', '**IS_FOLDER')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (9, 'VARCHAR2', 2000, 'FORM_CODE_FOR_FILTER', 20, 0, 0, 'FORMS2', Null, '*', '**FORM_CODE_FOR_FILTER')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (10, 'VARCHAR2', 12, 'DETAIL_FORM', 11, 0, 0, 'FORMS2', Null, '*', '**DETAIL_FORM')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (11, 'VARCHAR2', 1020, 'DETAIL_FORM_MULTI', 17, 0, 0, 'FORMS2', Null, '*', '**DETAIL_FORM_MULTI')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (1, 'NUMBER', 22, 'ICON_ID', 7, 0, -127, 'ICONS', Null, Null, '**ICON_ID')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (2, 'NUMBER', 22, 'ICON', 4, 0, -127, 'ICONS', Null, Null, '**ICON')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (3, 'VARCHAR2', 4000, 'ICON_FILE_NAME', 14, 0, 0, 'ICONS', Null, Null
            ,'*файл иконки по пути default_icon_path')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (4, 'VARCHAR2', 1020, 'ICON_PATH', 9, 0, 0, 'ICONS', Null, Null, '**ICON_PATH')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (1, 'VARCHAR2', 255, 'FORM_CODE', 9, 0, 0, 'FORM_TABS', 'Y', '*', '*Идентификатор форм')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (2, 'VARCHAR2', 255, 'TAB_CODE', 8, 0, 0, 'FORM_TABS', 'Y', '*', '*Идентификатор закладки')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (3, 'VARCHAR2', 255, 'CHILD_FORM_CODE', 15, 0, 0, 'FORM_TABS', Null, '*', '**CHILD_FORM_CODE')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (4, 'VARCHAR2', 1, 'TAB_POSITION', 12, 0, 0, 'FORM_TABS', Null, '*', '*Lookup FORMS.EDITOR_POSITION')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (5, 'VARCHAR2', 255, 'TAB_NAME', 8, 0, 0, 'FORM_TABS', Null, '*', '*Пользовательское имя закладки')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (6, 'NUMBER', 22, 'NUMBER_OF_COLUMNS', 17, 0, -127, 'FORM_TABS', Null, '*'
            ,'*см. com.smartgwt.client.widgets.form.DynamicForm   setNumCols')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (7, 'NUMBER', 22, 'ICON_ID', 7, 0, -127, 'FORM_TABS', Null, '*', '**ICON_ID')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (8, 'VARCHAR2', 2, 'TAB_TYPE', 8, 0, 0, 'FORM_TABS', Null, '*', '**TAB_TYPE')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (9, 'NUMBER', 22, 'TAB_DISPLAY_NUMBER', 18, 0, -127, 'FORM_TABS', Null, '*', '*Порядок сортировки')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (1, 'VARCHAR2', 2000, 'LOOKUP_TYPE', 11, 0, 0, 'LOOKUPS_LIST', Null, '*', '**LOOKUP_TYPE')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (2, 'VARCHAR2', 1020, 'LOOKUP_CODE', 11, 0, 0, 'LOOKUPS_LIST', Null, '*'
            ,'*Ссылка на лукап - формау или простой')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (3, 'VARCHAR2', 1020, 'LOOKUP_NAME', 11, 0, 0, 'LOOKUPS_LIST', Null, '*', '*Пользовательское имя')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (1, 'VARCHAR2', 1020, 'FORM_CODE', 9, 0, 0, 'FORMS_LIST', Null, '*', '*Идентификатор форм')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (2, 'VARCHAR2', 1020, 'FORM_NAME', 9, 0, 0, 'FORMS_LIST', Null, '*', '*Имя формы для пользователя')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (3, 'VARCHAR2', 400, 'HOT_KEY', 7, 0, 0, 'FORMS_LIST', Null, '*'
            ,'*Горячая клавиша  - строка вида [Ctrl+][Alt+][Shift+]Chr. Регистр не важен')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (4, 'NUMBER', 22, 'ICON_ID', 7, 0, -127, 'FORMS_LIST', Null, '*', '**ICON_ID')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (1, 'VARCHAR2', 255, 'FORM_CODE', 9, 0, 0, 'FORM_ACTIONS', Null, '*', '*Идентификатор форм')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (2, 'VARCHAR2', 255, 'ACTION_CODE', 11, 0, 0, 'FORM_ACTIONS', Null, '*', '**ACTION_CODE')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (3, 'VARCHAR2', 255, 'PROCEDURE_NAME', 14, 0, 0, 'FORM_ACTIONS', Null, '*', '*Name of the procedure')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (4, 'VARCHAR2', 255, 'ACTION_DISPLAY_NAME', 19, 0, 0, 'FORM_ACTIONS', Null, '*', '**ACTION_DISPLAY_NAME')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (5, 'NUMBER', 22, 'ICON_ID', 7, 0, -127, 'FORM_ACTIONS', Null, '*', '**ICON_ID')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (6, 'VARCHAR2', 255, 'DEFAULT_PARAM_PREFIX', 20, 0, 0, 'FORM_ACTIONS', Null, '*', '**DEFAULT_PARAM_PREFIX')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (7, 'VARCHAR2', 255, 'DEFAULT_OLD_PARAM_PREFIX', 24, 0, 0, 'FORM_ACTIONS', Null, '*'
            ,'**DEFAULT_OLD_PARAM_PREFIX')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (8, 'VARCHAR2', 2, 'ACTION_TYPE', 11, 0, 0, 'FORM_ACTIONS', Null, '*', '**ACTION_TYPE')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (9, 'NUMBER', 22, 'DISPLAY_NUMBER', 14, 0, -127, 'FORM_ACTIONS', Null, '*', '**DISPLAY_NUMBER')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (10, 'VARCHAR2', 4000, 'CONFIRM_TEXT', 12, 0, 0, 'FORM_ACTIONS', Null, '*', '**CONFIRM_TEXT')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (11, 'VARCHAR2', 1020, 'HOT_KEY', 7, 0, 0, 'FORM_ACTIONS', Null, '*'
            ,'*Горячая клавиша  - строка вида [Ctrl+][Alt+][Shift+]Chr. Регистр не важен')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (12, 'VARCHAR2', 4, 'SHOW_SEPARATOR_BELOW', 20, 0, 0, 'FORM_ACTIONS', Null, '*', '**SHOW_SEPARATOR_BELOW')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (13, 'VARCHAR2', 4, 'DISPLAY_ON_TOOLBAR', 18, 0, 0, 'FORM_ACTIONS', Null, '*', '**DISPLAY_ON_TOOLBAR')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (2, 'VARCHAR2', 255, 'TAB_CODE', 8, 0, 0, 'FORM_TABS_LIST', Null, '*', '*Идентификатор закладки')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (3, 'VARCHAR2', 1020, 'TAB_NAME', 8, 0, 0, 'FORM_TABS_LIST', Null, '*', '*Пользовательское имя закладки')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (4, 'VARCHAR2', 2, 'TAB_TYPE', 8, 0, 0, 'FORM_TABS_LIST', Null, '*', '**TAB_TYPE')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (1, 'VARCHAR2', 255, 'FORM_CODE', 9, 0, 0, 'FORM_TABS_LIST', Null, '*', '*Идентификатор форм')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (1, 'NUMBER', 22, 'COLUMN_DISPLAY_NUMBER', 21, 0, 0, 'FORM_COLUMNS', Null, '*'
            ,'*Порядковый номер отображения в таблице')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (2, 'VARCHAR2', 1020, 'FORM_CODE', 9, 0, 0, 'FORM_COLUMNS', 'Y', '*', '*Идентификатор форм')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (3, 'VARCHAR2', 1020, 'COLUMN_CODE', 11, 0, 0, 'FORM_COLUMNS', 'Y', '*', '*Идентификатор поля (из запроса)')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (4, 'VARCHAR2', 1020, 'COLUMN_DATA_TYPE', 16, 0, 0, 'FORM_COLUMNS', Null, '*'
            ,'*Тип данных (FORM_COLUMNS.DATA_TYPE)')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (5, 'VARCHAR2', 1020, 'COLUMN_USER_NAME', 16, 0, 0, 'FORM_COLUMNS', Null, '*', '*Пользовательское имя поля')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (6, 'VARCHAR2', 1020, 'COLUMN_DISPLAY_SIZE', 19, 0, 0, 'FORM_COLUMNS', Null, '*'
            ,'*Ширина поля в писькелях')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (7, 'VARCHAR2', 4, 'PIMARY_KEY_FLAG', 15, 0, 0, 'FORM_COLUMNS', Null, '*'
            ,'*Признак того, что поле является первичным ключем (Y). Пусто - не является.')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (8, 'VARCHAR2', 4, 'SHOW_ON_GRID', 12, 0, 0, 'FORM_COLUMNS', Null, '*', '*Показывать в гриде')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (9, 'VARCHAR2', 8000, 'TREE_INITIALIZATION_VALUE', 25, 0, 0, 'FORM_COLUMNS', Null, '*'
            ,'*Если не пусто и тип формы - "дерево" - используется при первом вызове дерева для инициализации. Аналогично конструкции Start With древовидных запросов')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (10, 'VARCHAR2', 8, 'TREE_FIELD_TYPE', 15, 0, 0, 'FORM_COLUMNS', Null, '*'
            ,'*Тип поля для дерева (Id, ParentId, ChildCount...)')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (11, 'VARCHAR2', 1020, 'EDITOR_TAB_CODE', 15, 0, 0, 'FORM_COLUMNS', Null, '*'
            ,'*Ссылка на закладку формы редактирования. Если не указано - показывается только в гриде')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (12, 'VARCHAR2', 8, 'FIELD_TYPE', 10, 0, 0, 'FORM_COLUMNS', Null, '*'
            ,'*Тип поля, общий для дерева и грида')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (13, 'VARCHAR2', 8000, 'COLUMN_DESCRIPTION', 18, 0, 0, 'FORM_COLUMNS', Null, '*'
            ,'*Описание поля (подсказка для пользователя)')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (14, 'VARCHAR2', 4, 'IS_FROZEN_FLAG', 14, 0, 0, 'FORM_COLUMNS', Null, '*', '*Замораживать поле?')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (15, 'VARCHAR2', 4, 'SHOW_HOVER_FLAG', 15, 0, 0, 'FORM_COLUMNS', Null, '*'
            ,'*Показывать всплывающую подсказку-значение поля')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (16, 'VARCHAR2', 4, 'EXISTS_IN_METADATA_FLAG', 23, 0, 0, 'FORM_COLUMNS', Null, '*'
            ,'**EXISTS_IN_METADATA_FLAG')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (17, 'VARCHAR2', 4, 'EXISTS_IN_QUERY_FLAG', 20, 0, 0, 'FORM_COLUMNS', Null, '*', '**EXISTS_IN_QUERY_FLAG')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (18, 'VARCHAR2', 1020, 'LOOKUP_CODE', 11, 0, 0, 'FORM_COLUMNS', Null, '*'
            ,'*Ссылка на лукап - формау или простой')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (19, 'VARCHAR2', 1020, 'HOVER_COLUMN_CODE', 17, 0, 0, 'FORM_COLUMNS', Null, '*'
            ,'*Поле той же формы, которое содержит подсказку. Если SHOW_HOVER_FLAG = ''Y'' и HOVER_COLUMN_CODE - подсказка берется из текущего поля (COLUMN_CODE)')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (20, 'VARCHAR2', 1020, 'EDITOR_HEIGHT', 13, 0, 0, 'FORM_COLUMNS', Null, '*'
            ,'*Высота поля в закладке редактирования')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (21, 'VARCHAR2', 4, 'LOOKUP_FIELD_TYPE', 17, 0, 0, 'FORM_COLUMNS', Null, '*'
            ,'*См. Lookup FORM_COLUMNS.LOOKUP_FIELD_TYPE')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (22, 'CLOB', 32767, 'HELP_TEXT', 9, 0, 0, 'FORM_COLUMNS', Null, '*', '*Will become item help.')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (23, 'VARCHAR2', 1020, 'TEXT_MASK', 9, 0, 0, 'FORM_COLUMNS', Null, '*'
            ,'*Текстовая маска для поля. См. описание в интерфейсе')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (24, 'VARCHAR2', 1020, 'VALIDATION_REGEXP', 17, 0, 0, 'FORM_COLUMNS', Null, '*'
            ,'*Регулярное выражение для клиентской валидации')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (25, 'VARCHAR2', 40, 'DEFAULT_ORDERBY_NUMBER', 22, 0, 0, 'FORM_COLUMNS', Null, '*'
            ,'*Порядок сортировки при открытии формы. "-" после цифры - сортировка по убыванию')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (26, 'VARCHAR2', 1020, 'DEFAULT_VALUE', 13, 0, 0, 'FORM_COLUMNS', Null, '*'
            ,'*Default value for the argument')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (27, 'VARCHAR2', 4, 'EDITOR_TITLE_ORIENTATION', 24, 0, 0, 'FORM_COLUMNS', Null, '*'
            ,'*item.setTitleOrientation')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (28, 'VARCHAR2', 40, 'EDITOR_COLS_SPAN', 16, 0, 0, 'FORM_COLUMNS', Null, '*'
            ,'*Редактор - количество колонок, занимаемых полем (item.setColSpan)')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (29, 'VARCHAR2', 4, 'EDITOR_END_ROW_FLAG', 19, 0, 0, 'FORM_COLUMNS', Null, '*', '*item.setEndRow')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (30, 'VARCHAR2', 1020, 'LOOKUP_DISPLAY_VALUE', 20, 0, 0, 'FORM_COLUMNS', Null, '*'
            ,'*Поле запроса, отображаемое пользователю - для длинных лукапов')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (31, 'VARCHAR2', 1020, 'LOOKUP_NAME', 11, 0, 0, 'FORM_COLUMNS', Null, '*', '*Пользовательское имя')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (1, 'VARCHAR2', 1020, 'MENU_CODE', 9, 0, 0, 'MENUS', 'Y', '*', '*Код меню')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (2, 'VARCHAR2', 1020, 'MENU_NAME', 9, 0, 0, 'MENUS', Null, '*', '*Пользовательское наименование меню')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (3, 'VARCHAR2', 1020, 'PARENT_MENU_CODE', 16, 0, 0, 'MENUS', Null, '*', '*Ссылка на пункт меню-родитель')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (4, 'VARCHAR2', 1020, 'PARENT_DISPLAY', 14, 0, 0, 'MENUS', Null, '*', '**PARENT_DISPLAY')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (5, 'VARCHAR2', 1020, 'MENU_FORM_CODE', 14, 0, 0, 'MENUS', Null, '*'
            ,'*Ссылка на форму (для конечных узлов)')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (6, 'VARCHAR2', 1020, 'FORM_DISPLAY', 12, 0, 0, 'MENUS', Null, '*', '**FORM_DISPLAY')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (7, 'VARCHAR2', 1020, 'FORM_DISPLAY_STAT', 17, 0, 0, 'MENUS', Null, '*', '**FORM_DISPLAY_STAT')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (8, 'NUMBER', 22, 'MENU_POSITION', 13, 0, 0, 'MENUS', Null, '*'
            ,'*Позиция пунктов на одном уровне. Если не указано - то сначала нумерованные, потом по наименованию')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (1, 'VARCHAR2', 255, 'LOOKUP_CODE', 11, 0, 0, 'LOOKUPS', Null, '120'
            ,'*Ссылка на лукап - формау или простой')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (2, 'VARCHAR2', 255, 'LOOKUP_NAME', 11, 0, 0, 'LOOKUPS', Null, '120', '*Пользовательское имя')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (1, 'VARCHAR2', 255, 'LOOKUP_CODE', 11, 0, 0, 'LOOKUP_VALUES', Null, '*'
            ,'*Ссылка на лукап - формау или простой')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (2, 'VARCHAR2', 255, 'LOOKUP_VALUE_CODE', 17, 0, 0, 'LOOKUP_VALUES', Null, '*', '**LOOKUP_VALUE_CODE')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (3, 'VARCHAR2', 255, 'LOOKUP_DISPLAY_VALUE', 20, 0, 0, 'LOOKUP_VALUES', Null, '*', '**LOOKUP_DISPLAY_VALUE')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (9, 'NUMBER', 22, 'ICON_ID', 7, 0, 0, 'MENUS', Null, '*', '**ICON_ID')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (10, 'NUMBER', 22, 'IS_FOLDER', 9, 0, 0, 'MENUS', Null, '*', '**IS_FOLDER')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (11, 'VARCHAR2', 400, 'ELEMENT_TYPE', 12, 0, 0, 'MENUS', Null, '*', '**ELEMENT_TYPE')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (12, 'VARCHAR2', 1020, 'FORM_CODE_FOR_FILTER', 20, 0, 0, 'MENUS', Null, '*', '**FORM_CODE_FOR_FILTER')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (13, 'VARCHAR2', 4, 'SHOW_IN_NAVIGATOR', 17, 0, 0, 'MENUS', Null, '*', '*Показывать в навигаторе')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (1, 'VARCHAR2', 1020, 'FORM_CODE', 9, 0, 0, 'FORMS', 'Y', '*', '*Идентификатор форм')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (2, 'VARCHAR2', 400, 'HOT_KEY', 7, 0, 0, 'FORMS', Null, '*'
            ,'*Горячая клавиша  - строка вида [Ctrl+][Alt+][Shift+]Chr. Регистр не важен')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (3, 'VARCHAR2', 4000, 'SQL_TEXT', 8, 0, 0, 'FORMS', Null, '*'
            ,'*Order by во внешнем запросе не используйте, иначе при сортировке лететь будет..')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (4, 'VARCHAR2', 1020, 'FORM_NAME', 9, 0, 0, 'FORMS', Null, '*', '*Имя формы для пользователя')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (5, 'VARCHAR2', 4, 'FORM_TYPE', 9, 0, 0, 'FORMS', Null, '*', '*Тип показываемой формы')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (6, 'VARCHAR2', 4, 'SHOW_TREE_ROOT_NODE', 19, 0, 0, 'FORMS', Null, '*'
            ,'*Показывать ли корневой узел для дерева?')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (7, 'NUMBER', 22, 'ICON_ID', 7, 0, -127, 'FORMS', Null, '*', '**ICON_ID')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (8, 'VARCHAR2', 120, 'FORM_WIDTH', 10, 0, 0, 'FORMS', Null, '*'
            ,'*ширина в пикселях или процентах. * - авто')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (9, 'VARCHAR2', 120, 'FORM_HEIGHT', 11, 0, 0, 'FORMS', Null, '*'
            ,'*высота в пикселях или процентах. * - авто')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (10, 'VARCHAR2', 8, 'BOTTOM_TABS_ORIENTATION', 23, 0, 0, 'FORMS', Null, '*'
            ,'*ориентация нижних табиков детализации. см. FORMS.TABS_ORIENTATION')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (11, 'VARCHAR2', 8, 'SIDE_TABS_ORIENTATION', 21, 0, 0, 'FORMS', Null, '*'
            ,'*ориентация боковых табиков детализации. см. FORMS.TABS_ORIENTATION')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (12, 'VARCHAR2', 4, 'SHOW_BOTTOM_TOOLBAR', 19, 0, 0, 'FORMS', Null, '*', '*Показывать нижний тулбар?')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (13, 'NUMBER', 22, 'OBJECT_VERSION_NUMBER', 21, 0, -127, 'FORMS', Null, '*', '**OBJECT_VERSION_NUMBER')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (14, 'VARCHAR2', 120, 'DEFAULT_COLUMN_WIDTH', 20, 0, 0, 'FORMS', Null, '*', '*Ширина полей по умолчанию')
/
Insert Into form_columns$
            ("COL_NUM", "COL_TYPE", "COL_MAX_LEN", "COL_NAME", "COL_NAME_LEN", "COL_PRECISION", "COL_SCALE"
            ,"FORM_CODE", "PIMARY_KEY_FLAG", "DEFAULT_COLUMN_WIDTH", "COLUMN_DESCRIPTION")
     Values (15, 'CLOB', 4000, 'DESCRIPTION', 11, 0, 0, 'FORMS', Null, '*', '*Description of the subscription')
/

