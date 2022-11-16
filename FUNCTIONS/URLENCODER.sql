--------------------------------------------------------
--  DDL for Function URLENCODER
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "PREMIER"."URLENCODER" (P_STR IN VARCHAR2)
RETURN VARCHAR2
AS
    VTMP VARCHAR2(32767) := NULL;
    VLEN NUMBER DEFAULT LENGTH (P_STR);
    VBAD VARCHAR2(32767) DEFAULT ' >%}\~];?@&<#{|^[`/:=$+''"' || CHR (10);
    VCHAR VARCHAR2 (400) := NULL;
BEGIN
    IF (P_STR IS NULL) THEN
        RETURN NULL;
    END IF;

    FOR I IN 1 .. VLEN LOOP
        VCHAR := SUBSTR (P_STR, I, 1);
        IF (INSTR (VBAD, VCHAR) > 0)
        THEN
        VTMP := VTMP || '%' || TO_CHAR (ASCII (VCHAR), 'fm0X');
        ELSE
        VTMP := VTMP || VCHAR;
        END IF;
    END LOOP;
    
    RETURN VTMP;
EXCEPTION
    WHEN OTHERS THEN
        RETURN NULL;
END;

/
