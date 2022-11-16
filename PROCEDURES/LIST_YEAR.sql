--------------------------------------------------------
--  DDL for Procedure LIST_YEAR
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PREMIER"."LIST_YEAR" ( p_yy in varchar2 )
  IS
    v_year varchar2(4);
    v_selected varchar2(20);
  BEGIN
    for i in -5..5 loop
      v_year := to_char(add_months(sysdate,i*12),'yyyy');

      if nvl(p_yy,to_char(sysdate,'yyyy')) = v_year then v_selected := '" selected>'; else v_selected := '">'; end if;
      htp.p('<option value="'||v_year||v_selected||v_year||' '||get_fn('년')||'</option>');
    end loop;
  END list_year;

/
