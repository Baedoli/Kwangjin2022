--------------------------------------------------------
--  DDL for Table C_0020_221107
--------------------------------------------------------

  CREATE TABLE "PREMIER"."C_0020_221107" 
   (	"COMPANYCD" VARCHAR2(2 BYTE), 
	"GUBUN" VARCHAR2(1 BYTE), 
	"XUSER" VARCHAR2(20 BYTE), 
	"SYSTEMCD" VARCHAR2(3 BYTE), 
	"GRADE" VARCHAR2(30 BYTE), 
	"USEYN" VARCHAR2(1 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "PREMIER_DAT" ;
