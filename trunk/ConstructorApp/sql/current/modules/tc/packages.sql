Create Or Replace Package hours_types_pkg As
   Procedure p_ins_upd (
      p_hours_type_id        In Out   Number
     ,p_hours_type_code      In Out   Varchar2
     ,p_hours_type_name      In Out   Varchar2
     ,p_use_in_shifts_flag   In Out   Varchar2
   );

   Procedure p_delete (p_hours_type_id In Out Number);
End HOURS_TYPES_PKG;
/

Create Or Replace Package Body hours_types_pkg As
   Procedure p_ins_upd (
      p_hours_type_id        In Out   Number
     ,p_hours_type_code      In Out   Varchar2
     ,p_hours_type_name      In Out   Varchar2
     ,p_use_in_shifts_flag   In Out   Varchar2
   ) Is
   Begin
      Update tc.hours_types
         Set hours_type_code = p_hours_type_code
            ,hours_type_name = p_hours_type_name
            ,use_in_shifts_flag = p_use_in_shifts_flag
       Where hours_type_id = p_hours_type_id;

      If Sql%Rowcount = 0 Then
         Select main_sq.Nextval
           Into p_hours_type_id
           From DUAL;

         Insert Into tc.hours_types
                     (hours_type_id, hours_type_code, hours_type_name, use_in_shifts_flag)
              Values (p_hours_type_id, p_hours_type_code, p_hours_type_name, p_use_in_shifts_flag);
      End If;
   End p_ins_upd;

   Procedure p_delete (p_hours_type_id In Out Number) Is
   Begin
      Delete From tc.hours_types
            Where hours_type_id = p_hours_type_id;
   End p_delete;
End hours_types_pkg;
/

Create Or Replace Package shedule_shifts_pkg As
   Procedure p_delete (p_shedule_shift_id In Out Number);

   Procedure p_ins_upd (
      p_shedule_shift_id     In Out   Number
     ,p_shedule_code         In Out   Varchar2
     ,p_shift_order_number   In Out   Number
     ,p_shift_code           In Out   Varchar2
   );
End shedule_shifts_pkg;
/

Create Or Replace Package Body shedule_shifts_pkg As
   Procedure p_ins_upd (
      p_shedule_shift_id     In Out   Number
     ,p_shedule_code         In Out   Varchar2
     ,p_shift_order_number   In Out   Number
     ,p_shift_code           In Out   Varchar2
   ) Is
   Begin
      Update tc.shedule_shifts
         Set shedule_code = p_shedule_code
            ,shift_order_number = p_shift_order_number
            ,shift_code = p_shift_code
       Where shedule_shift_id = p_shedule_shift_id;

      If Sql%Rowcount = 0 Then
         Select main_sq.Nextval
           Into p_shedule_shift_id
           From DUAL;

         Insert Into tc.shedule_shifts
                     (shedule_shift_id, shedule_code, shift_order_number, shift_code)
              Values (p_shedule_shift_id, p_shedule_code, p_shift_order_number, p_shift_code);
      End If;
   End p_ins_upd;

   Procedure p_delete (p_shedule_shift_id In Out Number) Is
   Begin
      Delete From tc.shedule_shifts
            Where shedule_shift_id = p_shedule_shift_id;
   End p_delete;
End shedule_shifts_pkg;
/

Create Or Replace Package shedule_types_pkg As
   Procedure p_ins_upd (
      p_shedule_type_id     In Out   Number
     ,p_shedule_type_code   In Out   Varchar2
     ,p_shedule_type_name   In Out   Varchar2
     ,p_shedule_period      In Out   Number
   );

   Procedure p_delete (p_shedule_type_id In Out Number);
End SHEDULE_TYPES_PKG;
/

Create Or Replace Package Body shedule_types_pkg As
   Procedure p_ins_upd (
      p_shedule_type_id     In Out   Number
     ,p_shedule_type_code   In Out   Varchar2
     ,p_shedule_type_name   In Out   Varchar2
     ,p_shedule_period      In Out   Number
   ) Is
   Begin
      Update tc.shedule_types
         Set shedule_type_code = p_shedule_type_code
            ,shedule_type_name = p_shedule_type_name
            ,shedule_period = p_shedule_period
       Where shedule_type_id = p_shedule_type_id;

      If Sql%Rowcount = 0 Then
         Select main_sq.Nextval
           Into p_shedule_type_id
           From DUAL;

         Insert Into tc.shedule_types
                     (shedule_type_id, shedule_type_code, shedule_type_name, shedule_period)
              Values (p_shedule_type_id, p_shedule_type_code, p_shedule_type_name, p_shedule_period);
      End If;
   End p_ins_upd;

   Procedure p_delete (p_shedule_type_id In Out Number) Is
   Begin
      Delete From tc.shedule_types
            Where shedule_type_id = p_shedule_type_id;
   End p_delete;
