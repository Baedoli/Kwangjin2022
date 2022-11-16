--------------------------------------------------------
--  DDL for Package SAMPLE_CHART
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "PREMIER"."SAMPLE_CHART" 
is
  PROCEDURE control
  (
    p_companycd in varchar2 default common.get_cookie('SYSCOMP'),
    p_yy in varchar2 default to_char(sysdate,'yyyy')
  );
 
  v_pkg varchar2(100 ) := 'sample_chart';
  
  v_number number := 0;
  
  v_comp varchar2(2) := common.get_cookie('SYSCOMP');
  v_lang varchar2(2) := common.get_cookie('SYSLANG');
  v_id varchar2(20) := common.get_cookie('SYSID');
  v_type varchar2(2) := common.get_cookie('SYSTYPE');
 
end sample_chart;

/
