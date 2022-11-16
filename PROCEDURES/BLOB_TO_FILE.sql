--------------------------------------------------------
--  DDL for Procedure BLOB_TO_FILE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PREMIER"."BLOB_TO_FILE" 
( 
  p_id           IN varchar2, 
  p_file_name   in varchar2,
  p_dir          in varchar2
)
IS
  v_blob BLOB;
  l_clob CLOB;
  v_file_name VARCHAR2(100);
  v_file_ext VARCHAR2(3);
  v_len NUMBER;
  v_my_vr RAW(32767);
  v_start_pos NUMBER := 1;
  v_byte_len NUMBER := 32767;
  v_output UTL_FILE.FILE_TYPE;

 function clobfromblob(p_blob blob) return clob is
      l_clob         clob;
      l_dest_offsset integer := 1;
      l_src_offsset  integer := 1;
      l_lang_context integer := dbms_lob.default_lang_ctx;
      l_warning      integer;

   begin

      if p_blob is null then
         return null;
      end if;

      dbms_lob.createTemporary(lob_loc => l_clob
                              ,cache   => false);

      dbms_lob.converttoclob(dest_lob     => l_clob
                            ,src_blob     => p_blob
                            ,amount       => dbms_lob.lobmaxsize
                            ,dest_offset  => l_dest_offsset
                            ,src_offset   => l_src_offsset
                            ,blob_csid    => nls_charset_id('KO16MSWIN949')
                            ,lang_context => l_lang_context
                            ,warning      => l_warning);

      return l_clob;

   end;  

BEGIN
  -- get the blob locator
  SELECT  blob_content, file_name, lower(substr(file_name,-3,3))
  INTO     v_blob, v_file_name, v_file_ext
  FROM     qis_upload_file
  WHERE   name = p_id; 

  l_clob := clobfromblob(v_blob);

  DBMS_XSLPROCESSOR.clob2file (l_clob, p_dir, p_file_name,nls_charset_id('KO16MSWIN949'));

EXCEPTION 
  WHEN OTHERS THEN 
    UTL_FILE.FCLOSE(v_output);  
--    DBMS_OUTPUT.PUT_LINE ('error : '|| substr(replace(replace(sqlerrm, chr(10), ''), '"', ''''), 1, 3000)||'' );
END;

/
