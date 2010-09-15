Create Or Replace Package attribute_type_lng_cases_pkg As
End ATTRIBUTE_TYPE_LNG_CASES_PKG;
/

Create Or Replace Package Body attribute_type_lng_cases_pkg As
   Procedure p_insert (
      p_attribute_type_lng_case_id   In Out   Number
     ,p_attribute_code               In Out   Varchar2
     ,p_lang_code                    In Out   Varchar2
     ,p_case_id                      In Out   Number
     ,p_case_ending_type             In Out   Varchar2
   ) Is
   Begin
      Insert Into AAHR_ORDERS.ATTRIBUTE_TYPE_LNG_CASES
                  (attribute_type_lng_case_id, attribute_code, lang_code, case_id, case_ending_type)
           Values (p_attribute_type_lng_case_id, p_attribute_code, p_lang_code, p_case_id, p_case_ending_type)
        Returning attribute_type_lng_case_id, attribute_code, lang_code, case_id, case_ending_type
             Into p_attribute_type_lng_case_id, p_attribute_code, p_lang_code, p_case_id, p_case_ending_type;
   End p_insert;

   Procedure p_update (
      p_attribute_type_lng_case_id   In Out   Number
     ,p_attribute_code               In Out   Varchar2
     ,p_lang_code                    In Out   Varchar2
     ,p_case_id                      In Out   Number
     ,p_case_ending_type             In Out   Varchar2
   ) Is
   Begin
      Update    AAHR_ORDERS.ATTRIBUTE_TYPE_LNG_CASES
            Set attribute_type_lng_case_id = p_attribute_type_lng_case_id
               ,attribute_code = p_attribute_code
               ,lang_code = p_lang_code
               ,case_id = p_case_id
               ,case_ending_type = p_case_ending_type
          Where attribute_type_lng_case_id = p_attribute_type_lng_case_id
            And attribute_code = p_attribute_code
            And lang_code = p_lang_code
            And case_id = p_case_id
            And case_ending_type = p_case_ending_type
      Returning attribute_type_lng_case_id, attribute_code, lang_code, case_id, case_ending_type
           Into p_attribute_type_lng_case_id, p_attribute_code, p_lang_code, p_case_id, p_case_ending_type;
   End p_update;

   Procedure p_delete (p_attribute_type_lng_case_id In Out Number) Is
   Begin
      Delete From AAHR_ORDERS.ATTRIBUTE_TYPE_LNG_CASES
            Where attribute_type_lng_case_id = p_attribute_type_lng_case_id;
   End p_delete;
End ATTRIBUTE_TYPE_LNG_CASES_PKG;
/

Create Or Replace Package attribute_types_pkg As
   Procedure p_delete (p_attribute_id In Out Number);

   Procedure p_ins_upd (
      p_attribute_id         In Out   Number
     ,p_old_attribute_code   In       Varchar2
     ,p_attribute_code       In Out   Varchar2
     ,p_attribute_name       In Out   Varchar2
     ,p_attribute_type       In Out   Varchar2
     ,p_db_expression        In Out   Varchar2
     ,p_exec_order           In Out   Varchar2
   );
End ATTRIBUTE_TYPES_PKG;
/

Create Or Replace Package Body attribute_types_pkg As
   Procedure p_ins_upd (
      p_attribute_id         In Out   Number
     ,p_old_attribute_code   In       Varchar2
     ,p_attribute_code       In Out   Varchar2
     ,p_attribute_name       In Out   Varchar2
     ,p_attribute_type       In Out   Varchar2
     ,p_db_expression        In Out   Varchar2
     ,p_exec_order           In Out   Varchar2
   ) Is
   Begin
      Update attribute_types
         Set attribute_code = p_attribute_code
            ,attribute_name = p_attribute_name
            ,attribute_type = p_attribute_type
            ,db_expression = p_db_expression
            ,exec_order = p_exec_order
       Where attribute_id = p_attribute_id;

      If 0 != Sql%Rowcount Then
         If p_attribute_code != p_old_attribute_code Then
            Update order_type_attributes ota
               Set ota.attribute_code = p_attribute_code
             Where ota.attribute_code = p_old_attribute_code;

            Update order_entity_attribute_values oeav
               Set oeav.attribute_code = p_attribute_code
             Where oeav.attribute_code = p_old_attribute_code;
         End If;
      Else
         Select main_sq.Nextval, NVL (p_exec_order, DECODE (p_db_expression, Null, 10, 20))
           Into p_attribute_id, p_exec_order
           From DUAL;

         Insert Into attribute_types
                     (attribute_id, attribute_code, attribute_name, attribute_type, db_expression, exec_order)
              Values (p_attribute_id, p_attribute_code, p_attribute_name, p_attribute_type, p_db_expression
                     ,p_exec_order);
      End If;
   End p_ins_upd;

   Procedure p_delete (p_attribute_id In Out Number) Is
   Begin
      Delete From attribute_types
            Where attribute_id = p_attribute_id;
   End p_delete;
End ATTRIBUTE_TYPES_PKG;
/

Create Or Replace Package db_item_tools_pkg As
   Function get_date_kz (p_date Date, p_year_str Varchar2, p_mon_suffix_soft Varchar2, p_mon_suffix_strong Varchar2)
      Return Varchar2;

   Function get_date_ru (p_date Date)
      Return Varchar2;

   Function get_date_dbi_kz (
      p_dbi_name            Varchar2
     ,p_year_str            Varchar2
     ,p_mon_suffix_soft     Varchar2
     ,p_mon_suffix_strong   Varchar2
   )
      Return Varchar2;

   Function get_date_dbi_ru (p_dbi_name Varchar2)
      Return Varchar2;
End db_item_tools_pkg;
/

Create Or Replace Package Body db_item_tools_pkg As
   Type char_vals_int_idx_t Is Table Of Varchar2 (4000)
      Index By Binary_integer;

   g_kz_months   char_vals_int_idx_t;

   Function get_date_kz (p_date Date, p_year_str Varchar2, p_mon_suffix_soft Varchar2, p_mon_suffix_strong Varchar2)
      Return Varchar2 Is
      Result   Varchar2 (4000);
   Begin
      Result    := g_kz_months (TO_CHAR (p_date, 'mm') + 0);
      Result    :=
            Case
               When TO_CHAR (p_date, 'mm') + 0 In (4, 7) Then Result || p_mon_suffix_soft
               Else Result || p_mon_suffix_strong
            End;
      Result    := TO_CHAR (p_date, 'yyyy') || ' ' || p_year_str || ' ' || TO_CHAR (p_date, 'dd') || ' ' || Result;
      Return Result;
   Exception
      When Others Then
         Return SQLERRM;
   End get_date_kz;

   Function get_date_ru (p_date Date)
      Return Varchar2 Is
      Result   Varchar2 (4000);
   Begin
      Result    :=
         text_utils_pkg.get_word_in_case (TO_CHAR (p_date, 'month', 'NLS_DATE_LANGUAGE=RUSSIAN')
                                         ,'RU'
                                         ,2
                                         ,'FIRST'
                                         ,'M'
                                         ,'N'
                                         );
      Result    := TO_CHAR (p_date, 'dd') || ' ' || Result || ' ' || TO_CHAR (p_date, 'yyyy');
      Return Result;
   Exception
      When Others Then
         Return SQLERRM;
   End get_date_ru;

   Function get_date_dbi_ru (p_dbi_name Varchar2)
      Return Varchar2 Is
   Begin
      Return db_item_tools_pkg.get_date_ru (db_item_utils_pkg.get_attr_val (p_dbi_name));
   End get_date_dbi_ru;

   Function get_date_dbi_kz (
      p_dbi_name            Varchar2
     ,p_year_str            Varchar2
     ,p_mon_suffix_soft     Varchar2
     ,p_mon_suffix_strong   Varchar2
   )
      Return Varchar2 Is
   Begin
      Return db_item_tools_pkg.get_date_kz (db_item_utils_pkg.get_attr_val (p_dbi_name)
                                           ,p_year_str
                                           ,p_mon_suffix_soft
                                           ,p_mon_suffix_strong
                                           );
   End get_date_dbi_kz;
Begin
   --   g_kz_months
   For cr In (Select a.lookup_value_code, LOWER (a.lookup_display_value) As lookup_display_value
                From lookup_values a
               Where a.lookup_code = 'HR_MONTHS_KZ') Loop
      g_kz_months (cr.lookup_value_code)    := cr.lookup_display_value;
   End Loop;

   Null;
End db_item_tools_pkg;
/

Create Or Replace Package db_item_utils_pkg As
   Type attr_vals_t Is Table Of Varchar2 (4000)
      Index By Varchar2 (4000);

   g_order_entity_id   Number      Default -1;
   g_attr_vals         attr_vals_t;

   Function get_attr_val (p_attribute_code Varchar2, p_order_entity_id Number Default g_order_entity_id)
      Return Varchar2;

   Procedure init_order_entity_dbitems (p_order_entity_id Number Default g_order_entity_id);
End db_item_utils_pkg;
/

Grant Execute On db_item_utils_pkg To fc22
/

Create Or Replace Package Body db_item_utils_pkg As
   Function eval_dbi (p_eval_str Varchar2, p_order_entity_id Number)
      Return Varchar2 Is
      l_res        Varchar2 (4000);
      l_exec_str   Varchar2 (4000) := p_eval_str;
   Begin
      Begin
         Execute Immediate Replace (l_exec_str, CHR (13))
                     Using Out l_res;
      Exception
         When Others Then
            Return SQLERRM;
      End;

      Return l_res;
   End eval_dbi;

   Procedure init_order_entity_dbitems (p_order_entity_id Number Default g_order_entity_id) Is
      l_res   Varchar2 (4000);
   Begin
      If p_order_entity_id != g_order_entity_id Then
         g_order_entity_id    := p_order_entity_id;
         g_attr_vals.Delete;

--      DBMS_OUTPUT.put_line ('Init. p_order_entity_id:' || p_order_entity_id);
         For cr In (Select   ott.attribute_code, att.attribute_type, att.db_expression, oeav.attribute_value
                            ,oeav.attribute_value_date, oeav.attribute_value_number
                        From orders o Join order_entities oe On oe.order_id = o.order_id
                             Join order_type_attributes ott On ott.order_type_code = o.order_type_code
                             Join attribute_types att On ott.attribute_code = att.attribute_code
                             Left Join order_entity_attribute_values oeav
                             On oeav.order_entity_id = oe.order_entity_id
                           And oeav.attribute_code = att.attribute_code
                       Where oe.order_entity_id = p_order_entity_id
                    Order By att.exec_order) Loop
            Case
               When 'D' = cr.attribute_type Then
                  l_res    := cr.attribute_value_date || '';
               When 'N' = cr.attribute_type Then
                  l_res    := cr.attribute_value_number || '';
               Else
                  l_res    := cr.attribute_value;
            End Case;

            If     l_res Is Null
               And cr.db_expression Is Not Null Then
               l_res    := eval_dbi (cr.db_expression, p_order_entity_id);
            End If;

