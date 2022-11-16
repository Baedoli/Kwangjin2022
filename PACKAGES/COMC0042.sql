--------------------------------------------------------
--  DDL for Package COMC0042
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "PREMIER"."COMC0042" 
is
  PROCEDURE control
  (
    p_sysroot in varchar2 default '996',
    p_id_ in varchar2 default null,
    p_uid_ in varchar2 default null
  );
 
  PROCEDURE query_a
  (
    p_sysroot in varchar2 default null
  );
  
  PROCEDURE crrec
  (
    p_sysroot in varchar2 default null,
    p_id_ in varchar2 default null,
    p_uid_ in varchar2 default null
  );

  PROCEDURE process
  (
    p_sysroot in varchar2 default null,
    p_id in number default null,
    p_uid in number default null,
    p_url in varchar2 default null,
    p_target in varchar2 default null,
    p_pgm_order in number default null,
    p_useyn in varchar2 default null,
    p_dml_gubun in varchar2 default null
  );

  v_pkg varchar2(100 ) := 'COMC0042';
  v_linkid varchar2(200);
  
  v_number number := 0;
  
  v_comp varchar2(2) := common.get_cookie('SYSCOMP');
  v_lang varchar2(2) := common.get_cookie('SYSLANG');
  v_id varchar2(20) := common.get_cookie('SYSID');
  v_type varchar2(2) := common.get_cookie('SYSTYPE');
 
end COMC0042;

/
