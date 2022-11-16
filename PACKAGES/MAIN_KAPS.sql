--------------------------------------------------------
--  DDL for Package MAIN_KAPS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "PREMIER"."MAIN_KAPS" 
IS
  PROCEDURE control  
  ( 
    p_sysroot in varchar2 default '35',
    p_companycd in varchar2 default common.get_cookie('SYSCOMP')
  );  
  
  PROCEDURE get_side_menu 
  (
    p_sysroot in varchar2 default null
  );
  
  PROCEDURE get_bookmark_menu 
  (
    p_sysroot in varchar2 default null
  );
  
  PROCEDURE tabbar;

  PROCEDURE main_body
  (
    p_companycd in varchar2 default common.get_cookie('SYSCOMP')
  );
  
  PROCEDURE change_lang 
  ( 
    p_lang in varchar2 default null
  );

  v_syscomp c_0010.companycd%type := common.get_cookie('SYSCOMP');
  v_systype c_0010.gubun%type := common.get_cookie('SYSTYPE');
  v_sysid c_0010.xuser%type := common.get_cookie('SYSID');
  v_teamcd  c_0010.teamcd%type := get_teamcd(v_syscomp, v_systype, v_sysid);
  v_syslang c_0051.lang%type := common.get_cookie('SYSLANG');
  
  v_role varchar2(100) := get_role(v_syscomp, v_systype, v_sysid, 'QMS' );
  v_pkg varchar2(100) := 'main_kaps';
  
END main_kaps;

/
