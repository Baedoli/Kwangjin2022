--------------------------------------------------------
--  Constraints for Table COMP_DUP_INFO
--------------------------------------------------------

  ALTER TABLE "PREMIER"."COMP_DUP_INFO" ADD CONSTRAINT "PK_COMP_DUP_INFO" PRIMARY KEY ("COMPANYCD", "GUBUN", "XUSER", "SNO")
  USING INDEX "PREMIER"."PK_COMP_DUP_INFO"  ENABLE;
