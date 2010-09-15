Create Or Replace Package exp_address_pkg As
   Procedure p_ins_upd (
      p_orig_ref_id    In Out   Number
     ,p_company        In Out   Varchar2
     ,p_address1       In Out   Varchar2
     ,p_address2       In Out   Varchar2
     ,p_city           In Out   Varchar2
     ,p_country        In Out   Varchar2
     ,p_main_address   In Out   Number
   );

   Procedure p_delete (
      p_orig_ref_id    In Out   Number
     ,p_company        In Out   Varchar2
     ,p_address1       In Out   Varchar2
     ,p_address2       In Out   Varchar2
     ,p_city           In Out   Varchar2
     ,p_country        In Out   Varchar2
     ,p_main_address   In Out   Number
   );
End exp_address_pkg;
/

Create Or Replace Package Body exp_address_pkg As
   Procedure p_ins_upd (
      p_orig_ref_id    In Out   Number
     ,p_company        In Out   Varchar2
     ,p_address1       In Out   Varchar2
     ,p_address2       In Out   Varchar2
     ,p_city           In Out   Varchar2
     ,p_country        In Out   Varchar2
     ,p_main_address   In Out   Number
   ) Is
   Begin
      Update ins.exp_address
         Set company = p_company
            ,address1 = p_address1
            ,address2 = p_address2
            ,city = p_city
            ,country = p_country
            ,main_address = p_main_address
       Where orig_ref_id = p_orig_ref_id;

      If Sql%Rowcount = 0 Then
         Select main_sq.Nextval
           Into p_orig_ref_id
           From DUAL;

         Insert Into ins.exp_address
                     (orig_ref_id, company, address1, address2, city, country, main_address)
              Values (p_orig_ref_id, p_company, p_address1, p_address2, p_city, p_country, p_main_address);
      End If;
   End p_ins_upd;

   Procedure p_delete (
      p_orig_ref_id    In Out   Number
     ,p_company        In Out   Varchar2
     ,p_address1       In Out   Varchar2
     ,p_address2       In Out   Varchar2
     ,p_city           In Out   Varchar2
     ,p_country        In Out   Varchar2
     ,p_main_address   In Out   Number
   ) Is
   Begin
      Delete From ins.exp_address
            Where orig_ref_id = p_orig_ref_id;
   End p_delete;
End exp_address_pkg;
/

Create Or Replace Package exp_company_pkg As
   Procedure p_ins_upd (
      p_orig_ref_id    In Out   Number
     ,p_company_name   In Out   Varchar2
     ,p_short_name     In Out   Varchar2
     ,p_company_type   In Out   Varchar2
     ,p_created_by     In Out   Varchar2
     ,p_created        In Out   Varchar2
     ,p_updated_by     In Out   Varchar2
     ,p_updated        In Out   Varchar2
   );

   Procedure p_delete (
      p_orig_ref_id    In Out   Number
     ,p_company_name   In Out   Varchar2
     ,p_short_name     In Out   Varchar2
     ,p_company_type   In Out   Varchar2
     ,p_created_by     In Out   Varchar2
     ,p_created        In Out   Varchar2
     ,p_updated_by     In Out   Varchar2
     ,p_updated        In Out   Varchar2
   );
End exp_company_pkg;
/

Create Or Replace Package Body exp_company_pkg As
   Procedure p_ins_upd (
      p_orig_ref_id    In Out   Number
     ,p_company_name   In Out   Varchar2
     ,p_short_name     In Out   Varchar2
     ,p_company_type   In Out   Varchar2
     ,p_created_by     In Out   Varchar2
     ,p_created        In Out   Varchar2
     ,p_updated_by     In Out   Varchar2
     ,p_updated        In Out   Varchar2
   ) Is
   Begin
      Update ins.exp_company
         Set company_name = p_company_name
            ,short_name = p_short_name
            ,company_type = p_company_type
            ,created_by = p_created_by
            ,created = p_created
            ,updated_by = p_updated_by
            ,updated = p_updated
       Where orig_ref_id = p_orig_ref_id;

      If Sql%Rowcount = 0 Then
         Select main_sq.Nextval
           Into p_orig_ref_id
           From DUAL;

         Insert Into ins.exp_company
                     (orig_ref_id, company_name, short_name, company_type, created_by, created, updated_by, updated)
              Values (p_orig_ref_id, p_company_name, p_short_name, p_company_type, p_created_by, p_created
                     ,p_updated_by, p_updated);
      End If;
   End p_ins_upd;

   Procedure p_delete (
      p_orig_ref_id    In Out   Number
     ,p_company_name   In Out   Varchar2
     ,p_short_name     In Out   Varchar2
     ,p_company_type   In Out   Varchar2
     ,p_created_by     In Out   Varchar2
     ,p_created        In Out   Varchar2
     ,p_updated_by     In Out   Varchar2
     ,p_updated        In Out   Varchar2
   ) Is
   Begin
      Delete From ins.exp_company
            Where orig_ref_id = p_orig_ref_id;
   End p_delete;
End exp_company_pkg;
/

Create Or Replace Package exp_contract_pkg As
   Procedure p_delete (
      p_orig_ref_id      In Out   Number
     ,p_contract_no      In Out   Varchar2
     ,p_descr            In Out   Varchar2
     ,p_created_by       In Out   Varchar2
     ,p_created          In Out   Varchar2
     ,p_updated_by       In Out   Varchar2
     ,p_updated          In Out   Varchar2
     ,p_client_company   In Out   Varchar2
     ,p_insur_company    In Out   Varchar2
     ,p_summ             In Out   Number
     ,p_currency         In Out   Varchar2
     ,p_contract_date    In Out   Varchar2
     ,p_date_start       In Out   Varchar2
     ,p_date_finish      In Out   Varchar2
   );

   Procedure p_ins_upd (
      p_orig_ref_id      In Out   Number
     ,p_contract_no      In Out   Varchar2
     ,p_descr            In Out   Varchar2
     ,p_created_by       In Out   Varchar2
     ,p_created          In Out   Varchar2
     ,p_updated_by       In Out   Varchar2
     ,p_updated          In Out   Varchar2
     ,p_client_company   In Out   Varchar2
     ,p_insur_company    In Out   Varchar2
     ,p_summ             In Out   Number
     ,p_currency         In Out   Varchar2
     ,p_contract_date    In Out   Varchar2
     ,p_date_start       In Out   Varchar2
     ,p_date_finish      In Out   Varchar2
   );
End exp_contract_pkg;
/

Create Or Replace Package Body exp_contract_pkg As
   Procedure p_ins_upd (
      p_orig_ref_id      In Out   Number
     ,p_contract_no      In Out   Varchar2
     ,p_descr            In Out   Varchar2
     ,p_created_by       In Out   Varchar2
     ,p_created          In Out   Varchar2
     ,p_updated_by       In Out   Varchar2
     ,p_updated          In Out   Varchar2
     ,p_client_company   In Out   Varchar2
     ,p_insur_company    In Out   Varchar2
     ,p_summ             In Out   Number
     ,p_currency         In Out   Varchar2
     ,p_contract_date    In Out   Varchar2
     ,p_date_start       In Out   Varchar2
     ,p_date_finish      In Out   Varchar2
   ) Is
   Begin
      Update ins.exp_contract
         Set contract_no = p_contract_no
            ,descr = p_descr
            ,created_by = p_created_by
            ,created = p_created
            ,updated_by = p_updated_by
            ,updated = p_updated
            ,client_company = p_client_company
            ,insur_company = p_insur_company
            ,summ = p_summ
            ,currency = p_currency
            ,contract_date = p_contract_date
            ,date_start = p_date_start
            ,date_finish = p_date_finish
       Where orig_ref_id = p_orig_ref_id;

      If Sql%Rowcount = 0 Then
         Select main_sq.Nextval
           Into p_orig_ref_id
           From DUAL;

         Insert Into ins.exp_contract
                     (orig_ref_id, contract_no, descr, created_by, created, updated_by, updated, client_company
                     ,insur_company, summ, currency, contract_date, date_start, date_finish)
              Values (p_orig_ref_id, p_contract_no, p_descr, p_created_by, p_created, p_updated_by, p_updated
                     ,p_client_company, p_insur_company, p_summ, p_currency, p_contract_date, p_date_start
                     ,p_date_finish);
      End If;
   End p_ins_upd;

   Procedure p_delete (
      p_orig_ref_id      In Out   Number
     ,p_contract_no      In Out   Varchar2
     ,p_descr            In Out   Varchar2
     ,p_created_by       In Out   Varchar2
     ,p_created          In Out   Varchar2
     ,p_updated_by       In Out   Varchar2
     ,p_updated          In Out   Varchar2
     ,p_client_company   In Out   Varchar2
     ,p_insur_company    In Out   Varchar2
     ,p_summ             In Out   Number
     ,p_currency         In Out   Varchar2
     ,p_contract_date    In Out   Varchar2
     ,p_date_start       In Out   Varchar2
     ,p_date_finish      In Out   Varchar2
   ) Is
   Begin
      Delete From ins.exp_contract
            Where orig_ref_id = p_orig_ref_id;
   End p_delete;
End exp_contract_pkg;
/

Create Or Replace Package exp_lookup_attributes_pkg As
   Procedure p_ins_upd (
      p_lookup_code      In Out   Varchar2
     ,p_attribute_code   In Out   Varchar2
     ,p_attribute_name   In Out   Varchar2
     ,p_attribute_type   In Out   Varchar2
   );

   Procedure p_delete (
      p_lookup_code      In Out   Varchar2
     ,p_attribute_code   In Out   Varchar2
     ,p_attribute_name   In Out   Varchar2
     ,p_attribute_type   In Out   Varchar2
   );
End exp_lookup_attributes_pkg;
/

Create Or Replace Package Body exp_lookup_attributes_pkg As
   Procedure p_ins_upd (
      p_lookup_code      In Out   Varchar2
     ,p_attribute_code   In Out   Varchar2
     ,p_attribute_name   In Out   Varchar2
     ,p_attribute_type   In Out   Varchar2
   ) Is
   Begin
      Update ins.exp_lookup_attributes
         Set attribute_name = p_attribute_name
       Where lookup_code = p_lookup_code
         And attribute_code = p_attribute_code
         And attribute_type = p_attribute_type;

      If Sql%Rowcount = 0 Then
         Insert Into ins.exp_lookup_attributes
                     (lookup_code, attribute_code, attribute_name, attribute_type)
              Values (p_lookup_code, p_attribute_code, p_attribute_name, p_attribute_type);
      End If;
   End p_ins_upd;

   Procedure p_delete (
      p_lookup_code      In Out   Varchar2
     ,p_attribute_code   In Out   Varchar2
     ,p_attribute_name   In Out   Varchar2
     ,p_attribute_type   In Out   Varchar2
   ) Is
   Begin
      Delete From ins.exp_lookup_attributes
            Where lookup_code = p_lookup_code
              And attribute_code = p_attribute_code
              And attribute_type = p_attribute_type;
   End p_delete;
