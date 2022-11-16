--------------------------------------------------------
--  DDL for Function GET_COMPDATE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "PREMIER"."GET_COMPDATE" ( p_companycd in varchar2 ) return date is
  cursor fnd_sysdate is
    select sysdate + nvl(comp_time_zone,0)/24
    from xm001
    where companycd = p_companycd;
    
  cursor fnd_timezone ( p_sysdate in date ) is
    select 1/24 
    from cm0079t
    where companycd = p_companycd
      and timezone = 'ED'
      and p_sysdate between symd and eymd; 
      
  v_sysdate  date;
  v_timezone number := 0;
begin
  
    open fnd_sysdate;
    fetch fnd_sysdate into v_sysdate;
    if fnd_sysdate%notfound then v_sysdate := sysdate; end if;
    close fnd_sysdate;

    open fnd_timezone(v_sysdate);
    fetch fnd_timezone into v_timezone;
    if fnd_timezone%notfound then v_timezone := 0; end if;
    close fnd_timezone;    

    return v_sysdate + v_timezone;
end;

/
