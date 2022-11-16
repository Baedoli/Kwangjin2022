--------------------------------------------------------
--  DDL for Package COMC0005
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "PREMIER"."COMC0005" 
is
  PROCEDURE control
  (
    p_useyn in varchar2 default 'Y'
  );
 
  PROCEDURE query_a
  (
    p_useyn in varchar2 default null
  );
  
  PROCEDURE query_a_data
  (
    p_useyn in varchar2 default null
  );
  
  PROCEDURE crrec
  (
    p_systemcd in varchar2 default null
  );
  
  PROCEDURE process
  (
    p_systemcd in varchar2 default null,
    p_dml_gubun in varchar2 default null,
    p_systemnm in varchar2 default null,
    p_useyn in varchar2 default null
  );
 
  v_pkg varchar2(100 ) := 'COMC0005';
  v_linkid varchar2(200);
  
  v_number number := 0;
  
  v_comp varchar2(2) := common.get_cookie('SYSCOMP');
  v_lang varchar2(2) := common.get_cookie('SYSLANG');
  v_id varchar2(20) := common.get_cookie('SYSID');
  v_type varchar2(2) := common.get_cookie('SYSTYPE');
 
end COMC0005;

/
