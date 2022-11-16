--------------------------------------------------------
--  Constraints for Table WF_CODE
--------------------------------------------------------

  ALTER TABLE "PREMIER"."WF_CODE" MODIFY ("WF_CODE" NOT NULL ENABLE);
  ALTER TABLE "PREMIER"."WF_CODE" MODIFY ("WF_CODE_NAME" NOT NULL ENABLE);
  ALTER TABLE "PREMIER"."WF_CODE" ADD CONSTRAINT "PK_WF_CODE" PRIMARY KEY ("WF_CODE")
  USING INDEX "PREMIER"."PK_WF_CODE"  ENABLE;
