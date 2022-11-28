--------------------------------------------------------
--  DDL for Procedure LOGOUT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PREMIER"."LOGOUT" 
IS
BEGIN

  -- commit work test bsh ...
  -- ....
  -- commit work test ljs..

  owa_util.mime_header('text/html', false);
  owa_cookie.remove('SYSCOMP', common.get_cookie('SYSCOMP'));
  owa_cookie.remove('SYSID', common.get_cookie('SYSID'));
  owa_cookie.remove('SYSLANG', common.get_cookie('SYSLANG'));
  owa_cookie.remove('SYSTYPE', common.get_cookie('SYSTYPE'));
  owa_cookie.remove('CCODE', common.get_cookie('CCODE'));
  owa_cookie.remove('TEAMCD', common.get_cookie('TEAMCD'));
  owa_cookie.remove('SYSCODE', common.get_cookie('SYSCODE'));
  owa_cookie.remove('SYSTITLE', common.get_cookie('SYSTITLE'));
  owa_cookie.remove('LOGINID', common.get_cookie('LOGINID'));
  owa_cookie.remove('SYSADM', common.get_cookie('SYSADM'));    

  owa_util.redirect_url('LOGIN');  
  owa_util.http_header_close; 

EXCEPTION
  when others then 
    show_err('LOGOUT');
END LOGOUT;

/
