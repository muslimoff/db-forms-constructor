Create Table attribute_type_lng_cases
    (attribute_type_lng_case_id     Number(19,0),
    attribute_code                 Varchar2(4000),
    lang_code                      Varchar2(10),
    case_id                        Number,
    case_ending_type               Varchar2(10))
/
Grant Select On attribute_type_lng_cases To fc
/


Create Table attribute_types
    (attribute_id                   Number,
    attribute_code                 Varchar2(4000),
    attribute_name                 Varchar2(4000),
    attribute_type                 Varchar2(4000),
    db_expression                  Varchar2(4000),
    exec_order                     Number)
/
Grant Select On attribute_types To fc
/


Comment On Column attribute_types.attribute_type Is 'N/D/C/B'
/
Comment On Column attribute_types.db_expression Is 'SQL выражение'
/
Create Table entity_types
    (entity_type_id                 Number,
    entity_type_code               Varchar2(4000),
    parent_entity_type_code        Varchar2(4000),
    entity_type_name               Varchar2(4000))
/
Grant Select On entity_types To fc
/


Create Table lang_case_endings
    (case_ending_id                 Number NOT NULL,
    case_id                        Number,
    ending_id                      Number,
    case_ending                    Varchar2(255))
/
Grant Select On lang_case_endings To fc
/


Create Table lang_cases
    (case_id                        Number NOT NULL,
    case_number                    Varchar2(19),
    lang                           Varchar2(3),
    case_name                      Varchar2(200),
    case_name_en                   Varchar2(200),
    case_name_ru                   Varchar2(200),
    question                       Varchar2(200))
/
Grant Select On lang_cases To fc
/


Create Table lang_endings
    (ending_id                      Number,
    lang                           Varchar2(3),
    ending_type                    Varchar2(10),
    sex                            Varchar2(1),
    ending                         Varchar2(255),
    comments                       Varchar2(255))
/
Grant Select On lang_endings To fc
/


Create Table order_entities
    (order_entity_id                Number,
    order_id                       Number,
    entity_type_code               Varchar2(4000),
    entity_id                      Number(9,0))
/
Grant Select On order_entities To fc
/


Comment On Column order_entities.entity_id Is 'Person_id organization_id assignment_id'
/
Comment On Column order_entities.entity_type_code Is 'Person/Organization/Assignment'
/
Create Table order_entity_attribute_values
    (order_entity_attr_value_id     Number,
    order_entity_id                Number,
    attribute_code                 Varchar2(4000),
    attribute_value                Varchar2(4000),
    attribute_value_date           Date,
    attribute_value_number         Number)
/
Grant Select On order_entity_attribute_values To fc
/


Create Table order_type_attributes
    (ot_attribute_id                Number,
    order_type_code                Varchar2(4000),
    attribute_code                 Varchar2(4000),
    api_field_name                 Varchar2(4000),
    in_out_type                    Varchar2(4000),
    display_name                   Varchar2(4000),
    display_position               Number,
    save_after_aprove_flag         Varchar2(2))
/
Grant Select On order_type_attributes To fc
/


Comment On Column order_type_attributes.display_name Is 'Имя поля в приказе. Перекрывает значение attribute_types.attribute_name'
/
Comment On Column order_type_attributes.display_position Is 'Порядковый номер поля в приказах'
/
Comment On Column order_type_attributes.in_out_type Is 'I O IO'
/
Comment On Column order_type_attributes.save_after_aprove_flag Is 'Сохранять в БД после утверждения (для ФИО в падежах - "Нет")'
/
Create Table order_type_reports
    (order_type_report_id           Number,
    order_type_code                Varchar2(4000),
    report_name                    Varchar2(4000),
    Template                       CLOB)
  Lob ("Template") Store As Sys_Lob0000036161C00004$$
  (
   Nocache Logging
   Chunk 8192
  )
/
Grant Select On order_type_reports To fc
/


Create Table order_types
    (order_type_id                  Number,
    order_type_code                Varchar2(4000),
    order_type_name                Varchar2(4000),
    api_procedure_name             Varchar2(4000),
    parent_order_type_code         Varchar2(4000),
    multiple_entits_allowed_fl     Varchar2(1),
    wf_process_name                Varchar2(4000),
    view_name                      Varchar2(4000),
    form_code                      Varchar2(4000),
    entity_type_code               Varchar2(4000))
/
Grant Select On order_types To fc
/


Create Table orders
    (order_id                       Number,
    order_type_code                Varchar2(4000),
    order_date                     Date,
    order_number                   Varchar2(4000),
    approval_date                  Date,
    start_date                     Date)
/
Grant Select On orders To fc
/
Grant Select On orders To fc22
/


Comment On Column orders.approval_date Is 'Дата утверждения'
/
Comment On Column orders.start_date Is 'Дата вступления в силу'
/

