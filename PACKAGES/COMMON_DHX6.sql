--------------------------------------------------------
--  DDL for Package COMMON_DHX6
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "PREMIER"."COMMON_DHX6" 
IS 

procedure list_company (
    p_type in varchar2 default 'N',
    p_lang in varchar2 default common.get_cookie('SYSLANG')
);

procedure list_team (
    p_companycd in varchar2 default null,
    p_type in varchar2 default 'N' 
);

procedure list_kindcd(
    p_companycd in varchar2 default null,
    p_type in varchar2 default null
);
 
-- 카타로그 options
procedure list_catalog (
    p_systemcd in varchar2, 
    p_catalogcd in varchar2,
    p_type in varchar2 default 'N',
    p_lang in varchar2 default common.get_cookie('SYSLANG')
);
-- 카타로그 하위 
procedure list_catalog_select (
    p_systemcd in varchar2, 
    p_catalogcd in varchar2,
    p_type in varchar2 default 'N',
    p_value in varchar2
  );

-- 카타로그 radioGroup
procedure radio_catalog(
  p_systemcd in varchar2, 
  p_catalogcd in varchar2,
  p_align in varchar2,
  p_labelposition in varchar2,
  p_labelwidth in varchar2
);

-- fms 양식
procedure list_form_type 
(
  p_gbn in varchar2 default null
);
  
END;

/
