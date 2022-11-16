--------------------------------------------------------
--  DDL for View V_COMPLET_DOC
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "PREMIER"."V_COMPLET_DOC" ("DOC_ID", "COM_ID", "ORG_ID", "FLAG") AS 
  SELECT doc_id,
       NULL com_id,
       NULL org_id,
       DECODE (status,  'FINISH', '1',  'REJECT', '2') flag
FROM wf_docs
WHERE status IN ('FINISH', 'REJECT')
;
