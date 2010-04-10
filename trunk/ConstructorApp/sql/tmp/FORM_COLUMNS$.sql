Select a.col_num, a.col_type, a.col_max_len, a.col_name, a.col_name_len, a.col_precision, a.col_scale, a.form_code
      ,a.pimary_key_flag, a.default_column_width, a.column_description
  From form_columns$ a
 Where a.form_code In
          ('COLUMNS_LIST'
          ,'FORM_ACTIONS'
          ,'FORM_COLUMNS'
          ,'FORM_TABS'
          ,'FORM_TABS_LIST'
          ,'FORMS'
          ,'FORMS_LIST'
          ,'FORMS2'
          ,'ICONS'
          ,'LOOKUP_VALUES'
          ,'LOOKUPS'
          ,'LOOKUPS_LIST'
          ,'MENUS'
          )

