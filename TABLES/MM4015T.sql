--------------------------------------------------------
--  DDL for Table MM4015T
--------------------------------------------------------

  CREATE TABLE "PREMIER"."MM4015T" 
   (	"COMPANYCD" VARCHAR2(2 BYTE), 
	"VENDCD" VARCHAR2(20 BYTE), 
	"INDATE" DATE, 
	"APNO" VARCHAR2(50 BYTE), 
	"BOXQTY" NUMBER DEFAULT 0, 
	"QTY" NUMBER DEFAULT 0, 
	"WEIGHT" NUMBER DEFAULT 0, 
	"CALDIV" VARCHAR2(20 BYTE), 
	"COST" NUMBER DEFAULT 0, 
	"DESCR" VARCHAR2(500 BYTE), 
	"PYMD" DATE, 
	"LOGIN_ID" VARCHAR2(30 BYTE), 
	"LOGIN_YMD" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 5 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "PREMIER_DAT" ;

   COMMENT ON COLUMN "PREMIER"."MM4015T"."COMPANYCD" IS '광진사업장';
   COMMENT ON COLUMN "PREMIER"."MM4015T"."VENDCD" IS '요청업체';
   COMMENT ON COLUMN "PREMIER"."MM4015T"."INDATE" IS '요청일';
   COMMENT ON COLUMN "PREMIER"."MM4015T"."APNO" IS '품번';
   COMMENT ON COLUMN "PREMIER"."MM4015T"."BOXQTY" IS '박스- CM0045T';
   COMMENT ON COLUMN "PREMIER"."MM4015T"."QTY" IS '수량';
   COMMENT ON COLUMN "PREMIER"."MM4015T"."WEIGHT" IS '무게';
   COMMENT ON COLUMN "PREMIER"."MM4015T"."CALDIV" IS 'CM0050T-금액산출구분(1:수량,2:중량)';
   COMMENT ON COLUMN "PREMIER"."MM4015T"."COST" IS '단가';
   COMMENT ON COLUMN "PREMIER"."MM4015T"."DESCR" IS '비고';
   COMMENT ON COLUMN "PREMIER"."MM4015T"."PYMD" IS '등록일';
   COMMENT ON TABLE "PREMIER"."MM4015T"  IS '업체-원자재사급요청';