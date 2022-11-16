--------------------------------------------------------
--  DDL for Function GET_SYSTYPE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "PREMIER"."GET_SYSTYPE" (
  p_companycd in varchar2,
  p_xuser in varchar2
)
return varchar2
is
  cursor cur is
    select gubun
    from c_0010
    where 1=1
--    and   companycd = p_companycd
    and   xuser = p_xuser
    and   rownum = 1
    ;
      
  v_gubun c_0010.gubun%type;

begin

  open cur;
  fetch cur into v_gubun;
  close cur;
  
  return v_gubun;

end get_systype;

/
