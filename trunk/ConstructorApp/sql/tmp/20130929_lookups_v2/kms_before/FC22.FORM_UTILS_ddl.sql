 
Create Or Replace 
Package fc22.form_utils
--Authid Current_user
As
   Type pkg_text_r Is Record (
      pkg_txt        Varchar2 (32000)
     ,pkg_body_txt   Varchar2 (32000)
   );

   Type desc_rec2 Is Record (
      col_num                Integer
     ,col_type               Varchar2 (255)
     ,col_max_len            Integer                                := 0
     ,col_name               Varchar2 (2000)                        := ''
     ,col_name_len           Integer                                := 0
     ,col_precision          Integer                                := 0
     ,col_scale              Integer                                := 0
     ,form_code              forms.form_code%Type
     ,pimary_key_flag        form_columns.pimary_key_flag%Type
     ,default_column_width   forms.default_column_width%Type
     ,column_description     form_columns.column_description%Type
   );

   Type desc_t Is Table Of desc_rec2;

   Type Desc_idx_t Is Table Of desc_rec2
      Index By Binary_integer;

   Type bind_variables_rec Is Record (
      form_code    forms.form_code%Type
     ,Position     Integer
     ,datatype     Varchar2 (255)
     ,max_length   Integer
     ,array_len    Integer
     ,bind_name    Varchar2 (255)
   );

   Type column_rec Is Record (
      column_display_number        form_columns.column_display_number%Type
     ,form_code                    form_columns.form_code%Type
     ,column_code                  form_columns.column_code%Type
     ,column_data_type             form_columns.column_data_type%Type
     ,column_user_name             form_columns.column_user_name%Type
     ,column_display_size          form_columns.column_display_size%Type
     ,pimary_key_flag              form_columns.pimary_key_flag%Type
     ,show_on_grid                 form_columns.show_on_grid%Type
     ,tree_initialization_value    form_columns.tree_initialization_value%Type
     ,tree_field_type              form_columns.tree_field_type%Type
     ,editor_tab_code              form_columns.editor_tab_code%Type
     ,field_type                   form_columns.field_type%Type
     ,column_description           form_columns.column_description%Type
     ,is_frozen_flag               form_columns.is_frozen_flag%Type
     ,show_hover_flag              form_columns.show_hover_flag%Type
     ,exists_in_metadata_flag      Varchar2 (1)
     ,exists_in_query_flag         Varchar2 (1)
     ,lookup_code                  form_columns.lookup_code%Type
     ,hover_column_code            form_columns.hover_column_code%Type
     ,editor_height                form_columns.editor_height%Type
     ,lookup_field_type            form_columns.lookup_field_type%Type
     ,help_text                    form_columns.help_text%Type
     ,text_mask                    form_columns.text_mask%Type
     ,validation_regexp            form_columns.validation_regexp%Type
     ,default_orderby_number       form_columns.default_orderby_number%Type
     ,DEFAULT_VALUE                form_columns.DEFAULT_VALUE%Type
     ,editor_title_orientation     form_columns.editor_title_orientation%Type
     ,editor_cols_span             form_columns.editor_cols_span%Type
     ,editor_end_row_flag          form_columns.editor_end_row_flag%Type
     ,lookup_display_value         form_columns.lookup_display_value%Type
     ,editor_on_enter_key_action   form_columns.editor_on_enter_key_action%Type
     ,lookup_width                 form_columns.lookup_width%Type
     ,lookup_height                form_columns.lookup_height%Type
   );

   Type form_tab_rec Is Record (
      form_code            form_tabs.form_code%Type
     ,tab_code             form_tabs.tab_code%Type
     ,child_form_code      form_tabs.child_form_code%Type
     ,tab_position         form_tabs.tab_position%Type
     ,tab_name             form_tabs.tab_name%Type
     ,number_of_columns    form_tabs.number_of_columns%Type
     ,icon_id              form_tabs.icon_id%Type
     ,tab_type             form_tabs.tab_type%Type
     ,tab_display_number   form_tabs.tab_display_number%Type
   );

   Type bind_variables_t Is Table Of bind_variables_rec;

   Type bind_variables_idx_t Is Table Of bind_variables_rec
      Index By Varchar2 (256);

   Type columns_t Is Table Of column_rec;

   Type form_tabs_t Is Table Of form_tab_rec;

   /*возвращает список столбцов - результат разбора запроса формы p_form_code.*/
   Function describe_form_columns (p_form_code Varchar2 Default Null)
      Return desc_t Pipelined;

   Function describe_form_columns (p_form_code Varchar2, p_sql_text Varchar2, p_default_column_width Varchar2)
      Return desc_t Pipelined;

   /*возвращает список столбцов - результат разбора запроса p_sql_text.*/
   Function describe_query_columns (p_sql_text Varchar2)
      Return desc_t Pipelined;

   /*Обработка p_sql_text для успешного разбора.*/
   Function get_extended_sql_text (p_sql_text Varchar2)
      Return Varchar2;

   Function get_binds
      Return bind_variables_t Pipelined;

   Function get_datatype_as_string (
      p_type          Integer
     ,p_scale         Integer Default Null
     ,p_precision     Integer Default Null
     ,p_charsetform   Integer Default Null
   )
      Return Varchar2;

   /*Pipelined ф-ция - список столбцов формы.*/
   Function describe_form_columns_pl (p_form_code Varchar2 Default Null, p_master_form_code Varchar2 Default Null)
      Return columns_t Pipelined;

   Procedure refresh_temp_columns (p_form_code Varchar2 Default Null);

   Procedure refresh_temp_columns (
      p_form_code              Varchar2
     ,p_sql_text               Varchar2
     ,p_default_column_width   Varchar2
     ,p_delete_only_flag       Varchar2 Default 'N'
   );

   Procedure err_message (p_err_message Varchar2, p_args args_t Default Null);

   Procedure check_nulls (p_vals args_t, p_msgs args_t);

   /*Динамическое создание пакета и его спецификации на основании кода, сгенерированного ф-цией GET_FORM_PKG_CLOB*/
   Procedure generate_form_pkg (
      p_form_code       Varchar2
     ,p_package_owner   Varchar2 Default Null
     ,p_table_name      Varchar2 Default Null
   );

   /*Генерация скриптов вставки для одной из сущностей формы*/
   Function get_entity_insetrs (p_entity_type Varchar2, p_form_code Varchar2)
      Return Clob;

   /*Генерация скриптов для формы*/
   Function get_inserts (p_form_code Varchar2)
      Return Clob;

   /*Генерация скриптов для clob-полей*/
   Function get_clob_upd (p_form_code Varchar2 Default Null)
      Return Clob;

   /*Выборка табиков формы - выведено в функцию для упрощения модификации без перекомпиляции Java кода среднего слоя*/
   Function get_form_tabs (p_form_code Varchar2 Default Null, p_master_form_code Varchar2 Default Null)
      Return form_tabs_t Pipelined;

   /*Замена переменных вида &var в тексте запроса*/
   Function replace_user_variables (p_text Varchar2)
      Return Varchar2;

   /*Генерация пакета для формы*/
   Function get_form_pkg_clob (
      p_form_code       Varchar2
     ,p_package_owner   Varchar2 Default Null
     ,p_table_name      Varchar2 Default Null
   )
      Return Clob;

   /*Скрипты форм по всему приложению*/
   Function get_app_forms_scripts (p_apps_code Varchar2)
      Return Clob;

   /*Скрипты колонок таблиц по схеме*/
   Function get_table_cols_scripts (p_schema Varchar2)
      Return Clob;

   /*Получение буфера DBMS_OUTPUT в таблицу*/
   Function get_dbms_output
      Return Clob;
