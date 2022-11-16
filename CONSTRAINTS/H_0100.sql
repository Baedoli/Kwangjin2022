--------------------------------------------------------
--  Constraints for Table H_0100
--------------------------------------------------------

  ALTER TABLE "PREMIER"."H_0100" MODIFY ("COMPANYCD" NOT NULL ENABLE);
  ALTER TABLE "PREMIER"."H_0100" MODIFY ("XUSER" NOT NULL ENABLE);
  ALTER TABLE "PREMIER"."H_0100" ADD CONSTRAINT "PK_H_0100" PRIMARY KEY ("COMPANYCD", "XUSER")
  USING INDEX "PREMIER"."PK_H_0100"  ENABLE;
