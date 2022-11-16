--------------------------------------------------------
--  DDL for Index PK_CM0070T
--------------------------------------------------------

  CREATE UNIQUE INDEX "PREMIER"."PK_CM0070T" ON "PREMIER"."CM0070T" ("COMPANYCD", "VENDCD") 
  PCTFREE 5 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 196608 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "PREMIER_IDX" ;
