--------------------------------------------------------
--  DDL for Package COMMESSAGE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "PREMIER"."COMMESSAGE" 
is
  PROCEDURE control
  (
    p_systemcd in varchar2 default null,
    p_message_text in varchar2 default null
  );
 
  PROCEDURE query_a
  (
    p_systemcd in varchar2 default null,
    p_message_text in varchar2 default null
  );
  
  PROCEDURE query_a_data
  (
    p_systemcd in varchar2 default null,
    p_message_text in varchar2 default null
  );
  
  PROCEDURE crrec
  (
    p_systemcd in varchar2 default null,
    p_catalogcd in varchar2 default null,
    p_dml_gubun in varchar2 default null
  );
  
  PROCEDURE process
  (
    p_systemcd in varchar2 default null,
    p_catalogcd in varchar2 default null,
    p_dml_gubun in varchar2 default null,
    p_ko_message in varchar2 default null,
    p_en_message in varchar2 default null
  );
 
  v_pkg varchar2(100 ) := 'COMMESSAGE';
  v_linkid varchar2(200);
  
  v_number number := 0;
  
  v_comp varchar2(2) := common.get_cookie('SYSCOMP');
  v_lang varchar2(2) := common.get_cookie('SYSLANG');
  v_id varchar2(20) := common.get_cookie('SYSID');
  v_type varchar2(2) := common.get_cookie('SYSTYPE');
 
end COMMESSAGE;

/
