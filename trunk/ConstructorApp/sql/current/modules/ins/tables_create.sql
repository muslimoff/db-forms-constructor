Create Table exp_account
    (orig_ref_id                    Number(10,0) NOT NULL,
    date_part                      Varchar2(24),
    Account                        Varchar2(96),
    company                        Varchar2(768),
    account_date                   Date,
    amount                         Number(19,2),
    created_by                     Varchar2(384),
    created                        Date,
    updated_by                     Varchar2(384),
    updated                        Date)
/



Create Table exp_account_lines
    (orig_ref_id                    Number(10,0) NOT NULL,
    account_orig_ref_id            Number(10,0),
    insured_id                     Number(10,0),
    posting_date                   Date,
    visit_date                     Date,
    description                    Varchar2(768),
    discount                       Number(10,0),
    created_by                     Varchar2(384),
    created                        Date,
    updated_by                     Varchar2(384),
    updated                        Date)
/



Create Table exp_address
    (orig_ref_id                    Number(10,0),
    company                        Varchar2(768),
    address1                       Varchar2(768),
    address2                       Varchar2(768),
    city                           Varchar2(384),
    country                        Varchar2(384),
    main_address                   Number(10,0))
/



Create Table exp_company
    (orig_ref_id                    Number(10,0),
    company_name                   Varchar2(1536),
    short_name                     Varchar2(768),
    company_type                   Varchar2(384),
    created_by                     Varchar2(384),
    created                        Date,
    updated_by                     Varchar2(384),
    updated                        Date)
/



Create Table exp_contract
    (orig_ref_id                    Number(10,0),
    contract_no                    Varchar2(96),
    descr                          Varchar2(768),
    created_by                     Varchar2(384),
    created                        Date,
    updated_by                     Varchar2(384),
    updated                        Date,
    client_company                 Varchar2(768),
    insur_company                  Varchar2(768),
    summ                           Number(19,2),
    currency                       Varchar2(96),
    contract_date                  Date,
    date_start                     Date,
    date_finish                    Date)
/



Create Table exp_insured
    (orig_ref_id                    Number(10,0),
    fio                            Varchar2(384),
    address                        Varchar2(1536),
    phone                          Varchar2(384),
    date_of_birth                  Date,
    card_no                        Varchar2(96),
    contract_no                    Varchar2(96),
    program                        Varchar2(384),
    attached_to                    Varchar2(384),
    contract_start_date            Date,
    contract_finish_date           Date,
    limit_for_all_family           Number(10,0),
    sex                            Varchar2(3),
    created_by                     Varchar2(384),
    created                        Date,
    updated_by                     Varchar2(384),
    updated                        Date)
/



Create Table exp_insured_category
    (orig_ref_id                    Number(10,0),
    contract_no                    Varchar2(96),
    fio                            Varchar2(384),
    identity_card                  Varchar2(96),
    program                        Varchar2(384),
    Category                       Varchar2(384),
    amount                         Number(19,2),
    isunion                        Number(10,0),
    created_by                     Varchar2(384),
    created                        Date,
    updated_by                     Varchar2(384),
    updated                        Date)
/



Create Table exp_lookup_attribute_values
    (lookup_code                    Varchar2(765),
    lookup_value_code              Varchar2(765),
    attribute_code                 Varchar2(765),
    attribute_value_number         Number(19,2),
    attribute_value_int            Number(19,0),
    attribute_value_char           Varchar2(4000),
    attribute_value_date           Date)
/



Create Table exp_lookup_attributes
    (lookup_code                    Varchar2(765),
    attribute_code                 Varchar2(765),
    attribute_name                 Varchar2(765),
    attribute_type                 Char(3))
/



Create Table exp_lookup_values
    (lookup_code                    Varchar2(768),
    lookup_value_code              Varchar2(768),
    lookup_display_value           Varchar2(768))
/