End form_utils;
/

-- Grants for Package
Grant Execute On fc22.form_utils To prw
/
Grant Execute On fc22.form_utils To xxwo
/
Grant Execute On fc22.form_utils To fc22_admin
/
Grant Execute On fc22.form_utils To apps
/

Create Or Replace 
PACKAGE BODY fc22.form_utils As
   g_bind_variables   bind_variables_idx_t;

   Cursor forms_cur (c_form_code Varchar2) Is
      Select NVL (c_form_code, f.form_code) form_code, f.sql_text, f.default_column_width
        From forms f
       Where f.form_code = NVL (c_form_code, f.form_code);

   Function get_datatype_as_string (
      p_type          Integer
     ,p_scale         Integer Default Null
     ,p_precision     Integer Default Null
     ,p_charsetform   Integer Default Null
   )
      Return Varchar2 Is
      l_res   Varchar2 (255);
   Begin
      Select DECODE (p_type
                    ,1, DECODE (p_charsetform, 2, 'NVARCHAR2', 'VARCHAR2')
                    ,2, DECODE (p_scale, Null, DECODE (p_precision, Null, 'NUMBER', 'FLOAT'), 'NUMBER')
                    ,8, 'LONG'
                    ,9, DECODE (p_charsetform, 2, 'NCHAR VARYING', 'VARCHAR')
                    ,12, 'DATE'
                    ,23, 'RAW'
                    ,24, 'LONG RAW'
                    ,69, 'ROWID'
                    ,96, DECODE (p_charsetform, 2, 'NCHAR', 'CHAR')
                    ,100, 'BINARY_FLOAT'
                    ,101, 'BINARY_DOUBLE'
                    ,105, 'MLSLABEL'
                    ,106, 'MLSLABEL'
                    ,112, DECODE (p_charsetform, 2, 'NCLOB', 'CLOB')
                    ,113, 'BLOB'
                    ,114, 'BFILE'
                    ,115, 'CFILE'
                    ,178, 'TIME(' || p_scale || ')'
                    ,179, 'TIME(' || p_scale || ')' || ' WITH TIME ZONE'
                    ,180, 'TIMESTAMP(' || p_scale || ')'
                    ,181, 'TIMESTAMP(' || p_scale || ')' || ' WITH TIME ZONE'
                    ,231, 'TIMESTAMP(' || p_scale || ')' || ' WITH LOCAL TIME ZONE'
                    ,182, 'INTERVAL YEAR(' || p_precision || ') TO MONTH'
                    ,183, 'INTERVAL DAY(' || p_precision || ') TO SECOND(' || p_scale || ')'
                    ,208, 'UROWID'
                    ,'UNDEFINED'
                    )
        Into l_res
        /*,58,111,121,122,123, NVL2 (ac.synobj#, (Select o.Name From obj$ o Where o.obj# = ac.synobj#), ot.Name)*/
      From   DUAL;

      Return l_res;
   End get_datatype_as_string;

   Function replace_user_variables (p_text Varchar2)
      Return Varchar2 Is
      l_res   Varchar2 (32000) := p_text;
   Begin
      l_res    := REGEXP_REPLACE (l_res, '&fc_schema_owner.', applications_pkg.get_fc_schema, 1, 0, 'i');
      l_res    := REGEXP_REPLACE (l_res, '&db_username.', User, 1, 0, 'i');
      Return l_res;
   End;

   Function get_extended_sql_text (p_sql_text Varchar2)
      Return Varchar2 Is
      l_result              Varchar2 (4000);
      l_last_order_by_pos   Number;
   Begin
      --Отсекаем последний order by, чтобы сортировка не летела...
      l_last_order_by_pos    := REGEXP_INSTR (p_sql_text, '(order\s+by.+)$', 1, 1, 0, 'i');

      If l_last_order_by_pos > 0 Then
         l_result    := SUBSTR (p_sql_text, 1, l_last_order_by_pos - 1);
      Else
         l_result    := p_sql_text;
      End If;

      l_result               := replace_user_variables (l_result);
      Return l_result;
   --Return 'select row_number() over(order by 2) - 0 rn, t.*, count(*) over() cnt from (' || p_sql_text || ') t';
   End get_extended_sql_text;

