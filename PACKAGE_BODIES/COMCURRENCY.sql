--------------------------------------------------------
--  DDL for Package Body COMCURRENCY
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "PREMIER"."COMCURRENCY" 
IS
  PROCEDURE control
  (
    p_ymd in varchar2 default to_char(sysdate,'yyyy') 
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
        var url = "'||v_pkg||'.crrec?p_ymd='||p_ymd||'";  
        newWnd2 = window.open(url,"'||v_pkg||'window","top=100, left=100, status=yes, resizable=no, scrollbars=yes, width=920, height=200");  
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
          <div class="cTitle"><label for="p_ymd">'||get_fn('기준년')||'</label></div>
          <div class="cInput">
            <input type="text" id="p_ymd" name="p_ymd" maxlength="4" class="cDate" value="'||p_ymd||'" />   
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
    p_ymd in varchar2 default null
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
            
            x[i]=["'||get_fn('기준년')||'", "100","center","link","str","true"];i++;
            x[i]=["'||get_fn('통화')||'", "100","left","ro","str","true"];i++;
            x[i]=["'||get_fn('환율')||'", "100","right","ro","str","true"];i++;
            x[i]=["'||get_fn('등록자')||'", "200","left","ro","str","true"];i++;
            x[i]=["'||get_fn('등록일')||'", "200","center","ro","str","true"];i++;

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
        
          function link_(obj1, obj2){
            url ="'||v_pkg||'.crrec?p_ymd="+obj1+"&p_coincd="+obj2;
            newWnd2 = window.open(url,"'||v_pkg||'window","top=100, left=100, status=yes, resizable=no, scrollbars=yes, width=920, height=200");  
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
    p_ymd in varchar2 default null
  )
  IS
  
    cursor cur is 
      select  ymd, coincd, rate, login_id, login_ymd
      from    xm800 
      where   ymd = p_ymd
      order by  coincd ; 

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
      v_link := '^javascript:link_(\"'||rec(i).ymd||'\", \"'||rec(i).coincd||'\")^_self';
      htp.p('
      { id:' ||i|| ',
        data:[
          {value:"'||rec(i).ymd||v_link||'"},
          {value:"'||get_catalog_name('COM', 'CURRENCY_NAME', v_lang,rec(i).coincd)||'"},
          {value:"'||rec(i).rate||'"},
          {value:"'||rec(i).login_id||'"},
          {value:"'||to_char(rec(i).login_ymd,'yyyy-mm-dd')||'"}
        ] 

      } 
      ');
      
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
    p_ymd in varchar2 default null,
    p_coincd in varchar2 default null
  )
  IS
  
    cursor cur is 
      select  ymd, coincd, rate
      from    xm800
      where   ymd = p_ymd
      and     coincd = p_coincd
      ;
  
    rec cur %rowtype;
    
    v_disabled varchar2(20);

  BEGIN  
        
    open cur;
    fetch cur into rec;
    close cur;
    
    if rec.ymd is not null then
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
        $("#p_ymd").removeAttr("disabled");

        thisForm.p_dml_gubun.value = "1";
        thisForm.submit(); 
        
      }    

      function proc_del() {    
        var thisForm = document.getElementById("form1");
  
        if (!confirm("'||get_fn('삭제하시겠습니까?')||'")) return false;    
        $("#p_ymd").removeAttr("disabled");
        
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
          <div class="formTitle">'||get_program_name('COM',v_pkg,v_lang)||'</div>
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
                <td class="titletd">'||get_fn('기준일')||'</td>
                <td class="inputtd" colspan="4">
                  <input type="text" id="p_ymd" name="p_ymd" '||v_disabled||' value="'||nvl(rec.ymd, p_ymd)||'" /> 
                </td>
               <td></td> 
              </tr>
              <tr>
                <td class="titletd require">'||get_fn('통화명')||'</td>
                <td class="inputtd">
                  '); common.list_catalog('COM', 'CURRENCY_NAME', rec.coincd, 'select', null, 'p_coincd', 'c', 'yes'); htp.p(' 
                </td>
                <td class="titletd require">'||get_fn('환율')||'</td>
                <td class="inputtd">
                  <input type="text" id="p_rate" name="p_rate" maxlength="30" value="'||rec.rate||'" /> 
                </td>
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
    p_ymd in varchar2 default null,
    p_dml_gubun in varchar2 default null,
    p_coincd in varchar2 default null,
    p_rate in varchar2 default null

  ) 
  IS
  
  BEGIN
    
    if p_dml_gubun = '1' then
      
      begin 
        insert into xm800(ymd, coincd, rate, login_id, login_ymd ) 
                  values (p_ymd, p_coincd, p_rate, common.get_cookie('SYSID'), sysdate); 
      exception  
        when dup_val_on_index then 
          update  xm800 
          set     rate = p_rate, 
                  login_id = common.get_cookie('SYSID'), 
                  login_ymd = sysdate
          where   ymd = p_ymd
          and     coincd = p_coincd; 
          when others then 
            show_err;
      end; 
    
      htp.p('
      <script type="text/javascript">
        alert("'||get_fn( '저장되었습니다.')||'");
        opener.location.reload();
        location.href = "'||v_pkg||'.crrec?p_ymd='||p_ymd||'&p_coincd='||p_coincd||'";
      </script>
      ');
    
    elsif p_dml_gubun = '2' then
      
      delete from   xm800
      where         ymd = p_ymd
      and           coincd = p_coincd; 
    
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
 
END COMCURRENCY;

/
