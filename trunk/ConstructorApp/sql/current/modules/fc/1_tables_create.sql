DROP TABLE applications
/

CREATE TABLE applications
    (schema_name                    VARCHAR2(100),
    apps_description               VARCHAR2(4000),
    apps_name                      VARCHAR2(4000),
    apps_code                      VARCHAR2(200),
    default_table_prefix           VARCHAR2(10))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
/




DROP TABLE apps_privs
/

CREATE TABLE apps_privs
    (apps_code                      VARCHAR2(200),
    form_code                      VARCHAR2(255))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
/

GRANT DELETE ON apps_privs TO aahr_orders
/
GRANT INSERT ON apps_privs TO aahr_orders
/
GRANT UPDATE ON apps_privs TO aahr_orders
/



DROP TABLE apps_role_menus
/

CREATE TABLE apps_role_menus
    (app_menu_id                    NUMBER,
    menu_code                      VARCHAR2(4000),
    parent_menu_code               VARCHAR2(4000),
    position                       NUMBER(9,0),
    form_code                      VARCHAR2(4000),
    enabled_flag                   VARCHAR2(4000),
    display_name                   VARCHAR2(4000))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
/




DROP TABLE apps_role_users
/

CREATE TABLE apps_role_users
    (app_role_user_id               NUMBER,
    role_code                      VARCHAR2(4000),
    apps_code                      VARCHAR2(4000),
    user_id                        NUMBER)
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
/




DROP TABLE apps_roles
/

CREATE TABLE apps_roles
    (apps_role_id                   NUMBER,
    role_code                      VARCHAR2(4000),
    role_name                      VARCHAR2(4000),
    apps_code                      VARCHAR2(4000),
    root_menu_code                 VARCHAR2(4000))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
/




DROP TABLE form_actions
/

CREATE TABLE form_actions
    (form_code                      VARCHAR2(255) NOT NULL,
    action_code                    VARCHAR2(255) NOT NULL,
    procedure_name                 VARCHAR2(255),
    action_display_name            VARCHAR2(255),
    icon_id                        NUMBER,
    default_param_prefix           VARCHAR2(255),
    default_old_param_prefix       VARCHAR2(255),
    action_type                    VARCHAR2(2),
    display_number                 NUMBER,
    confirm_text                   VARCHAR2(4000) DEFAULT '�� ��������?',
    hot_key                        VARCHAR2(255),
    show_separator_below           VARCHAR2(1) DEFAULT 'N',
    display_on_toolbar             VARCHAR2(1) DEFAULT 'Y',
    child_form_code                VARCHAR2(255),
    url_text                       VARCHAR2(4000))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
/

GRANT SELECT ON form_actions TO mz_so_integration
/
GRANT SELECT ON form_actions TO tc
/
GRANT SELECT ON form_actions TO ins
/
GRANT SELECT ON form_actions TO aahr_orders
/
GRANT SELECT ON form_actions TO bf
/
GRANT SELECT ON form_actions TO fc_admin
/



ALTER TABLE form_actions
ADD CONSTRAINT form_actions_pk PRIMARY KEY (form_code, action_code)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

COMMENT ON COLUMN form_actions.child_form_code IS '����� �������� ����� � ����� ����/����'
/
COMMENT ON COLUMN form_actions.url_text IS 'URL ����� ���������� ��������'
/
DROP TABLE form_column_actions
/

CREATE TABLE form_column_actions
    (form_column_action_id          NUMBER,
    form_code                      VARCHAR2(255) NOT NULL,
    column_code                    VARCHAR2(255) NOT NULL,
    action_code                    VARCHAR2(255) NOT NULL,
    action_key_code                VARCHAR2(255),
    col_action_type_code           VARCHAR2(255) NOT NULL)
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
/

GRANT SELECT ON form_column_actions TO fc_admin
/



ALTER TABLE form_column_actions
ADD CONSTRAINT form_column_actions_pk PRIMARY KEY (form_code, column_code, 
  action_code, col_action_type_code)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/



