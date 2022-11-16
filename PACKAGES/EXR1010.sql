--------------------------------------------------------
--  DDL for Package EXR1010
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "PREMIER"."EXR1010" 
is
  PROCEDURE control
  (
    p_date in varchar2 default to_char(sysdate,'yyyymmdd')
  );
 
  PROCEDURE query_a
  (
    p_date in varchar2 default null
  );
  
  PROCEDURE query_b
  (
    p_date in varchar2 default null
  );
  
  PROCEDURE query_a_data
  (
    p_date in varchar2 default null,
    p_tocoincd in varchar2 default null
  );
  
  PROCEDURE query_b_data
  (
    p_date in varchar2 default null,
    p_tocoincd in varchar2 default null
  );
  
  procedure excel
  (
    p_date in varchar2 default null
  );
  
  PROCEDURE excel_crrec
  (
    p_date in varchar2 default null
  );
  
  PROCEDURE excel_process  
  (   
    p_date in varchar2 default null,  
    p_dml_gubun in varchar2 default null, 
    p_file_name in varchar2 default null
  );
  
  PROCEDURE excel_load
  (  
    p_date in varchar2 default null
  );
  
  procedure check_key 
  (
    p_date in varchar2 default null
  );
  
  v_pkg varchar2(100 ) := 'exr1010';
  v_linkid varchar2(200);
  
  v_number number := 0;
  
  v_comp varchar2(2) := common.get_cookie('SYSCOMP');
  v_lang varchar2(2) := common.get_cookie('SYSLANG');
  v_id varchar2(20) := common.get_cookie('SYSID');
  v_type varchar2(2) := common.get_cookie('SYSTYPE');
  v_full_file_name  sys_file_upload.fullfilename%type;  
  v_file_name       sys_file_upload.filename%type;  
  
end exr1010;

/
