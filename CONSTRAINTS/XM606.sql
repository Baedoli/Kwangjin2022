--------------------------------------------------------
--  Constraints for Table XM606
--------------------------------------------------------

  ALTER TABLE "PREMIER"."XM606" MODIFY ("COMPANYCD" NOT NULL ENABLE);
  ALTER TABLE "PREMIER"."XM606" MODIFY ("TEAMCD" NOT NULL ENABLE);
  ALTER TABLE "PREMIER"."XM606" ADD CONSTRAINT "PK_XM606" PRIMARY KEY ("COMPANYCD", "TEAMCD", "SDATE")
  USING INDEX "PREMIER"."PK_XM606"  ENABLE;
