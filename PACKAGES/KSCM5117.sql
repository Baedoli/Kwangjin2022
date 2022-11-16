--------------------------------------------------------
--  DDL for Package KSCM5117
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "PREMIER"."KSCM5117" 
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
    p_vendcd  in varchar2 default null,
    p_groupcd  in varchar2 default null
  );
  
  PROCEDURE process
  (
    p_companycd in varchar2 default null,
    p_dml_gubun in varchar2 default null,
    p_vendcd  in varchar2 default null,
    p_groupcd in varchar2 default null,
    p_descr in varchar2 default null,
    p_list_order in varchar2 default null
  );
 
  v_pkg varchar2(100 ) := 'kscm5117';
  v_linkid varchar2(200);
  
  v_number number := 0;
  
  v_comp varchar2(2) := common.get_cookie('SYSCOMP');
  v_lang varchar2(2) := common.get_cookie('SYSLANG');
  v_id varchar2(20) := common.get_cookie('SYSID');
  v_type varchar2(2) := common.get_cookie('SYSTYPE');
 
end kscm5117;

/
