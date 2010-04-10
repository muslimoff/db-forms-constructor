-- Start of DDL Script for Package FC.FORM_UTILS_CUSTOMIZATION
-- Generated 10.04.2010 22:26:27 from FC@VM_XE

Create Or Replace 
PACKAGE form_utils_customization As
   Procedure customize_column_metadata (p_column_number Number, p_column_data In Out form_utils.column_rec);
End form_utils_customization;
/


Create Or Replace 
PACKAGE BODY form_utils_customization As
   Procedure customize_column_metadata (p_column_number Number, p_column_data In Out form_utils.column_rec) Is
   Begin
      If (p_column_data.form_code = 'MZ_DIMENSION_DEMO1') Then
         matrix_rep_demo_pkg.customize_column_metadata (p_column_number, p_column_data);
      End If;
   End;
End form_utils_customization;
/


-- End of DDL Script for Package FC.FORM_UTILS_CUSTOMIZATION

