--------------------------------------------------------
--  DDL for Table MAIL_MSG
--------------------------------------------------------

  CREATE TABLE "PREMIER"."MAIL_MSG" 
   (	"MSG_CODE" VARCHAR2(20 BYTE), 
	"MSG_NAME" VARCHAR2(1024 BYTE), 
	"MSG_KO" VARCHAR2(2048 BYTE), 
	"MSG_EN" VARCHAR2(2048 BYTE), 
	"MSG_CH" VARCHAR2(2048 BYTE), 
	"MSG_SP" VARCHAR2(2048 BYTE), 
	"USEYN" VARCHAR2(2 BYTE) DEFAULT 'Y', 
	"LOGIN_ID" VARCHAR2(20 BYTE), 
	"LOGIN_YMD" DATE, 
	"LOGIN_COMP" VARCHAR2(2 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 30 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 4194304 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "PREMIER_DAT" ;