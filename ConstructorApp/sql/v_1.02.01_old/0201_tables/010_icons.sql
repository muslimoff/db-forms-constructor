Create Table fc22.icons
    (icon_id                        Number,
    icon_file_name                 Varchar2(4000),
    icon_path                      Varchar2(255))
/

Comment On Column fc22.icons.icon_file_name Is 'файл иконки по пути default_icon_path'
/
