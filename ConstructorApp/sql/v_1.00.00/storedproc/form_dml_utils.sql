-- Start of DDL Script for Package FC.FORM_DML_UTILS
-- Generated 10.04.2010 22:24:48 from FC@VM_XE

Create Or Replace 
PACKAGE form_dml_utils Is
   Type parameter_value_rec Is Record (
      parameter_name         Varchar2 (255)
     ,parameter_char_value   Varchar2 (4000)
   );

   Type parameter_values_tbl Is Table Of parameter_value_rec
      Index By Varchar2 (255);

   Procedure init;

   Procedure set_parameter_value (p_parameter_name Varchar2, p_parameter_char_value Varchar2);

   Function execute_form_action (p_procedure_name Varchar2)
      Return Varchar2;
End FORM_DML_UTILS;
/


Create Or Replace 
PACKAGE BODY form_dml_utils Is
/*
Не используется. Оставил как пример работы с коллекциями, индексированными по varchar*/
   g_parameter_values   parameter_values_tbl;

   Procedure init Is
   Begin
      g_parameter_values.Delete;
   End init;

   Procedure set_parameter_value (p_parameter_name Varchar2, p_parameter_char_value Varchar2) Is
      l_parameter_value_rec   parameter_value_rec;
   Begin
      If (p_parameter_name Is Null) Then
         raise_application_error (-20001, 'p_parameter_name Is Null');
      End If;

      l_parameter_value_rec.parameter_name          := p_parameter_name;
      l_parameter_value_rec.parameter_char_value    := p_parameter_char_value;
      g_parameter_values (p_parameter_name)         := l_parameter_value_rec;
   End set_parameter_value;

   Function execute_form_action (p_procedure_name Varchar2)
      Return Varchar2 Is
      Type bind_var_tbl Is Table Of parameter_value_rec
         Index By Binary_integer;

      l_bind_var_values    bind_var_tbl;
      l_bind_var_counter   Binary_integer   := 0;
      l_sql_text           Varchar2 (32000) := 'begin ' || p_procedure_name || '(';
      l_message            Varchar2 (4000);
   Begin
      For c In (Select   a.argument_name
                    From all_arguments a
                   Where a.package_name || '.' || a.object_name = UPPER (p_procedure_name)
                     And a.owner = 'FORMS_CONSTRUCTOR'
                     And a.Position != 0
                Order By a.Position, a.Sequence) Loop
         If g_parameter_values.Exists (c.argument_name) Then
            l_sql_text                                :=
                                                    l_sql_text || c.argument_name || ' => :' || c.argument_name || ', ';
            l_bind_var_counter                        := l_bind_var_counter + 1;
            l_bind_var_values (l_bind_var_counter)    := g_parameter_values (c.argument_name);
         End If;
      End Loop;

      l_sql_text    := Rtrim (Rtrim (l_sql_text, ' '), ',');
      l_sql_text    := l_sql_text || '); end;';
      DBMS_OUTPUT.put_line (l_sql_text);

      Declare
         l_curId            Integer        Default DBMS_SQL.open_cursor;
         l_status           Integer;
         l_parameter_name   Varchar2 (255);
      Begin
--         l_message           := l_sql_text;
         DBMS_SQL.parse (l_curId, l_sql_text, DBMS_SQL.native);

         For i In l_bind_var_values.First .. l_bind_var_values.Last Loop
            Null;
            DBMS_SQL.bind_variable (c          => l_curId
                                   ,Name       => l_bind_var_values (i).parameter_name
                                   ,Value      => l_bind_var_values (i).parameter_char_value
                                   );
            DBMS_OUTPUT.put_line (   l_bind_var_values (i).parameter_name
                                  || ' => '
                                  || l_bind_var_values (i).parameter_char_value
                                 );
/*            l_message    :=
                  l_message
               || l_bind_var_values (i).parameter_name
               || ' => '
               || l_bind_var_values (i).parameter_char_value
               || '; ';*/
         End Loop;

         l_status            := DBMS_SQL.Execute (l_curId);
         --OUT
         l_parameter_name    := g_parameter_values.First;

         While True Loop
            Exit When l_parameter_name Is Null;
            DBMS_OUTPUT.put_line (   'parameter_name = '
                                  || l_parameter_name
                                  || '; parameter_value = '
                                  || g_parameter_values (l_parameter_name).parameter_char_value
                                 );

            Begin
               DBMS_SQL.variable_value (c          => l_curId
                                       ,Name       => ':' || l_parameter_name
                                       ,Value      => g_parameter_values (l_parameter_name).parameter_char_value
                                       );
            Exception                                                               --Игнорируем неизмененные переменные
               When Others Then
                  Null;
            End;

            l_parameter_name    := g_parameter_values.Next (l_parameter_name);
         End Loop;

         DBMS_SQL.close_cursor (c => l_curId);
      Exception
         When Others Then
            l_message    := SUBSTR (SQLERRM, 1, 4000);
            DBMS_SQL.close_cursor (c => l_curId);
      End;

      Return l_message;
   End execute_form_action;
Begin
   Null;
/* пример пробежки по varchar-коллекции
        */
End form_dml_utils;
/


-- End of DDL Script for Package FC.FORM_DML_UTILS

