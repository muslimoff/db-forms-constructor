Create Table fc22.forms
    (form_code                      Varchar2(255) Not Null,
    hot_key                        Varchar2(100),
    sql_text                       Varchar2(4000),
    form_name                      Varchar2(255),
    form_type                      Varchar2(1) Default 'G',
    show_tree_root_node            Varchar2(1) Default 'Y',
    icon_id                        Number,
    form_width                     Varchar2(30) Default '*',
    form_height                    Varchar2(30) Default '*',
    bottom_tabs_orientation        Varchar2(2) Default NULL,
    side_tabs_orientation          Varchar2(2),
    show_bottom_toolbar            Varchar2(1) Default 'Y',
    object_version_number          Number Default 1,
    default_column_width           Varchar2(30) Default '*',
    description                    CLOB,
    double_click_action_code       Varchar2(255),
    lookup_width                   Number,
    apps_code                      Varchar2(255),
    export_order                   Number Default 100)
  Lob ("Description") Store As Sys_Lob0000034300C00015$$
  (
   Nocache Logging
   Chunk 8192
  )
/

Alter Table fc22.forms
Add Constraint forms_pk Primary Key (form_code)
Using Index
/


Create Or Replace Trigger fc22.forms_sql_update_aiud
 After
   Insert Or Delete Or Update Of sql_text
 On fc22.forms
Referencing New As New Old As Old
 For Each Row
Declare
   --����� ��������� ������������� ������� FORM_COLUMNS$
   x   Number;
Begin
   If DELETING Then
      form_utils.refresh_temp_columns (:Old.form_code
                                      ,:Old.sql_text
                                      ,:Old.default_column_width
                                      ,p_delete_only_flag      => 'Y'
                                      );
   Elsif    INSERTING
         Or (    UPDATING
             And :Old.sql_text != :New.sql_text) Then
      form_utils.refresh_temp_columns (:New.form_code, :New.sql_text, :New.default_column_width);
   End If;
End FORMS_SQL_UPDATE_AIUD;
/

Comment On Table fc22.forms Is 'xx'
/
Comment On Column fc22.forms.apps_code Is '��� ����������. ���� ������ ��� ��������� ��������� ��������'
/
Comment On Column fc22.forms.bottom_tabs_orientation Is '���������� ������ ������� �����������. ��. FORMS.TABS_ORIENTATION'
/
Comment On Column fc22.forms.default_column_width Is '������ ����� �� ���������'
/
Comment On Column fc22.forms.description Is '�������� �����... ��� ����������� ��� ��������� ������ � �.�'
/
Comment On Column fc22.forms.double_click_action_code Is '�������� �� �������� ������ �� ������. �� ��������� - ��������������'
/
Comment On Column fc22.forms.export_order Is '���������� ����� ��� ��������� ��������'
/
Comment On Column fc22.forms.form_code Is '��������� ������������� �����'
/
Comment On Column fc22.forms.form_height Is '������ � �������� ��� ���������. * - ����'
/
Comment On Column fc22.forms.form_name Is '��� ����� ��� ������������'
/
Comment On Column fc22.forms.form_type Is '��� �����. G-����, T-������...'
/
Comment On Column fc22.forms.form_width Is '������ � �������� ��� ���������. * - ����'
/
Comment On Column fc22.forms.hot_key Is '������� �������  - ������ ���� [Ctrl+][Alt+][Shift+]Chr. ������� �� �����'
/
Comment On Column fc22.forms.lookup_width Is '������ ������ (���� ����� ��������� � ���� ������)'
/
Comment On Column fc22.forms.show_bottom_toolbar Is '���������� ������ ������?'
/
Comment On Column fc22.forms.show_tree_root_node Is '���������� �� �������� ���� ��� ������?'
/
Comment On Column fc22.forms.side_tabs_orientation Is '���������� ������� ������� �����������. ��. FORMS.TABS_ORIENTATION'
/
Comment On Column fc22.forms.sql_text Is 'Order by �� ������� ������� �� �����������, ����� ��� ���������� ������ �����..'
/
Alter Table fc22.forms
Add Constraint forms_form_actions_fk Foreign Key (form_code, 
  double_click_action_code)
References FC22.form_actions (form_code,action_code)
/
