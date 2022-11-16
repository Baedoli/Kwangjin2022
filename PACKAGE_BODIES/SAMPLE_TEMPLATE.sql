--------------------------------------------------------
--  DDL for Package Body SAMPLE_TEMPLATE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "PREMIER"."SAMPLE_TEMPLATE" 
IS
  PROCEDURE control
  (
    p_companycd in varchar2 default common.get_cookie('SYSCOMP'),
    p_symd in varchar2 default to_char(trunc(sysdate,'mm'),'yyyymmdd'),
    p_eymd in varchar2 default to_char(sysdate,'yyyymmdd'),
    p_gubun in varchar2 default null,
    p_4m_no in varchar2 default null,
    p_part_no in varchar2 default null
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

        myLayout.cells("a").setText("■ Template");
        //myLayout.cells("a").hideHeader();
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
      
      function doExcel(){
        alert("개발중입니다."); return false;
      }
      
      function doCrrec(){  
        var url = "'||v_pkg||'.crrec?p_companycd='||p_companycd||'";  
        newWnd2 = window.open(url,"'||v_pkg||'window","top=100, left=100, status=yes, resizable=no, scrollbars=yes, width=1000, height=950");  
        newWnd2.focus();
      } 
      
      function doCrrec2(){  
        var url = "'||v_pkg||'.crrec2?p_companycd='||p_companycd||'";  
        newWnd2 = window.open(url,"'||v_pkg||'2window","top=100, left=100, status=yes, resizable=no, scrollbars=yes, width=1000, height=950");  
        newWnd2.focus();
      }
      
      $(function() {
        doOnLoad();
        
        $(window).on("resize", function(){
          myLayout.detachHeader();
          attachHeader();
        });
        
        $("#p_symd, #p_eymd").datepicker({
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
          <div class="cTitle"><label for="p_symd">'||get_fn('등록날짜')||'</label></div>
          <div class="cInput">
            <input type="text" id="p_symd" name="p_symd" value="'||p_symd||'" class="cDate"> ~ 
            <input type="text" id="p_eymd" name="p_eymd" value="'||p_eymd||'" class="cDate">
          </div>
        </div>

        <div class="cBox">
          <div class="cTitle"><label for="p_gubun">'||get_fn('구분')||'</label></div>
          <div class="cInput">
            '); common.list_catalog('QIS','GUIDELINE',p_gubun,'select', null, 'p_gubun', 'a', 'yes'); htp.p('
          </div>
        </div>

        <div class="cBox">  
          <div class="cTitle"><label for="p_4m_no">4M</label></div>
          <div class="cInput">
            <input type="text" name="p_4m_no" id="p_4m_no" value="">
          </div>
        </div>

        <div class="cBox">
          <div class="cTitle"><label for="p_part_no">'||get_fn('품번')||'</label></div>
          <div class="cInput">
            <input type="text" name="p_part_no" id="p_part_no" class="cSearch" value="" >
          </div>
        </div>
        
      </div>
      <div id="c11">
        <a href="#" target="list" onclick="doQuery(); return false;" class="btn-search buttons">'||get_fn('조회')||'</a>
      </div>
      <div class="crlf"></div>
    </div>
    <div id="c22">
      <div class="floatL letterNarrow" style="line-height:120%;">
        <span>※'||get_fn('제출월')||' : </span>
        <strong class="txtShape txtGray">○</strong>
        <span>'||get_fn('계획')||'</span>
        <strong class="txtShape txtGray">●</strong>
        <span>'||get_fn('실적')||'</span>
        <strong class="txtShape txtGreen">●</strong>
        <span>'||get_fn('결재')||'('||get_fn('합격')||')</span>
        <strong class="txtShape txtRed">●</strong>
        <span>'||get_fn('결재')||'('||get_fn('불합격')||')</span>
      </div>
      <div class="floatR">
        <a href="#" target="list" onclick="doExcel(); return false;" class="btn-excel buttons">'||get_fn('엑셀다운로드')||'</a>
        <a href="#" target="list" onclick="doCrrec(); return false;" class="btn-new buttons">'||get_fn('셈플')||'1</a>
        <a href="#" target="list" onclick="doCrrec2(); return false;" class="btn-new buttons">'||get_fn('셈플')||'2</a>
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
    p_symd in varchar2 default null,
    p_eymd in varchar2 default null,
    p_gubun in varchar2 default null,
    p_4m_no in varchar2 default null,
    p_part_no in varchar2 default null
  )
  IS
    
  BEGIN    
    htp.p('
  <!DOCTYPE html">
  <html lang="ko">
    <head>
      <title>'||common.title||'</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta http-equiv="Content-Type" content="application/xhtml+xml; charset=utf-8" />  ');
        dbv_grid.print_env_v451;
        htp .p('
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
            x[i]=["'||get_fn('셈플')||'", "80","center","ro","str","true"];i++;
            
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
            newWnd2 = window.open(url,"'||v_pkg||'window","top=100, left=100, status=yes, resizable=no, scrollbars=yes, width=1000, height=950");  
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
    p_symd in varchar2 default null,
    p_eymd in varchar2 default null,
    p_gubun in varchar2 default null,
    p_4m_no in varchar2 default null,
    p_part_no in varchar2 default null
  )
  IS
    cursor cur is
      select 1 sample_
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
          {value:"'||rec(i).sample_||'"}
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
  
  BEGIN  
  
    v_linkid := '02!TEST-2210-001';
        
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
        $("#p_j_ymd").datepicker({
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
    <form id="form1" name="form1" action="'||v_pkg||'.process" method="post" >
      <!--결재 Setting S -->
      <div class="aprvProgress">
        <div class="aprvPwrap">
          <div class="'||get_doc_status(279899,'A')||'">'||get_fn('결재대기')||'</div>
          <div><hr></div>
          <div class="'||get_doc_status(279899,'B')||'">'||get_fn('결재진행')||'</div>
          <div><hr></div>
          <div class="'||get_doc_status(279899,'C')||'">'||get_fn('결재완료')||'</div>
        </div>
        <div class="aprvBtn aprvExit" onclick="toggle_layer()" id="aprvBtn1" title="'||get_fn('결재상태닫기')||'"></div>
        <div class="aprvBtn aprvEnter" onclick="toggle_layer()" id="aprvBtn2" title="'||get_fn('결재상태열기')||'"></div>
        <div class="aprvCmt" onclick="approval_descr(279899)">'||get_fn('의견보기')||'</div>
      </div>
      <iframe id="approvStatus" name="approvStatus" src="approval_status_rev?p_doc_id=279899" frameborder="no" scrolling="auto"></iframe>
      <!--결재 Setting E -->
      
      <!-- 신규 Form Setting S -->
      <div class="formWrap">
      
        <!--상단타이틀/버튼 S -->
        <div class="formTop">
          <div class="formTitle">'||get_program_name('QMS',v_pkg,v_lang)||'</div>
          <div class="btnbar">
            <a href="#" class="btn-save buttons" onclick="proc_save(); return false;">'||get_fn('저장')||'</a>&nbsp;
            <a href="#" class="btn-approval buttons" onclick="crDoc(); return false;">'||get_fn('결재')||'</a>&nbsp;
            <a href="#" class="btn-delete buttons" onclick="proc_del(); return false;">'||get_fn('삭제')||'</a>&nbsp;
            <a href="#" class="btn-close buttons" onclick="self.close(); return false;">'||get_fn('닫기')||'</a>
          </div>
        </div>
        <!--상단타이틀/버튼 E -->
        
        <!--테이블입력-->
        <div>
          <!--td 안에 값만 출력하는 화면일 경우 class="table_ro" 사용 --> 
          <!--<table width="100%" border="0" cellspacing="0" cellpadding="4" class="table_ro">-->
          <table width="100%" border="0" cellspacing="0" cellpadding="4">
            <tbody>
            
              <tr>
                <td class="titletd">4M '||get_fn('번호')||'</td>
                <td class="inputtd">
                  <input readonly="readonly" id="p_register_no" name="p_register_no" value="">
                </td>
                <td class="titletd require">'||get_fn('구분')||'</td>
                <td class="inputtd"> 
                  <select id="p_gubun" name="p_gubun"> 
                    <option value="A">'||get_fn('사내')||'</option>
                    <option value="B">'||get_fn('사외')||'</option>
                  </select>
                </td>
              </tr>
              <tr>
                <td class="titletd require">'||get_fn('품번')||'</td>
                <td class="inputtd">
                  <input type="text" id="p_partno" name="p_partno" value="" class="iconSearch">
                </td>
                <td class="titletd require">'||get_fn('적용예정일')||'</td>
                <td class="inputtd">
                  <input type="text" id="p_j_ymd" name="p_j_ymd" maxlength="8" class="iconDate" value="">
                </td>
              </tr>
              <tr>
                <td class="titletd require">'||get_fn('변경유형')||'1</td>
                <td class="inputtd">
                  <input type="radio" id="p_b_gbn_1" name="p_b_gbn" value="A"><label class="label-radio" for="p_b_gbn_1">'||get_fn('사람')||'</label>
                  <input type="radio" id="p_b_gbn_2" name="p_b_gbn" value="B"><label class="label-radio" for="p_b_gbn_2">'||get_fn('설비')||'</label>
                  <input type="radio" id="p_b_gbn_3" name="p_b_gbn" value="C"><label class="label-radio" for="p_b_gbn_3">'||get_fn('방법')||'</label>
                  <input type="radio" id="p_b_gbn_4" name="p_b_gbn" value="D"><label class="label-radio" for="p_b_gbn_4">'||get_fn('원자재')||'</label>
                  <input type="radio" id="p_b_gbn_5" name="p_b_gbn" value="E"><label class="label-radio" for="p_b_gbn_5">'||get_fn('의식')||'</label>
                </td>
                <td class="titletd require">'||get_fn('변경유형')||'2</td>
                <td class="inputtd">
                  '); common.list_catalog('QMS','4M_GUBUN', null,'input', 'checkbox', 'p_send', 'z', 'yes'); htp.p('
                </td>
              </tr>
              <tr>
                <td class="titletd require">'||get_fn('제목')||'</td>
                <td class="inputtd" colspan="3">
                  <input type="text" name="p_b_title" maxlength="100">      
                </td>
              </tr>
              <tr>
                <td class="titletd">'||get_fn('고객허용유무')||'</td>
                <td class="inputtd">
                  <select id="p_customer_yn" name="p_customer_yn"> 
                    <option value="Y">'||get_fn('필요')||'</option>
                    <option value="N" selected="selected">'||get_fn('불필요')||'</option>
                  </select>
                </td>
                <td></td>
                <td></td>
              </tr>
              <tr>
                <td class="titletd titleTop">'||get_fn('변경내용')||'</td>
                <td class="inputtd">
                  <textarea id="p_b_descr_1" name="p_b_descr_1"></textarea>
                </td>
                <td class="titletd titleTop"'||get_fn('변경효과')||'></td>
                <td class="inputtd">
                  <textarea id="p_b_descr_2" name="p_b_descr_2"></textarea>
                </td>
              </tr>
              <tr>        
                <td class="titletd">'||get_fn('현상그림 첨부')||'('||get_fn('양품')||')</td>        
                <td class="inputtd" colspan="4">        
                  <iframe id="attachList1" name="attachList1" src="/premier_util/file/uploadFileView.do?linktypecd=QMS_TEMP_LJS_IMG_FILE&linkid='||v_linkid||'&ext=jpg,gif,png&readonly=N" style="width: 100%; height: 90px;" scrolling="no" frameborder="0"></iframe>        
                </td>        
              </tr>
              <tr>        
                <td class="titletd">'||get_fn('현상그림 첨부')||'('||get_fn('양품')||')</td>        
                <td class="inputtd" colspan="4">        
                  <img onClick="popupImageView(''QMS_TEMP_LJS_IMG_FILE'','''||v_linkid||''')" src="'||vault_download('QMS_TEMP_LJS_IMG_FILE',v_linkid)||'" width="260px" height="200px">     
                </td>        
              </tr>
              <tr>        
                <td class="titletd">'||get_fn('첨부파일')||'</td>        
                <td class="inputtd" colspan="4">        
                  <iframe id="attachList3" name="attachList3" src="/premier_util/file/uploadFileView.do?linktypecd=QMS_TEMP_LJS_FILE&linkid='||v_linkid||'&readonly=N" style="width: 100%; height: 200px;" scrolling="no" frameborder="0"></iframe>        
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
  
  PROCEDURE crrec2
  (
    p_companycd in varchar2 default null
  )
  IS
  
  BEGIN  
  
    v_linkid := '02!TEST-2210-001';
        
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
        $("#p_j_ymd").datepicker({
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
        var v_cnt = 0;
        
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
      <!--결재 Setting S -->
      <div class="aprvProgress">
        <div class="aprvPwrap">
          <div class="'||get_doc_status(291037,'A')||'">'||get_fn('결재대기')||'</div>
          <div><hr></div>
          <div class="'||get_doc_status(291037,'B')||'">'||get_fn('결재진행')||'</div>
          <div><hr></div>
          <div class="'||get_doc_status(291037,'C')||'">'||get_fn('결재완료')||'</div>
        </div>
        <div class="aprvBtn aprvExit" onclick="toggle_layer()" id="aprvBtn1" title="'||get_fn('결재상태닫기')||'"></div>
        <div class="aprvBtn aprvEnter" onclick="toggle_layer()" id="aprvBtn2" title="'||get_fn('결재상태열기')||'"></div>
        <div class="aprvCmt" onclick="approval_descr(291037)">'||get_fn('의견보기')||'</div>
      </div>
      <iframe id="approvStatus" name="approvStatus" src="approval_status_rev?p_doc_id=291037" frameborder="no" scrolling="auto"></iframe>
      <!--결재 Setting E -->
      
      <!-- 신규 Form Setting S -->
      <div class="formWrap">
      
        <!--상단타이틀/버튼 S -->
        <div class="formTop">
          <div class="formTitle">'||get_program_name('QMS',v_pkg,v_lang)||'</div>
          <div class="btnbar">
            <a href="#" class="btn-save buttons" onclick="proc_save(); return false;">'||get_fn('저장')||'</a>&nbsp;
            <a href="#" class="btn-approval buttons" onclick="crDoc(); return false;">'||get_fn('결재')||'</a>&nbsp;
            <a href="#" class="btn-delete buttons" onclick="delete_rec(); return false;">'||get_fn('삭제')||'</a>&nbsp;
            <a href="#" class="btn-close buttons" onclick="self.close(); return false;">'||get_fn('닫기')||'</a>
          </div>
        </div>
        <!--상단타이틀/버튼 E -->
        
        <!--테이블입력-->
        <div>
          <table width="100%" border="0" cellspacing="0" cellpadding="4">
            <tbody>
            
              <tr>
                <td class="titletd">4M '||get_fn('번호')||'</td>
                <td class="inputtd">
                  <input readonly="readonly" id="p_register_no" name="p_register_no" value="">
                </td>
                <td class="titletd require">'||get_fn('구분')||'</td>
                <td class="inputtd"> 
                  <select id="p_gubun" name="p_gubun"> 
                    <option value="A">'||get_fn('사내')||'</option>
                    <option value="B">'||get_fn('사외')||'</option>
                  </select>
                </td>
              </tr>
              <tr>
                <td class="titletd require">'||get_fn('품번')||'</td>
                <td class="inputtd">
                  <input type="text" id="p_partno" name="p_partno" value="" class="iconSearch">
                </td>
                <td class="titletd require">'||get_fn('적용예정일')||'</td>
                <td class="inputtd">
                  <input type="text" id="p_j_ymd" name="p_j_ymd" maxlength="8" class="iconDate" value="">
                </td>
              </tr>
              <tr>
                <td class="titletd require">'||get_fn('변경유형')||'1</td>
                <td class="inputtd">
                  <input type="radio" id="p_b_gbn_1" name="p_b_gbn" value="A"><label class="label-radio" for="p_b_gbn_1">'||get_fn('사람')||'</label>
                  <input type="radio" id="p_b_gbn_2" name="p_b_gbn" value="B"><label class="label-radio" for="p_b_gbn_2">'||get_fn('설비')||'</label>
                  <input type="radio" id="p_b_gbn_3" name="p_b_gbn" value="C"><label class="label-radio" for="p_b_gbn_3">'||get_fn('방법')||'</label>
                  <input type="radio" id="p_b_gbn_4" name="p_b_gbn" value="D"><label class="label-radio" for="p_b_gbn_4">'||get_fn('원자재')||'</label>
                  <input type="radio" id="p_b_gbn_5" name="p_b_gbn" value="E"><label class="label-radio" for="p_b_gbn_5">'||get_fn('의식')||'</label>
                </td>
                <td class="titletd require">'||get_fn('변경유형')||'2</td>
                <td class="inputtd">
                  '); common.list_catalog('QMS','4M_GUBUN', null,'input', 'checkbox', 'p_send', 'z', 'yes'); htp.p('
                </td>
              </tr>
              <tr>
                <td class="titletd require">'||get_fn('제목')||'</td>
                <td class="inputtd" colspan="3">
                  <input type="text" name="p_b_title" maxlength="100">      
                </td>
              </tr>
              <tr>
                <td class="titletd">'||get_fn('고객허용유무')||'</td>
                <td class="inputtd">
                  <select id="p_customer_yn" name="p_customer_yn"> 
                    <option value="Y">'||get_fn('필요')||'</option>
                    <option value="N" selected="selected">'||get_fn('불필요')||'</option>
                  </select>
                </td>
                <td></td>
                <td></td>
              </tr>
              <tr>
                <td class="titletd titleTop require">'||get_fn('변경내용')||'</td>
                <td class="inputtd">
                  <textarea id="p_b_descr_1" name="p_b_descr_1"></textarea>
                </td>
                <td class="titletd titleTop">'||get_fn('변경효과')||'</td>
                <td class="inputtd">
                  <textarea id="p_b_descr_2" name="p_b_descr_2"></textarea>
                </td>
              </tr>
              <tr>        
                <td class="titletd">'||get_fn('현상그림 첨부')||'('||get_fn('양품')||')</td>        
                <td class="inputtd" colspan="4">        
                  <iframe id="attachList1" name="attachList1" src="/premier_util/file/uploadFileView.do?linktypecd=QMS_TEMP_LJS_IMG_FILE&linkid='||v_linkid||'&ext=jpg,gif,png&readonly=N" style="width: 100%; height: 90px;" scrolling="no" frameborder="0"></iframe>        
                </td>        
              </tr>
              <tr>        
                <td class="titletd">'||get_fn('현상그림 첨부')||'('||get_fn('양품')||')</td>        
                <td class="inputtd" colspan="4">        
                  <img onClick="popupImageView(''QMS_TEMP_LJS_IMG_FILE'','''||v_linkid||''')" src="'||vault_download('QMS_TEMP_LJS_IMG_FILE',v_linkid)||'" width="260px" height="200px">     
                </td>        
              </tr>
              <tr>        
                <td class="titletd">'||get_fn('첨부파일')||'</td>        
                <td class="inputtd" colspan="4">        
                  <iframe id="attachList3" name="attachList3" src="/premier_util/file/uploadFileView.do?linktypecd=QMS_TEMP_LJS_FILE&linkid='||v_linkid||'&readonly=N" style="width: 100%; height: 200px;" scrolling="no" frameborder="0"></iframe>        
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
      show_err('crrec2');
  END crrec2;
  
END sample_template;

/
