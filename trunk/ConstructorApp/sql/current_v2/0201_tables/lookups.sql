Create Table lookups
    (lookup_code                    Varchar2(255),
    lookup_name                    Varchar2(255),
    apps_code                      Varchar2(255),
    search_mode_code               Varchar2(1),
    description                    CLOB)
/


-- Comments for LOOKUPS

Comment On Column lookups.apps_code Is 'Идентификатор приложения (Для автосоздания скриптов)'
/
Comment On Column lookups.description Is 'Описание (для документации)'
/
Comment On Column lookups.lookup_code Is 'Текстовый идентфикатор (ID)'
/
Comment On Column lookups.lookup_name Is 'Пользовательское имя'
/
Comment On Column lookups.search_mode_code Is 'Режим поиска'
/

-- End of DDL Script for Table FC22.LOOKUPS

