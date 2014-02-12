Create Table fc22.report_templates
    (report_id                      Number,
    user_id                        Number,
    app_code                       Varchar2(255),
    report_type_code               Varchar2(255),
    content_type                   Varchar2(255),
    content                        BLOB,
    filename                       Varchar2(255),
    clob_content                   CLOB)
  Lob ("Content") Store As Sys_Lob0000039462C00006$$
  (
   Nocache Logging
   Chunk 8192
  )
  Lob ("Clob_Content") Store As Sys_Lob0000039462C00008$$
  (
   Nocache Logging
   Chunk 8192
  )
/

