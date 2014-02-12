Create Table form_props
    (property_level                 Varchar2(4000),
    property_code                  Varchar2(4000),
    property_name                  Varchar2(4000),
    description                    Varchar2(4000),
    help_text                      CLOB,
    prop_datatype                  Varchar2(4000),
    property_id                    Number)
/


-- Comments for FORM_PROPS

Comment On Column form_props.description Is 'Описание, для подсказки'
/
Comment On Column form_props.help_text Is 'HTML текст для подсказки в интерфейсе'
/
Comment On Column form_props.prop_datatype Is 'Тип данных N(umber) D(ate) S(tring) B(oolean) L(OB)'
/
Comment On Column form_props.property_code Is 'напр SQL_TEXT'
/
Comment On Column form_props.property_id Is 'ID'
/
Comment On Column form_props.property_level Is 'FORM->TAB->COLUMN-ACTION'
/
Comment On Column form_props.property_name Is 'напр "Текст запроса"'
/

-- End of DDL Script for Table FC22.FORM_PROPS

