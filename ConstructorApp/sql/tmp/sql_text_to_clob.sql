
/
/
Alter Table fc22.forms Rename Column sql_text To sql_text_old;
Alter Table fc22.forms Add sql_text CLOB;
alter table fc22.forms disable all triggers;
Update fc22.forms f
   Set f.sql_text = f.sql_text_old
/

Create Or Replace Trigger fc22.forms_sql_update_aiud
   After Insert Or Delete Or Update
   On fc22.forms
   Referencing New As New Old As Old
   For Each Row
Declare
   --Вызов процедуры перегенерации таблицы FORM_COLUMNS$
   x   Number;
Begin
   If DELETING
   Then
      form_utils.refresh_temp_columns(:Old.form_code, :Old.sql_text, :Old.default_column_width, p_delete_only_flag => 'Y');
   Elsif    INSERTING
         Or (    UPDATING
             And :Old.sql_text != :New.sql_text)
   Then
      form_utils.refresh_temp_columns(:New.form_code, :New.sql_text, :New.default_column_width);
   End If;
End FORMS_SQL_UPDATE_AIUD;
/

