-- Start of DDL Script for Package FC.MATRIX_REP_DEMO_PKG
-- Generated 10.04.2010 22:27:54 from FC@VM_XE

Create Or Replace 
PACKAGE matrix_rep_demo_pkg As
   Type dim_rec Is Record (
      rn                Binary_integer
     ,dimension_name    Varchar2 (200)
     ,dimension_value   Varchar2 (200)
   );

   Type dim_t Is Table Of dim_rec
      Index By Binary_integer;

   Type result_rec Is Record (
      v_dimension_name    Varchar2 (200)
     ,v_dimension_value   Varchar2 (200)
     ,c01                 Varchar2 (200)
     ,c02                 Varchar2 (200)
     ,c03                 Varchar2 (200)
     ,c04                 Varchar2 (200)
     ,c05                 Varchar2 (200)
     ,c06                 Varchar2 (200)
     ,c07                 Varchar2 (200)
     ,c08                 Varchar2 (200)
     ,c09                 Varchar2 (200)
     ,c10                 Varchar2 (200)
     ,c11                 Varchar2 (200)
     ,c12                 Varchar2 (200)
     ,c13                 Varchar2 (200)
     ,c14                 Varchar2 (200)
     ,c15                 Varchar2 (200)
     ,c16                 Varchar2 (200)
     ,c17                 Varchar2 (200)
     ,c18                 Varchar2 (200)
     ,c19                 Varchar2 (200)
     ,c20                 Varchar2 (200)
     ,c21                 Varchar2 (200)
     ,c22                 Varchar2 (200)
     ,c23                 Varchar2 (200)
     ,c24                 Varchar2 (200)
     ,c25                 Varchar2 (200)
     ,c26                 Varchar2 (200)
     ,c27                 Varchar2 (200)
     ,c28                 Varchar2 (200)
     ,c29                 Varchar2 (200)
     ,c30                 Varchar2 (200)
   );

   Type result_t Is Table Of result_rec;

   Function get_query_as_matrix (p_sql_text_vertical Varchar2 Default Null, p_sql_text_horizontal Varchar2 Default Null)
      Return result_t Pipelined;

   Procedure customize_column_metadata (p_column_number Number, p_column_data In Out form_utils.column_rec);
End matrix_rep_demo_pkg;
/


Create Or Replace 
PACKAGE BODY matrix_rep_demo_pkg As
   Type cur_type Is Ref Cursor;

   g_dim_t        dim_t;
   g_sel_param1   Varchar2 (4000) := 'FORM_COLUMNS';
   g_sel_param2   Varchar2 (4000);

/*   g_base_sql_text   Varchar2 (4000)
      := '
Select   a.column_code dimension_name, a.column_display_number dimension_value
                  From form_columns a
                 Where a.form_code = :g_sel_param1
              Order By dimension_name
';
*/
   Function get_ordered_sql (p_sql_text Varchar2)
      Return Varchar2 Is
   Begin
      Return 'Select ROWNUM rn, a1.* From (' || p_sql_text || ') a1';
   End get_ordered_sql;

   Function get_matrix_sql_text (p_sql_text_vertical Varchar2, p_sql_text_horizontal Varchar2)
      Return Varchar2 Is
   Begin
      Return    '
