--------------------------------------------------------
--  DDL for Table COMP_DUP_INFO
--------------------------------------------------------

  CREATE TABLE "PREMIER"."COMP_DUP_INFO" 
   (	"COMPANYCD" VARCHAR2(2 BYTE), 
	"GUBUN" VARCHAR2(1 BYTE), 
	"XUSER" VARCHAR2(20 BYTE), 
	"SNO" NUMBER DEFAULT 0, 
	"D_COMPANYCD" VARCHAR2(2 BYTE), 
	"TEAMCD" VARCHAR2(20 BYTE), 
	"JIKUP" VARCHAR2(10 BYTE), 
	"LOGIN_COMPANYCD" VARCHAR2(2 BYTE), 
	"LOGIN_ID" VARCHAR2(20 BYTE), 
	"LOGIN_YMD" DATE, 
	"D_XUSER" VARCHAR2(20 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 30 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 4194304 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "PREMIER_DAT" ;
