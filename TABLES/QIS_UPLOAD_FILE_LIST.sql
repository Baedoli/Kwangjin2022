--------------------------------------------------------
--  DDL for Table QIS_UPLOAD_FILE_LIST
--------------------------------------------------------

  CREATE TABLE "PREMIER"."QIS_UPLOAD_FILE_LIST" 
   (	"NAME" VARCHAR2(256 BYTE), 
	"MIME_TYPE" VARCHAR2(128 BYTE), 
	"DOC_SIZE" NUMBER, 
	"DAD_CHARSET" VARCHAR2(128 BYTE), 
	"LAST_UPDATED" DATE, 
	"CONTENT_TYPE" VARCHAR2(128 BYTE), 
	"BLOB_CONTENT" BLOB, 
	"FILE_NAME" VARCHAR2(255 BYTE), 
	"FILE_SEQ" NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "PREMIER_DAT" 
 LOB ("BLOB_CONTENT") STORE AS SECUREFILE (
  TABLESPACE "PREMIER_DAT" ENABLE STORAGE IN ROW CHUNK 8192
  NOCACHE LOGGING  NOCOMPRESS  KEEP_DUPLICATES 
  STORAGE(INITIAL 106496 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)) ;