--            DBMS_OUTPUT.put_line (cr.attribute_code || ':' || l_res || '; db_expression:' || cr.db_expression);
            g_attr_vals (cr.attribute_code)    := l_res;
         End Loop;
      End If;
   End init_order_entity_dbitems;

   Function get_attr_val (p_attribute_code Varchar2, p_order_entity_id Number Default g_order_entity_id)
      Return Varchar2 Is
      l_res   Varchar2 (4000);
   Begin
      init_order_entity_dbitems (p_order_entity_id);
      Return g_attr_vals (p_attribute_code);
   Exception
      When Others Then
         Return SQLERRM;
   End get_attr_val;
End db_item_utils_pkg;
/

Create Or Replace Package entity_types_pkg As
End ENTITY_TYPES_PKG;
/

Create Or Replace Package Body entity_types_pkg As
   Procedure p_insert (
      p_entity_type_id            In Out   Number
     ,p_entity_type_code          In Out   Varchar2
     ,p_parent_entiry_type_code   In Out   Varchar2
     ,p_entity_type_name          In Out   Varchar2
   ) Is
   Begin
      Insert Into AAHR_ORDERS.ENTITY_TYPES
                  (entity_type_id, entity_type_code, parent_entity_type_code, entity_type_name)
           Values (p_entity_type_id, p_entity_type_code, p_parent_entiry_type_code, p_entity_type_name)
        Returning entity_type_id, entity_type_code, parent_entity_type_code, entity_type_name
             Into p_entity_type_id, p_entity_type_code, p_parent_entiry_type_code, p_entity_type_name;
   End p_insert;

   Procedure p_update (
      p_entity_type_id            In Out   Number
     ,p_entiry_type_code          In Out   Varchar2
     ,p_parent_entiry_type_code   In Out   Varchar2
     ,p_entity_type_name          In Out   Varchar2
   ) Is
   Begin
      Update    AAHR_ORDERS.ENTITY_TYPES
            Set entity_type_id = p_entity_type_id
               ,entity_type_code = p_entiry_type_code
               ,parent_entity_type_code = p_parent_entiry_type_code
               ,entity_type_name = p_entity_type_name
          Where entity_type_id = p_entity_type_id
            And entity_type_code = p_entiry_type_code
            And parent_entity_type_code = p_parent_entiry_type_code
            And entity_type_name = p_entity_type_name
      Returning entity_type_id, entity_type_code, parent_entity_type_code, entity_type_name
           Into p_entity_type_id, p_entiry_type_code, p_parent_entiry_type_code, p_entity_type_name;
   End p_update;

   Procedure p_delete (
      p_entity_type_id            In Out   Number
     ,p_entiry_type_code          In Out   Varchar2
     ,p_parent_entiry_type_code   In Out   Varchar2
     ,p_entity_type_name          In Out   Varchar2
   ) Is
   Begin
      Delete From AAHR_ORDERS.ENTITY_TYPES
            Where entity_type_id = p_entity_type_id
              And entity_type_code = p_entiry_type_code
              And parent_entity_type_code = p_parent_entiry_type_code
              And entity_type_name = p_entity_type_name;
   End p_delete;
End ENTITY_TYPES_PKG;
/

Create Or Replace Package lang_case_endings_filter_pkg As
   Procedure p_ins_upd (p_lang Varchar2, p_sex Varchar2, p_ending_type Varchar2);
End lang_case_endings_filter_pkg;
/

Create Or Replace Package Body lang_case_endings_filter_pkg As
   Procedure p_ins_upd (p_lang Varchar2, p_sex Varchar2, p_ending_type Varchar2) Is
   Begin
      Null;
   End p_ins_upd;
End lang_case_endings_filter_pkg;
/

Create Or Replace Package lang_case_endings_pkg As
   Procedure p_ins_upd (
      p_case_ending_id   In Out   Number
     ,p_case_id          In Out   Number
     ,p_ending_id        In Out   Number
     ,p_case_ending      In Out   Varchar2
   );

   Procedure p_delete (p_case_ending_id In Out Number);

   Procedure p_delete_by_ending_id (p_ending_id In Number);
End lang_case_endings_pkg;
/

Create Or Replace Package Body lang_case_endings_pkg As
   Procedure p_ins_upd (
      p_case_ending_id   In Out   Number
     ,p_case_id          In Out   Number
     ,p_ending_id        In Out   Number
     ,p_case_ending      In Out   Varchar2
   ) Is
   Begin
      Update aahr_orders.lang_case_endings
         Set case_id = p_case_id
            ,ending_id = p_ending_id
            ,case_ending = p_case_ending
       Where case_ending_id = p_case_ending_id;

      If 0 = Sql%Rowcount Then
         Select main_sq.Nextval
           Into p_case_ending_id
           From DUAL;

         Insert Into aahr_orders.lang_case_endings
                     (case_ending_id, case_id, ending_id, case_ending)
              Values (p_case_ending_id, p_case_id, p_ending_id, p_case_ending);
      End If;
   End p_ins_upd;

   Procedure p_delete (p_case_ending_id In Out Number) Is
   Begin
      Delete From aahr_orders.lang_case_endings a
            Where a.case_ending_id = p_case_ending_id;
   End p_delete;

   Procedure p_delete_by_ending_id (p_ending_id In Number) Is
   Begin
      Delete From aahr_orders.lang_case_endings a
            Where a.ending_id = p_ending_id;
   End p_delete_by_ending_id;
End lang_case_endings_pkg;
/

Create Or Replace Package lang_cases_pkg As
   Procedure p_delete (p_case_id In Out Number);

   Procedure p_ins_upd (
      p_case_id        In Out   Number
     ,p_case_number    In Out   Varchar2
     ,p_lang           In Out   Varchar2
     ,p_case_name      In Out   Varchar2
     ,p_case_name_en   In Out   Varchar2
     ,p_case_name_ru   In Out   Varchar2
     ,p_question       In Out   Varchar2
   );
End LANG_CASES_PKG;
/

Create Or Replace Package Body lang_cases_pkg As
   Procedure p_ins_upd (
      p_case_id        In Out   Number
     ,p_case_number    In Out   Varchar2
     ,p_lang           In Out   Varchar2
     ,p_case_name      In Out   Varchar2
     ,p_case_name_en   In Out   Varchar2
     ,p_case_name_ru   In Out   Varchar2
     ,p_question       In Out   Varchar2
   ) Is
   Begin
      Update AAHR_ORDERS.LANG_CASES
         Set case_number = p_case_number
            ,lang = p_lang
            ,case_name = p_case_name
            ,case_name_en = p_case_name_en
            ,case_name_ru = p_case_name_ru
            ,question = p_question
       Where case_id = p_case_id;

      If 0 = Sql%Rowcount Then
         Select main_sq.Nextval
           Into p_case_id
           From DUAL;

         Insert Into AAHR_ORDERS.LANG_CASES
                     (case_id, case_number, lang, case_name, case_name_en, case_name_ru, question)
              Values (p_case_id, p_case_number, p_lang, p_case_name, p_case_name_en, p_case_name_ru, p_question);
      End If;
   End p_ins_upd;

   Procedure p_delete (p_case_id In Out Number) Is
   Begin
      Delete From lang_cases
            Where case_id = p_case_id;
   End p_delete;
End lang_cases_pkg;
/

Create Or Replace Package lang_endings_pkg As
   Procedure p_delete (p_ending_id In Out Number);

   Procedure p_ins_upd (
      p_ending_id     In Out   Number
     ,p_lang          In Out   Varchar2
     ,p_ending_type   In Out   Varchar2
     ,p_sex           In Out   Varchar2
     ,p_ending        In Out   Varchar2
     ,p_comments      In Out   Varchar2
     ,p_sort_key      Out      Varchar2
   );
End LANG_ENDINGS_PKG;
/

Create Or Replace Package Body lang_endings_pkg As
   Procedure p_ins_upd (
      p_ending_id     In Out   Number
     ,p_lang          In Out   Varchar2
     ,p_ending_type   In Out   Varchar2
     ,p_sex           In Out   Varchar2
     ,p_ending        In Out   Varchar2
     ,p_comments      In Out   Varchar2
     ,p_sort_key      Out      Varchar2
   ) Is
   Begin
      Update AAHR_ORDERS.LANG_ENDINGS
         Set lang = p_lang
            ,ending_type = p_ending_type
            ,sex = p_sex
            ,ending = p_ending
            ,comments = p_comments
       Where ending_id = p_ending_id;

      If 0 = Sql%Rowcount Then
         Select main_sq.Nextval
           Into p_ending_id
           From DUAL;

         Insert Into AAHR_ORDERS.LANG_ENDINGS
                     (ending_id, lang, ending_type, sex, ending, comments)
              Values (p_ending_id, p_lang, p_ending_type, p_sex, p_ending, p_comments);

         If p_lang Is Not Null Then
            --Вставка пустышек для падежей
            For cr In (Select a.case_id, a.case_number, a.lang, a.case_name, a.case_name_en, a.case_name_ru
                             ,a.question
                         From lang_cases a
                        Where a.lang = p_lang) Loop
               Declare
                  l_case_ending_id   Number;
                  l_case_ending      Varchar2 (32000);
               Begin
                  lang_case_endings_pkg.p_ins_upd (l_case_ending_id, cr.case_id, p_ending_id, l_case_ending);
               End;
            End Loop;
         End If;
      End If;

      p_sort_key    := text_utils_pkg.get_reverse_str (p_ending);
   End p_ins_upd;

   Procedure p_delete (p_ending_id In Out Number) Is
   Begin
      lang_case_endings_pkg.p_delete_by_ending_id (p_ending_id);

      Delete From AAHR_ORDERS.LANG_ENDINGS
            Where ending_id = p_ending_id;
   End p_delete;
End LANG_ENDINGS_PKG;
/

Create Or Replace Package order_entities_pkg As
   Procedure p_ins_upd (
      p_order_entity_id    In Out   Number
     ,p_order_id           In Out   Number
     ,p_entity_type_code   In Out   Varchar2
     ,p_entity_id          In       Varchar2
   );

   Procedure p_delete (p_order_entity_id In Out Number);
End;
/

Create Or Replace Package Body order_entities_pkg As
   Procedure p_ins_upd (
      p_order_entity_id    In Out   Number
     ,p_order_id           In Out   Number
     ,p_entity_type_code   In Out   Varchar2
     ,p_entity_id          In       Varchar2
   ) Is
   Begin
      Update order_entities
         Set order_id = p_order_id
            ,entity_type_code = p_entity_type_code
            ,entity_id = p_entity_id
       Where order_entity_id = p_order_entity_id;

      If 0 = Sql%Rowcount Then
         Select main_sq.Nextval
           Into p_order_entity_id
           From DUAL;

         Insert Into order_entities
                     (order_entity_id, order_id, entity_type_code, entity_id)
              Values (p_order_entity_id, p_order_id, p_entity_type_code, p_entity_id)
           Returning order_entity_id
                Into p_order_entity_id;
      End If;
   End p_ins_upd;

   Procedure p_delete (p_order_entity_id In Out Number) Is
   Begin
      Delete From order_entities
            Where order_entity_id = p_order_entity_id;
   End p_delete;