COMMENT ON COLUMN form_column_actions.action_code IS '��� ��������'
/
COMMENT ON COLUMN form_column_actions.action_key_code IS '������� (��� ���� "�� ������� �������").'
/
COMMENT ON COLUMN form_column_actions.col_action_type_code IS '��� �������� (����� FORM_COLUMNS.ACTION_TYPE)'
/
COMMENT ON COLUMN form_column_actions.column_code IS '��� �������'
/
COMMENT ON COLUMN form_column_actions.form_code IS '��� �����'
/
COMMENT ON COLUMN form_column_actions.form_column_action_id IS '����. ��� ���������� �� ����������'
/
ALTER TABLE form_column_actions
ADD CONSTRAINT form_cols_acts_actions_fk FOREIGN KEY (form_code, action_code)
REFERENCES form_actions (form_code,action_code) ON DELETE CASCADE
/
ALTER TABLE form_column_actions
ADD CONSTRAINT form_cols_acts_columns_fk FOREIGN KEY (form_code, column_code)
REFERENCES form_columns$ (form_code,col_name) ON DELETE CASCADE
DISABLE NOVALIDATE
/
DROP TABLE form_column_attr_vals
/

CREATE TABLE form_column_attr_vals
    (form_column_attr_val_id        NUMBER,
    form_code                      VARCHAR2(255),
    column_code                    VARCHAR2(255),
    attribute_code                 VARCHAR2(255),
    attribute_value                VARCHAR2(255))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
/

GRANT SELECT ON form_column_attr_vals TO ins
/
GRANT SELECT ON form_column_attr_vals TO fc_admin
/



COMMENT ON TABLE form_column_attr_vals IS '�������������� �������� �������'
/
COMMENT ON COLUMN form_column_attr_vals.attribute_code IS '��� ��������'
/
COMMENT ON COLUMN form_column_attr_vals.attribute_value IS '�������� ��������'
/
COMMENT ON COLUMN form_column_attr_vals.column_code IS '������������� ���� (�� �������)'
/
COMMENT ON COLUMN form_column_attr_vals.form_code IS '������������� ����'
/
COMMENT ON COLUMN form_column_attr_vals.form_column_attr_val_id IS 'Id'
/
DROP TABLE form_columns
/

CREATE TABLE form_columns
    (form_code                      VARCHAR2(255),
    column_code                    VARCHAR2(255),
    column_user_name               VARCHAR2(255),
    column_display_size            VARCHAR2(255),
    column_data_type               VARCHAR2(255) DEFAULT 'S',
    column_display_number          NUMBER,
    pimary_key_flag                VARCHAR2(1),
    show_on_grid                   VARCHAR2(1) DEFAULT 'Y',
    tree_initialization_value      VARCHAR2(2000),
    tree_field_type                VARCHAR2(2),
    editor_tab_code                VARCHAR2(255),
    field_type                     VARCHAR2(2),
    column_description             VARCHAR2(2000),
    is_frozen_flag                 VARCHAR2(1) DEFAULT 'N',
    show_hover_flag                VARCHAR2(1) DEFAULT 'N',
    lookup_code                    VARCHAR2(255),
    hover_column_code              VARCHAR2(255),
    editor_height                  VARCHAR2(255),
    lookup_field_type              VARCHAR2(1),
    help_text                      CLOB,
    text_mask                      VARCHAR2(255),
    validation_regexp              VARCHAR2(255),
    default_orderby_number         VARCHAR2(10),
    default_value                  VARCHAR2(255),
    editor_title_orientation       VARCHAR2(1) DEFAULT NULL,
    editor_end_row_flag            VARCHAR2(1) DEFAULT 'Y',
    editor_cols_span               VARCHAR2(10) DEFAULT '*',
    lookup_display_value           VARCHAR2(255),
    editor_on_enter_key_action     VARCHAR2(255))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
  LOB ("HELP_TEXT") STORE AS SYS_LOB0000034311C00020$$
  (
   NOCACHE LOGGING
   CHUNK 8192
  )
/

GRANT SELECT ON form_columns TO sys
/
GRANT SELECT ON form_columns TO tc
/
GRANT SELECT ON form_columns TO ins
/
GRANT SELECT ON form_columns TO aahr_orders
/
GRANT UPDATE ON form_columns TO aahr_orders
/
GRANT SELECT ON form_columns TO bf
/
GRANT SELECT ON form_columns TO fc_admin
/



ALTER TABLE form_columns
ADD CONSTRAINT form_columns_uk UNIQUE (form_code, column_code)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/



