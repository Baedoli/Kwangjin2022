--------------------------------------------------------
--  DDL for Package KSCM4111
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "PREMIER"."KSCM4111" 
is
  PROCEDURE control
  (
    p_companycd in varchar2 default common.get_cookie('SYSCOMP'),
    p_symd in  varchar2 default to_char(sysdate,'yyyymmdd'),
    p_eymd in  varchar2 default to_char(sysdate,'yyyymmdd')
  );
 
  PROCEDURE query_a
  (
    p_companycd in varchar2 default null,
    p_symd in  varchar2 default null,
    p_eymd in  varchar2 default null
  );
  
  PROCEDURE query_a_data
  (
    p_companycd in varchar2 default null,
    p_symd in  varchar2 default null,
    p_eymd in  varchar2 default null
  );
  
  v_pkg varchar2(100 ) := 'KSCM4111';
  v_linkid varchar2(200);
  
  v_number number := 0;
  
  v_comp varchar2(2) := common.get_cookie('SYSCOMP');
  v_lang varchar2(2) := common.get_cookie('SYSLANG');
  v_id varchar2(20) := common.get_cookie('SYSID');
  v_type varchar2(2) := common.get_cookie('SYSTYPE');
 
end KSCM4111;

/
