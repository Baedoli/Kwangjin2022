--------------------------------------------------------
--  DDL for Table C_0043
--------------------------------------------------------

  CREATE TABLE "PREMIER"."C_0043" 
   (	"COMPANYCD" VARCHAR2(2 BYTE), 
	"GUBUN" VARCHAR2(1 BYTE), 
	"XUSER" VARCHAR2(20 BYTE), 
	"SYSTEMCD" VARCHAR2(3 BYTE), 
	"PGMID" VARCHAR2(20 BYTE), 
	"MEMO" VARCHAR2(100 BYTE), 
	"SNO" NUMBER DEFAULT 0, 
	"USEYN" VARCHAR2(1 BYTE) DEFAULT 'Y', 
	"URL" VARCHAR2(1000 BYTE), 
	"TARGET" VARCHAR2(500 BYTE), 
	"ID_" NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 1048576 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "PREMIER_DAT" ;

   COMMENT ON COLUMN "PREMIER"."C_0043"."COMPANYCD" IS '사업장';
   COMMENT ON COLUMN "PREMIER"."C_0043"."GUBUN" IS '구분';
   COMMENT ON COLUMN "PREMIER"."C_0043"."XUSER" IS '사용자ID';
   COMMENT ON COLUMN "PREMIER"."C_0043"."SYSTEMCD" IS '시스템코드';
   COMMENT ON COLUMN "PREMIER"."C_0043"."PGMID" IS '프로그램ID';
   COMMENT ON COLUMN "PREMIER"."C_0043"."MEMO" IS '프로그램명(사용자가 작성한)';
   COMMENT ON COLUMN "PREMIER"."C_0043"."USEYN" IS '사용유무';
   COMMENT ON TABLE "PREMIER"."C_0043"  IS '사용자별 즐겨찾기(북마크)';