COMMENT ON COLUMN form_columns.column_code IS '������������� ���� (�� �������)'
/
COMMENT ON COLUMN form_columns.column_data_type IS '��� ������ (FORM_COLUMNS.DATA_TYPE)'
/
COMMENT ON COLUMN form_columns.column_description IS '�������� ���� (��������� ��� ������������)'
/
COMMENT ON COLUMN form_columns.column_display_number IS '���������� ����� ����������� � �������'
/
COMMENT ON COLUMN form_columns.column_display_size IS '������ ���� � ���������'
/
COMMENT ON COLUMN form_columns.column_user_name IS '���������������� ��� ����'
/
COMMENT ON COLUMN form_columns.default_orderby_number IS '������� ���������� ��� �������� �����. "-" ����� ����� - ���������� �� ��������'
/
COMMENT ON COLUMN form_columns.default_value IS '�������� �� ��������� ��� ����� �������'
/
COMMENT ON COLUMN form_columns.editor_cols_span IS '�������� - ���������� �������, ���������� ����� (item.setColSpan)'
/
COMMENT ON COLUMN form_columns.editor_end_row_flag IS 'item.setEndRow'
/
COMMENT ON COLUMN form_columns.editor_height IS '������ ���� � �������� ��������������'
/
COMMENT ON COLUMN form_columns.editor_on_enter_key_action IS '�������� �� ������� Enter'
/
COMMENT ON COLUMN form_columns.editor_tab_code IS '������ �� �������� ����� ��������������. ���� �� ������� - ������������ ������ � �����'
/
COMMENT ON COLUMN form_columns.editor_title_orientation IS 'item.setTitleOrientation'
/
COMMENT ON COLUMN form_columns.field_type IS '��� ����, ����� ��� ������ � �����'
/
COMMENT ON COLUMN form_columns.form_code IS '������������� ����'
/
COMMENT ON COLUMN form_columns.help_text IS '�������� ���� � HTML'
/
COMMENT ON COLUMN form_columns.hover_column_code IS '���� ��� �� �����, ������� �������� ���������. ���� SHOW_HOVER_FLAG = ''Y'' � HOVER_COLUMN_CODE - ��������� ������� �� �������� ���� (COLUMN_CODE)'
/
COMMENT ON COLUMN form_columns.is_frozen_flag IS '������������ ����?'
/
COMMENT ON COLUMN form_columns.lookup_code IS '������ �� ����� - ������ ��� �������'
/
COMMENT ON COLUMN form_columns.lookup_display_value IS '���� �������, ������������ ������������ - ��� ������� �������'
/
COMMENT ON COLUMN form_columns.lookup_field_type IS '��. Lookup FORM_COLUMNS.LOOKUP_FIELD_TYPE'
/
COMMENT ON COLUMN form_columns.pimary_key_flag IS '������� ����, ��� ���� �������� ��������� ������ (Y). ����� - �� ��������.'
/
COMMENT ON COLUMN form_columns.show_hover_flag IS '���������� ����������� ���������-�������� ����'
/
COMMENT ON COLUMN form_columns.show_on_grid IS '���������� � �����'
/
COMMENT ON COLUMN form_columns.text_mask IS '��������� ����� ��� ����. ��. �������� � ����������'
/
COMMENT ON COLUMN form_columns.tree_field_type IS '��� ���� ��� ������ (Id, ParentId, ChildCount...)'
/
COMMENT ON COLUMN form_columns.tree_initialization_value IS '���� �� ����� � ��� ����� - "������" - ������������ ��� ������ ������ ������ ��� �������������. ���������� ����������� Start With ����������� ��������'
/
COMMENT ON COLUMN form_columns.validation_regexp IS '���������� ��������� ��� ���������� ���������'
/
ALTER TABLE form_columns
ADD CONSTRAINT form_columns_hover_cc_fk FOREIGN KEY (form_code, 
  hover_column_code)
REFERENCES form_columns$ (form_code,col_name)
DISABLE NOVALIDATE
/
ALTER TABLE form_columns
ADD CONSTRAINT form_tabs_fk FOREIGN KEY (form_code, editor_tab_code)
REFERENCES form_tabs (form_code,tab_code)
/
DROP TABLE form_columns$
/

