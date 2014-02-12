--Select a.lookup_code, a.lookup_name, a.apps_code From lookups a Where a.apps_code = 'FC'
Insert Into lookups
            ("LOOKUP_CODE", "LOOKUP_NAME", "APPS_CODE")
     Values ('FORM_COLUMNS.FIELD_TYPE', 'Тип поля (общий для всех типов форм)', 'FC')
/
Insert Into lookups
            ("LOOKUP_CODE", "LOOKUP_NAME", "APPS_CODE")
     Values ('FORM_ACTIONS.ACTION_TYPE', 'Тип действия', 'FC')
/
Insert Into lookups
            ("LOOKUP_CODE", "LOOKUP_NAME", "APPS_CODE")
     Values ('FORMS.TABS_ORIENTATION', 'Ориентация табов детализации', 'FC')
/
Insert Into lookups
            ("LOOKUP_CODE", "LOOKUP_NAME", "APPS_CODE")
     Values ('FORM_COLUMNS.LOOKUP_FIELD_TYPE', 'Тип поля в лукапе', 'FC')
/
Insert Into lookups
            ("LOOKUP_CODE", "LOOKUP_NAME", "APPS_CODE")
     Values ('FORMS.FORM_TYPE', 'Тип формы. (грид, дерево)', 'FC')
/
Insert Into lookups
            ("LOOKUP_CODE", "LOOKUP_NAME", "APPS_CODE")
     Values ('FORM_COLUMNS.TREE_FIELD_TYPE', 'Тип поля для дерева', 'FC')
/
Insert Into lookups
            ("LOOKUP_CODE", "LOOKUP_NAME", "APPS_CODE")
     Values ('FORM_COLUMNS.DISPLAY_TYPE', 'Где отображать поле(грид/форма)', 'FC')
/
Insert Into lookups
            ("LOOKUP_CODE", "LOOKUP_NAME", "APPS_CODE")
     Values ('FORMS.EDITOR_POSITION', 'Позиция редактора', 'FC')
/
Insert Into lookups
            ("LOOKUP_CODE", "LOOKUP_NAME", "APPS_CODE")
     Values ('FORM_COLUMNS.DATA_TYPE', 'Тип данных поля', 'FC')
/
Insert Into lookups
            ("LOOKUP_CODE", "LOOKUP_NAME", "APPS_CODE")
     Values ('FORM_TABS.TAB_TYPE', 'Тип закладки', 'FC')
/
Insert Into lookups
            ("LOOKUP_CODE", "LOOKUP_NAME", "APPS_CODE")
     Values ('FORM_COLUMNS.ACTION_TYPE', 'Типы действий для полей', 'FC')
/
Insert Into lookups
            ("LOOKUP_CODE", "LOOKUP_NAME", "APPS_CODE")
     Values ('FORM_COLUMN_LOOKUP_MAP.MAPPING_TYPE', 'Типы поля для меппинга лукапов', 'FC')
/
Insert Into lookups
            ("LOOKUP_CODE", "LOOKUP_NAME", "APPS_CODE")
     Values ('LOOKUP_SEARCH_MODE_CODE', 'Режим поиска в лукапах', 'FC')
/

