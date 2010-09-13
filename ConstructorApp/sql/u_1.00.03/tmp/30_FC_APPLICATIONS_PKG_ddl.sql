Create Or Replace 
PACKAGE applications_pkg As
   --Пока не работает - нужно полностью переделывать доступ
   Procedure create_new_application (p_schema_name In Varchar2, p_tablespace_name In Varchar2 Default 'FC');

   Function get_fc_schema
      Return Varchar2;
End applications_pkg;
/

Grant Execute On applications_pkg To fc22_admin
/

Create Or Replace 
PACKAGE BODY applications_pkg As
   Function get_fc_schema
      Return Varchar2 Is
-- Функция возвращает имя схемы
      Result   Varchar2 (30);
   Begin
      Select username
        Into Result
        From user_users
       Where user_id = USERENV ('SCHEMAID');

      Return Result;
   End;

   Procedure create_new_application (p_schema_name In Varchar2, p_tablespace_name In Varchar2 Default 'FC') Is
   Begin
      Execute Immediate    'Create USER '
                        || p_schema_name
                        || ' Identified By '
                        || p_schema_name
                        || ' DEFAULT Tablespace '
                        || p_tablespace_name
                        || ' Temporary Tablespace temp';

      Null;
   End;
End applications_pkg;
/

