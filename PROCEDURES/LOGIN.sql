--------------------------------------------------------
-- DDL for Procedure LOGIN
-- GitHub Test ..
-- 배성호 2022.11.16
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PREMIER"."LOGIN" 

--------------------------------------------------------
-- DDL for Procedure LOGIN
-- GitHub Test ..
-- 배성호 2022.11.16
--------------------------------------------------------

AS



BEGIN

htp.p('
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>'||common.title||'</title>
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
				<form class="login100-form validate-form" autocomplete="off">
					<span class="login100-form-title p-b-40" style="">
						<img src="/resources/images/logo.png" width="45%">
					</span>
					<span class="login100-form-title p-b-66">
						<h2>Welcome!</h2><br>
						<h3>Sign into Your Account</h3>
					</span>
					<div class="wrap-input100 login-box biz-icon">
						<select name="p_companycd" id="p_companycd">
							'); common.list_qc_company_login(null,'EN'); htp.p('
						</select>
					</div>
					<div class="wrap-input100 validate-input login-box id-icon" data-validate="ID를 입력하세요.">	
						<input class="input100" type="text" name="accid" id="accid">
						<span class="focus-input100"></span>
						<span class="label-input100">ID</span>
					</div>
					<div class="wrap-input100 validate-input login-box pw-icon" data-validate="Password를 입력하세요.">
						<input class="input100" type="password" name="passwd" id="passwd">
						<span class="focus-input100"></span>
						<span class="label-input100">Password</span>
					</div>
					<div class="wrap-input100 login-box lang-icon">
						<select name="lang" id="lang">
							'); common.list_catalog_name('COM','LANGUAGE',null,'KO'); htp.p('
						</select>
					</div>
					<div class="flex-sb-m w-full p-t-2 p-b-15 login-box">
						<div class="contact100-form-checkbox">
							<input class="input-checkbox100" id="ckb1" type="checkbox" name="p_remember_me" checked>
							<label class="label-checkbox100" for="ckb1">
								Remember me
							</label>
						</div>
					</div>
					<div class="container-login100-form-btn login-box">
						<button class="login100-form-btn form-btn" id="btn_login">
							Login
						</button>
						<button class="cancel100-form-btn form-btn" id="btn_password">
							Reset Password
						</button>
					</div>
					<div class="container-login100-form-btn login-box">
						<button class="signinl00-form-btn form-btn" id="btn_signin" type="button">
							<img src="/resources/images/logo_ms.png" style="width:20px; margin-right:14px;"> Sign in with Microsoft
						</button>
					</div>
					<div class="mobile_hidden text-center" style="text-align: left!important; bottom: 100px; position: fixed;">
					</div> 
					<div class="mobile_hidden p-b-20 lh-2-9" style="bottom: 0; position:fixed; min-top:600;">
						<span class="txt2">©2022 KWANGJIN. ALL RIGHT RESERVED.</span><!--<br>
						<a style="color:#dddddd!important; width:120px; display: inline-block !important; background: #6C747F; border-radius: 4px; text-align:center;" href="http://www.dbvalley.com/?page_id=4929" target="_black" class="fs-12 m-t-5">개인정보처리방침</a>-->
					</div> 
				</form>

				<div class="login100-more">
					<div class="loginTxt">
						<span>The world best<br>open/closing system provider</span>
						<br><br>
						세계 최고의 자동차 메이커들이 최고의 도어시스템을 구현 할 수 있도록<br>
						광진은 최고의 품질과 기술력으로 만전을 기할 것 입니다.
					</div>
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
  <script>
    function submitData(){
    	if(!loginFlag){
    		$(".validate-form").ajaxSubmit({
    			url : "checkLogin",
    			type:"post",
            dataType : "json",
            success:function(data){
            if(data.result == "Y"){ 
              setCookie("accid", $("#accid").val(), 30);
              setCookie("ckb1",$("#ckb1").val());
              if($(''input:checkbox[id="ckb1"]'').is(":checked")){
                setCookie("isSave", "Y", 30);	
              }else{
                setCookie("isSave", "N", 30);
              }
              location.replace("secur_confirm");						
            }else{
              if(data.cause == "99"){
                alert(data.message);
                $("#passwd").val("");
                $("#passwd").val("").focus();
              }else{
                alert(data.message);
              }
            }
          },
          beforeSend:function(){
            flag = true;
            $(".wrap-loading").removeClass("display-none");
          },
          complete:function(){
            $(".wrap-loading").addClass("display-none");
            flag = false;
          },
          error:function(e){
            alert(e.message);
          }
    		});	
    	}    	
    }
  </script>
</body>
</html>
');
EXCEPTION
  when others then 
    show_err('LOGIN');
END LOGIN;

/
