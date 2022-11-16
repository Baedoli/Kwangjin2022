--------------------------------------------------------
--  DDL for Procedure PASSWORD_
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PREMIER"."PASSWORD_" 
IS

BEGIN

  htp.p('
    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
    <html lang="ko">
    <head>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <title>Kwangjin password</title>
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <meta name="viewport" content="width=device-width, initial-scale=1">
    <!--===============================================================================================-->	
      <link rel="stylesheet" type="text/css" href="/include/login/vendor/bootstrap/css/bootstrap.min.css">
      <link rel="stylesheet" type="text/css" href="/include/login/fonts/fontawesome-5.15.3/css/all.css">
      <link rel="stylesheet" type="text/css" href="/include/login/fonts/icon-font.min.css">
      <link rel="stylesheet" type="text/css" href="/include/login/vendor/animate/animate.css">
      <link rel="stylesheet" type="text/css" href="/include/login/vendor/css-hamburgers/hamburgers.min.css">
      <link rel="stylesheet" type="text/css" href="/include/login/vendor/animsition/css/animsition.min.css">
      <link rel="stylesheet" type="text/css" href="/include/login/vendor/select2/select2.min.css">
      <link rel="stylesheet" type="text/css" href="/include/login/vendor/daterangepicker/daterangepicker.css">
      <link rel="stylesheet" type="text/css" href="/include/login/css/util.css">
      <link rel="stylesheet" type="text/css" href="/resources/main/main.css">
      <link rel="icon" type="image/png" href="/resources/images/favicon.ico">
    <!--===============================================================================================-->
    </head>
    <body onselectstart="return false" ondragstart="return false">
      <div class="limiter">
        <div class="container-login100">
          <div class="wrap-login100 loginBG">
            <form class="password100-form validate-form" autocomplete="off">
              <span class="login100-form-title p-b-40" style="">
                <img src="/resources/images/logo.png" width="150px">
              </span>
              <span class="login100-form-title p-b-40">
                <h2 >Change Password!</h2><br>
                <h5>비밀번호는 대문자, 소문자, 숫자를 조합하여 8자리 이상이어야 합니다.<br>
                이전 비밀번호와 동일한 비밀번호는 사용 할 수 없으며 최소 4자리 이상 다르게 해야 합니다.<br>
                비밀번호에 개인신상자료(이름, 생년월일 등)는 사용 할 수 없습니다.</h5>
              </span>
              <div class="wrap-input100 validate-input login-box pw-icon" data-validate="현재 비밀번호를 입력하세요.">
                <input class="input100" type="text" name="passwd" id="passwd">
                <span class="focus-input100"></span>
                <span class="label-input100">현재 비밀번호</span>
              </div>
              <div class="wrap-input100 validate-input login-box pw-icon" data-validate="신규 비밀번호를 입력하세요.">
                <input class="input100" type="password" name="passwd" id="passwd">
                <span class="focus-input100"></span>
                <span class="label-input100">신규 비밀번호</span>
              </div>
              <div class="wrap-input100 validate-input login-box pw-icon" data-validate="신규 비밀번호를 다시 입력하세요.">
                <input class="input100" type="password" name="passwd" id="passwd">
                <span class="focus-input100"></span>
                <span class="label-input100">신규 비밀번호 확인</span>
              </div>
              <div class="wrap-input100 validate-input login-box phone-icon" data-validate="휴대전화번호를 입력하세요.">
                <input class="input100" type="password" name="phone" id="phone">
                <span class="focus-input100"></span>
                <span class="label-input100">휴대전화번호</span>
              </div>
              <div class="wrap-input100 validate-input login-box mail-icon" data-validate="이메일주소를 입력하세요.">
                <input class="input100" type="email" name="email" id="email">
                <span class="focus-input100"></span>
                <span class="label-input100">이메일주소</span>
              </div>
              <!--Html 디자인 용도 -->
              <div class="wrap-input100 login-box lang-icon">
                <select name="lang" id="lang">
                  <option value="KOR">한국어(Korean)</option>
                  <option value="CHN">중국어(Chinese)</option>
                  <option value="ENG">영어(English)</option>
                </select>
              </div>
              <!-- 실제 JSP 코딩 -->
              <!--
              <div class="wrap-input100 login-box lang-icon">
                <select name="lang" id="lang">
                  <c:forEach var="result" items="${lang}">
                  <option value="${result.lang}">${result.langname}(${result.langnameeng})</option>
                  </c:forEach>
                </select>
              </div>
              -->
              <div class="flex-sb-m w-full p-t-2 p-b-15 login-box">
                <div class="contact100-form-checkbox">
                  <input class="input-checkbox100" id="ckb1" type="checkbox" name="remember-me" checked>
                  <label class="label-checkbox100" for="ckb1">
                    Remember me
                  </label>
                </div>
              </div>
              <div class="container-login100-form-btn login-box">
                <button class="login100-form-btn form-btn" id="btn_login">
                  confirm
                </button>
                <button class="cancel200-form-btn form-btn" id="btn_auth_back">
                  cancel
                </button>
              </div>
              
              <div class="wrap-input100 auth-box" style="display:none;">
                <input class="input100" type="text" name="authkey" id="authkey">
                <span class="focus-input100"></span>
                <span class="label-input100">인증번호</span>
              </div>
              <div class="container-login100-form-btn  auth-box" style="display:none;">
                <button class="login100-form-btn" id="btn_auth" type="button">
                  OK
                </button>
                <button class="cancel100-form-btn" id="btn_auth_back" type="button">
                  CANCEL
                </button>
              </div>
              <!-- 실제 JSP 코딩 -->
              <!--
              <div class="wrap-input100 partner-box" style="display:none">
                <select id="mgtcmpysn" name="mgtcmpysn">
                  <option value="">사업장을 선택하세요.</option>
                  <c:forEach var="item" items="${comp}" varStatus="status">
                  <option value="${item.cmpysn }">${item.cmpynm }</option>
                  </c:forEach>
                </select>
              </div>
              -->
              <div class="container-login100-form-btn  partner-box" style="display:none;">
                <button class="login100-form-btn" id="btn_partner" type="button">
                  OK
                </button>
                <button class="cancel100-form-btn" id="btn_partner_back" type="button">
                  CANCEL
                </button>
              </div>
              
              <div class="wrap-input100 pw-box" style="display:none;">
                <input class="input100" type="password" name="curPw" id="curPw">
                <span class="focus-input100"></span>
                <span class="label-input100">기존비밀번호</span>
              </div>
              <div class="wrap-input100 pw-box" style="display:none;">
                <input class="input100" type="password" name="newPw" id="newPw">
                <span class="focus-input100"></span>
                <span class="label-input100">새 비밀번호</span>
              </div>
              <div class="wrap-input100 pw-box" style="display:none;">
                <input class="input100" type="password" name="chkPw" id="chkPw">
                <span class="focus-input100"></span>
                <span class="label-input100">비밀번호 확인</span>
              </div>
              <div class="container-login100-form-btn  pw-box" style="display:none;">
                <button class="login100-form-btn" id="btn_pw_chg" type="button">
                  OK
                </button>
                <button class="cancel100-form-btn" id="btn_pw_back" type="button">
                  CANCEL
                </button>
              </div>
              <div class="container-login100-form-btn p-t-10 pw-box" style="display:none;">
                <button class="cancel100-form-btn" id="btn_pw_pass" type="button">
                  다음에 변경하기
                </button>
              </div>
              <div class="mobile_hidden text-center" style="text-align: left!important; bottom: 100px; position: fixed;">
              </div> 
              <div class="mobile_hidden p-b-20 lh-2-9" style="bottom: 0; position:fixed; min-top:600;">
                <span class="txt2">©2022 DBVALLEY CO.,LTD. ALL RIGHT RESERVED.</span><!--<br>
                <a style="color:#dddddd!important; width:120px; display: inline-block !important; background: #6C747F; border-radius: 4px; text-align:center;" href="http://www.dbvalley.com/?page_id=4929" target="_black" class="fs-12 m-t-5">개인정보처리방침</a>-->
              </div> 
            </form>

            <div class="password100-more">
              
            </div>
          </div>
        </div>
      </div>
      <div class="wrap-loading display-none">
        <div><img style="width: 42px; height: 42px;" src="/resources/images/ajaxloading.gif"></div>
      </div> 
      
    <!--===============================================================================================-->
    <script src="/include/login/vendor/jquery/jquery-3.2.1.min.js"></script>
    <script src="/include/login/vendor/animsition/js/animsition.min.js"></script>
    <script src="/include/login/vendor/animsition/js/popper.js"></script>
    <script src="/include/login/vendor/bootstrap/js/bootstrap.min.js"></script>
    <script src="/include/login/vendor/select2/select2.min.js"></script>
    <script src="/include/login/vendor/daterangepicker/moment.min.js"></script>
    <script src="/include/login/vendor/daterangepicker/daterangepicker.js"></script>
    <script src="/include/login/vendor/countdowntime/countdowntime.js"></script>
    <script src="/include/jquery/jquery.form.js" type="text/javascript"></script>
    <script src="/js/common/premier_util.js" type="text/javascript"></script>
    <script src="/include/login/js/main_premier_v1.js"></script>
  <!--===============================================================================================-->
      
      <!-- 실제 JSP 코딩 -->
      <!--
      ${init}
      -->
      
    </body></html>
  ');

exception
  when others then 
    show_err('PASSWORD_');
END PASSWORD_;

/
