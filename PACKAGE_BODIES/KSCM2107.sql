--------------------------------------------------------
--  DDL for Package Body KSCM2107
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "PREMIER"."KSCM2107" 
IS
  PROCEDURE control
  (
    p_companycd in varchar2 default common.get_cookie('SYSCOMP'),
    p_yy in  varchar2 default to_char(sysdate,'yyyymmdd'),
    p_linecd in varchar2 default null
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
        var url = "'||v_pkg||'.crrec?p_companycd='||p_companycd||'";  
        newWnd2 = window.open(url,"'||v_pkg||'window","top=100, left=100, status=yes, resizable=no, scrollbars=yes, width=1000, height=700");  
        newWnd2.focus();
      } 
      
      $(function() {
        doOnLoad();  
        
        $("#p_yy").datepicker({
          changeMonth: true,
          changeYear: true,
          dateFormat: "yymmdd",
          buttonImage: "/image/calendar.gif",
          showOn: "focus", // focus, button, both
          showAnim: "fadeIn", //explode, fold, slideDown
          showOptions: {pieces: 1},
          duration: 500
        }) ; 
        
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
          <div class="cTitle"><label for="p_yy">'||get_fn('기준일자')||'</label></div>
          <div class="cInput">
            <input type="text" id="p_yy" name="p_yy" maxlength="8" class="cDate" value="'||p_yy||'" />   
          </div>
        </div>  
      
      </div>
      <div id="c11">
        <a href="#" target="list" onclick="doQuery(); return false;" class="btn-search buttons">'||get_fn('조회')||'</a>
        <a href="#" target="list" onclick="excel(); return false;" class="btn-excel buttons">'||get_fn('EXCEL')||'</a>
      </div>
      <div class="crlf"></div>
    </div>
    <div id="c22">
      <div class="floatL">
        
      </div>
      <div class="floatR">
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
    p_yy in  varchar2 default null,
    p_linecd in varchar2 default null
  )
  IS
    
    v_data1 number := 99111999;
    
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
            var v_header2="";   
            var w_header="";
            var v_width="";
            var v_align="";
            var v_types="";
            var v_sorting="";
            var v_tooltip="";
            var x = new Array(100);
            var cm = "";
            var i=0;     
            var j=0; 
            
            x[i]=["NO","#rspan","40","center","ro","int","true"];i=i+1;   
            x[i]=["'||get_fn('품번')||'","#rspan","80","center","ro","str","false"];i=i+1;   
            x[i]=["'||get_fn('기초재고')||'","#rspan","120","right","ron","int","false"];mygrid.setNumberFormat("0,000", i);i=i+1;  
            x[i]=["'||to_char(to_date(p_yy,'yyyymmdd'),'yyyy')||'-'||to_char(to_date(p_yy,'yyyymmdd'),'mm')||'-'||to_char(to_date(p_yy,'yyyymmdd'),'dd')||'","'||get_fn('생산')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000", i);i=i+1; 
            x[i]=["#cspan","'||get_fn('입고')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000",i);i=i+1; 
            x[i]=["#cspan","'||get_fn('계획')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000",i);i=i+1;  
            x[i]=["#cspan","'||get_fn('예상재고')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000",i);i=i+1; 
            x[i]=["'||to_char(to_date(p_yy,'yyyymmdd')+1,'yyyy')||'-'||to_char(to_date(p_yy,'yyyymmdd')+1,'mm')||'-'||to_char(to_date(p_yy,'yyyymmdd')+1,'dd')||'","'||get_fn('생산')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000",i);i=i+1; 
            x[i]=["#cspan","'||get_fn('입고')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000",i);i=i+1; 
            x[i]=["#cspan","'||get_fn('계획')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000",i);i=i+1;  
            x[i]=["#cspan","'||get_fn('예상재고')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000",i);i=i+1;                      
              
            x[i]=["'||to_char(to_date(p_yy,'yyyymmdd')+2,'yyyy')||'-'||to_char(to_date(p_yy,'yyyymmdd')+2,'mm')||'-'||to_char(to_date(p_yy,'yyyymmdd')+2,'dd')||'","'||get_fn('생산')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000",i);i=i+1; 
            x[i]=["#cspan","'||get_fn('입고')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000",i);i=i+1; 
            x[i]=["#cspan","'||get_fn('계획')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000",i);i=i+1;  
            x[i]=["#cspan","'||get_fn('예상재고')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000",i);i=i+1;                      
              
            x[i]=["'||to_char(to_date(p_yy,'yyyymmdd')+3,'yyyy')||'-'||to_char(to_date(p_yy,'yyyymmdd')+3,'mm')||'-'||to_char(to_date(p_yy,'yyyymmdd')+3,'dd')||'","'||get_fn('생산')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000",i);i=i+1; 
            x[i]=["#cspan","'||get_fn('입고')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000",i);i=i+1; 
            x[i]=["#cspan","'||get_fn('계획')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000",i);i=i+1;  
            x[i]=["#cspan","'||get_fn('예상재고')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000",i);i=i+1;                      
              
            x[i]=["'||to_char(to_date(p_yy,'yyyymmdd')+4,'yyyy')||'-'||to_char(to_date(p_yy,'yyyymmdd')+4,'mm')||'-'||to_char(to_date(p_yy,'yyyymmdd')+4,'dd')||'","'||get_fn('생산')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000",i);i=i+1; 
            x[i]=["#cspan","'||get_fn('입고')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000",i);i=i+1; 
            x[i]=["#cspan","'||get_fn('계획')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000",i);i=i+1;  
            x[i]=["#cspan","'||get_fn('예상재고')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000",i);i=i+1;                      
              
            x[i]=["'||to_char(to_date(p_yy,'yyyymmdd')+5,'yyyy')||'-'||to_char(to_date(p_yy,'yyyymmdd')+5,'mm')||'-'||to_char(to_date(p_yy,'yyyymmdd')+5,'dd')||'","'||get_fn('생산')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000",i);i=i+1; 
            x[i]=["#cspan","'||get_fn('입고')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000",i);i=i+1; 
            x[i]=["#cspan","'||get_fn('계획')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000",i);i=i+1;  
            x[i]=["#cspan","'||get_fn('예상재고')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000",i);i=i+1;                      
              
            x[i]=["'||to_char(to_date(p_yy,'yyyymmdd')+6,'yyyy')||'-'||to_char(to_date(p_yy,'yyyymmdd')+6,'mm')||'-'||to_char(to_date(p_yy,'yyyymmdd')+6,'dd')||'","'||get_fn('생산')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000",i);i=i+1; 
            x[i]=["#cspan","'||get_fn('입고')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000",i);i=i+1; 
            x[i]=["#cspan","'||get_fn('계획')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000",i);i=i+1;  
            x[i]=["#cspan","'||get_fn('예상재고')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000",i);i=i+1;                      
              
            x[i]=["'||to_char(to_date(p_yy,'yyyymmdd')+7,'yyyy')||'-'||to_char(to_date(p_yy,'yyyymmdd')+7,'mm')||'-'||to_char(to_date(p_yy,'yyyymmdd')+7,'dd')||'","'||get_fn('생산')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000",i);i=i+1; 
            x[i]=["#cspan","'||get_fn('입고')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000",i);i=i+1; 
            x[i]=["#cspan","'||get_fn('계획')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000",i);i=i+1;  
            x[i]=["#cspan","'||get_fn('예상재고')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000",i);i=i+1;                      
              
            x[i]=["'||to_char(to_date(p_yy,'yyyymmdd')+8,'yyyy')||'-'||to_char(to_date(p_yy,'yyyymmdd')+8,'mm')||'-'||to_char(to_date(p_yy,'yyyymmdd')+8,'dd')||'","'||get_fn('생산')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000",i);i=i+1; 
            x[i]=["#cspan","'||get_fn('입고')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000",i);i=i+1; 
            x[i]=["#cspan","'||get_fn('계획')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000",i);i=i+1;  
            x[i]=["#cspan","'||get_fn('예상재고')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000",i);i=i+1;                      
              
            x[i]=["'||to_char(to_date(p_yy,'yyyymmdd')+9,'yyyy')||'-'||to_char(to_date(p_yy,'yyyymmdd')+9,'mm')||'-'||to_char(to_date(p_yy,'yyyymmdd')+9,'dd')||'","'||get_fn('생산')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000",i);i=i+1; 
            x[i]=["#cspan","'||get_fn('입고')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000",i);i=i+1; 
            x[i]=["#cspan","'||get_fn('계획')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000",i);i=i+1;  
            x[i]=["#cspan","'||get_fn('예상재고')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000",i);i=i+1;                      
              
            x[i]=["'||to_char(to_date(p_yy,'yyyymmdd')+10,'yyyy')||'-'||to_char(to_date(p_yy,'yyyymmdd')+10,'mm')||'-'||to_char(to_date(p_yy,'yyyymmdd')+10,'dd')||'","'||get_fn('생산')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000",i);i=i+1; 
            x[i]=["#cspan","'||get_fn('입고')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000",i);i=i+1; 
            x[i]=["#cspan","'||get_fn('계획')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000",i);i=i+1;  
            x[i]=["#cspan","'||get_fn('예상재고')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000",i);i=i+1;                      
              
            x[i]=["'||to_char(to_date(p_yy,'yyyymmdd')+11,'yyyy')||'-'||to_char(to_date(p_yy,'yyyymmdd')+11,'mm')||'-'||to_char(to_date(p_yy,'yyyymmdd')+11,'dd')||'","'||get_fn('생산')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000",i);i=i+1; 
            x[i]=["#cspan","'||get_fn('입고')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000",i);i=i+1; 
            x[i]=["#cspan","'||get_fn('계획')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000",i);i=i+1;  
            x[i]=["#cspan","'||get_fn('예상재고')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000",i);i=i+1;                      
              
            x[i]=["'||to_char(to_date(p_yy,'yyyymmdd')+12,'yyyy')||'-'||to_char(to_date(p_yy,'yyyymmdd')+12,'mm')||'-'||to_char(to_date(p_yy,'yyyymmdd')+12,'dd')||'","'||get_fn('생산')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000",i);i=i+1; 
            x[i]=["#cspan","'||get_fn('입고')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000",i);i=i+1; 
            x[i]=["#cspan","'||get_fn('계획')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000",i);i=i+1;  
            x[i]=["#cspan","'||get_fn('예상재고')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000",i);i=i+1;                      
              
            x[i]=["'||to_char(to_date(p_yy,'yyyymmdd')+13,'yyyy')||'-'||to_char(to_date(p_yy,'yyyymmdd')+13,'mm')||'-'||to_char(to_date(p_yy,'yyyymmdd')+13,'dd')||'","'||get_fn('생산')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000",i);i=i+1; 
            x[i]=["#cspan","'||get_fn('입고')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000",i);i=i+1; 
            x[i]=["#cspan","'||get_fn('계획')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000",i);i=i+1;  
            x[i]=["#cspan","'||get_fn('예상재고')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000",i);i=i+1;

            for(j=0;j<i;j++){   
              if(j==0) cm="";   
              else cm=",";   
              v_header=v_header+cm+x[j][0];   
              v_header2=v_header2+cm+x[j][1];  
              v_width=v_width+cm+x[j][2];   
              v_align=v_align+cm+x[j][3];   
              v_types=v_types+cm+x[j][4];   
              v_sorting=v_sorting+cm+x[j][5];   
              v_tooltip=v_tooltip+cm+x[j][6];   
             }   
            
            var v_footer2="";   
            var y = new Array(100);   
            var cm2 = "";   
            var b=0; 
              
            y[b]=["'||get_fn('')||'"];b++;   
            y[b]=["'||get_fn('Total')||'"];b++;   
            y[b]=["'||replace(to_char(v_data1,'fm999,999,999,999'),',','&#44;')||'"];b++;   
            y[b]=["'||replace(to_char(v_data1,'fm999,999,999,999'),',','&#44;')||'"];b++;   
            y[b]=["'||replace(to_char(v_data1,'fm999,999,999,999'),',','&#44;')||'"];b++;   
            y[b]=["'||replace(to_char(v_data1,'fm999,999,999,999'),',','&#44;')||'"];b++;   
            y[b]=["'||replace(to_char(v_data1,'fm999,999,999,999'),',','&#44;')||'"];b++;   
            y[b]=["'||replace(to_char(v_data1,'fm999,999,999,999'),',','&#44;')||'"];b++;   
            y[b]=["'||replace(to_char(v_data1,'fm999,999,999,999'),',','&#44;')||'"];b++;   
            y[b]=["'||replace(to_char(v_data1,'fm999,999,999,999'),',','&#44;')||'"];b++;   
            y[b]=["'||replace(to_char(v_data1,'fm999,999,999,999'),',','&#44;')||'"];b++;   
            y[b]=["'||replace(to_char(v_data1,'fm999,999,999,999'),',','&#44;')||'"];b++;   
            y[b]=["'||replace(to_char(v_data1,'fm999,999,999,999'),',','&#44;')||'"];b++;   
            y[b]=["'||replace(to_char(v_data1,'fm999,999,999,999'),',','&#44;')||'"];b++;   
            y[b]=["'||replace(to_char(v_data1,'fm999,999,999,999'),',','&#44;')||'"];b++;   
            y[b]=["'||replace(to_char(v_data1,'fm999,999,999,999'),',','&#44;')||'"];b++;   
            y[b]=["'||replace(to_char(v_data1,'fm999,999,999,999'),',','&#44;')||'"];b++;   
            y[b]=["'||replace(to_char(v_data1,'fm999,999,999,999'),',','&#44;')||'"];b++;   
            y[b]=["'||replace(to_char(v_data1,'fm999,999,999,999'),',','&#44;')||'"];b++;   
            y[b]=["'||replace(to_char(v_data1,'fm999,999,999,999'),',','&#44;')||'"];b++;   
            y[b]=["'||replace(to_char(v_data1,'fm999,999,999,999'),',','&#44;')||'"];b++;   
            y[b]=["'||replace(to_char(v_data1,'fm999,999,999,999'),',','&#44;')||'"];b++;   
            y[b]=["'||replace(to_char(v_data1,'fm999,999,999,999'),',','&#44;')||'"];b++;   
            y[b]=["'||replace(to_char(v_data1,'fm999,999,999,999'),',','&#44;')||'"];b++;   
            y[b]=["'||replace(to_char(v_data1,'fm999,999,999,999'),',','&#44;')||'"];b++;   
            y[b]=["'||replace(to_char(v_data1,'fm999,999,999,999'),',','&#44;')||'"];b++;   
            y[b]=["'||replace(to_char(v_data1,'fm999,999,999,999'),',','&#44;')||'"];b++;   
            y[b]=["'||replace(to_char(v_data1,'fm999,999,999,999'),',','&#44;')||'"];b++;   
            y[b]=["'||replace(to_char(v_data1,'fm999,999,999,999'),',','&#44;')||'"];b++;   
            y[b]=["'||replace(to_char(v_data1,'fm999,999,999,999'),',','&#44;')||'"];b++;   
            y[b]=["'||replace(to_char(v_data1,'fm999,999,999,999'),',','&#44;')||'"];b++;   
            y[b]=["'||replace(to_char(v_data1,'fm999,999,999,999'),',','&#44;')||'"];b++;   
            y[b]=["'||replace(to_char(v_data1,'fm999,999,999,999'),',','&#44;')||'"];b++;   
            y[b]=["'||replace(to_char(v_data1,'fm999,999,999,999'),',','&#44;')||'"];b++;   
            y[b]=["'||replace(to_char(v_data1,'fm999,999,999,999'),',','&#44;')||'"];b++;   
            y[b]=["'||replace(to_char(v_data1,'fm999,999,999,999'),',','&#44;')||'"];b++;   
            y[b]=["'||replace(to_char(v_data1,'fm999,999,999,999'),',','&#44;')||'"];b++;   
            y[b]=["'||replace(to_char(v_data1,'fm999,999,999,999'),',','&#44;')||'"];b++;   
            y[b]=["'||replace(to_char(v_data1,'fm999,999,999,999'),',','&#44;')||'"];b++;   
            y[b]=["'||replace(to_char(v_data1,'fm999,999,999,999'),',','&#44;')||'"];b++;   
            y[b]=["'||replace(to_char(v_data1,'fm999,999,999,999'),',','&#44;')||'"];b++;   
            y[b]=["'||replace(to_char(v_data1,'fm999,999,999,999'),',','&#44;')||'"];b++;   
            y[b]=["'||replace(to_char(v_data1,'fm999,999,999,999'),',','&#44;')||'"];b++;   
            y[b]=["'||replace(to_char(v_data1,'fm999,999,999,999'),',','&#44;')||'"];b++;   
            y[b]=["'||replace(to_char(v_data1,'fm999,999,999,999'),',','&#44;')||'"];b++;   
            y[b]=["'||replace(to_char(v_data1,'fm999,999,999,999'),',','&#44;')||'"];b++;   
            y[b]=["'||replace(to_char(v_data1,'fm999,999,999,999'),',','&#44;')||'"];b++;   
            y[b]=["'||replace(to_char(v_data1,'fm999,999,999,999'),',','&#44;')||'"];b++;   
            y[b]=["'||replace(to_char(v_data1,'fm999,999,999,999'),',','&#44;')||'"];b++;   
            y[b]=["'||replace(to_char(v_data1,'fm999,999,999,999'),',','&#44;')||'"];b++;   
            y[b]=["'||replace(to_char(v_data1,'fm999,999,999,999'),',','&#44;')||'"];b++;   
            y[b]=["'||replace(to_char(v_data1,'fm999,999,999,999'),',','&#44;')||'"];b++;   
            y[b]=["'||replace(to_char(v_data1,'fm999,999,999,999'),',','&#44;')||'"];b++;   
            y[b]=["'||replace(to_char(v_data1,'fm999,999,999,999'),',','&#44;')||'"];b++;   
            y[b]=["'||replace(to_char(v_data1,'fm999,999,999,999'),',','&#44;')||'"];b++;   
            y[b]=["'||replace(to_char(v_data1,'fm999,999,999,999'),',','&#44;')||'"];b++;   
            y[b]=["'||replace(to_char(v_data1,'fm999,999,999,999'),',','&#44;')||'"];b++;   
            y[b]=["'||replace(to_char(v_data1,'fm999,999,999,999'),',','&#44;')||'"];b++;   
            y[b]=["'||replace(to_char(v_data1,'fm999,999,999,999'),',','&#44;')||'"];b++;   
            
            for(i=0;i<b;i++){       
              if(i==0) cm2="";         
              else cm2=",";         
              v_footer2=v_footer2+cm2+y[i][0];   
            }   
        
            mygrid.attachFooter(v_footer2,[ "font-style:normal;text-align:center;",
                                            "font-style:normal;text-align:center;",  
                                            "font-style:normal;text-align:right;",  
                                            "font-style:normal;text-align:right;",  
                                            "font-style:normal;text-align:right;",  
                                            "font-style:normal;text-align:right;",  
                                            "font-style:normal;text-align:right;",  
                                            "font-style:normal;text-align:right;",  
                                            "font-style:normal;text-align:right;",  
                                            "font-style:normal;text-align:right;",  
                                            "font-style:normal;text-align:right;",  
                                            "font-style:normal;text-align:right;",  
                                            "font-style:normal;text-align:right;",  
                                            "font-style:normal;text-align:right;",  
                                            "font-style:normal;text-align:right;", 
                                            "font-style:normal;text-align:right;",  
                                            "font-style:normal;text-align:right;",  
                                            "font-style:normal;text-align:right;",  
                                            "font-style:normal;text-align:right;",  
                                            "font-style:normal;text-align:right;",  
                                            "font-style:normal;text-align:right;",  
                                            "font-style:normal;text-align:right;",  
                                            "font-style:normal;text-align:right;",  
                                            "font-style:normal;text-align:right;",  
                                            "font-style:normal;text-align:right;",  
                                            "font-style:normal;text-align:right;",  
                                            "font-style:normal;text-align:right;",  
                                            "font-style:normal;text-align:right;",  
                                            "font-style:normal;text-align:right;",  
                                            "font-style:normal;text-align:right;",  
                                            "font-style:normal;text-align:right;",  
                                            "font-style:normal;text-align:right;",  
                                            "font-style:normal;text-align:right;",  
                                            "font-style:normal;text-align:right;",  
                                            "font-style:normal;text-align:right;",  
                                            "font-style:normal;text-align:right;",  
                                            "font-style:normal;text-align:right;",  
                                            "font-style:normal;text-align:right;",  
                                            "font-style:normal;text-align:right;",  
                                            "font-style:normal;text-align:right;",  
                                            "font-style:normal;text-align:right;",  
                                            "font-style:normal;text-align:right;",  
                                            "font-style:normal;text-align:right;",  
                                            "font-style:normal;text-align:right;",  
                                            "font-style:normal;text-align:right;",  
                                            "font-style:normal;text-align:right;",  
                                            "font-style:normal;text-align:right;",  
                                            "font-style:normal;text-align:right;",  
                                            "font-style:normal;text-align:right;",  
                                            "font-style:normal;text-align:right;",
                                            "font-style:normal;text-align:right;",  
                                            "font-style:normal;text-align:right;",  
                                            "font-style:normal;text-align:right;",  
                                            "font-style:normal;text-align:right;",  
                                            "font-style:normal;text-align:right;",  
                                            "font-style:normal;text-align:right;",  
                                            "font-style:normal;text-align:right;",  
                                            "font-style:normal;text-align:right;",  
                                            "font-style:normal;text-align:right;"]);    

            mygrid.setHeader(v_header);
            mygrid.attachHeader(v_header2);   
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
            mygrid.splitAt(3);     

            mygrid.enableHeaderMenu();
            mygrid.enableDistributedParsing(true,10,300);
            mygrid.preventIECaching(false);
            mygrid.setSkin("dhx_web");
            //mygrid.attachEvent("onRowSelect",doOnRowSelected);
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
          
          function link_(obj1, obj2, obj3, obj4, obj5){
            url ="'||v_pkg||'.crrec?p_companycd="+obj1+"&p_vendcd="+obj2+"&p_partno="+obj3+"&p_sno="+obj4;
            newWnd2 = window.open(url,"'||v_pkg||'window","top=100, left=100, status=yes, resizable=no, scrollbars=yes, width=1000, height=700");  
            newWnd2.focus();
          }
          
          $(function() {
            doInitGrid();
          });
          
        </script>
      </head>
    <body>
      <div id="mygrid_obj" style="width:100%;height:96%;"></div>
    </body>
  </html> ');
  EXCEPTION
    WHEN OTHERS THEN
      show_err('query_a');
  END query_a;
  
  PROCEDURE query_a_data
  (
    p_companycd in varchar2 default null,
    p_yy in  varchar2 default null,
    p_linecd in varchar2 default null
  )
  IS
    cursor cur is
      select '4270-2335' as partno
            ,'3423' as stockqty
            ,'3488' as makqty1
            ,'3426' as incqty1
            ,'3400' as planqty1
            ,'3999' as v_stock1
            ,'3465' as makqty2
            ,'34' as incqty2
            ,'34' as planqty2
            ,'3' as v_stock2
            ,'34' as makqty3
            ,'34' as incqty3
            ,'34' as planqty3  
            ,'3' as v_stock3
            ,'34' as makqty4
            ,'34' as incqty4
            ,'34' as planqty4  
            ,'3' as v_stock4
            ,'34' as makqty5
            ,'34' as incqty5
            ,'34' as planqty5  
            ,'3' as v_stock5
            ,'34' as makqty6
            ,'34' as incqty6
            ,'34' as planqty6  
            ,'3' as v_stock6
            ,'34' as makqty7
            ,'34' as incqty7
            ,'34' as planqty7 
            ,'3' as v_stock7
            ,'34' as makqty8
            ,'34' as incqty8
            ,'34' as planqty8
            ,'3' as v_stock8
            ,'34' as makqty9
            ,'34' as incqty9
            ,'34' as planqty9 
            ,'3' as v_stock9
            ,'34' as makqty10
            ,'34' as incqty10
            ,'34' as planqty10 
            ,'3' as v_stock10
            ,'34' as makqty11
            ,'34' as incqty11
            ,'34' as planqty11
            ,'3' as v_stock11
            ,'34' as makqty12
            ,'34' as incqty12
            ,'34' as planqty12
            ,'3' as v_stock12
            ,'34' as makqty13
            ,'34' as incqty13
            ,'34' as planqty13
            ,'3' as v_stock13
            ,'34' as makqty14
            ,'34' as incqty14
            ,'34' as planqty14
            ,'3' as v_stock14
      from dual
      ;
      
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
--      v_link := '^javascript:link_(\"'||rec(i).companycd||'\", \"'||rec(i).vendcd||'\", \"'||rec(i).partno||'\", \"'||rec(i).sno||'\")^_self';
      htp.p('
      { id:' ||i|| ',
        data:[
          {value:"'||i||'"},
          {value:"'||rec(i).partno||'"},
          {value:"'||rec(i).stockqty||'"},
          {value:"'||rec(i).makqty1||'"},
          {value:"'||rec(i).incqty1||'"},
          {value:"'||rec(i).planqty1||'"},    
          {value:"'||rec(i).v_stock1||'"},
          {value:"'||rec(i).makqty2||'"},
          {value:"'||rec(i).incqty2||'"},
          {value:"'||rec(i).planqty2||'"},
          {value:"'||rec(i).v_stock2||'"},
          {value:"'||rec(i).makqty3||'"},
          {value:"'||rec(i).incqty3||'"},
          {value:"'||rec(i).planqty3||'"},
          {value:"'||rec(i).v_stock3||'"},
          {value:"'||rec(i).makqty4||'"},
          {value:"'||rec(i).incqty4||'"},
          {value:"'||rec(i).planqty4||'"},
          {value:"'||rec(i).v_stock4||'"},
          {value:"'||rec(i).makqty5||'"},
          {value:"'||rec(i).incqty5||'"},
          {value:"'||rec(i).planqty5||'"},
          {value:"'||rec(i).v_stock5||'"},
          {value:"'||rec(i).makqty6||'"},
          {value:"'||rec(i).incqty6||'"},
          {value:"'||rec(i).planqty6||'"},
          {value:"'||rec(i).v_stock6||'"},
          {value:"'||rec(i).makqty7||'"},
          {value:"'||rec(i).incqty7||'"},
          {value:"'||rec(i).planqty7||'"},
          {value:"'||rec(i).v_stock7||'"},
          {value:"'||rec(i).makqty8||'"},
          {value:"'||rec(i).incqty8||'"},
          {value:"'||rec(i).planqty8||'"},
          {value:"'||rec(i).v_stock8||'"},
          {value:"'||rec(i).makqty9||'"},
          {value:"'||rec(i).incqty9||'"},
          {value:"'||rec(i).planqty9||'"},    
          {value:"'||rec(i).v_stock9||'"},
          {value:"'||rec(i).makqty10||'"},
          {value:"'||rec(i).incqty10||'"},
          {value:"'||rec(i).planqty10||'"},    
          {value:"'||rec(i).v_stock10||'"},
          {value:"'||rec(i).makqty11||'"},
          {value:"'||rec(i).incqty11||'"},
          {value:"'||rec(i).planqty11||'"},    
          {value:"'||rec(i).v_stock11||'"},
          {value:"'||rec(i).makqty12||'"},
          {value:"'||rec(i).incqty12||'"},
          {value:"'||rec(i).planqty12||'"},    
          {value:"'||rec(i).v_stock12||'"},
          {value:"'||rec(i).makqty13||'"},
          {value:"'||rec(i).incqty13||'"},
          {value:"'||rec(i).planqty13||'"},    
          {value:"'||rec(i).v_stock13||'"},
          {value:"'||rec(i).makqty14||'"},
          {value:"'||rec(i).incqty14||'"},
          {value:"'||rec(i).planqty14||'"},    
          {value:"'||rec(i).v_stock14||'"},
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
  
END KSCM2107;

/
