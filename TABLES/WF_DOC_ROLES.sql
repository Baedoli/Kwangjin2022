--------------------------------------------------------
--  DDL for Table WF_DOC_ROLES
--------------------------------------------------------

  CREATE TABLE "PREMIER"."WF_DOC_ROLES" 
   (	"DOC_ID" NUMBER, 
	"COM_ID" VARCHAR2(2 BYTE), 
	"ORG_ID" VARCHAR2(6 BYTE), 
	"EMP_ID" VARCHAR2(20 BYTE), 
	"ROLE_ID" NUMBER, 
	"TYPE_ID" NUMBER, 
	"PRIOR_ID" NUMBER, 
	"CREATED_DATE" DATE, 
	"STATUS" VARCHAR2(10 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 3145728 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "PREMIER_DAT" ;

   COMMENT ON TABLE "PREMIER"."WF_DOC_ROLES"  IS 'QIS-결재 대상 마스타';
