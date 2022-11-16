--------------------------------------------------------
--  DDL for Procedure SHOW_ERR
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PREMIER"."SHOW_ERR" 
(
	p_message in varchar2 default null
)
is
begin
	htp.p('
		<script type="text/javascript">
		alert("'||p_message||' - '||substr(replace(replace(sqlerrm, chr(10), ''), '"', ''''), 1, 3000)||'");
		</script>
	');
end show_err;

/
