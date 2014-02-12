Create Table fc22.form_tabs
    (form_code                      Varchar2(255),
    tab_code                       Varchar2(255),
    child_form_code                Varchar2(255),
    tab_position                   Varchar2(1),
    tab_name                       Varchar2(255),
    number_of_columns              Number Default NULL,
    icon_id                        Number,
    tab_type                       Varchar2(2),
    tab_display_number             Number)
/

Alter Table fc22.form_tabs
Add Constraint form_tabs_pk Unique (form_code, tab_code)
Using Index
/

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
