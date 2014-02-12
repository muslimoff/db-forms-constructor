-- Start of DDL Script for Type FC22.ARGS_T
-- Generated 17.11.2013 0:54:29 from FC22@XE

Create Or Replace Type args_t As Table Of Varchar2 (4000)
/

-- End of DDL Script for Type FC22.ARGS_T

-- Start of DDL Script for Type FC22.STRING_AGG_TYPE
-- Generated 17.11.2013 0:54:29 from FC22@XE

Create Or Replace Type string_agg_type As Object (
   Separator   Varchar2 (10)
  ,Total       Varchar2 (4000)
  ,Static Function Odciaggregateinitialize (Sctx In Out String_Agg_Type)
      Return Number
  ,Member Function Odciaggregateiterate (
      Self          In Out   String_Agg_Type
     ,Value         In       Varchar2
     ,p_Separator   In       Varchar2 := ' / '
   )
      Return Number
  ,Member Function Odciaggregateterminate (Self In String_Agg_Type, Returnvalue Out Varchar2, Flags In Number)
      Return Number
  ,Member Function Odciaggregatemerge (Self In Out String_Agg_Type, Ctx2 In String_Agg_Type)
      Return Number
)
/

Create Or Replace Type Body string_agg_type Is
   Static Function Odciaggregateinitialize (Sctx In Out String_Agg_Type)
      Return Number Is
   Begin
      Sctx    := String_Agg_Type (Null, Null);
      Return Odciconst.Success;
   End;
   Member Function Odciaggregateiterate (Self In Out String_Agg_Type, Value In Varchar2, p_Separator In Varchar2
            := ' / ')
      Return Number Is
   Begin
      Self.Separator    := p_Separator;
      Self.Total        := Self.Total || Value || Self.Separator;
      Return Odciconst.Success;
   End;
   Member Function Odciaggregateterminate (Self In String_Agg_Type, Returnvalue Out Varchar2, Flags In Number)
      Return Number Is
   Begin
      Returnvalue    := Rtrim (Self.Total, Self.Separator);
      Return Odciconst.Success;
   End;
   Member Function Odciaggregatemerge (Self In Out String_Agg_Type, Ctx2 In String_Agg_Type)
      Return Number Is
   Begin
      Self.Total    := Self.Total || Ctx2.Total;
      Return Odciconst.Success;
   End;
End;
/

Create Or Replace Function stragg (Input Varchar2)
   Return Varchar2 Parallel_enable
   Aggregate Using String_Agg_Type;
/

-- End of DDL Script for Type FC22.STRING_AGG_TYPE

