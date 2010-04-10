-- Start of DDL Script for Package FC.TEXT_UTILS
-- Generated 10.04.2010 22:28:20 from FC@VM_XE

Create Or Replace 
package text_utils is

  -- Author  : V.SAFRONOV
  -- Created : 23.12.2009 14:52:14
  -- Purpose : 

  -- Public type declarations

  function format(p_str varchar2, p_args args_t default null) return varchar2;

end TEXT_UTILS;
/


Create Or Replace 
package body text_utils is

  function format(p_str varchar2, p_args args_t default null) return varchar2 as
    l_str varchar2(32000) := p_str;
  begin
    if p_args is not null then
      for i in 1 .. p_args.count loop
        l_str := replace(l_str, '%' || i, p_args(i));
      end loop;
    end if;
    return l_str;
  end;

end TEXT_UTILS;
/


-- End of DDL Script for Package FC.TEXT_UTILS

