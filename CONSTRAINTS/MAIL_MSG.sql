--------------------------------------------------------
--  Constraints for Table MAIL_MSG
--------------------------------------------------------

  ALTER TABLE "PREMIER"."MAIL_MSG" MODIFY ("MSG_CODE" NOT NULL ENABLE);
  ALTER TABLE "PREMIER"."MAIL_MSG" ADD CONSTRAINT "PK_MAIL_MSG" PRIMARY KEY ("MSG_CODE")
  USING INDEX "PREMIER"."PK_MAIL_MSG"  ENABLE;