CREATE TABLE form_columns$
    (col_num                        NUMBER,
    col_type                       VARCHAR2(255),
    col_max_len                    NUMBER,
    col_name                       VARCHAR2(4000),
    col_name_len                   NUMBER,
    col_precision                  NUMBER,
    col_scale                      NUMBER,
    form_code                      VARCHAR2(255),
    pimary_key_flag                VARCHAR2(1),
    default_column_width           VARCHAR2(30),
    column_description             VARCHAR2(4000))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
/

GRANT SELECT ON form_columns$ TO tc
/
GRANT SELECT ON form_columns$ TO ins
/
GRANT SELECT ON form_columns$ TO bf
/
GRANT SELECT ON form_columns$ TO fc_admin
/



ALTER TABLE form_columns$
ADD CONSTRAINT form_columns$_uk UNIQUE (form_code, col_name)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

DROP TABLE form_prop_values
/

CREATE TABLE form_prop_values
    (prop_value_id                  NUMBER,
    form_code                      VARCHAR2(4000),
    property_level                 VARCHAR2(4000),
    property_code                  VARCHAR2(4000),
    prop_val_level                 VARCHAR2(4000),
    value_char                     VARCHAR2(4000),
    value_number                   NUMBER,
    value_date                     DATE,
    value_clob                     CLOB)
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
  LOB ("VALUE_CLOB") STORE AS SYS_LOB0000038074C00009$$
  (
   NOCACHE LOGGING
   CHUNK 8192
  )
/




COMMENT ON COLUMN form_prop_values.prop_val_level IS 'SYSTEM->APP->PARENT_FORM->ROLE->USER (System - ��� ������ �������� FORM_COLUMNS$). �������� � ������������'
/
DROP TABLE form_props
/

CREATE TABLE form_props
    (property_level                 VARCHAR2(4000),
    property_code                  VARCHAR2(4000),
    property_name                  VARCHAR2(4000),
    description                    VARCHAR2(4000),
    help_text                      CLOB,
    prop_datatype                  VARCHAR2(4000),
    property_id                    NUMBER)
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
  LOB ("HELP_TEXT") STORE AS SYS_LOB0000038065C00005$$
  (
   NOCACHE LOGGING
   CHUNK 8192
  )
/




COMMENT ON COLUMN form_props.description IS '��������, ��� ���������'
/
COMMENT ON COLUMN form_props.help_text IS 'HTML ����� ��� ��������� � ����������'
/
COMMENT ON COLUMN form_props.prop_datatype IS '��� ������ N(umber) D(ate) S(tring) B(oolean) L(OB)'
/
COMMENT ON COLUMN form_props.property_code IS '���� SQL_TEXT'
/
COMMENT ON COLUMN form_props.property_id IS 'ID'
/
COMMENT ON COLUMN form_props.property_level IS 'FORM->TAB->COLUMN-ACTION'
/
COMMENT ON COLUMN form_props.property_name IS '���� "����� �������"'
/
DROP TABLE form_tab_parent_exclns
/

CREATE TABLE form_tab_parent_exclns
    (form_code                      VARCHAR2(4000),
    tab_code                       VARCHAR2(4000),
    parent_form_code               VARCHAR2(4000),
    included_flag                  VARCHAR2(2),
    excln_id                       NUMBER)
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
/

GRANT SELECT ON form_tab_parent_exclns TO fc_admin
/



COMMENT ON TABLE form_tab_parent_exclns IS 'Select a.child_form_code As form_code, a.tab_code, a.form_code As parent_form_code, ''Y'' As included_flag From form_tabs a Where a.child_form_code = ''INS_INS_INSURED'''
/
COMMENT ON COLUMN form_tab_parent_exclns.excln_id IS 'ID'
/
DROP TABLE form_tabs
/

CREATE TABLE form_tabs
    (form_code                      VARCHAR2(255),
    tab_code                       VARCHAR2(255),
    child_form_code                VARCHAR2(255),
    tab_position                   VARCHAR2(1),
    tab_name                       VARCHAR2(255),
    number_of_columns              NUMBER DEFAULT NULL,
    icon_id                        NUMBER,
    tab_type                       VARCHAR2(2),
    tab_display_number             NUMBER)
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
/