End ORDER_ENTITIES_PKG;
/

Create Or Replace Package order_entity_attr_vals_pkg As
   Procedure p_ins_upd (
      p_order_entity_attr_value_id   In Out   order_entity_attribute_values.order_entity_attr_value_id%Type
     ,p_order_entity_id              In Out   order_entity_attribute_values.order_entity_id%Type
     ,p_attribute_code               In Out   order_entity_attribute_values.attribute_code%Type
     ,p_attribute_value              In Out   order_entity_attribute_values.attribute_value%Type
     ,p_attribute_value_date         In Out   order_entity_attribute_values.attribute_value_date%Type
     ,p_attribute_value_number       In Out   order_entity_attribute_values.attribute_value_number%Type
   );
End;
/

Create Or Replace Package Body order_entity_attr_vals_pkg As
   Procedure p_ins_upd (
      p_order_entity_attr_value_id   In Out   order_entity_attribute_values.order_entity_attr_value_id%Type
     ,p_order_entity_id              In Out   order_entity_attribute_values.order_entity_id%Type
     ,p_attribute_code               In Out   order_entity_attribute_values.attribute_code%Type
     ,p_attribute_value              In Out   order_entity_attribute_values.attribute_value%Type
     ,p_attribute_value_date         In Out   order_entity_attribute_values.attribute_value_date%Type
     ,p_attribute_value_number       In Out   order_entity_attribute_values.attribute_value_number%Type
   ) Is
   Begin
      Update order_entity_attribute_values t
         Set t.order_entity_id = p_order_entity_id
            ,t.attribute_code = p_attribute_code
            ,t.attribute_value = p_attribute_value
            ,t.attribute_value_date = p_attribute_value_date
            ,t.attribute_value_number = p_attribute_value_number
       Where t.order_entity_attr_value_id = p_order_entity_attr_value_id;

      If 0 = Sql%Rowcount Then
         Select main_sq.Nextval
           Into p_order_entity_attr_value_id
           From DUAL;

         Insert Into order_entity_attribute_values
                     (order_entity_attr_value_id, order_entity_id, attribute_code, attribute_value
                     ,attribute_value_date, attribute_value_number)
              Values (p_order_entity_attr_value_id, p_order_entity_id, p_attribute_code, p_attribute_value
                     ,p_attribute_value_date, p_attribute_value_number);
      End If;
   End p_ins_upd;
End;
/

Create Or Replace Package order_type_attributes_pkg As
   Procedure p_ins_upd (
      p_ot_attribute_id    In Out   Number
     ,p_order_type_code    In Out   Varchar2
     ,p_attribute_code     In Out   Varchar2
     ,p_api_field_name     In Out   Varchar2
     ,p_in_out_type        In Out   Varchar2
     ,p_display_name       In Out   Varchar2
     ,p_display_position   In Out   Number
   );

   Procedure p_delete (p_ot_attribute_id In Out Number, p_order_type_code In Out Varchar2);
End order_type_attributes_pkg;
/

Create Or Replace Package Body order_type_attributes_pkg As
   Procedure p_ins_upd (
      p_ot_attribute_id    In Out   Number
     ,p_order_type_code    In Out   Varchar2
     ,p_attribute_code     In Out   Varchar2
     ,p_api_field_name     In Out   Varchar2
     ,p_in_out_type        In Out   Varchar2
     ,p_display_name       In Out   Varchar2
     ,p_display_position   In Out   Number
   ) Is
   Begin
      Update order_type_attributes
         Set order_type_code = p_order_type_code
            ,attribute_code = p_attribute_code
            ,api_field_name = p_api_field_name
            ,in_out_type = p_in_out_type
            ,display_name = p_display_name
            ,display_position = p_display_position
       Where ot_attribute_id = p_ot_attribute_id;

      If Sql%Rowcount = 0 Then
         Select main_sq.Nextval
           Into p_ot_attribute_id
           From DUAL;

         Insert Into order_type_attributes
                     (ot_attribute_id, order_type_code, attribute_code, api_field_name, in_out_type, display_name
                     ,display_position)
              Values (p_ot_attribute_id, p_order_type_code, p_attribute_code, p_api_field_name, p_in_out_type
                     ,p_display_name, p_display_position);

         order_types_pkg.generate_order_form (p_order_type_code);
      End If;
   End p_ins_upd;

   Procedure p_delete (p_ot_attribute_id In Out Number, p_order_type_code In Out Varchar2) Is
   Begin
      Delete From order_type_attributes
            Where ot_attribute_id = p_ot_attribute_id;

      order_types_pkg.generate_order_form (p_order_type_code);
   End p_delete;
End order_type_attributes_pkg;
/

Create Or Replace Package order_type_reports_pkg As
   Procedure p_ins_upd (
      p_order_type_report_id   In Out   Number
     ,p_order_type_code        In Out   Varchar2
     ,p_report_name            In Out   Varchar2
     ,p_template               In       Clob
   );

   Procedure p_delete (p_order_type_report_id In Number);
End order_type_reports_pkg;
/

Create Or Replace Package Body order_type_reports_pkg As
   Procedure p_ins_upd (
      p_order_type_report_id   In Out   Number
     ,p_order_type_code        In Out   Varchar2
     ,p_report_name            In Out   Varchar2
     ,p_template               In       Clob
   ) Is
   Begin
      Update order_type_reports
         Set order_type_code = p_order_type_code
            ,report_name = p_report_name
            ,Template = p_template
       Where order_type_report_id = p_order_type_report_id;

      If 0 = Sql%Rowcount Then
         Select main_sq.Nextval
           Into p_order_type_report_id
           From DUAL;

         Insert Into order_type_reports
                     (order_type_report_id, order_type_code, report_name, Template)
              Values (p_order_type_report_id, p_order_type_code, p_report_name, p_template);
      End If;
   End p_ins_upd;

   Procedure p_delete (p_order_type_report_id In Number) Is
   Begin
      Delete From order_type_reports
            Where order_type_report_id = p_order_type_report_id;
   End p_delete;
End order_type_reports_pkg;
/

Create Or Replace Package order_types_pkg As
   Procedure p_ins_upd (
      p_order_type_id                In Out   Number
     ,p_order_type_code              In Out   Varchar2
     ,p_order_type_name                                                                                     /* empty */
                                     In Out   Varchar2
     ,p_api_procedure_name           In Out   Varchar2
     ,p_parent_order_type_code       In Out   Varchar2
     ,p_wf_process_name              In Out   Varchar2
     ,p_view_name                    In Out   Varchar2
     ,p_form_code                    In Out   Varchar2
     ,p_entity_type_code             In Out   Varchar2
     ,p_multiple_entits_allowed_fl   In Out   Varchar2
   );

   Procedure p_delete (p_order_type_id In Out Number);

   Procedure generate_order_form (p_order_type_code Varchar2 Default 'HIRE');
End ORDER_TYPES_PKG;
/

