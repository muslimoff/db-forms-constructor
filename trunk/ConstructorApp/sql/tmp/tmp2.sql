Declare
--   p_entity_type   Varchar2 (255)    := 'FORMS';
   p_entity_type   Varchar2 (255)    := 'FORM_COLUMNS';
   p_form_code     Varchar2 (255)    := 'FORMS';
   p_res           Clob;
   p_str           Varchar2 (32000);
   p_ins_into      Varchar2 (32000);
   p_select        Varchar2 (32000);

---
   Type charArr Is Table Of Varchar2 (32000)
      Index By Binary_integer;

   Type clobArr Is Table Of Clob
      Index By Binary_integer;

   l_char_arr      charArr;
   l_clob_arr      clobArr;
   c               Integer;
   col_cnt         Integer;
   a               Integer;
   desc_t          DBMS_SQL.DESC_TAB;
Begin
   For cur In (Select   tc.column_id, tc.column_name, tc.data_type
                   From user_tab_columns tc
                  Where table_name = p_entity_type
               Order By tc.column_id) Loop
      Null;
      p_str    := p_str || ', "' || cur.column_name || '"';
   End Loop;

   p_ins_into    := CHR (10) || 'insert into ' || p_entity_type || '(' || SUBSTR (p_str, 3) || ') values (';
   p_select      := 'select * from ' || p_entity_type || ' where form_code=:p_form_code';
   c             := DBMS_SQL.open_cursor;
   DBMS_SQL.PARSE (c, p_select, DBMS_SQL.NATIVE);
   DBMS_SQL.DESCRIBE_COLUMNS (c, col_cnt, desc_t);

   For j In 1 .. col_cnt Loop
      If 112 = desc_t (j).col_type Then
         l_clob_arr (j)    := Null;
         DBMS_SQL.define_column (c, j, l_clob_arr (j));
      Else
         l_char_arr (j)    := Null;
         DBMS_SQL.define_column (c, j, l_char_arr (j), 32000);
      End If;
   End Loop;

   DBMS_SQL.bind_variable (c, 'p_form_code', p_form_code);
   a             := DBMS_SQL.Execute (c);

   Loop
      If DBMS_SQL.fetch_rows (c) = 0 Then
         Exit;
      End If;

      p_res    := p_res || p_ins_into;

--&apos;
      For j In 1 .. col_cnt Loop
         If j != 1 Then
            p_res    := p_res || CHR (10) || ',';
         End If;

         If 112 = desc_t (j).col_type Then
            DBMS_SQL.COLUMN_VALUE (c, j, l_clob_arr (j));
            p_res    := p_res || '''' || Replace (l_clob_arr (j), '''', '''''') || '''';
         Else
            DBMS_SQL.COLUMN_VALUE (c, j, l_char_arr (j));
            p_res    := p_res || '''' || Replace (l_char_arr (j), '''', '''''') || '''';
         End If;
      End Loop;

      p_res    := SUBSTR (p_res, 1, Length (p_res) - 0) || ');';
   End Loop;

   DBMS_OUTPUT.put_line ('*************************************** ');
   DBMS_OUTPUT.put_line (SUBSTR (p_res, 1, 2000));
End;
/

Select form_utils.get_entity_insetrs ('FORM_COLUMNS', form_code) x
  From forms
 Where form_code = 'FORMS'
/
Select    form_utils.get_entity_insetrs ('FORMS', form_code)
       || CHR (10)
       || form_utils.get_entity_insetrs ('FORM_TABS', form_code)
       || CHR (10)
       || form_utils.get_entity_insetrs ('FORM_ACTIONS', form_code)
       || CHR (10)
       || form_utils.get_entity_insetrs ('FORM_COLUMNS$', form_code)
       || CHR (10)
       || form_utils.get_entity_insetrs ('FORM_COLUMNS', form_code) x
  From forms
 Where form_code = 'FORMS'
/
Select form_utils.get_inserts ('FORMS')
  From DUAL
/
Select DBMS_XMLGEN.getxmltype ('select * from forms where form_code=''FORMS''').getClobVal ()
  From DUAL

