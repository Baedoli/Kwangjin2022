--------------------------------------------------------
--  DDL for Package Body EXR1010_YC_2
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "PREMIER"."EXR1010_YC_2" 
IS
  PROCEDURE control
  (
    p_date in varchar2 default to_char(sysdate,'yyyymmdd')
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
        myLayout.cells("a").setWidth(600);
        myLayout.cells("b").setHeight(260);
        myLayout.cells("a").fixSize(true, true);
        mygrid = myLayout.cells("a").attachGrid();
        mygrid2 = myLayout.cells("b").attachGrid();
        mygrid.preventIECaching(false);
        var v_url_a = "'||v_pkg||'.query_a?"+$("#form1").serialize();
        var v_url_b = "'||v_pkg||'.query_a";
        myLayout.cells("a").progressOn();
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
          <div class="cTitle"><label for="p_date">'||get_fn('일자')||'</label></div>
          <div class="cInput">
            <input type="text" id="p_date" name="p_date" class="date" maxlength="8" value="'||p_date||'" />          
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
    p_date in varchar2 default null
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
        var mygrid;
        var mygrid2;

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
            
            x[i]=["'||get_fn('순번')||'", "50","center","ro","int","true"];i++;
            x[i]=["'||get_fn('소스환율코드')||'", "200","center","ro","str","true"];i++;
            
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
            mygrid.attachEvent("onRowSelect",doOnRowSelected);
            var url = "'||v_pkg||'.query_a_data"+window.location.search;
            mygrid.load(url, "json");
            mygrid.attachEvent("onXLE", function() {
              parent.setStatusBarText(mygrid.getRowsNum());
              parent.myLayout.cells("a").progressOff();
            }); 
          }
        
          function doInitGrid2(){
            mygrid2 = new dhtmlXGridObject("mygrid_obj2");
            mygrid2.setImagePath("/grid451/skins/web/imgs/dhxgrid_web/");
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
            
            x[i]=["'||get_fn('목적환율코드')||'", "150","center","ro","int","true"];i++;
            x[i]=["'||get_fn('환율')||'", "100","center","ro","str","true"];i++;
            
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
            
            mygrid2.setHeader(v_header);
            mygrid2.setInitWidths(v_width);
            mygrid2.setColAlign(v_align);
            mygrid2.setColTypes(v_types);
            mygrid2.enableColumnMove(true);
            mygrid2.enableCollSpan(false);
            mygrid2.enableTooltips(v_tooltip);
            mygrid2.setColSorting(v_sorting);
            mygrid2.enableEditEvents(false,true,false);
            mygrid2.enableRowsHover(true,"grid_hover");
            mygrid2.init();
            mygrid2.enableHeaderMenu();
            mygrid2.enableDistributedParsing(true,10,300);
            mygrid2.preventIECaching(false);
            mygrid2.setSkin("dhx_web");
          }
          
          function setStatusBarText(rowCount) {
              sbObj.setText("'||get_fn('자료검색을 종료합니다..')||'"+ rowCount +" '||get_fn('건이 검색되었습니다.')||'");
            }
      
          function doOnRowSelected(rowID,celInd){
            var tocoincd = mygrid.cells(rowID,1).getValue();
            var v_url_b = "'||v_pkg||'.query_a_data_2?p_tocoincd="+tocoincd+"&p_date='||p_date||'";
            parent.myLayout.cells("b").attachURL(v_url_b);
          }
          
          $(function() {
            doInitGrid();
            doInitGrid2();
          });
          
        </script>
      </head>
    <body>
      <div id="mygrid_obj" style="width:100%;height:100%;"></div>
      <div id="mygrid_obj2" style="width:100%;height:100%;"></div>
    </body>
  </html> ');
  EXCEPTION
    WHEN OTHERS THEN
      show_err('query_a');
  END query_a;
  
  PROCEDURE query_a_data
  (
    p_date in varchar2 default null,
    p_tocoincd in varchar2 default null
  )
  IS
    cursor cur is
      select  tocoincd
      from    xm900
      group by  tocoincd
      order by  tocoincd
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
    
      htp .p('
      { id:' ||i|| ',
        data:[
          {value:"'||i||'"},
          {value:"'||rec(i).tocoincd||'"}
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
  
  PROCEDURE query_a_data_2
  (
    p_date in varchar2 default null,
    p_tocoincd in varchar2 default null
  )
  IS
    cursor cur is
       SELECT  *  
      FROM    xm900  
      where   tocoincd = p_tocoincd
      and     ymd = ( select max(ymd)
                      from xm900
                      where ymd <= p_date )
      order by  fromcoincd
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
    
      htp .p('
      { id:' ||i|| ',
        data:[
          {value:"'||rec(i).fromcoincd||'"},
          {value:"'||rec(i).rate||'"}
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
      show_err('query_a_data_2'); 
  END query_a_data_2;
  
  PROCEDURE process
  (
    p_companycd in varchar2 default null,
    p_dml_gubun in varchar2 default null
  )
  IS
  
  BEGIN
    
    if p_dml_gubun = '1' then
      
    
      htp.p('
        <script type="text/javascript">
          alert("'||get_fn( '저장되었습니다.')||'");
          opener.location.reload();
          location.href = "'||v_pkg||'.crrec?p_companycd='||p_companycd||'";
        </script>
        ');
    
    elsif p_dml_gubun = '2' then
      
    
    
      htp .p(' 
        <script type="text/javascript"> 
          alert("' ||get_fn( '삭제되었습니다.')|| '"); 
          opener.location.reload();
          self.close(); 
        </script> 
        ' );
        
    end if;
  
  
  EXCEPTION
    when others then 
      show_err('process');
  END process;
 
END exr1010_yc_2;

/