--------------------------------------------------------
--  DDL for Table C_0005
--------------------------------------------------------

  CREATE TABLE "PREMIER"."C_0005" 
   (	"SYSTEMCD" VARCHAR2(3 BYTE), 
	"SYSTEMNM" VARCHAR2(300 BYTE), 
	"USEYN" VARCHAR2(1 BYTE) DEFAULT 'Y'
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 1048576 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "PREMIER_DAT" ;

   COMMENT ON COLUMN "PREMIER"."C_0005"."SYSTEMCD" IS '시스템코드(SCM,B2B,QIR,LOT)';
   COMMENT ON COLUMN "PREMIER"."C_0005"."SYSTEMNM" IS '시스템명';
   COMMENT ON COLUMN "PREMIER"."C_0005"."USEYN" IS '사용유무 (Y.사용  N.사용안함)';
   COMMENT ON TABLE "PREMIER"."C_0005"  IS '시스템코드마스타';
