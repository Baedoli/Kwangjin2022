--------------------------------------------------------
--  DDL for Table Q_706
--------------------------------------------------------

  CREATE TABLE "PREMIER"."Q_706" 
   (	"KINDCD" VARCHAR2(20 BYTE), 
	"SECUR_TYPE" VARCHAR2(20 BYTE), 
	"COMPANYCD" VARCHAR2(2 BYTE), 
	"GUBUN" VARCHAR2(1 BYTE), 
	"XUSER" VARCHAR2(20 BYTE), 
	"TEAMCD" VARCHAR2(6 BYTE), 
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

   COMMENT ON COLUMN "PREMIER"."Q_706"."KINDCD" IS '차종코드';
   COMMENT ON COLUMN "PREMIER"."Q_706"."SECUR_TYPE" IS '권한종류_BOM작성(10)_BOM조회(20)_도면배포(30)_도면등록(40)';
   COMMENT ON COLUMN "PREMIER"."Q_706"."COMPANYCD" IS 'C-0010-로그인사업장';
   COMMENT ON COLUMN "PREMIER"."Q_706"."GUBUN" IS 'C-0010-구분';
   COMMENT ON COLUMN "PREMIER"."Q_706"."XUSER" IS 'C-0010-로그인 아이디';
   COMMENT ON COLUMN "PREMIER"."Q_706"."TEAMCD" IS '팀코드';
   COMMENT ON COLUMN "PREMIER"."Q_706"."DESCR" IS '비고';
   COMMENT ON TABLE "PREMIER"."Q_706"  IS '도면관리_프로젝트별_담당자';