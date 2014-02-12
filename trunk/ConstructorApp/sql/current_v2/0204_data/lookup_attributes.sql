/*Select a.lookup_code, a.attribute_code, a.attribute_name, a.attribute_type
  From lookup_attributes a
 Where a.lookup_code In (Select a.lookup_code
                           From lookups a
                          Where a.apps_code = 'FC')*/

Insert Into lookup_attributes
            ("LOOKUP_CODE", "ATTRIBUTE_CODE", "ATTRIBUTE_NAME", "ATTRIBUTE_TYPE")
     Values ('FORM_ACTIONS.ACTION_TYPE', 'AS_DRAGANDDROP_ALLOWED'
            ,'Может использоваться при автосохранении при перетаскивании', 'B')
/
Insert Into lookup_attributes
            ("LOOKUP_CODE", "ATTRIBUTE_CODE", "ATTRIBUTE_NAME", "ATTRIBUTE_TYPE")
     Values ('FORM_ACTIONS.ACTION_TYPE', 'AS_DUBLE_CLICK_ALLOWED', 'Может использоваться при открытии записи', 'B')
/

