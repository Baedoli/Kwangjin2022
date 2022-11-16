--------------------------------------------------------
--  DDL for Package Body COMC0040
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "PREMIER"."COMC0040" 
IS
  PROCEDURE control
  (
    p_systemcd in varchar2 default 'COM',  
    p_pgm_gb in varchar2 default null,
    p_descr in varchar2 default null
  )
  IS
  
  BEGIN
  htp.p('
  <!DOCTYPE HTML>
  <html lang="ko">
  <head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta charset="UTF-8">
    <title>'||common.title||'</title> ');
    dbv_grid.print_env_v451;
    htp.p('
    <script>
      var myLayout;
      var sbObj;
      
      function doOnLoad() {
        window.dhx4.ajax.cache = true;
        myLayout = new dhtmlXLayoutObject(document.body, "1C","dhx_skyblue");
          
        myLayout.cells("a").setText("■ Sample");
        myLayout.cells("a").hideHeader();
        myLayout.cells("a").fixSize(true, true);
        mygrid = myLayout.cells("a").attachGrid();
        mygrid.preventIECaching(false);
        var v_url_a = "'||v_pkg||'.query_a?"+$("#form1").serialize();
        myLayout.cells("a").progressOn();
        myLayout.cells("a").attachURL(v_url_a);
        attachHeader();
        attachStatusBar();
        sbObj.setText("'||get_fn('자료검색중')||'..");
      }
      
      function attachHeader() {
        myLayout.attachHeader("top-header");
      }
      
      function attachStatusBar() {
        if (sbObj != null) return;
        sbObj = myLayout.attachStatusBar({text:""}); 
      }
      
      function setStatusBarText(rowCount)
      {
        sbObj.setText("'||get_fn('자료검색을 종료합니다..')||'"+ rowCount +" '||get_fn('건이 검색되었습니다.')||'");
      }
      
      function doQuery() {
        document.getElementById("form1").submit();
      }
      
      function doCrrec()  
      {  
        var url = "'||v_pkg||'.crrec?";  
        newWnd2 = window.open(url,"'||v_pkg||'window","top=100, left=100, status=yes, resizable=no, scrollbars=yes, width=1000, height=485");  
        newWnd2.focus();
      } 
      
      $(function() {
        doOnLoad();  
        
        $(window).on("resize", function(){
          myLayout.detachHeader();
          attachHeader();
        });
              
      });
      
    </script>
  </head>
  <body>
  <div id="top-header" style="padding-bottom: 2px;background-color: #ffffff;">
    <form id="form1" name="form1" method="post" action="'||v_pkg||'.control">
    <div id="c00">
      <div id="c01">
      
        <div class="cBox">
          <div class="cTitle"><label for="p_systemcd">'||get_fn('시스템')||'</label></div>
          <div class="cInput">
            <select name="p_systemcd" id="p_systemcd"">
            ');
            common.list_systemcd(p_systemcd, 'a');
            HTP.P('
            </select>
          </div>
        </div>
        <div class="cBox">
          <div class="cTitle"><label for="p_pgm_gb">'||get_fn('구분')||'</label></div>
          <div class="cInput">
          '); common.list_catalog('COM','PGM_GB',p_pgm_gb,'select', null, 'p_pgm_gb', 'a', 'yes'); htp.p('
          </div>
        </div>
        <div class="cBox">
          <div class="cTitle"><label for="p_descr">'||get_fn('검색어')||'</label></div>
          <div class="cInput">
            <input type="text" name="p_descr" id="p_descr" value="'||p_descr||'"> 
          </div>
        </div>  
            
      </div>
      <div id="c11">
        <a href="#" target="list" onclick="doQuery(); return false;" class="btn-search buttons">'||get_fn('조회')||'</a>
      </div>
      <div class="crlf"></div>
    </div>
    <div id="c22">
      <div class="floatL">
        
      </div>
      <div class="floatR">
        <a href="#" target="list" onclick="doCrrec(); return false;" class="btn-new buttons">'||get_fn('신규')||'</a>
      </div>
      <div class="crlf"></div>
    </div>
    </form>
  </div>
  </body>
  </html> 
  ');
  EXCEPTION
    when others then
      show_err('control');
  END control;
  
  PROCEDURE query_a
  (
    p_systemcd in varchar2 default null,
    p_pgm_gb in varchar2 default null,
    p_descr in varchar2 default null
  )
  IS
    
  BEGIN    
  htp.p('
  <!DOCTYPE html">
  <html lang="ko">
    <head>
      <title>'||common.title||'</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta http-equiv="Content-Type" content="application/xhtml+xml; charset=utf-8" />  
        '); dbv_grid.print_env_v451; htp.p('
        <script type="text/javascript">
        
          function doInitGrid(){
            mygrid = new dhtmlXGridObject("mygrid_obj");
            mygrid.setImagePath("/grid451/skins/web/imgs/dhxgrid_web/");
            var v_header="";
            var w_header="";
            var v_width="";
            var v_align="";
            var v_types="";
            var v_sorting="";
            var v_tooltip="";
            var x = new Array(9);
            var cm = "";
            var i = 0;     
            
            x[i]=["'||get_fn('구분')||'", "80","center","ro","str","true"];i++;
            x[i]=["'||get_fn('프로그램 ID')||'", "178","center","link","str","true"];i++;
            x[i]=["'||get_fn('프로그램 개요')||'", "198","center","ro","str","true"];i++;
            x[i]=["'||get_fn('한국어')||'", "198","center","ro","str","true"];i++;
            x[i]=["'||get_fn('영어')||'", "198","center","ro","str","true"];i++;
            x[i]=["'||get_fn('중국어')||'", "198","center","ro","str","true"];i++;
            x[i]=["'||get_fn('스페인어')||'", "198","center","ro","str","true"];i++;
            x[i]=["'||get_fn('사용여부')||'", "78","center","ro","str","true"];i++;
            x[i]=["'||get_fn('ID')||'", "42","center","ro","str","true"];i++;

            for(j=0;j<i;j++){
              if(j==0) cm="";
              else cm=",";
              v_header=v_header+cm+x[j][0];
              v_width=v_width+cm+x[j][1];
              v_align=v_align+cm+x[j][2];
              v_types=v_types+cm+x[j][3];
              v_sorting=v_sorting+cm+x[j][4];
              v_tooltip=v_tooltip+cm+x[j][5];
            }
            
            mygrid.setHeader(v_header);
            mygrid.setInitWidths(v_width);
            mygrid.setColAlign(v_align);
            mygrid.setColTypes(v_types);
            mygrid.enableColumnMove(true);
            mygrid.enableCollSpan(false);
            mygrid.enableTooltips(v_tooltip);
            mygrid.setColSorting(v_sorting);
            mygrid.enableEditEvents(false,true,false);
            mygrid.enableRowsHover(true,"grid_hover");
            mygrid.init();
            mygrid.enableHeaderMenu();
            mygrid.enableDistributedParsing(true,10,300);
            mygrid.preventIECaching(false);
            mygrid.setSkin("dhx_web");
            var url = "'||v_pkg||'.query_a_data"+window.location.search;
            mygrid.load(url, "json");
            mygrid.attachEvent("onXLE", function() {
              parent.setStatusBarText(mygrid.getRowsNum());
              parent.myLayout.cells("a").progressOff();
            }); 
          }
        
          function doOnRowSelected(rowID,celInd){
            var companycd = mygrid.cells(rowID,0).getValue();
            var vendcd = mygrid.cells(rowID,1).getValue();
            var partno = mygrid.cells(rowID,2).getValue();
            var v_url_b = "'||v_pkg||'.query_b?p_companycd="+companycd+"&p_vendcd="+vendcd+"&p_partno="+partno;
            parent.myLayout.cells("b").attachURL(v_url_b);
          }
          
          function link_(obj1, obj2){
            url ="'||v_pkg||'.crrec?p_systemcd="+obj1+"&p_pgmid="+obj2;
            newWnd2 = window.open(url,"'||v_pkg||'window","top=100, left=100, status=yes, resizable=no, scrollbars=yes, width=1000, height=485");  
            newWnd2.focus();
          }
          
          $(function() {
            doInitGrid();
          });
          
        </script>
      </head>
    <body>
      <div id="mygrid_obj" style="width:100%;height:100%;"></div>
    </body>
  </html> ');
  EXCEPTION
    WHEN OTHERS THEN
      show_err('query_a');
  END query_a;
  
  PROCEDURE query_a_data
  (
    p_systemcd in varchar2 default null,
    p_pgm_gb in varchar2 default null,
    p_descr in varchar2 default null
  )
  IS
  
    cursor cur is
      select  systemcd, pgm_gb, pgmid, descr, useyn, id_
      from    c_0040
      where   nvl(systemcd, '*') = nvl(p_systemcd, nvl(systemcd, '*'))
      and     nvl(pgm_gb, '*') = nvl(p_pgm_gb, nvl(pgm_gb, '*'))
      and     upper(nvl(descr, '*')) like upper('%'||p_descr||'%')
      ;

    type r is table of cur%rowtype index by pls_integer;
    rec r;
    
    v_number number := 0 ;
    v_link varchar2(4096) := null;

    v_ko        varchar2(1000); 
    v_en        varchar2(1000);   
    v_ch        varchar2(1000);   
    v_sp        varchar2(1000); 
    
  BEGIN
  
    owa_util.mime_header('application/json');

    open cur;
    fetch cur bulk collect into rec;
    close cur;
    
    htp.p('{rows:[ ');
    v_number := rec.count;
    for i in 1 .. v_number loop
    
      v_link := '^javascript:link_(\"'||rec(i).systemcd||'\", \"'||rec(i).pgmid||'\")^_self';
      v_ko:=GET_PROGRAM_NAME(rec(i).systemcd, rec(i).pgmid, 'KO');   
      v_en:=GET_PROGRAM_NAME(rec(i).systemcd, rec(i).pgmid, 'EN');   
      v_sp:=GET_PROGRAM_NAME(rec(i).systemcd, rec(i).pgmid, 'SP');   
      v_ch:=GET_PROGRAM_NAME(rec(i).systemcd, rec(i).pgmid, 'CH');   
            
      htp.p('
      { id:' ||i|| ',
        data:[
          {value:"'||get_catalog_name('COM','pgm_gb',v_lang,rec(i).pgm_gb)||'"},
          {value:"'||rec(i).pgmid||v_link||'"},
          {value:"'||rec(i).descr||'"},
          {value:"'||return_html_text(v_ko)||'"}, 
          {value:"'||return_html_text(v_en)||'"}, 
          {value:"'||return_html_text(v_ch)||'"},   
          {value:"'||return_html_text(v_sp)||'"},   
          {value:"'||rec(i).useyn||'"},
          {value:"'||rec(i).id_||'"},
        ]
      } ');
            
      if i < v_number then
        htp .p(',');
      end if;
      
    end loop;
    
    if v_number = 0 then
      htp .p('{[]}');
    end if;
    
    htp.p(']}');
  EXCEPTION
    when others then
      show_err('query_a_data'); 
  END query_a_data;
  
  PROCEDURE crrec
  (
    p_systemcd in varchar2 default null,
    p_pgmid in varchar2 default null
  )
  IS
  
    cursor cur is
      select  systemcd, pgmid, descr, useyn, pgm_gb
      from    c_0040
      where   1=1
      and     systemcd = p_systemcd
      and     pgmid = p_pgmid
      ;
      
    rec cur%rowtype;
  
    cursor cur2 (p_lang in varchar2) is   
      select  pgmnm   
      from    c_0041   
      where   systemcd = p_systemcd   
      and     pgmid = p_pgmid   
      and     lang = p_lang;   
           
    v_pgmnm c_0041.pgmnm%type;   
        
    v_disabled varchar2(20);

  BEGIN  
        
    open cur;
    fetch cur into rec;
    close cur;
    
    if rec.systemcd is not null then
      v_disabled := 'disabled="disabled"';
    else
      v_disabled := '';
    end if;
    
    htp.p('
    <!DOCTYPE HTML>
    <html lang="ko">
    <head>
      <meta charset="UTF-8">
      <title>'||common.title||'</title> ');
      dbv_grid.print_env_rev;
      htp.p('      
      <script type="text/javascript">   
      
        function proc_save() {
          var thisForm = document.getElementById("form1");
          
          //필수값 체크
          if(!formRquried()){
            return false;  
          }     
 
          if (!confirm("'||get_fn('저장하시겠습니까?')||'")) return false;
          $("#p_systemcd").removeAttr("disabled");
          $("#p_pgmid").removeAttr("disabled");
          thisForm.p_dml_gubun.value = "1";
          thisForm.submit(); 
        }    

        function proc_del() {    
          var thisForm = document.getElementById("form1");
    
          if (!confirm("'||get_fn('삭제하시겠습니까?')||'")) return false;    
          $("#p_systemcd").removeAttr("disabled");
          $("#p_pgmid").removeAttr("disabled");
          thisForm.p_dml_gubun.value = "2";    
          thisForm.submit();   
        } 
      
      </script>      
    </head>    
    <body>                
      <form id="form1" name="form1" action="'||v_pkg||'.process" method="post" >
      <input type="hidden" id="p_dml_gubun" name="p_dml_gubun" value="" />
        <!-- 신규 Form Setting S -->
        <div class="formWrap">
        
          <!--상단타이틀/버튼-->
          <div class="formTop">
            <div class="formTitle">'||get_program_name('SYS',v_pkg,v_lang)||'</div>
            <div class="btnbar">

              <a href="#" class="btn-save buttons" onclick="proc_save(); return false;">'||get_fn('저장')||'</a>&nbsp;
              <a href="#" class="btn-delete buttons" onclick="proc_del(); return false;">'||get_fn('삭제')||'</a>&nbsp;
              <a href="#" class="btn-close buttons" onclick="self.close(); return false;">'||get_fn('닫기')||'</a>
            </div>
          </div>
          
          <!--테이블입력-->
          <div>
            <table width="100%" border="0" cellspacing="0" cellpadding="4">
              <tbody>
              
                <tr>
                  <td class="titletd require">'||get_fn('시스템')||'</td>
                  <td class="inputtd">
                    <select id="p_systemcd" name="p_systemcd" '||v_disabled||' >
                      '); common.list_systemcd(p_systemcd, 'c');  htp.p('
                    </select>  
                    </td>
                    <td></td><td></td>
                </tr>
                <tr>
                  <td class="titletd require">'||get_fn('프로그램 ID')||'</td>
                  <td class="inputtd">
                    <input type="text" id="p_pgmid" name="p_pgmid" '||v_disabled||' value="'||rec.pgmid||'" /> 
                  </td>
                  <td class="titletd">'||get_fn('프로그램 개요')||'</td>
                  <td class="inputtd">
                    <input type="text" id="p_descr" name="p_descr" value="'||rec.descr||'" / > 
                  </td>
                </tr>
                <tr>
                  <td class="titletd require">'||get_fn('구분')||'</td>
                  <td class="inputtd">
                    '); common.list_catalog('COM','pgm_gb',rec.pgm_gb,'select', null, 'p_pgm_gb', 'c', 'yes'); htp.p(' 
                  </td>
                  <td class="titletd require">'||get_fn('사용여부')||'</td>
                  <td class="inputtd">
                    '); common.list_catalog('COM','USEYN',rec.useyn,'select', null, 'p_useyn', 'c', 'yes'); htp.p(' 
                  </td>
                </tr>
                <tr>
                  <td class="titletd">'||get_fn('한국어')||'</td>
                  <td class="inputtd" colspan="4">
                    ');   
                    v_pgmnm := null;   
                    
                    open cur2('KO');   
                    fetch cur2 into v_pgmnm;   
                    close cur2;   
                    
                    htp.p('   
                    <input type="text" id="p_ko" name="p_ko" value="'||v_pgmnm||'" /> 
                  </td>
                 <td></td>
                </tr>
                <tr>
                  <td class="titletd">'||get_fn('영어')||'</td>
                  <td class="inputtd" colspan="4">
                    ');   
                    v_pgmnm := null;   
                    
                    open cur2('EN');   
                    fetch cur2 into v_pgmnm;   
                    close cur2;   
                    
                    htp.p('   
                    <input type="text" id="p_en" name="p_en" value="'||v_pgmnm||'" /> 
                  </td>
                  <td></td> <td></td>
                </tr>
                <tr>
                  <td class="titletd">'||get_fn('중국어')||'</td>
                  <td class="inputtd" colspan="4">
                    ');   
                    v_pgmnm := null;   
                    
                    open cur2('CH');   
                    fetch cur2 into v_pgmnm;   
                    close cur2;   
                    
                    htp.p('   
                    <input type="text" id="p_ch" name="p_ch" value="'||v_pgmnm||'" /> 
                  </td>
                  <td></td> <td></td>
                </tr>
                <tr>
                  <td class="titletd">'||get_fn('스페인어')||'</td>
                  <td class="inputtd" colspan="4">
                    ');   
                    v_pgmnm := null;   
                    
                    open cur2('SP');   
                    fetch cur2 into v_pgmnm;   
                    close cur2;   
                    
                    htp.p('   
                    <input type="text" id="p_sp" name="p_sp" value="'||v_pgmnm||'" /> 
                  </td>
                  <td></td> <td></td>
                </tr>
                <tr>
                  <td class="titletd">'||get_fn('폴란드어')||'</td>
                  <td class="inputtd" colspan="4">
                    ');   
                    v_pgmnm := null;   
                    
                    open cur2('PO');   
                    fetch cur2 into v_pgmnm;   
                    close cur2;   
                    
                    htp.p('   
                    <input type="text" id="p_po" name="p_po" value="'||v_pgmnm||'" /> 
                  </td>
                  <td></td> <td></td>
                </tr>
                <tr>
                  <td class="titletd">'||get_fn('베트남어')||'</td>
                  <td class="inputtd" colspan="4">
                    ');   
                    v_pgmnm := null;   
                    
                    open cur2('VN');   
                    fetch cur2 into v_pgmnm;   
                    close cur2;   
                    
                    htp.p('   
                    <input type="text" id="p_vn" name="p_vn" value="'||v_pgmnm||'" /> 
                  </td>
                  <td></td> <td></td>
                </tr>
                
              </tbody>
            </table>
          </div>
          
        </div>
        <!-- 신규 Form Setting E -->
      </form>    
    </body>    
  </html>    
    ' ); 
  EXCEPTION
    when others then
      show_err('crrec');
  END crrec;
  
  PROCEDURE process
  (
    p_systemcd in varchar2 default null,
    p_dml_gubun in varchar2 default null,
    p_pgmid in varchar2 default null,
    p_descr in varchar2 default null,
    p_useyn in varchar2 default null,
    p_pgm_gb in varchar2 default null,
    p_ko in varchar2 default null,
    p_en in varchar2 default null,
    p_ch in varchar2 default null,
    p_sp in varchar2 default null,
    p_po in varchar2 default null,
    p_vn in varchar2 default null
  )
    is
    
    cursor cur_max is   
    select  nvl(MAX(id_),0)+1   
    from    c_0040;    
     
    max_id  number:= 0; 
      
	BEGIN   
	 
    open cur_max;   
    fetch cur_max into max_id;   
    close cur_max;   
     
    if p_dml_gubun = '1' then
      
      BEGIN   
        INSERT INTO c_0040
        (systemcd, pgmid, descr, useyn, 
          deveymd, memo, pgm_gb, id_, content, pgm_explain)
        VALUES    
        (p_systemcd, upper(p_pgmid), p_descr, p_useyn,    
          to_char(sysdate, 'yyyymmdd'), null, p_pgm_gb, max_id, null, null);   
      EXCEPTION   
        WHEN dup_val_on_index THEN   
          UPDATE	c_0040   
          SET		  descr = p_descr,   
                  useyn = p_useyn, pgm_gb=p_pgm_gb   
          WHERE	  systemcd = p_systemcd   
          AND		  pgmid = upper(p_pgmid);   
        WHEN others THEN   
          show_err;    
      END;   
   
      if p_ko is not null then   
        BEGIN   
          INSERT INTO c_0041   
          (systemcd, pgmid, lang, pgmnm)   
          VALUES 
          (p_systemcd, upper(p_pgmid), 'KO', p_ko);   
        EXCEPTION   
          WHEN dup_val_on_index THEN   
            UPDATE    c_0041   
            SET       pgmnm = p_ko   
            WHERE     systemcd = p_systemcd   
            AND       pgmid = upper(p_pgmid)   
            AND       lang = 'KO';   
          WHEN others THEN   
            null;   
        END;   
      else   
        BEGIN   
          DELETE FROM c_0041   
          WHERE       systemcd = p_systemcd   
          AND         pgmid = upper(p_pgmid)   
          AND         lang = 'KO';   
        END;   
      end if;   
         
      if p_en is not null then   
        BEGIN   
          INSERT INTO c_0041   
          (systemcd, pgmid, lang, pgmnm)   
          VALUES   
          (p_systemcd, upper(p_pgmid), 'EN', p_en);   
        EXCEPTION   
          WHEN dup_val_on_index THEN   
            UPDATE    c_0041   
            SET       pgmnm = p_en   
            WHERE     systemcd = p_systemcd   
            AND       pgmid = upper(p_pgmid)   
            AND       lang = 'EN';   
          WHEN others THEN   
            null;   
        END;   
      else   
        BEGIN   
          DELETE FROM c_0041   
          WHERE       systemcd = p_systemcd   
          AND         pgmid = upper(p_pgmid)   
          AND         lang = 'EN';   
        END;   
      end if;   
   
      if p_ch is not null then   
        BEGIN   
          INSERT INTO c_0041   
          (systemcd, pgmid, lang, pgmnm)   
          VALUES   
          (p_systemcd, upper(p_pgmid), 'CH', p_ch);   
        EXCEPTION   
          WHEN dup_val_on_index THEN   
            UPDATE  c_0041   
            SET     pgmnm = p_ch   
            WHERE   systemcd = p_systemcd   
            AND     pgmid = upper(p_pgmid)   
            AND     lang = 'CH';   
          WHEN others THEN   
            null;   
        END;   
      else   
        BEGIN   
          DELETE FROM c_0041   
          WHERE       systemcd = p_systemcd   
          AND         pgmid = upper(p_pgmid)   
          AND         lang = 'CH';   
        END;   
      end if;   
   
      if p_sp is not null then   
        BEGIN   
          INSERT INTO c_0041   
          (systemcd, pgmid, lang, pgmnm)   
          VALUES   
          (p_systemcd, upper(p_pgmid), 'SP', p_sp);   
        EXCEPTION   
          WHEN dup_val_on_index THEN   
            UPDATE  c_0041   
            SET     pgmnm = p_sp   
            WHERE   systemcd = p_systemcd   
            AND     pgmid = upper(p_pgmid)   
            AND     lang = 'SP';   
          WHEN others THEN   
            null;   
        END;   
      else   
        BEGIN   
          DELETE FROM c_0041   
          WHERE       systemcd = p_systemcd   
          AND         pgmid = upper(p_pgmid)   
          AND         lang = 'SP';   
        END;   
      end if;     

      if p_po is not null then   
        BEGIN   
          INSERT INTO c_0041 
          (systemcd, pgmid, lang, pgmnm)   
          VALUES   
          (p_systemcd, upper(p_pgmid), 'PO', p_po);   
        EXCEPTION   
          WHEN dup_val_on_index THEN   
            UPDATE  c_0041   
            SET     pgmnm = p_po   
            WHERE   systemcd = p_systemcd   
            AND     pgmid = upper(p_pgmid)   
            AND     lang = 'PO';   
          WHEN others THEN   
            null;   
        END;   
      else   
        BEGIN   
          DELETE FROM c_0041   
          WHERE       systemcd = p_systemcd   
          AND         pgmid = upper(p_pgmid)   
          AND         lang = 'PO';   
        END;   
      end if;   
                               
      if p_vn is not null then   
        BEGIN   
          INSERT INTO c_0041
          (systemcd, pgmid, lang, pgmnm)   
          VALUES   
          (p_systemcd, upper(p_pgmid), 'VN', p_vn);   
        EXCEPTION   
          WHEN dup_val_on_index THEN   
            UPDATE  c_0041   
            SET     pgmnm = p_vn   
            WHERE   systemcd = p_systemcd   
            AND     pgmid = upper(p_pgmid)   
            AND     lang = 'VN';   
          WHEN others THEN   
            null;   
        END;   
      else   
        BEGIN   
          DELETE FROM c_0041   
          WHERE       systemcd = p_systemcd   
          AND         pgmid = upper(p_pgmid)   
          AND         lang = 'VN';   
        END;   
      end if; 
    
      htp.p('
      <script type="text/javascript">
        alert("'||get_fn( '저장되었습니다.')||'");
        opener.location.reload();
        location.href = "'||v_pkg||'.crrec?p_systemcd='||p_systemcd||'&p_pgmid='||p_pgmid||'";
      </script>
      ');
    
    elsif p_dml_gubun = '2' then
      
      DELETE FROM c_0041   
			WHERE       systemcd = p_systemcd   
			AND         pgmid = p_pgmid;   
				 
      DELETE FROM c_0040   
      WHERE       systemcd = p_systemcd   
      AND         pgmid = p_pgmid;   
    
      DELETE FROM c_0031   
      WHERE       systemcd = p_systemcd   
      AND         pgmid = p_pgmid;  
			
      htp.p(' 
      <script type="text/javascript"> 
        alert("' ||get_fn( '삭제되었습니다.')|| '"); 
        opener.location.reload();
        self.close(); 
      </script> 
      ');
  
    end if;
  
  EXCEPTION
    when others then 
      show_err('process');
  END process;
 
END COMC0040;

/
