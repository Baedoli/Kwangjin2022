--------------------------------------------------------
--  DDL for Package COMC0010_YC
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "PREMIER"."COMC0010_YC" 
is
  PROCEDURE control
  ;
 
  PROCEDURE query_a
  ;
  
  PROCEDURE query_a_data
  ;
  
  PROCEDURE crrec
  (
    p_xuser in varchar2 default null,
    p_xusernm in varchar2 default null,
    p_gubun in varchar2 default null,
    p_lang in varchar2 default null,
    p_email in varchar2 default null,
    p_mail_id in varchar2 default null,
    p_mobile in varchar2 default null
  );
  
  PROCEDURE process
  (
    p_xuser in varchar2 default null,
    p_xusernm in varchar2 default null,
    p_gubun in varchar2 default null,
    p_lang in varchar2 default null,
    p_email in varchar2 default null,
    p_mail_id in varchar2 default null,
    p_mobile in varchar2 default null,
    p_dml_gubun in varchar2 default null
  );
  
  PROCEDURE crrec_detail
  (
    p_companycd in varchar2 default null,
    p_xuser in varchar2 default null,
    p_xusernm in varchar2 default null,
    p_gubun in varchar2 default null,
    p_lang in varchar2 default null,
    p_email in varchar2 default null,
    p_mail_id in varchar2 default null,
    p_mobile in varchar2 default null,
    p_teamcd in varchar2 default null,
    p_default_yn in varchar2 default null,
    p_useyn in varchar2 default null,
    p_jikup in varchar2 default null,
    p_position in varchar2 default null,
    p_symd in varchar2 default null,
    p_eymd in varchar2 default null
  );
  
  PROCEDURE process_detail
  (
    p_companycd in varchar2 default null,
    p_xuser in varchar2 default null,
    p_xusernm in varchar2 default null,
    p_gubun in varchar2 default null,
    p_seq in varchar2 default null,
    p_lang in varchar2 default null,
    p_email in varchar2 default null,
    p_mail_id in varchar2 default null,
    p_mobile in varchar2 default null,
    p_teamcd in varchar2 default null,
    p_default_yn in varchar2 default null,
    p_useyn in varchar2 default null,
    p_jikup in varchar2 default null,
    p_position in varchar2 default null,
    p_symd in varchar2 default null,
    p_eymd in varchar2 default null,
    p_dml_gubun in varchar2 default null
  );
 
  v_pkg varchar2(100 ) := 'COMC0010_yc';
  v_linkid varchar2(200);
  
  v_number number := 0;
  
  v_comp varchar2(2) := common.get_cookie('SYSCOMP');
  v_lang varchar2(2) := common.get_cookie('SYSLANG');
  v_id varchar2(20) := common.get_cookie('SYSID');
  v_type varchar2(2) := common.get_cookie('SYSTYPE');
 
end COMC0010_yc;

/
