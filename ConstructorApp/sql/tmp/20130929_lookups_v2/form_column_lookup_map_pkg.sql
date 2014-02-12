
Create Package fc22.form_column_lookup_map_pkg As
   Procedure p_delete (
      p_form_column_lookup_map_id   In Out   Number
     ,p_form_code                   In Out   Varchar2
     ,p_column_code                 In Out   Varchar2
     ,p_lookup_form_code            In Out   Varchar2
     ,p_lookup_form_column_code     In Out   Varchar2
     ,p_mapping_type                In Out   Varchar2
     ,p_constant_value              In Out   Varchar2
     ,p_column_user_name            In Out   Varchar2
     ,p_column_display_size         In Out   Varchar2
     ,p_column_display_number       In Out   Number
     ,p_show_on_grid                In Out   Varchar2
     ,p_column_code_to_mapping      In Out   Varchar2
   );

   Procedure p_ins_upd (
      p_form_column_lookup_map_id   In Out   Number
     ,p_form_code                   In Out   Varchar2
     ,p_column_code                 In Out   Varchar2
     ,p_lookup_form_code            In Out   Varchar2
     ,p_lookup_form_column_code     In Out   Varchar2
     ,p_mapping_type                In Out   Varchar2
     ,p_constant_value              In Out   Varchar2
     ,p_column_user_name            In Out   Varchar2
     ,p_column_display_size         In Out   Varchar2
     ,p_column_display_number       In Out   Number
     ,p_show_on_grid                In Out   Varchar2
     ,p_column_code_to_mapping      In Out   Varchar2
   );
End FORM_COLUMN_LOOKUP_MAP_PKG;
/

Create Package Body fc22.form_column_lookup_map_pkg As
   Procedure p_ins_upd (
      p_form_column_lookup_map_id   In Out   Number
     ,p_form_code                   In Out   Varchar2
     ,p_column_code                 In Out   Varchar2
     ,p_lookup_form_code            In Out   Varchar2
     ,p_lookup_form_column_code     In Out   Varchar2
     ,p_mapping_type                In Out   Varchar2
     ,p_constant_value              In Out   Varchar2
     ,p_column_user_name            In Out   Varchar2
     ,p_column_display_size         In Out   Varchar2
     ,p_column_display_number       In Out   Number
     ,p_show_on_grid                In Out   Varchar2
     ,p_column_code_to_mapping      In Out   Varchar2
   ) Is
   Begin
      Update FORM_COLUMN_LOOKUP_MAP
         Set form_code = p_form_code
            ,column_code = p_column_code
            ,lookup_form_code = p_lookup_form_code
            ,lookup_form_column_code = p_lookup_form_column_code
            ,mapping_type = p_mapping_type
            ,constant_value = p_constant_value
            ,column_user_name = p_column_user_name
            ,column_display_size = p_column_display_size
            ,column_display_number = p_column_display_number
            ,show_on_grid = p_show_on_grid
            ,column_code_to_mapping = p_column_code_to_mapping
       Where form_column_lookup_map_id = p_form_column_lookup_map_id;

      If Sql%Rowcount = 0 Then
         Select main_sq.Nextval
           Into p_form_column_lookup_map_id
           From DUAL;

         Insert Into FORM_COLUMN_LOOKUP_MAP
                     (form_column_lookup_map_id, form_code, column_code, lookup_form_code, lookup_form_column_code
                     ,mapping_type, constant_value, column_user_name, column_display_size, column_display_number
                     ,show_on_grid, column_code_to_mapping)
              Values (p_form_column_lookup_map_id, p_form_code, p_column_code, p_lookup_form_code
                     ,p_lookup_form_column_code, p_mapping_type, p_constant_value, p_column_user_name
                     ,p_column_display_size, p_column_display_number, p_show_on_grid, p_column_code_to_mapping);
      End If;
   End p_ins_upd;

   Procedure p_delete (
      p_form_column_lookup_map_id   In Out   Number
     ,p_form_code                   In Out   Varchar2
     ,p_column_code                 In Out   Varchar2
     ,p_lookup_form_code            In Out   Varchar2
     ,p_lookup_form_column_code     In Out   Varchar2
     ,p_mapping_type                In Out   Varchar2
     ,p_constant_value              In Out   Varchar2
     ,p_column_user_name            In Out   Varchar2
     ,p_column_display_size         In Out   Varchar2
     ,p_column_display_number       In Out   Number
     ,p_show_on_grid                In Out   Varchar2
     ,p_column_code_to_mapping      In Out   Varchar2
   ) Is
   Begin
      Delete From FORM_COLUMN_LOOKUP_MAP
            Where form_column_lookup_map_id = p_form_column_lookup_map_id;
   End p_delete;
End FORM_COLUMN_LOOKUP_MAP_PKG;
/

-- End of DDL Script for Package FC22.FORM_COLUMN_LOOKUP_MAP_PKG

