--------------------------------------------------------
--  DDL for Trigger QIS_UPLOAD_FILE_T2
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "PREMIER"."QIS_UPLOAD_FILE_T2" 
before INSERT ON PREMIER.QIS_UPLOAD_FILE
FOR EACH ROW
begin
  DECLARE
    v_mime_type qis_upload_file.mime_type%type;
  BEGIN
    if lower(:new.name) like '%xls' or lower(:new.name) like '%xlsx' then
      v_mime_type := 'application/vnd.ms-excel';
    elsif lower(:new.name) like '%ppt' or lower(:new.name) like '%pptx' then
      v_mime_type := 'application/vnd.ms-powerpoint';
    end if;

    UPDATE QIS_UPLOAD_FILE
    SET mime_type = v_mime_type
    WHERE NAME = :NEW.name;
  END;

END;
/
ALTER TRIGGER "PREMIER"."QIS_UPLOAD_FILE_T2" ENABLE;
