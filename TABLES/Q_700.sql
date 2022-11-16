--------------------------------------------------------
--  DDL for Table Q_700
--------------------------------------------------------

  CREATE TABLE "PREMIER"."Q_700" 
   (	"KINDCD" VARCHAR2(20 BYTE), 
	"COMPANYCD" VARCHAR2(2 BYTE), 
	"GUBUN" VARCHAR2(1 BYTE), 
	"XUSER" VARCHAR2(20 BYTE), 
	"TEAMCD" VARCHAR2(20 BYTE), 
	"DESCR" VARCHAR2(100 BYTE), 
	"LOGIN_COMPANYCD" VARCHAR2(2 BYTE), 
	"LOGIN_ID" VARCHAR2(20 BYTE), 
	"LOGIN_YMD" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 30 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 524288 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "PREMIER_DAT" ;

   COMMENT ON COLUMN "PREMIER"."Q_700"."KINDCD" IS '차종코드';
   COMMENT ON COLUMN "PREMIER"."Q_700"."COMPANYCD" IS 'C-0010-로그인사업장';
   COMMENT ON COLUMN "PREMIER"."Q_700"."GUBUN" IS 'C-0010-구분';
   COMMENT ON COLUMN "PREMIER"."Q_700"."XUSER" IS 'C-0010-로그인 아이디';
   COMMENT ON COLUMN "PREMIER"."Q_700"."TEAMCD" IS '팀코드';
   COMMENT ON COLUMN "PREMIER"."Q_700"."DESCR" IS '비고';
   COMMENT ON TABLE "PREMIER"."Q_700"  IS 'ECR-차종별담당자';
