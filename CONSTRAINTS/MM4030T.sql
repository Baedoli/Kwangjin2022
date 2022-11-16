--------------------------------------------------------
--  Constraints for Table MM4030T
--------------------------------------------------------

  ALTER TABLE "PREMIER"."MM4030T" ADD CONSTRAINT "PK_MM4030T" PRIMARY KEY ("COMPANYCD", "VENDCD", "GROUPCD")
  USING INDEX "PREMIER"."PK_MM4030T"  ENABLE;
