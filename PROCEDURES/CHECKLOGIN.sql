--------------------------------------------------------
--  DDL for Procedure CHECKLOGIN
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PREMIER"."CHECKLOGIN" 
(
  p_companycd in varchar2 default null,
  accid in varchar2 default null,
  passwd in varchar2 default null,
  lang in varchar2 default null,
  p_remember_me in varchar2 default null
)
AS
  cursor fnd_found is 
    select *
    from c_0010 
    where companycd = p_companycd 
--    and   gubun = p_gubun 
    and   xuser = accid 
    and   useyn = 'Y' 
    and   rownum = 1
    ;
    
  rec c_0010%rowtype;
  
  cursor fnd_login is
   select trunc(sysdate - nvl(max(login_ymd),sysdate)) 
   from login_address 
   where login_companycd = p_companycd 
   and   login_id = accid
   ;
   
  v_login_count number;
  
  cursor fnd_pass is
    select 'Y'
    from c_0010
    where 1=1
    and   companycd = p_companycd
    and   xuser = accid
    and   pass = passwd
    and   useyn = 'Y'
    and   rownum = 1
    ;
    
  v_pass c_0010.pass%type;
  
  cursor fnd_vend is
	  select *
	  from cm0070t
	  where companycd = p_companycd
	  and   c_0010_id = p_companycd||accid
	  and   rownum = 1;
  
  rec_vend cm0070t%rowtype;
  
  v_result varchar2(2);
  v_cause varchar2(2) := '1';
  v_message varchar2(4000);
  v_ip varchar2(20); 
	v_ip_2 varchar2(20);
BEGIN

  v_ip := owa_util.get_cgi_env('REMOTE_ADDR');
  v_ip_2 := sys_context('USERENV', 'IP_ADDRESS', 15);

  open fnd_found;
  fetch fnd_found into rec;
  if fnd_found%notfound then rec := null; end if;
  close fnd_found;
  
  open fnd_login;
  fetch fnd_login into v_login_count;
  close fnd_login;
  
  open fnd_pass;
  fetch fnd_pass into v_pass;
  if fnd_pass%notfound then v_pass := 'N'; end if;
  close fnd_pass;
  
  open fnd_vend;
  fetch fnd_vend into rec_vend;
  if fnd_vend%notfound then rec_vend := null; end if;
  close fnd_vend;
  
  if p_companycd is null then 
    v_result := 'N';
    v_message := '사업장을 선택해 주세요.';
  elsif rec.xuser is null then 
    v_result := 'N';
    v_message := '등록되지 않은 사용자입니다. (The ID is not registered.)';
   elsif rec.pass_failure > 5 then 
    v_result := 'N';
    v_cause := '99';
    v_message := get_fn('비밀번호가 6회 오류 입력입니다. 비밀번호 초기화 진행하세요');
  elsif v_login_count >= 31 then
    v_result := 'N';
    v_cause := '99';
    v_message := '1달이상 접속하지 않은 사용자입니다. (This is a user who has not logged in for more than 1 month.)';
  elsif v_pass  = 'N' then 
    v_result := 'N';
    v_cause := '99';
    v_message := 'Invalid Password.';
    /** 비밀번호 실패 체크 - S **/
    begin
      update c_0010
      set pass_failure = pass_failure + 1
      where 1=1
      and   companycd = p_companycd
      and   xuser = accid
      ;
    exception
      when others then 
        show_err('update-c_0010-pass_failure');
    end;
    /** 비밀번호 실패 체크 - E**/
  else
    v_result := 'Y'; 
    
    begin
      update c_0010
      set pass_failure = 0
      where 1=1
      and   companycd = p_companycd
      and   xuser = accid
      ;
    exception
      when others then 
        show_err('update-c_0010-pass_failure');
    end;
    
    begin
      insert into login_address(login_id, login_companycd, login_ymd, ip, ip2, login_yn)
      values(accid, p_companycd, get_compdate(p_companycd), v_ip, v_ip_2, 'login');
    exception when others then null;  
    end;
    
    common.set_cookie('SYSCOMP',p_companycd); 
    common.set_cookie('SYSID',accid);
    common.set_cookie('SYSLANG',nvl(lang,'KO'));
    common.set_cookie('SYSTYPE',rec.gubun);
    common.set_cookie('CCODE' ,nvl(rec_vend.vendcd,accid));
    common.set_cookie('TEAMCD' ,rec.teamcd);
    common.set_cookie('SYSCODE','QIS');                 
    common.set_cookie('SYSTITLE','KWANGJIN K-APS');
    common.set_cookie('LOGINID',p_companycd||accid);
    if accid in ('premier','dbvalley') then
    common.set_cookie('SYSADM','Y');
    end if;
     
  end if;
  
  htp.p('
    {
      "result" : "'||v_result||'", 
      "cause" : "'||v_cause||'",
      "message" : "'||v_message||'"
    }
  ');
    
EXCEPTION
  when others then 
    show_err('checkLogin');
END checkLogin;

/
