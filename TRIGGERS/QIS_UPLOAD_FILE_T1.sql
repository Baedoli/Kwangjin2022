--------------------------------------------------------
--  DDL for Trigger QIS_UPLOAD_FILE_T1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "PREMIER"."QIS_UPLOAD_FILE_T1" 
BEFORE INSERT ON PREMIER.QIS_UPLOAD_FILE
FOR EACH ROW
begin
  :NEW.FILE_NAME := TRIM(UPPER(SUBSTR(:NEW.NAME, INSTR(:NEW.NAME,'/',-1)+1)));
end;
/
ALTER TRIGGER "PREMIER"."QIS_UPLOAD_FILE_T1" ENABLE;
