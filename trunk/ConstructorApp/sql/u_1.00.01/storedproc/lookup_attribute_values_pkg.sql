-- Start of DDL Script for Package FC22.LOOKUP_ATTRIBUTE_VALUES_PKG
-- Generated 12.04.2010 16:18:01 from FC22@VM_XE

Create Or Replace Package lookup_attribute_values_pkg As
   Procedure p_delete (
      p_lookup_code              In Out   Varchar2
     ,p_lookup_value_code        In Out   Varchar2
     ,p_attribute_code           In Out   Varchar2
     ,p_attribute_value_number   In Out   Number
     ,p_attribute_value_char     In Out   Varchar2
     ,p_attribute_value_date     In Out   Varchar2
   );

   Procedure p_ins_upd (
      p_lookup_code              In Out   Varchar2
     ,p_lookup_value_code        In Out   Varchar2
     ,p_attribute_code           In Out   Varchar2
     ,p_attribute_value_number   In Out   Number
     ,p_attribute_value_char     In Out   Varchar2
     ,p_attribute_value_date     In Out   Varchar2
   );
End LOOKUP_ATTRIBUTE_VALUES_PKG;
/

Create Or Replace Package Body lookup_attribute_values_pkg As
   Procedure p_delete (
      p_lookup_code              In Out   Varchar2
     ,p_lookup_value_code        In Out   Varchar2
     ,p_attribute_code           In Out   Varchar2
     ,p_attribute_value_number   In Out   Number
     ,p_attribute_value_char     In Out   Varchar2
     ,p_attribute_value_date     In Out   Varchar2
   ) Is
   Begin
      Delete From LOOKUP_ATTRIBUTE_VALUES
            Where lookup_code = p_lookup_code
              And lookup_value_code = p_lookup_value_code
              And attribute_code = p_attribute_code
              And attribute_value_number = p_attribute_value_number
              And attribute_value_char = p_attribute_value_char
              And attribute_value_date = p_attribute_value_date;
   End p_delete;

   Procedure p_ins_upd (
      p_lookup_code              In Out   Varchar2
     ,p_lookup_value_code        In Out   Varchar2
     ,p_attribute_code           In Out   Varchar2
     ,p_attribute_value_number   In Out   Number
     ,p_attribute_value_char     In Out   Varchar2
     ,p_attribute_value_date     In Out   Varchar2
   ) Is
   Begin
      Update    LOOKUP_ATTRIBUTE_VALUES
            Set lookup_code = p_lookup_code
               ,lookup_value_code = p_lookup_value_code
               ,attribute_code = p_attribute_code
               ,attribute_value_number = p_attribute_value_number
               ,attribute_value_char = p_attribute_value_char
               ,attribute_value_date = p_attribute_value_date
          Where lookup_code = p_lookup_code
            And lookup_value_code = p_lookup_value_code
            And attribute_code = p_attribute_code
      Returning lookup_code, lookup_value_code, attribute_code, attribute_value_number, attribute_value_char
               ,attribute_value_date
           Into p_lookup_code, p_lookup_value_code, p_attribute_code, p_attribute_value_number, p_attribute_value_char
               ,p_attribute_value_date;

      If Sql%Rowcount = 0 Then
         Insert Into LOOKUP_ATTRIBUTE_VALUES
                     (lookup_code, lookup_value_code, attribute_code, attribute_value_number, attribute_value_char
                     ,attribute_value_date)
              Values (p_lookup_code, p_lookup_value_code, p_attribute_code, p_attribute_value_number
                     ,p_attribute_value_char, p_attribute_value_date)
           Returning lookup_code, lookup_value_code, attribute_code, attribute_value_number
                    ,attribute_value_char, attribute_value_date
                Into p_lookup_code, p_lookup_value_code, p_attribute_code, p_attribute_value_number
                    ,p_attribute_value_char, p_attribute_value_date;
      End If;
   End p_ins_upd;
End LOOKUP_ATTRIBUTE_VALUES_PKG;
/

-- End of DDL Script for Package FC22.LOOKUP_ATTRIBUTE_VALUES_PKG

