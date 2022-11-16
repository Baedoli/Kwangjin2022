--------------------------------------------------------
--  DDL for Function VAULT_DOWNLOAD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "PREMIER"."VAULT_DOWNLOAD" 
(
  P_LINKTYPECD IN VARCHAR2,
  P_LINKID IN VARCHAR2
)
RETURN VARCHAR2
AS

  cursor cur is
    select filepath
    from sys_file_upload
    where 1=1
    and   linktypecd = p_linktypecd
    and   linkid = p_linkid
    and   rownum = 1
    ;
    
  v_file varchar2(4000);

BEGIN

  open cur;
  fetch cur into v_file;
  if cur%notfound then v_file := ''; end if;
  close cur;
  
  
  return ( v_file );
  
EXCEPTION
  when others then 
    show_err('VAULT_DOWNLOAD');
END VAULT_DOWNLOAD;

/
