--------------------------------------------------------
--  Constraints for Table CM0060T
--------------------------------------------------------

  ALTER TABLE "PREMIER"."CM0060T" MODIFY ("COMPANYCD" NOT NULL ENABLE);
  ALTER TABLE "PREMIER"."CM0060T" MODIFY ("LINECD" NOT NULL ENABLE);
  ALTER TABLE "PREMIER"."CM0060T" ADD CONSTRAINT "PK_CM0060T" PRIMARY KEY ("COMPANYCD", "LINECD")
  USING INDEX "PREMIER"."PK_CM0060T"  ENABLE;
