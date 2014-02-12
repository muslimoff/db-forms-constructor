Select *
  From global_params t;
--:p_form_code, :p_master_form_code, :p_drilldown_flag  
With t As
     (
        Select t.param_name, t.description, t.param_value
              ,REGEXP_REPLACE (REGEXP_REPLACE (REGEXP_REPLACE (REGEXP_REPLACE (t.param_value
                                                                              ,':p_form_code'
                                                                              ,'''FORMS'''
                                                                              ,1
                                                                              ,1
                                                                              ,'i'
                                                                              )
                                                              ,':p_Master_form_code'
                                                              ,''''''
                                                              ,1
                                                              ,1
                                                              ,'i'
                                                              )
                                              ,':p_drilldown_flag'
                                              ,'''N'''
                                              ,1
                                              ,1
                                              ,'i'
                                              )
                              ,'&fc_schema_owner.'
                              ,'FC22'
                              ,1
                              ,1
                              ,'i'
                              ) As txt
          From global_params t
         Where t.param_name In
                  ('formSQL'
                  ,'ColumnsMetaDataSQL'
                  ,'columnAttributesSQL'
                  ,'columnActionsSQL'
                  ,'formActionsSQL'
--                  ,'argsSQLText'
                  ,'detailFormSQL'
                  ))
Select t.*, DBMS_XMLGEN.getxmltype (t.txt).getClobVal () As xx
  From t
/
Select FORM_UTILS_XML_TMP.get_form_xml_clob ('ColumnsMetaDataSQL'
                                            ,'FC22'                                      --fc_schema_owner      Varchar2
                                            ,'FORMS'                                     --p_form_code          Varchar2
                                            ,''                                          --p_master_form_code   Varchar2
                                            ,'Y'                                         --p_drilldown_flag     Varchar2
                                            ,'COLUMNS'
                                            ,'COLUMN'
                                            ) As xx
  From DUAL

