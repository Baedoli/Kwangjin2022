--------------------------------------------------------
--  Constraints for Table CM0070T
--------------------------------------------------------

  ALTER TABLE "PREMIER"."CM0070T" MODIFY ("COMPANYCD" NOT NULL ENABLE);
  ALTER TABLE "PREMIER"."CM0070T" MODIFY ("VENDCD" NOT NULL ENABLE);
  ALTER TABLE "PREMIER"."CM0070T" ADD CONSTRAINT "PK_CM0070T" PRIMARY KEY ("COMPANYCD", "VENDCD")
  USING INDEX "PREMIER"."PK_CM0070T"  ENABLE;
