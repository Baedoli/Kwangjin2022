--------------------------------------------------------
--  Constraints for Table P_600
--------------------------------------------------------

  ALTER TABLE "PREMIER"."P_600" MODIFY ("SYSTEMCD" NOT NULL ENABLE);
  ALTER TABLE "PREMIER"."P_600" MODIFY ("RCNO" NOT NULL ENABLE);
  ALTER TABLE "PREMIER"."P_600" ADD CONSTRAINT "PK_P_600" PRIMARY KEY ("SYSTEMCD", "RCNO")
  USING INDEX "PREMIER"."PK_P_600"  ENABLE;
