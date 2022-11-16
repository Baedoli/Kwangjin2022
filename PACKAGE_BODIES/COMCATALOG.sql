--------------------------------------------------------
--  DDL for Package Body COMCATALOG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "PREMIER"."COMCATALOG" 
IS
  PROCEDURE control
  (
    p_systemcd in varchar2 default null,
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
      
      function setStatusBarText(rowCount) {
        sbObj.setText("'||get_fn('자료검색을 종료합니다..')||'"+ rowCount +" '||get_fn('건이 검색되었습니다.')||'");
      }
      
      function doQuery() {
        document.getElementById("form1").submit();
      }
      
      function doCrrec() {  
        var url = "'||v_pkg||'.crrec?";  
        newWnd2 = window.open(url,"'||v_pkg||'window","top=100, left=100, status=yes, resizable=no, scrollbars=yes, width=1252, height=700");  
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
            '); common.list_systemcd(p_systemcd, 'a'); htp.p('
            </select>
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
            
            x[i]=["'||get_fn('코드명')||'", "200","left","link","str","true"];i++;
            x[i]=["'||get_fn('코드내용')||'", "*","left","ro","str","true"];i++;
            x[i]=["'||get_fn('사용여부')||'", "130","center","ro","str","true"];i++;

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
            console.log(obj2);
            url ="'||v_pkg||'.crrec?p_systemcd="+obj1+"&p_catalogcd="+obj2;
            newWnd2 = window.open(url,"'||v_pkg||'window","top=100, left=100, status=yes, resizable=no, scrollbars=yes, width=1252, height=700");  
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
    p_descr in varchar2 default null
  )
  IS
    cursor cur is
      select  systemcd, catalogcd, descr, useyn
      from    c_0050
      where   nvl(systemcd, '*') = nvl(p_systemcd, nvl(systemcd, '*'))
      and     upper(nvl(descr, '*')) like upper('%'||p_descr||'%')
      order by  catalogcd
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
      v_link := '^javascript:link_(\"'||rec(i).systemcd||'\", \"'||rec(i).catalogcd||'\")^_self';
      htp .p('
      { id:' ||i|| ',
        data:[
          {value:"'||rec(i).catalogcd||v_link||'"},
          {value:"'||rec(i).descr||'"},
          {value:"'||rec(i).useyn||'"},
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
    p_catalogcd in varchar2 default null,
    p_listvalue in varchar2 default null,
    p_useyn in varchar2 default 'Y'
  )
  IS
  
    cursor cur (p_listvalue in varchar2) is
      select  distinct b.listvalue,
              b.listorder,
              a.systemcd,
              a.catalogcd,
              a.descr,
              b.useyn,
              ( select  listdescr
                from    c_0051 
                where   systemcd = b.systemcd
                and     catalogcd = b.catalogcd
                and     listvalue = b.listvalue
                and     lang = 'KO'    ) ko,
              ( select  listdescr
                from    c_0051
                where   systemcd = b.systemcd
                and     catalogcd = b.catalogcd
                and     listvalue = b.listvalue
                and     lang = 'EN'    ) en,
              ( select  listdescr
                from    c_0051
                where   systemcd = b.systemcd
                and     catalogcd = b.catalogcd
                and     listvalue = b.listvalue
                and     lang = 'CH'    ) ch,
              ( select  listdescr
                from    c_0051
                where   systemcd = b.systemcd
                and     catalogcd = b.catalogcd
                and     listvalue = b.listvalue
                and     lang = 'SP'    ) sp,
              ( select  listdescr
                from    c_0051
                where   systemcd = b.systemcd
                and     catalogcd = b.catalogcd
                and     listvalue = b.listvalue
                and     lang = 'VN'    ) vn,
              ( select  listdescr
                from    c_0051
                where   systemcd = b.systemcd
                and     catalogcd = b.catalogcd
                and      listvalue = b.listvalue
                and      lang = 'PL'    ) pl
      from    c_0050 a, 
              ( select  *
                from    c_0051
                where   listvalue = p_listvalue
              ) b
      where   a.systemcd = b.systemcd(+)
      and     a.catalogcd = b.catalogcd(+)
      and     a.systemcd = p_systemcd
      and     a.catalogcd = p_catalogcd
      ;     
      
      rec cur %rowtype;

    cursor cur2 is
      select  systemcd, catalogcd, listvalue, listorder, useyn,
           (  select    listdescr
              from      c_0051
              where     systemcd = a.systemcd
              and       catalogcd = a.catalogcd
              and       listvalue = a.listvalue
              and       lang = 'KO'    ) ko,
           (  select    listdescr
              from      c_0051
              where     systemcd = a.systemcd
              and       catalogcd = a.catalogcd
              and       listvalue = a.listvalue
              and       lang = 'EN'    ) en,
           (  select    listdescr
              from      c_0051
              where     systemcd = a.systemcd
              and       catalogcd = a.catalogcd
              and       listvalue = a.listvalue
              and       lang = 'CH'    ) ch,
           (  select    listdescr
              from      c_0051
              where     systemcd = a.systemcd
              and       catalogcd = a.catalogcd
              and       listvalue = a.listvalue
              and       lang = 'SP'    ) sp,
           (  select    listdescr
              from      c_0051
              where     systemcd = a.systemcd
              and       catalogcd = a.catalogcd
              and       listvalue = a.listvalue
              and       lang = 'VN'    ) vn,
           (  select    listdescr
              from      c_0051
              where     systemcd = a.systemcd
              and       catalogcd = a.catalogcd
              and       listvalue = a.listvalue
              and       lang = 'PL'    ) pl
      from    c_0051 a
      where   systemcd = p_systemcd
      and     catalogcd = upper(p_catalogcd)
--      and     useyn = 'Y'
      group by 	systemcd, catalogcd, listvalue, listorder, useyn      
      order by  listorder;
      
      type r2 is table of cur2%rowtype index by pls_integer;
      rec2 r2;
    
    v_disabled varchar(20);
    v_link2 varchar2(100) := null;

  BEGIN  
        
      open cur(p_listvalue);
      fetch cur into rec;
      close cur;
  
      open cur2;  
      fetch cur2 bulk collect into rec2;  
      close cur2; 
    
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
 
          $(function(){   
            doInitGrid2();
          });
        
          function proc_save() {
            var thisForm = document.getElementById("form1");
            
            //필수값 체크
            if(!formRquried()){
              return false;  
            }     
              
            if  (!document.getElementById("p_ko").value && !document.getElementById("p_en").value
                && !document.getElementById("p_ch").value && !document.getElementById("p_sp").value
                && !document.getElementById("p_vn").value && !document.getElementById("p_pl").value){
                  alert("' ||get_fn( '언어 입력을 해주십시오.')|| '"); 
                  return false;
            }
           
            if (!confirm("'||get_fn('저장하시겠습니까?')||'")) return false;
            $("#p_systemcd").removeAttr("disabled");
            $("#p_catalogcd").removeAttr("disabled");
            thisForm.p_dml_gubun.value = "1";
            thisForm.submit(); 
          }    

          function proc_del() {    
            var thisForm = document.getElementById("form1");
      
            if (!confirm("'||get_fn('삭제하시겠습니까?')||'")) return false;    
            $("#p_systemcd").removeAttr("disabled");
            $("#p_catalogcd").removeAttr("disabled");
            thisForm.p_dml_gubun.value = "2";    
            thisForm.submit();   
          } 
          
          function proc_all_del() {
            thisForm = document.forms[0];
            if (!confirm("'||get_fn('삭제하시겠습니까?')||'")) return false;   
            $("#p_systemcd").removeAttr("disabled");
            $("#p_catalogcd").removeAttr("disabled"); 
            thisForm.p_dml_gubun.value = "3";
            thisForm.submit();
          }
    
          function toView(obj1, obj2, obj3){
            url ="'||v_pkg||'.crrec?p_systemcd="+obj1+"&p_catalogcd="+obj2+"&p_listvalue="+obj3;
            newWnd2 = window.open(url,"'||v_pkg||'window","top=100, left=100, status=yes, resizable=no, scrollbars=yes, width=1000, height=700");  
            newWnd2.focus();
          }
          
          data={ rows:[           
            ');  
          
            for i in 1 .. rec2.count loop  
               
              v_link2 := '^javascript:toView(\"'||rec2(i).systemcd||'\",\"'||rec2(i).catalogcd||'\",\"'||rec2(i).listvalue||'\")^_self';

              htp.p('
                { id:'||i||',
                  data:[
                    {value:"'||return_html_text(rec2(i).listvalue)||v_link2||'"},
                    {value:"'||return_html_text(rec2(i).listorder)||'"},
                    {value:"'||return_html_text(rec2(i).ko)||'"},
                    {value:"'||return_html_text(rec2(i).en)||'"},
                    {value:"'||return_html_text(rec2(i).ch)||'"},
                    {value:"'||return_html_text(rec2(i).sp)||'"},
                    {value:"'||return_html_text(rec2(i).vn)||'"},
                    {value:"'||return_html_text(rec2(i).pl)||'"},
                    {value:"'||return_html_text(rec2(i).useyn)||'"}
                  ]
                }
              ');
              
              if i < rec2.count then
                htp.p(',');
              end if;
            end loop;
            
            if rec2.count = 0 then
                htp.p('{ id:1, data:[ "" ] }');
            end if;
          
            htp.p('           
              ]
            }           
            var mygrid;       
                
          function doInitGrid2(){
            mygrid2 = new dhtmlXGridObject("mygrid_container");
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
            
            x[i]=["'||get_fn('코드')||'","100","center","link","str","false"];i=i+1;
            x[i]=["'||get_fn('순서')||'","100","center","ro","str","false"];i=i+1;
            x[i]=["'||get_fn('한국어')||'","150","center","ro","str","false"];i=i+1;
            x[i]=["'||get_fn('영어')||'","150","center","ro","str","false"];i=i+1;
            x[i]=["'||get_fn('중국어')||'","150","center","ro","str","false"];i=i+1;
            x[i]=["'||get_fn('스페인어')||'","150","center","ro","str","false"];i=i+1;
            x[i]=["'||get_fn('베트남어')||'","150","center","ro","str","false"];i=i+1;
            x[i]=["'||get_fn('폴란드어')||'","150","center","ro","str","false"];i=i+1;
            x[i]=["'||get_fn('사용여부')||'","150","center","ro","str","false"];i=i+1;

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
           
            mygrid2.parse(data,"json");  
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
                <a href="#" class="btn-delete buttons" onclick="proc_all_del(); return false;">'||get_fn('전체 삭제')||'</a>&nbsp;
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
                        '); common.list_systemcd(p_systemcd, 'c'); htp.p('
                      </select>  
                    </td>
                    <td class="titletd require">'||get_fn('코드명')||'</td>
                    <td class="inputtd">
                      <input type="text" id="p_catalogcd" name="p_catalogcd" '||v_disabled||' value="'||rec.catalogcd||'" /> 
                    </td>
                  </tr>
                 
                  <tr>
                    <td class="titletd">'||get_fn('코드내용')||'</td>
                    <td class="inputtd">
                      <input type="text" id="p_descr" name="p_descr" value="'||rec.descr||'" /> 
                      </td>
                    </td>
                    <td class="titletd require">'||get_fn('코드사용여부')||'</td>
                    <td class="inputtd">
                      '); common.list_catalog('COM','USEYN',nvl(rec.useyn, 'Y'),'select', null, 'p_useyn', 'c', 'yes'); htp.p(' 
                    </td>
                  </tr>
                  
                  <tr>
                    <td class="titletd require">'||get_fn('코드')||'</td>
                    <td class="inputtd"> 
                      <input type="text" id="p_listvalue" name="p_listvalue" value="'||rec.listvalue||'" /> 
                    </td>
                    <td class="titletd">'||get_fn('순서')||'</td>
                    <td class="inputtd">
                      <input type="text" id="p_listorder" name="p_listorder" value="'||rec.listorder||'" /> 
                    </td>
                  </tr>
                  
                   <tr>
                  <td class="titletd">'||get_fn('한국어')||'</td>
                  <td class="inputtd" colspan="4">
                    <input type="text" id="p_ko" name="p_ko" value="'||rec.ko||'" /> 
                  </td>
                 <td></td>
                </tr>
                <tr>
                  <td class="titletd">'||get_fn('영어')||'</td>
                  <td class="inputtd" colspan="4">
                    <input type="text" id="p_en" name="p_en" value="'||rec.en||'" /> 
                  </td>
                  <td></td>
                </tr>
                <tr>
                  <td class="titletd">'||get_fn('중국어')||'</td>
                  <td class="inputtd" colspan="4">
                    <input type="text" id="p_ch" name="p_ch" value="'||rec.ch||'" /> 
                  </td>
                  <td></td>
                </tr>
                <tr>
                  <td class="titletd">'||get_fn('스페인어')||'</td>
                  <td class="inputtd" colspan="4">
                    <input type="text" id="p_sp" name="p_sp" value="'||rec.sp||'" /> 
                  </td>
                  <td></td> 
                </tr>
                <tr>
                  <td class="titletd">'||get_fn('폴란드어')||'</td>
                  <td class="inputtd" colspan="4">
                    <input type="text" id="p_pl" name="p_pl" value="'||rec.pl||'" /> 
                  </td>
                  <td></td>
                </tr>
                <tr>
                  <td class="titletd">'||get_fn('베트남어')||'</td>
                  <td class="inputtd" colspan="4">
                    <input type="text" id="p_vn" name="p_vn" value="'||rec.vn||'" /> 
                  </td>
                  <td></td>
                </tr>
                  
                </tbody>
              </table>
            </div>
            
          </div>
          <div id="mygrid_container" style="width:100%;height:99%;"></div>           
        </form>    
      </body>    
      </html>    
    '); 
  EXCEPTION
    when others then
      show_err('crrec');
  END crrec;
  
  PROCEDURE process
  (
    p_systemcd in varchar2 default null,
    p_dml_gubun in varchar2 default null,
    p_catalogcd in varchar2 default null,
    p_descr in varchar2 default null,
    p_ko in varchar2 default null,
    p_en in varchar2 default null,
    p_ch in varchar2 default null,
    p_sp in varchar2 default null,
    p_pl in varchar2 default null,
    p_vn in varchar2 default null,
    p_listvalue in varchar2 default null,
    p_listorder in varchar2 default null,
    p_useyn in varchar2 default null
  )
  IS
  
  BEGIN
    
    if p_dml_gubun = '1' then
      
      begin
        insert into c_0050
        (systemcd, catalogcd, descr, useyn)
        values 
        ( p_systemcd, upper(p_catalogcd), p_descr, 'Y' );
      exception
        when dup_val_on_index then
          update  c_0050
          set     descr = p_descr
          where   systemcd = p_systemcd
          and     catalogcd = upper(p_catalogcd);
        WHEN others THEN   
        null;   
      end;
          
      if p_ko is not null then
        
        begin
          insert into C_0051
          (systemcd, catalogcd, lang, listvalue, listdescr, listorder, useyn)
          values 
          (p_systemcd, upper(p_catalogcd), 'KO', p_listvalue,  p_ko, p_listorder, p_useyn);
        exception
          when dup_val_on_index then
            update  c_0051 
            set     listdescr = p_ko,
                    listorder = p_listorder,
                    useyn = p_useyn
            where   systemcd = p_systemcd
            and     catalogcd = upper(p_catalogcd)
            and     listvalue = p_listvalue
            and     lang = 'KO';
          WHEN others THEN   
          null;   
        end;
      end if;
      
      if p_en is not null then
            
        begin
          insert into C_0051
          (systemcd, catalogcd, lang, listvalue, listdescr, listorder, useyn)
          values 
          (p_systemcd, upper(p_catalogcd), 'EN', p_listvalue,  p_en, p_listorder, p_useyn);
        exception
          when dup_val_on_index then
            update  c_0051 
            set     listdescr = p_en,
                    listorder = p_listorder,
                    useyn = p_useyn
            where   systemcd = p_systemcd
            and     catalogcd = upper(p_catalogcd) 
            and     listvalue = p_listvalue
            and     lang = 'EN';
        WHEN others THEN   
        null;  
        end;
      end if;
      
      if p_ch is not null then
            
        begin
          insert into C_0051
          (systemcd, catalogcd, lang, listvalue, listdescr, listorder, useyn)
          values 
          (p_systemcd, upper(p_catalogcd), 'CH', p_listvalue,  p_ch, p_listorder, p_useyn);
        exception
          when dup_val_on_index then
            update c_0051 
            set     listdescr = p_ch,
                    listorder = p_listorder,
                    useyn = p_useyn
            where   systemcd = p_systemcd
            and     catalogcd = upper(p_catalogcd)
            and     listvalue = p_listvalue
            and     lang = 'CH';
          WHEN others THEN   
          null; 
        end;
      end if;
      
      if p_sp is not null then
            
        begin
          insert into C_0051
          (systemcd, catalogcd, lang, listvalue, listdescr, listorder, useyn)
          values 
          (p_systemcd, upper(p_catalogcd), 'SP', p_listvalue,  p_sp, p_listorder, p_useyn);
        exception
          when dup_val_on_index then
            update  c_0051 
            set     listdescr = p_sp,
                    listorder = p_listorder,
                    useyn = p_useyn
            where   systemcd = p_systemcd
            and     catalogcd = upper(p_catalogcd)
            and     listvalue = p_listvalue
            and     lang = 'SP';
          WHEN others THEN   
          null; 
        end;
      end if;
      
      if p_vn is not null then
            
        begin
          insert into C_0051
          (systemcd, catalogcd, lang, listvalue, listdescr, listorder, useyn)
          values 
          (p_systemcd, upper(p_catalogcd), 'VN', p_listvalue,  p_vn, p_listorder, p_useyn);
        exception
          when dup_val_on_index then
            update  c_0051 
            set     listdescr = p_vn,
                    listorder = p_listorder,
                    useyn = p_useyn
            where   systemcd = p_systemcd
            and     catalogcd = upper(p_catalogcd)
            and     listvalue = p_listvalue
            and     lang = 'VN';
          WHEN others THEN   
          null; 
        end;
      end if;
      
      if p_pl is not null then
        
        begin
          insert into C_0051
          (systemcd, catalogcd, lang, listvalue, listdescr, listorder, useyn)
          values 
          (p_systemcd, upper(p_catalogcd), 'PL', p_listvalue,  p_pl, p_listorder, p_useyn);
        exception
          when dup_val_on_index then
            update  c_0051 
            set     listdescr = p_pl,
                    listorder = p_listorder,
                    useyn = p_useyn
            where   systemcd = p_systemcd
            and     catalogcd = upper(p_catalogcd)
            and     listvalue = p_listvalue
            and     lang = 'PL';
          WHEN others THEN   
          null; 
        end;
      end if;
    
      htp.p('
        <script type="text/javascript">
          alert("'||get_fn( '저장되었습니다.')||'");
          opener.location.reload();
          location.href = "'||v_pkg||'.crrec?p_systemcd='||p_systemcd||'&p_catalogcd='||p_catalogcd||'&p_listvalue='||p_listvalue||'";
        </script>
        ');
    
    elsif p_dml_gubun = '2' then
      
      BEGIN
      
        DELETE FROM c_0051
        WHERE systemcd = p_systemcd
        AND   catalogcd = p_catalogcd
        AND   listvalue = p_listvalue;
        
      END;
    
      htp.p(' 
        <script type="text/javascript"> 
          alert("' ||get_fn( '삭제되었습니다.')|| '"); 
          opener.location.reload();
          location.href = "'||v_pkg||'.crrec?p_systemcd='||p_systemcd||'&p_catalogcd='||p_catalogcd||'";
        </script> 
        ' );
        
    elsif p_dml_gubun = '3' then
    
      BEGIN
      
        DELETE FROM c_0051
        WHERE systemcd = p_systemcd
        AND   catalogcd = p_catalogcd;
        
        DELETE FROM c_0050
        WHERE systemcd = p_systemcd
        AND   catalogcd = p_catalogcd;
        
      END;
    
      htp.p(' 
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
 
END COMCATALOG;

/
