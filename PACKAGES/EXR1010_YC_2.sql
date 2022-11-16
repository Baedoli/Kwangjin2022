--------------------------------------------------------
--  DDL for Package EXR1010_YC_2
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "PREMIER"."EXR1010_YC_2" 
is
  PROCEDURE control
  (
    p_date in varchar2 default to_char(sysdate,'yyyymmdd')
  );
 
  PROCEDURE query_a
  (
    p_date in varchar2 default null
  );
  
  PROCEDURE query_a_data
  (
    p_date in varchar2 default null,
    p_tocoincd in varchar2 default null
  );
  
  PROCEDURE query_a_data_2
  (
    p_date in varchar2 default null,
    p_tocoincd in varchar2 default null
  );
  
  PROCEDURE process
  (
    p_companycd in varchar2 default null,
    p_dml_gubun in varchar2 default null
  );
 
  v_pkg varchar2(100 ) := 'exr1010_yc_2';
  v_linkid varchar2(200);
  
  v_number number := 0;
  
  v_comp varchar2(2) := common.get_cookie('SYSCOMP');
  v_lang varchar2(2) := common.get_cookie('SYSLANG');
  v_id varchar2(20) := common.get_cookie('SYSID');
  v_type varchar2(2) := common.get_cookie('SYSTYPE');
 
end exr1010_yc_2;

/
