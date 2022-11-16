--------------------------------------------------------
--  Constraints for Table CM0077T
--------------------------------------------------------

  ALTER TABLE "PREMIER"."CM0077T" MODIFY ("COMPANYCD" NOT NULL ENABLE);
  ALTER TABLE "PREMIER"."CM0077T" MODIFY ("VENDCD" NOT NULL ENABLE);
  ALTER TABLE "PREMIER"."CM0077T" ADD CONSTRAINT "PK_CM0077T" PRIMARY KEY ("COMPANYCD", "VENDCD", "SNO")
  USING INDEX "PREMIER"."PK_CM0077T"  ENABLE;
