--------------------------------------------------------
--  DDL for Index PK_G_600
--------------------------------------------------------

  CREATE UNIQUE INDEX "PREMIER"."PK_G_600" ON "PREMIER"."G_600" ("YY", "G_GBN", "G_COMPANYCD", "G_CODE", "COMPANYCD", "GUBUN", "XUSER", "SNO") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 2097152 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "PREMIER_IDX" ;
