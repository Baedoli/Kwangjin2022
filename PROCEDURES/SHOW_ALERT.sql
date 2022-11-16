--------------------------------------------------------
--  DDL for Procedure SHOW_ALERT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PREMIER"."SHOW_ALERT" (p_alert in varchar2 default null)
IS
BEGIN
    htp.p('
        <script>
        alert("'||p_alert||'");
        </script>
    ');

END;

/