Create Or Replace Package Body order_types_pkg As
   Procedure generate_order_form (p_order_type_code Varchar2 Default 'HIRE') As
      Type attrs_list_t Is Table Of Varchar2 (4000)
         Index By Varchar2 (4000);

      l_static_attrs_list          attrs_list_t;
      l_calculated_attrs_list      attrs_list_t;
      l_cols                       Varchar2 (32000);
      l_cols1                      Varchar2 (32000);
      l_proc_decl                  Varchar2 (32000);
      l_pks                        Varchar2 (32000);
      l_pkb                        Varchar2 (32000);
      l_text                       Varchar2 (32000);
      l_param_sel                  Varchar2 (32000);
      l_case_cl                    Varchar2 (32000);
      l_view_name                  Varchar2 (32000) := 'O_' || p_order_type_code || '_ATTRS_V';
      l_form_obj_number            Number;
      l_new_form_code              Varchar2 (4000)  := 'ORDERS_' || p_order_type_code;
      l_pkg_name                   Varchar2 (32000) := l_new_form_code || '_gen_pkg';
      --API OUT Params
      l_form_type                  Varchar2 (10)    := 'G';
      l_show_tree_root_node        Varchar2 (10)    := 'N';
      l_form_width                 Varchar2 (10)    := '0%';
      l_form_height                Varchar2 (10)    := '*';
      l_default_column_width       Varchar2 (10)    := '*';
      l_double_click_action_code   Varchar2 (10)    := Null;
      l_lookup_width               Varchar2 (10)    := Null;

      Procedure exec_command (p_text Varchar2) Is
      Begin
         Execute Immediate p_text;
      Exception
         When Others Then
            DBMS_OUTPUT.put_line (SQLERRM);
            DBMS_OUTPUT.put_line (SUBSTR ('Value of p_text=' || p_text, 1, 255));
      End;
   Begin
      For cr In
         (Select   a.ot_attribute_id, a.order_type_code, a.display_position, a.attribute_code
                  ,NVL (a.display_name, att.attribute_name) display_name, att.attribute_type
                  ,    ', DECODE (ota.attribute_code, '''
                    || a.attribute_code
                    || ''', '
                    || DECODE (att.db_expression, Null, Null, 'NVL (')
                    || DECODE (att.attribute_type
                              ,'N', 'oeav.attribute_value_number'
                              ,'D', 'oeav.attribute_value_date'
                              ,'oeav.attribute_value'
                              )
                    || DECODE (att.db_expression
                              ,Null, Null
                              ,' ,aahr_orders.db_item_utils_pkg.get_attr_val (ota.attribute_code, oe.order_entity_id))'
                              )
                    || ') As '
                    || a.attribute_code
                    || ''
                    || CHR (10) As v_col
                  , ', Max (' || a.attribute_code || ') As ' || a.attribute_code || CHR (10) As v_col1
                  ,DECODE (att.db_expression, Null, 'Y', 'N') As is_static_flag
                  ,    ', p_'
                    || LOWER (a.attribute_code)
                    || ' in out '
                    || DECODE (att.attribute_type, 'N', 'number', 'D', 'date', 'varchar2') As ins_params
                  ,    'l_params ('''
                    || a.attribute_code
                    || ''')    := p_'
                    || LOWER (a.attribute_code)
                    || ';'
                    || CHR (10) As param_sel
              From order_type_attributes a, attribute_types att
             Where a.attribute_code = att.attribute_code
               And a.order_type_code = p_order_type_code
          Order By a.display_position) Loop
         l_cols         := l_cols || cr.v_col;
         l_cols1        := l_cols1 || cr.v_col1;
         l_proc_decl    := l_proc_decl || cr.ins_params;
         l_param_sel    := l_param_sel || cr.param_sel;
         l_case_cl      :=
               l_case_cl
            || 'when l_key = '''
            || cr.attribute_code
            || ''' Then p_'
            || LOWER (cr.attribute_code)
            || '    := db_item_utils_pkg.g_attr_vals (l_key);'
            || CHR (10);

         If 'Y' = cr.is_static_flag Then
            l_static_attrs_list (cr.attribute_code)    := cr.display_name;
         Else
            l_calculated_attrs_list (cr.attribute_code)    := cr.display_name;
         End If;
      End Loop;

      exec_command ('Drop View ' || l_view_name);
      l_text         :=
            'With t As (Select o.order_id, oe.order_entity_id, oe.entity_type_code, oe.entity_id'
         || CHR (10)
         || l_cols
         || '    From orders o Join order_entities oe On o.order_id = oe.order_id
         Join order_type_attributes ota On o.order_type_code = ota.order_type_code
         Left Join order_entity_attribute_values oeav
         On oe.order_entity_id = oeav.order_entity_id
       And ota.attribute_code = oeav.attribute_code
   Where o.order_type_code =  '''
         || p_order_type_code
         || ''')
   Select   order_id, order_entity_id, entity_type_code, entity_id'
         || l_cols1
         || '       From t
   Group By order_id, order_entity_id, entity_type_code, entity_id';
      exec_command ('Create Force View ' || l_view_name || ' as ' || l_text);
      exec_command ('grant select on ' || l_view_name || ' to fc22');
      l_text         :=
                     'select t.* from aahr_orders.' || l_view_name || ' t where t.order_id = nvl(:order_id, t.order_id)';
      forms2_pkg.p_delete (l_new_form_code);
      forms_pkg.p_insert_update (p_old_form_code                 => l_new_form_code
                                ,p_form_code                     => l_new_form_code
                                ,p_hot_key                       => Null
                                ,p_sql_text                      => l_text
                                ,p_form_name                     => Null
                                ,p_description                   => Null
                                ,p_form_type                     => l_form_type
                                ,p_show_tree_root_node           => l_show_tree_root_node
                                ,p_icon_id                       => Null
                                ,p_form_width                    => l_form_width
                                ,p_form_height                   => l_form_height
                                ,p_bottom_tabs_orientation       => Null
                                ,p_side_tabs_orientation         => Null
                                ,p_show_bottom_toolbar           => 'N'
                                ,p_default_column_width          => l_default_column_width
                                ,p_object_version_number         => l_form_obj_number
                                ,p_double_click_action_code      => l_double_click_action_code
                                ,p_lookup_width                  => l_lookup_width
                                );

      Insert Into fc22.apps_privs
           Values ('AAHR', l_new_form_code);

      form_tabs_pkg.p_ins_upd (p_form_code               => l_new_form_code
                              ,p_tab_code                => 'X1'
                              ,p_child_form_code         => Null
                              ,p_tab_position            => 'R'
                              ,p_tab_name                => 'Static'
                              ,p_number_of_columns       => 4
                              ,p_icon_id                 => 1
                              ,p_tab_type                => 1
                              ,p_tab_display_number      => 1
                              );
      form_tabs_pkg.p_ins_upd (p_form_code               => l_new_form_code
                              ,p_tab_code                => 'X2'
                              ,p_child_form_code         => Null
                              ,p_tab_position            => 'R'
                              ,p_tab_name                => 'Calculated'
                              ,p_number_of_columns       => 4
                              ,p_icon_id                 => 1
                              ,p_tab_type                => 1
                              ,p_tab_display_number      => 2
                              );

      For cr In (Select *
                   From Table (form_utils.describe_form_columns_pl (l_new_form_code))) Loop
         Declare
            l_exists_in_metadata_flag   Varchar2 (10);
            l_show_on_grid              Varchar2 (10)   := 'N';
            l_column_user_name          Varchar2 (4000) := cr.column_user_name;
            l_editor_tab_code           Varchar2 (4000) := cr.editor_tab_code;
         Begin
            If l_static_attrs_list.Exists (cr.column_code) Then
               l_column_user_name    := l_static_attrs_list (cr.column_code);
               l_editor_tab_code     := 'X1';
            Elsif l_calculated_attrs_list.Exists (cr.column_code) Then
               Null;
               l_column_user_name    := l_calculated_attrs_list (cr.column_code);
               l_editor_tab_code     := 'X2';
            End If;

            If cr.column_code = 'ORDER_ENTITY_ID' Then
               cr.pimary_key_flag    := 'Y';
            End If;

            form_columns_pkg.p_ins_upd (p_form_code                     => cr.form_code
                                       ,p_column_code                   => cr.column_code
                                       ,p_column_user_name              => l_column_user_name
                                       ,p_column_display_size           => cr.column_display_size
                                       ,p_column_display_number         => cr.column_display_number
                                       ,p_pimary_key_flag               => cr.pimary_key_flag
                                       ,p_show_on_grid                  => 'N'
                                       ,p_tree_field_type               => cr.tree_field_type
                                       ,p_editor_tab_code               => l_editor_tab_code
                                       ,p_field_type                    => cr.field_type
                                       ,p_column_description            => cr.column_description
                                       ,p_is_frozen_flag                => cr.is_frozen_flag
                                       ,p_show_hover_flag               => cr.show_hover_flag
                                       ,p_column_data_type              => cr.column_data_type
                                       ,p_exists_in_metadata_flag       => l_exists_in_metadata_flag
                                       ,p_lookup_code                   => cr.lookup_code
                                       ,p_hover_column_code             => cr.hover_column_code
                                       ,p_editor_height                 => cr.editor_height
                                       ,p_lookup_field_type             => cr.lookup_field_type
                                       ,p_help_text                     => cr.help_text
                                       ,p_text_mask                     => cr.text_mask
                                       ,p_validation_regexp             => cr.validation_regexp
                                       ,p_default_orderby_number        => cr.default_orderby_number
                                       ,p_default_value                 => cr.DEFAULT_VALUE
                                       ,p_editor_title_orientation      => cr.editor_title_orientation
                                       ,p_editor_cols_span              => cr.editor_cols_span
                                       ,p_editor_end_row_flag           => cr.editor_end_row_flag
                                       ,p_lookup_display_value          => cr.lookup_display_value
                                       );
         End;
      End Loop;

      l_proc_decl    := 'procedure p_ins_upd(p_order_entity_id number' || l_proc_decl || ')';
      l_pks          := 'package ' || l_pkg_name || ' is ' || l_proc_decl || ';' || ' end ' || l_pkg_name || ';';
      exec_command ('Create or replace ' || l_pks);
      l_pkb          :=
            'package body '
         || l_pkg_name
         || ' is '
         || l_proc_decl
         || ' is'
         || CHR (10)
         || ' l_params   db_item_utils_pkg.attr_vals_t; l_key Varchar2 (4000);'
         || CHR (10)
         || 'begin'
         || CHR (10)
         || l_param_sel
         || CHR (10)
         || 'db_item_utils_pkg.init_order_entity_dbitems (p_order_entity_id);'
         || CHR (10)
         || 'For cr In (Select ota.attribute_code, oe.order_entity_id, ot.attribute_type, oeav.order_entity_attr_value_id
                   From orders o Join order_entities oe On o.order_id = oe.order_id
                        Join order_type_attributes ota On o.order_type_code = ota.order_type_code
                        Join attribute_types ot On ota.attribute_code = ot.attribute_code
                        Left Join order_entity_attribute_values oeav
                        On ota.attribute_code = oeav.attribute_code
                      And oe.order_entity_id = oeav.order_entity_id
                  Where oe.order_entity_id = p_order_entity_id) Loop
         Declare
            l_attribute_value          Varchar2 (32000);
            l_attribute_value_date     Date;
            l_attribute_value_number   Number;
         Begin
            Case
               When cr.attribute_type = ''D'' Then
                  l_attribute_value_date    := l_params (cr.attribute_code);
               When cr.attribute_type = ''N'' Then
                  l_attribute_value_number    := l_params (cr.attribute_code);
               Else
                  l_attribute_value    := l_params (cr.attribute_code);
            End Case;

            If NVL (db_item_utils_pkg.g_attr_vals (cr.attribute_code), ''###'') != NVL (l_params (cr.attribute_code), ''###'') Then
               order_entity_attr_vals_pkg.p_ins_upd (cr.order_entity_attr_value_id
                                                    ,cr.order_entity_id
                                                    ,cr.attribute_code
                                                    ,l_attribute_value
                                                    ,l_attribute_value_date
                                                    ,l_attribute_value_number
                                                    );
            End If;
         End;'
         || CHR (10)
         || 'End Loop;'
         || CHR (10)
         || 'db_item_utils_pkg.g_order_entity_id     := -1;  db_item_utils_pkg.init_order_entity_dbitems (p_order_entity_id);'
         || CHR (10)
         || 'l_params := db_item_utils_pkg.g_attr_vals; l_key := l_params.First; Loop case'
         || CHR (10)
         || l_case_cl
         || '   Else Null; End Case;'
         || CHR (10)
         || 'Exit When l_key = l_params.Last; l_key := l_params.Next (l_key); End Loop;'
         || CHR (10)
         || 'end p_ins_upd;'
         || ' end '
         || l_pkg_name
         || ';';
      exec_command ('Create or replace ' || l_pkb);
      form_actions_pkg.p_ins_upd (p_form_code                     => l_new_form_code
                                 ,p_action_code                   => 'UPD'
                                 ,p_procedure_name                => l_pkg_name || '.p_ins_upd'
                                 ,p_action_display_name           => 'Сохранить'
                                 ,p_icon_id                       => 46
                                 ,p_default_param_prefix          => Null
                                 ,p_default_old_param_prefix      => Null
                                 ,p_action_type                   => 2
                                 ,p_confirm_text                  => Null
                                 ,p_display_number                => 10
                                 ,p_hot_key                       => Null
                                 ,p_show_separator_below          => 'N'
                                 ,p_display_on_toolbar            => 'Y'
                                 ,p_child_form_code               => Null
                                 );
      Commit;
   End generate_order_form;

   Procedure p_ins_upd (
      p_order_type_id                In Out   Number
     ,p_order_type_code              In Out   Varchar2
     ,p_order_type_name              In Out   Varchar2
     ,p_api_procedure_name           In Out   Varchar2
     ,p_parent_order_type_code       In Out   Varchar2
     ,p_wf_process_name              In Out   Varchar2
     ,p_view_name                    In Out   Varchar2
     ,p_form_code                    In Out   Varchar2
     ,p_entity_type_code             In Out   Varchar2
     ,p_multiple_entits_allowed_fl   In Out   Varchar2
   ) Is
   Begin
      Update order_types
         Set order_type_code = p_order_type_code
            ,order_type_name = p_order_type_name
            ,api_procedure_name = p_api_procedure_name
            ,parent_order_type_code = p_parent_order_type_code
            ,wf_process_name = p_wf_process_name
            ,view_name = p_view_name
            ,form_code = p_form_code
            ,entity_type_code = p_entity_type_code
            ,multiple_entits_allowed_fl = p_multiple_entits_allowed_fl
       Where order_type_id = p_order_type_id;

      If 0 = Sql%Rowcount Then
         Insert Into AAHR_ORDERS.ORDER_TYPES
                     (order_type_id, order_type_code, order_type_name, api_procedure_name, parent_order_type_code
                     ,wf_process_name, view_name, form_code, entity_type_code, multiple_entits_allowed_fl)
              Values (p_order_type_id, p_order_type_code, p_order_type_name, p_api_procedure_name
                     ,p_parent_order_type_code, p_wf_process_name, p_view_name, p_form_code, p_entity_type_code
                     ,p_multiple_entits_allowed_fl)
           Returning order_type_id
                Into p_order_type_id;
      End If;
   End p_ins_upd;

   Procedure p_delete (p_order_type_id In Out Number) Is
   Begin
      Delete From AAHR_ORDERS.ORDER_TYPES
            Where order_type_id = p_order_type_id;
   End p_delete;
/*  Procedure gen_view_and_form Is
     p_order_type_code        Varchar2 (32000) := 'HIRE';
     l_cols                   Varchar2 (32000);
     l_cols1                  Varchar2 (32000);
     l_text                   Varchar2 (32000);
     l_view_name              Varchar2 (32000) := 'O_' || p_order_type_code || '_ATTRS_V';
     l_form_obj_number        Number;
     l_new_form_code          Varchar2 (4000)  := 'ORDERS_' || p_order_type_code;
     --API OUT Params
     l_form_type              Varchar2 (10)    := 'G';
     l_show_tree_root_node    Varchar2 (10)    := 'N';
     l_form_width             Varchar2 (10)    := '*';
     l_form_height            Varchar2 (10)    := '*';
     l_default_column_width   Varchar2 (10)    := '*';

     Procedure exec_command (p_text Varchar2) Is
     Begin
        Execute Immediate p_text;
     Exception
        When Others Then
           DBMS_OUTPUT.put_line (SQLERRM);
     End;
  Begin
     For cr In (Select   a.ot_attribute_id, a.order_type_code, a.display_position, a.attribute_code
                        ,NVL (a.display_name, att.attribute_name) display_name, att.attribute_type
                        ,    ', DECODE (oeav.attribute_code, '''
                          || a.attribute_code
                          || ''', oeav.'
                          || DECODE (att.attribute_type
                                    ,'N', 'attribute_value_number'
                                    ,'D', 'attribute_value_date'
                                    ,'attribute_value'
                                    )
                          || ') As '
                          || a.attribute_code
                          || ''
                          || CHR (10) As v_col
                        , ', Max (' || a.attribute_code || ') As ' || a.attribute_code || CHR (10) As v_col1
                    From order_type_attributes a, attribute_types att
                   Where a.attribute_code = att.attribute_code
                     And a.order_type_code = p_order_type_code
                Order By a.display_position) Loop
        l_cols     := l_cols || cr.v_col;
        l_cols1    := l_cols1 || cr.v_col1;
     End Loop;

     exec_command ('Drop View ' || l_view_name);
     l_text    :=
           'With t As (Select o.order_id, oe.order_entity_id, oe.entity_type_code, oe.entity_id'
        || CHR (10)
        || l_cols
        || '             From orders o Join order_entities oe On o.order_id = oe.order_id
                 Join aahr_orders.order_entity_attribute_values oeav On oe.order_entity_id = oeav.order_entity_id
           Where o.order_type_code = '''
        || p_order_type_code
        || ''')
  Select   order_id, order_entity_id, entity_type_code, entity_id'
        || l_cols1
        || '       From t
  Group By order_id, order_entity_id, entity_type_code, entity_id';
     exec_command ('Create Force View ' || l_view_name || ' as ' || l_text);
     l_text    := 'select t.* from aahr_orders.' || l_view_name || ' t';
     DBMS_OUTPUT.put_line (l_text);
     forms2_pkg.p_delete (l_new_form_code);
     forms_pkg.p_insert_update (p_form_code                    => l_new_form_code
                               ,p_hot_key                      => Null
                               ,p_sql_text                     => l_text
                               ,p_form_name                    => Null
                               ,p_description                  => Null
                               ,p_form_type                    => l_form_type
                               ,p_show_tree_root_node          => l_show_tree_root_node
                               ,p_icon_id                      => Null
                               ,p_form_width                   => l_form_width
                               ,p_form_height                  => l_form_height
                               ,p_bottom_tabs_orientation      => Null
                               ,p_side_tabs_orientation        => Null
                               ,p_show_bottom_toolbar          => 'N'
                               ,p_default_column_width         => l_default_column_width
                               ,p_object_version_number        => l_form_obj_number
                               );

     Insert Into fc22.apps_privs
          Values ('AAHR', l_new_form_code);

     Commit;
  End;*/
End ORDER_TYPES_PKG;
/

Create Or Replace Package orders_hire_gen_pkg Is
   Procedure p_ins_upd (
      p_order_entity_id                       Number
     ,p_last_name                    In Out   Varchar2
     ,p_first_name                   In Out   Varchar2
     ,p_middle_name                  In Out   Varchar2
     ,p_rnn                          In Out   Number
     ,p_hire_date                    In Out   Date
     ,p_sex                          In Out   Varchar2
     ,p_salary                       In Out   Number
     ,p_organization_id              In Out   Number
     ,p_assignment_id                In Out   Number
     ,p_labor_contract_date          In Out   Date
     ,p_labor_contract_date_txt_ru   In Out   Varchar2
     ,p_labor_contract_date_txt_kz   In Out   Varchar2
     ,p_labor_contract_num           In Out   Varchar2
     ,p_probation_period             In Out   Number
     ,p_last_name_en                 In Out   Varchar2
     ,p_full_name                    In Out   Varchar2
     ,p_order_number                 In Out   Varchar2
     ,p_order_date                   In Out   Date
     ,p_order_date_txt_ru            In Out   Varchar2
     ,p_full_name_case_ru_2          In Out   Varchar2
     ,p_full_name_case_ru_4          In Out   Varchar2
     ,p_probation_period_txt_ru      In Out   Varchar2
     ,p_hire_date_txt_ru             In Out   Varchar2
     ,p_probation_period_txt_kz      In Out   Varchar2
     ,p_hire_date_txt_kz             In Out   Varchar2
     ,p_salary_txt_kz                In Out   Varchar2
   );
End ORDERS_HIRE_gen_pkg;
/

Create Or Replace Package Body orders_hire_gen_pkg Is
   Procedure p_ins_upd (
      p_order_entity_id                       Number
     ,p_last_name                    In Out   Varchar2
     ,p_first_name                   In Out   Varchar2
     ,p_middle_name                  In Out   Varchar2
     ,p_rnn                          In Out   Number
     ,p_hire_date                    In Out   Date
     ,p_sex                          In Out   Varchar2
     ,p_salary                       In Out   Number
     ,p_organization_id              In Out   Number
     ,p_assignment_id                In Out   Number
     ,p_labor_contract_date          In Out   Date
     ,p_labor_contract_date_txt_ru   In Out   Varchar2
     ,p_labor_contract_date_txt_kz   In Out   Varchar2
     ,p_labor_contract_num           In Out   Varchar2
     ,p_probation_period             In Out   Number
     ,p_last_name_en                 In Out   Varchar2
     ,p_full_name                    In Out   Varchar2
     ,p_order_number                 In Out   Varchar2
     ,p_order_date                   In Out   Date
     ,p_order_date_txt_ru            In Out   Varchar2
     ,p_full_name_case_ru_2          In Out   Varchar2
     ,p_full_name_case_ru_4          In Out   Varchar2
     ,p_probation_period_txt_ru      In Out   Varchar2
     ,p_hire_date_txt_ru             In Out   Varchar2
     ,p_probation_period_txt_kz      In Out   Varchar2
     ,p_hire_date_txt_kz             In Out   Varchar2
     ,p_salary_txt_kz                In Out   Varchar2
   ) Is
      l_params   db_item_utils_pkg.attr_vals_t;
      l_key      Varchar2 (4000);
   Begin
      l_params ('LAST_NAME')                     := p_last_name;
      l_params ('FIRST_NAME')                    := p_first_name;
      l_params ('MIDDLE_NAME')                   := p_middle_name;
      l_params ('RNN')                           := p_rnn;
      l_params ('HIRE_DATE')                     := p_hire_date;
      l_params ('SEX')                           := p_sex;
      l_params ('SALARY')                        := p_salary;
      l_params ('ORGANIZATION_ID')               := p_organization_id;
      l_params ('ASSIGNMENT_ID')                 := p_assignment_id;
      l_params ('LABOR_CONTRACT_DATE')           := p_labor_contract_date;
      l_params ('LABOR_CONTRACT_DATE_TXT_RU')    := p_labor_contract_date_txt_ru;
      l_params ('LABOR_CONTRACT_DATE_TXT_KZ')    := p_labor_contract_date_txt_kz;
      l_params ('LABOR_CONTRACT_NUM')            := p_labor_contract_num;
      l_params ('PROBATION_PERIOD')              := p_probation_period;
      l_params ('LAST_NAME_EN')                  := p_last_name_en;
      l_params ('FULL_NAME')                     := p_full_name;
      l_params ('ORDER_NUMBER')                  := p_order_number;
      l_params ('ORDER_DATE')                    := p_order_date;
      l_params ('ORDER_DATE_TXT_RU')             := p_order_date_txt_ru;
      l_params ('FULL_NAME_CASE_RU_2')           := p_full_name_case_ru_2;
      l_params ('FULL_NAME_CASE_RU_4')           := p_full_name_case_ru_4;
      l_params ('PROBATION_PERIOD_TXT_RU')       := p_probation_period_txt_ru;
      l_params ('HIRE_DATE_TXT_RU')              := p_hire_date_txt_ru;
      l_params ('PROBATION_PERIOD_TXT_KZ')       := p_probation_period_txt_kz;
      l_params ('HIRE_DATE_TXT_KZ')              := p_hire_date_txt_kz;
      l_params ('SALARY_TXT_KZ')                 := p_salary_txt_kz;
      db_item_utils_pkg.init_order_entity_dbitems (p_order_entity_id);

      For cr In (Select ota.attribute_code, oe.order_entity_id, ot.attribute_type, oeav.order_entity_attr_value_id
                   From orders o Join order_entities oe On o.order_id = oe.order_id
                        Join order_type_attributes ota On o.order_type_code = ota.order_type_code
                        Join attribute_types ot On ota.attribute_code = ot.attribute_code
                        Left Join order_entity_attribute_values oeav
                        On ota.attribute_code = oeav.attribute_code
                      And oe.order_entity_id = oeav.order_entity_id
                  Where oe.order_entity_id = p_order_entity_id) Loop
         Declare
            l_attribute_value          Varchar2 (32000);
            l_attribute_value_date     Date;
            l_attribute_value_number   Number;
         Begin
            Case
               When cr.attribute_type = 'D' Then
                  l_attribute_value_date    := l_params (cr.attribute_code);
               When cr.attribute_type = 'N' Then
                  l_attribute_value_number    := l_params (cr.attribute_code);
               Else
                  l_attribute_value    := l_params (cr.attribute_code);
            End Case;

            If NVL (db_item_utils_pkg.g_attr_vals (cr.attribute_code), '###') !=
                                                                               NVL (l_params (cr.attribute_code), '###') Then
               order_entity_attr_vals_pkg.p_ins_upd (cr.order_entity_attr_value_id
                                                    ,cr.order_entity_id
                                                    ,cr.attribute_code
                                                    ,l_attribute_value
                                                    ,l_attribute_value_date
                                                    ,l_attribute_value_number
                                                    );
            End If;
         End;
      End Loop;

      db_item_utils_pkg.g_order_entity_id        := -1;
      db_item_utils_pkg.init_order_entity_dbitems (p_order_entity_id);
      l_params                                   := db_item_utils_pkg.g_attr_vals;
      l_key                                      := l_params.First;

      Loop
         Case
            When l_key = 'LAST_NAME' Then
               p_last_name    := db_item_utils_pkg.g_attr_vals (l_key);
            When l_key = 'FIRST_NAME' Then
               p_first_name    := db_item_utils_pkg.g_attr_vals (l_key);
            When l_key = 'MIDDLE_NAME' Then
               p_middle_name    := db_item_utils_pkg.g_attr_vals (l_key);
            When l_key = 'RNN' Then
               p_rnn    := db_item_utils_pkg.g_attr_vals (l_key);
            When l_key = 'HIRE_DATE' Then
               p_hire_date    := db_item_utils_pkg.g_attr_vals (l_key);
            When l_key = 'SEX' Then
               p_sex    := db_item_utils_pkg.g_attr_vals (l_key);
            When l_key = 'SALARY' Then
               p_salary    := db_item_utils_pkg.g_attr_vals (l_key);
            When l_key = 'ORGANIZATION_ID' Then
               p_organization_id    := db_item_utils_pkg.g_attr_vals (l_key);
            When l_key = 'ASSIGNMENT_ID' Then
               p_assignment_id    := db_item_utils_pkg.g_attr_vals (l_key);
            When l_key = 'LABOR_CONTRACT_DATE' Then
               p_labor_contract_date    := db_item_utils_pkg.g_attr_vals (l_key);
            When l_key = 'LABOR_CONTRACT_DATE_TXT_RU' Then
               p_labor_contract_date_txt_ru    := db_item_utils_pkg.g_attr_vals (l_key);
            When l_key = 'LABOR_CONTRACT_DATE_TXT_KZ' Then
               p_labor_contract_date_txt_kz    := db_item_utils_pkg.g_attr_vals (l_key);
            When l_key = 'LABOR_CONTRACT_NUM' Then
               p_labor_contract_num    := db_item_utils_pkg.g_attr_vals (l_key);
            When l_key = 'PROBATION_PERIOD' Then
               p_probation_period    := db_item_utils_pkg.g_attr_vals (l_key);
            When l_key = 'LAST_NAME_EN' Then
               p_last_name_en    := db_item_utils_pkg.g_attr_vals (l_key);
            When l_key = 'FULL_NAME' Then
               p_full_name    := db_item_utils_pkg.g_attr_vals (l_key);
            When l_key = 'ORDER_NUMBER' Then
               p_order_number    := db_item_utils_pkg.g_attr_vals (l_key);
            When l_key = 'ORDER_DATE' Then
               p_order_date    := db_item_utils_pkg.g_attr_vals (l_key);
            When l_key = 'ORDER_DATE_TXT_RU' Then
               p_order_date_txt_ru    := db_item_utils_pkg.g_attr_vals (l_key);
            When l_key = 'FULL_NAME_CASE_RU_2' Then
               p_full_name_case_ru_2    := db_item_utils_pkg.g_attr_vals (l_key);
            When l_key = 'FULL_NAME_CASE_RU_4' Then
               p_full_name_case_ru_4    := db_item_utils_pkg.g_attr_vals (l_key);
            When l_key = 'PROBATION_PERIOD_TXT_RU' Then
               p_probation_period_txt_ru    := db_item_utils_pkg.g_attr_vals (l_key);
            When l_key = 'HIRE_DATE_TXT_RU' Then
               p_hire_date_txt_ru    := db_item_utils_pkg.g_attr_vals (l_key);
            When l_key = 'PROBATION_PERIOD_TXT_KZ' Then
               p_probation_period_txt_kz    := db_item_utils_pkg.g_attr_vals (l_key);
            When l_key = 'HIRE_DATE_TXT_KZ' Then
               p_hire_date_txt_kz    := db_item_utils_pkg.g_attr_vals (l_key);
            When l_key = 'SALARY_TXT_KZ' Then
               p_salary_txt_kz    := db_item_utils_pkg.g_attr_vals (l_key);
            Else
               Null;
         End Case;

         Exit When l_key = l_params.Last;
         l_key    := l_params.Next (l_key);
      End Loop;
   End p_ins_upd;
End ORDERS_HIRE_gen_pkg;
/

Create Or Replace Package orders_pkg As
   Procedure p_delete (p_order_id In Out Number);

   Procedure p_ins_upd (
      p_order_id          In Out   Number
     ,p_order_type_code   In Out   Varchar2
     ,p_order_date        In Out   Date
     ,p_order_number      In Out   Varchar2
     ,p_form_code         In Out   Varchar2
--     ,p_report            In Out   Clob
   );

   Function get_report (p_order_id Number, p_order_type_report_id Number Default 1)
      Return Clob;
End ORDERS_PKG;
/

Grant Execute On orders_pkg To fc22
/

Create Or Replace Package Body orders_pkg As
   Function get_report (p_order_id Number, p_order_type_report_id Number Default 1)
      Return Clob Is
      l_order_type_code   Varchar2 (4000);
      l_res               Clob;
      vals                db_item_utils_pkg.attr_vals_t;
      l_key               Varchar2 (4000);
   Begin
      Select order_type_code
        Into l_order_type_code
        From ORDERS o
       Where o.order_id = p_order_id;

      Select a.Template
        Into l_res
        From order_type_reports a
       Where a.order_type_code = l_order_type_code
         And a.order_type_report_id = p_order_type_report_id
         And ROWNUM = 1;

      For cr_oe In (Select a.order_entity_id
                      From order_entities a
                     Where a.order_id = p_order_id) Loop
         Declare
         Begin
            db_item_utils_pkg.init_order_entity_dbitems (cr_oe.order_entity_id);
            vals     := db_item_utils_pkg.g_attr_vals;
            l_key    := vals.First;

            Loop
               --DBMS_OUTPUT.put_line (l_key || ': ' || vals (l_key));
               l_res    := Replace (l_res, '&amp;' || l_key || '&amp;', vals (l_key));
               Exit When l_key = vals.Last;
               l_key    := vals.Next (l_key);
            End Loop;
         End;
      End Loop;

      Return l_res;
   End get_report;

   Procedure p_ins_upd (
      p_order_id          In Out   Number
     ,p_order_type_code   In Out   Varchar2
     ,p_order_date        In Out   Date
     ,p_order_number      In Out   Varchar2
     ,p_form_code         In Out   Varchar2
--     ,p_report            In Out   clob
   ) Is
      l_entity_type_code             Varchar2 (4000);
      l_order_entity_id              Number;
      l_multiple_entits_allowed_fl   order_types.multiple_entits_allowed_fl%Type;
   Begin
      Update AAHR_ORDERS.ORDERS
         Set order_type_code = p_order_type_code
            ,order_date = p_order_date
            ,order_number = p_order_number
       Where order_id = p_order_id;

      If 0 = Sql%Rowcount Then
         Select main_sq.Nextval
           Into p_order_id
           From DUAL;

         p_order_number    := NVL (p_order_number, p_order_id || '-' || SUBSTR (p_order_type_code, 1, 1));

         Insert Into orders
                     (order_id, order_type_code, order_date, order_number)
              Values (p_order_id, p_order_type_code, p_order_date, p_order_number)
           Returning order_id
                Into p_order_id;

         Select entity_type_code, a.multiple_entits_allowed_fl, a.form_code
           Into l_entity_type_code, l_multiple_entits_allowed_fl, p_form_code
           From order_types a
          Where a.order_type_code = p_order_type_code;

--         p_report          := orders_pkg.get_report (p_order_id);
         If 'Y' != l_multiple_entits_allowed_fl Then
            order_entities_pkg.p_ins_upd (l_order_entity_id, p_order_id, l_entity_type_code, Null);
         End If;
      End If;
   End p_ins_upd;

   Procedure p_delete (p_order_id In Out Number) Is
   Begin
      Delete From AAHR_ORDERS.ORDERS
            Where order_id = p_order_id;
   End p_delete;
End ORDERS_PKG;
/

Create Or Replace Package text_utils_pkg Is
   Type t_words_arr Is Table Of Varchar2 (4000);

   Type vchar_t Is Table Of Varchar2 (2000)
      Index By Varchar2 (20);

--- Косяки:
--  1.  разобраться с разделителем, длиной больше чем 1 символ.
--  2.  Для отрицательных значений word_num должна работать как SUBSTR (влево)
   Function del_mul_separators                         --Функция заменяет множественные разделители в строке одиночными
                              (
      strng   In   Varchar2                                                                           --исходная строка
     ,symb    In   Char Default ' '                                                                --символ-разделитель
   )
      Return Varchar2;

   Function word_count                                               --Функция возвращает кол-во слов, разделенных symb
                      (
      strng   In   Varchar2                                                                           --исходная строка
     ,symb    In   Char Default ' '                                                                --символ-разделитель
   )
      Return Number;

   Function word                                                                             --Функция возвращает слово
                (
      strng      In   Varchar2                                                                        --исходная строка
     ,word_num   In   Number                                                                     --Номер слова в строке
     ,words      In   Number Default 99                                                                  -- кол-во слов
     ,symb       In   Char Default ' '                                                            -- символ-разделитель
   )
      Return Varchar2;

   Function separators (strng In Varchar2                                                             --исходная строка
                                         , symb In Char Default ' '                                --символ-разделитель
                                                                   )
      Return Varchar2;

   Function WORDS (strng In Varchar2, symb In Char Default ' ')
      Return t_words_arr Pipelined;

   Function get_translated_str (s_rus Varchar2)
      Return Varchar2;

   Function remove_numbers (strng In Varchar2)
      Return Varchar2;

   Function remove_letters (strng In Varchar2)
      Return Number;

   Function get_str_in_case (p_str Varchar2, p_lang Varchar2, p_case_number Number, p_ending_type Varchar2)
      Return Varchar2;

   Function get_reverse_str (p_str Varchar2)
      Return Varchar2;

   Function get_word_in_case (
      p_str             Varchar2
     ,p_lang            Varchar2
     ,p_case_number     Number
     ,p_ending_type     Char
     ,p_sex             Char
     ,p_initcaps_flag   Varchar2 Default 'Y'
   )
      Return Varchar2
/* FUNCTION get_str_in_case Функция преобразования строки по падежам
   ARGUMENT p_str           Преобразуемая строка
   ARGUMENT p_lang          Язык
   ARGUMENT p_case_number   Идентификатор падежа
   ARGUMENT p_ending_type   Вид преобразования 'F' - фамилия, 'I' - имя, 'O' - отчество
   ARGUMENT p_sex           Пол Мужской - M, Женский - F */
   ;

   Function number_to_lang_str (p_num Number)
      Return Varchar2;
End text_utils_pkg;
/

Grant Execute On text_utils_pkg To fc22
/
Grant Execute On text_utils_pkg To aahr
/

Create Or Replace Package Body text_utils_pkg Is
   l_nums   vchar_t;

------------------------
   Function del_mul_separators_old (strng In Varchar2,                                                --исходная строка
                                                      symb In Char Default ' '                     --символ-разделитель
                                                                              )
      Return Varchar2
--Функция заменяет множественные разделители в строке одиночными
--пока symb должен быть длиной 1. Нужна проверка. потом.
/*
--- Это круче, чем эта функция...
Select Replace (Replace (Replace ('aa     bb            cc', ' ', ' _'), '_ '), '_') d
  From DUAL;*/
   As
      result_str   Varchar2 (2000);
      temp_str     Varchar2 (2000);
      cnt          Binary_integer;
      max_loop     Number          Default 7;                         --Кол-во проходов. 7 проверенно для 500 пробелов.
                                                                      --Значения менее семи не рекомендуются.
   Begin
      result_str    := strng;

      For cnt In 1 .. max_loop Loop
         result_str    :=
                Replace (result_str, SUBSTR (TRANSLATE ('xxxxxxxxxx', '_x', '_' || symb), 1, max_loop - cnt + 1), symb);
      End Loop;

      result_str    := Ltrim (Rtrim (result_str, symb), symb);
      Return result_str;
   End del_mul_separators_old;

   Function del_mul_separators (strng In Varchar2,                                                     --исходная строка
                                                  symb In Char Default ' '                          --символ-разделитель
                                                                          )
      Return Varchar2
--Функция заменяет множественные разделители в строке одиночными
--пока symb должен быть длиной 1. Нужна проверка. потом.
   As
      result_str   Varchar2 (2000);
      l_hlp_sym    Varchar2 (1)    := '`';
   Begin
      result_str    := Replace (Replace (Replace (strng, symb, symb || l_hlp_sym), l_hlp_sym || symb), l_hlp_sym);
      result_str    := Ltrim (Rtrim (result_str, symb), symb);
      Return result_str;
   End del_mul_separators;

------------------------
   Function word_count (strng In Varchar2, symb In Char Default ' ')
--Функция возвращает кол-во слов, разделенных symb
   Return Number As
      result_str   Varchar2 (2000);
      temp_str     Varchar2 (2000);
      cnt          Binary_integer;
   Begin
      temp_str    := del_mul_separators (strng, symb);                              --Удаляем множественные разделители
      cnt         := Length (temp_str) - Length (TRANSLATE (temp_str, CHR (0) || symb, CHR (0))) + 1;
--       + LENGTH(symb);
      Return cnt;
   End word_count;

------------------------
   Function word (
      strng      In   Varchar2
     ,                                                                                                 --исходная строка
      word_num   In   Number
     ,                                                                                                     --номер слова
      words      In   Number Default 99
     ,                                                                                                    -- кол-во слов
      symb       In   Char Default ' '                                                             -- символ-разделитель
   )
      Return Varchar2 As
      first_symb_pos   Number;                                                       -- Позиция первого символа в слове
      last_symb_pos    Number;                                                    -- Позиция последнего символа в слове
      sgn_word_num     Number;                                                             -- Если <0 то с конца строки
      abs_word_num     Number;
      word_count       Number;                                                            -- Общее кол-во слов в строке
      max_words        Number;                                                                                        --
      result_str       Varchar2 (2000);
      temp_str         Varchar2 (2000);
   Begin
      sgn_word_num    := SIGN (word_num);
      abs_word_num    := ABS (word_num);
      word_count      := text_utils_pkg.word_count (strng, symb);
      temp_str        := symb || del_mul_separators (strng, symb) || symb;          --Удаляем множественные разделители

      If    (abs_word_num > word_count)
         Or word_num = 0 Then
         result_str    := Null;
         Return result_str;
      End If;

      If (words + abs_word_num > word_count) Then
         max_words    := word_count - abs_word_num + 1;
      Else
         max_words    := words;
      End If;

      If sgn_word_num > 0 Then
         first_symb_pos    := INSTR (temp_str, symb, sgn_word_num, abs_word_num) + 1;
--      first_symb_pos := INSTR (temp_str, symb, sgn_word_num, abs_word_num    ) + length(symb);
         last_symb_pos     := INSTR (temp_str, symb, sgn_word_num, abs_word_num + max_words);
      Else
         first_symb_pos    := INSTR (temp_str, symb, sgn_word_num, abs_word_num + max_words) + 1;
--      first_symb_pos := INSTR (temp_str, symb, sgn_word_num, abs_word_num + max_words) + + length(symb);
         last_symb_pos     := INSTR (temp_str, symb, sgn_word_num, abs_word_num);
      End If;

      result_str      := SUBSTR (temp_str, first_symb_pos, last_symb_pos - first_symb_pos);
      Return result_str;
   End word;

--- функцЫя овзвращающая массив слов из строки
   Function words (strng In Varchar2, symb In Char Default ' ')
      Return t_words_arr Pipelined Is
      n_count   Number;
   Begin
      n_count    := WORD_COUNT (strng, symb);

      For i In 1 .. n_count Loop
         Pipe Row (WORD (strng, i, 1, symb));
      End Loop;

      Return;
   End words;

------------------------
   Function separators (strng In Varchar2, symb In Char Default ' ')
      Return Varchar2 As
      result_str   Varchar2 (2000);
   Begin
      result_str    :=
         TRANSLATE (strng
                   ,'1 "`.,=-/()*'''
                   , '1' || symb || symb || symb || symb || symb || symb || symb || symb || symb || symb || symb || symb
                   );
      Return result_str;
   End separators;