Create Table exp_lookups
    (lookup_code                    Varchar2(768),
    lookup_name                    Varchar2(768))
/



Create Table exp_medical_service
    (orig_ref_id                    Number(10,0) NOT NULL,
    account_lines_ref_if           Number(10,0),
    medical_service_id             Number(10,0),
    amount                         Number(19,2),
    posted_date                    Date,
    orig_service_ref_id            Varchar2(192),
    created_by                     Varchar2(384),
    created                        Date,
    updated_by                     Varchar2(384),
    updated                        Date)
/



Create Table exp_program
    (orig_ref_id                    Number(10,0),
    contract_no                    Varchar2(96),
    program                        Varchar2(384),
    amount                         Number(19,2),
    premium                        Number(19,2),
    isunion                        Number(10,0),
    created_by                     Varchar2(384),
    created                        Date,
    updated_by                     Varchar2(384),
    updated                        Date)
/



Create Table exp_program_category
    (orig_ref_id                    Number(10,0),
    contract_no                    Varchar2(96),
    program                        Varchar2(384),
    Category                       Varchar2(384),
    amount                         Number(19,2),
    isunion                        Number(10,0),
    created_by                     Varchar2(384),
    created                        Date,
    updated_by                     Varchar2(384),
    updated                        Date)
/



Create Table exp_program_med_service
    (orig_ref_id                    Number(10,0),
    contract_no                    Varchar2(96),
    program                        Varchar2(384),
    Category                       Varchar2(384),
    medical_service                Varchar2(384),
    created_by                     Varchar2(384),
    created                        Date,
    updated_by                     Varchar2(384),
    updated                        Date)
/



Create Table exp_service_diagnosis
    (orig_ref_id                    Number(10,0) NOT NULL,
    account_lines_ref_if           Number(10,0),
    diagnosis_id                   Number(10,0),
    diagnosos                      Varchar2(768),
    orig_diagnosis_id              Varchar2(192),
    created_by                     Varchar2(384),
    created                        Date,
    updated_by                     Varchar2(384),
    updated                        Date)
/



Create Table exp_user
    (fio                            Varchar2(384),
    sys_name                       Varchar2(192),
    orig_ref_id                    Number(10,0))
/



Create Table exp_visit
    (orig_ref_id                    Number(10,0),
    visit_date                     Date,
    insured_id                     Number(10,0),
    status_id                      Number(10,0),
    visit_type                     Number(10,0),
    age                            Varchar2(96),
    address                        Varchar2(3072),
    phone                          Varchar2(384),
    visit_reason                   Varchar2(768),
    diagnosis                      Varchar2(768),
    comments                       Varchar2(3072),
    created_by                     Varchar2(384),
    created                        Date,
    updated_by                     Varchar2(384),
    updated                        Date)
/



Create Table exp_visit_result
    (orig_ref_id                    Number(10,0),
    visit_id                       Number(10,0),
    result_type_id                 Number(10,0),
    visit_time                     Varchar2(15),
    created_by                     Varchar2(384),
    created                        Date,
    updated_by                     Varchar2(384),
    updated                        Date)
/



Create Table ins_account
    (account_id                     Number,
    Account                        Varchar2(96),
    company_id                     Number,
    account_date                   Date,
    amount                         Number(19,2),
    created_by                     Number,
    created                        Date,
    updated_by                     Number,
    updated                        Date,
    orig_ref_id                    Number(10,0) NOT NULL)
/



Create Table ins_account_lines
    (account_line_id                Number NOT NULL,
    account_id                     Number,
    insured_id                     Number,
    posting_date                   Date,
    visit_date                     Date,
    discount                       Number(10,0),
    created_by                     Number,
    created                        Date,
    updated_by                     Number,
    updated                        Date,
    orig_ref_id                    Number(10,0) NOT NULL,
    is_reserve_flag                Varchar2(1),
    account_num                    Varchar2(100),
    company_id                     Number)
