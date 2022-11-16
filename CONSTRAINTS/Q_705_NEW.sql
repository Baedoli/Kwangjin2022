--------------------------------------------------------
--  Constraints for Table Q_705_NEW
--------------------------------------------------------

  ALTER TABLE "PREMIER"."Q_705_NEW" MODIFY ("COMPANYCD" NOT NULL ENABLE);
  ALTER TABLE "PREMIER"."Q_705_NEW" MODIFY ("LANG" NOT NULL ENABLE);
  ALTER TABLE "PREMIER"."Q_705_NEW" MODIFY ("SNO" NOT NULL ENABLE);
  ALTER TABLE "PREMIER"."Q_705_NEW" ADD CONSTRAINT "PK_Q_705_NEW" PRIMARY KEY ("COMPANYCD", "LANG", "SNO")
  USING INDEX "PREMIER"."PK_Q_705_NEW"  ENABLE;
