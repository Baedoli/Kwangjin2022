--------------------------------------------------------
--  Constraints for Table XM800
--------------------------------------------------------

  ALTER TABLE "PREMIER"."XM800" MODIFY ("YMD" NOT NULL ENABLE);
  ALTER TABLE "PREMIER"."XM800" MODIFY ("COINCD" NOT NULL ENABLE);
  ALTER TABLE "PREMIER"."XM800" ADD CONSTRAINT "PK_XM800" PRIMARY KEY ("YMD", "COINCD")
  USING INDEX "PREMIER"."PK_XM800"  ENABLE;
