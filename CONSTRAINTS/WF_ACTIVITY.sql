--------------------------------------------------------
--  Constraints for Table WF_ACTIVITY
--------------------------------------------------------

  ALTER TABLE "PREMIER"."WF_ACTIVITY" MODIFY ("DOC_ID" NOT NULL ENABLE);
  ALTER TABLE "PREMIER"."WF_ACTIVITY" MODIFY ("EMP_ID" NOT NULL ENABLE);
  ALTER TABLE "PREMIER"."WF_ACTIVITY" ADD CONSTRAINT "WF_ACTIVITY_PK" PRIMARY KEY ("DOC_ID", "EMP_ID")
  USING INDEX "PREMIER"."WF_ACTIVITY_PK"  ENABLE;
