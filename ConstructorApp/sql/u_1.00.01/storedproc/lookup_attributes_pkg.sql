-- Start of DDL Script for Package FC22.LOOKUP_ATTRIBUTES_PKG
-- Generated 12.04.2010 16:17:30 from FC22@VM_XE

Create Or Replace Package lookup_attributes_pkg As
   Procedure p_delete (
      p_lookup_code      In Out   Varchar2
     ,p_attribute_code   In Out   Varchar2
     ,p_attribute_name   In Out   Varchar2
     ,p_attribute_type   In Out   Varchar2
   );

   Procedure p_ins_upd (
      p_lookup_code      In Out   Varchar2
     ,p_attribute_code   In Out   Varchar2
     ,p_attribute_name   In Out   Varchar2
     ,p_attribute_type   In Out   Varchar2
   );
End LOOKUP_ATTRIBUTES_PKG;
/

Create Or Replace Package Body lookup_attributes_pkg As
   Procedure p_delete (
      p_lookup_code      In Out   Varchar2
     ,p_attribute_code   In Out   Varchar2
     ,p_attribute_name   In Out   Varchar2
     ,p_attribute_type   In Out   Varchar2
   ) Is
   Begin
      Delete From LOOKUP_ATTRIBUTES
            Where lookup_code = p_lookup_code
              And attribute_code = p_attribute_code
              And attribute_name = p_attribute_name
              And attribute_type = p_attribute_type;
   End p_delete;

   Procedure p_ins_upd (
      p_lookup_code      In Out   Varchar2
     ,p_attribute_code   In Out   Varchar2
     ,p_attribute_name   In Out   Varchar2
     ,p_attribute_type   In Out   Varchar2
   ) Is
   Begin
      Update    LOOKUP_ATTRIBUTES
            Set lookup_code = p_lookup_code
               ,attribute_code = p_attribute_code
               ,attribute_name = p_attribute_name
               ,attribute_type = p_attribute_type
          Where lookup_code = p_lookup_code
            And attribute_code = p_attribute_code
      Returning lookup_code, attribute_code, attribute_name, attribute_type
           Into p_lookup_code, p_attribute_code, p_attribute_name, p_attribute_type;

      If Sql%Rowcount = 0 Then
         Insert Into LOOKUP_ATTRIBUTES
                     (lookup_code, attribute_code, attribute_name, attribute_type)
              Values (p_lookup_code, p_attribute_code, p_attribute_name, p_attribute_type)
           Returning lookup_code, attribute_code, attribute_name, attribute_type
                Into p_lookup_code, p_attribute_code, p_attribute_name, p_attribute_type;
      End If;
   End;
End LOOKUP_ATTRIBUTES_PKG;
/

-- End of DDL Script for Package FC22.LOOKUP_ATTRIBUTES_PKG

