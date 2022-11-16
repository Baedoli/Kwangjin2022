--------------------------------------------------------
--  DDL for Package COMCURRENCY
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "PREMIER"."COMCURRENCY" 
is
  PROCEDURE control
  (
    p_ymd in varchar2 default to_char(sysdate,'yyyy') 
  );
 
  PROCEDURE query_a
  (
    p_ymd in varchar2 default null
  );
  
  PROCEDURE query_a_data
  (
    p_ymd in varchar2 default null
  );
  
  PROCEDURE crrec
  (
    p_ymd in varchar2 default null,
    p_coincd in varchar2 default null
  );
  
  PROCEDURE process
  (
    p_ymd in varchar2 default null,
    p_dml_gubun in varchar2 default null,
    p_coincd in varchar2 default null,
    p_rate in varchar2 default null
  );
 
  v_pkg varchar2(100 ) := 'COMCURRENCY';
  v_linkid varchar2(200);
  
  v_number number := 0;
  
  v_comp varchar2(2) := common.get_cookie('SYSCOMP');
  v_lang varchar2(2) := common.get_cookie('SYSLANG');
  v_id varchar2(20) := common.get_cookie('SYSID');
  v_type varchar2(2) := common.get_cookie('SYSTYPE');
 
end COMCURRENCY;

/
