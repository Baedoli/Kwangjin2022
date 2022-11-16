--------------------------------------------------------
--  DDL for Package Body SAMPLE_CHART
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "PREMIER"."SAMPLE_CHART" 
IS
  PROCEDURE control
  (
    p_companycd in varchar2 default common.get_cookie('SYSCOMP'),
    p_yy in varchar2 default to_char(sysdate,'yyyy')
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
        myLayout = new dhtmlXLayoutObject(document.body, "2E","dhx_skyblue");

          
        myLayout.cells("a").setText("■ Sample");
        //myLayout.cells("a").hideHeader();
        //myLayout.cells("b").hideHeader();
        //myLayout.cells("a").setWidth(600);
        //myLayout.cells("b").setHeight(260);
        myLayout.cells("a").fixSize(true, true);
        mygrid = myLayout.cells("a").attachGrid();
        mygrid.preventIECaching(false);
        var v_url_a = "'||v_pkg||'.query_a?"+$("#form1").serialize();
        myLayout.cells("a").attachURL(v_url_a);
        attachHeader();
      }
      
      function attachHeader() {
        myLayout.attachHeader("top-header");
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
    <input type="hidden" name="p_companycd" value="'||p_companycd||'" />
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
 
END sample_chart;

/