End shedule_types_pkg;
/

Create Or Replace Package shedules_pkg As
   Procedure p_ins_upd (
      p_shedule_id                In Out   Number
     ,p_shedule_type_code         In Out   Varchar2
     ,p_shedule_code              In Out   Varchar2
     ,p_shedule_name              In Out   Varchar2
     ,p_is_primary_flag           In Out   Varchar2
     ,p_shift_time_from_primary   In Out   Varchar2
     ,p_shedule_start_date        In Out   Varchar2
   );

   Procedure p_delete (p_shedule_id In Out Number);
End shedules_pkg;
/

Create Or Replace Package Body shedules_pkg As
   Procedure p_ins_upd (
      p_shedule_id                In Out   Number
     ,p_shedule_type_code         In Out   Varchar2
     ,p_shedule_code              In Out   Varchar2
     ,p_shedule_name              In Out   Varchar2
     ,p_is_primary_flag           In Out   Varchar2
     ,p_shift_time_from_primary   In Out   Varchar2
     ,p_shedule_start_date        In Out   Varchar2
   ) Is
   Begin
      Update tc.shedules
         Set shedule_id = p_shedule_id
            ,shedule_type_code = p_shedule_type_code
            ,shedule_code = p_shedule_code
            ,shedule_name = p_shedule_name
            ,is_primary_flag = p_is_primary_flag
            ,shift_time_from_primary = p_shift_time_from_primary
            ,shedule_start_date = p_shedule_start_date
       Where shedule_id = p_shedule_id;

      If Sql%Rowcount = 0 Then
         Select main_sq.Nextval
           Into p_shedule_id
           From DUAL;

         Insert Into tc.shedules
                     (shedule_id, shedule_type_code, shedule_code, shedule_name, is_primary_flag
                     ,shift_time_from_primary, shedule_start_date)
              Values (p_shedule_id, p_shedule_type_code, p_shedule_code, p_shedule_name, p_is_primary_flag
                     ,p_shift_time_from_primary, p_shedule_start_date);
      End If;
   End p_ins_upd;

   Procedure p_delete (p_shedule_id In Out Number) Is
   Begin
      Delete From tc.shedules
            Where shedule_id = p_shedule_id;
   End p_delete;
End shedules_pkg;
/

Create Or Replace Package shift_hours_pkg As
   Procedure p_delete (p_shitf_hours_id In Out Number);

   Procedure p_ins_upd (
      p_shitf_hours_id    In Out   Number
     ,p_shift_code        In Out   Varchar2
     ,p_hours_type_code   In Out   Varchar2
     ,p_time_from         In Out   Varchar2
     ,p_time_to           In Out   Varchar2
     ,p_hours             In Out   Varchar2
   );
End shift_hours_pkg;
/

Create Or Replace Package Body shift_hours_pkg As
   Procedure p_ins_upd (
      p_shitf_hours_id    In Out   Number
     ,p_shift_code        In Out   Varchar2
     ,p_hours_type_code   In Out   Varchar2
     ,p_time_from         In Out   Varchar2
     ,p_time_to           In Out   Varchar2
     ,p_hours             In Out   Varchar2
   ) Is
      l_hours       Date := To_date ('01.01.2001 ' || p_hours, 'dd.mm.yyyy hh24:mi');
      l_time_from   Date := To_date ('01.01.2001 ' || p_time_from, 'dd.mm.yyyy hh24:mi');
      l_time_to     Date := To_date ('01.01.2001 ' || p_time_to, 'dd.mm.yyyy hh24:mi');
   Begin
      Select NVL2 (p_time_from, l_time_from, Null), NVL2 (p_time_to, l_time_to, Null)
        Into l_time_from, l_time_to
        From DUAL;

      Update tc.shift_hours
         Set shift_code = p_shift_code
            ,hours_type_code = p_hours_type_code
            ,time_from = l_time_from
            ,time_to = l_time_to
            ,hours = l_hours
       Where shitf_hours_id = p_shitf_hours_id;

      If Sql%Rowcount = 0 Then
         Select main_sq.Nextval
           Into p_shitf_hours_id
           From DUAL;

         Insert Into tc.shift_hours
                     (shitf_hours_id, shift_code, hours_type_code, time_from, time_to, hours)
              Values (p_shitf_hours_id, p_shift_code, p_hours_type_code, l_time_from, l_time_to, l_hours);
      End If;
   End p_ins_upd;

   Procedure p_delete (p_shitf_hours_id In Out Number) Is
   Begin
      Delete From tc.shift_hours
            Where shitf_hours_id = p_shitf_hours_id;
   End p_delete;