/*   Function describe_columns (p_sql_text Varchar2, p_form_code Varchar2 Default Null)
      Return DBMS_SQL.desc_tab Is
      cur          Number;
      col_count    Pls_integer;
      l_result     DBMS_SQL.desc_tab;
      l_sql_text   Varchar2 (4000)   := get_extended_sql_text (p_sql_text);
   Begin
      cur    := DBMS_SQL.open_cursor;
      DBMS_SQL.parse (cur, l_sql_text, DBMS_SQL.native);
      DBMS_SQL.describe_columns (cur, col_count, l_result);
      / * Проблема в Oracle 9.2 - нет столбца v$sql_cursor.child_handle - убрал до лучших времен для совместимости
            For Binds In (Select Distinct p_form_code form_code, m.Position, get_datatype_as_string (m.datatype) datatype
                                         --
                                          ,m.max_length, m.array_len, m.bind_name
                                     From v$sql_bind_metadata m, v$sql_cursor c
                                    Where c.child_handle = m.address
                                      And c.curno = cur
                                 Order By m.Position) Loop
               g_bind_variables (Binds.form_code || Binds.Position)    := Binds;
            End Loop;
      * /
      DBMS_SQL.close_cursor (cur);
      raise_application_error(-20001, 'User:'||user);
      Return l_result;
   Exception
      When Others Then
         DBMS_OUTPUT.put_line (SQLERRM);
         DBMS_OUTPUT.put_line (SUBSTR ('Value of l_sql_text=' || l_sql_text, 1, 255));

         If DBMS_SQL.is_open (cur) Then
            DBMS_SQL.close_cursor (cur);
         End If;

         l_result.Delete;
         Return l_result;
   End describe_columns;*/
   Function get_binds
      Return bind_variables_t Pipelined Is
      l_str   Varchar2 (256) := g_bind_variables.First;
   Begin
      Loop
         Pipe Row (g_bind_variables (l_str));
         Exit When l_str = g_bind_variables.Last;
         l_str    := g_bind_variables.Next (l_str);
      End Loop;

      Return;
   End get_binds;

   Function convert_to_desc_t_idx (dsc DBMS_SQL.desc_tab, p_form_code Varchar2 Default Null)
      Return desc_idx_t Is
      l_result   desc_idx_t;
   Begin
      For i In dsc.First .. dsc.Last Loop
         l_result (i).form_code        := p_form_code;
         l_result (i).col_num          := i;
         l_result (i).col_max_len      := dsc (i).col_max_len;
         l_result (i).col_name         := dsc (i).col_name;
         l_result (i).col_name_len     := dsc (i).col_name_len;
         l_result (i).col_precision    := dsc (i).col_precision;
         l_result (i).col_scale        := dsc (i).col_scale;
         l_result (i).col_type         :=
            get_datatype_as_string (dsc (i).col_type, dsc (i).col_scale, dsc (i).col_precision
                                   ,dsc (i).col_charsetform);
      End Loop;

      Return l_result;
   End convert_to_desc_t_idx;

   Function describe_query_columns (p_sql_text Varchar2)
      Return desc_t Pipelined Is
      src        desc_idx_t := convert_to_desc_t_idx (form_auth_cur_user_utlis_pkg.describe_columns (p_sql_text));
      l_result   desc_rec2;
   Begin
      For i In src.First .. src.Last Loop
         Pipe Row (src (i));
      End Loop;

      Return;
   End describe_query_columns;

   Function describe_form_columns_pl (p_form_code Varchar2 Default Null, p_master_form_code Varchar2 Default Null)
      Return columns_t Pipelined Is
      i       Binary_integer := 1;
      l_rec   column_rec;
   Begin
      For cc In (Select   NVL (stat.column_display_number, 1000 + dyn.col_num) column_display_number
                         ,NVL (stat.form_code, dyn.form_code) form_code
                         ,NVL (stat.column_code, dyn.col_name) column_code
                         ,NVL (stat.column_data_type, dyn.col_type) column_data_type
                         ,NVL (stat.column_user_name
                              ,SUBSTR (Ltrim (Replace (dyn.column_description, dyn.col_name, ''), '*'), 1, 100)
                              ) column_user_name
                         ,NVL (NVL (stat.column_display_size, default_column_width), '*')
                         ,NVL (stat.pimary_key_flag, dyn.pimary_key_flag) pimary_key_flag
                         ,NVL (stat.show_on_grid, 'Y') show_on_grid, stat.tree_initialization_value
                         ,NVL (stat.tree_field_type, DECODE (dyn.pimary_key_flag, 'Y', 1)) tree_field_type
                         ,stat.editor_tab_code, stat.field_type
                         ,NVL (stat.column_description, dyn.column_description) column_description
                         ,NVL (stat.is_frozen_flag, 'N'), NVL (stat.show_hover_flag, 'N')
                         ,NVL2 (stat.column_code, 'Y', 'N') exists_in_metadata_flag
                         ,NVL2 (dyn.col_name, 'Y', 'N') exists_in_query_flag, stat.lookup_code, stat.hover_column_code
                         ,stat.editor_height, NVL (stat.lookup_field_type, DECODE (dyn.pimary_key_flag, 'Y', 1))
                         ,stat.help_text, stat.text_mask, stat.validation_regexp, stat.default_orderby_number
                         ,stat.DEFAULT_VALUE
                         ,NVL (stat.editor_title_orientation
                              ,DECODE (stat.field_type, '4', 'T', '5', 'T', 'L')
                              ) editor_title_orientation
                         ,NVL (stat.editor_cols_span, '*') editor_cols_span
                         ,NVL (stat.editor_end_row_flag, 'Y') editor_end_row_flag, stat.lookup_display_value
                         ,stat.editor_on_enter_key_action, stat.lookup_width, stat.lookup_height
                     From (Select *
                             From form_columns c
                            Where c.form_code = NVL (p_form_code, c.form_code)
                            /*  And Exists (Select 1 From forms_v f  Where f.form_code = c.form_code)*/
                          ) stat
                          Full Outer Join
                          (Select *
                             From form_columns$ c
                            Where c.form_code = NVL (p_form_code, c.form_code)) dyn
                          On stat.form_code = dyn.form_code
                        And dyn.col_name = stat.column_code
                 Order By form_code, column_display_number, column_code) Loop
         cc.column_data_type    :=
            Case
               When cc.column_data_type = 'NUMBER' Then 'N'
               When cc.column_data_type = 'VARCHAR2' Then 'S'
               When cc.column_data_type = 'CHAR' Then 'S'
               When cc.column_data_type = 'DATE' Then 'D'
               Else cc.column_data_type
            End;
         --User Hook
         DBMS_OUTPUT.put_line ('form_code = ' || cc.form_code);
         form_utils_customization.customize_column_metadata (i, cc, p_master_form_code);
         Pipe Row (cc);
         i                      := i + 1;
      End Loop;

