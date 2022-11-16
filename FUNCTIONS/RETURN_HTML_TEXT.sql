--------------------------------------------------------
--  DDL for Function RETURN_HTML_TEXT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "PREMIER"."RETURN_HTML_TEXT" (p_text in varchar2)
RETURN VARCHAR2
IS
    v_text  varchar2(4000);
BEGIN
  /*
  v_text:='';
  if p_text='"' then
    v_text:= '&quot;';
  end if; 
  return v_text;
  */ 
  --return replace(replace(replace(replace(p_text, '"', '&quot;'), chr(10), ''), chr(13), ''), chr(13)||chr(10), '');
  
  v_text := p_text;
  v_text := replace(v_text, '&', '&amp;');
  v_text := replace(v_text, chr(13), '');
  v_text := replace(v_text, chr(10), '');
  v_text := replace(v_text, chr(11), '');
  v_text := replace(v_text, chr(13)||chr(10), '');
--  v_text := replace(v_text, '"', '&quot;');
  v_text := replace(v_text, '"', '`');    
  -- v_text := replace(v_text, '"', '*');
--  v_text := replace(v_text, '''', '&acute;');
  v_text := replace(v_text, '''', '`');
  v_text := replace(v_text, '<', '&lt;');
  v_text := replace(v_text, '>', '&gt;');
  v_text := replace(v_text, ',', '&#44;');
  v_text := replace(v_text, '\', '');
  v_text := replace(v_text, '*', '&#42;');

  
  return v_text;
END return_html_text;

/
