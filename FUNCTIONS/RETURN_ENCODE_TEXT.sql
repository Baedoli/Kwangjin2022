--------------------------------------------------------
--  DDL for Function RETURN_ENCODE_TEXT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "PREMIER"."RETURN_ENCODE_TEXT" (p_text in varchar2)
RETURN VARCHAR2
IS
    v_text  varchar2(4000);
BEGIN

  v_text := p_text;
  v_text := replace(v_text, ' ','%20');

  return v_text;
END return_encode_text;

/