/*Для алертов.
      l_rec                          := Null;
      l_rec.form_code                := p_form_code;
      l_rec.column_code              := 'STATUS_LEVEL';
      l_rec.column_display_number    := -1;
      l_rec.show_on_grid             := 'Y';
      Pipe Row (l_rec);
      */
      Return;
   End describe_form_columns_pl;

   Procedure refresh_temp_columns (
      p_form_code              Varchar2
     ,p_sql_text               Varchar2
     ,p_default_column_width   Varchar2
     ,p_delete_only_flag       Varchar2 Default 'N'
   ) Is
   Begin
      Delete From form_columns$ a
            Where p_form_code = a.form_code;
--20130611 - Заменить на Merge - теряются form_column_actions
      If 'Y' != p_delete_only_flag Then
         For cr In (Select col_num, col_type, col_max_len, col_name, col_name_len, col_precision, col_scale, form_code
                          ,pimary_key_flag, default_column_width, column_description
                      From Table (form_utils.describe_form_columns (p_form_code, p_sql_text, p_default_column_width))) Loop
            Insert Into form_columns$
                        (col_num, col_type, col_max_len, col_name, col_name_len, col_precision, col_scale, form_code
                        ,pimary_key_flag, default_column_width, column_description)
                 Values (cr.col_num, cr.col_type, cr.col_max_len, cr.col_name, cr.col_name_len, cr.col_precision
                        ,cr.col_scale, cr.form_code, cr.pimary_key_flag, cr.default_column_width
                        ,cr.column_description);
         /*Select *
         From Table (form_utils.describe_form_columns (p_form_code, p_sql_text, p_default_column_width));*/
         End Loop;
      End If;
   End;

   Procedure refresh_temp_columns (p_form_code Varchar2 Default Null) Is
   Begin
      For cur In forms_cur (p_form_code) Loop
         refresh_temp_columns (cur.form_code, cur.sql_text, cur.default_column_width);
      End Loop;
   End;

   Function describe_form_columns (p_form_code Varchar2, p_sql_text Varchar2, p_default_column_width Varchar2)
      --по одной форме
   Return desc_t Pipelined Is
      src              desc_idx_t;
      l_result         desc_rec2;

      Type primary_keys_type Is Table Of Binary_integer
         Index By Varchar2 (100);

      l_primary_keys   primary_keys_type;
   Begin
      Begin
         src    :=
            convert_to_desc_t_idx (form_auth_cur_user_utlis_pkg.describe_columns (p_sql_text, p_form_code)
                                  ,p_form_code);

         -- Пытаемся получить первичные ключи, предполагая, что имя формы соответствует имени таблички. Owner пока не анализируем
         For cp In (Select   cc.column_name, cc.Position
                        From all_constraints c, all_cons_columns cc
                       Where c.table_name = p_form_code
                         And c.constraint_type In ('U', 'P')
                         And c.owner = cc.owner
                         And c.table_name = cc.table_name
                         And c.constraint_name = cc.constraint_name
                    Order By cc.Position) Loop
            l_primary_keys (cp.column_name)    := cp.Position;
         End Loop;

         For i In src.First .. src.Last Loop
            If l_primary_keys.Exists (src (i).col_name) Then
               src (i).pimary_key_flag    := 'Y';
            End If;

            --Леша тут бага берет описание с других таблиц:)Хотя наверног тут есть какоенить обьяснение
            Select '*' || NVL (Min (cm.comments), '*' || src (i).col_name)
              Into src (i).column_description
              From all_col_comments cm
             Where cm.column_name = src (i).col_name                              --NVL (stat.column_code, dyn.col_name)
               And cm.comments Is Not Null;

            src (i).default_column_width    := p_default_column_width;
            Pipe Row (src (i));
         End Loop;
      Exception
         When Others Then
