/*Select   a.lookup_code, a.lookup_value_code, a.lookup_display_value
    From lookup_values a
   Where a.lookup_code In (Select a.lookup_code
                             From lookups a
                            Where a.apps_code = 'FC')
Order By a.lookup_code, a.lookup_value_code
*/

Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORMS.EDITOR_POSITION', 'B', 'Снизу')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORMS.EDITOR_POSITION', 'R', 'Справа')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORMS.FORM_TYPE', 'G', 'Грид')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORMS.FORM_TYPE', 'T', 'Дерево')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORMS.TABS_ORIENTATION', 'B', 'Снизу')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORMS.TABS_ORIENTATION', 'H', 'Скрыть')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORMS.TABS_ORIENTATION', 'L', 'Слева')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORMS.TABS_ORIENTATION', 'R', 'Справа')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORMS.TABS_ORIENTATION', 'T', 'Сверху')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_ACTIONS.ACTION_TYPE', '1', 'Вставка')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_ACTIONS.ACTION_TYPE', '10', 'Открыть дочернюю форму в новом табе')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_ACTIONS.ACTION_TYPE', '11', 'Открыть дочернюю форму в новом окне')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_ACTIONS.ACTION_TYPE', '12', 'Экспорт таблицы')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_ACTIONS.ACTION_TYPE', '13', '**Экспорт записи')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_ACTIONS.ACTION_TYPE', '14', '**Печать')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_ACTIONS.ACTION_TYPE', '15', 'Открыть URL в окне')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_ACTIONS.ACTION_TYPE', '16', 'Проверка записи на сервере (валидация)')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_ACTIONS.ACTION_TYPE', '17', 'Закрыть текущую форму')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_ACTIONS.ACTION_TYPE', '18', 'Обновить ветвь дерева')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_ACTIONS.ACTION_TYPE', '2', 'Обновление (Update)')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_ACTIONS.ACTION_TYPE', '3', 'Удаление')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_ACTIONS.ACTION_TYPE', '4', 'Refresh')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_ACTIONS.ACTION_TYPE', '5', 'Перейти на предыдущую запись')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_ACTIONS.ACTION_TYPE', '6', 'Перейти на следующую запись')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_ACTIONS.ACTION_TYPE', '7', 'PL/SQL Процедура на неизмененных данных')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_ACTIONS.ACTION_TYPE', '8', 'Редактировать запись')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_ACTIONS.ACTION_TYPE', '9', 'Фильтр')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_ACTIONS.ACTION_TYPE', '99', 'TestAction')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.ACTION_TYPE', '1', 'По нажатию клавиши')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.ACTION_TYPE', '2', 'При входе в поле')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.ACTION_TYPE', '3', 'При выходе из поля')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.ACTION_TYPE', '4', 'После выбора из списка')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.DATA_TYPE', 'B', 'Boolean')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.DATA_TYPE', 'D', 'Date')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.DATA_TYPE', 'N', 'Number')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.DATA_TYPE', 'S', 'String')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.DISPLAY_TYPE', 'B', 'И в таблице и в форме редактирования')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.DISPLAY_TYPE', 'E', 'Только форма редактирования')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.DISPLAY_TYPE', 'G', 'Только в таблице')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.FIELD_TYPE', '1', 'Динамическая подчиненная форма одиночная (с обновлением)')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.FIELD_TYPE', '10', 'Lookup простой (сортировка по значению)')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.FIELD_TYPE', '11', 'Link')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.FIELD_TYPE', '12', '[Статус выполнения. OUT. Текст сообщения]')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.FIELD_TYPE', '13', '[Статус выполнения. IN. Номер ответа (нажатой кнопки)]')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.FIELD_TYPE', '14', '[Статус выполнения. OUT. Уровень сообщения]')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.FIELD_TYPE', '15', 'Редактор кода (Пока только PL/SQL)')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.FIELD_TYPE', '16', 'Lookup-форма')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.FIELD_TYPE', '2', 'Динамическая подчиненная форма множественная (без обновлнения)')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.FIELD_TYPE', '3', 'Иконка')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.FIELD_TYPE', '4', 'Текстовый редактор')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.FIELD_TYPE', '5', 'HTML editor')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.FIELD_TYPE', '6', 'Заголовок формы (нередактируемый)')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.FIELD_TYPE', '7', 'iFrame')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.FIELD_TYPE', '8', 'Lookup простой (сортировка по коду)')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.FIELD_TYPE', '9', '!!!Устарело!!! Lookup-форма')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.FIELD_TYPE', '99', 'PickTreeList')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.LOOKUP_FIELD_TYPE', '1', 'Идентификатор (передается в БД при сохранении)')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.LOOKUP_FIELD_TYPE', '2', 'Значение - отображается пользователю')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.LOOKUP_FIELD_TYPE', '3', 'Дополнительное отображаемое поле')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.TREE_FIELD_TYPE', '1', 'Идентификатор записи')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.TREE_FIELD_TYPE', '2', 'Идентификатор родителя')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.TREE_FIELD_TYPE', '3', 'Признак, является ли поддеревом или конечным элементом')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.TREE_FIELD_TYPE', '4', 'Иконка')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.TREE_FIELD_TYPE', '5', 'Количество дочерних элементов у текущего узла')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.TREE_FIELD_TYPE', '6', 'Флаг canAcceptDrop (разрешать ли вложенные узлы при перетаскивании)')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMNS.TREE_FIELD_TYPE', '7', 'Флаг canDrag (разрешать ли перетаскиваниие)')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMN_LOOKUP_MAP.MAPPING_TYPE', 'COLUMN', 'Столбец')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_COLUMN_LOOKUP_MAP.MAPPING_TYPE', 'CONSTANT', 'Константа')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_TABS.TAB_TYPE', '1', 'Редактор форм')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_TABS.TAB_TYPE', '2', 'Статическая подчиненная форма')
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_TABS.TAB_TYPE', '3', 'Динамическая подчиненная форма')
/

