--------------------------------------------------------
--  DDL for Package Body COMMESSAGE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "PREMIER"."COMMESSAGE" 
IS
  PROCEDURE control
  (
    p_systemcd in varchar2 default null,
    p_message_text in varchar2 default null
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
        var url = "'||v_pkg||'.crrec?p_dml_gubun=1";  
        newWnd2 = window.open(url,"'||v_pkg||'window","top=100, left=100, status=yes, resizable=no, scrollbars=yes, width=860, height=250");  
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
          
          <div class="cTitle"><label for="p_message_text">'||get_fn('메세지')||'</label></div>
          <div class="cInput">
            <input type="text" name="p_message_text" id="p_message_text" value="'||p_message_text||'"> 
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
    p_message_text in varchar2 default null
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
            
            x[i]=["'||get_fn('메시지ID')||'", "150","center","link","str","true"];i++;
            x[i]=["'||get_fn('메시지(한국어)')||'", "300","center","ro","str","true"];i++;
            x[i]=["'||get_fn('메시지(영어)')||'", "300","center","ro","str","true"];i++;
            x[i]=["'||get_fn('관리여부')||'", "100","center","ro","str","true"];i++;

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
            //url ="'||v_pkg||'.crrec?p_systemcd="+obj1+"&p_catalogcd="+obj2+"&p_dml_gubun=3";
            url ="'||v_pkg||'.crrec?p_systemcd="+obj1+"&p_catalogcd="+obj2+"&p_dml_gubun=1";
            newWnd2 = window.open(url,"'||v_pkg||'window","top=100, left=100, status=yes, resizable=no, scrollbars=yes, width=860, height=250");  
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
    p_message_text in varchar2 default null
  )
  IS
  
    cursor cur is 
      select systemcd, catalogcd, ko_message, en_message, (select mg_yn from c_0060 where systemcd=a.systemcd and catalogcd=a.catalogcd) mg_yn
      from( select  systemcd, 
                    catalogcd, 
                    ( select  message_text
                      from    c_0061
                      where   systemcd = a.systemcd
                      and     catalogcd = a.catalogcd
                      and     message_text = a.message_text
                      and     lang = 'KO'  
                    ) ko_message,
                    ( select  message_text
                      from    c_0061
                      where   systemcd = a.systemcd
                      and     catalogcd = a.catalogcd
                      and     message_text = a.message_text
                      and     lang = 'EN'  
                    ) en_message
            from    c_0061 a
            where   lang = 'KO'
            ) a
      where (ko_message like p_message_text||'%' or en_message like p_message_text||'%')
      and   nvl(systemcd, '*') = nvl(p_systemcd, nvl(systemcd, '*'))
      order by  1, 2;

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
          {value:"'||rec(i).ko_message||'"},
          {value:"'||rec(i).en_message||'"},
          {value:"'||rec(i).mg_yn||'"}

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
    p_dml_gubun in varchar2 default null
  )
  IS
  
  cursor cur is
    select  distinct
            ( select  message_text
              from    c_0061
              where   systemcd = a.systemcd
              and     catalogcd = a.catalogcd
              and     lang = 'KO' ) ko,
            ( select  message_text
              from    c_0061
              where   systemcd = a.systemcd
              and     catalogcd = a.catalogcd
              and     lang = 'EN' ) en,
            systemcd,
            catalogcd
    from    c_0061 a
    where   systemcd = p_systemcd
    and     catalogcd = upper(p_catalogcd);
          
    rec cur %rowtype;
    
    v_disabled varchar2(20);

  BEGIN  
        
    open cur;
    fetch cur into rec;
    close cur;
    
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
      
        function proc_save() {
          var thisForm = document.getElementById("form1");
          
          //필수값 체크
          if(!formRquried()){
            return false;  
          }     
                  
          if (!confirm("'||get_fn('저장하시겠습니까?')||'")) return false;
          $("#p_systemcd").removeAttr("disabled");
          //thisForm.p_dml_gubun.value = "1";
          thisForm.submit(); 
          
        }    

        function proc_del() {    
          var thisForm = document.getElementById("form1");
    
          if (!confirm("'||get_fn('삭제하시겠습니까?')||'")) return false;    
          $("#p_systemcd").removeAttr("disabled");
          thisForm.p_dml_gubun.value = "2";    
          thisForm.submit();   
        } 
        
      </script>      
    </head>    
    <body>                
      <form id="form1" name="form1" action="'||v_pkg||'.process" method="post" >
      <input type="hidden" id="p_dml_gubun" name="p_dml_gubun" value="'||p_dml_gubun||'" />
      
        <!-- 신규 Form Setting S -->
        <div class="formWrap">
        
          <!--상단타이틀/버튼-->
          <div class="formTop">
            <div class="formTitle">'||get_program_name('SYS',v_pkg,v_lang)||'</div>
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
                  <td class="titletd require">'||get_fn('시스템')||'</td>
                  <td class="inputtd">
                    <select id="p_systemcd" name="p_systemcd" '||v_disabled||'>
                      '); common.list_systemcd(p_systemcd, 'c');  htp.p('
                    </select>  
                  </td>
                  <td class="titletd">'||get_fn('메시지 ID')||'</td>
                  <td class="inputtd">
                    <input type="text" id="p_catalogcd" name="p_catalogcd" value="'||rec.catalogcd||'" / > 
                  </td>
                </tr>
                
                <tr>
                  <td class="titletd">'||get_fn('메세지(한국어)')||'</td>
                  <td class="inputtd" colspan="4">
                    <input type="text" id="p_ko_message" name="p_ko_message" value="'||rec.ko||'" /> 
                  </td>
                  <td></td> <td></td>
                </tr>
                
                <tr>
                  <td class="titletd">'||get_fn('메세지(영어)')||'</td>
                  <td class="inputtd" colspan="4">
                    <input type="text" id="p_en_message" name="p_en_message" value="'||rec.en||'" /> 
                  </td>
                  <td></td> <td></td>
                </tr>
                
              </tbody>
            </table>
          </div>
          
        </div>
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
    p_systemcd in varchar2 default null,
    p_catalogcd in varchar2 default null,
    p_dml_gubun in varchar2 default null,
    p_ko_message in varchar2 default null,
    p_en_message in varchar2 default null
  )
  IS
  
  BEGIN
    
