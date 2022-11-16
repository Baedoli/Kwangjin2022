--------------------------------------------------------
--  Constraints for Table C_2000
--------------------------------------------------------

  ALTER TABLE "PREMIER"."C_2000" MODIFY ("KNAME" NOT NULL ENABLE);
  ALTER TABLE "PREMIER"."C_2000" MODIFY ("LANG" NOT NULL ENABLE);
  ALTER TABLE "PREMIER"."C_2000" ADD CONSTRAINT "PK_C_2000" PRIMARY KEY ("KNAME", "LANG")
  USING INDEX "PREMIER"."PK_C_2000"  ENABLE;
