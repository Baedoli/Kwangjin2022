--------------------------------------------------------
--  Constraints for Table MM4045T
--------------------------------------------------------

  ALTER TABLE "PREMIER"."MM4045T" MODIFY ("COMPANYCD" NOT NULL ENABLE);
  ALTER TABLE "PREMIER"."MM4045T" MODIFY ("VENDCD" NOT NULL ENABLE);
  ALTER TABLE "PREMIER"."MM4045T" MODIFY ("APNO" NOT NULL ENABLE);
  ALTER TABLE "PREMIER"."MM4045T" ADD CONSTRAINT "PK_MM4045T" PRIMARY KEY ("COMPANYCD", "VENDCD", "APNO")
  USING INDEX "PREMIER"."PK_MM4045T"  ENABLE;