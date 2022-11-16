--------------------------------------------------------
--  DDL for Package Body KSCM2101
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "PREMIER"."KSCM2101" 
IS
  PROCEDURE control
  (
    p_companycd in varchar2 default common.get_cookie('SYSCOMP'),
    p_yy in  varchar2 default to_char(sysdate,'yyyy'),
    p_mode in varchar2 default 'A'
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
          <div class="cTitle"><label for="p_yy">'||get_fn('기준년도')||'</label></div>
          <div class="cInput">
            <select name="p_yy" id="p_yy">
            '); list_year(p_yy); htp.p('
            </select>
          </div>
        </div>
        <div class="cBox">
          <div class="cTitle"><label for="p_mode"></label></div>
          <div class="cInput">
            '); common.list_catalog('SCM','SCM1101',p_mode,'input', 'radio', 'p_mode', 'z', 'yes'); htp.p('
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
    p_mode in varchar2 default null
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
            x[i]=["'||get_fn('차종')||'", "120","center","ro","str","true"];i++;
            x[i]=["'||get_fn('사업구분')||'", "100","center","ro","str","true"];i++;
            x[i]=["'||get_fn('품번')||'", "170","left","ro","str","true"];i++;
            x[i]=["'||get_fn('품명')||'", "170","left","ro","str","true"];i++;
            
            '); for i in 1..12 loop htp.p('
            x[i]=["'||get_fn(i||'월')||'", "80","center","ron","int","true"];mygrid.setNumberFormat("0,000", i);i++;     
            '); end loop;  htp.p('
            
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
    p_yy in  varchar2 default null,
    p_mode in varchar2 default null
  )
  IS
    cursor cur is
      select '9BUB/YC-K_KJM' as kindnm
            ,'1' as gubun
            ,'4270-2335' as partno
            ,'REG ASSY-PR LH' as partnm
            ,1111 as m01
            ,1112 as m02
            ,1113 as m03
            ,1114 as m04
            ,1115 as m05
            ,1116 as m06
            ,1117 as m07
            ,1118 as m08
            ,1119 as m09
            ,1120 as m10
            ,1121 as m11
            ,1121 as m12
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
          {value:"'||rec(i).kindnm||'"},
          {value:"'||rec(i).gubun||'"},
          {value:"'||rec(i).partno||'"},
          {value:"'||rec(i).partnm||'"},
          {value:"'||rec(i).m01||'"},
          {value:"'||rec(i).m02||'"},
          {value:"'||rec(i).m03||'"},
          {value:"'||rec(i).m04||'"},
          {value:"'||rec(i).m05||'"},
          {value:"'||rec(i).m06||'"},
          {value:"'||rec(i).m07||'"},
          {value:"'||rec(i).m08||'"},
          {value:"'||rec(i).m09||'"},
          {value:"'||rec(i).m10||'"},
          {value:"'||rec(i).m11||'"},
          {value:"'||rec(i).m12||'"}
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
  
END kscm2101;

/