End exp_lookup_attributes_pkg;
/

Create Or Replace Package exp_lookup_values_pkg As
   Procedure p_delete (
      p_lookup_code            In Out   Varchar2
     ,p_lookup_value_code      In Out   Varchar2
     ,p_lookup_display_value   In Out   Varchar2
   );

   Procedure p_ins_upd (
      p_lookup_code            In Out   Varchar2
     ,p_lookup_value_code      In Out   Varchar2
     ,p_lookup_display_value   In Out   Varchar2
   );
End exp_lookup_values_pkg;
/

Create Or Replace Package Body exp_lookup_values_pkg As
   Procedure p_ins_upd (
      p_lookup_code            In Out   Varchar2
     ,p_lookup_value_code      In Out   Varchar2
     ,p_lookup_display_value   In Out   Varchar2
   ) Is
   Begin
      Update ins.exp_lookup_values
         Set lookup_display_value = p_lookup_display_value
       Where lookup_code = p_lookup_code
         And lookup_value_code = p_lookup_value_code;

      If Sql%Rowcount = 0 Then
         Insert Into ins.exp_lookup_values
                     (lookup_code, lookup_value_code, lookup_display_value)
              Values (p_lookup_code, p_lookup_value_code, p_lookup_display_value);
      End If;
   End p_ins_upd;

   Procedure p_delete (
      p_lookup_code            In Out   Varchar2
     ,p_lookup_value_code      In Out   Varchar2
     ,p_lookup_display_value   In Out   Varchar2
   ) Is
   Begin
      Delete From ins.exp_lookup_values
            Where lookup_code = p_lookup_code
              And lookup_value_code = p_lookup_value_code;
   End p_delete;
End exp_lookup_values_pkg;
/

Create Or Replace Package exp_lookups_pkg As
   Procedure p_delete (p_lookup_code In Out Varchar2, p_lookup_name In Out Varchar2);

   Procedure p_ins_upd (p_lookup_code In Out Varchar2, p_lookup_name In Out Varchar2);
End exp_lookups_pkg;
/

Create Or Replace Package Body exp_lookups_pkg As
   Procedure p_ins_upd (p_lookup_code In Out Varchar2, p_lookup_name In Out Varchar2) Is
   Begin
      Update ins.exp_lookups
         Set lookup_name = p_lookup_name
       Where lookup_code = p_lookup_code;

      If Sql%Rowcount = 0 Then
         Insert Into ins.exp_lookups
                     (lookup_code, lookup_name)
              Values (p_lookup_code, p_lookup_name);
      End If;
   End p_ins_upd;

   Procedure p_delete (p_lookup_code In Out Varchar2, p_lookup_name In Out Varchar2) Is
   Begin
      Delete From ins.exp_lookups
            Where lookup_code = p_lookup_code;
   End p_delete;
End exp_lookups_pkg;
/

Create Or Replace Package exp_user_pkg As
   Procedure p_delete (p_fio In Out Varchar2, p_sys_name In Out Varchar2, p_orig_ref_id In Out Number);

   Procedure p_ins_upd (p_fio In Out Varchar2, p_sys_name In Out Varchar2, p_orig_ref_id In Out Number);
End exp_user_pkg;
/

Create Or Replace Package Body exp_user_pkg As
   Procedure p_ins_upd (p_fio In Out Varchar2, p_sys_name In Out Varchar2, p_orig_ref_id In Out Number) Is
   Begin
      Update ins.exp_user
         Set fio = p_fio
            ,sys_name = p_sys_name
       Where orig_ref_id = p_orig_ref_id;

      If Sql%Rowcount = 0 Then
         Select main_sq.Nextval
           Into p_orig_ref_id
           From DUAL;

         Insert Into ins.exp_user
                     (fio, sys_name, orig_ref_id)
              Values (p_fio, p_sys_name, p_orig_ref_id);
      End If;
   End p_ins_upd;

   Procedure p_delete (p_fio In Out Varchar2, p_sys_name In Out Varchar2, p_orig_ref_id In Out Number) Is
   Begin
      Delete From ins.exp_user
            Where orig_ref_id = p_orig_ref_id;
   End p_delete;
End exp_user_pkg;
/

Create Or Replace Package ins_company_rep_pkg As
   Type report_r Is Record (
      card_no                 Varchar2 (2000)
     ,fio                     Varchar2 (2000)
     ,clnt_company_name       Varchar2 (2000)
     ,ins_company_name        Varchar2 (2000)
     ,posting_date            Date
     ,visit_date              Date
     ,is_reserve_flag         Varchar2 (10)
     ,account_num             Varchar2 (2000)
     ,supplier_company_name   Varchar2 (2000)
     ,amount                  Number
     ,discount                Varchar2 (2000)
     ,amount_w_discnt         Number
     ,posted_date             Date
     ,med_cat                 Varchar2 (2000)
     ,med_serv                Varchar2 (2000)
     ,diagnosis               Varchar2 (2000)
     ,city                    Varchar2 (2000)
     ,program                 Varchar2 (2000)
   );

   Type report_t Is Table Of report_r;

   Function get_lookup (p_type Varchar2, p_code Number)
      Return Varchar2;

   Function get_report_xml (
      p_start_date          In   Date
     ,p_end_date            In   Date
     ,p_client_company_id   In   Varchar2
     ,p_ins_company_id      In   Varchar2
     ,p_card_no             In   Varchar2
     ,p_fio                 In   Varchar2
     ,p_hide_reserve_flag   In   Varchar2
     ,p_city_code           In   Varchar2
     ,p_med_category_code   In   Varchar2
     ,p_w_group_flag        In   Varchar2
   )
      Return Xmltype;

   Procedure generate_report (
      p_start_date          In       Date
     ,p_end_date            In       Date
     ,p_client_company_id   In       Varchar2
     ,p_ins_company_id      In       Varchar2
     ,p_card_no             In       Varchar2
     ,p_fio                 In       Varchar2
     ,p_hide_reserve_flag   In       Varchar2
     ,p_city_code           In       Varchar2
     ,p_med_category_code   In       Varchar2
     ,p_w_group_flag        In       Varchar2
     ,p_rep_data            Out      Clob
   );

   Function get_report_table (
      p_start_date          In   Date
     ,p_end_date            In   Date
     ,p_client_company_id   In   Varchar2
     ,p_ins_company_id      In   Varchar2
     ,p_card_no             In   Varchar2
     ,p_fio                 In   Varchar2
     ,p_hide_reserve_flag   In   Varchar2
     ,p_city_code           In   Varchar2
     ,p_med_category_code   In   Varchar2
   )
      Return report_t Pipelined;
End ins_company_rep_pkg;
/

Grant Execute On ins_company_rep_pkg To fc22
/

Create Or Replace Package Body ins_company_rep_pkg As
   Type lookups_t Is Table Of Varchar2 (2000)
      Index By Binary_integer;

   g_diag           lookups_t;                                                                                      --1
   g_med_cat_name   lookups_t;                                                                                      --2
   g_med_service    lookups_t;                                                                                      --3
   g_company        lookups_t;                                                                                      --4
   g_city           lookups_t;                                                                                      --5
   g_program        lookups_t;                                                                                      --6
   g_med_cat_id     lookups_t;                                                                                      --7

/*==================================================*/
   Function get_lookup (p_type In Varchar2, p_code In Number)
      Return Varchar2 Is
   Begin
      Return Case
         When p_type = 1 Then g_diag (p_code)
         When p_type = 2 Then g_med_cat_name (p_code)
         When p_type = 3 Then g_med_service (p_code)
         When p_type = 4 Then g_company (p_code)
         When p_type = 5 Then g_city (NVL (p_code, 1))
         When p_type = 6 Then g_program (p_code)
         When p_type = 7 Then g_med_cat_id (p_code)
      End;
   Exception
      When Others Then
         Return Case
            When p_type = 1 Then SQLERRM
            When p_type = 2 Then SQLERRM
            When p_type = 3 Then SQLERRM
            When p_type = 4 Then SQLERRM
            When p_type = 5 Then Null
            When p_type = 6 Then SQLERRM
            When p_type = 7 Then Null
         End;
   End get_lookup;