------------------------
-- удаляет все букфы из подстроки
   Function remove_letters (strng In Varchar2)
      Return Number As
      result_str   Number;
   Begin
      result_str    := TO_NUMBER (TRANSLATE (strng, '1QWERTYUIOPASDFGHJKLZXCVBNMqwertyuiopasdfghjklzxcvbnm', '1'));
      Return result_str;
   End remove_letters;

------------------------
-- удаляет все цыфры из подстроки
   Function remove_numbers (strng In Varchar2)
      Return Varchar2 As
      result_str   Varchar2 (2000);
   Begin
      result_str    := TRANSLATE (strng, 'A0123456789', 'A');
      Return result_str;
   End remove_numbers;

------------------------
-- Функция возвращает строку в транслите
   Function get_translated_str (s_rus Varchar2)
      Return Varchar2 As
      Type abc Is Table Of Varchar2 (4)
         Index By Binary_integer;

      abc1     abc;
      Result   Varchar2 (4000);
   Begin
      If s_rus Is Null Then
         Result    := s_rus;
         Return Result;
      End If;

      abc1 (ASCII ('а'))    := 'a';
      abc1 (ASCII ('б'))    := 'b';
      abc1 (ASCII ('в'))    := 'v';
      abc1 (ASCII ('г'))    := 'g';
      abc1 (ASCII ('д'))    := 'd';
      abc1 (ASCII ('е'))    := 'e';
      abc1 (ASCII ('ё'))    := 'e';
      abc1 (ASCII ('ж'))    := 'zh';
      abc1 (ASCII ('з'))    := 'z';
      abc1 (ASCII ('и'))    := 'i';
      abc1 (ASCII ('й'))    := 'y';
      abc1 (ASCII ('к'))    := 'k';
      abc1 (ASCII ('л'))    := 'l';
      abc1 (ASCII ('м'))    := 'm';
      abc1 (ASCII ('н'))    := 'n';
      abc1 (ASCII ('о'))    := 'o';
      abc1 (ASCII ('п'))    := 'p';
      abc1 (ASCII ('р'))    := 'r';
      abc1 (ASCII ('с'))    := 's';
      abc1 (ASCII ('т'))    := 't';
      abc1 (ASCII ('у'))    := 'u';
      abc1 (ASCII ('ф'))    := 'f';
      abc1 (ASCII ('х'))    := 'h';
      abc1 (ASCII ('ц'))    := 'c';
      abc1 (ASCII ('ч'))    := 'ch';
      abc1 (ASCII ('ш'))    := 'sh';
      abc1 (ASCII ('щ'))    := 'sch';
      abc1 (ASCII ('ъ'))    := '';
      abc1 (ASCII ('ы'))    := 'y';
      abc1 (ASCII ('ь'))    := '';
      abc1 (ASCII ('э'))    := 'e';
      abc1 (ASCII ('ю'))    := 'yu';
      abc1 (ASCII ('я'))    := 'ya';
      abc1 (ASCII ('А'))    := 'A';
      abc1 (ASCII ('Б'))    := 'B';
      abc1 (ASCII ('В'))    := 'V';
      abc1 (ASCII ('Г'))    := 'G';
      abc1 (ASCII ('Д'))    := 'D';
      abc1 (ASCII ('Е'))    := 'E';
      abc1 (ASCII ('Ё'))    := 'E';
      abc1 (ASCII ('Ж'))    := 'ZH';
      abc1 (ASCII ('З'))    := 'Z';
      abc1 (ASCII ('И'))    := 'I';
      abc1 (ASCII ('Й'))    := 'Y';
      abc1 (ASCII ('К'))    := 'K';
      abc1 (ASCII ('Л'))    := 'L';
      abc1 (ASCII ('М'))    := 'M';
      abc1 (ASCII ('Н'))    := 'N';
      abc1 (ASCII ('О'))    := 'O';
      abc1 (ASCII ('П'))    := 'P';
      abc1 (ASCII ('Р'))    := 'R';
      abc1 (ASCII ('С'))    := 'S';
      abc1 (ASCII ('Т'))    := 'T';
      abc1 (ASCII ('У'))    := 'U';
      abc1 (ASCII ('Ф'))    := 'F';
      abc1 (ASCII ('Х'))    := 'H';
      abc1 (ASCII ('Ц'))    := 'C';
      abc1 (ASCII ('Ч'))    := 'CH';
      abc1 (ASCII ('Ш'))    := 'SH';
      abc1 (ASCII ('Щ'))    := 'SCH';
      abc1 (ASCII ('Ъ'))    := '';
      abc1 (ASCII ('Ы'))    := 'Y';
      abc1 (ASCII ('Ь'))    := '';
      abc1 (ASCII ('Э'))    := 'E';
      abc1 (ASCII ('Ю'))    := 'YU';
      abc1 (ASCII ('Я'))    := 'YA';

      For i In 1 .. Length (s_rus) Loop
         Begin
            Result    := Result || abc1 (ASCII (SUBSTR (s_rus, i, 1)));
         Exception
            When NO_DATA_FOUND Then
               Result    := Result || SUBSTR (s_rus, i, 1);
            When Others Then
               Raise;
         End;
      End Loop;

      Return Result;
   End get_translated_str;

   Function get_word_in_case (
      p_str             Varchar2
     ,p_lang            Varchar2
     ,p_case_number     Number
     ,p_ending_type     Char
     ,p_sex             Char
     ,p_initcaps_flag   Varchar2 Default 'Y'
   )
      Return Varchar2
