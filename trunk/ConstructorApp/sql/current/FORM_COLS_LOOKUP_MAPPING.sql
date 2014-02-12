Select a.form_code, a.column_code, a.lookup_code, b.column_code As lookup_column_code
  From form_columns a, form_columns b
 Where a.field_type = '16'
   And a.lookup_code = b.form_code
--   And a.column_code = b.column_code

