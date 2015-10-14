# Introduction #

Add your content here.


# Details #
В действиях создать новое действие типа "Открыть URL в окне"

В поле **"PL/SQL процедура"** ввести:
xmlp?type=xmlp&ContentType=application/vnd.ms-excel&template=INS\_COMPANY\_REP&dataClobId=:REP\_DATA&filename=rep1

Где **INS\_COMPANY\_REP** - шаблон из таблицы **REPORT\_TEMPLATES**
_(выполняется запрос
Select a.clob\_content From report\_templates a Where a.report\_type\_code = 'INS\_COMPANY\_REP'
)_



> REP\_DATA имя столбца из запроса формы (скрыт), который содержит CLOB


Все остальное в пакете **INS\_COMPANY\_REP\_PKG** и форме **"Отчет по компании"**