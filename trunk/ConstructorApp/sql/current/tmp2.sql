Declare
   l_cols           Clob;
   l_col_comments   Clob;
   l_res            Clob;
Begin
   For cr In (With t As
                   (
                      Select   utc.table_name, utc.column_name, utc.data_type, utc.data_length, utc.data_precision
                              ,utc.data_scale, ucc.comments
                          From all_tab_columns utc, all_col_comments ucc
                         Where utc.table_name = ucc.table_name
                           And utc.column_name = ucc.column_name
                           And utc.owner = ucc.owner
                           And utc.owner = 'FC22'
                           And utc.table_name Not In ('SQLN_EXPLAIN_PLAN')
                      Order By utc.table_name, utc.column_id)
              Select t.table_name, t.column_name
                    ,    'alter table "'
                      || t.table_name
                      || '" add "'
                      || t.column_name
                      || '" '
                      || LOWER (   t.data_type
                                || DECODE (t.data_type
                                          ,'VARCHAR2', '(' || t.data_length || ')'
                                          ,'NUMBER', '(' || t.data_length || ', ' || NVL (t.data_precision, 0) || ')'
                                          )
                               )
                      || ';' As colmn
                    ,DECODE (t.comments
                            ,Null, Null
                            ,    'Comment On Column "'
                              || t.table_name
                              || '"."'
                              || t.column_name
                              || '" is '''
                              || Replace (t.comments, '''', '''''')
                              || ''';'
                            ) col_comments
                From t) Loop
      l_cols            := l_cols || cr.colmn || CHR (10);
      l_col_comments    := l_col_comments || cr.col_comments || CHR (10);
      l_res             := l_cols || CHR (10) || l_col_comments;
   End Loop;
End;
/

Select form_utils.get_table_cols_scripts ('FC22')
  From DUAL