GRANT SELECT ON form_tabs TO tc
/
GRANT SELECT ON form_tabs TO ins
/
GRANT SELECT ON form_tabs TO aahr_orders
/
GRANT SELECT ON form_tabs TO bf
/
GRANT SELECT ON form_tabs TO fc_admin
/



ALTER TABLE form_tabs
ADD CONSTRAINT form_tabs_pk UNIQUE (form_code, tab_code)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

COMMENT ON COLUMN form_tabs.form_code IS '������������� ����'
/
COMMENT ON COLUMN form_tabs.number_of_columns IS '��. com.smartgwt.client.widgets.form.DynamicForm   setNumCols'
/
COMMENT ON COLUMN form_tabs.tab_code IS '������������� ��������'
/
COMMENT ON COLUMN form_tabs.tab_display_number IS '������� ����������'
/
COMMENT ON COLUMN form_tabs.tab_name IS '���������������� ��� ��������'
/
COMMENT ON COLUMN form_tabs.tab_position IS 'Lookup FORMS.EDITOR_POSITION'
/
DROP TABLE forms
/

CREATE TABLE forms
    (form_code                      VARCHAR2(255) NOT NULL,
    hot_key                        VARCHAR2(100),
    sql_text                       VARCHAR2(4000),
    form_name                      VARCHAR2(255),
    form_type                      VARCHAR2(1) DEFAULT 'G',
    show_tree_root_node            VARCHAR2(1) DEFAULT 'Y',
    icon_id                        NUMBER,
    form_width                     VARCHAR2(30) DEFAULT '*',
    form_height                    VARCHAR2(30) DEFAULT '*',
    bottom_tabs_orientation        VARCHAR2(2) DEFAULT NULL,
    side_tabs_orientation          VARCHAR2(2),
    show_bottom_toolbar            VARCHAR2(1) DEFAULT 'Y',
    object_version_number          NUMBER DEFAULT 1,
    default_column_width           VARCHAR2(30) DEFAULT '*',
    description                    CLOB,
    double_click_action_code       VARCHAR2(255),
    lookup_width                   NUMBER,
    apps_code                      VARCHAR2(255),
    export_order                   NUMBER DEFAULT 100)
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
  LOB ("DESCRIPTION") STORE AS SYS_LOB0000034300C00015$$
  (
   NOCACHE LOGGING
   CHUNK 8192
  )
/

GRANT SELECT ON forms TO sys
/
GRANT SELECT ON forms TO mz_so_integration
/
GRANT SELECT ON forms TO tc
/
GRANT INSERT ON forms TO ins
/
GRANT SELECT ON forms TO ins
/
GRANT UPDATE ON forms TO ins
/
GRANT DELETE ON forms TO aahr_orders
/
GRANT INSERT ON forms TO aahr_orders
/
GRANT SELECT ON forms TO aahr_orders
/
GRANT UPDATE ON forms TO aahr_orders
/
GRANT SELECT ON forms TO bf
/
GRANT INSERT ON forms TO fc_admin
/
GRANT SELECT ON forms TO fc_admin
/
GRANT UPDATE ON forms TO fc_admin
/



ALTER TABLE forms
ADD CONSTRAINT forms_pk PRIMARY KEY (form_code)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/


CREATE OR REPLACE TRIGGER forms_sql_update_aiud
 AFTER
   INSERT OR DELETE OR UPDATE OF sql_text
 ON forms
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
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

