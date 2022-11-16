--------------------------------------------------------
--  DDL for Table C_0042
--------------------------------------------------------

  CREATE TABLE "PREMIER"."C_0042" 
   (	"PGM_ORDER" NUMBER, 
	"URL" VARCHAR2(1000 BYTE), 
	"TARGET" VARCHAR2(500 BYTE), 
	"ID_" NUMBER, 
	"UID_" NUMBER, 
	"LOGIN_ID" VARCHAR2(20 BYTE), 
	"LOGIN_YMD" DATE, 
	"MODIFIED" VARCHAR2(5 BYTE), 
	"USEYN" VARCHAR2(1 BYTE), 
	"USEYN_SUPPLY" VARCHAR2(1 BYTE), 
	"PREMIER_VIEW" VARCHAR2(1 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 1048576 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "PREMIER_DAT" ;

   COMMENT ON COLUMN "PREMIER"."C_0042"."PGM_ORDER" IS '같은레벨에서 정렬순서';
   COMMENT ON COLUMN "PREMIER"."C_0042"."URL" IS '클릭시 경로';
   COMMENT ON COLUMN "PREMIER"."C_0042"."TARGET" IS 'target';
   COMMENT ON COLUMN "PREMIER"."C_0042"."ID_" IS '자신ID';
   COMMENT ON COLUMN "PREMIER"."C_0042"."UID_" IS '부모ID';
   COMMENT ON COLUMN "PREMIER"."C_0042"."MODIFIED" IS '수정중 체크';
   COMMENT ON TABLE "PREMIER"."C_0042"  IS '프로그램 메뉴';
