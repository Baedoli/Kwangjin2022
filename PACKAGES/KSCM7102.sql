--------------------------------------------------------
--  DDL for Package KSCM7102
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "PREMIER"."KSCM7102" 
is
  PROCEDURE control
  (
    p_companycd in varchar2 default common.get_cookie('SYSCOMP'),
    p_cli_code in varchar2 default common.get_cookie('CCODE')
  );
 
  PROCEDURE query_a
  (
    p_companycd in varchar2 default null,
    p_cli_code in varchar2 default null
  );
  
  PROCEDURE query_a_data
  (
    p_companycd in varchar2 default null,
    p_cli_code in varchar2 default null
  );
  
  PROCEDURE crrec
  (
    p_companycd in varchar2 default null,
    p_cli_code in varchar2 default null,
    p_sno in varchar2 default null
  );
  
  PROCEDURE process
  (
    p_companycd in varchar2 default null,
    p_cli_code in varchar2 default null,
    p_sno in varchar2 default null,
    p_dml_gubun in varchar2 default null,
    p_vendcd in varchar2 default null, 
    p_deptnm in varchar2 default null, 
    p_empnm in varchar2 default null, 
    p_email in varchar2 default null, 
    p_telno in varchar2 default null, 
    p_bpno in varchar2 default null,
    p_memo in varchar2 default null
  );
 
  v_pkg varchar2(100 ) := 'kscm7102';
  v_linkid varchar2(200);
  
  v_number number := 0;
  
  v_comp varchar2(2) := common.get_cookie('SYSCOMP');
  v_lang varchar2(2) := common.get_cookie('SYSLANG');
  v_id varchar2(20) := common.get_cookie('SYSID');
  v_type varchar2(2) := common.get_cookie('SYSTYPE');
 
end kscm7102;

/