/



Create Index ins_accnt_lines_dates On ins_account_lines
  (
    posting_date                    ASC,
    visit_date                      ASC
  )
/

Alter Table ins_account_lines
Add Constraint account_lines_pk Primary Key (account_line_id)
Using Index
/
Create Table ins_company
    (Id                             Number,
    company_name                   Varchar2(1536),
    short_name                     Varchar2(768),
    company_type_id                Varchar2(255),
    created_by                     Number,
    created                        Date,
    updated_by                     Number,
    updated                        Date,
    orig_ref_id                    Number(10,0))
/



Create Table ins_contract
    (Id                             Number NOT NULL,
    contract_no                    Varchar2(96),
    descr                          Varchar2(768),
    created_by                     Number,
    created                        Date,
    updated_by                     Number,
    updated                        Date,
    client_company_id              Number,
    ins_company_id                 Number,
    summ                           Number(19,2),
    currency_id                    Varchar2(255),
    contract_date                  Date,
    date_start                     Date,
    date_finish                    Date,
    orig_ref_id                    Number(10,0))
/



Alter Table ins_contract
Add Constraint ins_contract_pk Primary Key (Id)
Using Index
/
Create Table ins_insured
    (Id                             Number NOT NULL,
    card_no                        Varchar2(96),
    fio                            Varchar2(384),
    address                        Varchar2(1536),
    phone                          Varchar2(384),
    date_of_birth                  Date,
    contract_id                    Number,
    program_code                   Varchar2(255),
    attached_to                    Varchar2(384),
    contract_start_date            Date,
    contract_finish_date           Date,
    limit_for_all_family           Varchar2(1),
    sex                            Varchar2(40),
    created_by                     Number,
    created                        Date,
    updated_by                     Number,
    updated                        Date,
    orig_ref_id                    Number(10,0),
    attached_to_id                 Number,
    city_code                      Number(10,0),
    ins_premium                    Number(10,0))
/



Create Index ins_insured_contract_id On ins_insured
  (
    contract_id                     ASC
  )
/
Create Index ins_insured_attach_to_fk On ins_insured
  (
    attached_to_id                  ASC
  )
/

Alter Table ins_insured
Add Constraint ins_insured_pk Primary Key (Id)
Using Index
/


Alter Table ins_insured
Add Constraint ins_insured_attach_to_fk Foreign Key (attached_to_id)
References ins_insured (Id)
/
Alter Table ins_insured
Add Constraint ins_insured_contract_id Foreign Key (contract_id)
References ins_contract (Id)
/
Create Table ins_insured_category
    (Id                             Number,
    insured_id                     Number,
    contract_id                    Number,
    program_code                   Varchar2(255),
    category_code                  Varchar2(768),
    amount                         Number(19,2),
    isunion                        Varchar2(1),
    created_by                     Number,
    created                        Date,
    updated_by                     Number,
    updated                        Date,
    orig_ref_id                    Number(10,0))
/



Create Index insured_cat_contract_id On ins_insured_category
  (
    contract_id                     ASC
  )
/


Alter Table ins_insured_category
Add Constraint insured_cat_contract_id Foreign Key (contract_id)
References ins_contract (Id)
/
Create Table ins_insured_filter
    (user_id                        Number,
    ins_company                    Varchar2(2000),
    client_company                 Varchar2(2000),
    card_no                        Varchar2(2000),
    fio                            Varchar2(2000),
    all_family                     Varchar2(1),
    show_all                       Varchar2(1))
/