/* FUNCTION get_str_in_case Функция преобразования строки по падежам
   ARGUMENT p_str           Преобразуемая строка
   ARGUMENT p_lang          Язык
   ARGUMENT p_case_number   Идентификатор падежа
   ARGUMENT p_ending_type   Вид преобразования 'F' - фамилия, 'I' - имя, 'O' - отчество
   ARGUMENT p_sex           Пол Мужской - M, Женский - F */
   As
      l_res      Varchar2 (255);
      l_str      Varchar2 (255) := TRIM (p_str);
      l_ending   Varchar2 (255);
   Begin
      Begin
         --Выбираем из таблицы окончание(подстроку) максимальной длины для данного языка, пола, падежа
         Select ending, case_ending
           Into l_ending, l_res
           From (Select e.ending, ce.case_ending, Max (Length (e.ending)) Over () max_e_len, Length (e.ending) e_len
                   From lang_endings e, lang_case_endings ce, lang_cases c
                  Where e.ending_id = ce.ending_id
                    And c.case_id = ce.case_id
                    And c.lang = p_lang
                    And c.case_number = p_case_number
                    And e.ending_type = p_ending_type
                    And NVL (e.sex, 'X') = NVL (p_sex, 'X')
                    And UPPER (l_str) Like '%' || UPPER (e.ending))
          Where max_e_len = e_len;

         l_res    := SUBSTR (l_str, 1, Length (l_str) - NVL (Length (l_ending), 0)) || l_res;
      Exception
         When NO_DATA_FOUND Then
            l_res    := l_str;
      End;

      If ('Y' = p_initcaps_flag) Then
         l_res    := INITCAP (l_res);
      End If;

      Return l_res;
   End get_word_in_case;

   Function get_str_in_case (p_str Varchar2, p_lang Varchar2, p_case_number Number, p_ending_type Varchar2)
      Return Varchar2 Is
      l_tmp    Varchar2 (32000) := p_str;
      l_res    Varchar2 (32000);
      l_word   Varchar2 (32000);
   Begin
      l_tmp    := Replace (l_tmp, '-', ' - ');
      l_tmp    := Replace (l_tmp, '.', '. ');
      l_tmp    := Replace (l_tmp, ',', ' , ');
      l_tmp    := Replace (l_tmp, '(', ' ( ');
      l_tmp    := Replace (l_tmp, ')', ' ) ');
      l_tmp    := del_mul_separators (l_tmp);

      For i In 1 .. word_count (l_tmp) Loop
         l_word    := word (l_tmp, i, 1);

         --добавить слова-исключения для ключа lang+ending_type+sex
         If Length (l_word) > 2 Then
            l_word    := get_word_in_case (l_word, p_lang, p_case_number, p_ending_type, '', 'N');
         End If;

         l_res     := l_res || ' ' || l_word;
      End Loop;

      l_res    := Replace (l_res, ' - ', '-');
      l_res    := Replace (l_res, ' ( ', ' (');
      l_res    := Replace (l_res, ' )', ')');
      l_res    := Replace (l_res, ' , ', ', ');
      l_res    := Ltrim (l_res, ' ');
      Return l_res;
   End get_str_in_case;

   Function get_reverse_str (p_str Varchar2)
      Return Varchar2 Is
      l_res   Varchar2 (32000);
   Begin
      For i In 1 .. Length (p_str) Loop
         l_res    := l_res || SUBSTR (p_str, -i, 1);
      End Loop;

      Return l_res;
   End get_reverse_str;

   /*********************
   функции расроложенные в этом блоке используются для
   получения чисел прописью
   *********************/
   Function Small_Text (p_Nnum Natural, p_Crod Char, p_Cone Varchar2, p_Ctwo Varchar2, p_Cmany Varchar2)
      Return Varchar2 Is
      l_Sotni    Constant Varchar2 (100)
         := '                сто    двести    тр'
            || 'иста четыреста   пятьсот  шестьсот   семьсот восемьсот девятьсот ';
      l_Decat    Constant Varchar2 (96)
            := '   двадцать    тридцать       сор' || 'ок   пятьдесят  шестьдесят   семьдесят восемьдесят   девяносто ';
      l_Nadcat   Constant Varchar2 (130)
         :=    '      десять  одиннадцать   двенад'
            || 'цать   тринадцать четырнадцать   пятнадцать  шест'
            || 'надцать   семнадцать восемнадцать девятнадцать ';
      l_Tri      Constant Varchar2 (49)  := '   три четыре   пять  шесть   семь восемь девять ';
      n                   Pls_integer    := TRUNC (p_Nnum / 10, -1);
      s                   Varchar2 (100) := Ltrim (SUBSTR (l_Sotni, n + 1, 10));
      Num                 Pls_integer    := p_Nnum - n * 10;
      Ctype               Varchar2 (30)  := p_Cmany;
   Begin
      n    := TRUNC (Num / 10);

      If n = 1 Then
         s    := s || Ltrim (SUBSTR (l_Nadcat, (Num - 10) * 13 + 1, 13));
      Else
         If n > 1 Then
            s      := s || Ltrim (SUBSTR (l_Decat, (n - 2) * 12 + 1, 12));
            Num    := Num - n * 10;
         End If;

         If Num > 2 Then
            s    := s || Ltrim (SUBSTR (l_Tri, (Num - 3) * 7 + 1, 7));

            If Num < 5 Then
               Ctype    := p_Ctwo;
            End If;
         Elsif Num = 2 Then
            If p_Crod In ('g', 'G') Then
               s    := s || 'две ';
            Else
               s    := s || 'два ';
            End If;

            Ctype    := p_Ctwo;
         Elsif Num = 1 Then
            If p_Crod In ('m', 'M') Then
               s    := s || 'один ';
            Elsif p_Crod In ('g', 'G') Then
               s    := s || 'одна ';
            Else
               s    := s || 'одно ';
            End If;

            Ctype    := p_Cone;
         End If;
      End If;

      Return s || Ctype;
   End;

   Function Textnumber (p_Nnum Number, p_Crod Char, p_Cone Varchar2, p_Ctwo Varchar2, p_Cmany Varchar2)
      Return Varchar2 Is
      l_Num   Number         := p_Nnum;
      s       Varchar2 (255) := '';
      n       Number;
   Begin
      If l_Num < 0 Then
         s        := 'минус ';
         l_Num    := -l_Num;
      End If;

      l_Num    := TRUNC (l_Num);

      If l_Num = 0 Then
         s    := s || 'нуль ' || p_Cmany;
      Elsif l_Num >= 1000000000000 Then
         s    := s || 'ну очень много ' || p_Cmany;
      Else
         If l_Num >= 1000000000 Then
            n        := TRUNC (l_Num / 1000000000);
            s        := s || Small_Text (n, 'm', 'миллиард ', 'миллиарда ', 'миллиардов ');
            l_Num    := l_Num - n * 1000000000;
         End If;

         If l_Num >= 1000000 Then
            n        := TRUNC (l_Num / 1000000);
            s        := s || Small_Text (n, 'm', 'миллион ', 'миллиона ', 'миллионов ');
            l_Num    := l_Num - n * 1000000;
         End If;

         If l_Num >= 1000 Then
            n        := TRUNC (l_Num / 1000);
            s        := s || Small_Text (n, 'g', 'тысяча ', 'тысячи ', 'тысяч ');
            l_Num    := l_Num - n * 1000;
         End If;

         s    := s || Small_Text (l_Num, p_Crod, p_Cone, p_Ctwo, p_Cmany);
      End If;

      Return s;
   End Textnumber;

   Function short_number_to_lang_str (p_num Number)
      Return Varchar2 Is
      l_num   Number (3, 0)   := p_num;
      l_n1    Number;
      l_n2    Number;
      l_res   Varchar2 (2000);
   Begin
      For i In Reverse 1 .. Length (l_num) Loop
         l_n2     := POWER (10, i - 1);
         l_n1     := Mod (l_num, l_n2 * 10) - Mod (l_num, l_n2);
         l_res    :=
               l_res
            || ' '
            || Case
                  When l_n2 In (1, 10) Then l_nums (l_n1)
                  When l_n1 != 100 Then l_nums (l_n1 / l_n2) || ' ' || l_nums (100)
                  Else l_nums (100)
               End;
      End Loop;

      l_res    := TRIM (l_res);
      Return l_res;
   Exception
      When Others Then
         Return Null;                                                                                        --SQLERRM;
   End short_number_to_lang_str;

   Function number_to_lang_str (p_num Number)
      Return Varchar2 Is
      --TODO Пока отсечка дробных
      l_num   Number          := TRUNC (p_num);
      l_res   Varchar2 (2000);
      l_nn1   Number;
      l_nn2   Number;
   Begin
      For j In Reverse 1 .. CEIL (Length (l_num) / 3) Loop
         l_nn1    := POWER (10, (j - 1) * 3);
         l_nn2    := TRUNC ((Mod (l_num, POWER (10, j * 3)) - Mod (l_num, POWER (10, j - 1))) / l_nn1);
         l_res    :=
               l_res
            || ' '
            || short_number_to_lang_str (l_nn2)
            || Case
                  When l_nn1 = 1 Then Null
                  When l_nums.Exists (l_nn1) Then ' ' || l_nums (l_nn1)
                  Else ' ' || l_nn1
               End;
      End Loop;

      l_res    := TRIM (l_res);
      Return l_res;
   Exception
      When Others Then
         Return SQLERRM;
   End number_to_lang_str;
Begin
   For cr In (Select lookup_value_code + 0 As digit, lv.lookup_display_value As chars
                From lookup_values lv
               Where lv.lookup_code = 'HR_NUMBERS_KZ') Loop
      l_nums (cr.digit)    := cr.chars;
   End Loop;

   l_nums (0)    := Null;
End text_utils_pkg;
/

