--------------------------------------------------------
--  DDL for Trigger DT_QIS_UPLOAD_FILE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "PREMIER"."DT_QIS_UPLOAD_FILE" 
after UPDATE OR DELETE OR INSERT ON PREMIER.QIS_UPLOAD_FILE
FOR EACH ROW
DECLARE

  v_file_seq qis_upload_file_list.file_seq%type;
  v_new_file_name qis_upload_file_list.file_name%type;
  l_file      UTL_FILE.FILE_TYPE;
  l_blob      BLOB;
  l_file_name VARCHAR2(256);
  l_file_ext VARCHAR2(3);
  l_buffer    RAW(32767);
  l_amount    BINARY_INTEGER := 32767;
  l_pos       INTEGER := 1;
  l_blob      BLOB;
  l_blob_len  INTEGER;
--  
BEGIN
  null;
/*
  if inserting then
		select	qis_upload_file_seq.nextval into v_file_seq from dual;
    --v_file_seq := qis_upload_file_seq.nextval;
    begin
      insert into qis_upload_file_list (
        name, mime_type, doc_size, dad_charset, last_updated, content_type, blob_content, file_name, file_seq
      )
      values (
        :new.name, :new.mime_type, :new.doc_size, :new.dad_charset, :new.last_updated, :new.content_type, null, :new.file_name, v_file_seq
      );
    exception
      when others then
        show_err;
    end;

    v_new_file_name := v_file_seq||regexp_substr(:new.file_name, '\.[^\.]*$');

----------------파일 업로드 시 파일시스템에 해당 파일 저장 처리----------------

      l_blob_len := DBMS_LOB.getlength(:new.blob_content);

      -- Open the destination file.
      l_file := UTL_FILE.fopen('QMS_FILE_DIR', v_new_file_name, 'wb', 32767);

      -- Read chunks of the BLOB and write them to the file
      -- until complete.
      WHILE l_pos <= l_blob_len LOOP
        DBMS_LOB.read(:new.blob_content, l_amount, l_pos, l_buffer);
        UTL_FILE.put_raw(l_file, l_buffer, TRUE);
        l_pos := l_pos + l_amount;
      END LOOP;

      -- Close the file.
      UTL_FILE.fclose(l_file);    

-------------------------------------------------------------------------------


  ELSIF UPDATING THEN
    update  qis_upload_file_list
    set     name = :new.name
    where   name = :old.name;

  elsIF DELETING THEN
    delete from qis_upload_file_list
    where   name = :new.name;

    BEGIN
      insert into qis_upload_recycle(NAME,MIME_TYPE,DOC_SIZE,DAD_CHARSET,LAST_UPDATED,CONTENT_TYPE,BLOB_CONTENT,FILE_NAME)
      values (:OLD.NAME,:OLD.MIME_TYPE,:OLD.DOC_SIZE,:OLD.DAD_CHARSET,:OLD.LAST_UPDATED,:OLD.CONTENT_TYPE,:OLD.BLOB_CONTENT,:OLD.FILE_NAME);

    END;

	end if;
*/
exception
  when others then
    --show_err('Trigger1 - '||v_new_file_name||'-');
    null;

END DT_qis_upload_FILE;
/
ALTER TRIGGER "PREMIER"."DT_QIS_UPLOAD_FILE" ENABLE;
