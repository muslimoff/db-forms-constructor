Select a.form_code, a.hot_key, a.sql_text, a.form_name, a.form_type, a.show_tree_root_node, a.icon_id, a.form_width
      ,a.form_height, a.bottom_tabs_orientation, a.side_tabs_orientation, a.show_bottom_toolbar
      ,a.object_version_number, a.default_column_width                                                 --, a.description
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

