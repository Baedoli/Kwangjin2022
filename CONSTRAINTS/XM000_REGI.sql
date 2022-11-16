--------------------------------------------------------
--  Constraints for Table XM000_REGI
--------------------------------------------------------

  ALTER TABLE "PREMIER"."XM000_REGI" MODIFY ("COMPANYCD" NOT NULL ENABLE);
  ALTER TABLE "PREMIER"."XM000_REGI" MODIFY ("KINDCD" NOT NULL ENABLE);
  ALTER TABLE "PREMIER"."XM000_REGI" ADD CONSTRAINT "PK_XM000_REGI" PRIMARY KEY ("COMPANYCD", "KINDCD")
  USING INDEX "PREMIER"."PK_XM000_REGI"  ENABLE;
