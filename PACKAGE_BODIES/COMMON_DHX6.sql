--------------------------------------------------------
--  DDL for Package Body COMMON_DHX6
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "PREMIER"."COMMON_DHX6" 
IS
  v_selected   varchar2(100);
  
procedure list_company (
    p_type in varchar2 default 'N',
    p_lang in varchar2 default common.get_cookie('SYSLANG')
  )
  is
    cursor cur is
      select  '{'||'"value" : "'||code||'",
                  "content" : "'||name||'"}' as json_obj
      from    master_language
      where   companycd = '00'
      and     tableid = 'XM001'
      and     code in ('00', '02')
      and     lang = p_lang
      order by  code;
        
    type r02 is table of cur%rowtype index by pls_integer;
    rec r02;
    
    v_attr varchar2(50) := null;
    
    v_data varchar2(32767) := '';
      
  begin
  

    open cur;
    fetch cur bulk collect into rec;
    close cur;
    
     if p_type = 'A' then -- 전체
      v_data := '{'||'"value" : "", "content" : "'||get_fn('전체')||'"},';
    elsif p_type = 'S' then -- 선택
      v_data := '{'||'"value" : "", "content" : "'||get_fn('선택하세요.')||'"},';
    end if;
    
    for i in 1 .. rec.count loop
      v_data := v_data||rec(i).json_obj;
                  
      if i < rec.count then
      v_data := v_data||',';
      end if;
                  
    end loop;  
    
    htp.p(' ['||v_data||'] ');
        
  exception
    when others then
      htp.p('
      <span id="err" style="color: #ff0000;">'||sqlerrm||'</span>
      ');
  end list_company;
  
 
  
  
  
  procedure list_team (
    p_companycd in varchar2 default null,
    p_type in varchar2 default 'N'
  )
  is
    cursor cur is 
      select  '{'||'"value" : "'||teamcd||'",
                    "content" : "'||teamnm||'"}' as json_obj
      from    xm605 
      where   companycd = p_companycd
      order by  teamcd, teamnm; 
        
    type r02 is table of cur%rowtype index by pls_integer;
    rec r02;
    
    v_attr varchar2(50) := null;
    
    v_data varchar2(32767) := '';
      
  begin
  

    open cur;
    fetch cur bulk collect into rec;
    close cur;
    
     if p_type = 'A' then -- 전체
      v_data := '{'||'"value" : "", "content" : "'||get_fn('전체')||'"},';
    elsif p_type = 'S' then -- 선택
      v_data := '{'||'"value" : "", "content" : "'||get_fn('선택하세요.')||'"},';
    end if;
    
    for i in 1 .. rec.count loop
      v_data := v_data||rec(i).json_obj;
                  
      if i < rec.count then
      v_data := v_data||',';
      end if;
                  
    end loop;  
    
    htp.p(' ['||v_data||'] ');
        
  exception
    when others then
      htp.p('
      <span id="err" style="color: #ff0000;">'||sqlerrm||'</span>
      ');
  end list_team;

procedure list_kindcd(
  p_companycd in varchar2 default null,
  p_type in varchar2 default null
)
  is
    cursor cur is
      select  '{'||'"value" : "'||kindcd||'",
                  "content" : "'||kindnm||'"}' as json_obj
      from    xm000
      where   companycd = p_companycd
      ;
        
    type r02 is table of cur%rowtype index by pls_integer;
    rec r02;
    
    v_attr varchar2(50) := null;
    
    v_data varchar2(32767) := '';
      
  begin
  

    open cur;
    fetch cur bulk collect into rec;
    close cur;
    
     if p_type = 'A' then -- 전체
      v_data := '{'||'"value" : "", "content" : "'||get_fn('전체')||'"},';
    elsif p_type = 'S' then -- 선택
      v_data := '{'||'"value" : "", "content" : "'||get_fn('선택하세요.')||'"},';
    end if;
    
    for i in 1 .. rec.count loop
      v_data := v_data||rec(i).json_obj;
                  
      if i < rec.count then
      v_data := v_data||',';
      end if;
                  
    end loop;  
    
    htp.p(' ['||v_data||'] ');
        
  exception
    when others then
      htp.p('
      <span id="err" style="color: #ff0000;">'||sqlerrm||'</span>
      ');
  end list_kindcd;

procedure list_catalog (
    p_systemcd in varchar2, 
    p_catalogcd in varchar2,
    p_type in varchar2 default 'N',
    p_lang in varchar2 default common.get_cookie('SYSLANG')
  )
  is
   v_data varchar2(32767) := '';

cursor fnd_cur is
    SELECT  '{'||'"value" : "'||listvalue||'",
                  "content" : "'||listdescr||'"}' as json_obj
    FROM    C_0051 A
    WHERE   SYSTEMCD = p_systemcd
    AND     CATALOGCD = p_catalogcd
    AND     USEYN = 'Y'
    AND     LANG = p_lang
    --협력사 탭 제외
    AND     NOT EXISTS (  SELECT 1
                          FROM C_0051
                          WHERE 1=1
                          AND   SYSTEMCD = A.SYSTEMCD
                          AND   CATALOGCD = A.CATALOGCD
                          AND   LANG = A.LANG
                          AND   LISTVALUE = A.LISTVALUE
                          AND   SYSTEMCD = 'COM'
                          AND   CATALOGCD = 'SYSROOT_NM'
                          AND   LANG = p_lang
                          AND   USEYN = 'Y'
                          AND   (
                                  (common.get_cookie('SYSTYPE') = '0' AND 1=2) OR
                                  (common.get_cookie('SYSTYPE') = '1' AND LISTVALUE IN ('16','36')) --16:SYSTEM, 36:EIS
                                )
                       )
    ORDER BY LISTORDER
    ;

