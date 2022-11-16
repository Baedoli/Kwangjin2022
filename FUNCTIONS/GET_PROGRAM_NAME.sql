--------------------------------------------------------
--  DDL for Function GET_PROGRAM_NAME
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "PREMIER"."GET_PROGRAM_NAME" ( P_SYSTEMCD IN VARCHAR2, P_PGMID IN VARCHAR2, P_LANG IN VARCHAR2 )
RETURN VARCHAR2
IS
v_pgmnm c_0041.pgmnm%type;

cursor fnd_c_0041 is
select pgmnm
from   c_0041
where  systemcd = upper(p_systemcd)
and    pgmid = upper(p_pgmid) 
and    lang = upper(p_lang);

BEGIN

  open fnd_c_0041;
  fetch fnd_c_0041 into v_pgmnm;
  if fnd_c_0041%notfound then v_pgmnm := null; end if;
  close fnd_c_0041;
  
  return ( v_pgmnm );
  
END GET_PROGRAM_NAME;

/
