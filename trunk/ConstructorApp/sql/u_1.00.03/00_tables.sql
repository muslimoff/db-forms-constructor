Alter Table forms Add double_click_action_code Varchar2(255);
Alter Table forms Add lookup_width Number;
Alter Table form_actions Add child_form_code Varchar2(255);
Alter Table form_columns Add editor_on_enter_key_action Varchar2(255);

Alter Table form_columns
Add Constraint form_columns_uk Unique (form_code, column_code)
Using Index
/
Alter Table form_columns
Add Constraint form_columns_hover_cc_fk Foreign Key (form_code,
  hover_column_code)
References form_columns$ (form_code,col_name)
Disable Novalidate
/
Alter Table form_columns
Add Constraint form_tabs_fk Foreign Key (form_code, editor_tab_code)
References form_tabs (form_code,tab_code)
/
--=================================================================
Alter Table form_actions
Add Constraint form_actions_pk Primary Key (form_code, action_code)
Using Index
/
Alter Table forms
Add Constraint forms_form_actions_fk Foreign Key (form_code,
  double_click_action_code)
References form_actions (form_code,action_code)
Disable Novalidate
/
Create Or Replace Trigger forms_sql_update_aiud
   After Insert Or Delete Or Update Of sql_text
   On forms
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
Create Table form_tab_parent_exclns
    (form_code                      Varchar2(4000),
    tab_code                       Varchar2(4000),
    parent_form_code               Varchar2(4000),
    included_flag                  Varchar2(2))
/
Create Or Replace View forms_v (form_code
                               ,hot_key
                               ,sql_text
                               ,form_name
                               ,description
                               ,form_type
                               ,show_tree_root_node
                               ,icon_id
                               ,form_width
                               ,form_height
                               ,bottom_tabs_orientation
                               ,side_tabs_orientation
                               ,show_bottom_toolbar
                               ,object_version_number
                               ,default_column_width
                               ,double_click_action_code
                               ,lookup_width
                               ) As
   Select a.form_code, a.hot_key, a.sql_text, NVL (a.form_name, a.form_code) form_name, a.description, a.form_type
         ,a.show_tree_root_node, a.icon_id, a.form_width, a.form_height
         ,NVL (a.bottom_tabs_orientation, 'T') bottom_tabs_orientation
         ,NVL (a.side_tabs_orientation, 'T') side_tabs_orientation, NVL (a.show_bottom_toolbar
                                                                        ,'Y') show_bottom_toolbar
         ,a.object_version_number, a.default_column_width, double_click_action_code, lookup_width
     From forms a
    Where 1 = 1
      And (   SYS_CONTEXT ('USERENV', 'SESSION_USER') = applications_pkg.get_fc_schema ()                       --'FC22'
           Or a.form_code In (
                          Select ap.form_code
                            From apps_privs ap, APPLICATIONS a
                           Where a.apps_code = ap.apps_code
                             And (a.schema_name In (Select username
                                                      From user_users
                                                     Where user_id = USERENV ('SCHEMAID'))))
          )
/
Create Table users
    (user_id                        Number,
    fio                            Varchar2(4000),
    username                       Varchar2(255),
    Password                       Varchar2(255),
    orig_ref_id                    Number(10,0),
    email                          Varchar2(4000))
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
Create Table apps_role_menus
    (app_menu_id                    Number,
    menu_code                      Varchar2(4000),
    parent_menu_code               Varchar2(4000),
    Position                       Number(9,0),
    form_code                      Varchar2(4000),
    enabled_flag                   Varchar2(4000),
    display_name                   Varchar2(4000))
/
Create Table report_templates
    (report_id                      Number,
    user_id                        Number,
    app_code                       Varchar2(255),
    report_type_code               Varchar2(255),
    content_type                   Varchar2(255),
    content                        BLOB,
    filename                       Varchar2(255),
    clob_content                   CLOB)
  Lob ( Content ) Store As Sys_Lob0000039462C00006$$
  (
   Nocache Logging
   Chunk 8192
  )
  Lob ( Clob_Content ) Store As Sys_Lob0000039462C00008$$
  (
   Nocache Logging
   Chunk 8192
  )
/
Create Table form_column_attr_vals
    (form_column_attr_val_id        Number,
    form_code                      Varchar2(255),
    column_code                    Varchar2(255),
    attribute_code                 Varchar2(255),
    attribute_value                Varchar2(255))