/*==================================================*/
   Function get_report_table (
      p_start_date          In   Date
     ,p_end_date            In   Date
     ,p_client_company_id   In   Varchar2
     ,p_ins_company_id      In   Varchar2
     ,p_card_no             In   Varchar2
     ,p_fio                 In   Varchar2
     ,p_hide_reserve_flag   In   Varchar2
     ,p_city_code           In   Varchar2
     ,p_med_category_code   In   Varchar2
   )
      Return report_t Pipelined Is
      l_start_date   Date            := NVL (p_start_date, To_date ('01.01.1900', 'dd.mm.yyyy'));
      l_end_date     Date            := NVL (p_end_date, To_date ('01.01.4000', 'dd.mm.yyyy'));
      l_card_no      Varchar2 (2000) := p_card_no || '%';
      l_fio          Varchar2 (2000) := p_fio || '%';
      --
      l_res_r        report_r;
   Begin
      For cr In (With t As
                      (
                         Select i.card_no, i.fio, i.city_code, i.program_code, ic.client_company_id, ic.ins_company_id
                               ,al.posting_date, al.visit_date, al.discount, al.is_reserve_flag, al.account_num
                               ,al.company_id As supplier_company_id, ms.amount, ms.posted_date
                               ,ms.medical_service_code
                               ,ins_company_rep_pkg.get_lookup (1, diag.diagnosis_code) As diagnosis
                           From ins_insured i                                                              /*On 1 = 1*/
                                             Join ins_contract ic On i.contract_id = ic.Id
                                Join ins_account_lines al On i.Id = al.insured_id
                                Join ins_medical_service ms On al.account_line_id = ms.account_line_id
                                Join ins_service_diagnosis diag On al.account_line_id = diag.account_line_id
                          Where 1 = 1
                            And NVL (i.city_code || '', '1') = NVL (p_city_code, NVL (i.city_code || '', '1'))
                            And LOWER (i.card_no) Like LOWER (l_card_no)
                            And LOWER (i.fio) Like LOWER (l_fio)
                            And al.posting_date Between l_start_date And l_end_date
                            And NVL (al.is_reserve_flag, 'N') =
                                                   DECODE (p_hide_reserve_flag
                                                          ,'Y', 'N'
                                                          ,NVL (al.is_reserve_flag, 'N')
                                                          )
                            And NVL (p_client_company_id, ic.client_company_id) = ic.client_company_id
                            And NVL (p_ins_company_id, ic.ins_company_id) = ic.ins_company_id)
                 Select   t.card_no, t.fio, t.city_code, t.program_code, t.client_company_id, t.ins_company_id
                         ,t.posting_date, t.visit_date, t.discount, t.is_reserve_flag, t.account_num
                         ,t.supplier_company_id, t.amount, t.posted_date, t.medical_service_code
                         ,stragg (t.diagnosis) As diagnosis
                     From t
                    Where (   p_med_category_code Is Null
                           Or p_med_category_code = get_lookup (7, t.medical_service_code)
                          )
                 Group By t.card_no
                         ,t.fio
                         ,t.city_code
                         ,t.program_code
                         ,t.client_company_id
                         ,t.ins_company_id
                         ,t.posting_date
                         ,t.visit_date
                         ,t.discount
                         ,t.is_reserve_flag
                         ,t.account_num
                         ,t.supplier_company_id
                         ,t.amount
                         ,t.posted_date
                         ,t.medical_service_code) Loop
         l_res_r.card_no                  := cr.card_no;
         l_res_r.fio                      := cr.fio;
         l_res_r.clnt_company_name        := get_lookup (4, cr.client_company_id);
         l_res_r.ins_company_name         := get_lookup (4, cr.ins_company_id);
         l_res_r.posting_date             := cr.posting_date;
         l_res_r.visit_date               := cr.visit_date;
         l_res_r.is_reserve_flag          := cr.is_reserve_flag;
         l_res_r.account_num              := cr.account_num;
         l_res_r.supplier_company_name    := get_lookup (4, cr.supplier_company_id);
         l_res_r.discount                 := cr.discount;
         l_res_r.amount                   := cr.amount;
         l_res_r.amount_w_discnt          := cr.amount * (100 - NVL (cr.discount, 0)) / 100;
         l_res_r.posted_date              := cr.posted_date;
         l_res_r.med_cat                  := get_lookup (2, cr.medical_service_code);
         l_res_r.med_serv                 := get_lookup (3, cr.medical_service_code);
         l_res_r.diagnosis                := cr.diagnosis;
         l_res_r.city                     := get_lookup (5, cr.city_code);
         l_res_r.program                  := get_lookup (6, cr.program_code);
         Pipe Row (l_res_r);
      End Loop;

      Return;
   End get_report_table;

   Function get_report_xml (
      p_start_date          In   Date
     ,p_end_date            In   Date
     ,p_client_company_id   In   Varchar2
     ,p_ins_company_id      In   Varchar2
     ,p_card_no             In   Varchar2
     ,p_fio                 In   Varchar2
     ,p_hide_reserve_flag   In   Varchar2
     ,p_city_code           In   Varchar2
     ,p_med_category_code   In   Varchar2
     ,p_w_group_flag        In   Varchar2
   )
      Return Xmltype Is
      l_res   Xmltype;
   Begin
      --Select Xmltype (Cursor (Select   *  From all_users Where username Like 'SYS%' Order By username Desc)).getClobVal () As xml From DUAL;
      With prms As
           (
              Select XMLELEMENT
                        ("PARAM_VALS"
                        ,xmlattributes (TO_CHAR (p_start_date, 'dd.mm.yyyy') As p_start_date
                                       ,TO_CHAR (p_end_date, 'dd.mm.yyyy') As p_end_date
                                       ,Case
                                           When p_client_company_id Is Null Then 'Все'
                                           Else get_lookup (4, p_client_company_id)
                                        End As p_client_company_name
                                       ,Case
                                           When p_ins_company_id Is Null Then 'Все'
                                           Else get_lookup (4, p_ins_company_id)
                                        End As p_ins_company_name
                                       ,NVL (p_card_no, 'Все') As p_card_no1
                                       ,NVL (p_fio, 'Все') As p_fio
                                       ,DECODE (p_hide_reserve_flag, 'N', 'Да', 'Нет') As p_hide_reserve_flag
                                       ,DECODE (p_city_code, Null, 'Все', get_lookup (5, p_city_code)) As p_city_code
                                       ,DECODE (p_med_category_code
                                               ,Null, 'Все'
                                               , (Select cat.lookup_display_value
                                                    From fc22.lookup_values cat
                                                   Where cat.lookup_code = 'INS_MEDICAL_SERVICE_CATEGORY'
                                                     And cat.lookup_value_code = p_med_category_code)
                                               ) As p_med_category_code
                                       ,p_w_group_flag As p_w_group_flag
                                       )
                        ) As val
                From DUAL)
          ,t As
           (
              Select ROW_NUMBER () Over (Order By t.fio) rn, t.*                                                      --
                    ,Sum (t.amount) Over (Partition By card_no) As ins_amnt
                    ,Sum (t.amount_w_discnt) Over (Partition By card_no) As ins_amount_w_discnt
                    ,Sum (t.amount) Over (Partition By clnt_company_name) As client_amnt
                    ,Sum (t.amount_w_discnt) Over (Partition By clnt_company_name) As client_amount_w_discnt
                From Table (ins_company_rep_pkg.get_report_table (p_start_date
                                                                 ,p_end_date
                                                                 ,p_client_company_id
                                                                 ,p_ins_company_id
                                                                 ,p_card_no
                                                                 ,p_fio
                                                                 ,p_hide_reserve_flag
                                                                 ,p_city_code
                                                                 ,p_med_category_code
                                                                 )
                           ) t)
          ,totals_i As
           (Select   med_cat, Sum (t.amount) As cat_amnt, Sum (t.amount_w_discnt) cat_amount_w_discnt
                From t
            Group By med_cat)
          ,totals As
           (
              Select XMLELEMENT
                               ("TOTALS"
                               ,xmlattributes (Sum (cat_amnt) As "AMOUNT"
                                              ,Sum (cat_amount_w_discnt) As "AMOUNT_W_DISCNT")
                               ,XMLAGG (XMLELEMENT ("MED_CAT"
                                                   ,xmlattributes (med_cat As "NAME"
                                                                  ,cat_amnt As "AMOUNT"
                                                                  ,cat_amount_w_discnt As "AMOUNT_W_DISCNT"
                                                                  )
                                                   ) Order By med_cat
                                       )
                               ) val
                From totals_i)
/****************/
           ,details As
            (
               Select XMLELEMENT
                         ("ROWSET"
                         ,XMLAGG (XMLELEMENT ("ROW"
                                             ,xmlattributes (rn
                                                            ,card_no
                                                            ,fio
                                                            ,clnt_company_name
                                                            ,ins_company_name
                                                            ,posting_date
                                                            ,visit_date
                                                            ,is_reserve_flag
                                                            ,account_num
                                                            ,supplier_company_name
                                                            ,posted_date
                                                            ,med_cat
                                                            ,med_serv
                                                            ,diagnosis
                                                            ,city
                                                            ,program
                                                            ,discount
                                                            ,amount
                                                            ,amount_w_discnt
                                                            ,ins_amnt
                                                            ,ins_amount_w_discnt
                                                            ,client_amnt
                                                            ,client_amount_w_discnt
                                                            )
                                             ) Order By fio, posting_date
                                 )
                         ) /*.getclobval () */ As val
                 From t)
/****************/
      Select
--XMLROOT (
             XMLELEMENT ("ROOT", (Select val
                                    From prms), (Select val
                                                   From totals), (Select val
                                                                    From details))
--, VERSION '1.0', STANDALONE YES)
      Into   l_res
        From DUAL;

      Return l_res;
   End get_report_xml;

   Procedure generate_report (
      p_start_date          In       Date
     ,p_end_date            In       Date
     ,p_client_company_id   In       Varchar2
     ,p_ins_company_id      In       Varchar2
     ,p_card_no             In       Varchar2
     ,p_fio                 In       Varchar2
     ,p_hide_reserve_flag   In       Varchar2
     ,p_city_code           In       Varchar2
     ,p_med_category_code   In       Varchar2
     ,p_w_group_flag        In       Varchar2
     ,p_rep_data            Out      Clob
   ) Is
   Begin
--      raise_application_error (-20001, p_start_date || '>>' || p_end_date || '>>' || p_client_company_id);
      p_rep_data    :=
         get_report_xml (p_start_date
                        ,p_end_date
                        ,p_client_company_id
                        ,p_ins_company_id
                        ,p_card_no
                        ,p_fio
                        ,p_hide_reserve_flag
                        ,p_city_code
                        ,p_med_category_code
                        ,p_w_group_flag
                        ).getClobVal ();
   End generate_report;
/*==================================================*/
Begin
/***********************/
   For cr In (Select lv.lookup_value_code, lv.lookup_display_value
                From fc22.lookup_values lv
               Where lv.lookup_code = 'INS_DIAGNOSIS') Loop
      g_diag (cr.lookup_value_code)    := cr.lookup_display_value;
   End Loop;

/***********************/
   For cr In (Select lv.lookup_value_code, lv.lookup_display_value
                From fc22.lookup_values lv
               Where lv.lookup_code = 'INS_CITY') Loop
      g_city (cr.lookup_value_code)    := cr.lookup_display_value;
   End Loop;

/***********************/
   For cr In (Select lv.lookup_value_code, lv.lookup_display_value
                From fc22.lookup_values lv
               Where lv.lookup_code = 'INS_PROGRAM') Loop
      g_program (cr.lookup_value_code)    := cr.lookup_display_value;
   End Loop;

/***********************/
   For cr In (With cat As
                   (Select cat.lookup_value_code As med_category_id, cat.lookup_display_value As med_category_name
                      From fc22.lookup_values cat
                     Where cat.lookup_code = 'INS_MEDICAL_SERVICE_CATEGORY')
                  ,med_serv As
                   (
                      Select lv1.lookup_value_code As med_serv_code, lv1.lookup_display_value As med_serv_name
                            ,lav.attribute_value_number As med_category_id
                        From fc22.lookup_values lv1, fc22.lookup_attribute_values lav
                       Where lv1.lookup_code = 'INS_MEDICAL_SERVICE'
                         And lv1.lookup_code = lav.lookup_code
                         And lv1.lookup_value_code = lav.lookup_value_code
                         And lav.attribute_code = 'CATEGORY_ID')
              Select m.med_serv_code, c.med_category_id, c.med_category_name, m.med_serv_name
                From cat c, med_serv m
               Where m.med_category_id = c.med_category_id) Loop
      g_med_cat_name (cr.med_serv_code)    := cr.med_category_name;
      g_med_service (cr.med_serv_code)     := cr.med_serv_name;
      g_med_cat_id (cr.med_serv_code)      := cr.med_category_id;
   End Loop;

   For cr In (Select a.Id, a.company_name
                From ins_company a) Loop
      g_company (cr.Id)    := cr.company_name;
   End Loop;
End ins_company_rep_pkg;
/

