--------------------------------------------------------
--  DDL for Package COMC0043
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "PREMIER"."COMC0043" 
is
    procedure control;   
    
    procedure form_data ( 
      p_sysroot in varchar2 default null
    ); 
    
    procedure query (
      p_sysroot   in varchar2 default null,
      p_id       in number default null,
      p_uid      in number default null
    );
    
    procedure list_menu (
      p_obj in varchar2 default null
    );
    
    procedure insert_row
    ( p_rowid in varchar2 default null );
    
    procedure delete_row
    ( p_rowid in varchar2 default null );

    procedure list_menu2 (
      p_obj in varchar2 default null
    );
    
    
    v_link1 varchar2(4000);
    v_link2 varchar2(4000);
    v_link3 varchar2(4000);
    v_link4 varchar2(4000);
      
    err_num number;
    err_msg varchar2(1000);
      
    v_file_icon varchar2(1000);
      
    v_session_id varchar2(30) := userenv('SESSIONID');
    v_sysdate varchar2(14) := to_char(sysdate, 'yyyymmddhh24miss');
      
    v_syscomp varchar2(2) := common.get_cookie('syscomp');
    v_systype varchar2(1) := common.get_cookie('systype');
    v_sysid varchar2(50) := common.get_cookie('sysid');
    v_syslang varchar2(2) := common.get_cookie('syslang');

    v_teamcd c_0010.teamcd%type := get_teamcd (v_syscomp, v_systype, v_sysid);
    v_pkg varchar2(30) := 'comc0043';

end comc0043;

/
