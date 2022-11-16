--------------------------------------------------------
--  DDL for Function GET_ROLE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "PREMIER"."GET_ROLE" ( P_COMPANYCD IN VARCHAR2, P_GUBUN IN VARCHAR2, P_USERID IN VARCHAR2,
                                             P_SYSTEMCD IN VARCHAR2 )
RETURN VARCHAR2
IS
v_grade c_0020.grade%type;

cursor fnd_role is
select grade
from   c_0020
where  useyn ='Y' 
and    companycd = p_companycd
and    gubun = p_gubun
and    xuser = p_userid
and    systemcd = upper(p_systemcd);

BEGIN

  open fnd_role;
  fetch fnd_role into v_grade;
  if fnd_role%notfound then v_grade := null; end if;
  close fnd_role;
  
  return ( v_grade );
  
END GET_ROLE;

/