COMMENT ON TABLE forms IS 'xx'
/
COMMENT ON COLUMN forms.apps_code IS '��� ����������. ���� ������ ��� ��������� ��������� ��������'
/
COMMENT ON COLUMN forms.bottom_tabs_orientation IS '���������� ������ ������� �����������. ��. FORMS.TABS_ORIENTATION'
/
COMMENT ON COLUMN forms.default_column_width IS '������ ����� �� ���������'
/
COMMENT ON COLUMN forms.description IS '�������� �����... ��� ����������� ��� ��������� ������ � �.�'
/
COMMENT ON COLUMN forms.double_click_action_code IS '�������� �� �������� ������ �� ������. �� ��������� - ��������������'
/
COMMENT ON COLUMN forms.export_order IS '���������� ����� ��� ��������� ��������'
/
COMMENT ON COLUMN forms.form_code IS '��������� ������������� �����'
/
COMMENT ON COLUMN forms.form_height IS '������ � �������� ��� ���������. * - ����'
/
COMMENT ON COLUMN forms.form_name IS '��� ����� ��� ������������'
/
COMMENT ON COLUMN forms.form_type IS '��� �����. G-����, T-������...'
/
COMMENT ON COLUMN forms.form_width IS '������ � �������� ��� ���������. * - ����'
/
COMMENT ON COLUMN forms.hot_key IS '������� �������  - ������ ���� [Ctrl+][Alt+][Shift+]Chr. ������� �� �����'
/
COMMENT ON COLUMN forms.lookup_width IS '������ ������ (���� ����� ��������� � ���� ������)'
/
COMMENT ON COLUMN forms.show_bottom_toolbar IS '���������� ������ ������?'
/
COMMENT ON COLUMN forms.show_tree_root_node IS '���������� �� �������� ���� ��� ������?'
/
COMMENT ON COLUMN forms.side_tabs_orientation IS '���������� ������� ������� �����������. ��. FORMS.TABS_ORIENTATION'
/
COMMENT ON COLUMN forms.sql_text IS 'Order by �� ������� ������� �� �����������, ����� ��� ���������� ������ �����..'
/
ALTER TABLE forms
ADD CONSTRAINT forms_form_actions_fk FOREIGN KEY (form_code, 
  double_click_action_code)
REFERENCES form_actions (form_code,action_code)
/
DROP TABLE global_params
/

CREATE TABLE global_params
    (param_name                     VARCHAR2(255),
    param_value                    VARCHAR2(2000))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
/

GRANT SELECT ON global_params TO fc_admin
/



DROP TABLE icons
/

CREATE TABLE icons
    (icon_id                        NUMBER,
    icon_file_name                 VARCHAR2(4000),
    icon_path                      VARCHAR2(255))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
/

GRANT SELECT ON icons TO mz_so_integration
/
GRANT SELECT ON icons TO tc
/
GRANT SELECT ON icons TO ins
/
GRANT SELECT ON icons TO aahr_orders
/
GRANT SELECT ON icons TO bf
/
GRANT SELECT ON icons TO fc_admin
/



COMMENT ON COLUMN icons.icon_file_name IS '���� ������ �� ���� default_icon_path'
/
DROP TABLE lookup_attribute_values
/

CREATE TABLE lookup_attribute_values
    (lookup_code                    VARCHAR2(255),
    lookup_value_code              VARCHAR2(255),
    attribute_code                 VARCHAR2(255),
    attribute_value_number         NUMBER,
    attribute_value_char           VARCHAR2(2000),
    attribute_value_date           DATE)
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
/

GRANT SELECT ON lookup_attribute_values TO tc
/
GRANT SELECT ON lookup_attribute_values TO ins
/
GRANT SELECT ON lookup_attribute_values TO aahr_orders
/
GRANT SELECT ON lookup_attribute_values TO bf
/
GRANT SELECT ON lookup_attribute_values TO fc_admin
/





ALTER TABLE lookup_attribute_values
ADD CONSTRAINT lookup_attribute_values_fk1 FOREIGN KEY (lookup_code, 
  attribute_code)
REFERENCES lookup_attributes (lookup_code,attribute_code)
/
ALTER TABLE lookup_attribute_values
ADD CONSTRAINT lookup_attribute_values_fk2 FOREIGN KEY (lookup_code, 
  lookup_value_code)
REFERENCES lookup_values (lookup_code,lookup_value_code)
/
DROP TABLE lookup_attributes
/

CREATE TABLE lookup_attributes
    (lookup_code                    VARCHAR2(255),
    attribute_code                 VARCHAR2(255),
    attribute_name                 VARCHAR2(255),
    attribute_type                 VARCHAR2(1))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
/

GRANT SELECT ON lookup_attributes TO tc
/
GRANT SELECT ON lookup_attributes TO ins
/
GRANT SELECT ON lookup_attributes TO aahr_orders
/
GRANT SELECT ON lookup_attributes TO bf
/
GRANT SELECT ON lookup_attributes TO fc_admin
/



