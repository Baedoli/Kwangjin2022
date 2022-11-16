--------------------------------------------------------
--  Constraints for Table C_0060
--------------------------------------------------------

  ALTER TABLE "PREMIER"."C_0060" MODIFY ("SYSTEMCD" NOT NULL ENABLE);
  ALTER TABLE "PREMIER"."C_0060" MODIFY ("CATALOGCD" NOT NULL ENABLE);
  ALTER TABLE "PREMIER"."C_0060" ADD CONSTRAINT "PK_C_0060" PRIMARY KEY ("SYSTEMCD", "CATALOGCD")
  USING INDEX "PREMIER"."PK_C_0060"  ENABLE;