Create Or Replace Package ins_contract_pkg As
   Procedure p_ins_upd (
      p_contract_no         In Out   Varchar2
     ,p_descr               In Out   Varchar2
     ,p_created_by          In Out   Number
     ,p_created             In Out   Varchar2
     ,p_updated_by          In Out   Number
     ,p_updated             In Out   Varchar2
     ,p_client_company_id   In Out   Number
     ,p_ins_company_id      In Out   Number
     ,p_summ                In Out   Number
     ,p_currency_id         In Out   Varchar2
     ,p_contract_date       In Out   Varchar2
     ,p_date_start          In Out   Varchar2
     ,p_date_finish         In Out   Varchar2
     ,p_id                  In Out   Number
     ,p_orig_ref_id         In Out   Number
   );

   Procedure p_delete (p_id In Out Number);
End ins_contract_pkg;
/

Create Or Replace Package Body ins_contract_pkg As
   Procedure p_ins_upd (
      p_contract_no         In Out   Varchar2
     ,p_descr               In Out   Varchar2
     ,p_created_by          In Out   Number
     ,p_created             In Out   Varchar2
     ,p_updated_by          In Out   Number
     ,p_updated             In Out   Varchar2
     ,p_client_company_id   In Out   Number
     ,p_ins_company_id      In Out   Number
     ,p_summ                In Out   Number
     ,p_currency_id         In Out   Varchar2
     ,p_contract_date       In Out   Varchar2
     ,p_date_start          In Out   Varchar2
     ,p_date_finish         In Out   Varchar2
     ,p_id                  In Out   Number
     ,p_orig_ref_id         In Out   Number
   ) Is
   Begin
      Update ins_contract
         Set contract_no = p_contract_no
            ,descr = p_descr
            ,created_by = p_created_by
            ,created = p_created
            ,updated_by = p_updated_by
            ,updated = p_updated
            ,client_company_id = p_client_company_id
            ,ins_company_id = p_ins_company_id
            ,summ = p_summ
            ,currency_id = p_currency_id
            ,contract_date = p_contract_date
            ,date_start = p_date_start
            ,date_finish = p_date_finish
            ,Id = p_id
            ,orig_ref_id = p_orig_ref_id
       Where Id = p_id;

      If Sql%Rowcount = 0 Then
         Select main_sq.Nextval
           Into p_id
           From DUAL;

         Insert Into ins_contract
                     (contract_no, descr, created_by, created, updated_by, updated, client_company_id, ins_company_id
                     ,summ, currency_id, contract_date, date_start, date_finish, Id, orig_ref_id)
              Values (p_contract_no, p_descr, p_created_by, p_created, p_updated_by, p_updated, p_client_company_id
                     ,p_ins_company_id, p_summ, p_currency_id, p_contract_date, p_date_start, p_date_finish, p_id
                     ,p_orig_ref_id);
      End If;
   End p_ins_upd;

   Procedure p_delete (p_id In Out Number) Is
   Begin
      Delete From ins_contract
            Where Id = p_id;
   End p_delete;
End ins_contract_pkg;
/

Create Or Replace Package ins_ins_account_lines_pkg As
End ins_ins_account_lines_pkg;
/

Create Or Replace Package Body ins_ins_account_lines_pkg As
   Procedure p_ins_upd (
      p_account_id                In Out   Number
     ,p_account_line_id           In Out   Number
     ,p_insured_id                In Out   Number
     ,p_posting_date              In Out   Varchar2
     ,p_visit_date                In Out   Varchar2
     ,p_created_by                In Out   Number
     ,p_discount                  In Out   Number
     ,p_created                   In Out   Varchar2
     ,p_updated_by                In Out   Number
     ,p_updated                   In Out   Varchar2
     ,p_orig_ref_id               In Out   Number
     ,p_is_reserve_flag           In Out   Varchar2
     ,p_service_amount            In Out   Number
     ,p_service_discounted_amnt   In Out   Number
   ) Is
   Begin
      Update ins.ins_account_lines
         Set account_id = p_account_id
            ,account_line_id = p_account_line_id
            ,insured_id = p_insured_id
            ,posting_date = p_posting_date
            ,visit_date = p_visit_date
            ,created_by = p_created_by
            ,discount = p_discount
            ,created = p_created
            ,updated_by = p_updated_by
            ,updated = p_updated
            ,orig_ref_id = p_orig_ref_id
            ,is_reserve_flag = p_is_reserve_flag
       Where account_id = p_account_id
         And account_line_id = p_account_line_id
         And insured_id = p_insured_id
         And posting_date = p_posting_date
         And visit_date = p_visit_date
         And created_by = p_created_by
         And discount = p_discount
         And created = p_created
         And updated_by = p_updated_by
         And updated = p_updated
         And orig_ref_id = p_orig_ref_id
         And is_reserve_flag = p_is_reserve_flag;

      If Sql%Rowcount = 0 Then
         Select main_sq.Nextval
           Into p_account_line_id
           From DUAL;

         Insert Into ins_account_lines
                     (account_id, account_line_id, insured_id, posting_date, visit_date, created_by, discount, created
                     ,updated_by, updated, orig_ref_id, is_reserve_flag)
              Values (p_account_id, p_account_line_id, p_insured_id, p_posting_date, p_visit_date, p_created_by
                     ,p_discount, p_created, p_updated_by, p_updated, p_orig_ref_id, p_is_reserve_flag);
      End If;
   End p_ins_upd;

   Procedure p_delete (
      p_account_id                In Out   Number
     ,p_account_line_id           In Out   Number
     ,p_insured_id                In Out   Number
     ,p_posting_date              In Out   Varchar2
     ,p_visit_date                In Out   Varchar2
     ,p_created_by                In Out   Number
     ,p_discount                  In Out   Number
     ,p_created                   In Out   Varchar2
     ,p_updated_by                In Out   Number
     ,p_updated                   In Out   Varchar2
     ,p_orig_ref_id               In Out   Number
     ,p_is_reserve_flag           In Out   Varchar2
     ,p_service_amount            In Out   Number
     ,p_service_discounted_amnt   In Out   Number
   ) Is
   Begin
      Delete From ins_account_lines
            Where account_id = p_account_id
              And account_line_id = p_account_line_id
              And insured_id = p_insured_id
              And posting_date = p_posting_date
              And visit_date = p_visit_date
              And created_by = p_created_by
              And discount = p_discount
              And created = p_created
              And updated_by = p_updated_by
              And updated = p_updated
              And orig_ref_id = p_orig_ref_id
              And is_reserve_flag = p_is_reserve_flag;
   End p_delete;
End ins_ins_account_lines_pkg;
/

Create Or Replace Package ins_insured_filter_pkg As
   Procedure p_clear_filter (
      p_ins_company      Out   Varchar2
     ,p_client_company   Out   Varchar2
     ,p_card_no          Out   Varchar2
     ,p_fio              Out   Varchar2
     ,p_all_family       Out   Varchar2
     ,p_show_all         Out   Varchar2
   );

   Procedure p_ins_upd (
      p_ins_company      In Out   Varchar2
     ,p_client_company   In Out   Varchar2
     ,p_card_no          In Out   Varchar2
     ,p_fio              In Out   Varchar2
     ,p_all_family       In Out   Varchar2
     ,p_show_all         In Out   Varchar2
   );
End ins_insured_filter_pkg;
/

Create Or Replace Package Body ins_insured_filter_pkg As
   Procedure p_ins_upd (
      p_ins_company      In Out   Varchar2
     ,p_client_company   In Out   Varchar2
     ,p_card_no          In Out   Varchar2
     ,p_fio              In Out   Varchar2
     ,p_all_family       In Out   Varchar2
     ,p_show_all         In Out   Varchar2
   ) As
      l_user_id   Number := fc22.users_pkg.get_user_id ();
   Begin
      --
      Update ins_insured_filter iif
         Set ins_company = p_ins_company
            ,client_company = p_client_company
            ,card_no = p_card_no
            ,fio = p_fio
            ,all_family = p_all_family
            ,show_all = p_show_all
       Where user_id = l_user_id;

      If 0 = Sql%Rowcount Then
         Insert Into ins_insured_filter
                     (user_id, ins_company, client_company, card_no, fio, all_family, show_all)
              Values (l_user_id, p_ins_company, p_client_company, p_card_no, p_fio, p_all_family, p_show_all);
      End If;

      Null;
   End p_ins_upd;

   Procedure p_clear_filter (
      p_ins_company      Out   Varchar2
     ,p_client_company   Out   Varchar2
     ,p_card_no          Out   Varchar2
     ,p_fio              Out   Varchar2
     ,p_all_family       Out   Varchar2
     ,p_show_all         Out   Varchar2
   ) Is
   Begin
      p_ins_company       := Null;
      p_client_company    := Null;
      p_card_no           := Null;
      p_fio               := Null;
      p_all_family        := Null;
      p_show_all          := Null;
--      Raise_application_error (-20001, 'aaaa');
      p_ins_upd (p_ins_company, p_client_company, p_card_no, p_fio, p_all_family, p_show_all);
   End p_clear_filter;
End ins_insured_filter_pkg;
/

Create Or Replace Package ins_insured_pkg As
   Type insured_r Is Record (
      Id                     ins_insured.Id%Type
     ,insured_id             ins_insured.Id%Type
     ,card_no                ins_insured.card_no%Type
     ,fio                    ins_insured.fio%Type
     ,address                ins_insured.address%Type
     ,phone                  ins_insured.phone%Type
     ,date_of_birth          ins_insured.date_of_birth%Type
     ,contract_id            ins_insured.contract_id%Type
     ,program_code           ins_insured.program_code%Type
     ,contract_start_date    ins_insured.contract_start_date%Type
     ,contract_finish_date   ins_insured.contract_finish_date%Type
     ,limit_for_all_family   ins_insured.limit_for_all_family%Type
     ,sex                    ins_insured.sex%Type
     ,attached_to_id         ins_insured.attached_to_id%Type
     ,balance_cat9           Number
     ,balance_cat5           Number
     ,info                   Varchar2 (2000)
     ,created_by             ins_insured.created_by%Type
     ,created                ins_insured.created%Type
     ,updated_by             ins_insured.updated_by%Type
     ,updated                ins_insured.updated%Type
     ,orig_ref_id            ins_insured.orig_ref_id%Type
     ,client_company_name    ins_company.company_name%Type
     ,ins_company_name       ins_company.company_name%Type
     ,contract_no            ins_contract.contract_no%Type
     ,isunion                Varchar2 (10)
     ,city_code              ins_insured.city_code%Type
     ,ins_premium            ins_insured.ins_premium%Type
   );

   Type insured_t Is Table Of insured_r;

   Type insured_family_r Is Record (
      Id                  ins_insured.Id%Type
     ,fio                 ins_insured.fio%Type
     ,card_no             ins_insured.card_no%Type
     ,family_person_id    ins_insured.Id%Type
     ,family_person_fio   ins_insured.fio%Type
     ,family_card_no      ins_insured.card_no%Type
   );

   Type insured_family_t Is Table Of insured_family_r;

   Procedure p_ins_upd (
      p_card_no                In Out   Varchar2
     ,p_fio                    In Out   Varchar2
     ,p_date_of_birth          In Out   Varchar2
     ,p_sex                    In Out   Varchar2
     ,p_phone                  In Out   Varchar2
     ,p_address                In Out   Varchar2
     ,p_attached_to            In Out   Varchar2
     ,p_program_code           In Out   Varchar2
     ,p_contract_id            In Out   Number
     ,p_contract_start_date    In Out   Varchar2
     ,p_contract_finish_date   In Out   Varchar2
     ,p_id                     In Out   Number
     ,p_limit_for_all_family   In Out   Varchar2
     ,p_created_by             In Out   Number
     ,p_created                In Out   Varchar2
     ,p_updated_by             In Out   Number
     ,p_updated                In Out   Varchar2
     ,p_orig_ref_id            In Out   Number
     ,p_attached_to_id         In Out   Number
   );

   Procedure p_delete (p_id In Out Number);

   Function get_ballance_by_insured (
      p_contract_id     Number
     ,p_program_code    Varchar2
     ,p_category_code   Varchar2
     ,p_insured_id      Number
   )
      Return ballance_rec;

   Function get_bal_values_by_insured (
      p_contract_id      Number
     ,p_program_code     Varchar2
     ,p_insured_id       Number
     ,p_category1_code   Varchar2
     ,p_category2_code   Varchar2
   )
      Return Varchar2;

   Function get_ins_list (
      p_fio                   Varchar2 Default Null
     ,p_card_no               Varchar2 Default Null
     ,p_master_form_code      Varchar2 Default Null
     ,p_contract_id           Number Default Null
     ,p_client_company_name   Varchar2 Default Null
     ,p_ins_company_name      Varchar2 Default Null
   )
      Return insured_t Pipelined;

   Function get_insured_w_family_list (
      p_insured_id             Number
     ,p_show_all_family_flag   Varchar2 Default 'Y'
     ,p_fio                    Varchar2 Default Null
     ,p_card_no                Varchar2 Default Null
   )
      Return insured_family_t Pipelined;
