--------------------------------------------------------
--  DDL for Procedure SECUR_CONFIRM
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PREMIER"."SECUR_CONFIRM" 
IS
  cursor fnd_xusernm is  
    select *
    from c_0010 a
    where 1=1
    and   useyn = 'Y'
    and   companycd = common.get_cookie('SYSCOMP')
    and   xuser = common.get_cookie('SYSID')
    and   rownum = 1
    ;  

  rec fnd_xusernm%rowtype;
  
  cursor fnd_companynm is
    select *
    from xm001_login
    where 1=1
    and   companycd = common.get_cookie('SYSCOMP')
    and   rownum = 1
    ;
    
  rec_cmpynm fnd_companynm%rowtype;

BEGIN

  open fnd_xusernm;    
  fetch fnd_xusernm into rec;    
  close fnd_xusernm;    

  open fnd_companynm;    
  fetch fnd_companynm into rec_cmpynm;    
  close fnd_companynm;    
  
  htp.p('
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>'||common.title||'</title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
  <link rel="stylesheet" href="/include/dbv_docu.css">
  </head>
 
<body>
<div class="secu_wrap">
  <div class="secu_box">
    <h1 align="center">'||get_fn('회사정보 보안관련 서약서')||'</h1>
    <br><br>
    <ul> 
      <li>'||get_fn('사용자(갑)')||' : '||rec_cmpynm.descr1||'</li>
      <li>'||get_fn('근로자(을)')||' : '||rec.xusernm||'</li>
    </ul>
    <br>
      '||get_fn('자신의 고의 또는 과실로 사내(社內)의 문서가 무단 복제 및 유출되어 회사의 영업상이익을 침해하여 손해를 가하였을 경우 그')||' 
      <b>'||get_fn('손해를 배상할 책임 및 형사적인 책임')||'</b>'||get_fn('도 함께 질 것을 서약합니다.')||' <br>
      <br>
    <br><br>
    <div class="txtCenter">
      <a href="javascript:location.replace(''main_kaps.control'');"><input type="button" class="btnSecu btnOK" value="서약합니다 (Accept)"></a>
      <a href="javascript:location.replace(''login'');"><input type="button" class="btnSecu btnCencel" value="취소 (Cancel)"></a>
    </div>
  </div>
</div>
 
</BODY>
</HTML>

');

END;

/
