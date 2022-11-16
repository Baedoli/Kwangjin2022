--------------------------------------------------------
--  DDL for Package KSCM1104_A
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "PREMIER"."KSCM1104_A" 
is
  PROCEDURE control
  (
    p_companycd in varchar2 default common.get_cookie('SYSCOMP'),
    p_ymd in  varchar2 default to_char(sysdate,'yyyymmdd')
  );
 
  PROCEDURE query_a
  (
    p_companycd in varchar2 default null,
    p_ymd in  varchar2 default null
  );
  
  PROCEDURE query_a_data
  (
    p_companycd in varchar2 default null,
    p_ymd in  varchar2 default null
  );
  
  PROCEDURE query_b
  (
    p_companycd in varchar2 default null,
    p_ymd in  varchar2 default null
  );
  
  PROCEDURE query_b_data
  (
    p_companycd in varchar2 default null,
    p_ymd in  varchar2 default null
  );
 
  v_pkg varchar2(100 ) := 'kscm1104_A';
  v_linkid varchar2(200);
  
  v_number number := 0;
  
  v_comp varchar2(2) := common.get_cookie('SYSCOMP');
  v_lang varchar2(2) := common.get_cookie('SYSLANG');
  v_id varchar2(20) := common.get_cookie('SYSID');
  v_type varchar2(2) := common.get_cookie('SYSTYPE');
 
end kscm1104_A;

/
