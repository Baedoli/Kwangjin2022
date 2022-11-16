--------------------------------------------------------
--  DDL for Table C_0010
--------------------------------------------------------

  CREATE TABLE "PREMIER"."C_0010" 
   (	"COMPANYCD" VARCHAR2(2 BYTE), 
	"GUBUN" VARCHAR2(1 BYTE), 
	"XUSER" VARCHAR2(20 BYTE), 
	"PASS" VARCHAR2(20 BYTE), 
	"PYMD" DATE, 
	"XUSERNM" VARCHAR2(52 BYTE), 
	"USEYN" VARCHAR2(1 BYTE) DEFAULT 'Y', 
	"TEAMCD" VARCHAR2(6 BYTE), 
	"EMAIL" VARCHAR2(50 BYTE), 
	"MOBILE" VARCHAR2(30 BYTE), 
	"XUSERNM_ENG" VARCHAR2(100 BYTE), 
	"JIKUP" VARCHAR2(10 BYTE), 
	"C_0010_ID" VARCHAR2(30 BYTE), 
	"LANG" VARCHAR2(2 BYTE), 
	"RANKID" VARCHAR2(20 BYTE), 
	"EFAM_ID" VARCHAR2(50 BYTE), 
	"MERGE_TEAMCD" VARCHAR2(20 BYTE), 
	"MAIL_ID" VARCHAR2(40 BYTE), 
	"C_0010_COMP" VARCHAR2(10 BYTE), 
	"MESSENGER_ID" VARCHAR2(20 BYTE), 
	"PHONENO" VARCHAR2(30 BYTE), 
	"GIVEN_NAME" VARCHAR2(200 BYTE), 
	"FAMILY_NAME" VARCHAR2(200 BYTE), 
	"IP_PHONENO" VARCHAR2(30 BYTE), 
	"PERSONAL_EMAIL" VARCHAR2(50 BYTE), 
	"LOGIN_YMD" DATE, 
	"LOGIN_ID" VARCHAR2(20 BYTE), 
	"M365_TYPE" VARCHAR2(10 BYTE), 
	"B_DAY" VARCHAR2(15 BYTE), 
	"PASS_FAILURE" NUMBER DEFAULT 0
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 1048576 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "PREMIER_DAT" ;

   COMMENT ON COLUMN "PREMIER"."C_0010"."COMPANYCD" IS '광진구분 (00.광진상공, 01.광진기계)';
   COMMENT ON COLUMN "PREMIER"."C_0010"."GUBUN" IS '0:내부사번 1:업체코드';
   COMMENT ON COLUMN "PREMIER"."C_0010"."XUSER" IS '로그인코드';
   COMMENT ON COLUMN "PREMIER"."C_0010"."PASS" IS '패스워드';
   COMMENT ON COLUMN "PREMIER"."C_0010"."PYMD" IS '패스워드변경일';
   COMMENT ON COLUMN "PREMIER"."C_0010"."XUSERNM" IS '로그인명(Local)';
   COMMENT ON COLUMN "PREMIER"."C_0010"."USEYN" IS '사용유무 (Y.사용  N.사용안함)';
   COMMENT ON COLUMN "PREMIER"."C_0010"."TEAMCD" IS '팀코드(XM604-XM605)';
   COMMENT ON COLUMN "PREMIER"."C_0010"."EMAIL" IS '메일';
   COMMENT ON COLUMN "PREMIER"."C_0010"."MOBILE" IS '핸퐁';
   COMMENT ON COLUMN "PREMIER"."C_0010"."XUSERNM_ENG" IS '사용자명_(공용)';
   COMMENT ON COLUMN "PREMIER"."C_0010"."JIKUP" IS '직급';
   COMMENT ON COLUMN "PREMIER"."C_0010"."C_0010_ID" IS '연결부분 (Gubun 0: HR1000T , Gubun 1: CM0070T)';
   COMMENT ON COLUMN "PREMIER"."C_0010"."LANG" IS '언어';
   COMMENT ON COLUMN "PREMIER"."C_0010"."MERGE_TEAMCD" IS '파트연결';
   COMMENT ON COLUMN "PREMIER"."C_0010"."C_0010_COMP" IS 'ERP등록사업장';
   COMMENT ON COLUMN "PREMIER"."C_0010"."MESSENGER_ID" IS '메시지 ID';
   COMMENT ON COLUMN "PREMIER"."C_0010"."PHONENO" IS '내선번호';
   COMMENT ON COLUMN "PREMIER"."C_0010"."GIVEN_NAME" IS '이름';
   COMMENT ON COLUMN "PREMIER"."C_0010"."FAMILY_NAME" IS '성';
   COMMENT ON COLUMN "PREMIER"."C_0010"."IP_PHONENO" IS 'IPT전화';
   COMMENT ON COLUMN "PREMIER"."C_0010"."PERSONAL_EMAIL" IS '대체_이메일';
   COMMENT ON COLUMN "PREMIER"."C_0010"."M365_TYPE" IS 'M365 제품군';
   COMMENT ON COLUMN "PREMIER"."C_0010"."B_DAY" IS '생일(비밀번호초기화확인용:YYYY.MM.DD)';
   COMMENT ON COLUMN "PREMIER"."C_0010"."PASS_FAILURE" IS '로그인실패횟수';
   COMMENT ON TABLE "PREMIER"."C_0010"  IS '로그인 마스타';