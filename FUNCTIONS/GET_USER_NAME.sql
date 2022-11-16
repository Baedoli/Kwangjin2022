--------------------------------------------------------
--  DDL for Function GET_USER_NAME
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "PREMIER"."GET_USER_NAME" ( P_COMPANYCD IN VARCHAR2, P_USERID IN VARCHAR2, P_LANG IN VARCHAR2 DEFAULT COMMON.GET_COOKIE('SYSLANG'))
RETURN VARCHAR2
IS
v_xusernm master_language.name%type;

cursor fnd_xusernm is
select name
from   master_language
where  tableid = 'C_0010'
and    companycd = p_companycd
and    code = p_userid
and    gubun = '0'
and    lang = p_lang;

cursor fnd_xusernm2 is
select name
from   master_language
where  tableid = 'C_0010'
and    code = p_userid
and    gubun = '0'
and    lang = p_lang
and		rownum = 1;

--select decode(p_lang,'KO',teamnm,'EN',teamnm_eng)
--from   xm605
--where  companycd = p_companycd
--and    teamcd = p_teamcd;

BEGIN

	open fnd_xusernm;
	fetch fnd_xusernm into v_xusernm;
  if fnd_xusernm%notfound then 
			open fnd_xusernm2;
			fetch fnd_xusernm2 into v_xusernm;
			close fnd_xusernm2;
	end if;
  close fnd_xusernm;
  
  return ( v_xusernm );
  
END GET_USER_NAME;

/
