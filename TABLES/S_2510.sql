--------------------------------------------------------
--  DDL for Table S_2510
--------------------------------------------------------

  CREATE TABLE "PREMIER"."S_2510" 
   (	"COMPANYCD" VARCHAR2(2 BYTE), 
	"VENDCD" VARCHAR2(20 BYTE), 
	"SVENDCD" VARCHAR2(20 BYTE), 
	"SAUP" VARCHAR2(20 BYTE), 
	"SYMD" DATE, 
	"PONO" VARCHAR2(100 BYTE), 
	"SNO" NUMBER, 
	"CAPNO" VARCHAR2(100 BYTE), 
	"SQTY" NUMBER, 
	"LOGIN_ID" VARCHAR2(30 BYTE), 
	"LOGIN_YMD" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 5 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "PREMIER_DAT" ;

   COMMENT ON COLUMN "PREMIER"."S_2510"."COMPANYCD" IS '사업장';
   COMMENT ON COLUMN "PREMIER"."S_2510"."VENDCD" IS '물류업체';
   COMMENT ON COLUMN "PREMIER"."S_2510"."SVENDCD" IS '판매업체';
   COMMENT ON COLUMN "PREMIER"."S_2510"."SAUP" IS '판매사업장';
   COMMENT ON COLUMN "PREMIER"."S_2510"."SYMD" IS '출고일자';
   COMMENT ON COLUMN "PREMIER"."S_2510"."PONO" IS '발주번호';
   COMMENT ON COLUMN "PREMIER"."S_2510"."SNO" IS '순번';
   COMMENT ON COLUMN "PREMIER"."S_2510"."CAPNO" IS '판매품번';
   COMMENT ON COLUMN "PREMIER"."S_2510"."SQTY" IS '판매수량';
   COMMENT ON TABLE "PREMIER"."S_2510"  IS '물류업체 PO등록';
