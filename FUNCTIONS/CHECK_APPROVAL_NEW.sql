--------------------------------------------------------
--  DDL for Function CHECK_APPROVAL_NEW
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "PREMIER"."CHECK_APPROVAL_NEW" ( P_DOC_ID IN NUMBER, P_PRIOR_ID IN NUMBER )
RETURN VARCHAR2
IS

cursor fnd_check is
select 'Y'
from   wf_doc_roles
where  doc_id = P_DOC_ID
and    prior_id = ( select max(prior_id) from wf_doc_roles where doc_id = P_DOC_ID and type_id = 0 and prior_id < P_PRIOR_ID )
and    status = 'COMPLETE';

cursor fnd_count is
select 'Y'
from   wf_doc_roles
where  doc_id = p_doc_id
and    type_id = 0
and    prior_id < p_prior_id
and    status != 'COMPLETE'
and    rownum = 1;

v_row_check varchar2(1) := 'N';

v_check varchar2(1) := 'N';
BEGIN

  open fnd_count;
  fetch fnd_count into v_row_check;
  if fnd_count%notfound then v_row_check := 'N'; end if;
  close fnd_count;
  
  if v_row_check = 'Y' then 
     open fnd_check;
     fetch fnd_check into v_check;
     if fnd_check%notfound then v_check := 'N'; end if;
     close fnd_check;
  else
     v_check := 'Y';
  end if;
  
  return ( v_check );
  
END CHECK_APPROVAL_NEW;

/
