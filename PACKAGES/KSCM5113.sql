--------------------------------------------------------
--  DDL for Package KSCM5113
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "PREMIER"."KSCM5113" 
is
  PROCEDURE control
  (
    p_companycd in varchar2 default common.get_cookie('SYSCOMP'),
    p_yy in  varchar2 default to_char(sysdate,'yyyymm'),
    p_mode in varchar2 default 'A'
  );
 
  PROCEDURE query_a
  (
    p_companycd in varchar2 default null,
    p_yy in  varchar2 default null,
    p_mode in varchar2 default null
  );
  
  PROCEDURE query_a_data
  (
    p_companycd in varchar2 default null,
    p_yy in  varchar2 default null,
    p_mode in varchar2 default null
  );
  
  v_pkg varchar2(100 ) := 'kscm5113';
  v_linkid varchar2(200);
  
  v_number number := 0;
  
  v_comp varchar2(2) := common.get_cookie('SYSCOMP');
  v_lang varchar2(2) := common.get_cookie('SYSLANG');
  v_id varchar2(20) := common.get_cookie('SYSID');
  v_type varchar2(2) := common.get_cookie('SYSTYPE');
 
end kscm5113;

/
