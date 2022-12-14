--------------------------------------------------------
--  DDL for Table P_600
--------------------------------------------------------

  CREATE TABLE "PREMIER"."P_600" 
   (	"SYSTEMCD" VARCHAR2(20 BYTE), 
	"RCNO" NUMBER, 
	"COMPANYCD" VARCHAR2(2 BYTE), 
	"Q_YMD" DATE, 
	"Q_XUSERNM" VARCHAR2(40 BYTE), 
	"Q_DESCR" VARCHAR2(1000 BYTE), 
	"R_YMD1" DATE, 
	"R_YMD2" DATE, 
	"R_XUSERNM" VARCHAR2(40 BYTE), 
	"R_DESCR" VARCHAR2(1000 BYTE), 
	"R_STATECD" VARCHAR2(2 BYTE) DEFAULT 'N', 
	"C_YN" VARCHAR2(2 BYTE) DEFAULT 'N', 
	"DOC_ID" NUMBER, 
	"LOGIN_COMPANYCD" VARCHAR2(2 BYTE), 
	"LOGIN_ID" VARCHAR2(20 BYTE), 
	"LOGIN_YMD" DATE, 
	"TEMP_DESCR" VARCHAR2(1000 BYTE), 
	"TEMP_P_YMD" DATE, 
	"TEMP_C_YMD" DATE, 
	"IMPRO_DESCR" VARCHAR2(1000 BYTE), 
	"IMPRO_P_YMD" DATE, 
	"IMPRO_C_YMD" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 30 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 524288 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "PREMIER_DAT" ;

   COMMENT ON COLUMN "PREMIER"."P_600"."SYSTEMCD" IS 'Catalog- 시스템코드';
   COMMENT ON COLUMN "PREMIER"."P_600"."RCNO" IS 'RC번호';
   COMMENT ON COLUMN "PREMIER"."P_600"."COMPANYCD" IS '요청사업장';
   COMMENT ON COLUMN "PREMIER"."P_600"."Q_YMD" IS '요청일';
   COMMENT ON COLUMN "PREMIER"."P_600"."Q_XUSERNM" IS '요청자';
   COMMENT ON COLUMN "PREMIER"."P_600"."Q_DESCR" IS '요청내용 ';
   COMMENT ON COLUMN "PREMIER"."P_600"."R_YMD1" IS '접수일';
   COMMENT ON COLUMN "PREMIER"."P_600"."R_YMD2" IS '조치일(답변일)';
   COMMENT ON COLUMN "PREMIER"."P_600"."R_XUSERNM" IS '답변자';
   COMMENT ON COLUMN "PREMIER"."P_600"."R_DESCR" IS '답변내용';
   COMMENT ON COLUMN "PREMIER"."P_600"."R_STATECD" IS '조치단계(catalog)';
   COMMENT ON COLUMN "PREMIER"."P_600"."C_YN" IS '확인 Y/N (요청자, 전산실)';
   COMMENT ON COLUMN "PREMIER"."P_600"."TEMP_DESCR" IS '임시대책';
   COMMENT ON COLUMN "PREMIER"."P_600"."TEMP_P_YMD" IS '임시대책계획일';
   COMMENT ON COLUMN "PREMIER"."P_600"."TEMP_C_YMD" IS '임시대책완료일';
   COMMENT ON COLUMN "PREMIER"."P_600"."IMPRO_DESCR" IS '개선대책';
   COMMENT ON COLUMN "PREMIER"."P_600"."IMPRO_P_YMD" IS '개선대책계획일';
   COMMENT ON COLUMN "PREMIER"."P_600"."IMPRO_C_YMD" IS '개선대책완료일';
   COMMENT ON TABLE "PREMIER"."P_600"  IS 'RC- 마스타';
