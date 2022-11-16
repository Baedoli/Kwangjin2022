--------------------------------------------------------
--  Constraints for Table TEMP_LJS
--------------------------------------------------------

  ALTER TABLE "PREMIER"."TEMP_LJS" MODIFY ("COMPANYCD" NOT NULL ENABLE);
  ALTER TABLE "PREMIER"."TEMP_LJS" MODIFY ("REGISTER_NO" NOT NULL ENABLE);
  ALTER TABLE "PREMIER"."TEMP_LJS" ADD CONSTRAINT "PK_TEMP_LJS" PRIMARY KEY ("COMPANYCD", "REGISTER_NO")
  USING INDEX "PREMIER"."PK_TEMP_LJS"  ENABLE;
