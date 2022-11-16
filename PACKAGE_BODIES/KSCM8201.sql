--------------------------------------------------------
--  DDL for Package Body KSCM8201
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "PREMIER"."KSCM8201" 
IS
  PROCEDURE control
  (
    p_companycd in varchar2 default common.get_cookie('SYSCOMP'),
    p_yy in  varchar2 default to_char(sysdate,'yyyymm')
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
        myLayout.cells("a").setWidth(360);
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
          dateFormat: "yymm",
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
          <div class="cTitle"><label for="p_yy">'||get_fn('기준년월')||'</label></div>
          <div class="cInput">
            <input type="text" id="p_yy" name="p_yy" maxlength="6" class="cDate" value="'||p_yy||'" />   
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
    p_yy in  varchar2 default null
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
            x[i]=["'||get_fn('대급지급기준')||'", "*","center","ron","int","true"];mygrid.setNumberFormat("0,000", i);i++;
            x[i]=["'||get_fn('금액')||'", "160","center","ron","int","true"];mygrid.setNumberFormat("0,000", i);i++;

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
            
            var v_footer2="";   
            var y = new Array(100);   
            var cm2 = "";   
            var b=0; 
              
            y[b]=["'||get_fn('')||'"];b++;   
            y[b]=["'||get_fn('Total')||'"];b++;   
            y[b]=["'||replace(to_char(v_data1,'fm999,999,999,999'),',','&#44;')||'"];b++;   
            
            for(i=0;i<b;i++){       
              if(i==0) cm2="";         
              else cm2=",";         
              v_footer2=v_footer2+cm2+y[i][0];   
            }   
        
            mygrid.attachFooter(v_footer2,[ "font-style:normal;text-align:center;",
                                            "font-style:normal;text-align:center;",  
                                            "font-style:normal;text-align:right;"]);
                                            
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
      select '50000' as gubun, '124556' as gold from dual
      union
      select '40000' as gubun, '214556' as gold from dual
      union
      select '90000' as gubun, '424556' as gold from dual
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
          {value:"'||rec(i).gubun||'"},
          {value:"'||rec(i).gold||'"}
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
            x[i]=["'||get_fn('품번')||'","#rspan","120","center","ro","str","false"];i=i+1;   
            x[i]=["'||get_fn('품명')||'","#rspan","200","center","ro","str","false"];i=i+1;   
            x[i]=["'||get_fn('단가')||'","#rspan","80","center","ron","int","false"];mygrid.setNumberFormat("0,000", i);i=i+1;   
            x[i]=["'||get_fn('결제금액')||'","#rspan","80","center","ron","int","false"];mygrid.setNumberFormat("0,000", i);i=i+1;   
            x[i]=["'||get_fn('대금수량')||'","#rspan","80","center","ron","int","false"];mygrid.setNumberFormat("0,000", i);i=i+1;   
            x[i]=["'||get_fn('금액')||'","#rspan","80","center","ron","int","false"];mygrid.setNumberFormat("0,000", i);i=i+1;   
            x[i]=["'||get_fn('소급수량')||'","#rspan","80","center","ron","int","false"];mygrid.setNumberFormat("0,000", i);i=i+1;   
            x[i]=["'||get_fn('금액')||'","#rspan","80","center","ron","int","false"];mygrid.setNumberFormat("0,000", i);i=i+1;   
            x[i]=["'||get_fn('기초재고')||'","'||get_fn('창고')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000", i);i=i+1; 
            x[i]=["#cspan","'||get_fn('라인')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000",i);i=i+1;  
            x[i]=["#cspan","'||get_fn('Assy/Sub')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000",i);i=i+1; 
            x[i]=["'||get_fn('입고')||'","'||get_fn('실입고')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000", i);i=i+1; 
            x[i]=["#cspan","'||get_fn('금액')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000",i);i=i+1;  
            x[i]=["'||get_fn('창고출고')||'","'||get_fn('업체')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000", i);i=i+1; 
            x[i]=["#cspan","'||get_fn('라인')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000",i);i=i+1;  
            x[i]=["#cspan","'||get_fn('영업')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000",i);i=i+1;  
            x[i]=["#cspan","'||get_fn('기타')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000",i);i=i+1;  
            x[i]=["'||get_fn('영업')||'","'||get_fn('납품')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000", i);i=i+1; 
            x[i]=["#cspan","'||get_fn('직납')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000",i);i=i+1;  
            x[i]=["'||get_fn('기말재고')||'","'||get_fn('창고')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000", i);i=i+1; 
            x[i]=["#cspan","'||get_fn('라인')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000",i);i=i+1;  
            x[i]=["#cspan","'||get_fn('Assy/Sub')||'","80","right","ron","int","false"];mygrid.setNumberFormat("0,000",i);i=i+1;  

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
      select '9170-2335' as partno
            ,'DEG ASSY-PR LH' as partnm
            ,'16824' as dan
            ,'26824' as pay
            ,'36824' as goldqty
            ,'46824' as charge
            ,'56824' as smallqty
            ,'66824' as charge2
            ,'76824' as changgo
            ,'86824' as line
            ,'96824' as assy_sub
            ,'16824' as silip
            ,'26824' as charge3
            ,'12824' as upche
            ,'36824' as line2
            ,'46824' as youngup
            ,'56824' as gita
            ,'66824' as sendd
            ,'76824' as directsend
            ,'86824' as changgo2
            ,'16824' as link3
            ,'96824' as assy_sub2
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
          {value:"'||rec(i).partno||'"},
          {value:"'||rec(i).partnm||'"},
          {value:"'||rec(i).dan||'"},
          {value:"'||rec(i).pay||'"},
          {value:"'||rec(i).goldqty||'"},
          {value:"'||rec(i).charge||'"},
          {value:"'||rec(i).smallqty||'"},
          {value:"'||rec(i).charge2||'"},
          {value:"'||rec(i).changgo||'"},
          {value:"'||rec(i).line||'"},
          {value:"'||rec(i).assy_sub||'"},
          {value:"'||rec(i).silip||'"},
          {value:"'||rec(i).charge3||'"},
          {value:"'||rec(i).upche||'"},
          {value:"'||rec(i).line2||'"},
          {value:"'||rec(i).youngup||'"},
          {value:"'||rec(i).gita||'"},
          {value:"'||rec(i).sendd||'"},
          {value:"'||rec(i).directsend||'"},
          {value:"'||rec(i).changgo2||'"},
          {value:"'||rec(i).link3||'"},
          {value:"'||rec(i).assy_sub2||'"}
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
 
END kscm8201;

/