End ins_insured_pkg;
/

Grant Execute On ins_insured_pkg To fc22
/

Create Or Replace Package Body ins_insured_pkg As
   Type lookup_t Is Table Of Varchar2 (1000)
      Index By Varchar2 (100);

   g_contract_nums               lookup_t;
   g_contract_client_companies   lookup_t;
   g_contract_ins_companies      lookup_t;
   g_insured_is_union            lookup_t;

   Function get_ins_list (
      p_fio                   Varchar2 Default Null
     ,p_card_no               Varchar2 Default Null
     ,p_master_form_code      Varchar2 Default Null
     ,p_contract_id           Number Default Null
     ,p_client_company_name   Varchar2 Default Null
     ,p_ins_company_name      Varchar2 Default Null
   )
      Return insured_t Pipelined Is
      Type lookup_vals_t Is Table Of fc22.lookup_values.lookup_display_value%Type
         Index By fc22.lookup_values.lookup_value_code%Type;

      Type limit_r Is Record (
         isunion         Varchar2 (10)
        ,category_code   Varchar2 (10)
        ,amount          Number
      );

      Type limits_t Is Table Of limit_r
         Index By Varchar2 (2000);

      l_res             insured_r;
      l_program_codes   lookup_vals_t;
      l_limits          limits_t;
      l_serv_amnts      limits_t;
      l_key             Varchar2 (2000);

      Function get_ballance (p_insured_id Number, p_contract_id Number, p_program_code Varchar2, p_category_code Varchar2)
         Return Number Is
         l_key         Varchar2 (2000);
         l_res         Number          := 0;
         l_serv_amnt   Number          := 0;
      Begin
         l_key    :=
                   Ltrim (p_insured_id || '.' || p_contract_id || '.' || p_program_code || '.' || p_category_code, '.');

         If Not l_limits.Exists (l_key) Then
            l_key    := Ltrim (Null || '.' || p_contract_id || '.' || p_program_code || '.' || p_category_code, '.');
         End If;

         Begin
            l_res    := l_limits (l_key).amount;
         Exception
            When NO_DATA_FOUND Then
               Null;
         End;

         l_key    := Ltrim (p_insured_id || '.' || p_category_code, '.');

         If l_serv_amnts.Exists (l_key) Then
            l_serv_amnt    := l_serv_amnts (l_key).amount;
         End If;

         l_res    := l_res - l_serv_amnt;
         Return l_res;
      End get_ballance;
   Begin
      For cr In (With lv As
                      (Select lv.lookup_value_code As category_code
                         From fc22.lookup_values lv
                        Where lv.lookup_value_code In ('5', '9')
                          And lv.lookup_code = 'INS_MEDICAL_SERVICE_CATEGORY')
                     ,c As
                      (
                         Select ic.insured_id, ic.contract_id, ic.program_code, ic.category_code, ic.amount, ic.isunion
                           From ins_insured_category ic, ins_insured i
                          Where ic.insured_id = i.Id
                            And i.contract_id = NVL (p_contract_id, i.contract_id)
                         Union All
                         Select Null As insured_id, pc.contract_id, pc.program_code, pc.category_code, pc.amount
                               ,pc.isunion
                           From ins_program_category pc)
                 Select   c.insured_id, c.contract_id, c.program_code, c.category_code, c.isunion                      --
                         ,Sum (c.amount) amount
                     From c, lv
                    Where c.category_code = lv.category_code
                 Group By c.insured_id, c.contract_id, c.program_code, c.category_code, c.isunion) Loop
         l_key                             :=
               Ltrim (cr.insured_id || '.' || cr.contract_id || '.' || cr.program_code || '.' || cr.category_code, '.');
         l_limits (l_key).isunion          := cr.isunion;
         l_limits (l_key).category_code    := cr.category_code;
         l_limits (l_key).amount           := cr.amount;
         g_insured_is_union (l_key)        := cr.isunion;
      End Loop;

      For cr In (With t As
                      (Select i.Id, i.limit_for_all_family, i.attached_to_id
                         From ins.ins_insured i
                        Where i.contract_id = NVL (p_contract_id, i.contract_id))
                     ,i As
                      (
                         --сам
                         Select t.Id As insured_id, t.Id As account_line_insured_id
                           From t
                         Union
                         --прикрепленный, его сумма
                         Select b.Id, a.Id
                           From t a, t b
                          Where a.attached_to_id = b.Id
                            And b.limit_for_all_family = 'Y'
                         Union
                         --прикрепленная к родителю сумма
                         Select b.Id, a.attached_to_id
                           From t a, t b
                          Where a.Id = b.Id
                            And b.limit_for_all_family = 'Y'
                            And a.attached_to_id Is Not Null)
                     ,lv As
                      (Select lv.lookup_value_code As category_code
                         From fc22.lookup_values lv
                        Where lv.lookup_value_code In ('5', '9')
                          And lv.lookup_code = 'INS_MEDICAL_SERVICE_CATEGORY')
                 Select   i.insured_id, lv.category_code, Sum ((100 - al.discount) / 100 * ms.amount) As amount
                     From i
                         ,ins.ins_medical_service ms
                         ,ins.ins_account_lines al
                         ,lv
                         ,fc22.lookup_values lv1
                         ,fc22.lookup_attribute_values lav
                    Where lv1.lookup_value_code = ms.medical_service_code
                      And i.account_line_insured_id = al.insured_id
                      And al.account_line_id = ms.account_line_id
                      And lv1.lookup_code = 'INS_MEDICAL_SERVICE'
                      And lv1.lookup_code = lav.lookup_code
                      And lv1.lookup_value_code = lav.lookup_value_code
                      And lav.attribute_code = 'CATEGORY_ID'
                      And lav.attribute_value_number || '' = lv.category_code
                 Group By i.insured_id, lv.category_code) Loop
         l_key                                 := Ltrim (cr.insured_id || '.' || cr.category_code, '.');
         l_serv_amnts (l_key).category_code    := cr.category_code;
         l_serv_amnts (l_key).amount           := cr.amount;
      End Loop;

      For cr In (Select lv.lookup_value_code, lv.lookup_display_value
                   From fc22.lookup_values lv
                  Where lv.lookup_code = 'INS_PROGRAM') Loop
         l_program_codes (cr.lookup_value_code)    := cr.lookup_display_value;
      End Loop;

      For cr In (Select i.Id, i.Id As insured_id, i.card_no, i.fio, i.address, i.phone, i.date_of_birth, i.contract_id
                       ,i.program_code, i.contract_start_date, i.contract_finish_date, i.limit_for_all_family, i.sex
                       ,i.attached_to_id, i.city_code, i.ins_premium
                   --, i.created_by, i.created, i.updated_by, i.updated, i.orig_ref_id
                 From   ins_insured i
                  Where LOWER (i.card_no) Like LOWER (p_card_no || '%')
                    And LOWER (i.fio) Like LOWER (p_fio || '%')
                    And i.contract_id = NVL (p_contract_id, i.contract_id)
/*                    And Exists (
                           Select ic.Id
                             From ins_contract ic, ins_company clnt, ins_company ins
                            Where 1 = 1
                              And i.contract_id = ic.Id
                              And ic.client_company_id = clnt.Id
                              And ic.ins_company_id = ins.Id
                              And LOWER (clnt.company_name) Like LOWER (NVL (p_client_company_name, '%'))
                              And LOWER (ins.company_name) Like LOWER (NVL (p_ins_company_name, '%')))*/
                    And Exists (
                           Select ic.Id
                             From ins_contract ic
                            Where 1 = 1
                              And i.contract_id = ic.Id
                              And NVL (p_client_company_name, ic.client_company_id) = ic.client_company_id
                              And NVL (p_ins_company_name, ic.ins_company_id) = ic.ins_company_id)
                                                                                                  --
               ) Loop
--         l_res.created_by              := cr.created_by;
--         l_res.created                 := cr.created;
--         l_res.updated_by              := cr.updated_by;
--         l_res.updated                 := cr.updated;
--         l_res.orig_ref_id             := cr.orig_ref_id;
         --
         l_res.Id                      := cr.Id;
         l_res.insured_id              := cr.insured_id;
         l_res.card_no                 := cr.card_no;
         l_res.fio                     := cr.fio;
         l_res.address                 := cr.address;
         l_res.phone                   := cr.phone;
         l_res.date_of_birth           := cr.date_of_birth;
         l_res.contract_id             := cr.contract_id;
         l_res.program_code            := cr.program_code;
         l_res.contract_start_date     := cr.contract_start_date;
         l_res.contract_finish_date    := cr.contract_finish_date;
         l_res.limit_for_all_family    := cr.limit_for_all_family;
         l_res.sex                     := cr.sex;
         l_res.attached_to_id          := cr.attached_to_id;
         l_res.info                    := ' (' || TO_CHAR (cr.date_of_birth, 'dd.mm.yyyy') || '). ';
         l_res.info                    :=
                               '№ ' || cr.card_no || ' - ' || cr.fio || l_res.info || l_program_codes (cr.program_code);
         l_res.balance_cat9            := get_ballance (cr.insured_id, cr.contract_id, cr.program_code, '9');
         l_res.balance_cat5            := get_ballance (cr.insured_id, cr.contract_id, cr.program_code, '5');
