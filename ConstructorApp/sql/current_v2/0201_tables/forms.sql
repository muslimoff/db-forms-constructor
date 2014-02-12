Create Table forms
    (form_code                      Varchar2(255) Not Null,
    hot_key                        Varchar2(100),
    sql_text                       Varchar2(4000),
    form_name                      Varchar2(255),
    form_type                      Varchar2(1) Default 'G',
    show_tree_root_node            Varchar2(1) Default 'Y',
    icon_id                        Number,
    form_width                     Varchar2(30) Default '*',
    form_height                    Varchar2(30) Default '*',
    bottom_tabs_orientation        Varchar2(2) Default NULL,
    side_tabs_orientation          Varchar2(2),
    show_bottom_toolbar            Varchar2(1) Default 'Y',
    object_version_number          Number Default 1,
    default_column_width           Varchar2(30) Default '*',
    description                    CLOB,
    double_click_action_code       Varchar2(255),
    lookup_width                   Number,
    apps_code                      Varchar2(255),
    export_order                   Number Default 100,
    lookup_height                  Number,
    dragdrop_action_code           Varchar2(255),
    data_page_size                 Number)
/


-- Constraints for FORMS

Alter Table forms
Add Constraint forms_pk Primary Key (form_code)
Using Index
/



-- Triggers for FORMS

Create Or Replace Trigger forms_sql_update_aiud
 After
   Insert Or Delete Or Update Of sql_text
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
Comment On Column forms.data_page_size Is 'When using data paging, how many records to fetch at a time. See com.smartgwt.client.widgets.grid.ListGrid.setDataPageSize'
/
Comment On Column forms.default_column_width Is 'Ширина полей по умолчанию'
/
Comment On Column forms.description Is 'Описание формы... для коментариев при генерации пакета и т.д'
/
Comment On Column forms.double_click_action_code Is 'Действие по двойному щелчку на записи. По умолчанию - редактирование'
/
Comment On Column forms.dragdrop_action_code Is 'Для Drag&Drop - сохранение автоматическое, указать тип действия, которое будет вызываться'
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
Comment On Column forms.lookup_height Is 'Высота лукапа (если форма выступает в роли лукапа)'
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
rem Alter Table forms Add Constraint forms_form_actions_fk Foreign Key (form_code, double_click_action_code) References form_actions (form_code,action_code)
/
-- End of DDL script for Foreign Key(s)
