--------------------------------------------------------
--  DDL for Function GET_FN
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "PREMIER"."GET_FN" ( p_kname in varchar2, p_option number default 1, p_lang in varchar2 default common.get_cookie('SYSLANG'))
return varchar2 
is
  cursor fnd_c_2000 is
    select 	replace(replace(trim(decode(p_option, 1, fname1, 2, fname2, 3, fname3, 4, fname4, 5, fname5)), chr(10),''), chr(13), '')
    from 		c_2000
    where 	kname = replace(p_kname, ' ')
    and 		lang  = p_lang;
  
  v_fname c_2000.fname1%type;
  
begin

  open fnd_c_2000;
  fetch fnd_c_2000 into v_fname;
  if fnd_c_2000%notfound then 
  	v_fname := p_kname; 
  end if;
  close fnd_c_2000;

  return v_fname;

  --return p_kname;
end get_fn;

/
