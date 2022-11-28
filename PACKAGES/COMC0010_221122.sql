--------------------------------------------------------
--  DDL for Package COMC0010_221122
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "PREMIER"."COMC0010_221122" 
is
  PROCEDURE control
  (
    p_companycd in varchar2 default common.get_cookie('SYSCOMP'),
    p_systemcd in varchar2 default null,
    p_gubun in varchar2 default null,
    p_useyn in varchar2 default null,
    p_xusernm in varchar2 default null
  );
 
  PROCEDURE query_a
  (
    p_companycd in varchar2 default null,
    p_systemcd in varchar2 default null,
    p_gubun in varchar2 default null,
    p_useyn in varchar2 default null,
    p_xusernm in varchar2 default null
  );
  
  PROCEDURE query_a_data
  (
    p_companycd in varchar2 default null,
    p_systemcd in varchar2 default null,
    p_gubun in varchar2 default null,
    p_useyn in varchar2 default null,
    p_teamcd in varchar2 default null,   
    p_xusernm in varchar2 default null
  );
  
  PROCEDURE crrec
  (
    p_companycd in varchar2 default null,   
    p_gubun in varchar2 default null,   
    p_xuser in varchar2 default null,   
    p_f  in varchar2 default null   
  );
  
  PROCEDURE crrec2
  (
    p_companycd in varchar2 default null,
    p_systemcd in varchar2 default null,
    p_gubun in varchar2 default null,
    p_teamcd in varchar2 default null  
  );
 
  PROCEDURE process
  (
    p_companycd in varchar2 default null,
    p_teamnm in varchar2 default null,
    p_xusernm in varchar2 default null,
    p_xuser in varchar2 default null,
    p_gubun in varchar2 default null,
    p_useyn in varchar2 default null,
    p_dml_gubun in varchar2 default null,
    p_pass in varchar2 default null,
    p_mobile in varchar2 default null,
    p_jikup in varchar2 default null,
    p_email in varchar2 default null,
    p_teamcd in varchar2 default null
  );
 
  PROCEDURE process_crrec2
  (
    p_companycd in owa_util.ident_arr,   
    p_gubun     in owa_util.ident_arr,   
    p_xuser     in owa_util.ident_arr,   
    p_grade     in owa_util.ident_arr,  
    p_value     in owa_util.ident_arr, 
    p_teamcd    in varchar2 default null, 
    p_dml_gubun in varchar2 default null,
    p_systemcd  in varchar2 default null
  );  
  
  v_pkg varchar2(100 ) := 'COMC0010_221122';
  v_linkid varchar2(200);
  
  v_number number := 0;
  
  v_comp varchar2(2) := common.get_cookie('SYSCOMP');
  v_lang varchar2(2) := common.get_cookie('SYSLANG');
  v_id varchar2(20) := common.get_cookie('SYSID');
  v_type varchar2(2) := common.get_cookie('SYSTYPE');
 
end COMC0010_221122;

/
