Select a.form_code, a.description, Length (a.description) len, DBMS_LOB.SUBSTR (a.description, 4000, 1) x
  From forms a
 Where a.form_code In
          ('COLUMNS_LIST'
          ,'FORM_ACTIONS'
          ,'FORM_COLUMNS'
          ,'FORM_TABS'
          ,'FORM_TABS_LIST'
          ,'FORMS'
          ,'FORMS_LIST'
          ,'FORMS2'
          ,'ICONS'
          ,'LOOKUP_VALUES'
          ,'LOOKUPS'
          ,'LOOKUPS_LIST'
          ,'MENUS'
          )
   And a.description Is Not Null
   And DBMS_LOB.SUBSTR (a.description, 4000, 1) != '<br>'
/
Select a.form_code, a.help_text, Length (a.help_text), DBMS_LOB.SUBSTR (a.help_text, 2000, 1) x
  From form_columns a
 Where a.form_code In
          ('COLUMNS_LIST'
          ,'FORM_ACTIONS'
          ,'FORM_COLUMNS'
          ,'FORM_TABS'
          ,'FORM_TABS_LIST'
          ,'FORMS'
          ,'FORMS_LIST'
          ,'FORMS2'
          ,'ICONS'
          ,'LOOKUP_VALUES'
          ,'LOOKUPS'
          ,'LOOKUPS_LIST'
          ,'MENUS'
          )
   And a.help_text Is Not Null

