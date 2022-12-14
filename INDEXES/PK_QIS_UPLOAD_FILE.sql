--------------------------------------------------------
--  DDL for Index PK_QIS_UPLOAD_FILE
--------------------------------------------------------

  CREATE INDEX "PREMIER"."PK_QIS_UPLOAD_FILE" ON "PREMIER"."QIS_UPLOAD_FILE" ("FILE_NAME", "LAST_UPDATED") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 6291456 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "PREMIER_IDX" ;
