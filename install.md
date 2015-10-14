# Introduction #

Add your content here.


# Details #
  * Под пользователем SYS cоздать пользователя FORMS\_CONSTRUCTOR (можно и по другому, например FC, единственный минус - то что в приложении по умолчанию забит FORMS\_CONSTRUCTOR - пока придется при коннекте руками перебивать). **DEFAULT Tablespace** выбрать на свой вкус, если нет или не нравится это...

```
Create USER forms_constructor
Identified By f
DEFAULT Tablespace apps_ts_tx_data
Temporary Tablespace TEMP
/
Grant Connect To forms_constructor
/
Grant Dba To forms_constructor
/
Grant Resource To forms_constructor
/
Grant Select On Sys.V_$SQL_CURSOR To forms_constructor
/
Grant Select On Sys.V_$SQL_BIND_METADATA  To forms_constructor
/
```

  * Скачать и залить [дамп](http://db-forms-constructor.googlecode.com/files/fc20091029.zip)
  * Скачать и задеплоить [варик](http://db-forms-constructor.googlecode.com/files/ConstructorApp.war)
  * Пробуем подключиться. Если в списке серверов подходящего нет или подключиться не получилось - можно указать строку вида **jdbc:oracle:thin:@host:port:sid**, например **jdbc:oracle:thin:@192.168.110.3:1524:VIS12**