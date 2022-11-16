--------------------------------------------------------
--  DDL for Function GET_CATALOG_NAME
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "PREMIER"."GET_CATALOG_NAME" 
( 
  P_SYSTEMCD IN VARCHAR2, 
  P_CATALOGCD IN VARCHAR2,
  P_LANG IN VARCHAR2,
  P_CODE IN VARCHAR2
)
RETURN VARCHAR2
IS

cursor fnd_name is
select listdescr
from   c_0051
where  systemcd = upper(p_systemcd)
and    upper(catalogcd) = upper(p_catalogcd)
and    lang = upper(p_lang)
and    listvalue = p_code;

v_name c_0051.listdescr%type := null;
BEGIN

  open fnd_name;
  fetch fnd_name into v_name;
  if fnd_name%notfound then v_name := null; end if;
  close fnd_name;
  
  return ( v_name );
  
END GET_CATALOG_NAME;

/
