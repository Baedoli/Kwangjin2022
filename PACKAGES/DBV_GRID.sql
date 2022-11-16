--------------------------------------------------------
--  DDL for Package DBV_GRID
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "PREMIER"."DBV_GRID" 
IS

  PROCEDURE print_env_v451;
  PROCEDURE print_env_v652;
  PROCEDURE print_env_rev;
  
  v_number number := 0;
  default_skin varchar2(50) := 'dhx_web';

END DBV_GRID;

/
