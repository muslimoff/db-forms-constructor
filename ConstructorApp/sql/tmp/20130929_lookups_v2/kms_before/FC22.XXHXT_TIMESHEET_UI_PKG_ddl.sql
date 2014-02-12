-- Start of DDL Script for Package FC22.XXHXT_TIMESHEET_UI_PKG
-- Generated 19.10.2013 11:46:43 from FC22@KZM_TEST

-- Drop the old instance of XXHXT_TIMESHEET_UI_PKG
Drop Package fc22.xxhxt_timesheet_ui_pkg
/

Create Or Replace 
Package fc22.xxhxt_timesheet_ui_pkg Is

  /**    
  *========================================================================<br/>
  * <b>Системные сведения</b>                                              <br/>
  *   <br/>
  *   vc.Version : 1.0.0
  *   <br/>
  *   vc.Patch   : 1.0.0.01
  *   <br/>  
  *   vc.Object  : XXHR_STAFF_LIST_PKG  
  *   <br/>                                             
  *========================================================================<br/>
  * <b>Author</b>  : M. DAVYDENKO                                          <br/>
  * <b>Created</b> : 31.07.2013 10:28:20                                  <br/>
  * <b>Purpose</b> : Пакет для работы с нестандартным                      <br/>
  *                  пользовательским интерфейсом табеля                   <br/>
  *                                                                        <br/>
  * Ver.  Date         Author         Changes                              <br/>
  *========================================================================<br/>
  * 1.0   04.07.2013   M. Davydenko   Package created                      <br/>                                                       <br/>
  * @headcom
  */

  Type Timesheet_Rec Is Record(
     Person_Id              Number(10)
    ,Assignment_Id          Number(10)
    ,Schedule_Id            Varchar2(150)
    ,Sched_Name             Varchar2(4000)
    ,Base_Schedule_Id       Number
    ,Base_Sched_Name        Varchar2(4000)
    ,Employee_Number        Varchar2(30)
    ,Full_Name              Varchar2(362)
    ,Pos_Name               Varchar2(250)
    ,Grade                  Varchar2(240)
    ,Base_Work_Hours        Number
    ,Plan_Work_Days         Number
    ,Plan_Work_Hours        Number
    ,Fact_Work_Days         Number
    ,Fact_Work_Hours        Number
    ,D01                    Varchar2(4000)
    ,D02                    Varchar2(4000)
    ,D03                    Varchar2(4000)
    ,D04                    Varchar2(4000)
    ,D05                    Varchar2(4000)
    ,D06                    Varchar2(4000)
    ,D07                    Varchar2(4000)
    ,D08                    Varchar2(4000)
    ,D09                    Varchar2(4000)
    ,D10                    Varchar2(4000)
    ,D11                    Varchar2(4000)
    ,D12                    Varchar2(4000)
    ,D13                    Varchar2(4000)
    ,D14                    Varchar2(4000)
    ,D15                    Varchar2(4000)
    ,D16                    Varchar2(4000)
    ,D17                    Varchar2(4000)
    ,D18                    Varchar2(4000)
    ,D19                    Varchar2(4000)
    ,D20                    Varchar2(4000)
    ,D21                    Varchar2(4000)
    ,D22                    Varchar2(4000)
    ,D23                    Varchar2(4000)
    ,D24                    Varchar2(4000)
    ,D25                    Varchar2(4000)
    ,D26                    Varchar2(4000)
    ,D27                    Varchar2(4000)
    ,D28                    Varchar2(4000)
    ,D29                    Varchar2(4000)
    ,D30                    Varchar2(4000)
    ,D31                    Varchar2(4000)
    ,Night_Hours            Number
    ,Holiday_Hours          Number
    ,Idle_Days              Number
    ,Vac_Days               Number
    ,Unpaid_Vac_Days        Number
    ,Educ_Vac_Days          Number
    ,Unpaid_Educ_Vac_Days   Number
    ,Maternity_Vac_Days     Number
    ,Childcare_Vac_Days     Number
    ,Idle_Vac_Days          Number
    ,Unpaid_Idle_Vac_Days   Number
    ,Eco_Vac_Days           Number
    ,Soc_Vac_Days           Number
    ,Unpaid_Soc_Vac_Days    Number
    ,Discharge_Days         Number
    ,Sick_Days              Number
    ,Absense_Days           Number
    ,Duties_Absense_Days    Number
    ,Unknown_Absense_Days   Number
    ,Total_Free_Days        Number
    ,Worked_Days_In_Hol     Number
    ,Worked_Hours_In_Hol    Number
    ,Bus_Trip_Days          Number
    ,Forced_Absense_Days    Number
    ,Unpaid_Disability_Days Number
    ,Total_Worked_Days      Number
    ,Total_Abs              Number
    ,Grand_Total            Number
    ,Status_Code            Varchar2(30)
    ,Batch_Name             Pay_Batch_Headers.Batch_Name%type
    ,Batch_Status           Varchar2(100)
    ,Batch_Overall_Status   Varchar2(100)
    ,Work_Code              Varchar2(100)
    ,Profession_Code        Varchar2(100)
    ,Rate_Code              Varchar2(30)
    ,proposed_salary_n      Number
    ,tim_id                 Number
    ,Position_Id            Number
    ,last_update_date varchar2(20)
    ,last_updated_by number
    ,last_update_login number
    ,creation_date varchar2(20)
    ,created_by number);

  Type Timesheet_Tab Is Table Of Timesheet_Rec;

  Type Schedule_Rec Is Record(
     Period_Start_Date Date
    ,Schedule_Id       Number
    ,Sched_Name        Varchar2(4000)
    ,Shift_Id          Number
    ,Shift_Name        Varchar2(4000)
    ,Base_Schedule_Id  Number
    ,Base_Sched_Name   Varchar2(4000)
    ,Base_Work_Days    Number
    ,Base_Work_Hours   Number
    ,Plan_Work_Days    Number
    ,Plan_Work_Hours   Number
    ,Holiday_Hours     Number
    ,Night_Hours       Number
    ,D01               Varchar2(4000)
    ,D02               Varchar2(4000)
    ,D03               Varchar2(4000)
    ,D04               Varchar2(4000)
    ,D05               Varchar2(4000)
    ,D06               Varchar2(4000)
    ,D07               Varchar2(4000)
    ,D08               Varchar2(4000)
    ,D09               Varchar2(4000)
    ,D10               Varchar2(4000)
    ,D11               Varchar2(4000)
    ,D12               Varchar2(4000)
    ,D13               Varchar2(4000)
    ,D14               Varchar2(4000)
    ,D15               Varchar2(4000)
    ,D16               Varchar2(4000)
    ,D17               Varchar2(4000)
    ,D18               Varchar2(4000)
    ,D19               Varchar2(4000)
    ,D20               Varchar2(4000)
    ,D21               Varchar2(4000)
    ,D22               Varchar2(4000)
    ,D23               Varchar2(4000)
    ,D24               Varchar2(4000)
    ,D25               Varchar2(4000)
    ,D26               Varchar2(4000)
    ,D27               Varchar2(4000)
    ,D28               Varchar2(4000)
    ,D29               Varchar2(4000)
    ,D30               Varchar2(4000)
    ,D31               Varchar2(4000));

  Type Schedule_Tab Is Table Of Schedule_Rec;

  Procedure x_Log_Tmp(Val_To_Log Varchar2, clob_val Clob default null);

  Function Get_Status_Code(p_Sum_Id Number) Return Varchar2;

  /** Функция вставки тегов для форматирования  
  * Вторая строка комментария
  * @param  p_color Входящий Varchar2
  * @param  p_data Входящий Varchar2
  * @return Varchar2
  */
  Function Get_Show_Format(p_Color Varchar2
                          ,p_Data  Varchar2) Return Varchar2;

  /** Процедура изменения данных типа графика
  * @param P_SCHEDULE_TYPE_ID              ID типа графика
  * @param P_SCHEDULE_TYPE_CODE            Код
  * @param P_SCHEDULE_TYPE_NAME            Наименование
  * @param P_SCHEDULE_PERIOD               Период
  * @param P_SCHEDULE_TYPE_START_DATE      Дата начала
  * @param P_HOLIDAY_CALENDAR_ID           Праздн.календ
  * @param P_BASE_SCHEDULE_TYPE_ID         Опорный график
  * @param P_HOLIDAYS_AS_NONWORKING_FLAG   Празд.нерабоч.
  * @param P_PRINT_GROUP                   Группа (для печати)
  * @param P_DESCRIPTION                   Описание
  */
  Procedure On_Sched_Type_Ins_Upd(p_Schedule_Type_Id            In Out Number
                                 ,p_Schedule_Type_Code          In Out Varchar2
                                 ,p_Schedule_Type_Name          In Out Varchar2
                                 ,p_Schedule_Period             In Out Number
                                 ,p_Schedule_Type_Start_Date    In Out Date
                                 ,p_Holiday_Calendar_Id         In Out Number
                                 ,p_Is_Base_Schedule            In Out Varchar2
                                 ,p_Base_Schedule_Type_Id       In Out Number
                                 ,p_Holidays_As_Nonworking_Flag In Out Varchar2
                                 ,p_Print_Group                 In Out Varchar2
                                 ,p_Description                 In Out Varchar2
                                 ,p_Button_Idx                  In Out Number
                                 ,p_Message_Type                In Out Varchar2
                                 ,p_Message_Text                In Out Varchar2
                                 ,p_SCHEDULE_CLOSE_DATE         In Out Date);

  /** Процедура удаления типа графика
  * @param P_SCHEDULE_TYPE_ID              ID типа графика
  */
  Procedure On_Sched_Type_Del(p_Schedule_Type_Id In Out Number);

  /** Процедура изменения данных стандартные смены
  * @param P_SCHEDULE_TYPE_SHIFT_ID        ID 
  * @param P_SCHEDULE_TYPE_ID              ID Типа графика
  * @param P_SHIFT_ORDER_NUMBER            № в смене
  * @param P_SHIFT_ID                      Смена
  * @param P_DISPLAY_TEXT                  Отображать как
  */
  Procedure On_Stand_Shift_Ins_Upd(p_Schedule_Type_Shift_Id In Out Number
                                  ,p_Schedule_Type_Id       In Out Number
                                  ,p_Shift_Order_Number     In Out Number
                                  ,p_Shift_Id               In Out Number
                                  ,p_Display_Text           In Out Varchar2
                                  ,p_Button_Idx             In Out Number
                                  ,p_Message_Type           In Out Varchar2
                                  ,p_Message_Text           In Out Varchar2);

  /** Процедура удаления смены
  * @param p_Schedule_Type_Shift_Id                ID
  */
    Procedure On_Stand_Shift_Del(p_Schedule_Type_Shift_Id In Out Number
                                ,p_Schedule_Type_Id       In Out Number);

  /** Процедура изменения данных графика
  * @param P_SCHEDULE_ID                   ID
  * @param P_SCHEDULE_TYPE                 Тип Графика
  * @param P_SCHEDULE_CODE                 Код
  * @param P_SHIFT_FROM_PRIMARY_IN_DAYS    Сдвижка от основной смены, дней
  * @param P_START_DATE                    Период с
  * @param P_END_DATE                      Период по
  * @param P_SCHEDULE_TYPE_ID              ID Типа Графика
  */
  Procedure On_Sched_Ins_Upd(p_Schedule_Id                In Out Number
                            ,p_Schedule_Code              In Out Varchar2
                            ,p_Schedule_Name              In Out Varchar2
                            ,p_Shift_From_Primary_In_Days In Out Number
                            ,p_Schedule_Type_Eff_Date     In Out Date
                            ,p_Schedule_Type_Id           In Out Number
                            ,p_Button_Idx                 In Out Number
                            ,p_Message_Type               In Out Varchar2
                            ,p_Message_Text               In Out Varchar2);

  /** Процедура удаления типа графика
  * @param P_SCHEDULE_ID              ID графика
  */
  Procedure On_Sched_Del(p_Schedule_Id In Out Number ,p_Schedule_Type_Id In Out Number);

  /** Процедура изменения данных дня календаря праздничных дней
  * @param P_HOLIDAY_DAY_ID                ID
  * @param P_NAME                          Имя
  * @param P_HOLIDAY_DATE                  Нерабочий день
  * @param P_HOURS                         Часы
  * @param P_HOLIDAY_CALENDAR_ID           Кадендарь праздников
  */
  Procedure On_Holiday_Calend_Day_Ins_Upd(p_Holiday_Day_Id      In Out Number
                                         ,p_Name                In Out Varchar2
                                         ,p_Holiday_Date        In Out Date
                                         ,p_Hours               In Out Number
                                         ,p_Holiday_Calendar_Id In Out Number
                                         ,p_Button_Idx          In Out Number
                                         ,p_Message_Type        In Out Varchar2
                                         ,p_Message_Text        In Out Varchar2);

  /** Процедура удаления дня календаря праздничных дней
  * @param P_HOLIDAY_DAY_ID                ID
  */
  Procedure On_Holiday_Calend_Day_Del(p_Holiday_Day_Id In Out Number);

  /** Процедура изменения данных смены
  * @param P_SHIFT_ID                      ID
  * @param P_NAME                          Наименование
  * @param P_DESCRIPTION                   Описание
  * @param P_DATE_FROM                     Дата с
  * @param P_DATE_TO                       Дата по
  */
  Procedure On_Shift_Ins_Upd(p_Shift_Id     In Out Number
                            ,p_Name         In Out Varchar2
                            ,p_Description  In Out Varchar2
                            ,p_Date_From    In Out Date
                            ,p_Date_To      In Out Date
                            ,p_Button_Idx   In Out Number
                            ,p_Message_Type In Out Varchar2
                            ,p_Message_Text In Out Varchar2);

  /** Процедура удаления смены
  * @param P_SHIFT_ID                ID
  */
  Procedure On_Shift_Del(p_Shift_Id In Out Number);

  /** Процедура изменения данных часов смены
  */
  Procedure On_Shift_Hours_Ins_Upd(p_Shitf_Hours_Id In Out Number
                                  ,p_Shift_Id       In Out Number
                                  ,p_Name           In Out Varchar2
                                  ,p_Day_From       In Out Number
                                  ,p_Time_From      In Out Varchar2
                                  ,p_Day_To         In Out Number
                                  ,p_Time_To        In Out Varchar2
                                  ,p_Hours_Type_Id  In Out Number
                                  ,p_Button_Idx     In Out Number
                                  ,p_Message_Type   In Out Varchar2
                                  ,p_Message_Text   In Out Varchar2);

  /** Процедура удаления часов смены
  * @param P_SHIFT_ID                ID
  */
  Procedure On_Shift_Hours_Del(p_Shitf_Hours_Id In Out Number);

  /** Процедура изменения данных назначения графиков     
  * @param  p_assignment_shedule_id Входящий number
  * @param  p_assignment_id Входящий Number
  * @param  p_effective_start_date Входящий Date
  * @param  p_effective_end_date Входящий Date
  * @param  p_schedule_id Входящий Number
  * @param  p_schedule_type_id Входящий Number
  */
 Procedure On_Ass_Sched_Ins_Upd(p_Assignment_Shedule_Id In Out Number
                               ,p_Assignment_Id         In Out Number
                               ,p_Effective_Start_Date  In Out Date
                               ,p_Effective_End_Date    In Out Date
                               ,p_Schedule_Id           In Out Number
                               ,p_Schedule_Type_Id      In Out Number
                               ,p_Position_Id           In Out Number);

  /** Процедура удаление данных графиков назначения <b>p_delete</b>     
  * @param  p_assignment_shedule_id Входящий number
    */
  Procedure On_Ass_Sched_Del(p_Assignment_Shedule_Id In Out Number);

  Procedure On_Sched_Det_Ins_Update(p_Det_Id   Number
                                   ,p_Shift_Id Number
                                   ,p_Sum_Id   Number);

  --Удаление КТУ
  Procedure On_TS_delete (p_ASSIGNMENT_ID  In Out  number, p_tim_id  In Out  NUmber);

  -- Обновление "Табля подробно"
  Procedure On_Ts_Det_Ins_Upd(p_Det_Id              In Out Number
                             ,p_Tim_Id              In Out Number
                             ,p_Sum_Id              In Out Number
                             ,p_Date_Worked         In Out Date
                             ,p_Hours               In Out Number
                             ,p_Time_In             In Out Varchar2
                             ,p_Time_Out            In Out Varchar2
                             ,p_Det_Element_Type_Id In Number
                             ,p_Shift_Code          In Out Varchar2
                             ,p_Absence_Type_Id     In Out Number
                             ,p_Effective_Date      In Out Date
                             ,p_Assignment_Id       In Out Number
                             ,p_Person_Id           In Out Number
                             ,p_Button_Idx          In Out Number
                             ,p_Message_Type        In Out Varchar2
                             ,p_Message_Text        In Out Varchar2);

    /** Процедура удаление данных табеля подробно   
      */
   Procedure On_Ts_Det_Del(p_Sum_Id In Out Number
                          ,p_Det_Id In Out Number);

  Procedure On_Mvz_Upd(p_Id          In Out Number
                      ,p_Date_Worked In Out Date
                      ,p_Segment1    In Out Varchar2
                      ,p_Segment2    In Out Varchar2
                      ,p_Segment3    In Out Varchar2
                      ,p_Segment4    In Out Varchar2
                      ,p_Segment5    In Out Varchar2
                      ,p_Segment6    In Out Varchar2
                      ,p_Segment7    In Out Varchar2
                      ,p_Segment8    In Out Varchar2
                      ,p_Segment9    In Out Varchar2
                      ,p_Segment10   In Out Varchar2
                      ,p_Segment11   In Out Varchar2
                      ,p_Segment12   In Out Varchar2
                      ,p_Segment13   In Out Varchar2
                      ,p_Segment14   In Out Varchar2
                      ,p_Segment15   In Out Varchar2
                      ,p_Segment16   In Out Varchar2
                      ,p_Segment17   In Out Varchar2);

  /*Запускаем конкаррент для создания КТУ работников
  */
  Procedure Cr_Tc_For_Persons_Request(p_Effective_Date  Date Default Null
                                     ,p_Organization_Id Number Default Null
                                     ,p_Person_Id       Number
                                     ,p_Assignment_Id   Number
                                     ,p_Position_id     Number Default Null);

  /** Процедура генерации графиков за период
  * @param P_SCHEDULE_TYPE_ID            Тип графика
  * @param P_SCHEDULE_ID                 Звено
  * @param P_START_DATE                  Начало периода
  * @param P_END_DATE                    Конец периода
  */
  Procedure Generate_Schedules_Process(p_Schedule_Type_Id Number Default Null
                                       
                                      ,p_Schedule_Id   Number Default Null
                                      ,p_Start_Date    Date Default Null
                                      ,p_End_Date      Date Default Null
                                      ,p_Is_Concurrent Char Default 'N'
                                      ,p_Show_All_Shft_Time_Frst_Day Varchar2 Default 'N');

  /** Процедура для генерации графиков за период из параллельной программы
  * @param P_SCHEDULE_TYPE_ID            Тип графика
  * @param P_SCHEDULE_ID                 Звено
  * @param P_START_DATE                  Начало периода
  * @param P_END_DATE                    Конец периода
  */
  Procedure Generate_Sched_Detonator(Errbuf             Out Varchar2
                                    ,Retcode            Out Varchar2
                                    ,p_Schedule_Type_Id Number Default Null
                                    ,p_Schedule_Id      Number Default Null
                                    ,p_Start_Date       Varchar2 Default Null
                                    ,p_End_Date         Varchar2 Default Null
                                    ,p_Show_All_Shft_Time_Frst_Day Varchar2 Default 'N');

  /*Запускаем конкаррент для генерации графиков
  */
  Procedure Generate_Schedules_Request(p_Schedule_Type_Id Number Default Null
                                      ,p_Schedule_Id      Number Default Null
                                      ,p_Start_Date       Date Default Null
                                      ,p_End_Date         Date Default Null
                                      ,p_Show_All_Shft_Time_Frst_Day Varchar2 Default 'N');

  Function D00(p_Date_Worked       Date
              ,p_Day_Num           Number
              ,p_Preview_Type      Varchar2
              ,p_View_Type         Varchar2
              ,p_Total_Hours       Number
              ,p_Shift_Code        Varchar2
              ,p_Hours_Code        Varchar2
              ,p_Interval_Code     Varchar2
              ,p_Plan_Hours        Number
              ,p_Plan_Shift_Code   Varchar2
              ,p_Plan_Time_In      Date
              ,p_Plan_Time_Out     Date
              ,p_Absence_Type_Code Varchar2) Return Varchar2;

  Function Get_Timesheet(p_Organization_Id  Number
                        ,p_Person_Id        Number
                        ,p_Assignment_Id    Number
                        ,p_Effective_Date   Date
                        ,p_View_Type        Varchar2
                        ,p_Preview_Type     Varchar2
                        ,p_Display_Sub_Orgs Varchar2
                        ,p_Position_id      Number Default Null) Return Timesheet_Tab
    Pipelined;

  Function Get_Schedule(p_Schedule_Type_Id Number
                       ,p_Schedule_Id      Number
                       ,p_Start_Date       Date
                       ,p_End_Date         Date
                       ,p_View_Type        Varchar2) Return Schedule_Tab
    Pipelined;

  Procedure Change_Tc_Status(p_Effective_Date  Date Default Null
                            ,p_Organization_Id Number Default Null
                            ,p_Person_Id       Number Default Null
                            ,p_Assignment_Id   Number Default Null
                            ,p_Tc_Status       Varchar2 Default Null
                            ,p_Is_Concurrent   Char Default 'N');

  Procedure Change_Tc_Status_Detonator(Errbuf            Out Varchar2
                                      ,Retcode           Out Varchar2
                                      ,p_Effective_Date  Varchar2 Default Null
                                      ,p_Tc_Status       Varchar2 Default Null
                                      ,p_Organization_Id Number Default Null
                                      ,p_Person_Id       Number Default Null);

  Procedure Change_Tc_Request(p_Effective_Date  Varchar2 Default Null
                             ,p_Organization_Id Number Default Null
                             ,p_Person_Id       Number Default Null
                             ,p_Tc_Status       Varchar2 Default Null);

                             
  Function Get_Schedule_Close_Date(p_Sched_Id Number) Return Date;
  
End Xxhxt_Timesheet_Ui_Pkg;
/



-- End of DDL Script for Package FC22.XXHXT_TIMESHEET_UI_PKG