with t3 as (      
        Select t1.rn v_rn, t1.dimension_name v_dimension_name, t1.dimension_value v_dimension_value, t2.rn h_rn
              ,t2.dimension_name h_dimension_name, t2.dimension_value h_dimension_value
              , t1.dimension_value + t2.dimension_value agg_value
          From ('
             || p_sql_text_vertical
             || ') t1, ('
             || p_sql_text_horizontal
             || ') t2
         Where 1 = 1)
Select   t3.v_dimension_name, t3.v_dimension_value, Max (DECODE (h_rn, 1, t3.agg_value)) c01
        ,Max (DECODE (h_rn, 2, t3.agg_value)) c02, Max (DECODE (h_rn, 3, t3.agg_value)) c03
        ,Max (DECODE (h_rn, 4, t3.agg_value)) c04, Max (DECODE (h_rn, 5, t3.agg_value)) c05
        ,Max (DECODE (h_rn, 6, t3.agg_value)) c06, Max (DECODE (h_rn, 7, t3.agg_value)) c07
        ,Max (DECODE (h_rn, 8, t3.agg_value)) c08, Max (DECODE (h_rn, 9, t3.agg_value)) c09
        ,Max (DECODE (h_rn, 10, t3.agg_value)) c10, Max (DECODE (h_rn, 11, t3.agg_value)) c11
        ,Max (DECODE (h_rn, 12, t3.agg_value)) c12, Max (DECODE (h_rn, 13, t3.agg_value)) c13
        ,Max (DECODE (h_rn, 14, t3.agg_value)) c14, Max (DECODE (h_rn, 15, t3.agg_value)) c15
        ,Max (DECODE (h_rn, 16, t3.agg_value)) c16, Max (DECODE (h_rn, 17, t3.agg_value)) c17
        ,Max (DECODE (h_rn, 18, t3.agg_value)) c18, Max (DECODE (h_rn, 19, t3.agg_value)) c19
        ,Max (DECODE (h_rn, 20, t3.agg_value)) c20, Max (DECODE (h_rn, 21, t3.agg_value)) c21
        ,Max (DECODE (h_rn, 22, t3.agg_value)) c22, Max (DECODE (h_rn, 23, t3.agg_value)) c23
        ,Max (DECODE (h_rn, 24, t3.agg_value)) c24, Max (DECODE (h_rn, 25, t3.agg_value)) c25
        ,Max (DECODE (h_rn, 26, t3.agg_value)) c26, Max (DECODE (h_rn, 27, t3.agg_value)) c27
        ,Max (DECODE (h_rn, 28, t3.agg_value)) c28, Max (DECODE (h_rn, 29, t3.agg_value)) c29
        ,Max (DECODE (h_rn, 30, t3.agg_value)) c30
    From t3
Group By v_dimension_value, v_rn, v_dimension_name
Order By v_rn
';
   End get_matrix_sql_text;

   Procedure fill_horizontal_props (p_sql_text_horizontal Varchar2) Is
      c           cur_type;
      l_res_rec   dim_rec;
   Begin
      Open c For get_ordered_sql (p_sql_text_horizontal);                                        -- Using g_sel_param2;

      Loop
         Fetch c
          Into l_res_rec;

         Exit When c%Notfound;
         DBMS_OUTPUT.put_line (l_res_rec.rn || ':' || l_res_rec.dimension_name || '=' || l_res_rec.dimension_value);
         g_dim_t (l_res_rec.rn)    := l_res_rec;
      End Loop;

      Close c;
   End fill_horizontal_props;

   Function get_query_as_matrix (p_sql_text_vertical Varchar2 Default Null, p_sql_text_horizontal Varchar2 Default Null)
      Return result_t Pipelined Is
      c           cur_type;
      l_res_rec   result_rec;
   Begin
      fill_horizontal_props (p_sql_text_horizontal);

      Open c For get_matrix_sql_text (get_ordered_sql (p_sql_text_vertical), get_ordered_sql (p_sql_text_horizontal));

--      Using g_sel_param1, g_sel_param2;
      Loop
         Fetch c
          Into l_res_rec;

         Exit When c%Notfound;
         Pipe Row (l_res_rec);
      End Loop;

      Close c;

      Return;
   End get_query_as_matrix;

   Procedure customize_column_metadata (p_column_number Number, p_column_data In Out form_utils.column_rec) Is
      l_form_sql   Varchar2 (4000);
   Begin
      --Если нет данных в табличке
      If p_column_number = 1 Then
         g_dim_t.Delete;

         Select f.sql_text
           Into l_form_sql
           From forms f
          Where f.form_code = p_column_data.form_code;

         Execute Immediate l_form_sql;
      End If;

      If REGEXP_LIKE (p_column_data.column_code, 'C[0-9]{2}') Then
         Declare
            l_dim_rec   dim_rec;
         Begin
            l_dim_rec                           := g_dim_t (SUBSTR (p_column_data.column_code, 2) + 0);
            p_column_data.column_user_name      := l_dim_rec.dimension_name;
            p_column_data.column_description    := l_dim_rec.dimension_name || '-' || l_dim_rec.dimension_value;
            p_column_data.show_hover_flag       := 'Y';
            p_column_data.show_on_grid          := 'Y';
         Exception
            When NO_DATA_FOUND Then
               p_column_data.show_on_grid    := 'N';
         End;
      Else
         Null;                           --DBMS_OUTPUT.put_line (p_column_data.column_code || 'yyyyyyyyyyyyyyyyyyyyy');
      End If;
   End customize_column_metadata;
End matrix_rep_demo_pkg;
/


-- End of DDL Script for Package FC.MATRIX_REP_DEMO_PKG