ALTER TABLE lookup_attributes
ADD CONSTRAINT lookup_attribute_uk UNIQUE (lookup_code, attribute_code)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

DROP TABLE lookup_values
/

CREATE TABLE lookup_values
    (lookup_code                    VARCHAR2(255),
    lookup_value_code              VARCHAR2(255),
    lookup_display_value           VARCHAR2(255),
    lookup_value_id                NUMBER NOT NULL)
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
/

GRANT SELECT ON lookup_values TO app_rates
/
GRANT SELECT ON lookup_values TO mz_so_integration
/
GRANT DELETE ON lookup_values TO tc
/
GRANT INSERT ON lookup_values TO tc
/
GRANT SELECT ON lookup_values TO tc
/
GRANT UPDATE ON lookup_values TO tc
/
GRANT DELETE ON lookup_values TO ins
/
GRANT INSERT ON lookup_values TO ins
/
GRANT SELECT ON lookup_values TO ins
/
GRANT UPDATE ON lookup_values TO ins
/
GRANT SELECT ON lookup_values TO aahr_orders
/
GRANT DELETE ON lookup_values TO bf
/
GRANT INSERT ON lookup_values TO bf
/
GRANT SELECT ON lookup_values TO bf
/
GRANT UPDATE ON lookup_values TO bf
/
GRANT DELETE ON lookup_values TO fc_admin
/
GRANT INSERT ON lookup_values TO fc_admin
/
GRANT SELECT ON lookup_values TO fc_admin
/
GRANT UPDATE ON lookup_values TO fc_admin
/



ALTER TABLE lookup_values
ADD CONSTRAINT lookup_value_id_pk PRIMARY KEY (lookup_value_id)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

ALTER TABLE lookup_values
ADD CONSTRAINT lookup_value_uk UNIQUE (lookup_code, lookup_value_code)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

CREATE OR REPLACE TRIGGER lookup_values_biud
 BEFORE
  INSERT OR DELETE OR UPDATE
 ON lookup_values
REFERENCING NEW AS NEW OLD AS OLD
 FOR EACH ROW
Begin
   If INSERTING Then
      Select main_sq.Nextval
        Into :New.lookup_value_id
        From DUAL;
   End If;
End;
/

DROP TABLE lookups
/

CREATE TABLE lookups
    (lookup_code                    VARCHAR2(255),
    lookup_name                    VARCHAR2(255))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
/

GRANT SELECT ON lookups TO mz_so_integration
/
GRANT DELETE ON lookups TO tc
/
GRANT INSERT ON lookups TO tc
/
GRANT SELECT ON lookups TO tc
/
GRANT UPDATE ON lookups TO tc
/
GRANT DELETE ON lookups TO ins
/
GRANT INSERT ON lookups TO ins
/
GRANT SELECT ON lookups TO ins
/
GRANT UPDATE ON lookups TO ins
/
GRANT SELECT ON lookups TO aahr_orders
/
GRANT DELETE ON lookups TO bf
/
GRANT INSERT ON lookups TO bf
/
GRANT SELECT ON lookups TO bf
/
GRANT UPDATE ON lookups TO bf
/
GRANT DELETE ON lookups TO fc_admin
/
GRANT INSERT ON lookups TO fc_admin
/
GRANT SELECT ON lookups TO fc_admin
/
GRANT UPDATE ON lookups TO fc_admin
/



COMMENT ON COLUMN lookups.lookup_code IS '��������� ������������ (ID)'
/
COMMENT ON COLUMN lookups.lookup_name IS '���������������� ���'
/
DROP TABLE menus
/

CREATE TABLE menus
    (menu_code                      VARCHAR2(255) NOT NULL,
    menu_name                      VARCHAR2(255),
    parent_menu_code               VARCHAR2(255),
    menu_form_code                 VARCHAR2(255),
    menu_position                  NUMBER,
    show_in_navigator              VARCHAR2(1) DEFAULT 'N')
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
/

GRANT SELECT ON menus TO app_rates
/
GRANT SELECT ON menus TO mz_so_integration
/
GRANT SELECT ON menus TO tc
/
GRANT SELECT ON menus TO ins
/
GRANT SELECT ON menus TO aahr_orders
/
GRANT SELECT ON menus TO bf
/
GRANT SELECT ON menus TO fc_admin
/



