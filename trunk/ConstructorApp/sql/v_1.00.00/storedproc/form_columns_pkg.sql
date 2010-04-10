-- Start of DDL Script for Package FC.FORM_COLUMNS_PKG
-- Generated 10.04.2010 22:24:30 from FC@VM_XE

Create Or Replace 
PACKAGE form_columns_pkg As
   Procedure p_ins_upd (
      p_form_code                        form_columns.form_code%Type
     ,p_column_code                      form_columns.column_code%Type
     ,p_column_user_name                 form_columns.column_user_name%Type
     ,p_column_display_size              form_columns.column_display_size%Type
     ,p_column_display_number            form_columns.column_display_number%Type
     ,p_pimary_key_flag                  form_columns.pimary_key_flag%Type
     ,p_show_on_grid                     form_columns.show_on_grid%Type
     ,p_tree_field_type                  form_columns.tree_field_type%Type
     ,p_editor_tab_code                  form_columns.editor_tab_code%Type
     ,p_field_type                       form_columns.field_type%Type
     ,p_column_description               form_columns.column_description%Type
     ,p_is_frozen_flag                   form_columns.is_frozen_flag%Type
     ,p_show_hover_flag                  form_columns.show_hover_flag%Type
     ,p_column_data_type                 form_columns.column_data_type%Type
     ,p_exists_in_metadata_flag    Out   Varchar2
     ,p_lookup_code                      form_columns.lookup_code%Type
     ,p_hover_column_code                form_columns.hover_column_code%Type
     ,p_editor_height                    form_columns.editor_height%Type
     ,p_lookup_field_type                form_columns.lookup_field_type%Type
     ,p_help_text                        form_columns.help_text%Type
     ,p_text_mask                        form_columns.text_mask%Type
     ,p_validation_regexp                form_columns.validation_regexp%Type
     ,p_default_orderby_number           form_columns.default_orderby_number%Type
     ,p_default_value                    form_columns.DEFAULT_VALUE%Type
     ,p_editor_title_orientation         form_columns.editor_title_orientation%Type
     ,p_editor_cols_span                 form_columns.editor_cols_span%Type
     ,p_editor_end_row_flag              form_columns.editor_end_row_flag%Type
     ,p_lookup_display_value             form_columns.lookup_display_value%Type
   );

   Procedure p_delete (p_form_code form_columns.form_code%Type, p_column_code form_columns.column_code%Type);
End;
/


