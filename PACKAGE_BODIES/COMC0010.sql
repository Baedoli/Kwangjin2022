--------------------------------------------------------
--  DDL for Package Body COMC0010
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "PREMIER"."COMC0010" 
IS
  PROCEDURE control
  (
    p_companycd in varchar2 default null,
    p_gubun in varchar2 default null,
    p_xusernm in varchar2 default null
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
        var url = "'||v_pkg||'.crrec";  
        newWnd2 = window.open(url,"'||v_pkg||'window","top=100, left=100, status=yes, resizable=no, scrollbars=yes, width=1000, height=730");  
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
        <div class="cTitle"><label for="p_companycd">'||get_fn('사업장')||'</label></div>
        <div class="cInput">
          <select name="p_companycd" id="p_companycd">
          '); common.list_company(p_companycd, v_lang); htp.p('
          </select>
        </div>
      </div>
      
      <div class="cBox">
        <div class="cTitle"><label for="p_gubun">'||get_fn('구분')||'</label></div>
        <div class="cInput">
          '); common.list_catalog('COM','GUBUN',p_gubun,'select', null, 'p_gubun', 'a', 'yes'); htp.p('
        </div>
      </div> 
        
      <div class="cBox">
        <div class="cTitle"><label for="p_xusernm">'||get_fn('이름')||'</label></div>
        <div class="cInput">
          <input type="text" name="p_xusernm" id="p_xusernm" value="'||p_xusernm||'"> 
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
    p_companycd in varchar2 default null,
    p_gubun in varchar2 default null,
    p_xusernm in varchar2 default null
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
            x[i]=["'||get_fn('사원번호')||'", "80","center","link","str","true"];i++;
            x[i]=["'||get_fn('이름')||'", "80","center","ro","str","true"];i++;
            x[i]=["'||get_fn('구분')||'", "80","center","ro","str","true"];i++;
            x[i]=["'||get_fn('시작일')||'", "100","center","ro","str","true"];i++;
            x[i]=["'||get_fn('종료일')||'", "100","center","ro","str","true"];i++;
            x[i]=["'||get_fn('사업장')||'", "130","center","ro","str","true"];i++;
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
            var url = "'||v_pkg||'.query_a_data"+window.location.search;
            mygrid.load(url, "json");
            mygrid.attachEvent("onXLE", function() {
              parent.setStatusBarText(mygrid.getRowsNum());
              parent.myLayout.cells("a").progressOff();
            }); 
          }
        
          function link_(obj1, obj2, obj3, obj4, obj5){
            url ="'||v_pkg||'.crrec?p_xuser="+obj1+"&p_gubun="+obj2+"&p_companycd="+obj3+"&p_teamcd="+obj4+"&p_seq="+obj5;
            newWnd2 = window.open(url,"'||v_pkg||'window","top=100, left=100, status=yes, resizable=no, scrollbars=yes, width=1000, height=730");  
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
    p_gubun in varchar2 default null,
    p_xusernm in varchar2 default null
  )
  IS
    cursor cur is
      select  a.xuser, a.xusernm, a.gubun, b.symd, b.eymd, b.companycd, b.teamcd, b.seq, b.default_yn, b.useyn
      from    MDM0200 a, MDM0200_HISTORY b
      where   a.xuser = b.xuser
      and     a.gubun = b.gubun
      and     b.default_yn = 'Y'
      and     b.companycd = nvl(p_companycd, b.companycd)
      and     a.gubun = nvl(p_gubun, a.gubun)
      and     upper(a.xusernm) like '%'||upper(p_xusernm)||'%'
      order by  b.symd desc
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
      v_link := '^javascript:link_(\"'||rec(i).xuser||'\", \"'||rec(i).gubun||'\", \"'||rec(i).companycd||'\", \"'||rec(i).teamcd||'\", \"'||rec(i).seq||'\")^_self';
      htp .p('
      { id:' ||i|| ',
        data:[
          {value:"'||i||'"},
          {value:"'||rec(i).xuser||v_link||'"},
          {value:"'||rec(i).xusernm||'"},
          {value:"'||get_catalog_name('COM','GUBUN',v_lang,rec(i).gubun)||'"},
          {value:"'||rec(i).symd||'"},
          {value:"'||rec(i).eymd||'"},
          {value:"'||get_master_name('XM001',rec(i).companycd,'0',v_lang,'00')||'"},
          {value:"'||get_team_name(rec(i).companycd, rec(i).teamcd)||'"},
          {value:"'||rec(i).default_yn||'"},
          {value:"'||rec(i).useyn||'"}
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
      show_err('query_a_data'); 
  END query_a_data;
  
  PROCEDURE crrec
  (
    p_companycd in varchar2 default null,
    p_xuser in varchar2 default null,
    p_gubun in varchar2 default null,
    p_teamcd in varchar2 default null,
    p_seq in varchar2 default null
  )
  IS
  
  cursor cur is
    select  a.xuser, a.xusernm, a.gubun, a.lang, a.email, a.mail_id, a.mobile, b.companycd, b.seq, b.teamcd, b.symd, b.eymd, b.default_yn, b.useyn, b.jikup, b.position
    from    MDM0200 a, MDM0200_HISTORY b
    where   a.xuser = b.xuser
    and     a.gubun = b.gubun
    and     a.xuser = p_xuser
    and     a.gubun = p_gubun
    and     b.companycd = p_companycd
    and     b.teamcd = p_teamcd
    and     b.seq = p_seq
    ;
      
    rec cur%rowtype;

  cursor cur2 is
    select  a.xuser, a.xusernm, a.gubun, a.lang, a.email, a.mail_id, a.mobile, b.companycd, b.seq, b.teamcd, b.symd, b.eymd, b.default_yn, b.useyn, b.jikup, b.position
    from    MDM0200 a, MDM0200_HISTORY b
    where   a.xuser = b.xuser
    and     a.gubun = b.gubun
    and     a.xuser = p_xuser
    and     a.gubun = p_gubun
    order by    seq 
    ;
      
    type r2 is table of cur2%rowtype index by pls_integer;
    rec2 r2;
    
    v_link2 varchar2(100) := null;
    v_disabled varchar(20);
    v_disabled_select varchar(20);
 
  BEGIN  
        
    open cur;
    fetch cur into rec;
    close cur;
  
    open cur2;  
    fetch cur2 bulk collect into rec2;  
    close cur2; 
    
    if rec.xuser is not null then
      v_disabled := 'disabled="disabled"';
      v_disabled_select := 'disabled';
    else
      v_disabled := '';
      v_disabled_select := 'yes';
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
          
          doInitGrid2();

        });
                  
        function toDelete() {  
          var thisForm = document.getElementById("form1");                 
          var params = {
            p_xuser : thisForm.p_xuser.value,
            p_gubun : thisForm.p_gubun.value,
            p_seq : thisForm.p_seq.value,
            p_default_yn : thisForm.p_default_yn.value,
            p_symd : thisForm.p_symd.value,
            p_eymd : thisForm.p_eymd.value,
            p_flag : "1"
          }
          $.ajax({
            type : "POST",         
            url : "'||v_pkg||'.list_max_seq_check",    
            data : params, 
            async: false,           
            success : function(data){ 
              var v_parse = JSON.parse(data);
              
              if ( "'||p_seq||'" == "" ){
                alert("저장 후 삭제하여 주십시오");
                return false;
              }
              
              if ( v_parse.v_check=="Y"){
                alert("기본적용 데이터는 삭제할 수 없습니다");
              }else if ( v_parse.v_master=="N"){
                alert("상위 리비전이 있습니다");
              }else{
                proc_del();
              }
            },
            error : function(XMLHttpRequest, textStatus, errorThrown){ // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
              alert("실패.")
            }
          });
        } 
              
        function toProcess() {  
          var thisForm = document.getElementById("form1");   
                      
          var params = {
            p_xuser : thisForm.p_xuser.value,
            p_gubun : thisForm.p_gubun.value,
            p_seq : thisForm.p_seq.value,
            p_default_yn : thisForm.p_default_yn.value,
            p_symd : thisForm.p_symd.value,
            p_eymd : thisForm.p_eymd.value,
            p_flag : "2"
          }
          $.ajax({
            type : "POST",         
            url : "'||v_pkg||'.list_max_seq_check",    
            data : params, 
            async: false,           
            success : function(data){ 
              var v_parse = JSON.parse(data);
              
              if ( v_parse.v_symd_early == "Q") {
                alert("이전 차수의 시작일보다 전일 수 없습니다");
                return false;
              }
              
              if ( v_parse.v_date == "T") {
                alert("종료일이 시작일보다 전일 수 없습니다");
                return false;
              }
              
              if ( "'||p_xuser||'" != ""){
                if ( v_parse.v_check == "Y"){
                  alert("기본적용여부는 수정할 수 없습니다");
                  return false;
                }
              }else{
                if( v_parse.v_master == "X" ){
                  alert("이미 등록되어 있습니다");
                  return false;
                }
              }
              proc_save();
            },
            error : function(XMLHttpRequest, textStatus, errorThrown){ // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
              alert("실패.")
            }
          });
        } 
        
        function proc_save() {
          var thisForm = document.getElementById("form1");

          //필수값 체크
          if(!formRquried()){
            return false;  
          }     
    
          if (!confirm("'||get_fn('저장하시겠습니까?')||'")) return false;
   
          $("#p_xuser").removeAttr("disabled");
          $("#p_gubun").removeAttr("disabled");
          $("#p_companycd").removeAttr("disabled");
          $("#p_teamcd").removeAttr("disabled");
          $("#p_default_yn").removeAttr("disabled");

          thisForm.p_dml_gubun.value = "1";
          thisForm.submit(); 
        }   
        
        function p_companycd_onchange() {
          getTeamList( $("#p_companycd").val(), $("#p_teamcd").val(), "p_teamcd")
        }
        
        function revision_data() {
          var thisForm = document.getElementById("form1");
                
          if (!confirm("'||get_fn('개정하시겠습니까?')||'")) return false;   

          $("#p_companycd").removeAttr("disabled");
          $("#p_teamcd").removeAttr("disabled");
          
          thisForm.p_companycd.value = "";
          thisForm.p_teamcd.value = "";
          thisForm.p_useyn.value = "";
          thisForm.p_jikup.value = "";
          thisForm.p_position.value = "";
          thisForm.p_symd.value = "";
          thisForm.p_eymd.value = "";
          thisForm.p_seq.value = "";
          
          if ( "'||p_xuser||'" != ""){
            thisForm.p_default_yn.value = "";
          }
        }
        
        function proc_del() {    
          var thisForm = document.getElementById("form1");
          
          if (!confirm("'||get_fn('삭제하시겠습니까?')||'")) return false;   
           
          $("#p_xuser").removeAttr("disabled");
          $("#p_gubun").removeAttr("disabled");
          $("#p_companycd").removeAttr("disabled");
          $("#p_teamcd").removeAttr("disabled");
          $("#p_default_yn").removeAttr("disabled");
          
          thisForm.p_dml_gubun.value = "2";    
          thisForm.submit();   
        } 
        
        function toView(obj1, obj2, obj3, obj4, obj5){
          url ="'||v_pkg||'.crrec?p_xuser="+obj1+"&p_gubun="+obj2+"&p_companycd="+obj3+"&p_teamcd="+obj4+"&p_seq="+obj5;
          newWnd2 = window.open(url,"'||v_pkg||'window","top=100, left=100, status=yes, resizable=no, scrollbars=yes, width=1000, height=730");  
          newWnd2.focus();
        }
            
        data={ rows:[           
        ');  
      
        for i in 1 .. rec2.count loop  
           
          v_link2 := '^javascript:toView(\"'||rec2(i).xuser||'\",\"'||rec2(i).gubun||'\",\"'||rec2(i).companycd||'\",\"'||rec2(i).teamcd||'\",\"'||rec2(i).seq||'\")^_self';

          htp.p('
            { id:'||i||',
              data:[
                {value:"'||i||'"},
                {value:"'||return_html_text(get_master_name('XM001',rec2(i).companycd,'0',v_lang,'00'))||v_link2||'"},
                {value:"'||return_html_text(get_team_name(rec2(i).companycd, rec2(i).teamcd))||'"},
                {value:"'||return_html_text(rec2(i).default_yn)||'"},
                {value:"'||return_html_text(rec2(i).useyn)||'"},
                {value:"'||return_html_text(get_catalog_name('GMS', 'RANK', v_lang, rec2(i).jikup))||'"},
                {value:"'||return_html_text(get_catalog_name('COM', 'JIKUP', v_lang, rec2(i).position))||'"},
                {value:"'||return_html_text(rec2(i).symd)||'"},
                {value:"'||return_html_text(rec2(i).eymd)||'"}
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
        var mygrid2;   
              
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
          
          x[i]=["NO", "40","center","ro","int","true"];i++;
          x[i]=["'||get_fn('사업장')||'", "130","center","link","str","true"];i++;
          x[i]=["'||get_fn('부서')||'", "80","center","ro","str","true"];i++;
          x[i]=["'||get_fn('기본적용여부')||'", "80","center","ro","str","true"];i++;
          x[i]=["'||get_fn('사용여부')||'", "80","center","ro","str","true"];i++;
          x[i]=["'||get_fn('직급')||'", "80","center","ro","str","true"];i++;
          x[i]=["'||get_fn('직책')||'", "80","center","ro","str","true"];i++;
          x[i]=["'||get_fn('시작일')||'", "80","center","ro","str","true"];i++;
          x[i]=["'||get_fn('종료일')||'", "80","center","ro","str","true"];i++;
          
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
        <input type="hidden" id="p_seq" name="p_seq" value="'||rec.seq||'" />

        <!-- 신규 Form Setting S -->
        <div class="formWrap">
        
          <!--상단타이틀/버튼-->
          <div class="formTop">
            <div class="formTitle">'||get_program_name('SYS',v_pkg,v_lang)||'</div>
            <div class="btnbar">
              <a href="#" class="btn-save buttons" onclick="proc_save(); return false;">'||get_fn('비밀번호변경')||'</a>&nbsp;
              <a href="#" class="btn-save buttons" onclick="revision_data(); return false;">'||get_fn('개정')||'</a>&nbsp;
              <a href="#" class="btn-save buttons" onclick="toProcess(); return false;">'||get_fn('저장')||'</a>&nbsp;
              <a href="#" class="btn-delete buttons" onclick="toDelete(); return false;">'||get_fn('삭제')||'</a>&nbsp;
              <a href="#" class="btn-close buttons" onclick="self.close(); return false;">'||get_fn('닫기')||'</a>
            </div>
          </div>
          
          <!--테이블입력-->
          <div>
            <table width="100%" border="0" cellspacing="0" cellpadding="4">
              <tbody>
              
                <tr>
                  <td class="titletd require">'||get_fn('사원번호')||'</td>
                  <td class="inputtd">
                    <input type="text" id="p_xuser" name="p_xuser" value="'||rec.xuser||'" '||v_disabled||' /> 
                  </td>
                  <td class="titletd require">'||get_fn('이름')||'</td>
                  <td class="inputtd">
                    <input type="text" id="p_xusernm" name="p_xusernm" value="'||rec.xusernm||'" / > 
                  </td>
                </tr>
               
                <tr>
                  <td class="titletd require">'||get_fn('구분')||'</td>
                  <td class="inputtd">
                    '); common.list_catalog('COM','GUBUN',rec.gubun,'select', null, 'p_gubun', 'c', v_disabled_select); htp.p(' 
                  </td>
                  <td class="titletd require">'||get_fn('기본언어')||'</td>
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
                  <td class="titletd require">'||get_fn('사업장')||'</td>
                  <td>
                    <select name="p_companycd" id="p_companycd" onchange="p_companycd_onchange();" '||v_disabled||'>
                      '); common.list_company(rec.companycd, v_lang, '2'); htp.p('
                    </select>
                  </td>
                  <td class="titletd require">'||get_fn('부서')||'</td>
                  <td class="inputtd">
                    '); common.list_dept(rec.companycd, rec.teamcd, 'select', null, 'p_teamcd', 'c', v_disabled_select); htp.p(' 
                  </td>
                </tr>
                
                <tr>
                  <td class="titletd require">'||get_fn('기본적용여부')||'</td>
                  <td class="inputtd">
                    '); 
                    if p_xuser is null then
                      common.list_catalog('COM','USEYN','Y','select', null, 'p_default_yn', 'c', 'disabled'); 
                    else
                      common.list_catalog('COM','USEYN',rec.default_yn,'select', null, 'p_default_yn', 'c', 'yes'); 
                    end if;
                    htp.p(' 
                  </td>
                  <td class="titletd require">'||get_fn('사용여부')||'</td>
                   <td class="inputtd">
                    '); common.list_catalog('COM','USEYN',rec.useyn,'select', null, 'p_useyn', 'c', 'yes'); htp.p(' 
                  </td>
                </tr>
                
                <tr>
                  <td class="titletd">'||get_fn('직급')||'</td>
                  <td class="inputtd">
                    '); common.list_catalog('GMS','RANK',rec.jikup,'select', null, 'p_jikup', 'c', 'yes'); htp.p(' 
                  </td>
                  <td class="titletd">'||get_fn('직책')||'</td>
                   <td class="inputtd">
                    '); common.list_catalog('COM','JIKUP',rec.position,'select', null, 'p_position', 'c', 'yes'); htp.p(' 
                  </td>
                </tr>
                
                <tr>
                  <td class="titletd require">'||get_fn('시작일')||'</td>
                  <td class="inputtd">
                    <input type="text" id="p_symd" name="p_symd" class="date" value="'||rec.symd||'" /></td>  
                  </td>
                  <td class="titletd">'||get_fn('종료일')||'</td>
                   <td class="inputtd">
                    <input type="text" id="p_eymd" name="p_eymd" class="date" value="'||rec.eymd||'" /></td>  
                  </td>
                </tr>
                   
              </tbody>
            </table>
          </div>
          
          </div>
          <div id="mygrid_container" style="width:100%;height:99%;"></div>    
        <!-- 신규 Form Setting E -->
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
      
      if p_default_yn = 'Y' then
      
        begin
          update  mdm0200_history
          set     default_yn = 'N'
          where   xuser = p_xuser
          and     gubun = p_gubun
          ;
        end;
        
      end if;
    
      begin
        insert into mdm0200
        ( xuser, xusernm, gubun, lang, email, mail_id, mobile, passwords, login_comp, login_id, login_ymd )
        values
        ( p_xuser, p_xusernm, p_gubun, p_lang, p_email, p_mail_id, p_mobile, '1111', v_comp, v_id, sysdate );
      exception
        when dup_val_on_index then
          update  mdm0200
          set     xusernm = p_xusernm,
                  lang = p_lang,
                  email = p_email,
                  mail_id = p_mail_id,
                  mobile = p_mobile,
                  login_comp = v_comp,
                  login_id = v_id,
                  login_ymd = sysdate
          where   xuser = p_xuser
          and     gubun = p_gubun
          ;
        when others then
          show_err('insert-xm001');
      end;
      
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
        WHEN others THEN   
          null;   
      end;
        
      htp.p('
        <script type="text/javascript">
          alert("'||get_fn( '저장되었습니다.')||'");
          opener.location.reload();
          location.href = "'||v_pkg||'.crrec?p_xuser='||p_xuser||'&p_gubun='||p_gubun||'&p_companycd='||p_companycd||'&p_teamcd='||p_teamcd||'&p_seq='||v_seq||'";
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
  END process;
 
  PROCEDURE list_max_seq_check
    (  
    p_xuser         in   varchar2 default null, 
    p_gubun         in   varchar2 default null,
    p_seq           in   varchar2 default null,
    p_default_yn    in   varchar2 default null,
    p_symd          in   varchar2 default null,
    p_eymd          in   varchar2 default null,
    p_flag          in   varchar2 default null
    )  
    IS  
    
    --삭제 시 기본적용여부(default_yn) Y 여부 조회
    cursor cur is 
      select  default_yn
      from    mdm0200_history  
      where   xuser = p_xuser
      and     gubun = p_gubun
      and     seq = p_seq
      ;
    
    --삭제 시 max_seq check
    cursor cur2 is 
      select  decode(p_seq, max(seq), 'Y', 'N')
      from    mdm0200_history  
      where   xuser = p_xuser
      and     gubun = p_gubun
      ;
      
    --저장 시 master table 중복 check
    cursor cur3 is 
      select  'X'
      from    mdm0200
      where   xuser = p_xuser
      and     gubun = p_gubun
      ;

    --저장 시 시작일 > 종료일 일 때 error check
    cursor cur4 is
      select  'T'
      from    mdm0200_history
      where   p_symd > p_eymd
      ;
      
    --저장 시 전 차수의 시작일보다 이를 때 error check
    cursor cur5 is
      select  'Q'
      from    mdm0200_history
      where   xuser = p_xuser
      and     gubun = p_gubun
      and     seq <= p_seq-1
      and     symd > p_symd
      ;
      
    --개정 시 전 차수의 시작일보다 이를 때 error check
    cursor cur6 is
      select  'Q'
      from    mdm0200_history
      where   xuser = p_xuser
      and     gubun = p_gubun
      and     symd > p_symd
      ;
      
    v_check varchar2(1);
    v_default_yn varchar2(1);
    v_master_data varchar2(1);
    v_date_check varchar2(1);
    v_symd_early_check varchar2(1);

    begin

      --삭제 시 flag
      if p_flag = '1' then
      
        open cur;
        fetch cur into v_check;
        close cur;
        
        open cur2;
        fetch cur2 into v_master_data;
        close cur2;
        
      --저장 시 flag
      elsif p_flag = '2' then
      
        if p_default_yn = 'N' then
          open cur;
          fetch cur into v_check;
          close cur;
        else
          v_check := '0';
        end if;
        
        open cur3;
        fetch cur3 into v_master_data;
        close cur3;
        
        open cur4;
        fetch cur4 into v_date_check;
        close cur4;
        
      --저장_수정 시
        if p_seq is not null then
          open cur5;
          fetch cur5 into v_symd_early_check;
          close cur5;
      --저장_개정 시
        else
          open cur6;
          fetch cur6 into v_symd_early_check;
          close cur6;
        end if;
      end if;
      
      htp.p('

      {"v_check" :  "'||v_check||'", "v_master" :  "'||v_master_data||'", "v_date" :  "'||v_date_check||'", "v_symd_early" :  "'||v_symd_early_check||'"}
     
      ');
        
   END list_max_seq_check;  
   
END COMC0010;

/