Comment On Column ins_insured_filter.all_family Is 'д) по всей семье'
/
Comment On Column ins_insured_filter.card_no Is 'в) № Карты'
/
Comment On Column ins_insured_filter.client_company Is 'б) клиентская'
/
Comment On Column ins_insured_filter.fio Is 'г) ФИО'
/
Comment On Column ins_insured_filter.ins_company Is 'а) Страх. комп.'
/
Comment On Column ins_insured_filter.show_all Is 'е) Признак "Показать все" - вместо Дата по застраховенного  (не позже чем  6 мес)'
/
Create Table ins_medical_service
    (medical_service_id             Number,
    account_line_id                Number,
    medical_service_code           Varchar2(40),
    amount                         Number(19,2),
    posted_date                    Date,
    orig_service_ref_id            Varchar2(192),
    created_by                     Number,
    created                        Date,
    updated_by                     Number,
    updated                        Date,
    orig_ref_id                    Number(10,0) NOT NULL)
/



Create Index ins_medical_service_fk1 On ins_medical_service
  (
    account_line_id                 ASC
  )
/
Create Index ins_med_serv_posted_date_i On ins_medical_service
  (
    posted_date                     ASC
  )
/


Alter Table ins_medical_service
Add Constraint med_serv_accnt_lines_fk Foreign Key (account_line_id)
References ins_account_lines (account_line_id)
/
Create Table ins_program
    (Id                             Number,
    contract_id                    Number,
    program_code                   Varchar2(255),
    amount                         Number(19,2),
    premium                        Number(19,2),
    isunion                        Varchar2(1),
    created_by                     Number,
    created                        Date,
    updated_by                     Number,
    updated                        Date,
    orig_ref_id                    Number(10,0))
/



Create Table ins_program_category
    (Id                             Number,
    contract_id                    Number,
    program_code                   Varchar2(255),
    category_code                  Varchar2(768),
    amount                         Number(19,2),
    isunion                        Varchar2(1),
    created_by                     Number,
    created                        Date,
    updated_by                     Number,
    updated                        Date,
    orig_ref_id                    Number(10,0))
/



Create Index progr_category_contract_id On ins_program_category
  (
    contract_id                     ASC
  )
/


Alter Table ins_program_category
Add Constraint prog_cat_categoty Foreign Key (contract_id)
References ins_contract (Id)
/
Create Table ins_program_med_service
    (Id                             Number,
    contract_id                    Number,
    program_code                   Varchar2(255),
    category_code                  Varchar2(768),
    medical_service_code           Varchar2(255),
    created_by                     Number,
    created                        Date,
    updated_by                     Number,
    updated                        Date,
    orig_ref_id                    Number(10,0))
/



Create Table ins_service_diagnosis
    (service_diagnosis_id           Number,
    account_line_id                Number,
    diagnosis_code                 Varchar2(40),
    orig_diagnosis_id              Varchar2(192),
    created_by                     Number,
    created                        Date,
    updated_by                     Number,
    updated                        Date,
    orig_ref_id                    Number(10,0) NOT NULL)
/



Create Index ins_serv_diag_accnt_line_id On ins_service_diagnosis
  (
    account_line_id                 ASC
  )
/


Alter Table ins_service_diagnosis
Add Constraint ins_serv_diag_accnt_line_id Foreign Key (account_line_id)
References ins_account_lines (account_line_id)
/
Create Table ins_visit_results
    (visit_result_id                Number,
    visit_id                       Number,
    result_type_id                 Number(10,0),
    visit_time                     Varchar2(15),
    created_by                     Number,
    created                        Date,
    updated_by                     Number,
    updated                        Date,
    orig_ref_id                    Number(10,0))
/



Create Table ins_visits
    (visit_id                       Number,
    visit_date                     Date,
    insured_id                     Number,
    status_id                      Number(10,0),
    visit_type                     Number(10,0),
    age                            Varchar2(96),
    address                        Varchar2(3072),
    phone                          Varchar2(384),
    visit_reason                   Varchar2(768),
    diagnosis_txt                  Varchar2(768),
    comments                       Varchar2(3072),
    created_by                     Number,
    created                        Date,
    updated_by                     Number,
    updated                        Date,
    orig_ref_id                    Number(10,0))
/

