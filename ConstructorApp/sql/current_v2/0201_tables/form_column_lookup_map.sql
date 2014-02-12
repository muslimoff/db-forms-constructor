Create Table form_column_lookup_map
    (form_column_lookup_map_id      Number,
    form_code                      Varchar2(255),
    column_code                    Varchar2(255),
    lookup_form_code               Varchar2(255),
    lookup_form_column_code        Varchar2(255),
    mapping_type                   Varchar2(255) Default 'CONSTANT',
    constant_value                 Varchar2(255),
    column_user_name               Varchar2(255),
    column_display_size            Varchar2(255),
    column_display_number          Number,
    show_on_grid                   Varchar2(1),
    column_code_to_mapping         Varchar2(255))
/

