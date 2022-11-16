--------------------------------------------------------
--  Constraints for Table XM001
--------------------------------------------------------

  ALTER TABLE "PREMIER"."XM001" MODIFY ("COMPANYCD" NOT NULL ENABLE);
  ALTER TABLE "PREMIER"."XM001" ADD CONSTRAINT "PK_XM001" PRIMARY KEY ("COMPANYCD")
  USING INDEX "PREMIER"."PK_XM001"  ENABLE;
