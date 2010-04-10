-- Start of DDL Script for Table FC.FORM_COLUMNS
-- Generated 10.04.2010 20:51:05 from FC@VM_XE

Create Table form_columns
    (form_code                      Varchar2(255),
    column_code                    Varchar2(255),
    column_user_name               Varchar2(255),
    column_display_size            Varchar2(255),
    column_data_type               Varchar2(255) Default 'S',
    column_display_number          Number,
    pimary_key_flag                Varchar2(1),
    show_on_grid                   Varchar2(1) Default 'Y',
    tree_initialization_value      Varchar2(2000),
    tree_field_type                Varchar2(2),
    editor_tab_code                Varchar2(255),
    field_type                     Varchar2(2),
    column_description             Varchar2(2000),
    is_frozen_flag                 Varchar2(1) Default 'N',
    show_hover_flag                Varchar2(1) Default 'N',
    lookup_code                    Varchar2(255),
    hover_column_code              Varchar2(255),
    editor_height                  Varchar2(255),
    lookup_field_type              Varchar2(1),
    help_text                      CLOB,
    text_mask                      Varchar2(255),
    validation_regexp              Varchar2(255),
    default_orderby_number         Varchar2(10),
    default_value                  Varchar2(255),
    editor_title_orientation       Varchar2(1) Default NULL,
    editor_end_row_flag            Varchar2(1) Default 'Y',
    editor_cols_span               Varchar2(10) Default '*',
    lookup_display_value           Varchar2(255))
/

-- Grants for Table
Grant Select On form_columns To sys
/




-- Constraints for FORM_COLUMNS

Alter Table form_columns
Add Constraint form_columns_uk Unique (form_code, column_code)
Using Index
/




-- Comments for FORM_COLUMNS

Comment On Column form_columns.column_code Is '������������� ���� (�� �������)'
/
Comment On Column form_columns.column_data_type Is '��� ������ (FORM_COLUMNS.DATA_TYPE)'
/
Comment On Column form_columns.column_description Is '�������� ���� (��������� ��� ������������)'
/
Comment On Column form_columns.column_display_number Is '���������� ����� ����������� � �������'
/
Comment On Column form_columns.column_display_size Is '������ ���� � ���������'
/
Comment On Column form_columns.column_user_name Is '���������������� ��� ����'
/
Comment On Column form_columns.default_orderby_number Is '������� ���������� ��� �������� �����. "-" ����� ����� - ���������� �� ��������'
/
Comment On Column form_columns.default_value Is '�������� �� ��������� ��� ����� �������'
/
Comment On Column form_columns.editor_cols_span Is '�������� - ���������� �������, ���������� ����� (item.setColSpan)'
/
Comment On Column form_columns.editor_end_row_flag Is 'item.setEndRow'
/
Comment On Column form_columns.editor_height Is '������ ���� � �������� ��������������'
/
Comment On Column form_columns.editor_tab_code Is '������ �� �������� ����� ��������������. ���� �� ������� - ������������ ������ � �����'
/
Comment On Column form_columns.editor_title_orientation Is 'item.setTitleOrientation'
/
Comment On Column form_columns.field_type Is '��� ����, ����� ��� ������ � �����'
/
Comment On Column form_columns.form_code Is '������������� ����'
/
Comment On Column form_columns.help_text Is '�������� ���� � HTML'
/
Comment On Column form_columns.hover_column_code Is '���� ��� �� �����, ������� �������� ���������. ���� SHOW_HOVER_FLAG = ''Y'' � HOVER_COLUMN_CODE - ��������� ������� �� �������� ���� (COLUMN_CODE)'
/
Comment On Column form_columns.is_frozen_flag Is '������������ ����?'
/
Comment On Column form_columns.lookup_code Is '������ �� ����� - ������ ��� �������'
/
Comment On Column form_columns.lookup_display_value Is '���� �������, ������������ ������������ - ��� ������� �������'
/
Comment On Column form_columns.lookup_field_type Is '��. Lookup FORM_COLUMNS.LOOKUP_FIELD_TYPE'
/
Comment On Column form_columns.pimary_key_flag Is '������� ����, ��� ���� �������� ��������� ������ (Y). ����� - �� ��������.'
/
Comment On Column form_columns.show_hover_flag Is '���������� ����������� ���������-�������� ����'
/
Comment On Column form_columns.show_on_grid Is '���������� � �����'
/
Comment On Column form_columns.text_mask Is '��������� ����� ��� ����. ��. �������� � ����������'
/
Comment On Column form_columns.tree_field_type Is '��� ���� ��� ������ (Id, ParentId, ChildCount...)'
/
Comment On Column form_columns.tree_initialization_value Is '���� �� ����� � ��� ����� - "������" - ������������ ��� ������ ������ ������ ��� �������������. ���������� ����������� Start With ����������� ��������'
/
Comment On Column form_columns.validation_regexp Is '���������� ��������� ��� ���������� ���������'
/

-- End of DDL Script for Table FC.FORM_COLUMNS

-- Foreign Key
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
-- End of DDL script for Foreign Key(s)