End shift_hours_pkg;
/

Create Or Replace Package shifts_pkg As
   Procedure p_delete (p_shift_id In Out Number);

   Procedure p_ins_upd (p_shift_id In Out Number, p_shift_code In Out Varchar2, p_shift_name In Out Varchar2);
End SHIFTS_PKG;
/

Create Or Replace Package Body shifts_pkg As
   Procedure p_ins_upd (p_shift_id In Out Number, p_shift_code In Out Varchar2, p_shift_name In Out Varchar2) Is
   Begin
      Update TC.SHIFTS
         Set shift_id = p_shift_id
            ,shift_code = p_shift_code
            ,shift_name = p_shift_name
       Where shift_id = p_shift_id;

      If Sql%Rowcount = 0 Then
         Select main_sq.Nextval
           Into p_shift_id
           From DUAL;

         Insert Into TC.SHIFTS
                     (shift_id, shift_code, shift_name)
              Values (p_shift_id, p_shift_code, p_shift_name);
      End If;
   End p_ins_upd;

   Procedure p_delete (p_shift_id In Out Number) Is
   Begin
      Delete From TC.SHIFTS
            Where shift_id = p_shift_id;
   End p_delete;
End SHIFTS_PKG;
/

Create Or Replace Package tc_shedule_utils_pkg As
   Type shedules_shifts_r Is Record (
      shift_date   Date
     ,shift_code   shedule_shifts.shift_code%Type
   );

   Type shedules_shifts_t Is Table Of shedules_shifts_r;

   Function get_shedules_shifts_tbl (
      p_shedule_code        shedules.shedule_code%Type
     ,p_period_start_date   Date Default Null
     ,p_period_end_date     Date Default Null
   )
      Return shedules_shifts_t Pipelined;
End tc_shedule_utils_pkg;
/

Grant Execute On tc_shedule_utils_pkg To fc22
/

Create Or Replace Package Body tc_shedule_utils_pkg As
   Function get_shedules_shifts_tbl (
      p_shedule_code        shedules.shedule_code%Type
     ,p_period_start_date   Date Default Null
     ,p_period_end_date     Date Default Null
   )
      Return shedules_shifts_t Pipelined Is
      l_result              shedules_shifts_r;
      l_period_start_date   Date              := NVL (p_period_start_date, TRUNC (SYSDATE, 'mm'));
      l_period_end_date     Date              := NVL (p_period_end_date, LAST_DAY (SYSDATE));
   Begin
      For cr In (With s As
                      (
                         Select s.shedule_id, s.shedule_type_code, s.shedule_code, s.shedule_name, s.is_primary_flag
                               ,s.shift_time_from_primary, s.shedule_start_date
                               ,NVL (st.shedule_period, (Select Max (shift_order_number)
                                                           From shedule_shifts ss
                                                          Where ss.shedule_code = s.shedule_code)) As shedule_period
                           From shedules s, shedule_types st
                          Where s.shedule_type_code = st.shedule_type_code
                            And s.shedule_code = p_shedule_code)
                     ,s1 As
                      (
                         Select     s.shedule_id, s.shedule_type_code, s.shedule_code, s.shedule_name
                                   ,s.is_primary_flag, s.shift_time_from_primary, s.shedule_start_date
                                   , s.shedule_start_date + Level - 1 As shift_date
                                   ,DECODE (Mod (Level, s.shedule_period)
                                           ,0, s.shedule_period
                                           ,Mod (Level, s.shedule_period)
                                           ) As shift_order_number
                               From s
                         Connect By Level <= (l_period_end_date - s.shedule_start_date) + 1)
                     ,ss As
                      (Select ss.shedule_shift_id, ss.shedule_code, ss1.shift_order_number, ss.shift_code
                         From (Select     Level As shift_order_number, s.shedule_code
                                     From s
                               Connect By Level <= s.shedule_period) ss1
                              Left Join
                              shedule_shifts ss
                              On ss1.shift_order_number = ss.shift_order_number
                            And ss1.shedule_code = ss.shedule_code
                              )
                 Select   s1.shedule_id, s1.shift_date, ss.shift_code
                     From s1 Join ss On s1.shift_order_number = ss.shift_order_number
--
                 Where    s1.shift_date >= l_period_start_date
                 Order By shift_date) Loop
         l_result.shift_date    := cr.shift_date;
         l_result.shift_code    := cr.shift_code;
         Pipe Row (l_result);
      End Loop;

      Return;
   End get_shedules_shifts_tbl;
End tc_shedule_utils_pkg;
/

