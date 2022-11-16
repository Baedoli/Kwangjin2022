--------------------------------------------------------
--  DDL for Function GET_DOC_STATUS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "PREMIER"."GET_DOC_STATUS" 
(
  p_doc_id in number,
  p_flag in varchar2
)
RETURN VARCHAR2
AS
  cursor cur is
    select *
    from wf_docs
    where doc_id = p_doc_id
    ;
    
  rec wf_docs%rowtype;
  v_status_a varchar2(100); --결재대기
  v_status_b varchar2(100); --결재진행
  v_status_c varchar2(100); --결재완료
    
BEGIN

  open cur;
  fetch cur into rec;
  close cur;
  
  if rec.status = 'SAVED' then 
    v_status_a := 'aprvAct txtBold';
    v_status_b := 'aprvDeact';
    v_status_c := 'aprvDeact';
  elsif rec.status = 'ING' then 
    v_status_a := 'aprvAct';
    v_status_b := 'aprvAct txtBold';
    v_status_c := 'aprvDeact';
  elsif rec.status = 'REJECT' then 
    v_status_a := 'aprvAct';
    v_status_b := 'aprvStop txtBold';
    v_status_c := 'aprvDeact';
  elsif rec.status = 'FINISH' then 
    v_status_a := 'aprvAct';
    v_status_b := 'aprvAct';
    v_status_c := 'aprvAct txtBold';
  end if;
  
  if p_flag = 'A' then
    return ( v_status_a );
  elsif p_flag = 'B' then
    return ( v_status_b );
  elsif p_flag = 'C' then
    return ( v_status_c );
  end if;

EXCEPTION
  when others then 
    show_err('GET_DOC_STATUS');
END GET_DOC_STATUS;

/
