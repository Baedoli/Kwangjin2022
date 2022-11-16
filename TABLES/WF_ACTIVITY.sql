--------------------------------------------------------
--  DDL for Table WF_ACTIVITY
--------------------------------------------------------

  CREATE TABLE "PREMIER"."WF_ACTIVITY" 
   (	"DOC_ID" NUMBER, 
	"EMP_ID" VARCHAR2(20 BYTE), 
	"STATUS" VARCHAR2(10 BYTE), 
	"RESULT" VARCHAR2(10 BYTE), 
	"NOTES" VARCHAR2(2000 BYTE), 
	"START_DATE" DATE, 
	"END_DATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 3145728 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "PREMIER_DAT" ;

   COMMENT ON TABLE "PREMIER"."WF_ACTIVITY"  IS 'QIS- 결재 내용 마스타';