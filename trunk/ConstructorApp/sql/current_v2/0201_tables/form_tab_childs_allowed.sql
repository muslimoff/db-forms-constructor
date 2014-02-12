Create Table form_tab_childs_allowed
    (form_tab_childs_allowed_id     Number,
    form_code                      Varchar2(4000),
    tab_code                       Varchar2(4000),
    child_form_code                Varchar2(4000))
/


-- Comments for FORM_TAB_CHILDS_ALLOWED

Comment On Table form_tab_childs_allowed Is 'Список динамических форм, которые могут вызываться на данном табе. Основная цель - построение дерева конструктора (удобный поиск дочерних форм). Дополнительно можно подумать: добавить в табличке FORM_TABS флаг "Разрешать вызов незарегистрированных форм" и если стоит "Нет" - выводить сообщение об ошибке: "Данная форма не зарегистрирована в табличке FORM_TAB_CHILDS_ALLOWED"'
/

-- End of DDL Script for Table FC22.FORM_TAB_CHILDS_ALLOWED

