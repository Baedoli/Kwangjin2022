--------------------------------------------------------
--  DDL for Function GET_MASTER_NAME
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "PREMIER"."GET_MASTER_NAME" ( 
    P_TABLEID         in varchar2, 
    P_CODE                 IN VARCHAR2, 
    P_GUBUN             IN VARCHAR2 default '0',
    P_LANG                 in varchar2 default common.get_cookie('SYSLANG'),    
    P_COMPANYCD     IN VARCHAR2 default common.get_cookie('SYSCOMP') 
)
RETURN VARCHAR2
IS
    cursor fnd_teamcd is
    select name
    from   master_language
    where  tableid = p_tableid
    and    companycd = p_companycd
    and    code = p_code
    and    gubun = p_gubun
    and    lang = p_lang;

    v_name master_language.name%type;

BEGIN

  open fnd_teamcd;
  fetch fnd_teamcd into v_name;
  if fnd_teamcd%notfound then v_name := null; end if;
  close fnd_teamcd;
  
  return ( v_name );
  
END get_master_name;

/
