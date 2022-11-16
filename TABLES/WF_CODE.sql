--------------------------------------------------------
--  DDL for Table WF_CODE
--------------------------------------------------------

  CREATE TABLE "PREMIER"."WF_CODE" 
   (	"WF_CODE" VARCHAR2(20 BYTE), 
	"WF_CODE_NAME" VARCHAR2(100 BYTE), 
	"WF_STANDARD" VARCHAR2(100 BYTE), 
	"WF_DOC_NAME" VARCHAR2(100 BYTE), 
	"YANGSIK_YN" VARCHAR2(1 BYTE) DEFAULT 'N', 
	"DESCR" VARCHAR2(1024 BYTE), 
	"LOGIN_COMPANYCD" VARCHAR2(2 BYTE), 
	"LOGIN_ID" VARCHAR2(20 BYTE), 
	"LOGIN_YMD" DATE, 
	"WF_CODE_NAME_KO" VARCHAR2(100 BYTE), 
	"WF_CODE_NAME_EN" VARCHAR2(100 BYTE), 
	"WF_CODE_NAME_CH" VARCHAR2(100 BYTE), 
	"WF_CODE_NAME_SP" VARCHAR2(100 BYTE), 
	"DOCU_DESCR" CLOB, 
	"DOCU_DESCR_EN" CLOB, 
	"DOCU_DESCR_CH" CLOB, 
	"DOCU_DESCR_SP" CLOB, 
	"WF_CODE_NAME_VN" VARCHAR2(100 BYTE), 
	"WF_CODE_NAME_PL" VARCHAR2(100 BYTE), 
	"DOCU_DESCR_VN" CLOB, 
	"DOCU_DESCR_PL" CLOB, 
	"CONFIRM_USER" VARCHAR2(20 BYTE), 
	"SAVE_YEAR" VARCHAR2(20 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 30 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 4194304 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "PREMIER_DAT" 
 LOB ("DOCU_DESCR") STORE AS SECUREFILE (
  TABLESPACE "PREMIER_DAT" ENABLE STORAGE IN ROW CHUNK 8192
  NOCACHE LOGGING  NOCOMPRESS  KEEP_DUPLICATES 
  STORAGE(INITIAL 106496 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)) 
 LOB ("DOCU_DESCR_EN") STORE AS SECUREFILE (
  TABLESPACE "PREMIER_DAT" ENABLE STORAGE IN ROW CHUNK 8192
  NOCACHE LOGGING  NOCOMPRESS  KEEP_DUPLICATES 
  STORAGE(INITIAL 106496 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)) 
 LOB ("DOCU_DESCR_CH") STORE AS SECUREFILE (
  TABLESPACE "PREMIER_DAT" ENABLE STORAGE IN ROW CHUNK 8192
  NOCACHE LOGGING  NOCOMPRESS  KEEP_DUPLICATES 
  STORAGE(INITIAL 106496 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)) 
 LOB ("DOCU_DESCR_SP") STORE AS SECUREFILE (
  TABLESPACE "PREMIER_DAT" ENABLE STORAGE IN ROW CHUNK 8192
  NOCACHE LOGGING  NOCOMPRESS  KEEP_DUPLICATES 
  STORAGE(INITIAL 106496 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)) 
 LOB ("DOCU_DESCR_VN") STORE AS SECUREFILE (
  TABLESPACE "PREMIER_DAT" ENABLE STORAGE IN ROW CHUNK 8192
  NOCACHE LOGGING  NOCOMPRESS  KEEP_DUPLICATES 
  STORAGE(INITIAL 106496 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)) 
 LOB ("DOCU_DESCR_PL") STORE AS SECUREFILE (
  TABLESPACE "PREMIER_DAT" ENABLE STORAGE IN ROW CHUNK 8192
  NOCACHE LOGGING  NOCOMPRESS  KEEP_DUPLICATES 
  STORAGE(INITIAL 106496 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)) ;

   COMMENT ON COLUMN "PREMIER"."WF_CODE"."CONFIRM_USER" IS '전결권자';
   COMMENT ON COLUMN "PREMIER"."WF_CODE"."SAVE_YEAR" IS '보존연한';