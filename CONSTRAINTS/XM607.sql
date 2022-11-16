--------------------------------------------------------
--  Constraints for Table XM607
--------------------------------------------------------

  ALTER TABLE "PREMIER"."XM607" MODIFY ("COMPANYCD" NOT NULL ENABLE);
  ALTER TABLE "PREMIER"."XM607" MODIFY ("TEAMCD" NOT NULL ENABLE);
  ALTER TABLE "PREMIER"."XM607" MODIFY ("TEAMNM" NOT NULL ENABLE);
  ALTER TABLE "PREMIER"."XM607" ADD CONSTRAINT "PK_XM607" PRIMARY KEY ("COMPANYCD", "TEAMCD")
  USING INDEX "PREMIER"."PK_XM607"  ENABLE;
