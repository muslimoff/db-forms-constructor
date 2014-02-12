Update form_actions a
   Set a.url_text = a.procedure_name
      ,a.procedure_name = Null
 Where a.action_type In (12, 15)
   And a.procedure_name Is Not Null
   And a.url_text Is Null
--   And (   a.procedure_name Like '%xmlp%'
--        Or a.procedure_name Like '%/%')
/
Select *
  From form_actions a
 Where a.action_type In (12, 15)
--   And a.procedure_name Is Not Null
   And a.url_text Is not Null

