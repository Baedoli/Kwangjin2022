--------------------------------------------------------
--  Constraints for Table C_0043
--------------------------------------------------------

  ALTER TABLE "PREMIER"."C_0043" MODIFY ("COMPANYCD" NOT NULL ENABLE);
  ALTER TABLE "PREMIER"."C_0043" MODIFY ("GUBUN" NOT NULL ENABLE);
  ALTER TABLE "PREMIER"."C_0043" MODIFY ("XUSER" NOT NULL ENABLE);
  ALTER TABLE "PREMIER"."C_0043" ADD CONSTRAINT "PK_C_0043" PRIMARY KEY ("COMPANYCD", "GUBUN", "XUSER", "SYSTEMCD", "PGMID")
  USING INDEX "PREMIER"."PK_C_0043"  ENABLE;
