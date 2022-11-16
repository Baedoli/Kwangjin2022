--------------------------------------------------------
--  Constraints for Table MM4035T
--------------------------------------------------------

  ALTER TABLE "PREMIER"."MM4035T" ADD CONSTRAINT "PK_MM4035T" PRIMARY KEY ("COMPANYCD", "VENDCD", "APNO")
  USING INDEX "PREMIER"."PK_MM4035T"  ENABLE;
