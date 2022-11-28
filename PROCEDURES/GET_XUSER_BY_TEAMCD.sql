--------------------------------------------------------
--  DDL for Procedure GET_XUSER_BY_TEAMCD
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PREMIER"."GET_XUSER_BY_TEAMCD" (
  p_companycd in varchar2,
  p_teamcd in varchar2 default null,
  p_xuser in varchar2 default null,
  p_all_type in varchar2 default null
)
is
  cursor cur is 
    select nvl(b.code, a.xuser) xuser, nvl(b.name, a.xusernm) xusernm, decode(nvl(b.code, a.xuser), p_xuser, ' selected=\"selected\"', null) selected
    from c_0010 a, ( select *
                     from master_language
                     where tableid = 'C_0010'
                     and   lang = common.get_cookie('syslang')) b
    where a.companycd = b.companycd(+)
    and   a.gubun = b.gubun(+)
    and   a.xuser = b.code(+)
    and   a.companycd = p_companycd
    and   a.teamcd = p_teamcd
    and   a.useyn = 'Y'
    order by nvl(b.code, a.xuser)
    ;
    
  type r02 is table of cur%rowtype index by pls_integer;
  rec r02;
  
begin
  
  open cur;
  fetch cur bulk collect into rec;
  close cur;
    
  htp.p('[');
  
  if lower(p_all_type) = 'a' then      --  전체
    htp.p('  {"optionValue": "", "optionName": "'||get_fn('전체')||'", "optionSelected": ""}');
  elsif substr(lower(p_all_type), 1, 1) = 'a' and length(lower(p_all_type)) > 1 then  --  value는 substr(lower(p_all_type), 2, length(p_all_type))
    htp.p('  {"optionValue": "'||substr(lower(p_all_type), 2, length(p_all_type))||'", "optionName": "'||get_fn('전체')||'", "optionSelected": ""');
  elsif lower(p_all_type) = 'b' then  --  빈칸
    htp.p('  {"optionValue": "", "optionName": "", "selected": ""}');
  elsif lower(p_all_type) = 'c' then  --  선택하세요
    htp.p('  {"optionValue": "", "optionName": "'||get_fn('선택하세요')||'", "optionSelected": ""}');
  elsif lower(p_all_type) = 'z' then  --  칸 없음
    null;
  else                                --  칸 없음
    null;
  end if;
  
  if lower(p_all_type) <> 'z' and rec.count > 0 then
    htp.p(',');
  end if;
  
  for i in 1 .. rec.count loop
    htp.p('  {"optionValue": "'||rec(i).xuser||'", "optionName": "'||rec(i).xusernm||'", "optionSelected": "'||rec(i).selected||'"}');
    if i < rec.count then
      htp.p(',');
    end if;
  end loop;
  
  htp.p(']');
  
exception
  when others then
    htp.p('{"optionValue": "", "optionName": "'||replace(replace(sqlerrm, chr(13), null), chr(10), null)||'", "optionSelected": ""}');

end get_xuser_by_teamcd;

/
