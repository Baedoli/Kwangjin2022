--------------------------------------------------------
--  DDL for Package Body EXR1010
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "PREMIER"."EXR1010" 
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
        mygrid2.preventIECaching(false);
        myLayout.cells("b").attachURL(v_url_b);

        var v_url_a = "'||v_pkg||'.query_a?"+$("#form1").serialize();
        var v_url_b = "'||v_pkg||'.query_b";
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
      
      function setStatusBarText(rowCount) {
        sbObj.setText("'||get_fn('자료검색을 종료합니다..')||'"+ rowCount +" '||get_fn('건이 검색되었습니다.')||'");
      }
      
      function doQuery() {
        document.getElementById("form1").submit();
      }
      
      function excel() {  
        var thisForm = document.getElementById("form1");
        var page = "'||v_pkg||'.excel?p_date='||p_date||'";
        newWnd = window.open(page, "window2500", "top=100, left=100, status=yes, resizable=no, width=800, height=450");          
      }
      
      function excel_crRec() {
        var url = "'||v_pkg||'.excel_crRec?p_date='||p_date||'";
        var newWnd_c1 = window.open(url,"windowc1","top=0, left=100, status=no, resizable=no, menubar=no, scrollbars=yes, toolbar=no, location=no, width=800, height=300");
        newWnd_c1.focus();
      }
      
      $(function() {
        doOnLoad();  
        
        $("#p_date").datepicker({
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
          <div class="cTitle"><label for="p_date">'||get_fn('일자')||'</label></div>
          <div class="cInput">
            <input type="text" id="p_date" name="p_date" onchange="doQuery()" value="'||p_date||'" class="cDate">
          </div>
        </div>
            
      </div>
      <div id="c11">
        <a href="#" target="list" onclick="excel(); return false;" class="btn-excel buttons">'||get_fn('양식 다운로드')||'</a>
        <a href="#" target="list" onclick="excel_crRec(); return false;" class="btn-new buttons">'||get_fn('엑셀 업로드')||'</a>
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
            x[i]=["","0","center","ro","str","false"];i=i+1; // 소스환율코드                                 
            x[i]=["'||get_fn('소스환율코드')||'","200","left","ro","str","false"];i=i+1;
        
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
        
          function setStatusBarText(rowCount) {
            sbObj.setText("'||get_fn('자료검색을 종료합니다..')||'"+ rowCount +" '||get_fn('건이 검색되었습니다.')||'");
          }
      
          function doOnRowSelected(rowID,celInd){
            var tocoincd = mygrid.cells(rowID,1).getValue();
            var v_url_b = "'||v_pkg||'.query_b?p_tocoincd="+tocoincd+"&p_date='||p_date||'";
            parent.myLayout.cells("b").attachURL(v_url_b);
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
  
  PROCEDURE query_b
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
        var mygrid2;

          function doInitGrid2(){
            mygrid2 = new dhtmlXGridObject("mygrid_obj");
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
            
            x[i]=["'||get_fn('목적환율코드')||'", "100","center","ro","int","true"];i++;
            x[i]=["'||get_fn('환율')||'", "70","center","ron","str","true"]; mygrid2.setNumberFormat("0,000.000", i); i++;
            
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
            var url = "'||v_pkg||'.query_b_data"+window.location.search;

            mygrid2.load(url, "json");
            mygrid2.attachEvent("onXLE", function() {
              parent.setStatusBarText(mygrid2.getRowsNum());
              parent.myLayout.cells("b").progressOff();
            }); 
          }
        
          function setStatusBarText(rowCount) {
            sbObj.setText("'||get_fn('자료검색을 종료합니다..')||'"+ rowCount +" '||get_fn('건이 검색되었습니다.')||'");
          }
      
          $(function() {
            doInitGrid2();
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
  END query_b;
  
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
          {value:"'||rec(i).tocoincd||'"},
          {value:"'||get_catalog_name('COM', 'CURRENCY_NAME', v_lang,rec(i).tocoincd)||'"}
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
  
  PROCEDURE query_b_data
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
          {value:"'||get_catalog_name('COM', 'CURRENCY_NAME', v_lang,rec(i).fromcoincd)||'"},
          {value:"'||to_number(rec(i).rate)||'"}
        ]
      } ');
      
      if i < v_number then
        htp .p(',');
      end if;
      
    end loop;
    
    if v_number = 0 then
      htp.p('{[]}');
    end if;
    
    htp.p(']}');
  EXCEPTION
    when others then
      show_err('query_b_data'); 
  END query_b_data;
  
procedure excel
  (
    p_date in varchar2 default null
  )
  IS
    
  cursor cur is
    SELECT  *  
    FROM xm900  
    where ymd = ( select max(ymd)
                  from xm900
                  where ymd <= p_date )
    ;
  
  type r1 is table of cur%rowtype index by pls_integer;  
  rec r1;
  
  v_number number := 0;
                
  BEGIN  
  
    --env_init(); 
        
    open cur;
    fetch cur bulk collect into rec;
    close cur;
            
    v_number := rec.count;
    
    owa_util.mime_header ('application/vnd.ms-excel',false);
    htp.p('Content-disposition: filename=exchange_rate.xls' );
    owa_util.http_header_close ;
  
    htp.p('  
  
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">  
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">  
  <head>  
    <title>K-APS</title>  
    <meta http-equiv="Content-Type" content="application/xhtml+xml; charset=utf-8" />  
    <link rel="stylesheet" type="text/css" media="screen" href="/grid/dhtmlxGrid/codebase/dhtmlxgrid.css" />  
    <link rel="stylesheet" type="text/css" media="screen" href="/grid/dhtmlxGrid/codebase/dhtmlxgrid_skins.css" />  
    <link rel="stylesheet" type="text/css" media="screen" href="/include/dbv_eco.css" />  
    <script type="text/javascript" src="/include/jquery-latest.min.js"></script>  
    <script type="text/javascript" id="dym"></script>  
    
    <style type="text/css">    
      td {
          font-size: 9pt;
          mso-number-format: "\@";
      }
      td.txt {
          mso-number-format: \@;
      }
      td.day {
          mso-number-format: 0;
      } 
    </style> 
  </head>  
  <body>  
    <table border="1">  
      <thead>  
        <tr>  
          <th colspan = 2>'||get_fn('소스환율코드')||'</th>   
          <th colspan = 2>'||get_fn('목적환율코드')||'</th>
          <th style="width:80px">'||get_fn('환율')||'</th> 
        </tr> 
      </thead>       
      <tbody> ');  
      for i in 1 .. v_number loop    
        htp.p('  
        <tr> 
          <td>'||get_catalog_name('COM','CURRENCY_NAME',common.get_cookie('SYSLANG'),rec(i).tocoincd)||'</td>  
          <td>'||rec(i).tocoincd||'</td>
          <td>'||get_catalog_name('COM','CURRENCY_NAME',common.get_cookie('SYSLANG'),rec(i).fromcoincd)||'</td>  
          <td>'||rec(i).fromcoincd||'</td>
          <td></td>   
        </tr> ');                      
      end loop; htp.p('  
      </tbody>  
    </table>  
  </body>  
</html>  
  ');      
  
  end excel; 
  
  PROCEDURE excel_crrec
  (
    p_date in varchar2 default null
  )
  IS
  
  BEGIN  
        
    htp.p('
  <!DOCTYPE HTML>
  <html lang="ko">
  <head>
    <meta charset="UTF-8">
    <title>'||common.title||'</title> ');
    dbv_grid.print_env_rev;
    htp.p('      
    <script type="text/javascript">   

      $(function() {  
        $("#p_date").datepicker({
          changeMonth: true,
          changeYear: true,
          dateFormat: "yymmdd",
          buttonImage: "/image/calendar.gif",
          showOn: "focus", // focus, button, both
          showAnim: "fadeIn", //explode, fold, slideDown
          showOptions: {pieces: 1},
          duration: 500
        }) ;
      });   
      
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
    <form id="form1" name="form1" action="'||v_pkg||'.excel_process" method="post" enctype="multipart/form-data" >
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
                <td class="titletd require">'||get_fn('기준일자')||'</td>
                <td class="inputtd">
                  <input type="text" id="p_date" name="p_date" class="date" maxlength="8" value="'||p_date||'" />          
                </td>
              <tr>
              <tr>  
                <td class="titletd">'||get_fn('업로드_파일')||'</td>  
                <td class="inputtd" colspan ="4"> '||get_fn('CSV 파일로 변경후 로드해주세요.')||'  
                  <input type="file" id="p_file_name" name="p_file_name" class="txtbox" style="width: 99%;" /> 
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
  END excel_crrec;
  
  
  PROCEDURE excel_process  
  (   
    p_date in varchar2 default null,  
    p_dml_gubun in varchar2 default null, 
    p_file_name in varchar2 default null
  )  
  IS  
  
  BEGIN  

    if p_dml_gubun = '1' then  
    
      if p_file_name is not null then
       
        begin
					select 	name, file_name
					into		v_full_file_name, v_file_name
					from (	select 	name, doc_size, file_name
									from 		qis_upload_file
									where 	name = p_file_name
									order by 	last_updated desc	)
					where 	rownum = 1;
	      exception
	      	when others then
	      		null;
	      end; 

        if v_file_name is not null then  
          BLOB_TO_FILE(v_full_file_name, 'exr.csv', 'QMS_DIR');  
        end if;   
                
        exr1010.excel_load(p_date);
  
      end if; 
       
        htp.p('
        <script type="text/javascript">
          alert("'||get_fn( '저장되었습니다.')||'");
          opener.location.reload();
          self.close();  
        </script>
        ');
        
    elsif p_dml_gubun = '2' then 
    
      begin
        delete xm900
        where ymd = p_date;
      end;   
          
       htp.p('  
        <script type="text/javascript">  
          alert("' ||get_fn( '삭제되었습니다.')|| '");  
          opener.location.reload();
          self.close();  
        </script>  
       ');  
       
    end if;
      
  exception  
    when others then  
      show_err('excel_process');    
  END excel_process;   
  
  PROCEDURE excel_load
  (  
    p_date in varchar2 default null
  )  
  IS  
  
  cursor cur is  
    select rownum rowseq,   
           trim(f1) f1,     -- 소스환율명
           lpad(trim(f2),2,0) f2,     -- 소스환율코드
           trim(f3) f3,     -- 목적환율명
           lpad(trim(f4),2,0) f4,     -- 목적환율코드
           nvl(replace(replace(trim(f5), chr(13), ''), ',', ''), 0) f5     -- 환율
    from QIS_EXCEL_LOADER_EXR a
    ;  
    
    v_cnt number := 0;  
    v_start number := 1; --엑셀 데이터 시작 포인트
    v_ser number := 0;
  
  BEGIN  

    for rec in cur loop  
      
      v_cnt := v_cnt + 1;
      
      if v_cnt = 1 then -- 일단 지우고 시작한다. 
        begin  
          delete 
          from xm900   
          where ymd = p_date;            
          null; 
        end;  
        
      end if;  

      if v_cnt > v_start then  
        
        begin    
          insert into xm900   
          ( ymd, tocoincd, fromcoincd, rate, login_id, login_ymd )  
          values  
          ( p_date, rec.f2, rec.f4, to_number(rec.f5), common.get_cookie('SYSID'), sysdate);  
             null;
        exception  
          when others then  
            show_err;
        end;  
        
      end if;  
        
    end loop;  
    
  EXCEPTION  
    when others then  
      show_err('excel_load');
  END excel_load;
  
  procedure check_key 
  (
    p_date in varchar2 default null
  )
  is
    cursor cur is
      select  'Y'
      from xm900
      where ymd = p_date;
      
    v_return varchar2(20);
    
  begin
    
    open cur;
    fetch cur into v_return;
    if cur%notfound then
      v_return := null;
    end if;
    close cur;
    
    if v_return is not null then
      htp.p(v_return);
    end if;
    
  exception  
    when others then
      show_err;
  end check_key;
  
END exr1010;

/
