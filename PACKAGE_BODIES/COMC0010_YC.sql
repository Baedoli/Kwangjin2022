--------------------------------------------------------
--  DDL for Package Body COMC0010_YC
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "PREMIER"."COMC0010_YC" 
IS
  PROCEDURE control
 
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
        var url = "'||v_pkg||'.crrec";  
        newWnd2 = window.open(url,"'||v_pkg||'window","top=100, left=100, status=yes, resizable=no, scrollbars=yes, width=1000, height=277");  
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
            x[i]=["'||get_fn('사원번호')||'", "80","center","ro","str","true"];i++;
            x[i]=["'||get_fn('이름')||'", "80","center","ro","str","true"];i++;
            x[i]=["'||get_fn('구분')||'", "80","center","ro","str","true"];i++;
            x[i]=["'||get_fn('시작일')||'", "80","center","ro","str","true"];i++;
            x[i]=["'||get_fn('종료일')||'", "80","center","ro","str","true"];i++;
            x[i]=["'||get_fn('사업장')||'", "80","center","ro","str","true"];i++;
            x[i]=["'||get_fn('부서')||'", "80","center","ro","str","true"];i++;
            x[i]=["'||get_fn('기본적용여부')||'", "80","center","ro","str","true"];i++;
            x[i]=["'||get_fn('사용여부')||'", "80","center","ro","str","true"];i++;

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
            newWnd2 = window.open(url,"'||v_pkg||'window","top=100, left=100, status=yes, resizable=no, scrollbars=yes, width=1000, height=277");  
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
  
  IS
