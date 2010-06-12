
Create Sequence main_sq
  Increment By 1
  Start With 19261
  Minvalue 1
  Maxvalue 999999999999999999999999999
  Nocycle
  Noorder
  Cache 20
/
Create Table users
    (user_id                        Number,
    fio                            Varchar2(4000),
    username                       Varchar2(255),
    Password                       Varchar2(255),
    orig_ref_id                    Number(10,0),
    email                          Varchar2(4000))
/
Grant Select On users To app_rates
/
Create Table apps_role_menus
    (app_menu_id                    Number,
    menu_code                      Varchar2(4000),
    parent_menu_code               Varchar2(4000),
    Position                       Number(9,0),
    form_code                      Varchar2(4000),
    enabled_flag                   Varchar2(4000),
    display_name                   Varchar2(4000))
/
Create Table apps_roles
    (apps_role_id                   Number,
    role_code                      Varchar2(4000),
    role_name                      Varchar2(4000),
    apps_code                      Varchar2(4000),
    root_menu_code                 Varchar2(4000))
/
Create Table apps_role_users
    (app_role_user_id               Number,
    role_code                      Varchar2(4000),
    apps_code                      Varchar2(4000),
    user_id                        Number)
/
Create  Table lookup_attributes
    (lookup_code                    Varchar2(255),
    attribute_code                 Varchar2(255),
    attribute_name                 Varchar2(255),
    attribute_type                 Varchar2(1))
/
Grant  Select On lookup_attributes To app_rates
/
Alter Table lookup_attributes
Add Constraint lookup_attribute_uk Unique (lookup_code, attribute_code)
Using Index
/
Create Table lookup_attribute_values
    (lookup_code                    Varchar2(255),
    lookup_value_code              Varchar2(255),
    attribute_code                 Varchar2(255),
    attribute_value_number         Number,
    attribute_value_char           Varchar2(2000),
    attribute_value_date           Date)
/
Grant  Select On lookup_attribute_values To app_rates
/
Alter Table lookup_values
Add Constraint lookup_value_uk Unique (lookup_code, lookup_value_code)
Using Index
/
Alter Table lookup_values Add LOOKUP_VALUE_ID Number
/
Update lookup_values l
   Set lookup_value_id = main_sq.Nextval
/
Alter Table lookup_values
Add Constraint lookup_value_id_pk Primary Key (lookup_value_id)
Using Index
/
Alter  Table lookup_attribute_values
Add Constraint lookup_attribute_values_fk1 Foreign Key (lookup_code,
  attribute_code)
References lookup_attributes (lookup_code,attribute_code)
/
Alter Table lookup_attribute_values
Add Constraint lookup_attribute_values_fk2 Foreign Key (lookup_code,
  lookup_value_code)
References lookup_values (lookup_code,lookup_value_code)
/
Create Table form_tab_parent_exclns
    (form_code                      Varchar2(4000),
    tab_code                       Varchar2(4000),
    parent_form_code               Varchar2(4000),
    included_flag                  Varchar2(2))
/
Comment On Table form_tab_parent_exclns Is 'Select a.child_form_code As form_code, a.tab_code, a.form_code As parent_form_code, ''Y'' As included_flag From form_tabs a Where a.child_form_code = ''INS_INS_INSURED'''
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE", "LOOKUP_VALUE_ID")
     Values ('FORM_ACTIONS.ACTION_TYPE', '10', 'Открыть дочернюю форму в новом табе', 19181)
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE", "LOOKUP_VALUE_ID")
     Values ('FORM_ACTIONS.ACTION_TYPE', '11', 'Открыть дочернюю форму в новом окне', 19201)
/
Insert Into lookup_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "LOOKUP_DISPLAY_VALUE", "LOOKUP_VALUE_ID")
     Values ('FORM_ACTIONS.ACTION_TYPE', '9', 'Фильтр', 46)
/
Alter Table form_actions Add child_form_code                Varchar2(255)
/
Grant Select On form_actions To mz_so_integration
/
Comment On Column form_actions.child_form_code Is 'Вызов дочерней формы в новом табе/окне'
/
-- Start of DDL Script for Trigger FC22.LOOKUP_VALUES_BIUD
-- Generated 09.06.2010 18:11:47 from FC22@VM_XE

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
/
Insert Into icons
            ("ICON_ID", "ICON_FILE_NAME", "ICON_PATH")
     Values (101, 'sign_bell.gif ', Null)
/
Insert Into icons
            ("ICON_ID", "ICON_FILE_NAME", "ICON_PATH")
     Values (103, 'sign_point.gif', Null)
/
Insert Into icons
            ("ICON_ID", "ICON_FILE_NAME", "ICON_PATH")
     Values (102, 'sign_check.gif', Null)
/
-- End of DDL Script for Trigger FC22.LOOKUP_VALUES_BIUD

------------------new
Alter Table forms Modify SQL_TEXT Varchar2(4000 Char);


