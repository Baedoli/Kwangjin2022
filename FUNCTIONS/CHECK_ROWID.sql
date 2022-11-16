--------------------------------------------------------
--  DDL for Function CHECK_ROWID
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "PREMIER"."CHECK_ROWID" 
(P_ROWID IN VARCHAR2, P_CHECK IN VARCHAR2 ) RETURN VARCHAR2
IS
  V_NEW_ROWID VARCHAR2(20);
BEGIN

  IF P_CHECK = '1' THEN
     V_NEW_ROWID := REPLACE(REPLACE(REPLACE(P_ROWID,'+','~'),'/','`'),'%','$');
  ELSIF P_CHECK = '2' THEN
     V_NEW_ROWID := REPLACE(REPLACE(REPLACE(P_ROWID,'~','+'),'`','/'),'$','%');
  END IF;     

  RETURN (V_NEW_ROWID);
END;

/
