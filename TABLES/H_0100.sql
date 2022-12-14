--------------------------------------------------------
--  DDL for Table H_0100
--------------------------------------------------------

  CREATE TABLE "PREMIER"."H_0100" 
   (	"COMPANYCD" VARCHAR2(2 BYTE), 
	"XUSER" VARCHAR2(20 BYTE), 
	"ERP_ID" VARCHAR2(20 BYTE), 
	"EMP_TYPE" VARCHAR2(20 BYTE), 
	"JIKUP_TYPE" VARCHAR2(20 BYTE), 
	"EMP_DESCR" VARCHAR2(1024 BYTE), 
	"LOGIN_COMPANYCD" VARCHAR2(2 BYTE), 
	"LOGIN_ID" VARCHAR2(20 BYTE), 
	"LOGIN_YMD" DATE, 
	"MANAGER" VARCHAR2(20 BYTE), 
	"SUB_TEAMCD" VARCHAR2(6 BYTE), 
	"GRADE" VARCHAR2(10 BYTE), 
	"USEYN" VARCHAR2(5 BYTE), 
	"MGR_COMPANYCD" VARCHAR2(2 BYTE), 
	"EMP_TYPE_SYSTEM" VARCHAR2(20 BYTE), 
	"EMP_JIKUP_SYSTEM" VARCHAR2(20 BYTE), 
	"ORDER_" NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 1048576 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "PREMIER_DAT" ;

   COMMENT ON COLUMN "PREMIER"."H_0100"."COMPANYCD" IS '법인구분';
   COMMENT ON COLUMN "PREMIER"."H_0100"."XUSER" IS '로그인코드';
   COMMENT ON COLUMN "PREMIER"."H_0100"."ERP_ID" IS 'ERP ID';
   COMMENT ON COLUMN "PREMIER"."H_0100"."EMP_TYPE" IS '직책-CATALOG(JIKUP):인사평가에서만 사용';
   COMMENT ON COLUMN "PREMIER"."H_0100"."JIKUP_TYPE" IS '직위-CATALOGCD(RANK)';
   COMMENT ON COLUMN "PREMIER"."H_0100"."EMP_DESCR" IS '비고';
   COMMENT ON COLUMN "PREMIER"."H_0100"."EMP_TYPE_SYSTEM" IS '직책-CATALOG(JIKUP):전사결재연동';
   COMMENT ON COLUMN "PREMIER"."H_0100"."ORDER_" IS '정렬';
   COMMENT ON TABLE "PREMIER"."H_0100"  IS '인사항목 마스터_추가';