--
         l_res.client_company_name     := g_contract_client_companies (cr.contract_id);
         l_res.ins_company_name        := g_contract_ins_companies (cr.contract_id);
         l_res.contract_no             := g_contract_nums (cr.contract_id);
         l_res.city_code               := cr.city_code;
         l_res.ins_premium             := cr.ins_premium;
         --
         l_key                         :=
                              Ltrim (cr.insured_id || '.' || cr.contract_id || '.' || cr.program_code || '.' || 9, '.');

         If Not l_limits.Exists (l_key) Then
            l_key    := Ltrim (Null || '.' || cr.contract_id || '.' || cr.program_code || '.' || 9, '.');
         End If;

         Begin
            l_res.isunion    := l_limits (l_key).isunion;
         Exception
            When NO_DATA_FOUND Then
               Null;
         End;

         --
         Pipe Row (l_res);
      End Loop;

      Return;
   End get_ins_list;

   Function get_ballance_by_insured (
      p_contract_id     Number
     ,p_program_code    Varchar2
     ,p_category_code   Varchar2
     ,p_insured_id      Number
   )
      Return ballance_rec Is
      l_program_category_amount    Number;
      l_program_category_isunion   ins.ins_program_category.isunion%Type   := 'N';
      l_result                     ballance_rec
         := ballance_rec (l_program_category_amount
                         ,p_category_code
                         ,l_program_category_isunion
                         ,Null
                         ,Null
                         ,Null
                         ,Null
                         );
/*   Begin
      Begin
         Select pc.amount, pc.isunion
           Into l_result.program_category_amount, l_result.program_is_union
           From ins.ins_program_category pc
          Where pc.contract_id = p_contract_id
            And pc.program_code = p_program_code
            And pc.category_code = p_category_code;
      Exception
         When NO_DATA_FOUND Then
            Null;
      End;

      Begin
         Select ic.amount, ic.isunion
           Into l_result.ins_category_amount, l_result.ins_is_union
           From ins.ins_insured_category ic
          Where ic.contract_id = p_contract_id
            And ic.program_code = p_program_code
            And ic.category_code = p_category_code
            And ic.insured_id = p_insured_id
            And ROWNUM = 1;
      Exception
         When NO_DATA_FOUND Then
            Null;
      End;*/
   Begin
      Begin
         Select pc.amount, pc.isunion, ic.amount, ic.isunion
           Into l_result.program_category_amount, l_result.program_is_union, l_result.ins_category_amount
               ,l_result.ins_is_union
           From ins.ins_program_category pc Left Join ins.ins_insured_category ic
                On ic.contract_id = pc.contract_id
              And ic.program_code = pc.program_code
              And ic.category_code = pc.category_code
              And ic.insured_id = p_insured_id
          Where 1 = 1
            And pc.contract_id = p_contract_id
            And pc.program_code = p_program_code
            And pc.category_code = p_category_code;
      Exception
         When NO_DATA_FOUND Then
            Null;
         When Others Then
            Null;
      End;

      /*    With t As
                 (Select 1 x, a.Id, a.limit_for_all_family
                    From ins.ins_insured a
                   Where a.Id = p_insured_id)
            Select /*+ORDERED* /
                   Sum ((100 - al.discount) * ms.amount / 100) As amount
              Into l_result.ins_services_amount
              From ins.ins_account_lines al, ins.ins_medical_service ms, lookup_values lv, lookup_attribute_values lav
             Where al.account_line_id = ms.account_line_id
               And lv.lookup_value_code = ms.medical_service_code
               And lv.lookup_code = 'INS_MEDICAL_SERVICE'
               And lv.lookup_code = lav.lookup_code
               And lv.lookup_value_code = lav.lookup_value_code
               And lav.attribute_code = 'CATEGORY_ID'
               And lav.attribute_value_number = p_category_code
      --         And al.insured_id = p_insured_id;
               And al.insured_id In (
                      Select t.Id
                        From t
                      Union All
                      Select a.Id
                        From ins.ins_insured a, t
                       Where a.attached_to_id = t.Id
                         And t.limit_for_all_family = 'Y'
                      Union All
                      Select b.attached_to_id
                        From ins.ins_insured b, t
                       Where b.Id = t.Id
                         And t.limit_for_all_family = 'Y'
                         And b.attached_to_id Is Not Null);*/
      l_result.balance    :=
             NVL (l_result.ins_category_amount, l_result.program_category_amount)
             - NVL (l_result.ins_services_amount, 0);
      Return l_result;
   End get_ballance_by_insured;

   Function get_bal_values_by_insured (
      p_contract_id      Number
     ,p_program_code     Varchar2
     ,p_insured_id       Number
     ,p_category1_code   Varchar2
     ,p_category2_code   Varchar2
   )
      Return Varchar2 Is
      l_cat1_bal   ballance_rec;
      l_cat2_bal   ballance_rec;
   Begin
      l_cat1_bal    := get_ballance_by_insured (p_contract_id, p_program_code, p_category1_code, p_insured_id);
      l_cat2_bal    := get_ballance_by_insured (p_contract_id, p_program_code, p_category2_code, p_insured_id);
      Return l_cat1_bal.balance || '|' || l_cat2_bal.balance;
   End get_bal_values_by_insured;

   Procedure p_ins_upd (
      p_card_no                In Out   Varchar2
     ,p_fio                    In Out   Varchar2
     ,p_date_of_birth          In Out   Varchar2
     ,p_sex                    In Out   Varchar2
     ,p_phone                  In Out   Varchar2
     ,p_address                In Out   Varchar2
     ,p_attached_to            In Out   Varchar2
     ,p_program_code           In Out   Varchar2
     ,p_contract_id            In Out   Number
     ,p_contract_start_date    In Out   Varchar2
     ,p_contract_finish_date   In Out   Varchar2
     ,p_id                     In Out   Number
     ,p_limit_for_all_family   In Out   Varchar2
     ,p_created_by             In Out   Number
     ,p_created                In Out   Varchar2
     ,p_updated_by             In Out   Number
     ,p_updated                In Out   Varchar2
     ,p_orig_ref_id            In Out   Number
     ,p_attached_to_id         In Out   Number
   ) Is
   Begin
      Update ins_insured
         Set card_no = p_card_no
            ,fio = p_fio
            ,date_of_birth = p_date_of_birth
            ,sex = p_sex
            ,phone = p_phone
            ,address = p_address
            ,attached_to = p_attached_to
            ,program_code = p_program_code
            ,contract_id = p_contract_id
            ,contract_start_date = p_contract_start_date
            ,contract_finish_date = p_contract_finish_date
            ,limit_for_all_family = p_limit_for_all_family
            ,created_by = p_created_by
            ,created = p_created
            ,updated_by = p_updated_by
            ,updated = p_updated
            ,orig_ref_id = p_orig_ref_id
            ,attached_to_id = p_attached_to_id
       Where Id = p_id;

      If Sql%Rowcount = 0 Then
         Select main_sq.Nextval
           Into p_id
           From DUAL;

         Insert Into ins.ins_insured
                     (card_no, fio, date_of_birth, sex, phone, address, attached_to, program_code, contract_id
                     ,contract_start_date, contract_finish_date, Id, limit_for_all_family, created_by, created
                     ,updated_by, updated, orig_ref_id, attached_to_id)
              Values (p_card_no, p_fio, p_date_of_birth, p_sex, p_phone, p_address, p_attached_to, p_program_code
                     ,p_contract_id, p_contract_start_date, p_contract_finish_date, p_id, p_limit_for_all_family
                     ,p_created_by, p_created, p_updated_by, p_updated, p_orig_ref_id, p_attached_to_id);
      End If;
   End p_ins_upd;

   Procedure p_delete (p_id In Out Number) Is
   Begin
      Delete From ins.ins_insured
            Where Id = p_id;
   End p_delete;

   Function get_insured_w_family_list (
      p_insured_id             Number
     ,p_show_all_family_flag   Varchar2 Default 'Y'
     ,p_fio                    Varchar2 Default Null
     ,p_card_no                Varchar2 Default Null
   )
      Return insured_family_t Pipelined Is
   Begin
      For cr In (With t As
                      (
                         Select t.Id, t.fio, t.card_no, t.Id As family_person_id, t.attached_to_id
                               ,t.limit_for_all_family
                           From ins.ins_insured t
                          Where 1 = 1
                            --params
                            And NVL (p_insured_id, t.Id) = t.Id
                            And t.fio Like '%' || p_fio || '%'
                            And t.card_no Like '%' || p_card_no || '%')
                 Select
                        -- он сам
                        t.Id, t.fio, t.card_no, t.Id As family_person_id, t.fio As family_person_fio
                       ,t.card_no As family_person_card_no
                   From t
                 Union
                 Select
                        -- "братья"
                        t.Id, t.fio, t.card_no, pe.Id family_person_id, pe.fio As family_person_fio
                       ,pe.card_no As family_person_card_no
                   From t Join ins.ins_insured attached_to On t.attached_to_id = attached_to.Id
                        Join ins.ins_insured pe On pe.attached_to_id = attached_to.Id
                  Where t.limit_for_all_family = 'Y'
                    And pe.limit_for_all_family = 'Y'
                    And t.Id != pe.Id
                    And p_show_all_family_flag = 'Y'
                 Union
                 Select
                        -- "дети" (T является родителем для PE)
                        t.Id, t.fio, t.card_no, pe.Id family_person_id, pe.fio As family_person_fio
                       ,pe.card_no As family_person_card_no
                   From t Join ins.ins_insured pe On pe.attached_to_id = t.Id
                  Where pe.limit_for_all_family = 'Y'
                    And p_show_all_family_flag = 'Y'
                 Union
                 Select
                        -- "родитель"  (T прикреплен к ATTACHED_TO)
                        t.Id, t.fio, t.card_no, attached_to.Id family_person_id, attached_to.fio As family_person_fio
                       ,attached_to.card_no As family_person_card_no
                   From t Join ins.ins_insured attached_to On t.attached_to_id = attached_to.Id
                  Where t.limit_for_all_family = 'Y'
                    And p_show_all_family_flag = 'Y'
                                                    --
               ) Loop
         Pipe Row (cr);
      End Loop;

      Return;
   End get_insured_w_family_list;
Begin
   For cr In (Select a.Id As contract_id, a.contract_no, (Select cc.company_name
                                                            From ins.ins_company cc
                                                           Where cc.Id = a.client_company_id) As client_company_name
                    , (Select cc.company_name
                         From ins.ins_company cc
                        Where cc.Id = a.ins_company_id) As ins_company_name
                From ins.ins_contract a) Loop
      g_contract_nums (cr.contract_id)                := cr.contract_no;
      g_contract_client_companies (cr.contract_id)    := cr.client_company_name;
      g_contract_ins_companies (cr.contract_id)       := cr.ins_company_name;
   End Loop;

   Null;