--            DBMS_OUTPUT.Enable ();
            DBMS_OUTPUT.put_line ('Error on form: ' || p_form_code);
            DBMS_OUTPUT.put_line (SQLERRM);
--            DBMS_OUTPUT.Disable;
--TODO
--            Raise;
      End;
   End describe_form_columns;

   Function describe_form_columns (p_form_code Varchar2 Default Null)
      Return desc_t Pipelined Is
   Begin
      For cur In forms_cur (p_form_code) Loop
         For cf In (Select *
                      From Table (form_utils.describe_form_columns (cur.form_code
                                                                   ,cur.sql_text
                                                                   ,cur.default_column_width
                                                                   )
                                 )) Loop
            Pipe Row (cf);
         End Loop;
      End Loop;

      Return;
   End describe_form_columns;

   Function get_form_pkg_text (
      p_form_code       Varchar2
     ,p_package_owner   Varchar2 Default Null
     ,p_table_name      Varchar2 Default Null
   )
      Return pkg_text_r Is
      l_param_list       Varchar2 (4000);
      l_upd_set_list     Varchar2 (4000);
      l_upd_where_list   Varchar2 (4000);
      l_ins_col_list     Varchar2 (4000);
      l_ins_vals_list    Varchar2 (4000);
      l_owner_prefix     Varchar2 (4000);
      l_pkg_suffix       Varchar2 (4000) := '_PKG';
      l_pkg_name         Varchar2 (4000);
      l_table_name       Varchar2 (4000);
      l_pkg_end_name     Varchar2 (4000);
      l_res              pkg_text_r;
   Begin
      For cc In (Select   NVL2 (p_package_owner, p_package_owner || '.', '') owner_prefix
                         ,LOWER (column_code) column_code
                         ,DECODE (column_data_type, 'N', 'number', 'varchar2') column_data_type
                     From Table (form_utils.describe_form_columns_pl (p_form_code)) t
                 Order By column_display_number) Loop
         l_param_list        :=
                          l_param_list || CHR (10) || ',' || 'p_' || cc.column_code || ' in out '
                          || cc.column_data_type;
         l_upd_set_list      := l_upd_set_list || CHR (10) || ',' || cc.column_code || ' = p_' || cc.column_code;
         l_upd_where_list    := l_upd_where_list || CHR (10) || ' and ' || cc.column_code || ' = p_' || cc.column_code;
         l_ins_col_list      := l_ins_col_list || CHR (10) || ',' || cc.column_code;
         l_ins_vals_list     := l_ins_vals_list || CHR (10) || ',' || 'p_' || cc.column_code;
         l_owner_prefix      := cc.owner_prefix;
      End Loop;

      l_param_list          := SUBSTR (l_param_list, 3);
      l_upd_set_list        := SUBSTR (l_upd_set_list, 3);
      l_upd_where_list      := SUBSTR (l_upd_where_list, 7);
      l_ins_col_list        := SUBSTR (l_ins_col_list, 3);
      l_ins_vals_list       := SUBSTR (l_ins_vals_list, 3);
      l_table_name          := UPPER (l_owner_prefix || NVL (p_table_name, p_form_code));
      l_pkg_name            := l_table_name || l_pkg_suffix;
      l_pkg_end_name        := UPPER (NVL (p_table_name, p_form_code)) || l_pkg_suffix;
      l_res.pkg_txt         :=
            Replace (Xmltype ('<x/>').getClobVal (), '<x/>', '')
         || 'create package '
         || l_pkg_name
         || ' as '
         || ' end '
         || l_pkg_end_name
         || ';';
      l_res.pkg_body_txt    :=
            Replace (Xmltype ('<x/>').getClobVal (), '<x/>', '')
         || 'create package body '
         || l_pkg_name
         || ' as '
         || 'procedure p_ins_upd ('
         || l_param_list
         || ') is begin update '
         || l_table_name
         || ' set '
         || l_upd_set_list
         || ' where '
         || l_upd_where_list
         || '; if sql%rowcount=0 then Select main_sq.Nextval Into p_id From dual; '
         || 'insert into '
         || l_table_name
         || '('
         || l_ins_col_list
         || ') values('
         || l_ins_vals_list
         || '); end if; end p_ins_upd;'
         || 'procedure p_delete ('
         || l_param_list
         || ') is begin delete from '
         || l_table_name
         || ' where '
         || l_upd_where_list
         || '; end p_delete;'
         || ' end '
         || l_pkg_end_name
         || ';';
      Return l_res;
   Exception
      When Others Then
         l_res.pkg_txt    := SQLERRM;
         Return l_res;
   End get_form_pkg_text;

   Function get_form_pkg_clob (
      p_form_code       Varchar2
     ,p_package_owner   Varchar2 Default Null
     ,p_table_name      Varchar2 Default Null
   )
      Return Clob Is
      l_pkg   pkg_text_r := get_form_pkg_text (p_form_code, p_package_owner, p_table_name);
      l_res   Clob;
   Begin
      l_res    := l_pkg.pkg_txt || chr(10) ||'/' || chr(10) || l_pkg.pkg_body_txt || chr(10) || '/';
      Return l_res;
   End get_form_pkg_clob;

   Procedure generate_form_pkg (
      p_form_code       Varchar2
     ,p_package_owner   Varchar2 Default Null
     ,p_table_name      Varchar2 Default Null
   ) Is
      l_pkg   pkg_text_r := get_form_pkg_text (p_form_code, p_package_owner, p_table_name);
   Begin
      Begin
         Execute Immediate l_pkg.pkg_txt;
      Exception
         When Others Then
            DBMS_OUTPUT.put_line (SQLERRM);
      End;

      Begin
         Execute Immediate l_pkg.pkg_body_txt;
      Exception
         When Others Then
            DBMS_OUTPUT.put_line (SQLERRM);
      End;
   End generate_form_pkg;

   --f("не указаны колонки %1 на дату %2. Всетаки укажите колонки %1"
   --,"sdfds",sysdate
   --)
   Procedure err_message (p_err_message Varchar2, p_args args_t Default Null) As
   Begin
      raise_application_error (-20001, TEXT_UTILS.format (p_err_message, p_args));
   End err_message;

   Procedure check_nulls (p_vals args_t, p_msgs args_t) As
      l_msg   Varchar2 (32000) := Null;
   Begin
      For i In 1 .. p_vals.Count Loop
         If p_vals (i) Is Null Then
            l_msg    := l_msg || p_msgs (i) || CHR (10);
         End If;
      End Loop;

      If l_msg Is Not Null Then
         err_message (l_msg);
      End If;
   End check_nulls;

   Function get_entity_insetrs (p_entity_type Varchar2, p_form_code Varchar2)
      Return Clob Is
      Type charArr Is Table Of Varchar2 (32000)
         Index By Binary_integer;

      l_res        Clob              := '/*  Form: ' || p_form_code || '. Entity: ' || p_entity_type || '.  */';
      l_str        Varchar2 (32000);
      l_ins_into   Varchar2 (32000);
      p_select     Varchar2 (2000)   := 'select * from ' || p_entity_type || ' where form_code=:p_form_code';
      l_char_arr   charArr;
      l_tmp        Clob;
      c            Integer;
      col_cnt      Integer;
      rows_cnt     Integer;
      desc_t       DBMS_SQL.DESC_TAB;
   Begin
      c             := DBMS_SQL.open_cursor;
      DBMS_SQL.PARSE (c, p_select, DBMS_SQL.NATIVE);
      DBMS_SQL.DESCRIBE_COLUMNS (c, col_cnt, desc_t);

      For j In 1 .. col_cnt Loop
         l_str    := l_str || ', "' || desc_t (j).col_name || '"';

         If DBMS_TYPES.typecode_clob = desc_t (j).col_type Then
            DBMS_SQL.define_column (c, j, l_tmp);
         Else
            l_char_arr (j)    := Null;
            DBMS_SQL.define_column (c, j, l_char_arr (j), 32000);
         End If;
      End Loop;

      l_ins_into    :=
            CHR (10) || CHR (10) || 'insert into ' || p_entity_type || '(' || SUBSTR (l_str, 3) || ') values ('
            || CHR (10);
      DBMS_SQL.bind_variable (c, 'p_form_code', p_form_code);
      rows_cnt      := DBMS_SQL.Execute (c);

      Loop
         If DBMS_SQL.fetch_rows (c) = 0 Then
            Exit;
         End If;

         l_res    := l_res || l_ins_into;

         For j In 1 .. col_cnt Loop
            If j != 1 Then
               l_res    := l_res || CHR (10) || ',';
            End If;

            --Проблема с длинными Clob
            If DBMS_TYPES.typecode_clob = desc_t (j).col_type Then
               DBMS_SQL.COLUMN_VALUE (c, j, l_tmp);