ALTER TABLE menus
ADD CONSTRAINT menus_pk PRIMARY KEY (menu_code)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255
/

COMMENT ON COLUMN menus.menu_code IS '��� ����'
/
COMMENT ON COLUMN menus.menu_form_code IS '������ �� ����� (��� �������� �����)'
/
COMMENT ON COLUMN menus.menu_name IS '���������������� ������������ ����'
/
COMMENT ON COLUMN menus.menu_position IS '������� ������� �� ����� ������. ���� �� ������� - �� ������� ������������, ����� �� ������������'
/
COMMENT ON COLUMN menus.parent_menu_code IS '������ �� ����� ����-��������'
/
COMMENT ON COLUMN menus.show_in_navigator IS '���������� � ����������'
/
DROP TABLE report_templates
/

CREATE TABLE report_templates
    (report_id                      NUMBER,
    user_id                        NUMBER,
    app_code                       VARCHAR2(255),
    report_type_code               VARCHAR2(255),
    content_type                   VARCHAR2(255),
    content                        BLOB,
    filename                       VARCHAR2(255),
    clob_content                   CLOB)
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
  LOB ("CONTENT") STORE AS SYS_LOB0000039462C00006$$
  (
   NOCACHE LOGGING
   CHUNK 8192
  )
  LOB ("CLOB_CONTENT") STORE AS SYS_LOB0000039462C00008$$
  (
   NOCACHE LOGGING
   CHUNK 8192
  )
/

GRANT SELECT ON report_templates TO ins
/
GRANT SELECT ON report_templates TO fc_admin
/



DROP TABLE sqln_explain_plan
/

CREATE TABLE sqln_explain_plan
    (statement_id                   VARCHAR2(30),
    timestamp                      DATE,
    remarks                        VARCHAR2(80),
    operation                      VARCHAR2(30),
    options                        VARCHAR2(30),
    object_node                    VARCHAR2(128),
    object_owner                   VARCHAR2(30),
    object_name                    VARCHAR2(30),
    object_instance                NUMBER(*,0),
    object_type                    VARCHAR2(30),
    optimizer                      VARCHAR2(255),
    search_columns                 NUMBER(*,0),
    id                             NUMBER(*,0),
    parent_id                      NUMBER(*,0),
    position                       NUMBER(*,0),
    cost                           NUMBER(*,0),
    cardinality                    NUMBER(*,0),
    bytes                          NUMBER(*,0),
    other_tag                      VARCHAR2(255),
    partition_start                VARCHAR2(255),
    partition_stop                 VARCHAR2(255),
    partition_id                   NUMBER(*,0),
    other                          LONG,
    distribution                   VARCHAR2(30))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
/

GRANT DELETE ON sqln_explain_plan TO public
/
GRANT INSERT ON sqln_explain_plan TO public
/
GRANT SELECT ON sqln_explain_plan TO public
/
GRANT UPDATE ON sqln_explain_plan TO public
/



DROP TABLE tmp1
/

CREATE TABLE tmp1
    (lvl                            NUMBER,
    menu_code                      VARCHAR2(255),
    parent_menu_code               VARCHAR2(255),
    menu_position                  NUMBER,
    show_in_navigator              VARCHAR2(1),
    menu_name                      VARCHAR2(255),
    form_code                      VARCHAR2(255),
    form_name                      VARCHAR2(255),
    icon_id                        NUMBER,
    hot_key                        VARCHAR2(100),
    description                    CLOB,
    child_count                    NUMBER)
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
  LOB ("DESCRIPTION") STORE AS SYS_LOB0000037330C00011$$
  (
   NOCACHE LOGGING
   CHUNK 8192
   PCTVERSION 10
  )
/




DROP TABLE users
/

CREATE TABLE users
    (user_id                        NUMBER,
    fio                            VARCHAR2(4000),
    username                       VARCHAR2(255),
    password                       VARCHAR2(255),
    orig_ref_id                    NUMBER(10,0),
    email                          VARCHAR2(4000))
  PCTFREE     10
  INITRANS    1
  MAXTRANS    255
/

GRANT SELECT ON users TO ins
/
GRANT SELECT ON users TO bf
/
GRANT SELECT ON users TO fc_admin
/



