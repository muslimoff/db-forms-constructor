Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE")
     Values ('FORM_ACTIONS.ACTION_TYPE', '9', 'Фильтр')
/
Create Sequence main_sq Start With 1
/
Alter Table lookup_values Add lookup_value_id Number
/
Update lookup_values
   Set lookup_value_id = main_sq.Nextval
/
Alter Table lookup_values
Add Constraint lookup_value_id_pk Primary Key (lookup_value_id)
Using Index
/
Create Or Replace Trigger lookup_values_biud
   Before Insert Or Delete Or Update
   On lookup_values
   Referencing New As New Old As Old
   For Each Row
Begin
   If INSERTING Then
      Select main_sq.Nextval
        Into :New.lookup_value_id
        From DUAL;
   End If;
End;

