--------------------------------------------------------
--  Constraints for Table SYS_FILE_UPLOAD
--------------------------------------------------------

  ALTER TABLE "PREMIER"."SYS_FILE_UPLOAD" MODIFY ("FILESEQ" NOT NULL ENABLE);
  ALTER TABLE "PREMIER"."SYS_FILE_UPLOAD" ADD CONSTRAINT "SYS_FILE_UPLOAD_PK" PRIMARY KEY ("FILESEQ")
  USING INDEX "PREMIER"."SYS_FILE_UPLOAD_PK"  ENABLE;