Create Or Replace 
PACKAGE BODY form_columns_pkg As
   /*
   SELECT a.form_code, a.column_code, a.column_user_name,
          a.column_display_size, a.column_data_type,
          a.column_display_number, a.pimary_key_flag, a.show_on_grid,
          a.tree_initialization_value, a.tree_field_type,
          a.editor_tab_code, a.field_type, a.column_description
     FROM form_columns a
   */
   Procedure p_ins_upd (
      p_form_code                        form_columns.form_code%Type
     ,p_column_code                      form_columns.column_code%Type
     ,p_column_user_name                 form_columns.column_user_name%Type
     ,p_column_display_size              form_columns.column_display_size%Type
     ,p_column_display_number            form_columns.column_display_number%Type
     ,p_pimary_key_flag                  form_columns.pimary_key_flag%Type
     ,p_show_on_grid                     form_columns.show_on_grid%Type
     ,p_tree_field_type                  form_columns.tree_field_type%Type
     ,p_editor_tab_code                  form_columns.editor_tab_code%Type
     ,p_field_type                       form_columns.field_type%Type
     ,p_column_description               form_columns.column_description%Type
     ,p_is_frozen_flag                   form_columns.is_frozen_flag%Type
     ,p_show_hover_flag                  form_columns.show_hover_flag%Type
     ,p_column_data_type                 form_columns.column_data_type%Type
     ,p_exists_in_metadata_flag    Out   Varchar2
     ,p_lookup_code                      form_columns.lookup_code%Type
     ,p_hover_column_code                form_columns.hover_column_code%Type
     ,p_editor_height                    form_columns.editor_height%Type
     ,p_lookup_field_type                form_columns.lookup_field_type%Type
     ,p_help_text                        form_columns.help_text%Type
     ,p_text_mask                        form_columns.text_mask%Type
     ,p_validation_regexp                form_columns.validation_regexp%Type
     ,p_default_orderby_number           form_columns.default_orderby_number%Type
     ,p_default_value                    form_columns.DEFAULT_VALUE%Type
     ,p_editor_title_orientation         form_columns.editor_title_orientation%Type
     ,p_editor_cols_span                 form_columns.editor_cols_span%Type
     ,p_editor_end_row_flag              form_columns.editor_end_row_flag%Type
     ,p_lookup_display_value             form_columns.lookup_display_value%Type
   ) Is
   Begin
      form_utils.check_nulls (args_t (p_form_code, p_column_code)
                             ,args_t ('Не указан код формы', 'Не указан код колонки')
                             );

      Update form_columns fc
         Set fc.column_user_name = p_column_user_name
            ,fc.column_display_size = p_column_display_size
            ,fc.column_display_number = p_column_display_number
            ,fc.pimary_key_flag = p_pimary_key_flag
            ,fc.show_on_grid = p_show_on_grid
            ,fc.tree_field_type = p_tree_field_type
            ,fc.editor_tab_code = p_editor_tab_code
            ,fc.field_type = p_field_type
            ,fc.column_description = p_column_description
            ,fc.is_frozen_flag = p_is_frozen_flag
            ,fc.show_hover_flag = p_show_hover_flag
            ,fc.column_data_type = p_column_data_type
            ,fc.lookup_code = p_lookup_code
            ,fc.hover_column_code = p_hover_column_code
            ,fc.editor_height = p_editor_height
            ,fc.lookup_field_type = p_lookup_field_type
            ,fc.help_text = p_help_text
            ,fc.text_mask = p_text_mask
            ,fc.validation_regexp = p_validation_regexp
            ,fc.default_orderby_number = p_default_orderby_number
            ,fc.DEFAULT_VALUE = p_default_value
            ,fc.editor_title_orientation = p_editor_title_orientation
            ,fc.editor_cols_span = p_editor_cols_span
            ,fc.editor_end_row_flag = p_editor_end_row_flag
            ,fc.lookup_display_value = p_lookup_display_value
       Where fc.form_code = p_form_code
         And fc.column_code = p_column_code;

      If Sql%Rowcount = 0 Then
         Insert Into form_columns
                     (form_code, column_code, column_user_name, column_display_size, column_display_number
                     ,pimary_key_flag, show_on_grid, tree_field_type, editor_tab_code, field_type, column_description
                     ,is_frozen_flag, show_hover_flag, column_data_type, lookup_code, hover_column_code, editor_height
                     ,lookup_field_type, help_text, text_mask, validation_regexp, default_orderby_number
                     ,DEFAULT_VALUE, editor_title_orientation, editor_cols_span, editor_end_row_flag
                     ,lookup_display_value)
              Values (p_form_code, p_column_code, p_column_user_name, p_column_display_size, p_column_display_number
                     ,p_pimary_key_flag, p_show_on_grid, p_tree_field_type, p_editor_tab_code, p_field_type
                     ,p_column_description, p_is_frozen_flag, p_show_hover_flag, p_column_data_type, p_lookup_code
                     ,p_hover_column_code, p_editor_height, p_lookup_field_type, p_help_text, p_text_mask
                     ,p_validation_regexp, p_default_orderby_number, p_default_value, p_editor_title_orientation
                     ,p_editor_cols_span, p_editor_end_row_flag, p_lookup_display_value);
      End If;

      p_exists_in_metadata_flag    := 'Y';

      Update forms f
         Set f.object_version_number = f.object_version_number + 1
       Where f.form_code = p_form_code;
   --      raise_application_error (-20001, 'p_is_frozen_flag:' || p_is_frozen_flag);
   End p_ins_upd;

   Procedure p_delete (p_form_code form_columns.form_code%Type, p_column_code form_columns.column_code%Type) As
   Begin
      Delete From form_columns fc
            Where fc.form_code = p_form_code
              And fc.column_code = p_column_code;

      Update forms f
         Set f.object_version_number = f.object_version_number + 1
       Where f.form_code = p_form_code;
   End p_delete;
End;
/


-- End of DDL Script for Package FC.FORM_COLUMNS_PKG

