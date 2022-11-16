--------------------------------------------------------
--  DDL for Function GET_TEAMCD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "PREMIER"."GET_TEAMCD" ( P_COMPANYCD IN VARCHAR2, P_GUBUN IN VARCHAR2, P_USERID IN VARCHAR2 )
RETURN VARCHAR2
IS
v_teamcd c_0010.teamcd%type;

cursor fnd_c_0010 is
select nvl(teamcd,'YYYYYY')
from   c_0010
where  companycd = p_companycd
and    gubun = p_gubun
and    xuser = p_userid
and    useyn = 'Y';

BEGIN

  if p_gubun = '1' then 
     v_teamcd := '199999'; 
  else
     open fnd_c_0010;
     fetch fnd_c_0010 into v_teamcd;
     if fnd_c_0010%notfound then v_teamcd := 'YYYYYY'; end if;
     close fnd_c_0010;
  end if;
  
  return ( v_teamcd );
  
END GET_TEAMCD;

/
