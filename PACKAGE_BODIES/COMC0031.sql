--------------------------------------------------------
--  DDL for Package Body COMC0031
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "PREMIER"."COMC0031" 
IS
  PROCEDURE control
  (
    p_systemcd in varchar2 default null
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
        var url = "'||v_pkg||'.crrec?p_systemcd='||p_systemcd||'";  
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
          <div class="cTitle"><label for="p_systemcd">'||get_fn('시스템')||'</label></div>
          <div class="cInput">
            <select name="p_systemcd" id="p_systemcd"">
            '); common.list_systemcd(p_systemcd, 'a'); htp.p('
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
  
  PROCEDURE query_a
  (
    p_systemcd in varchar2 default null
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
            
            x[i]=["'||get_fn('권한')||'", "100","left","link","str","true"];i++;
            x[i]=["'||get_fn('권한명')||'", "300","left","ro","str","true"];i++;
            
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
            url ="'||v_pkg||'.crrec?p_systemcd="+obj1+"&p_grade="+obj2;
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
    p_systemcd in varchar2 default null
  )
  IS
    cursor cur is
      select  systemcd, grade, descr
      from    c_0030
      where   nvl(systemcd, '*') = nvl(p_systemcd, nvl(systemcd, '*'))
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
      v_link := '^javascript:link_(\"'||rec(i).systemcd||'\", \"'||rec(i).grade||'\")^_self';
      htp .p('
      { id:' ||i|| ',
        data:[
          {value:"'||rec(i).grade||v_link||'"},
          {value:"'||rec(i).descr||'"}
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
    p_systemcd in varchar2 default null,
    p_grade in varchar2 default null
    
  )
  IS
    
  cursor cur is
    select  systemcd, grade, descr
    from    c_0030
    where   systemcd = p_systemcd
    and     grade = p_grade;
    
  rec cur %rowtype;

  cursor cur2 is 
    select  *   
    from    ( select  b.systemcd, b.pgmid, b.descr, case when a.pgmid is null then '0' else '1' end gb, a.pgm_level   
              from    ( select  * 
                        from    c_0031 
                        where   systemcd = p_systemcd
                        and     grade = p_grade) a, 
                      ( select  * 
                        from    c_0040 
                        where   systemcd = p_systemcd
                        and     pgm_gb = 'P')b   
              where   a.systemcd(+) = b.systemcd    
              and     a.pgmid(+) = b.pgmid)   
    order by  gb desc, pgmid;   

    v_disabled varchar(20);
    v_link2 varchar2(100) := null;

    type r2 is table of cur2%rowtype index by pls_integer;
    rec2 r2;
      
  BEGIN   
      
    open cur;   
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

        $(function() {  
          doInitGrid2();
        });   
        
        function proc_save() {
          var thisForm = document.getElementById("form1");
          
          //필수값 체크
          if(!formRquried()){
            return false;  
          }     
                  
          if (!confirm("'||get_fn('저장하시겠습니까?')||'")) return false;
                 
          thisForm.submit(); 
          
        }    

        data={ rows:[           
          ');  
        
          for i in 1 .. rec2.count loop  
             
            htp.p('
              { id:'||i||',
                data:[
                  {value:"'||rec2(i).gb||'"},
                  {value:"'||return_html_text(rec2(i).pgmid)||'"},
                  {value:"'||return_html_text(rec2(i).descr)||'"},
                  {value:"'||return_html_text(rec2(i).pgm_level)||'"},
                  {value:"'||return_html_text(rec2(i).gb)||'"},
                  {value:"'||return_html_text(rec2(i).pgm_level)||'"}
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
          var v_width="";
          var v_align="";
          var v_types="";
          var v_sorting="";
          var v_tooltip="";
          var x = new Array(9);
          var cm = "";
          var i = 0;     
          x[i]=["#master_checkbox","50","center","ch","str","false"]; i=i+1;
          x[i]=["'||get_fn('프로그램 ID')||'","100","center","ro","str","false"];i=i+1;
          x[i]=["'||get_fn('프로그램명')||'","150","center","ro","str","false"];i=i+1;
          x[i]=["'||get_fn('등급')||'","150","center","coro","str","false"];i=i+1;
          x[i]=["","0","left","ro","str","false"];i=i+1;        //선택 이전값   
          x[i]=["","0","left","ro","str","false"];i=i+1;        //pgm_leven이전값  
             
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
          
          var combo_1 = mygrid2.getCombo(3);        
                  
          ');   
          declare   
            cursor f_1 is   
              select  1 step, null pgm_level   
              from    dual   
              union all   
              select  distinct 2 step, pgm_level   
              from    c_0031   
              where   systemcd = p_systemcd   
              order by  step, pgm_level;   
          begin   
            for rc in f_1 loop   
              htp.p('combo_1.put("'||rc.pgm_level||'","'||rc.pgm_level||'");');     
            end loop;   
          end;   
          htp.p('   
      
          mygrid2.init();
          mygrid2.enableHeaderMenu();
          mygrid2.enableDistributedParsing(true,10,300);
          mygrid2.preventIECaching(false);
          mygrid2.setSkin("dhx_web");
         
          mygrid2.parse(data,"json");  
        }
          
        function save_(){   
            var cnt=0;   
            var row=mygrid2.getRowsNum();   
            var thisForm=document.getElementById("form1");             
            for(i=1;i<=row;i++){               
                if(mygrid2.cells(i,0).getValue()!=mygrid2.cells(i,4).getValue() || mygrid2.cells(i,3).getValue()!=mygrid2.cells(i,5).getValue()){   
                    cnt=cnt+1;   
                }   
            }   
            if(cnt==0){   
                alert("변경된 내역이 없습니다.");   
            }   
            else{   
                for(i=1;i<=row;i++) {   
                    if(mygrid2.cells(i,0).getValue()!=mygrid2.cells(i,4).getValue() || mygrid2.cells(i,3).getValue()!=mygrid2.cells(i,5).getValue()){                           
                        $("#form1").append("<input type=''hidden'' name=''p_chk'' value=''"+mygrid2.cells(i,0).getValue()+"''>");   
                        $("#form1").append("<input type=''hidden'' name=''p_pgmid'' value=''"+mygrid2.cells(i,1).getValue()+"''>");   
                        $("#form1").append("<input type=''hidden'' name=''p_pgm_level'' value=''"+mygrid2.cells(i,3).getValue()+"''>");   
                    }   
                }   
                if(confirm("저장하시겠습니까?")){
                  $("#p_systemcd").removeAttr("disabled");
                  $("#p_grade").removeAttr("disabled");   
                  thisForm.submit();         
                }   
            }   
        }  
        
      </script>      
    </head>    
    <body>                
      <form id="form1" name="form1" action="'||v_pkg||'.process" method="post" >
        <input type="hidden" id="p_systemcd "name="p_systemcd" value="'||p_systemcd||'">   
        <!-- 신규 Form Setting S -->
        <div class="formWrap">
        
          <!--상단타이틀/버튼-->
          <div class="formTop">
            <div class="formTitle">'||get_program_name('SYS',v_pkg,v_lang)||'</div>
            <div class="btnbar">
              <a href="#" class="btn-save buttons" onclick="save_(); return false;">'||get_fn('저장')||'</a>&nbsp;
              <a href="#" class="btn-close buttons" onclick="self.close(); return false;">'||get_fn('닫기')||'</a>
            </div>
          </div>
          
          <!--테이블입력-->
          <div>
            <table width="100%" border="0" cellspacing="0" cellpadding="4">
              <tbody>
              
                <tr>
                  <td class="titletd">'||get_fn('권한코드')||'</td>
                  <td class="inputtd"> 
                    <input type="text" id="p_grade" name="p_grade" '||v_disabled||' value="'||rec.grade||'" /> 
                  </td>
                  <td class="titletd">'||get_fn('권한명')||'</td>
                  <td class="inputtd">
                    <input type="text" id="p_descr" name="p_descr" '||v_disabled||' value="'||rec.descr||'" /> 
                  </td>
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
    p_grade in varchar2 default null,   
    p_chk owa_util.ident_arr,  
    p_pgmid owa_util.ident_arr,   
    p_pgm_level owa_util.ident_arr  
  )
  IS
  
  BEGIN
    
    for r in 1..p_pgmid.count loop   
      if p_chk(r)=0 then  
       
        begin   
          delete from c_0031   
          where       systemcd=p_systemcd   
          and       grade=p_grade   
          and       pgmid=p_pgmid(r);   
        end;   
        
      elsif p_chk(r)=1 then   
        begin   
        
          insert into c_0031
          ( systemcd, grade, pgmid, pgm_level )   
          values
          ( p_systemcd, p_grade, p_pgmid(r), p_pgm_level(r) );   
                      
        exception when dup_val_on_index then   
          update  c_0031   
          set     pgm_level=p_pgm_level(r)   
          where   systemcd=p_systemcd   
          and     grade=p_grade   
          and     pgmid=p_pgmid(r);   
        end;   
      end if;   
    end loop; 
  
      htp.p('
        <script type="text/javascript">
          alert("'||get_fn( '저장되었습니다.')||'");
          opener.location.reload();
          location.href = "'||v_pkg||'.crrec?p_systemcd='||p_systemcd||'&p_grade='||p_grade||'";
        </script>
        ');
    
  EXCEPTION
    when others then 
      show_err('process');
  END process;
 
END COMC0031;

/
