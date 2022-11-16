--------------------------------------------------------
--  DDL for Package Body KSCM7102
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "PREMIER"."KSCM7102" 
IS
  PROCEDURE control
  (
    p_companycd in varchar2 default common.get_cookie('SYSCOMP'),
    p_cli_code in varchar2 default common.get_cookie('CCODE')
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
      
      function setStatusBarText(rowCount) {
        sbObj.setText("'||get_fn('자료검색을 종료합니다..')||'"+ rowCount +" '||get_fn('건이 검색되었습니다.')||'");
      }
      
      function doQuery() {
        document.getElementById("form1").submit();
      }
      
      function doCrrec() {  
        var url = "'||v_pkg||'.crrec?p_companycd='||p_companycd||'&p_cli_code='||p_cli_code||'";  
        newWnd2 = window.open(url,"'||v_pkg||'window","top=100, left=100, status=yes, resizable=no, scrollbars=yes, width=1000, height=327");  
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
      <input type="hidden" id="p_companycd" name="p_companycd" value="'||p_companycd||'"/>
      <input type="hidden" id="p_cli_code" name="p_cli_code" value="'||p_cli_code||'"/>

    <div id="c00">
      <div id="c01">
      
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
    p_companycd in varchar2 default null,
    p_cli_code in varchar2 default null
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
            
            x[i]=["'||get_fn('순번')||'", "100","center","link","str","true"];i++;
            x[i]=["'||get_fn('부서')||'", "100","center","ro","str","true"];i++;
            x[i]=["'||get_fn('이름')||'", "130","center","ro","str","true"];i++;
            x[i]=["'||get_fn('전화번호')||'", "130","center","ro","str","true"];i++;
            x[i]=["'||get_fn('휴대전화')||'", "130","center","ro","str","true"];i++;
            x[i]=["'||get_fn('전자우편')||'", "130","center","ro","str","true"];i++;
            x[i]=["'||get_fn('메모')||'", "*","center","ro","str","true"];i++;
            
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
        
          function link_(obj1, obj2, obj3){
            url ="'||v_pkg||'.crrec?p_companycd="+obj1+"&p_cli_code="+obj2+"&p_sno="+obj3;
            newWnd2 = window.open(url,"'||v_pkg||'window","top=100, left=100, status=yes, resizable=no, scrollbars=yes, width=1000, height=327");  
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
    p_companycd in varchar2 default null,
    p_cli_code in varchar2 default null
  )
  IS
--    cursor cur is
--      SELECT  a.companycd, a.vendcd, b.vendnm, a.sno, a.deptnm, a.empnm, a.telno, a.bpno, a.email, a.memo
--      FROM    cm0077t a, cm0075t b
--      WHERE   a.companycd = p_companycd
--      AND     a.vendcd = p_cli_code
--      AND     a.companycd = b.companycd
--      AND     a.vendcd = b.vendcd
--      ORDER BY  1, 3, 4;
    cursor cur is
      SELECT  a.companycd, a.vendcd, a.sno, a.deptnm, a.empnm, a.telno, a.bpno, a.email, a.memo
      FROM    cm0077t a
      WHERE   a.companycd = p_companycd
      AND     a.vendcd = p_cli_code
      ORDER BY  1, 3, 4;
      
    type r is table of cur%rowtype index by pls_integer;
    rec r;
    
    v_number number := 0 ;
    v_link varchar2(4096) := null;

  BEGIN
  
    owa_util.mime_header('application/json');

    open cur;
    fetch cur bulk collect into rec;
    close cur;
    
    htp.p('{rows:[ ');
    v_number := rec.count;
    for i in 1 .. v_number loop
      v_link := '^javascript:link_(\"'||rec(i).companycd||'\", \"'||rec(i).vendcd||'\", \"'||rec(i).sno||'\")^_self';
      htp .p('
      { id:' ||i|| ',
        data:[
          {value:"'||rec(i).sno||v_link||'"},
          {value:"'||rec(i).deptnm||'"},
          {value:"'||rec(i).empnm||'"},
          {value:"'||rec(i).telno||'"},
          {value:"'||rec(i).bpno||'"},
          {value:"'||rec(i).email||'"},
          {value:"'||rec(i).memo||'"}
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
    p_companycd in varchar2 default null,
    p_cli_code in varchar2 default null,
    p_sno in varchar2 default null
  )
  IS
  
    cursor cur is
      select  *
      from    cm0077t
      where   companycd = p_companycd
      and     vendcd = p_cli_code
      and     sno = p_sno
      ;
      
    rec cur %rowtype;
     
  BEGIN  
        
  open cur;
  fetch cur into rec;
  close cur;
        
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
               
        thisForm.p_dml_gubun.value = "1";
        thisForm.submit(); 
      }    

      function proc_del() {    
        var thisForm = document.getElementById("form1");
  
        if (!confirm("'||get_fn('삭제하시겠습니까?')||'")) return false;    
        thisForm.p_dml_gubun.value = "2";    
        thisForm.submit();   
      } 
      
    </script>      
  </head>    
  <body>                
    <form id="form1" name="form1" action="'||v_pkg||'.process" method="post" >
      <input type="hidden" id="p_dml_gubun" name="p_dml_gubun" value="" />
      <input type="hidden" name="p_companycd" value="'||p_companycd||'" />
      <input type="hidden" name="p_cli_code" value="'||p_cli_code||'" />
      <input type="hidden" name="p_sno" value="'||p_sno||'" />
    
      <!-- 신규 Form Setting S -->
      <div class="formWrap">
      
        <!--상단타이틀/버튼-->
        <div class="formTop">
          <div class="formTitle">'||get_program_name('SCM',v_pkg,v_lang)||'</div>
          <div class="btnbar">
            <a href="#" class="btn-save buttons" onclick="proc_save(); return false;">'||get_fn('저장')||'</a>&nbsp;
            <a href="#" class="btn-delete buttons" onclick="proc_del(); return false;">'||get_fn('선택삭제')||'</a>&nbsp;
            <a href="#" class="btn-close buttons" onclick="self.close(); return false;">'||get_fn('닫기')||'</a>
          </div>
        </div>
        
        <!--테이블입력-->
        <div>
          <table width="100%" border="0" cellspacing="0" cellpadding="4">
            <tbody>
            
              <tr>
                <td class="titletd">'||get_fn('거래처')||'</td>
                <td class="inputtd">
                  '||p_cli_code||'
                </td>
                <td class="titletd">'||get_fn('부서')||'</td>
                <td class="inputtd">
                  <input type="text" id="p_deptnm" name="p_deptnm" maxlength="30" value="'||rec.deptnm||'" /> 
                </td>
              </tr>
             
              <tr>
                <td class="titletd">'||get_fn('이름')||'</td>
                <td class="inputtd">
                  <input type="text" id="p_empnm" name="p_empnm" maxlength="30" value="'||rec.empnm||'" /> 
                </td>
                <td class="titletd">'||get_fn('전자우편')||'</td>
                <td class="inputtd">
                  <input type="text" id="p_email" name="p_email" maxlength="30" value="'||rec.email||'" /> 
                </td>
              </tr>
              
              <tr>
                <td class="titletd">'||get_fn('전화번호')||'</td>
                <td class="inputtd">
                  <input type="text" id="p_telno" name="p_telno" maxlength="30" value="'||rec.telno||'" /> 
                </td>
                <td class="titletd">'||get_fn('휴대전화')||'</td>
                <td class="inputtd">
                  <input type="text" id="p_bpno" name="p_bpno" maxlength="30" value="'||rec.bpno||'" /> 
                </td>
              </tr>
              
              <tr>
                <td class="titletd">'||get_fn('메모')||'</td>
                <td class="inputtd" colspan="4">
                    <input type="text" id="p_memo" name="p_memo" maxlength="200" style="text-align:left; width:608px; height:60px;" value="'||rec.memo||'" />            
                </td>
                <td></td><td></td>
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
    p_companycd in varchar2 default null,
    p_cli_code in varchar2 default null,
    p_sno in varchar2 default null,
    p_dml_gubun in varchar2 default null,
    p_vendcd in varchar2 default null, 
    p_deptnm in varchar2 default null, 
    p_empnm in varchar2 default null, 
    p_email in varchar2 default null, 
    p_telno in varchar2 default null, 
    p_bpno in varchar2 default null,
    p_memo in varchar2 default null
  )
  IS
  
   CURSOR cur IS
    SELECT  nvl(max(sno), 0) + 1
    FROM    cm0077t
    WHERE   companycd = p_companycd
    AND     vendcd = p_cli_code;
        
    v_sno number;

  BEGIN
    
    if p_dml_gubun = '1' then
      BEGIN

        if p_sno is null then  
          open cur;
          fetch cur into v_sno;
          if cur%notfound then
            v_sno := 1;
          end if;
          close cur;
        else
         v_sno := p_sno;
        end if;
    
        INSERT INTO cm0077t (companycd, vendcd, sno, deptnm, empnm, email, telno, bpno, memo, login_id, login_ymd)
                    VALUES  (p_companycd, p_cli_code, v_sno, p_deptnm, p_empnm, p_email, p_telno, p_bpno, p_memo, v_id, sysdate);
      exception  
      when dup_val_on_index then 
        update  cm0077t
        set     deptnm = p_deptnm,
                empnm = p_empnm,
                telno = p_telno,
                bpno = p_bpno,
                email = p_email,
                memo = p_memo
        where   companycd = p_companycd
        and     vendcd = p_cli_code
        and     sno = v_sno;
      end; 
        
      htp.p('
        <script type="text/javascript">
          alert("'||get_fn( '저장되었습니다.')||'");
          opener.location.reload();
          location.href = "'||v_pkg||'.crrec?p_companycd='||p_companycd||'&p_cli_code='||p_cli_code||'&p_sno='||v_sno||'";
        </script>
      ');
    
    elsif p_dml_gubun = '2' then
      
      DELETE FROM cm0077t
      WHERE       companycd = p_companycd
      AND         vendcd = p_cli_code
      AND         sno = p_sno;
    
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
 
END kscm7102;

/
