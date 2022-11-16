--------------------------------------------------------
--  DDL for Function GET_TEAM_NAME
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "PREMIER"."GET_TEAM_NAME" ( P_COMPANYCD IN VARCHAR2, P_TEAMCD IN VARCHAR2, P_LANG IN VARCHAR2 default common.get_cookie('SYSLANG'))
RETURN VARCHAR2
IS
v_teamnm xm605.teamnm%type;

cursor fnd_teamcd is
select name
from   master_language
where  tableid = 'XM605'
and    companycd = p_companycd
and    code = p_teamcd
and    lang = p_lang;

--select decode(p_lang,'KO',teamnm,'EN',teamnm_eng)
--from   xm605
--where  companycd = p_companycd
--and    teamcd = p_teamcd;

BEGIN

  open fnd_teamcd;
  fetch fnd_teamcd into v_teamnm;
  if fnd_teamcd%notfound then v_teamnm := null; end if;
  close fnd_teamcd;
  
  return ( v_teamnm );
  
END GET_TEAM_NAME;

/
