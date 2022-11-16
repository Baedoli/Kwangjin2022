--------------------------------------------------------
--  Constraints for Table SYS_FILE_UPLOAD_TEMP
--------------------------------------------------------

  ALTER TABLE "PREMIER"."SYS_FILE_UPLOAD_TEMP" MODIFY ("FILESEQ" NOT NULL ENABLE);
  ALTER TABLE "PREMIER"."SYS_FILE_UPLOAD_TEMP" ADD CONSTRAINT "SYS_FILE_UPLOAD_TEMP_PK" PRIMARY KEY ("FILESEQ")
  USING INDEX "PREMIER"."SYS_FILE_UPLOAD_TEMP_PK"  ENABLE;
