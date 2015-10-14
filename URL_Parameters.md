# Introduction #

Описание параметров URL.


# Details #

Возможые параметры
  * `app.serverID` - код сервера из элемента dbConnections/server@id файла constructorapp.xml
  * `app.userName` - имя пользователя. Перекрывает настройки constructorapp.xml. Работает при заданном непустом serverID
  * `app.pwd` - пароль. Используется преимущественно для кастомной авторизации из других приложений
  * `app.form` - форма, открываемая при запуске. Разрешается множественное перечисление
  * _param=value_ - все остальные параметры передаются в открываемые формы и в дальнейшем обрабатываются как их параметры

Пример:
http://127.0.0.1:8888/ConstructorApp.html?app.serverID=14&app.userName=FC22&app.pwd=fc&app.form=MENUS&app.form=FORMS&form_code=LOOKUPS_LIST