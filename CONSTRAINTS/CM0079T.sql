--------------------------------------------------------
--  Constraints for Table CM0079T
--------------------------------------------------------

  ALTER TABLE "PREMIER"."CM0079T" MODIFY ("COMPANYCD" NOT NULL ENABLE);
  ALTER TABLE "PREMIER"."CM0079T" MODIFY ("TIMEZONE" NOT NULL ENABLE);
  ALTER TABLE "PREMIER"."CM0079T" ADD CONSTRAINT "PK_CM0079T" PRIMARY KEY ("COMPANYCD", "TIMEZONE", "SYMD")
  USING INDEX "PREMIER"."PK_CM0079T"  ENABLE;