--    cursor cur is
--      select  a.xuser, a.xusernm, a.gubun, b.symd, b.eymd, b.companycd, b.teamcd, b.default_yn, b.useyn
--      from    MDM0200 a, MDM0200_HISTORY b
--      where   a.xuser = b.xuser
--      and     a.gubun = b.gubun
--      ;

    cursor cur is
      select  a.xuser, a.xusernm, a.gubun, b.symd, b.eymd, b.companycd, b.teamcd, b.default_yn, b.useyn
      from    MDM0200 a, MDM0200_HISTORY b
      where   a.xuser = b.xuser(+)
      and     a.gubun = b.gubun(+)
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
          {value:"'||rec(i).xuser||'"},
          {value:"'||rec(i).xusernm||'"},
          {value:"'||rec(i).gubun||'"},
          {value:"'||rec(i).symd||'"},
          {value:"'||rec(i).eymd||'"},
          {value:"'||rec(i).companycd||'"},
          {value:"'||rec(i).teamcd||'"},
          {value:"'||rec(i).default_yn||'"},
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
    p_xuser in varchar2 default null,
    p_xusernm in varchar2 default null,
    p_gubun in varchar2 default null,
    p_lang in varchar2 default null,
    p_email in varchar2 default null,
    p_mail_id in varchar2 default null,
    p_mobile in varchar2 default null
  )
  IS
  
    cursor cur is
      select  a.xuser, a.xusernm, a.gubun, a.lang, a.email, a.mail_id, a.mobile
      from    MDM0200 a
      where   xuser = p_xuser
      and     gubun = p_gubun
      ;
    
    rec cur %rowtype;

  BEGIN  
        
    open cur;
    fetch cur into rec;
    close cur;
  
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
    <form id="form1" name="form1" action="'||v_pkg||'.process" method="post" >
    <input type="hidden" id="p_dml_gubun" name="p_dml_gubun" value="" />
    
      <!-- 신규 Form Setting S -->
      <div class="formWrap">
      
        <!--상단타이틀/버튼-->
        <div class="formTop">
          <div class="formTitle">'||get_program_name('SYS',v_pkg,v_lang)||'</div>
          <div class="btnbar">
            <a href="#" class="btn-save buttons" onclick="proc_save(); return false;">'||get_fn('저장')||'</a>&nbsp;
            <a href="#" class="btn-approval buttons" onclick="crDoc(); return false;">'||get_fn('결재')||'</a>&nbsp;
            <a href="#" class="btn-delete buttons" onclick="proc_del(); return false;">'||get_fn('삭제')||'</a>&nbsp;
            <a href="#" class="btn-close buttons" onclick="self.close(); return false;">'||get_fn('닫기')||'</a>
          </div>
        </div>
        
        <!--테이블입력-->
        <div>
          <table width="100%" border="0" cellspacing="0" cellpadding="4">
            <tbody>
            
              <tr>
                <td class="titletd">'||get_fn('사원번호')||'</td>
                <td class="inputtd">
                  <input type="text" id="p_xuser" name="p_xuser" value="'||rec.xuser||'" /> 
                </td>
                <td class="titletd">'||get_fn('이름')||'</td>
                <td class="inputtd">
                  <input type="text" id="p_xusernm" name="p_xusernm" value="'||rec.xusernm||'" / > 
                </td>
              </tr>
             
              <tr>
                <td class="titletd">'||get_fn('구분')||'</td>
                <td class="inputtd">
                  '); common.list_catalog('COM','GUBUN',rec.gubun,'select', null, 'p_gubun', 'c', 'yes'); htp.p(' 
                </td>
                <td class="titletd">'||get_fn('기본언어')||'</td>
                 <td class="inputtd">
                  '); common.list_catalog('COM','LANGUAGE',rec.lang,'select', null, 'p_lang', 'c', 'yes'); htp.p(' 
                </td>
              </tr>
              
              <tr>
                <td class="titletd">'||get_fn('EMAIL')||'</td>
                <td class="inputtd">
                  <input type="text" id="p_email" name="p_email" value="'||rec.email||'" /> 
                </td>
                <td class="titletd">'||get_fn('MS 메일계정')||'</td>
                <td class="inputtd">
                  <input type="text" id="p_mail_id" name="p_mail_id" value="'||rec.mail_id||'" / > 
                </td>
              </tr>
              
              <tr>
                <td class="titletd">'||get_fn('핸드폰')||'</td>
                <td class="inputtd">
                  <input type="text" id="p_mobile" name="p_mobile" value="'||rec.mobile||'" /> 
                </td>
                <td></td><td></td>
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
    p_xuser in varchar2 default null,
    p_xusernm in varchar2 default null,
    p_gubun in varchar2 default null,
    p_lang in varchar2 default null,
    p_email in varchar2 default null,
    p_mail_id in varchar2 default null,
    p_mobile in varchar2 default null,
    p_dml_gubun in varchar2 default null
  )
  IS
  
  BEGIN
    
    if p_dml_gubun = '1' then
      
      begin
        insert into mdm0200
        ( xuser, xusernm, gubun, lang, email, mail_id, mobile )
        values
        ( p_xuser, p_xusernm, p_gubun, p_lang, p_email, p_mail_id, p_mobile );
      exception
        when dup_val_on_index then
          update  mdm0200
          set     xusernm = p_xusernm,
                  lang = p_lang,
                  email = p_email,
                  mail_id = p_mail_id,
                  mobile = p_mobile
          where   1=1
          and     xuser = p_xuser
          and     gubun = p_gubun
          ;
        when others then
          show_err('insert-xm001');
      end;
    
      htp.p('
        <script type="text/javascript">
          alert("'||get_fn( '저장되었습니다.')||'");
          opener.location.reload();
          location.href = "'||v_pkg||'.crrec";
        </script>
      ');
    
    elsif p_dml_gubun = '2' then
      
        delete from mdm0200
        where       xuser = p_xuser
        and         gubun = p_gubun
        ;
    
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
  
  PROCEDURE crrec_detail
  (
    p_companycd in varchar2 default null,
    p_xuser in varchar2 default null,
    p_xusernm in varchar2 default null,
    p_gubun in varchar2 default null,
    p_lang in varchar2 default null,
    p_email in varchar2 default null,
    p_mail_id in varchar2 default null,
    p_mobile in varchar2 default null,
    p_teamcd in varchar2 default null,
    p_default_yn in varchar2 default null,
    p_useyn in varchar2 default null,
    p_jikup in varchar2 default null,
    p_position in varchar2 default null,
    p_symd in varchar2 default null,
    p_eymd in varchar2 default null
  )
  IS
  
  cursor cur is
    select  a.xuser, a.xusernm, a.gubun, a.lang, a.email, a.mail_id, a.mobile, b.companycd, b.seq, b.teamcd, b.symd, b.eymd, b.default_yn, b.useyn, b.jikup, b.position
    from    MDM0200 a, MDM0200_HISTORY b
    where   a.xuser = b.xuser
    and     a.gubun = b.gubun
    ;
      
    rec cur%rowtype;


  BEGIN  
        
    open cur;
    fetch cur into rec;
    close cur;
  
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
        $("#p_symd").datepicker({
            changeMonth: true,
            changeYear: true,
            dateFormat: "yymmdd",
            buttonImage: "/image/calendar.gif",
            showOn: "focus", // focus, button, both
            showAnim: "fadeIn", //explode, fold, slideDown
            showOptions: {pieces: 1},
            duration: 500
        });
        
        $("#p_eymd").datepicker({
            changeMonth: true,
            changeYear: true,
            dateFormat: "yymmdd",
            buttonImage: "/image/calendar.gif",
            showOn: "focus", // focus, button, both
            showAnim: "fadeIn", //explode, fold, slideDown
            showOptions: {pieces: 1},
            duration: 500
        });
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
    <form id="form1" name="form1" action="'||v_pkg||'.process_detail" method="post" >
      <input type="hidden" id="p_dml_gubun" name="p_dml_gubun" value="" />
      <input type="hidden" id="p_seq" name="p_seq" value="'||rec.seq||'" />

      <!-- 신규 Form Setting S -->
      <div class="formWrap">
      
        <!--상단타이틀/버튼-->
        <div class="formTop">
          <div class="formTitle">'||get_program_name('SYS',v_pkg,v_lang)||'</div>
          <div class="btnbar">
            <a href="#" class="btn-save buttons" onclick="proc_save(); return false;">'||get_fn('비밀번호변경')||'</a>&nbsp;
            <a href="#" class="btn-save buttons" onclick="proc_save(); return false;">'||get_fn('개정')||'</a>&nbsp;
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
                <td class="titletd">'||get_fn('사원번호')||'</td>
                <td class="inputtd">
                  <input type="text" id="p_xuser" name="p_xuser" value="'||rec.xuser||'" /> 
                </td>
                <td class="titletd">'||get_fn('이름')||'</td>
                <td class="inputtd">
                  <input type="text" id="p_xusernm" name="p_xusernm" value="'||rec.xusernm||'" / > 
                </td>
              </tr>
             
              <tr>
                <td class="titletd">'||get_fn('구분')||'</td>
                <td class="inputtd">
                  '); common.list_catalog('COM','GUBUN',rec.gubun,'select', null, 'p_gubun', 'c', 'yes'); htp.p(' 
                </td>
                <td class="titletd">'||get_fn('기본언어')||'</td>
                 <td class="inputtd">
                  '); common.list_catalog('COM','LANGUAGE',rec.lang,'select', null, 'p_lang', 'c', 'yes'); htp.p(' 
                </td>
              </tr>
              
              <tr>
                <td class="titletd">'||get_fn('EMAIL')||'</td>
                <td class="inputtd">
                  <input type="text" id="p_email" name="p_email" value="'||rec.email||'" /> 
                </td>
                <td class="titletd">'||get_fn('MS 메일계정')||'</td>
                <td class="inputtd">
                  <input type="text" id="p_mail_id" name="p_mail_id" value="'||rec.mail_id||'" / > 
                </td>
              </tr>
              
              <tr>
                <td class="titletd">'||get_fn('핸드폰')||'</td>
                <td class="inputtd">
                  <input type="text" id="p_mobile" name="p_mobile" value="'||rec.mobile||'" /> 
                </td>
                <td></td><td></td>
              </tr>
              
              <tr>
                <td class="titletd">'||get_fn('사업장')||'</td>
                <td>
                <select name="p_companycd" id="p_companycd">
                '); common.list_company(p_companycd, v_lang); htp.p('
                </select>
                  </td>
                <td class="titletd">'||get_fn('부서')||'</td>
                 <td class="inputtd">
                  '); common.list_dept(nvl(rec.companycd, p_companycd), rec.teamcd, 'select', null, 'p_teamcd', 'b', 'yes'); htp.p(' 
                </td>
              </tr>
              
              <tr>
                <td class="titletd">'||get_fn('기본적용여부')||'</td>
                <td class="inputtd">
                  '); common.list_catalog('COM','USEYN',rec.default_yn,'select', null, 'p_default_yn', 'c', 'yes'); htp.p(' 
                </td>
                <td class="titletd">'||get_fn('기본언어')||'</td>
                 <td class="inputtd">
                  '); common.list_catalog('COM','LANGUAGE',rec.lang,'select', null, 'p_lang', 'c', 'yes'); htp.p(' 
                </td>
              </tr>
              
              <tr>
                <td class="titletd">'||get_fn('직급')||'</td>
                <td class="inputtd">
                  '); common.list_catalog('COM','RANK',rec.jikup,'select', null, 'p_jikup', 'c', 'yes'); htp.p(' 
                </td>
                <td class="titletd">'||get_fn('직책')||'</td>
                 <td class="inputtd">
                  '); common.list_catalog('COM','JIKUP',rec.position,'select', null, 'p_position', 'c', 'yes'); htp.p(' 
                </td>
              </tr>
              
              <tr>
                <td class="titletd">'||get_fn('시작일')||'</td>
                <td class="inputtd">
                  <input type="text" id="p_symd" name="p_symd" class="date" style="width: 140px;" value="'||rec.symd||'" /></td>  
                </td>
                <td class="titletd">'||get_fn('종료일')||'</td>
                 <td class="inputtd">
                  <input type="text" id="p_eymd" name="p_eymd" class="date" style="width: 140px;" value="'||rec.eymd||'" /></td>  
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
  END crrec_detail;
  
  PROCEDURE process_detail
  (
    p_companycd in varchar2 default null,
    p_xuser in varchar2 default null,
    p_xusernm in varchar2 default null,
    p_gubun in varchar2 default null,
    p_seq in varchar2 default null,
    p_lang in varchar2 default null,
    p_email in varchar2 default null,
    p_mail_id in varchar2 default null,
    p_mobile in varchar2 default null,
    p_teamcd in varchar2 default null,
    p_default_yn in varchar2 default null,
    p_useyn in varchar2 default null,
    p_jikup in varchar2 default null,
    p_position in varchar2 default null,
    p_symd in varchar2 default null,
    p_eymd in varchar2 default null,
    p_dml_gubun in varchar2 default null
  )
  IS
  
    cursor cur is 
      select  nvl(max(seq), 0)+1
      from    mdm0200_history
      where   xuser = p_xuser
      and     gubun = p_gubun
      and     teamcd = p_teamcd
      and     companycd = p_companycd
      ;
      
    v_seq varchar(20); 
    
  BEGIN
  
    open cur;
    fetch cur into v_seq;
    close cur;
     
    if p_seq is not null then
      v_seq := p_seq;
    else 
      v_seq := v_seq;
    end if;
    
    if p_dml_gubun = '1' then
      
      begin
        insert into mdm0200_history
        ( xuser, gubun, companycd, teamcd, seq, xusernm, default_yn, jikup, position, useyn, symd, eymd, login_comp, login_id, login_ymd )
        values
        ( p_xuser, p_gubun, p_companycd, p_teamcd, v_seq, p_xusernm, p_default_yn, p_jikup, p_position, p_useyn, p_symd, p_eymd, v_comp, v_id, sysdate );
      exception
        when dup_val_on_index then
          update  mdm0200_history
          set     default_yn = p_default_yn,
                  jikup = p_jikup,
                  position = p_position,
                  useyn = p_useyn,
                  symd = p_symd,
                  eymd = p_eymd,
                  login_comp = v_comp,
                  login_id = v_id,
                  login_ymd = sysdate
          where   xuser = p_xuser
          and     gubun = p_gubun
          and     companycd = p_companycd
          and     teamcd = p_teamcd
          and     seq = v_seq
          ;
        when others then
          show_err('insert-xm001');
      end;
        
      htp.p('
        <script type="text/javascript">
          alert("'||get_fn( '저장되었습니다.')||'");
          opener.location.reload();
          location.href = "'||v_pkg||'.crrec_detail?p_xuser='||p_xuser||'&p_gubun='||p_gubun||'&p_companycd='||p_companycd||'&p_teamcd='||p_teamcd||'&p_seq='||p_seq||'";
        </script>
      ');
    
    elsif p_dml_gubun = '2' then
      
      delete from mdm0200_history
      where       xuser = p_xuser
      and         gubun = p_gubun
      and         companycd = p_companycd
      and         teamcd = p_teamcd
      and         seq = v_seq     
      ;
      
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
  END process_detail;
 
END COMC0010_yc;

/
