--------------------------------------------------------
--  DDL for Index PK_C_0045
--------------------------------------------------------

  CREATE UNIQUE INDEX "PREMIER"."PK_C_0045" ON "PREMIER"."C_0045" ("SYSTEMCD", "PGMID", "FIELDCD") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 1048576 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "PREMIER_IDX" ;
