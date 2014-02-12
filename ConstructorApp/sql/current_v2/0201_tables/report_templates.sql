Create Table report_templates
    (report_id                      Number,
    user_id                        Number,
    app_code                       Varchar2(255),
    report_type_code               Varchar2(255),
    content_type                   Varchar2(255),
    content                        BLOB,
    filename                       Varchar2(255),
    clob_content                   CLOB)
/


-- End of DDL Script for Table FC22.REPORT_TEMPLATES

