/*Select a.lookup_code, a.lookup_value_code, a.attribute_code, a.attribute_value_number, a.attribute_value_char
      ,a.attribute_value_date
  From lookup_attribute_values a
 Where a.lookup_code In (Select a.lookup_code
                           From lookups a
                          Where a.apps_code = 'FC')*/

Insert Into lookup_attribute_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "ATTRIBUTE_CODE", "ATTRIBUTE_VALUE_NUMBER", "ATTRIBUTE_VALUE_CHAR"
            ,"ATTRIBUTE_VALUE_DATE")
     Values ('FORM_ACTIONS.ACTION_TYPE', '16', 'AS_DUBLE_CLICK_ALLOWED', Null, 'Y', Null)
/
Insert Into lookup_attribute_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "ATTRIBUTE_CODE", "ATTRIBUTE_VALUE_NUMBER", "ATTRIBUTE_VALUE_CHAR"
            ,"ATTRIBUTE_VALUE_DATE")
     Values ('FORM_ACTIONS.ACTION_TYPE', '2', 'AS_DRAGANDDROP_ALLOWED', Null, 'Y', Null)
/
Insert Into lookup_attribute_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "ATTRIBUTE_CODE", "ATTRIBUTE_VALUE_NUMBER", "ATTRIBUTE_VALUE_CHAR"
            ,"ATTRIBUTE_VALUE_DATE")
     Values ('FORM_ACTIONS.ACTION_TYPE', '10', 'AS_DUBLE_CLICK_ALLOWED', Null, 'Y', Null)
/
Insert Into lookup_attribute_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "ATTRIBUTE_CODE", "ATTRIBUTE_VALUE_NUMBER", "ATTRIBUTE_VALUE_CHAR"
            ,"ATTRIBUTE_VALUE_DATE")
     Values ('FORM_ACTIONS.ACTION_TYPE', '11', 'AS_DUBLE_CLICK_ALLOWED', Null, 'Y', Null)
/
Insert Into lookup_attribute_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "ATTRIBUTE_CODE", "ATTRIBUTE_VALUE_NUMBER", "ATTRIBUTE_VALUE_CHAR"
            ,"ATTRIBUTE_VALUE_DATE")
     Values ('FORM_ACTIONS.ACTION_TYPE', '8', 'AS_DUBLE_CLICK_ALLOWED', Null, 'Y', Null)
/
Insert Into lookup_attribute_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "ATTRIBUTE_CODE", "ATTRIBUTE_VALUE_NUMBER", "ATTRIBUTE_VALUE_CHAR"
            ,"ATTRIBUTE_VALUE_DATE")
     Values ('FORM_ACTIONS.ACTION_TYPE', '15', 'AS_DUBLE_CLICK_ALLOWED', Null, 'Y', Null)
/
Insert Into lookup_attribute_values
            ("LOOKUP_CODE", "LOOKUP_VALUE_CODE", "ATTRIBUTE_CODE", "ATTRIBUTE_VALUE_NUMBER", "ATTRIBUTE_VALUE_CHAR"
            ,"ATTRIBUTE_VALUE_DATE")
     Values ('FORM_ACTIONS.ACTION_TYPE', '2', 'AS_DUBLE_CLICK_ALLOWED', Null, 'Y', Null)
/

