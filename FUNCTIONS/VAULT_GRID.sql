--------------------------------------------------------
--  DDL for Function VAULT_GRID
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "PREMIER"."VAULT_GRID" 
(
  P_LINKTYPECD IN VARCHAR2,
  P_LINKID IN VARCHAR2
)
RETURN VARCHAR2
AS
  cursor cur is
    select *
    from sys_file_upload
    where 1=1
    and   linktypecd = p_linktypecd
    and   linkid = p_linkid
    order by fileseq
    ;
    
  v_file varchar2(32767);
    
BEGIN

  v_file := ''; 
  for rec in cur loop
  
    if rec.filename is not null then
      v_file := v_file ||'<a href='||return_encode_text(rec.filepath)||' target=''_blank''><img border=''0'' src=''/image/button/file.gif'' alt='''||rec.filename||'''></a>';
    else
      v_file := '';
    end if;
    
  end loop;
  
  return ( v_file );

EXCEPTION
when others then 
  show_err('VAULT_GRID');
END VAULT_GRID;

/