-- 기본값 N.    
cursor fnd_cur_n is
    SELECT  '{'||'"value" : "'||listvalue||'",
                  "content" : "'||listdescr||'"}' as json_obj
    FROM    C_0051 A
    WHERE   SYSTEMCD = p_systemcd
    AND     CATALOGCD = p_catalogcd
    AND     USEYN = 'Y'
    AND     LANG = p_lang
    --협력사 탭 제외
    AND     NOT EXISTS (  SELECT 1
                          FROM C_0051
                          WHERE 1=1
                          AND   SYSTEMCD = A.SYSTEMCD
                          AND   CATALOGCD = A.CATALOGCD
                          AND   LANG = A.LANG
                          AND   LISTVALUE = A.LISTVALUE
                          AND   SYSTEMCD = 'COM'
                          AND   CATALOGCD = 'SYSROOT_NM'
                          AND   LANG = p_lang
                          AND   USEYN = 'Y'
                          AND   (
                                  (common.get_cookie('SYSTYPE') = '0' AND 1=2) OR
                                  (common.get_cookie('SYSTYPE') = '1' AND LISTVALUE IN ('16','36')) --16:SYSTEM, 36:EIS
                                )
                       )
    ORDER BY LISTORDER desc
    ;
    
    type r01 is table of fnd_cur%rowtype index by pls_integer;
    rec r01;

begin 
    if p_type='Z' then
        open fnd_cur_n;
        fetch fnd_cur_n bulk collect into rec;
        close fnd_cur_n;
    else
        open fnd_cur;
        fetch fnd_cur bulk collect into rec;
        close fnd_cur;
    end if;
      
    if p_type = 'A' then -- 전체
      v_data := '{'||'"value" : "", "content" : "'||get_fn('전체')||'"},';
    elsif p_type = 'S' then -- 선택
      v_data := '{'||'"value" : "", "content" : "'||get_fn('선택하세요.')||'"},';
    end if;
    
    for i in 1 .. rec.count loop
      v_data := v_data||rec(i).json_obj;
                  
      if i < rec.count then
      v_data := v_data||',';
      end if;
                  
    end loop;  
  
    htp.p(' ['||v_data||'] ');
    
  end list_catalog;
  
  procedure list_catalog_select (
    p_systemcd in varchar2, 
    p_catalogcd in varchar2,
    p_type in varchar2 default 'N',
    p_value in varchar2
  )
  is
   v_data varchar2(32767) := '';

