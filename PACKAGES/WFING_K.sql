--------------------------------------------------------
--  DDL for Package WFING_K
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "PREMIER"."WFING_K" 
is
  PROCEDURE list
  (
    p_companycd in varchar2 default common.get_cookie('SYSCOMP')
  );
 
  PROCEDURE query_a
  (
    p_companycd in varchar2 default null
  );
  
  PROCEDURE query_a_data
  (
    p_companycd in varchar2 default null
  );
  
  PROCEDURE crrec
  (
    p_companycd in varchar2 default null
  );
  
  PROCEDURE process
  (
    p_companycd in varchar2 default null,
    p_dml_gubun in varchar2 default null
  );
 
  v_pkg varchar2(100 ) := 'wfing_k';
  v_linkid varchar2(200);
  
  v_number number := 0;
  
  v_comp varchar2(2) := common.get_cookie('SYSCOMP');
  v_lang varchar2(2) := common.get_cookie('SYSLANG');
  v_id varchar2(20) := common.get_cookie('SYSID');
  v_type varchar2(2) := common.get_cookie('SYSTYPE');
 
end wfing_k;

/
