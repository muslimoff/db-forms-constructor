Update form_actions a
   Set a.url_text = '[ModuleBaseURL]/' || a.url_text
 Where a.url_text Like 'xmlp?%'

