--------------------------------------------------------
--  Constraints for Table XM000
--------------------------------------------------------

  ALTER TABLE "PREMIER"."XM000" MODIFY ("KINDCD" NOT NULL ENABLE);
  ALTER TABLE "PREMIER"."XM000" ADD CONSTRAINT "PK_XM000" PRIMARY KEY ("KINDCD")
  USING INDEX "PREMIER"."PK_XM000"  ENABLE;
