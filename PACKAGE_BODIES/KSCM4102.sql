--------------------------------------------------------
--  DDL for Package Body KSCM4102
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "PREMIER"."KSCM4102" 
IS
  PROCEDURE control
  (
    p_companycd in varchar2 default common.get_cookie('SYSCOMP'),
    p_yy in  varchar2 default to_char(sysdate,'yyyymmdd')
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
        myLayout = new dhtmlXLayoutObject(document.body, "2U","dhx_skyblue");
        myLayout.cells("a").setText("■ Sample");
        myLayout.cells("a").hideHeader();
        myLayout.cells("b").hideHeader();
        //myLayout.cells("b").hideHeader();
        myLayout.cells("a").setWidth(170);
        //myLayout.cells("b").setHeight(260);
        myLayout.cells("a").fixSize(true, true);
        mygrid = myLayout.cells("a").attachGrid();
        mygrid.preventIECaching(false);
        var v_url_a = "'||v_pkg||'.query_a?"+$("#form1").serialize();
        var v_url_b = "'||v_pkg||'.query_b?";
        myLayout.cells("a").progressOn();
        myLayout.cells("b").progressOn();
        myLayout.cells("a").attachURL(v_url_a);
        myLayout.cells("b").attachURL(v_url_b);
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
    <input type="hidden" name="p_companycd" value="'||p_companycd||'"/>
    <div id="c00">
      <div id="c01">
      
        <div class="cBox">
          <div class="cTitle"><label for="p_yy">'||get_fn('기준일')||'</label></div>
          <div class="cInput">
            <input type="text" id="p_yy" name="p_yy" maxlength="8" class="cDate" value="'||p_yy||'" />   
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
    p_yy in  varchar2 default null
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
            
            x[i]=["NO", "40","center","ro","int","true"];i++;
            x[i]=["'||get_fn('차수')||'", "*","center","ro","str","true"];i++;
            
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
    p_yy in  varchar2 default null
  )
  IS
    cursor cur is
      select 'chasu88' as gubun from dual
      union
      select 'chasu12' as gubun from dual
      union
      select 'chasu42' as gubun from dual
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
      htp .p('
      { id:' ||i|| ',
        data:[
          {value:"'||i||'"},
          {value:"'||rec(i).gubun||'"}
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
  
  PROCEDURE query_b
  (
    p_companycd in varchar2 default null,
    p_yy in  varchar2 default null
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
            
            x[i]=["NO", "40","center","ro","int","true"];i++;
            x[i]=["'||get_fn('차수')||'", "50","center","ro","str","true"];i++;
            x[i]=["'||get_fn('순번')||'", "50","center","ro","str","true"];i++;
            x[i]=["'||get_fn('일자')||'", "80","left","ro","str","true"];i++;
            x[i]=["'||get_fn('시간')||'", "50","left","ro","str","true"];i++;
            x[i]=["'||get_fn('품번')||'", "100","left","ro","str","true"];i++;
            x[i]=["'||get_fn('품명')||'", "150","left","ro","str","true"];i++;
            x[i]=["'||get_fn('수량')||'", "80","left","ron","int","true"];mygrid.setNumberFormat("0,000", i);i++;
            x[i]=["'||get_fn('LOT')||'", "80","left","ron","int","true"];mygrid.setNumberFormat("0,000", i);i++;
            x[i]=["'||get_fn('창고')||'", "*","center","ro","str","true"];i++;

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
            //mygrid.attachEvent("onRowSelect",doOnRowSelected);
            var url = "'||v_pkg||'.query_b_data?";
            mygrid.load(url, "json");
            mygrid.attachEvent("onXLE", function() {
              parent.setStatusBarText(mygrid.getRowsNum());
              parent.myLayout.cells("b").progressOff();
            }); 
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
      <div id="mygrid_obj" style="width:100%;height:100%;"></div>
    </body>
  </html> ');
  EXCEPTION
    WHEN OTHERS THEN
      show_err('query_b');
  END query_b;
  
  PROCEDURE query_b_data
  (
    p_companycd in varchar2 default null,
    p_yy in  varchar2 default null
  )
  IS
    cursor cur is
      select '2' as chasu
            ,'3' as ordno
            ,'22/11/14' as ymd
            ,'6' as nowtime
            ,'11568-44874' as partno
            ,'canival' as partnm
            ,'11452' as qty
            ,'1514' as lotno
            ,'유럽' as changgo
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
      htp .p('
      { id:' ||i|| ',
        data:[
          {value:"'||i||'"},
          {value:"'||rec(i).chasu||'"},
          {value:"'||rec(i).ordno||'"},
          {value:"'||rec(i).ymd||'"},
          {value:"'||rec(i).nowtime||'"},
          {value:"'||rec(i).partno||'"},
          {value:"'||rec(i).partnm||'"},
          {value:"'||rec(i).qty||'"},
          {value:"'||rec(i).lotno||'"},
          {value:"'||rec(i).changgo||'"}
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
      show_err('query_b_data'); 
  END query_b_data;
 
END kscm4102;

/