End ins_insured_pkg;
/

Create Or Replace Package ins_insured_rep_pkg As
   Type rep_r Is Record (
      insured_id       Number
     ,card_no          ins_insured.card_no%Type
     ,fio              ins_insured.fio%Type
     ,posting_date     Date
     ,visit_date       Date
     ,discount         Number
     ,account_num      Varchar2 (2000)
     ,service_amount   Number
     ,company_name     Varchar2 (2000)
     ,med_cat          Varchar2 (2000)
     ,med_serv         Varchar2 (2000)
     ,diagnosis        Varchar2 (2000)
   );

   Type rep_t Is Table Of rep_r;

   Function get_report_xml (p_insured_id Number, p_show_all_family_flag Varchar2, p_start_date Date, p_end_date Date)
      Return Xmltype;

   Procedure generate_report (
      p_insured_id                   Number
     ,p_show_all_family_flag         Varchar2
     ,p_start_date                   Date
     ,p_end_date                     Date
     ,p_rep_data               Out   Clob
   );

   Function get_report_table (p_insured_id Number, p_show_all_family_flag Varchar2, p_start_date Date, p_end_date Date)
      Return rep_t Pipelined;
End ins_insured_rep_pkg;
/

Grant Execute On ins_insured_rep_pkg To fc22
/

Create Or Replace Package Body ins_insured_rep_pkg As
   Function get_report_table (p_insured_id Number, p_show_all_family_flag Varchar2, p_start_date Date, p_end_date Date)
      Return rep_t Pipelined Is
   Begin
      For cr In (With t As
                      (
                         Select l.account_line_id, i.family_person_id As insured_id, i.family_card_no As card_no
                               ,i.family_person_fio As fio, l.posting_date, l.visit_date, l.discount, l.account_num
                               , (Select Sum (a.amount)
                                    From ins.ins_medical_service a
                                   Where a.account_line_id = l.account_line_id) As service_amount
                               ,ins_company_rep_pkg.get_lookup (4, l.company_id) As company_name
                               ,ins_company_rep_pkg.get_lookup (2, ms.medical_service_code) As med_cat
                               ,ins_company_rep_pkg.get_lookup (3, medical_service_code) As med_serv
                               ,ins_company_rep_pkg.get_lookup (1, diag.diagnosis_code) As diagnosis
                           From Table (ins_insured_pkg.get_insured_w_family_list (p_insured_id, p_show_all_family_flag)) i Join ins.ins_account_lines l
                                On i.family_person_id = l.insured_id
                                Join ins_medical_service ms On l.account_line_id = ms.account_line_id
                                Join ins_service_diagnosis diag On l.account_line_id = diag.account_line_id
                          Where 1 = 1
                            --  And l.insured_id = p_insured_id
--                            And ins_company_rep_pkg.get_lookup (7, ms.medical_service_code) = p_med_cat
                            And l.posting_date Between p_start_date And p_end_date                                     --
                                                                                  )
                     ,t2 As
                      (
                         Select insured_id, card_no, fio, posting_date, visit_date, discount, account_num
                               , (100 - discount) * service_amount / 100 As service_amount, company_name, med_cat
                               ,med_serv, diagnosis
                           From t)
                 Select insured_id, card_no, fio, posting_date, visit_date, discount, account_num, service_amount
                       ,company_name, med_cat, med_serv, diagnosis
                   From t2) Loop
         Pipe Row (cr);
      End Loop;

      Return;
   End get_report_table;

   Function get_report_xml (p_insured_id Number, p_show_all_family_flag Varchar2, p_start_date Date, p_end_date Date)
      Return Xmltype Is
      l_res   Xmltype;
   Begin
      Select XMLELEMENT ("ROWSET"
                        ,xmlattributes (Sum (service_amount) As total_service_amount
                                       ,Max (p_start_date) As p_start_date
                                       ,Max (p_end_date) As p_end_date
                                       ,Max ((Select i.fio
                                                From ins_insured i
                                               Where i.Id = p_insured_id)) As p_fio
                                       ,Max (DECODE (p_show_all_family_flag, 'Да', 'Нет')) As p_show_all_family_flag
                                       )
                        ,XMLAGG (XMLELEMENT ("ROW"
                                            ,xmlattributes (insured_id
                                                           ,card_no
                                                           ,fio
                                                           ,posting_date
                                                           ,visit_date
                                                           ,discount
                                                           ,account_num
                                                           ,service_amount
                                                           ,company_name
                                                           ,med_cat
                                                           ,med_serv
                                                           ,diagnosis
                                                           )
                                            )
                                )
                        )
        Into l_res
        From Table (ins_insured_rep_pkg.get_report_table (p_insured_id, p_show_all_family_flag, p_start_date
                                                         ,p_end_date)
                   );

      Return l_res;
   End get_report_xml;

   Procedure generate_report (
      p_insured_id                   Number
     ,p_show_all_family_flag         Varchar2
     ,p_start_date                   Date
     ,p_end_date                     Date
     ,p_rep_data               Out   Clob
   ) Is
   Begin
--      raise_application_error (-20001, p_start_date || '>>' || p_end_date || '>>' || p_client_company_id);
      p_rep_data    := get_report_xml (p_insured_id, p_show_all_family_flag, p_start_date, p_end_date).getClobVal ();
   End generate_report;
End ins_insured_rep_pkg;
/

Create Or Replace Package ins_med_company_rep As
   Type report_r Is Record (
      med_company_name      Varchar2 (200)
     ,ins_company_name      Varchar2 (200)
     ,client_company_name   Varchar2 (200)
     ,card_no               Varchar2 (200)
     ,fio                   Varchar2 (200)
     ,posting_date          Date
     ,account_num           Varchar2 (200)
     ,med_cat_name          Varchar2 (200)
     ,amount                Number
     ,amount_w_discnt       Number
   );

   Type report_t Is Table Of report_r;

   Function get_report_table (
      p_company_type_id   In   Number
     ,p_med_company_id    In   Number
     ,p_ins_company_id    In   Number
     ,p_start_date        In   Date
     ,p_end_date          In   Date
     ,p_account_num       In   Varchar2
   )
      Return report_t Pipelined;

   Function get_report_xml (
      p_company_type_id   In   Number
     ,p_med_company_id    In   Number
     ,p_ins_company_id    In   Number
     ,p_start_date        In   Date
     ,p_end_date          In   Date
     ,p_account_num       In   Varchar2
   )
      Return Xmltype;

   Function get_report_xml2 (
      p_company_type_id   In   Number
     ,p_med_company_id    In   Number
     ,p_ins_company_id    In   Number
     ,p_start_date        In   Date
     ,p_end_date          In   Date
     ,p_account_num       In   Varchar2
   )
      Return Xmltype;

   Procedure generate_report (
      p_company_type_id   In       Number
     ,p_med_company_id    In       Number
     ,p_ins_company_id    In       Number
     ,p_start_date        In       Date
     ,p_end_date          In       Date
     ,p_account_num       In       Varchar2
     ,p_rep_data          Out      Clob
   );
End ins_med_company_rep;
/

Grant Execute On ins_med_company_rep To fc22
/

