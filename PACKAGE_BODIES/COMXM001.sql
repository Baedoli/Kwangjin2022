--------------------------------------------------------
--  DDL for Package Body COMXM001
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "PREMIER"."COMXM001" 
IS
  PROCEDURE control
  (
    p_useyn in varchar2 default 'Y'
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
        //myLayout.cells("b").hideHeader();
        //myLayout.cells("a").setWidth(600);
        //myLayout.cells("b").setHeight(260);
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
      
      function setStatusBarText(rowCount)
      {
        sbObj.setText("'||get_fn('자료검색을 종료합니다..')||'"+ rowCount +" '||get_fn('건이 검색되었습니다.')||'");
      }
      
      function doQuery() {
        document.getElementById("form1").submit();
      }
      
      function doCrrec()  
      {  
        var url = "'||v_pkg||'.crrec?";  
        newWnd2 = window.open(url,"'||v_pkg||'window","top=100, left=100, status=yes, resizable=no, scrollbars=yes, width=800, height=300");  
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
          <div class="cTitle"><label for="p_useyn">'||get_fn('사용여부')||'</label></div>
          <div class="cInput">
          '); common.list_catalog('COM','USEYN',p_useyn,'select', null, 'p_useyn', 'a', 'yes'); htp.p('
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
    p_useyn in varchar2 default null
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
            x[i]=["'||get_fn('코드')||'", "50","center","link","str","true"];i++;
            x[i]=["'||get_fn('사업장명')||'", "200","left","link","str","true"];i++;
            x[i]=["'||get_fn('대표자')||'", "100","center","ro","str","true"];i++;
            x[i]=["'||get_fn('사업자번호')||'", "200","left","ro","str","true"];i++;
            x[i]=["'||get_fn('사업장명(공용)')||'", "200","left","ro","str","true"];i++;
            x[i]=["'||get_fn('통화명')||'", "70","center","ro","str","true"];i++;
            x[i]=["'||get_fn('사용여부')||'", "70","center","ro","str","true"];i++;
            
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
          
          function link_(obj1){
            url ="'||v_pkg||'.crrec?p_companycd="+obj1;
            newWnd2 = window.open(url,"'||v_pkg||'window","top=100, left=100, status=yes, resizable=no, scrollbars=yes, width=800, height=300");  
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
    p_useyn in varchar2 default null
  )
  IS
    cursor cur is
      select * 
      from xm001 
      where 1=1
      and   useyn = nvl(p_useyn,useyn) 
      order by companycd; 

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
      v_link := '^javascript:link_(\"'||rec(i).companycd||'\")^_self';
      htp .p('
      { id:' ||i|| ',
        data:[
          {value:"'||i||'"},
          {value:"'||rec(i).companycd||v_link||'"},
          {value:"'||return_html_text(rec(i).descr)||v_link||'"},
          {value:"'||rec(i).presnm||'"},
          {value:"'||rec(i).busino||'"},
          {value:"'||return_html_text(rec(i).descr1)||'"},
          {value:"'||get_catalog_name('COM','CURRENCY_NAME',v_lang,rec(i).currency_name)||'"},
          {value:"'||rec(i).useyn||'"}
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
    p_companycd in varchar2 default null
  )
  IS
    cursor cur is
      select *
      from xm001
      where 1=1
      and   companycd = p_companycd
      ;
      
    rec cur%rowtype;
    v_disabled varchar2(20);
    
  BEGIN  
  
    open cur;
    fetch cur into rec;
    close cur;
    
    if rec.companycd is not null then
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

      $(function() {  
              
      });   

      function proc_save() {
        var thisForm = document.getElementById("form1");
        
        //필수값 체크
        if(!formRquried()){
          return false;  
        }     
                
        if (!confirm("'||get_fn('저장하시겠습니까?')||'")) return false;
        $("#p_companycd").removeAttr("disabled");
        thisForm.p_dml_gubun.value = "1";
        thisForm.submit(); 
      }    

      function proc_del() {    
        var thisForm = document.getElementById("form1");
        if (!confirm("'||get_fn('삭제하시겠습니까?')||'")) return false;    
        $("#p_companycd").removeAttr("disabled");
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
          <div class="formTitle">'||get_program_name('SYS',v_pkg,v_lang)||'</div>
          <div class="btnbar">
            <a href="#" class="btn-save buttons" onclick="proc_save();">'||get_fn('저장')||'</a>&nbsp;
            <a href="#" class="btn-delete buttons" onclick="proc_del();">'||get_fn('삭제')||'</a>&nbsp;
            <a href="#" class="btn-close buttons" onclick="self.close();">'||get_fn('닫기')||'</a>
          </div>
        </div>
        
        <!--테이블입력-->
        <div>
          <table width="100%" border="0" cellspacing="0" cellpadding="4">
            <tbody>
              <tr>
                <td class="titletd require">'||get_fn('사업장코드')||'</td>
                <td class="inputtd">
                  <input type="text" id="p_companycd" name="p_companycd" maxlength="2" '||v_disabled||' value="'||rec.companycd||'" / > 
                </td>
                <td class="titletd">'||get_fn('사업장명')||'</td>
                <td class="inputtd">
                  <input type="text" id="p_descr" name="p_descr" value="'||rec.descr||'" / > 
                </td>
              </tr>
              <tr>
                <td class="titletd">'||get_fn('대표자')||'</td>
                <td class="inputtd">
                  <input type="text" id="p_presnm" name="p_presnm" value="'||rec.presnm||'" / > 
                </td>
                <td class="titletd">'||get_fn('사업장번호')||'</td>
                <td class="inputtd">
                  <input type="text" id="p_busino" name="p_busino" value="'||rec.busino||'" / > 
                </td>
              </tr>
              <tr>
                <td class="titletd">'||get_fn('사업장명(공용)')||'</td>
                <td class="inputtd">
                  <input type="text" id="p_descr1" name="p_descr1" value="'||rec.descr1||'" / > 
                </td>
                <td class="titletd">'||get_fn('사업장명(약어)')||'</td>
                <td class="inputtd">
                  <input type="text" id="p_descr2" name="p_descr2" value="'||rec.descr2||'" / > 
                </td>
              </tr>
              <tr>
                <td class="titletd">'||get_fn('통화명')||'</td>
                <td class="inputtd">
                  '); common.list_catalog('COM','CURRENCY_NAME',rec.currency_name,'select', null, 'p_currency_name', 'c', 'yes'); htp.p(' 
                </td>
                <td class="titletd require">'||get_fn('사용여부')||'</td>
                <td class="inputtd">
                  '); common.list_catalog('COM','USEYN',rec.useyn,'select', null, 'p_useyn', 'c', 'yes'); htp.p(' 
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
    p_companycd in varchar2 default null,
    p_dml_gubun in varchar2 default null,
    p_descr in varchar2 default null,
    p_presnm in varchar2 default null,
    p_busino in varchar2 default null,
    p_descr1 in varchar2 default null,
    p_descr2 in varchar2 default null,
    p_useyn in varchar2 default null,
    p_currency_name in varchar2 default null
  )
  IS
    cursor cur_lang is
      select *
      from c_0051
      where 1=1
      and   systemcd = 'COM'
      and   catalogcd = 'LANGUAGE'
      and   lang = 'KO'
      and   useyn = 'Y'
      ;
  BEGIN
    
    if p_dml_gubun = '1' then
      
      begin
        insert into xm001
        (companycd, descr, presnm, busino, useyn, descr1, descr2, currency_name)
        values
        (p_companycd, p_descr, p_presnm, p_busino, p_useyn, p_descr1, p_descr2, p_currency_name);
      exception
        when dup_val_on_index then
          update xm001
          set descr = p_descr, 
              presnm = p_presnm, 
              busino = p_busino, 
              useyn = p_useyn, 
              descr1 = p_descr1,
              descr2 = p_descr2, 
              currency_name = p_currency_name
          where 1=1
          and   companycd = p_companycd
          ;
        when others then
          show_err('insert-xm001');
      end;
      
      for rec in cur_lang loop
        begin
          insert into master_language(
          tableid, companycd, code, gubun, lang, 
          name, logincomp, loginid, loginymd)
          values(
          'XM001', p_companycd, p_companycd, '0', rec.listvalue,
          p_descr, v_comp, v_id, sysdate);
        exception
        when dup_val_on_index then
          update master_language
          set name = p_descr, 
              logincomp = v_comp, 
              loginid = v_id, 
              loginymd = sysdate
          where 1=1
          and   tableid = 'XM001'
          and   companycd = p_companycd
          and   code = p_companycd
          and   gubun = '0'
          and   lang = rec.listvalue
          ;
        when others then
          show_err('insert-master_language');
        end;
      end loop;
    
      htp.p('
        <script type="text/javascript">
          alert("'||get_fn( '저장되었습니다.')||'");
          opener.location.reload();
          location.href = "'||v_pkg||'.crrec?p_companycd='||p_companycd||'";
        </script>
        ');
    
    elsif p_dml_gubun = '2' then
      
      begin
        delete from xm001
        where 1=1
        and   companycd = p_companycd
        ;
      exception 
        when others then
          show_err('delete-xm001');
      end;
      
      begin
        delete from master_language
        where 1=1
        and   tableid = 'XM001'
        and   companycd = p_companycd
        and   code = p_companycd
        and   gubun = '0'
        ;
      exception 
        when others then
          show_err('delete-master_language');
      end;
    
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
 
END COMXM001;

/
