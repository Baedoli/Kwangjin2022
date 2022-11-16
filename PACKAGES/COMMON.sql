--------------------------------------------------------
--  DDL for Package COMMON
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "PREMIER"."COMMON" 
IS

  FUNCTION  get_cookie(p_cookie_name in varchar2 default null) return varchar2;
  PROCEDURE set_cookie(p_cookie_name in VARCHAR2,
                       p_name        in VARCHAR2);
                       
  PROCEDURE list_qc_company_login
  (
    p_companycd in varchar2,
    p_lang in varchar2
  );
  
  PROCEDURE list_company
  (
    p_companycd in varchar2, 
    p_lang      in varchar2
  );  

  PROCEDURE list_catalog_name
  (
    p_systemcd in varchar2, 
    p_catalogcd in varchar2,
    p_listvalue in varchar2,
    p_lang in varchar2
  );
  
  procedure list_catalog (
    p_systemcd in varchar2, 
    p_catalogcd in varchar2,
    p_listvalue in varchar2,
    p_element_tag in varchar2,
    p_element_type in varchar2,
    p_element_name in varchar2,
    p_all_type in varchar2,
    p_attr in varchar2 default null,
    p_divider in varchar2 default null,
    p_class in varchar2 default null,
    p_check_all in varchar2 default null,
    p_lang in varchar2 default common.get_cookie('SYSLANG')
  );
  
  PROCEDURE list_systemcd (
    p_systemcd   in varchar2,
    p_all_type   in varchar2
  );

  PROCEDURE imageView
  (
    p_linktypecd in varchar2 default null,
    p_linkid in varchar2 default null
  );
  
  PROCEDURE save_file_info
  (
    p_attachList in owa_util.vc_arr,
    p_linkid in varchar2 default null
  );
  
  PROCEDURE remove_file_info
  (
    p_linktypecd in varchar2 default null,
    p_linkid in varchar2 default null
  );

  skin varchar2(100) := 'dhx_web';
  title varchar(100) := 'Kwangjin Advanced e-Business Portal System';
END COMMON;

/