--               l_res    := l_res || '''' || Replace (l_tmp, '''', '''''') || '''';
               l_res    := l_res || '''' || Null || '''';
            Else
               DBMS_SQL.COLUMN_VALUE (c, j, l_char_arr (j));
               l_res    := l_res || '''' || Replace (l_char_arr (j), '''', '''''') || '''';
            End If;
         End Loop;

         l_res    := l_res || ');';
      End Loop;

      DBMS_SQL.close_cursor (c);
      Return l_res;
   End get_entity_insetrs;

   Function get_clob_upd (p_form_code Varchar2 Default Null)
      Return Clob Is
      l_res   Clob;
   Begin
      For cr In (Select    'Declare l_clob   Clob := '''
                        || Replace (f.description, '''', '''''')
                        || '''; Begin Update FORMS Set description = l_clob Where form_code = '''
                        || NVL (p_form_code, f.form_code)
                        || '''; End;'
                        || CHR (10)
                        || CHR (47) txt
                   From forms f
                  Where f.description Is Not Null
                    And f.form_code = NVL (p_form_code, f.form_code)) Loop
         l_res    := l_res || CHR (10) || cr.txt;
      End Loop;

      For cr In (Select    'Declare l_clob   Clob := '''
                        || Replace (f.help_text, '''', '''''')
                        || ''';  Begin Update FORM_COLUMNS Set help_text = l_clob Where form_code = '''
                        || NVL (p_form_code, f.form_code)
                        || ''' and column_code = '''
                        || f.column_code
                        || '''; End;'
                        || CHR (10)
                        || CHR (47) txt
                   From form_columns f
                  Where f.help_text Is Not Null
                    And f.form_code = NVL (p_form_code, f.form_code)) Loop
         l_res    := l_res || CHR (10) || cr.txt;
      End Loop;

      Return l_res;
   End get_clob_upd;

   Function get_inserts (p_form_code Varchar2)
      Return Clob Is
      Type t Is Table Of Varchar2 (2000);

      l_tables_list   t
         := t ('FORMS'
              ,'FORM_TABS'
              ,'FORM_ACTIONS'
              ,'FORM_COLUMNS$'
              ,'FORM_COLUMNS'
              ,'FORM_COLUMN_ATTR_VALS'
              ,'FORM_TAB_PARENT_EXCLNS'
              ,'FORM_TAB_CHILDS_ALLOWED'
              ,'APPS_PRIVS'
              );
      l_res           Clob;
   Begin
      For i In Reverse l_tables_list.First .. l_tables_list.Last Loop
         l_res    :=
             l_res || 'delete from ' || l_tables_list (i) || ' where form_code = ''' || p_form_code || ''';'
             || CHR (10);
      End Loop;

      For i In l_tables_list.First .. l_tables_list.Last Loop
         l_res    := l_res || form_utils.get_entity_insetrs (l_tables_list (i), p_form_code) || CHR (10);
      End Loop;

      l_res    :=
            '
Alter Table FORMS Disable All Triggers;
Alter Table forms Disable Constraint forms_form_actions_fk;'
         || CHR (10)
         || l_res
         || CHR (10)
         || get_clob_upd (p_form_code)
         || CHR (10)
         || '
Alter Table forms Enable VALIDATE Constraint forms_form_actions_fk;
Alter Table FORMS Enable All Triggers;';
      Return l_res;
   End get_inserts;

   Function get_form_tabs (p_form_code Varchar2 Default Null, p_master_form_code Varchar2 Default Null)
      Return form_tabs_t Pipelined Is
      l_ebs_responsibility_id Number := apps.fnd_global.resp_id;
   Begin
      For cr In (Select   ft.form_code, ft.tab_code, ft.child_form_code, NVL (ft.tab_position, 'R') tab_position
                         ,NVL (ft.tab_name, (Select NVL (f.form_name, f.form_code)
                                               From forms f
                                              Where f.form_code = ft.child_form_code)) tab_name
                         ,NVL (ft.number_of_columns, 2) number_of_columns
                         ,NVL (ft.icon_id, (Select f.icon_id
                                              From forms f
                                             Where f.form_code = ft.child_form_code)) icon_id, ft.tab_type
                         ,tab_display_number
                     From form_tabs ft
                    Where ft.form_code = NVL (p_form_code, ft.form_code)
                      --Не отображаем табики, которые не нужно показывать, если есть форма-родитель
                      -- dos04092013
                      And Not Exists (
                             Select Null
                               From
                               (Select *
                                 From apps_role_menus t
                                Start With t.parent_menu_code =
                                           (Select r.root_menu_code
                                              From apps_roles r
                                             Where r.external_role_id = l_ebs_responsibility_id)
                               Connect By Prior t.menu_code = t.parent_menu_code) t
                                Where t.entity_type In ('EDIT_FRM', 'TAB')
                                  And t.enabled_flag = 'N'
                                  And nvl(t.master_form_code,'#') = nvl(p_master_form_code,'#')
                                  And t.parent_form_code = p_form_code
                                  And t.menu_code = ft.tab_code
                               --
                              )
                      And Not Exists (
                             Select 1
                               From form_tab_parent_exclns a
                              Where a.form_code = ft.form_code
                                And a.parent_form_code = p_master_form_code
                                And a.included_flag = 'N'
                                And a.tab_code = ft.tab_code)
                 Order By tab_display_number, tab_name, tab_code) Loop
         Pipe Row (cr);
      End Loop;

      Return;
   End get_form_tabs;

   Function get_app_forms_scripts (p_apps_code Varchar2)
      Return Clob Is
      l_res   Clob;
   Begin
      For cr In (Select   a.export_order, a.form_code, a.form_name, FORM_UTILS.get_inserts (a.form_code)
                                                                                                        As form_script
                     From forms a
                    Where a.apps_code = p_apps_code
                 Order By a.export_order, a.form_code) Loop
         l_res    := l_res || CHR (10) || '/*****************' || cr.form_code || '*********************/' || CHR (10);
         l_res    := l_res || cr.form_script || CHR (10);
      End Loop;

      Return l_res;
   End get_app_forms_scripts;

   Function get_table_cols_scripts (p_schema Varchar2)
      Return Clob Is
      l_cols           Clob;
      l_col_comments   Clob;
      l_res            Clob;
   Begin
      For cr In (With t As
                      (
                         Select   utc.table_name, utc.column_name, utc.data_type, utc.data_length, utc.data_precision
                                 ,utc.data_scale, ucc.comments
                             From all_tab_columns utc, all_col_comments ucc
                            Where utc.table_name = ucc.table_name
                              And utc.column_name = ucc.column_name
                              And utc.owner = ucc.owner
                              And utc.owner = p_schema
                              And utc.table_name Not In ('SQLN_EXPLAIN_PLAN')
                         Order By utc.table_name, utc.column_id)
                 Select t.table_name, t.column_name
                       ,    'alter table "'
                         || t.table_name
                         || '" add "'
                         || t.column_name
                         || '" '
                         || LOWER (   t.data_type
                                   || DECODE (t.data_type
                                             ,'VARCHAR2', '(' || t.data_length || ')'
                                             ,'NUMBER', '(' || t.data_length || ', ' || NVL (t.data_precision, 0) || ')'
                                             )
                                  )
                         || ';' As colmn
                       ,DECODE (t.comments
                               ,Null, Null
                               ,    'Comment On Column "'
                                 || t.table_name
                                 || '"."'
                                 || t.column_name
                                 || '" is '''
                                 || Replace (t.comments, '''', '''''')
                                 || ''';'
                               ) col_comments
                   From t) Loop
         l_cols    := l_cols || cr.colmn || CHR (10);

         If cr.col_comments Is Not Null Then
            l_col_comments    := l_col_comments || cr.col_comments || CHR (10);
         End If;

         l_res     := l_cols || CHR (10) || l_col_comments;
      End Loop;

      Return l_res;
   End get_table_cols_scripts;

   Function get_dbms_output
      Return Clob Is
      l_lines         dbmsoutput_linesarray;
      l_numlines      Integer;
--      l_line       Varchar2 (4000);
      l_result        Clob;
      l_return_char   Varchar2 (2)          := '
';
   Begin
      DBMS_OUTPUT.get_lines (lines => l_lines, numlines => l_numlines);

      For i In 1 .. l_numlines Loop
         l_result    := l_result || l_lines (i) || l_return_char;
      End Loop;

      l_result    := SUBSTR (l_result, 1, Length (l_result) - Length (l_return_char));
      Return l_result;
   End get_dbms_output;
End FORM_UTILS;
/


-- End of DDL Script for Package Body FC22.FORM_UTILS

