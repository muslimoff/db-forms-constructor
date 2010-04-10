Select a.form_code, a.column_code, a.column_user_name, a.column_display_size, a.column_data_type
      ,a.column_display_number, a.pimary_key_flag, a.show_on_grid, a.tree_initialization_value, a.tree_field_type
      ,a.editor_tab_code, a.field_type, a.column_description, a.is_frozen_flag, a.show_hover_flag, a.lookup_code
      ,a.hover_column_code, a.editor_height, a.lookup_field_type, a.text_mask, a.validation_regexp
      ,a.default_orderby_number, a.DEFAULT_VALUE, a.editor_title_orientation, a.editor_end_row_flag, a.editor_cols_span
      ,a.lookup_display_value                                                                            --, a.help_text
  From form_columns a
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