Create Or Replace Package Body ins_med_company_rep As
   Function get_report_table (
      p_company_type_id   In   Number
     ,p_med_company_id    In   Number
     ,p_ins_company_id    In   Number
     ,p_start_date        In   Date
     ,p_end_date          In   Date
     ,p_account_num       In   Varchar2
   )
      Return report_t Pipelined Is
      l_row   report_r;
   Begin
      For cr In (With t1 As
                      (
                         Select al.company_id As med_company_id, c.ins_company_id, c.client_company_id, i.card_no
                               ,i.fio, al.posting_date, al.discount, al.account_num
                               ,INS_COMPANY_REP_PKG.get_lookup (2, ms.medical_service_code) As med_cat_name, ms.amount
                               , ms.amount * (100 - al.discount) / 100 amount_w_discnt
                           From ins_contract c, ins_insured i, ins_account_lines al, ins_medical_service ms
                          Where 1 = 1
                            And c.Id = i.contract_id
                            And i.Id = al.insured_id
                            And al.account_line_id = ms.account_line_id
-- params
                            And al.posting_date Between p_start_date And p_end_date
                            And NVL (p_med_company_id, al.company_id) = al.company_id
                            And NVL (p_ins_company_id, c.ins_company_id) = c.ins_company_id
                            And NVL (p_account_num, al.account_num) = al.account_num
                            And Exists (Select 1
                                          From ins_company icmp
                                         Where al.company_id = icmp.Id
                                           And icmp.company_type_id = p_company_type_id))
                 Select   med_company_id, ins_company_id, client_company_id, card_no, fio, posting_date, account_num
                         ,med_cat_name, Sum (amount) As amount, Sum (amount_w_discnt) As amount_w_discnt
                     From t1
                 Group By med_company_id
                         ,ins_company_id
                         ,client_company_id
                         ,card_no
                         ,fio
                         ,posting_date
                         ,account_num
                         ,med_cat_name) Loop
         l_row.med_company_name       := INS_COMPANY_REP_PKG.get_lookup (4, cr.med_company_id);
         l_row.ins_company_name       := INS_COMPANY_REP_PKG.get_lookup (4, cr.ins_company_id);
         l_row.client_company_name    := INS_COMPANY_REP_PKG.get_lookup (4, cr.client_company_id);
         l_row.card_no                := cr.card_no;
         l_row.fio                    := cr.fio;
         l_row.posting_date           := cr.posting_date;
         l_row.account_num            := cr.account_num;
         l_row.med_cat_name           := cr.med_cat_name;
         l_row.amount                 := cr.amount;
         l_row.amount_w_discnt        := cr.amount_w_discnt;
         Pipe Row (l_row);
      End Loop;

      Return;
   End get_report_table;

   Function get_report_xml (
      p_company_type_id   In   Number
     ,p_med_company_id    In   Number
     ,p_ins_company_id    In   Number
     ,p_start_date        In   Date
     ,p_end_date          In   Date
     ,p_account_num       In   Varchar2
   )
      Return Xmltype Is
      l_res   Xmltype;
   Begin
      Select   XMLELEMENT
                  ("ROOT"
                  ,XMLELEMENT ("COMPANIES"
                              ,XMLAGG (XMLELEMENT ("COMPANY"
                                                  ,xmlattributes (med_company_name
                                                                 ,ins_company_name
                                                                 ,Sum (amount) As amount
                                                                 ,Sum (amount_w_discnt) As amount_w_discnt
                                                                 )
                                                  ,XMLELEMENT ("ROWS"
                                                              ,XMLAGG (XMLELEMENT ("ROW"
                                                                                  ,xmlattributes (card_no
                                                                                                 ,fio
                                                                                                 ,client_company_name
                                                                                                 ,posting_date
                                                                                                 ,account_num
                                                                                                 ,med_cat_name
                                                                                                 ,amount
                                                                                                 ,amount_w_discnt
                                                                                                 )
                                                                                  )
                                                                      )
                                                              )
                                                  )
                                      )
                              )
                  )                                                                               --.getClobVal () As xx
          Into l_res
          From Table (INS_MED_COMPANY_REP.get_report_table (p_company_type_id
                                                           ,p_med_company_id
                                                           ,p_ins_company_id
                                                           ,p_start_date
                                                           ,p_end_date
                                                           ,p_account_num
                                                           )
                     )
      Group By med_company_name, ins_company_name;

      Return l_res;
   End get_report_xml;

   Function get_report_xml2 (
      p_company_type_id   In   Number
     ,p_med_company_id    In   Number
     ,p_ins_company_id    In   Number
     ,p_start_date        In   Date
     ,p_end_date          In   Date
     ,p_account_num       In   Varchar2
   )
      Return Xmltype Is
      l_res               Xmltype;
      l_company_type_id   Varchar2 (2000);
   Begin
      Select stragg (a.lookup_display_value)
        Into l_company_type_id
        From fc22.lookup_values a
       Where a.lookup_code = 'INS_COMPANY_TYPE'
         And a.lookup_value_code = p_company_type_id;

      With t As
           (
              Select med_company_name, ins_company_name, card_no, fio, client_company_name, posting_date, account_num
                    ,med_cat_name, amount, amount_w_discnt
                    ,Sum (amount) Over (Partition By med_company_name, ins_company_name) As amount_ttl
                    ,Sum (amount_w_discnt) Over (Partition By med_company_name, ins_company_name)
                                                                                                 As amount_w_discnt_ttl
                From Table (ins.INS_MED_COMPANY_REP.get_report_table (p_company_type_id
                                                                     ,p_med_company_id
                                                                     ,p_ins_company_id
                                                                     ,p_start_date
                                                                     ,p_end_date
                                                                     ,p_account_num
                                                                     )
                           ))
      Select XMLELEMENT
                ("ROWSET"
                ,xmlattributes (l_company_type_id As p_company_type_id
                               ,INS_COMPANY_REP_PKG.get_lookup (4, p_med_company_id) As p_med_company_name
                               ,INS_COMPANY_REP_PKG.get_lookup (4, p_ins_company_id) As p_ins_company_name
                               ,TO_CHAR (p_start_date, 'dd.mm.yyyy') As p_start_date
                               ,TO_CHAR (p_end_date, 'dd.mm.yyyy') As p_end_date
                               ,p_account_num As p_account_num
                               )
                ,XMLAGG (XMLELEMENT ("ROW"
                                    ,xmlattributes (med_company_name
                                                   ,ins_company_name
                                                   ,card_no
                                                   ,fio
                                                   ,client_company_name
                                                   ,posting_date
                                                   ,account_num
                                                   ,med_cat_name
                                                   ,amount
                                                   ,amount_w_discnt
                                                   ,amount_ttl
                                                   ,amount_w_discnt_ttl
                                                   )
                                    )
                        )
                )                                                                                    --.getClobVal () xx
        Into l_res
        From t;

      Return l_res;
   End get_report_xml2;

   Procedure generate_report (
      p_company_type_id   In       Number
     ,p_med_company_id    In       Number
     ,p_ins_company_id    In       Number
     ,p_start_date        In       Date
     ,p_end_date          In       Date
     ,p_account_num       In       Varchar2
     ,p_rep_data          Out      Clob
   ) Is
   Begin
--      raise_application_error (-20001, p_start_date || '>>' || p_end_date || '>>' || p_client_company_id);
      p_rep_data    :=
         get_report_xml2 (p_company_type_id
                         ,p_med_company_id
                         ,p_ins_company_id
                         ,p_start_date
                         ,p_end_date
                         ,p_account_num
                         ).getClobVal ();
   End generate_report;
End INS_MED_COMPANY_REP;
/

Create Or Replace Package ins_program_category_pkg As
   Procedure p_delete (p_id In Out Number);

   Procedure p_ins_upd (
      p_id              In Out   Number
     ,p_contract_id     In Out   Number
     ,p_program_code    In Out   Varchar2
     ,p_category_code   In Out   Varchar2
     ,p_amount          In Out   Number
     ,p_isunion         In Out   Varchar2
     ,p_created_by      In Out   Number
     ,p_created         In Out   Varchar2
     ,p_updated_by      In Out   Number
     ,p_updated         In Out   Varchar2
     ,p_orig_ref_id     In Out   Number
   );
End ins_program_category_pkg;
/

Create Or Replace Package Body ins_program_category_pkg As
   Procedure p_ins_upd (
      p_id              In Out   Number
     ,p_contract_id     In Out   Number
     ,p_program_code    In Out   Varchar2
     ,p_category_code   In Out   Varchar2
     ,p_amount          In Out   Number
     ,p_isunion         In Out   Varchar2
     ,p_created_by      In Out   Number
     ,p_created         In Out   Varchar2
     ,p_updated_by      In Out   Number
     ,p_updated         In Out   Varchar2
     ,p_orig_ref_id     In Out   Number
   ) Is
   Begin
      Update ins_program_category
         Set contract_id = p_contract_id
            ,program_code = p_program_code
            ,category_code = p_category_code
            ,amount = p_amount
            ,isunion = p_isunion
            ,created_by = p_created_by
            ,created = p_created
            ,updated_by = p_updated_by
            ,updated = p_updated
            ,orig_ref_id = p_orig_ref_id
       Where Id = p_id;

      If Sql%Rowcount = 0 Then
         Select main_sq.Nextval
           Into p_id
           From DUAL;

         Insert Into ins_program_category
                     (Id, contract_id, program_code, category_code, amount, isunion, created_by, created, updated_by
                     ,updated, orig_ref_id)
              Values (p_id, p_contract_id, p_program_code, p_category_code, p_amount, p_isunion, p_created_by
                     ,p_created, p_updated_by, p_updated, p_orig_ref_id);
      End If;
   End p_ins_upd;

   Procedure p_delete (p_id In Out Number) Is
   Begin
      Delete From ins.ins_program_category
            Where Id = p_id;
   End p_delete;
End ins_program_category_pkg;
/

Create Or Replace Package ins_program_med_service_pkg As
   Procedure p_ins_upd (
      p_id                     In Out   Number
     ,p_contract_id            In Out   Number
     ,p_program_code           In Out   Varchar2
     ,p_category_code          In Out   Varchar2
     ,p_medical_service_code   In Out   Varchar2
     ,p_created_by             In Out   Number
     ,p_created                In Out   Varchar2
     ,p_updated_by             In Out   Number
     ,p_updated                In Out   Varchar2
     ,p_orig_ref_id            In Out   Number
   );

   Procedure p_delete (p_id In Out Number);
End ins_program_med_service_pkg;
/

Create Or Replace Package Body ins_program_med_service_pkg As
   Procedure p_ins_upd (
      p_id                     In Out   Number
     ,p_contract_id            In Out   Number
     ,p_program_code           In Out   Varchar2
     ,p_category_code          In Out   Varchar2
     ,p_medical_service_code   In Out   Varchar2
     ,p_created_by             In Out   Number
     ,p_created                In Out   Varchar2
     ,p_updated_by             In Out   Number
     ,p_updated                In Out   Varchar2
     ,p_orig_ref_id            In Out   Number
   ) Is
   Begin
      Update ins_program_med_service
         Set contract_id = p_contract_id
            ,program_code = p_program_code
            ,category_code = p_category_code
            ,medical_service_code = p_medical_service_code
            ,created_by = p_created_by
            ,created = p_created
            ,updated_by = p_updated_by
            ,updated = p_updated
            ,orig_ref_id = p_orig_ref_id
       Where Id = p_id;

      If Sql%Rowcount = 0 Then
         Select main_sq.Nextval
           Into p_id
           From DUAL;

         Insert Into ins_program_med_service
                     (Id, contract_id, program_code, category_code, medical_service_code, created_by, created
                     ,updated_by, updated, orig_ref_id)
              Values (p_id, p_contract_id, p_program_code, p_category_code, p_medical_service_code, p_created_by
                     ,p_created, p_updated_by, p_updated, p_orig_ref_id);
      End If;
   End p_ins_upd;

   Procedure p_delete (p_id In Out Number) Is
   Begin
      Delete From ins_program_med_service
            Where Id = p_id;
   End p_delete;
End ins_program_med_service_pkg;
/

Create Or Replace Package ins_program_pkg As
   Procedure p_delete (p_id In Out Number);

   Procedure p_ins_upd (
      p_id                      Number
     ,p_orig_ref_id    In Out   Number
     ,p_contract_id    In Out   Number
     ,p_program_code   In Out   Varchar2
     ,p_amount         In Out   Number
     ,p_premium        In Out   Number
     ,p_isunion        In Out   Varchar2
     ,p_created_by     In Out   Number
     ,p_created        In Out   Varchar2
     ,p_updated_by     In Out   Number
     ,p_updated        In Out   Varchar2
   );
End ins_program_pkg;
/

Create Or Replace Package Body ins_program_pkg As
   Procedure p_ins_upd (
      p_id                      Number
     ,p_orig_ref_id    In Out   Number
     ,p_contract_id    In Out   Number
     ,p_program_code   In Out   Varchar2
     ,p_amount         In Out   Number
     ,p_premium        In Out   Number
     ,p_isunion        In Out   Varchar2
     ,p_created_by     In Out   Number
     ,p_created        In Out   Varchar2
     ,p_updated_by     In Out   Number
     ,p_updated        In Out   Varchar2
   ) Is
      l_id   Number;
   Begin
      Update ins_program
         Set orig_ref_id = p_orig_ref_id
            ,contract_id = p_contract_id
            ,program_code = p_program_code
            ,amount = p_amount
            ,premium = p_premium
            ,isunion = p_isunion
            ,created_by = p_created_by
            ,created = p_created
            ,updated_by = p_updated_by
            ,updated = p_updated
       Where Id = p_id;

      If Sql%Rowcount = 0 Then
         Select main_sq.Nextval
           Into l_id
           From DUAL;

         Insert Into ins_program
                     (Id, orig_ref_id, contract_id, program_code, amount, premium, isunion, created_by, created
                     ,updated_by, updated)
              Values (l_id, p_orig_ref_id, p_contract_id, p_program_code, p_amount, p_premium, p_isunion, p_created_by
                     ,p_created, p_updated_by, p_updated);
      End If;
   End p_ins_upd;

   Procedure p_delete (p_id In Out Number) Is
   Begin
      Delete From ins_program
            Where Id = p_id;
   End p_delete;
End ins_program_pkg;
/

