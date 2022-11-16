--------------------------------------------------------
--  DDL for Package Body SAMPLE_ATTACHFORM
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "PREMIER"."SAMPLE_ATTACHFORM" 
IS
  PROCEDURE control
  (
    p_companycd in varchar2 default common.get_cookie('SYSCOMP')
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
          
        myLayout.cells("a").setText("■ AttachForm");
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
          <div class="cTitle"><label for="p_companycd">'||get_fn('사업장')||'</label></div>
          <div class="cInput">
            <select name="p_companycd" id="p_companycd">
            '); common.list_company(p_companycd, v_lang); htp.p('
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
    p_companycd in varchar2 default null
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
            x[i]=["'||get_fn('등록번호')||'", "200","center","link","str","true"];i++;
            x[i]=["'||get_fn('등록시간')||'", "200","center","ro","str","true"];i++;
            x[i]=["'||get_fn('첨부파일')||'", "400","left","ro","str","true"];i++;
            
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
          
          function link_(obj1, obj2){
            url ="'||v_pkg||'.crrec?p_companycd="+obj1+"&p_register_no="+obj2;
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
    p_companycd in varchar2 default null
  )
  IS
    cursor cur is
      select *
      from temp_ljs
      where companycd = p_companycd
      order by login_ymd desc
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
    
      v_link := '^javascript:link_(\"'||rec(i).companycd||'\", \"'||rec(i).register_no||'\")^_self';
      v_linkid := rec(i).companycd||'!'||rec(i).register_no;
      
      htp .p('
      { id:' ||i|| ',
        data:[
          {value:"'||i||'"},
          {value:"'||rec(i).register_no||v_link||'"},
          {value:"'||to_char(rec(i).login_ymd,'yyyy-mm-dd hh24:mi:ss')||'"},
          {value:"'||vault_grid('QMS_TEMP_LJS_FILE',v_linkid)||'"}
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
    p_register_no in varchar2 default null
  )
  IS
    cursor cur is
      select *
      from temp_ljs
      where companycd = p_companycd
      and   register_no = p_register_no
      ;
      
      rec temp_ljs%rowtype;
      
  BEGIN
  
    open cur;
    fetch cur into rec;
    close cur;  
    
    /** 첨부파일 설정 **/
    v_linkid := rec.companycd||'!'||rec.register_no;
        
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
        
        //필수입력값.. 
        //if(input_valid("",thisForm.p_vendcd.value,true,"'||get_fn('협력업체')||'",20)){thisForm.p_vendcd.focus();return false;}    
        
        if($("#attachList1")[0].contentWindow.vault.data.getLength() == 0){
          alert("' ||get_fn ('첨부파일을 첨부하세요.')|| '");
          return false;
        }  
                
        if (!confirm("'||get_fn('저장하시겠습니까?')||'")) return false;
             
        /***** 첨부파일 설정 - S *****/ 
        if($("#attachList1")[0].contentWindow.TEMP_FILE_LIST.length > 0){
          $.each($("#attachList1")[0].contentWindow.TEMP_FILE_LIST,function(index,item){
            $("#form1").append("<input type=''hidden'' name=''p_attachList1'' value=''"+item+"''>");
          });
        }else{
          $("#form1").append("<input type=''hidden'' name=''p_attachList1'' value=''''''>");
        }
         
        if($("#attachList3")[0].contentWindow.TEMP_FILE_LIST.length > 0){
          $.each($("#attachList3")[0].contentWindow.TEMP_FILE_LIST,function(index,item){
            $("#form1").append("<input type=''hidden'' name=''p_attachList3'' value=''"+item+"''>");
          });
        }else{
          $("#form1").append("<input type=''hidden'' name=''p_attachList3'' value=''''''>");
        }
        
        /***** 첨부파일 설정 - E *****/
        
        thisForm.p_dml_gubun.value = "1";
        thisForm.submit(); 
  
      }    

      function proc_del() {    
        var thisForm = document.getElementById("form1");
  
        $("#form1").append("<input type=''hidden'' name=''p_attachList1'' value=''''''>");
        $("#form1").append("<input type=''hidden'' name=''p_attachList3'' value=''''''>");
        
        if (!confirm("'||get_fn('삭제하시겠습니까?')||'")) return false;    
        thisForm.p_dml_gubun.value = "2";    
        thisForm.submit();   
      } 
      
    </script>      
  </head>    
  <body>                
    <form id="form1" name="form1" action="'||v_pkg||'.process" method="post" >
      <input type="hidden" name="p_dml_gubun" value="" />
      <input type="hidden" name="p_companycd" value="'||p_companycd||'" />
      <div class="formWrap">
      
        <!--상단타이틀/버튼-->
        <div class="formTop">
          <div class="formTitle">'||get_program_name('QMS',v_pkg,v_lang)||'</div>
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
                <td class="titletd require">4M '||get_fn('번호')||'</td>
                <td class="inputtd">
                  <input readonly="readonly" id="p_register_no" name="p_register_no" value="'||rec.register_no||'">
                </td>
                <td class=""></td>
                <td class=""> 
                </td>
              </tr>      
              <tr>        
                <td class="titletd">'||get_fn('현상그림 첨부')||'('||get_fn('양품')||')</td>        
                <td class="inputtd" colspan="4">        
                  <iframe id="attachList1" name="attachList1" src="/premier_util/file/uploadFileView.do?linktypecd=QMS_TEMP_LJS_IMG_FILE&linkid='||v_linkid||'&ext=jpg,gif,png&readonly=N" style="width: 100%; height: 90px;" scrolling="no" frameborder="0"></iframe>        
                </td>        
              </tr>
              <tr>        
                <td class="titletd">'||get_fn('첨부파일')||'</td>        
                <td class="inputtd" colspan="4">        
                  <iframe id="attachList3" name="attachList3" src="/premier_util/file/uploadFileView.do?linktypecd=QMS_TEMP_LJS_FILE&linkid='||v_linkid||'&readonly=N" style="width: 100%; height: 200px;" scrolling="no" frameborder="0"></iframe>        
                </td>
              </tr>
              <tr>        
                <td class="titletd">'||get_fn('현상그림 첨부')||'('||get_fn('양품')||')</td>        
                <td class="inputtd" colspan="4">        
                  <img onClick="popupImageView(''QMS_TEMP_LJS_IMG_FILE'','''||v_linkid||''')" src="'||vault_download('QMS_TEMP_LJS_IMG_FILE',v_linkid)||'" width="260px" height="200px">        
                </td>        
              </tr>
              
            </tbody>
          </table>
        </div>
        
      </div>
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
    p_register_no in varchar2 default null,
    p_attachList1 in owa_util.vc_arr,
    p_attachList3 in owa_util.vc_arr
  )
  IS
    cursor cur is
      select nvl(lpad(max(to_number(substr(register_no,-3,3)))+1,3,'0'),'001') as regi
      from temp_ljs
      where companycd = p_companycd
      ;
      
      v_regi varchar2(100);
      v_register_no temp_ljs.register_no%type;
      v_linkid varchar2(200);
      
  BEGIN
  
    if p_register_no is not null then
      v_register_no := p_register_no;
    else
      open cur;
      fetch cur into v_regi;
      close cur;
      
      v_register_no := 'TEST-'||to_char(sysdate,'yymm')||'-'||v_regi;
    end if;
    
    v_linkid := p_companycd||'!'||v_register_no;
    
    if p_dml_gubun = '1' then
      
      begin
        insert into temp_ljs(companycd, register_no, login_companycd, login_id, login_ymd)
        values(p_companycd, v_register_no, v_comp, v_id, sysdate);
      exception
        when dup_val_on_index then
          update temp_ljs
          set login_companycd = v_comp, 
              login_id = v_id, 
              login_ymd = sysdate
          where companycd = p_companycd
          and   register_no = v_register_no
          ;
        when others then
          show_err('insert-temp_ljs');
      end;
      
      /***** 첨부파일 설정 - S *****/
      if p_attachList1.count > 0 then
      common.save_file_info(p_attachList1, v_linkid);
      end if;
      
      if p_attachList3.count > 0 then
      common.save_file_info(p_attachList3, v_linkid);
      end if;      
      /***** 첨부파일 설정 - E *****/
    
      htp.p('
        <script type="text/javascript">
          alert("'||get_fn( '저장되었습니다.')||'");
          opener.location.reload();
          location.href = "'||v_pkg||'.crrec?p_companycd='||p_companycd||'&p_register_no='||v_register_no||'";
        </script>
        ');
    
    elsif p_dml_gubun = '2' then
      
      begin
        delete from temp_ljs
        where companycd = p_companycd
        and   register_no = v_register_no
        ;
      exception
        when others then
          show_err('delete-temp_ljs');
      end;
      
      /***** 첨부파일 설정 - S *****/      
      common.remove_file_info('QMS_TEMP_LJS_IMG_FILE', v_linkid);
      common.remove_file_info('QMS_TEMP_LJS_FILE', v_linkid);
      /***** 첨부파일 설정 - E *****/
    
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
 
END sample_attachForm;

/
