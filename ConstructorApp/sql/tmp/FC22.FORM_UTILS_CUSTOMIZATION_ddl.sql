CREATE OR REPLACE 
Package fc22.form_utils_customization As
   Procedure customize_column_metadata (
      p_column_number               Number
     ,p_column_data        In Out   form_utils.column_rec
     ,p_master_form_code            Varchar2 Default Null
   );
End form_utils_customization;
/


CREATE OR REPLACE 
PACKAGE BODY fc22.form_utils_customization As
   Procedure customize_column_metadata (
      p_column_number               Number
     ,p_column_data        In Out   form_utils.column_rec
     ,p_master_form_code            Varchar2 Default Null
   ) Is
   Begin
      If (p_column_data.form_code = 'MZ_DIMENSION_DEMO1') Then
         matrix_rep_demo_pkg.customize_column_metadata (p_column_number, p_column_data);
      End If;

      Case
         When     p_column_data.form_code = 'INS_INS_INSURED'
              And p_master_form_code = 'INS_INS_CONTRACT'
              And p_column_data.column_code = 'CONTRACT_ID' Then
            p_column_data.show_on_grid    := 'N';
         When     p_column_data.form_code = 'INS_INS_PROGRAM'
              And p_master_form_code = 'INS_INS_CONTRACT'
              And p_column_data.column_code = 'CONTRACT_ID' Then
            p_column_data.show_on_grid    := 'N';
/*         When     p_column_data.form_code = 'INS_INS_ACCOUNT_LINES'
              And p_master_form_code = 'INS_INS_INSURED'
              And p_column_data.column_code = 'INSURED_ID' Then
            p_column_data.show_on_grid    := 'N';*/
/*         When     p_column_data.form_code = 'INS_INS_ACCOUNT_LINES'
              And p_master_form_code = 'INS_INS_INSURED'
              And p_column_data.column_code = 'SEARCH_TEXT' Then
            p_column_data.show_on_grid    := 'N';*/
/*         When     p_column_data.form_code = 'INS_INS_ACCOUNT_LINES'
              And p_master_form_code = 'ACCOUNTS_GEN'
              And p_column_data.column_code In ('COMPANY_ID', 'ACCOUNT_NUM') Then
            p_column_data.show_on_grid    := 'N';*/
/*         When     p_column_data.form_code = 'INS_INS_ACCOUNT_LINES'
              And p_master_form_code = 'INS_INS_ACCOUNT'
              And p_column_data.column_code In ('COMPANY_ID', 'ACCOUNT_NUM') Then
            p_column_data.show_on_grid    := 'N';*/
      When     p_column_data.form_code = 'FORM_COLUMN_ACTIONS'
           And p_master_form_code = 'FORM_ACTIONS'
           And p_column_data.column_code In ('FORM_CODE', 'ACTION_CODE') Then
            p_column_data.show_on_grid    := 'N';
         When     p_column_data.form_code = 'FORM_COLUMN_ACTIONS'
              And p_master_form_code = 'FORM_COLUMNS'
              And p_column_data.column_code In ('FORM_CODE', 'COLUMN_CODE') Then
            p_column_data.show_on_grid    := 'N';
         When     p_column_data.form_code = 'INS_ACCOUNT_LINES_RESERVE2'
              And p_master_form_code = 'INS_INS_INSURED'
              And p_column_data.column_code = 'INSURED_ID' Then
            p_column_data.show_on_grid    := 'N';
--
      When     p_column_data.form_code = 'INS_ACCOUNT_LINES3'
           And p_master_form_code = 'INS_INS_INSURED'
           And p_column_data.column_code = 'INSURED_ID' Then
            p_column_data.show_on_grid    := 'N';
         When     p_column_data.form_code = 'INS_ACCOUNT_LINES3_RESERVE'
              And p_master_form_code = 'INS_INS_INSURED'
              And p_column_data.column_code = 'INSURED_ID' Then
            p_column_data.show_on_grid    := 'N';
         Else
            Null;
      End Case;
   End;
End form_utils_customization;
/

