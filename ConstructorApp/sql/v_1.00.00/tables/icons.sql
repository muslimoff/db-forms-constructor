-- Start of DDL Script for Table FC.ICONS
-- Generated 10.04.2010 20:53:17 from FC@VM_XE

Create Table icons
    (icon_id                        Number,
    icon_file_name                 Varchar2(4000),
    icon_path                      Varchar2(255))
/

-- Grants for Table
Grant Select On icons To mz_so_integration
/




-- Comments for ICONS

Comment On Column icons.icon_file_name Is 'файл иконки по пути default_icon_path'
/

-- End of DDL Script for Table FC.ICONS

