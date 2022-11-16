--------------------------------------------------------
--  DDL for Package SAMPLE_ATTACHFORM
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "PREMIER"."SAMPLE_ATTACHFORM" 
is
  PROCEDURE control
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
    p_companycd in varchar2 default null,
    p_register_no in varchar2 default null
  );
  
  PROCEDURE process
  (
    p_companycd in varchar2 default null,
    p_dml_gubun in varchar2 default null,
    p_register_no in varchar2 default null,
    p_attachList1 in owa_util.vc_arr,
    p_attachList3 in owa_util.vc_arr
  );
 
  v_pkg varchar2(100 ) := 'sample_attachForm';
  
  v_number number := 0;
  v_linkid varchar2(200);
  
  v_comp varchar2(2) := common.get_cookie('SYSCOMP');
  v_lang varchar2(2) := common.get_cookie('SYSLANG');
  v_id varchar2(20) := common.get_cookie('SYSID');
  v_type varchar2(2) := common.get_cookie('SYSTYPE');
 
end sample_attachForm;

/
