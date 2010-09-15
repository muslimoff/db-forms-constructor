Create Table hours_types
    (hours_type_id                  Number,
    hours_type_code                Varchar2(20) NOT NULL,
    hours_type_name                Varchar2(255),
    use_in_shifts_flag             Varchar2(1))
/
Grant Select On hours_types To fc22
/


Alter Table hours_types
Add Constraint hours_types_uk1 Unique (hours_type_id)
Using Index
/
Alter Table hours_types
Add Constraint hours_types_pk Primary Key (hours_type_code)
Using Index
/
Comment On Table hours_types Is 'Типы часов - дневные/ночные/вечерние/праздничные/выходные'
/
Create Table shedule_shift_overrides
    (shedule_shift_override_id      Number NOT NULL,
    shedule_shift_id               Number,
    override_date                  Date,
    override_shift_code            Varchar2(20),
    override_hours_type            Varchar2(20))
/
Grant Select On shedule_shift_overrides To fc22
/


Alter Table shedule_shift_overrides
Add Constraint shedule_shift_overrides_pk Primary Key (shedule_shift_override_id)
Using Index
/

Comment On Table shedule_shift_overrides Is 'Для неалгоритмизируемых переносов, например для переносов по распоряжению правительства выходных дней.'
/
Alter Table shedule_shift_overrides
Add Constraint shedule_shift_overrides_ss_fk Foreign Key (shedule_shift_id)
References shedule_shifts (shedule_shift_id)
/
Create Table shedule_shifts
    (shedule_shift_id               Number,
    shedule_code                   Varchar2(20),
    shift_order_number             Number,
    shift_code                     Varchar2(20))
/
Grant Select On shedule_shifts To fc22
/


Alter Table shedule_shifts
Add Constraint shedule_shifts_uk1 Unique (shedule_shift_id)
Using Index
/
Alter Table shedule_shifts
Add Constraint shedule_shifts_uk2 Unique (shedule_code, shift_order_number,
  shift_code)
Using Index
/


Comment On Column shedule_shifts.shift_order_number Is 'Порядковый номер в смене'
/
Alter Table shedule_shifts
Add Constraint shedule_shifts_shedules_fk Foreign Key (shedule_code)
References shedules (shedule_code)
/
Alter Table shedule_shifts
Add Constraint shedule_shifts_shifts_fk Foreign Key (shift_code)
References shifts (shift_code)
/
Create Table shedule_types
    (shedule_type_id                Number,
    shedule_type_code              Varchar2(20) NOT NULL,
    shedule_type_name              Varchar2(255),
    shedule_period                 Number)
/
Grant Select On shedule_types To fc22
/


Alter Table shedule_types
Add Constraint shedule_types_uk1 Unique (shedule_type_id)
Using Index
/
Alter Table shedule_types
Add Constraint shedule_types_pk Primary Key (shedule_type_code)
Using Index
/
Comment On Column shedule_types.shedule_period Is 'Периодичность графика. Если не указана - вычисляем из его смен'
/
Create Table shedules
    (shedule_id                     Number,
    shedule_type_code              Varchar2(20),
    shedule_code                   Varchar2(20) NOT NULL,
    shedule_name                   Varchar2(255),
    is_primary_flag                Varchar2(1),
    shift_time_from_primary        Date,
    shedule_start_date             Date)
/
Grant Select On shedules To fc22
/


Alter Table shedules
Add Constraint shedules_uk1 Unique (shedule_id)
Using Index
/
Alter Table shedules
Add Constraint shedules_pk Primary Key (shedule_code)
Using Index
/

Comment On Column shedules.is_primary_flag Is 'Из нескольких скользящих смен только одна является основной, остальные можно получить сдвижкой'
/
Comment On Column shedules.shedule_start_date Is 'Дата начала графика. 1-й день.'
/
Comment On Column shedules.shift_time_from_primary Is 'Сдвижка в часах от основной смены'
/
Alter Table shedules
Add Constraint shedules_shedule_types_fk Foreign Key (shedule_type_code)
References shedule_types (shedule_type_code)
/
Create Table shift_hours
    (shitf_hours_id                 Number,
    shift_code                     Varchar2(20),
    hours_type_code                Varchar2(20),
    time_from                      Date,
    time_to                        Date,
    hours                          Date)
/
Grant Select On shift_hours To fc22
/


Alter Table shift_hours
Add Constraint shift_hours_uk1 Unique (shitf_hours_id)
Using Index
/
Alter Table shift_hours
Add Constraint shift_hours_uk2 Unique (shift_code, hours_type_code)
Using Index
/


Alter Table shift_hours
Add Constraint shift_hours_hours_types_fk Foreign Key (hours_type_code)
References hours_types (hours_type_code)
/
Alter Table shift_hours
Add Constraint shift_hours_shifts_fk Foreign Key (shift_code)
References shifts (shift_code)
/
Create Table shifts
    (shift_id                       Number,
    shift_code                     Varchar2(20) NOT NULL,
    shift_name                     Varchar2(255))
/
Grant Select On shifts To fc22
/


Alter Table shifts
Add Constraint shifts_uk1 Unique (shift_id)
Using Index
/
Alter Table shifts
Add Constraint shifts_pk Primary Key (shift_code)
Using Index
/