--    htp.p(' 
--      <script type="text/javascript"> 
--        alert("' ||p_systemcd|| '"); 
--        alert("' ||p_catalogcd|| '"); 
--      </script> 
--    ');
       
    if p_dml_gubun = '1' then
      
      if p_ko_message is not null then
        BEGIN
          insert into c_0061
          ( systemcd, catalogcd, lang, message_text, useyn )
          values
          ( upper(p_systemcd), upper(p_catalogcd), 'KO', p_ko_message, 'Y' );
        EXCEPTION
          when dup_val_on_index then
            update  c_0061
            set     message_text = p_ko_message
            where   systemcd = upper(p_systemcd)
            and     catalogcd = upper(p_catalogcd)
            and     lang = 'KO';
          WHEN others THEN   
            null;   
        END;
      end if;
                
      if p_en_message is not null then
        BEGIN
          insert into c_0061 
          ( systemcd, catalogcd, lang, message_text, useyn )
          values
          ( upper(p_systemcd), upper(p_catalogcd), 'EN', p_en_message, 'Y' ); 
        EXCEPTION
          when dup_val_on_index then
            update c_0061
            set message_text = p_en_message
            WHERE systemcd = upper(p_systemcd)
            AND catalogcd = upper(p_catalogcd)
            and lang = 'EN';
          WHEN others THEN   
            null;   
        END;
      end if;
    
      htp.p('
      <script type="text/javascript">
        alert("'||get_fn( '저장되었습니다.')||'");
        opener.location.reload();
        location.href = "'||v_pkg||'.crrec?p_systemcd='||p_systemcd||'&p_catalogcd='||p_catalogcd||'&p_dml_gubun=3";
      </script>
      ');
    
    elsif p_dml_gubun = '2' then
      
      delete  c_0061
      where   systemcd = upper(p_systemcd)
      and     catalogcd = upper(p_catalogcd);
    
      htp.p(' 
      <script type="text/javascript"> 
        alert("' ||get_fn( '삭제되었습니다.')|| '"); 
        opener.location.reload();
        self.close(); 
      </script> 
       ');
        
    elsif p_dml_gubun=3 then
    
      update  c_0061
      set     message_text = p_ko_message
      WHERE   systemcd = upper(p_systemcd)
      AND     catalogcd = upper(p_catalogcd)
      and     lang = 'KO';
      
      update  c_0061
      set     message_text = p_en_message
      WHERE   systemcd = upper(p_systemcd)
      AND     catalogcd = upper(p_catalogcd)
      and     lang = 'EN';
        
      htp.p('
      <script type="text/javascript">
        alert("'||get_fn( '저장되었습니다.')||'");
        opener.location.reload();
        location.href = "'||v_pkg||'.crrec?p_systemcd='||p_systemcd||'&p_catalogcd='||p_catalogcd||'&p_dml_gubun='||p_dml_gubun||'";
      </script>
      ');
      
    end if;
    
  EXCEPTION
    when others then 
      show_err('process');
  END process;
 
END COMMESSAGE;

/
