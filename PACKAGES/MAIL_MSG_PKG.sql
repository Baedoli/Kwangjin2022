--------------------------------------------------------
--  DDL for Package MAIL_MSG_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "PREMIER"."MAIL_MSG_PKG" 
is
  PROCEDURE control
  (
    p_useyn in varchar2 default null
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
    p_msg_code in varchar2 default null
  );
  
  PROCEDURE process
  (
    p_msg_code in varchar2 default null,
    p_msg_name in varchar2 default null,
    p_msg_ko in varchar2 default null,
    p_msg_en in varchar2 default null,
    p_msg_ch in varchar2 default null,
    p_msg_sp in varchar2 default null,
    p_useyn in varchar2 default null,
    p_dml_gubun in varchar2 default null
  );
 
  v_pkg varchar2(100 ) := 'mail_msg_pkg';
  v_linkid varchar2(200);
  
  v_number number := 0;
  
  v_comp varchar2(2) := common.get_cookie('SYSCOMP');
  v_lang varchar2(2) := common.get_cookie('SYSLANG');
  v_id varchar2(20) := common.get_cookie('SYSID');
  v_type varchar2(2) := common.get_cookie('SYSTYPE');
 
end mail_msg_pkg;

/