/
--=================================================================
Comment On Table form_tab_parent_exclns Is 'Select a.child_form_code As form_code, a.tab_code, a.form_code As parent_form_code, ''Y'' As included_flag From form_tabs a Where a.child_form_code = ''INS_INS_INSURED''';
Comment On Column forms.double_click_action_code Is '�������� �� �������� ������ �� ������. �� ��������� - ��������������';
Comment On Column forms.lookup_width Is '������ ������ (���� ����� ��������� � ���� ������)';
Comment On Table forms Is 'xx';
Comment On Column forms.bottom_tabs_orientation Is '���������� ������ ������� �����������. ��. FORMS.TABS_ORIENTATION';
Comment On Column forms.default_column_width Is '������ ����� �� ���������';
Comment On Column forms.description Is '�������� �����... ��� ����������� ��� ��������� ������ � �.�';
Comment On Column forms.form_code Is '��������� ������������� �����';
Comment On Column forms.form_height Is '������ � �������� ��� ���������. * - ����';
Comment On Column forms.form_name Is '��� ����� ��� ������������';
Comment On Column forms.form_type Is '��� �����. G-����, T-������...';
Comment On Column forms.form_width Is '������ � �������� ��� ���������. * - ����';
Comment On Column forms.hot_key Is '������� �������  - ������ ���� [Ctrl+][Alt+][Shift+]Chr. ������� �� �����';
Comment On Column forms.show_bottom_toolbar Is '���������� ������ ������?';
Comment On Column forms.show_tree_root_node Is '���������� �� �������� ���� ��� ������?';
Comment On Column forms.side_tabs_orientation Is '���������� ������� ������� �����������. ��. FORMS.TABS_ORIENTATION';
Comment On Column forms.sql_text Is 'Order by �� ������� ������� �� �����������, ����� ��� ���������� ������ �����..';
--
Comment On Column form_actions.child_form_code Is '����� �������� ����� � ����� ����/����';
--=================================================================
Comment On Column form_columns.column_code Is '������������� ���� (�� �������)';
Comment On Column form_columns.column_data_type Is '��� ������ (FORM_COLUMNS.DATA_TYPE)';
Comment On Column form_columns.column_description Is '�������� ���� (��������� ��� ������������)';
Comment On Column form_columns.column_display_number Is '���������� ����� ����������� � �������';
Comment On Column form_columns.column_display_size Is '������ ���� � ���������';
Comment On Column form_columns.column_user_name Is '���������������� ��� ����';
Comment On Column form_columns.default_orderby_number Is '������� ���������� ��� �������� �����. "-" ����� ����� - ���������� �� ��������';
Comment On Column form_columns.DEFAULT_VALUE Is '�������� �� ��������� ��� ����� �������';
Comment On Column form_columns.editor_cols_span Is '�������� - ���������� �������, ���������� ����� (item.setColSpan)';
Comment On Column form_columns.editor_end_row_flag Is 'item.setEndRow';
Comment On Column form_columns.editor_height Is '������ ���� � �������� ��������������';
Comment On Column form_columns.editor_on_enter_key_action Is '�������� �� ������� Enter';
Comment On Column form_columns.editor_tab_code Is '������ �� �������� ����� ��������������. ���� �� ������� - ������������ ������ � �����';
Comment On Column form_columns.editor_title_orientation Is 'item.setTitleOrientation';
Comment On Column form_columns.field_type Is '��� ����, ����� ��� ������ � �����';
Comment On Column form_columns.form_code Is '������������� ����';
Comment On Column form_columns.help_text Is '�������� ���� � HTML';
Comment On Column form_columns.hover_column_code Is '���� ��� �� �����, ������� �������� ���������. ���� SHOW_HOVER_FLAG = ''Y'' � HOVER_COLUMN_CODE - ��������� ������� �� �������� ���� (COLUMN_CODE)';
Comment On Column form_columns.is_frozen_flag Is '������������ ����?';
Comment On Column form_columns.lookup_code Is '������ �� ����� - ������ ��� �������';
Comment On Column form_columns.lookup_display_value Is '���� �������, ������������ ������������ - ��� ������� �������';
Comment On Column form_columns.lookup_field_type Is '��. Lookup FORM_COLUMNS.LOOKUP_FIELD_TYPE';
Comment On Column form_columns.pimary_key_flag Is '������� ����, ��� ���� �������� ��������� ������ (Y). ����� - �� ��������.';
Comment On Column form_columns.show_hover_flag Is '���������� ����������� ���������-�������� ����';
Comment On Column form_columns.show_on_grid Is '���������� � �����';
Comment On Column form_columns.text_mask Is '��������� ����� ��� ����. ��. �������� � ����������';
Comment On Column form_columns.tree_field_type Is '��� ���� ��� ������ (Id, ParentId, ChildCount...)';
Comment On Column form_columns.tree_initialization_value Is '���� �� ����� � ��� ����� - "������" - ������������ ��� ������ ������ ������ ��� �������������. ���������� ����������� Start With ����������� ��������';
Comment On Column form_columns.validation_regexp Is '���������� ��������� ��� ���������� ���������';
Comment On Table form_column_attr_vals Is '�������������� �������� �������';
Comment On Column form_column_attr_vals.attribute_code Is '��� ��������';
Comment On Column form_column_attr_vals.attribute_value Is '�������� ��������';
Comment On Column form_column_attr_vals.column_code Is '������������� ���� (�� �������)';
Comment On Column form_column_attr_vals.form_code Is '������������� ����';
Comment On Column form_column_attr_vals.form_column_attr_val_id Is 'Id';

