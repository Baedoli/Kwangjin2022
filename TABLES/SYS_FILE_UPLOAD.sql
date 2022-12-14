--------------------------------------------------------
--  DDL for Table SYS_FILE_UPLOAD
--------------------------------------------------------

  CREATE TABLE "PREMIER"."SYS_FILE_UPLOAD" 
   (	"FILESEQ" NUMBER(8,0), 
	"FILETYPECD" VARCHAR2(50 BYTE), 
	"FILENAME" VARCHAR2(200 BYTE), 
	"TEMPFILENAME" VARCHAR2(200 BYTE), 
	"LINKTYPECD" VARCHAR2(50 BYTE), 
	"LINKID" VARCHAR2(200 BYTE), 
	"CONTENTTYPE" VARCHAR2(200 BYTE), 
	"FULLFILENAME" VARCHAR2(1000 BYTE), 
	"REALFILENAME" VARCHAR2(1000 BYTE), 
	"ACTIVEFLAG" VARCHAR2(1 BYTE), 
	"CREATE_ACC_NO" VARCHAR2(50 BYTE), 
	"CREATE_DATE" DATE DEFAULT SYSDATE, 
	"UPDATE_ACC_NO" VARCHAR2(50 BYTE), 
	"UPDATE_DATE" DATE, 
	"FILECOMMENT" VARCHAR2(2000 BYTE), 
	"FILESIZE" NUMBER(10,0), 
	"FILEPATH" VARCHAR2(1000 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 2097152 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "PREMIER_DAT" ;

   COMMENT ON COLUMN "PREMIER"."SYS_FILE_UPLOAD"."FILESEQ" IS '파일순번';
   COMMENT ON COLUMN "PREMIER"."SYS_FILE_UPLOAD"."FILETYPECD" IS '파일분류';
   COMMENT ON COLUMN "PREMIER"."SYS_FILE_UPLOAD"."FILENAME" IS '파일명';
   COMMENT ON COLUMN "PREMIER"."SYS_FILE_UPLOAD"."TEMPFILENAME" IS '임시파일명';
   COMMENT ON COLUMN "PREMIER"."SYS_FILE_UPLOAD"."LINKTYPECD" IS '첨부 테이블 링크 정보';
   COMMENT ON COLUMN "PREMIER"."SYS_FILE_UPLOAD"."LINKID" IS '첨부 테이블 순번 정보';
   COMMENT ON COLUMN "PREMIER"."SYS_FILE_UPLOAD"."CONTENTTYPE" IS 'Content Type';
   COMMENT ON COLUMN "PREMIER"."SYS_FILE_UPLOAD"."FULLFILENAME" IS 'FULL 파일 이름';
   COMMENT ON COLUMN "PREMIER"."SYS_FILE_UPLOAD"."REALFILENAME" IS '실제 파일 이름';
   COMMENT ON COLUMN "PREMIER"."SYS_FILE_UPLOAD"."ACTIVEFLAG" IS '유효 FLAG';
   COMMENT ON COLUMN "PREMIER"."SYS_FILE_UPLOAD"."CREATE_ACC_NO" IS '등록자계정';
   COMMENT ON COLUMN "PREMIER"."SYS_FILE_UPLOAD"."CREATE_DATE" IS '등록일';
   COMMENT ON COLUMN "PREMIER"."SYS_FILE_UPLOAD"."UPDATE_ACC_NO" IS '수정자';
   COMMENT ON COLUMN "PREMIER"."SYS_FILE_UPLOAD"."UPDATE_DATE" IS '수정일';
   COMMENT ON COLUMN "PREMIER"."SYS_FILE_UPLOAD"."FILECOMMENT" IS '파일설명';
   COMMENT ON COLUMN "PREMIER"."SYS_FILE_UPLOAD"."FILESIZE" IS '파일크기';
   COMMENT ON COLUMN "PREMIER"."SYS_FILE_UPLOAD"."FILEPATH" IS '파일경로';
   COMMENT ON TABLE "PREMIER"."SYS_FILE_UPLOAD"  IS '파일업로드관리';
