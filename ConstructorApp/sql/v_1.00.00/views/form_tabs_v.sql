-- Start of DDL Script for View FC.FORM_TABS_V
-- Generated 10.04.2010 22:53:29 from FC@VM_XE

CREATE force View form_tabs_v (
   form_code,
   tab_code,
   child_form_code,
   tab_position,
   tab_name,
   number_of_columns,
   icon_id,
   tab_type,
   tab_display_number )
As
Select ft.form_code, ft.tab_code, ft.child_form_code, NVL (ft.tab_position, 'R') tab_position
      ,                                                                                                          --NVL (
       NVL (ft.tab_name, (Select NVL (f.form_name, f.form_code)
                            From forms f
                           Where f.form_code = ft.child_form_code))
                                                                   --, ft.tab_code)
       tab_name, NVL (ft.number_of_columns, 2) number_of_columns
      ,NVL (ft.icon_id, (Select f.icon_id
                           From forms f
                          Where f.form_code = ft.child_form_code)) icon_id, ft.tab_type, tab_display_number
  From form_tabs ft
/

-- Grants for View
Grant Select On form_tabs_v To mz_so_integration
/

-- End of DDL Script for View FC.FORM_TABS_V

