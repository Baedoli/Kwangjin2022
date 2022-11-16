--------------------------------------------------------
--  DDL for Function CH_XML_DATA
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "PREMIER"."CH_XML_DATA" 
( P_TAG_NAME IN VARCHAR2 )
RETURN VARCHAR2
IS
v_tag_name varchar2(2048) := null;
BEGIN

  v_tag_name := replace(replace(replace(replace(replace(replace(p_tag_name,'⇒',''),'&','&amp;'),'<','&lt;'),'>','&gt;'),'''','&apos;'),'"','&quot;');

  return v_tag_name;

END;

/