cursor fnd_cur is
    SELECT  '{'||'"value" : "'||listvalue||'",
                  "content" : "'||listdescr||'"}' as json_obj
    FROM    C_0051
    WHERE   SYSTEMCD = p_systemcd
    AND     CATALOGCD = p_catalogcd
    AND     USEYN = 'Y'
    AND     LANG = 'KO'
    AND     listvalue LIKE p_value||'%'  
    ORDER BY LISTORDER
    ;
    
    type r01 is table of fnd_cur%rowtype index by pls_integer;
    rec r01;

begin 
    open fnd_cur;
    fetch fnd_cur bulk collect into rec;
    close fnd_cur;
      
    if p_type = 'A' then -- 전체
      v_data := '{'||'"value" : "", "content" : "'||get_fn('전체')||'"},';
    elsif p_type = 'S' then -- 선택
      v_data := '{'||'"value" : "", "content" : "'||get_fn('선택하세요.')||'"},';
    end if;
    
    for i in 1 .. rec.count loop
      v_data := v_data||rec(i).json_obj;
                  
      if i < rec.count then
      v_data := v_data||',';
      end if;
                  
    end loop;  
  
    htp.p(' ['||v_data||'] ');
    
  end list_catalog_select;
  
  procedure radio_catalog (
    p_systemcd in varchar2, 
    p_catalogcd in varchar2,
    p_align in varchar2,
    p_labelposition in varchar2,
    p_labelwidth in varchar2
  )
  is
   v_data varchar2(32767) := '';

cursor fnd_cur is
    SELECT  '{'||'"type" : "radioButton", "label" : "'||listdescr||'", "value" : "'||listvalue||'", "labelPosition" : "'||p_labelposition||'", "labelWidth" : "'||p_labelwidth||'", "gravity" : "false" }' as json_obj
    FROM    C_0051
    WHERE   SYSTEMCD = p_systemcd
    AND     CATALOGCD = p_catalogcd
    AND     USEYN = 'Y'
    AND     LANG = 'KO'
    ORDER BY LISTORDER
    ;
    
    type r01 is table of fnd_cur%rowtype index by pls_integer;
    rec r01;

begin 
    open fnd_cur;
    fetch fnd_cur bulk collect into rec;
    close fnd_cur;
       
    
    for i in 1 .. rec.count loop
      v_data := v_data||rec(i).json_obj;
                  
      if i < rec.count then
      v_data := v_data||',';
      end if;
                  
    end loop;  
   
    
    htp.p('{align: "'||p_align||'", cols:['||v_data||']}');
    
  end radio_catalog;
  
  PROCEDURE list_form_type 
  ( 
      p_gbn in varchar2 default null 
  )  
   IS  
      CURSOR cur  
      IS  
        select  '{'||'"value" : "'||listvalue||'",
                      "content" : "'||listdescr||'"}' as json_obj 
        from( 
                SELECT  listvalue, listdescr  
                FROM    c_0051  
                WHERE   systemcd = 'FMS'  
                AND     catalogcd = 'HEAD_FORM'   
                AND     listvalue LIKE p_gbn||'%'  
                AND     lang = common.get_cookie ('SYSLANG')  
                AND     USEYN='Y'
                ORDER BY listvalue 
         );  
          
    type r01 is table of cur%rowtype index by pls_integer;
    rec r01;
    
    v_attr varchar2(50) := null; 
    v_data varchar2(32767) := ''; 
    
  begin   
    
    open cur;
    fetch cur bulk collect into rec;
    close cur;
    
    v_data := '{'||'"value" : "", "content" : "'||get_fn('선택하세요.')||'"},';
       
    for i in 1 .. rec.count loop
      v_data := v_data||rec(i).json_obj;
                  
      if i < rec.count then
      v_data := v_data||',';
      end if;
                  
    end loop;  
    
    htp.p(' ['||v_data||'] ');
        
   EXCEPTION  
      WHEN OTHERS  
      THEN  
         NULL;  
   END;

  
END;

/
