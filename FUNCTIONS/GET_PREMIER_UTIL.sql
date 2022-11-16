--------------------------------------------------------
--  DDL for Function GET_PREMIER_UTIL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "PREMIER"."GET_PREMIER_UTIL" 
RETURN VARCHAR2
AS
    v_premier_util varchar2(100);
BEGIN

    if upper(owa_util.get_cgi_env('SCRIPT_NAME')) = '/KAPS' then
        v_premier_util := '/premier_util';
    else
        v_premier_util := '/';
    end if;
  
    return ( v_premier_util );

END GET_PREMIER_UTIL;

/
