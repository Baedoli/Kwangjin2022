--------------------------------------------------------
--  DDL for Package Body COMC0010_221122
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "PREMIER"."COMC0010_221122" 
IS
  PROCEDURE control
  (
    p_companycd in varchar2 default common.get_cookie('SYSCOMP'),
    p_systemcd in varchar2 default null,
    p_gubun in varchar2 default null,
    p_useyn in varchar2 default null,
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
        var url = "'||v_pkg||'.crrec?p_companycd='||p_companycd||'";  
        newWnd2 = window.open(url,"'||v_pkg||'window","top=100, left=100, status=yes, resizable=no, scrollbars=yes, width=1000, height=250");  
        newWnd2.focus();
      } 
      
      function doCrrec2() {  
        thisForm = document.forms[0];   
        var url ="'||v_pkg||'.crrec2?p_companycd="+thisForm.p_companycd.value+"&p_gubun="+thisForm.p_gubun.value+"&p_teamcd="+thisForm.p_teamcd.value+"&p_systemcd="+thisForm.p_systemcd.value;  

        newWnd2 = window.open(url,"'||v_pkg||'window2","top=100, left=100, status=yes, resizable=no, scrollbars=yes, width=1475, height=650");  
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
          <div class="cTitle"><label for="p_systemcd">'||get_fn('시스템')||'</label></div>
          <div class="cInput">
            <select name="p_systemcd" id="p_systemcd"">
            '); common.list_systemcd(p_systemcd, 'z'); htp.p('
            </select>
          </div>
        </div>  
        <div class="cBox">
          <div class="cTitle"><label for="p_teamcd">'||get_fn('부서')||'</label></div>
          <div class="cInput">
            <select name="p_teamcd" id="p_teamcd"">
            '); common.list_systemcd(p_systemcd, 'a'); htp.p('
            </select>
          </div>
        </div> 
      </div>
      
      <div id="c01">
      
        <div class="cBox">
          <div class="cTitle"><label for="p_gubun">'||get_fn('구분')||'</label></div>
          <div class="cInput">
          '); common.list_catalog('COM','INOUT_GBN',p_gubun,'select', null, 'p_gubun', 'z', 'yes'); htp.p('
          </div>
        </div>  
        <div class="cBox">
          <div class="cTitle"><label for="p_useyn">'||get_fn('사용여부')||'</label></div>
          <div class="cInput">
            '); common.list_catalog('COM','USEYN',p_useyn,'select', null, 'p_useyn', 'a', 'yes'); htp.p('
          </div>
        </div>  
        <div class="cBox">
          <div class="cTitle"><label for="p_xusernm">'||get_fn('사용자명')||'</label></div>
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
        <a href="#" target="list" onclick="doCrrec2(); return false;" class="btn-new buttons">'||get_fn('권한등록')||'</a>
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
    p_systemcd in varchar2 default null,
    p_gubun in varchar2 default null,
    p_useyn in varchar2 default null,
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
            
            x[i]=["'||get_fn('사용자ID')||'", "130","center","link","str","true"];i++;
            x[i]=["'||get_fn('이름')||'", "150","center","ro","str","true"];i++;
            x[i]=["'||get_fn('부서')||'", "100","center","ro","str","true"];i++;
            x[i]=["'||get_fn('사용여부')||'", "100","center","ro","str","true"];i++;

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
          
          function link_(obj1, obj2, obj3){
            url ="'||v_pkg||'.crrec?p_companycd="+obj1+"&p_gubun="+obj2+"&p_xuser="+obj3;
            newWnd2 = window.open(url,"'||v_pkg||'window","top=100, left=100, status=yes, resizable=no, scrollbars=yes, width=1000, height=250");  
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
    p_systemcd in varchar2 default null,
    p_gubun in varchar2 default null,
    p_useyn in varchar2 default null,
    p_teamcd in varchar2 default null,   
    p_xusernm in varchar2 default null
  )
  IS
  
    cursor cur is   
      select *   
      from (  select  *   
              from    c_0010   
              where   nvl(companycd, '*') = nvl(p_companycd, nvl(companycd, '*'))
              and     nvl(gubun, '*') = nvl(p_gubun, nvl(gubun, '*'))
              --and     nvl(teamcd, '*') = nvl(p_teamcd, nvl(teamcd, '*'))
              and     nvl(useyn, '*') = nvl(p_useyn, nvl(useyn, '*'))
              and     upper(xusernm) like '%'||upper(p_xusernm)||'%'   
              and     p_gubun='0'   
              union all   
              select  *   
              from    c_0010   
              where   nvl(companycd, '*') = nvl(p_companycd, nvl(companycd, '*'))
              and     nvl(gubun, '*') = nvl(p_gubun, nvl(gubun, '*'))
              and     nvl(useyn, '*') = nvl(p_useyn, nvl(useyn, '*'))
              and     upper(xusernm) like '%'||upper(p_xusernm)||'%'   
              and     p_gubun='1')   
      order by xusernm;   
    type r is table of cur%rowtype index by pls_integer;
    rec r;
    
    v_number number := 0 ;
    v_link varchar2(4096) := null;
    v_teamcd  varchar2(100);   

  BEGIN
  
    owa_util.mime_header('application/json');

    open cur;
    fetch cur bulk collect into rec;
    close cur;
    
    htp.p('{rows:[ ');
    v_number := rec.count;
    for i in 1 .. v_number loop
      v_link := '^javascript:link_(\"'||rec(i).companycd||'\", \"'||rec(i).gubun||'\", \"'||rec(i).xuser||'\")^_self';
      
      if rec(i).teamcd = 'NC000' then   
      v_teamcd := '01';   
      else   
      v_teamcd := rec(i).teamcd;   
      end if; 
    
      htp.p('
      { id:' ||i|| ',
        data:[
          {value:"'||rec(i).xuser||v_link||'"},
          {value:"'||rec(i).xusernm||'"},
          {value:"'||GET_TEAM_NAME(rec(i).companycd, v_teamcd)||'"},
          //{value:"'||v_teamcd||'"},
          {value:"'||get_catalog_name('COM', 'USEYN', common.get_cookie('SYSLANG'), rec(i).useyn)||'"}
        ]
      } ');
      
      if i < v_number then
        htp.p(',');
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
    p_gubun in varchar2 default null,   
    p_xuser in varchar2 default null,   
    p_f  in varchar2 default null   
  )
  IS
  
    cursor cur is   
      select  *   
      from    c_0010   
      where   companycd = p_companycd   
      and     gubun = p_gubun   
      and     xuser = p_xuser; 
      
    rec cur %rowtype;
    
    v_disabled varchar2(20);
    v_test varchar2(20);
    
  BEGIN  
        
    open cur;   
    fetch cur into rec;   
    close cur;
    
    if rec.companycd is not null then
      v_disabled := 'disabled="disabled"';
    else
      v_disabled := '';
    end if;
    
    if rec.companycd is not null then
      v_test := 'disabled'; 
    else 
      v_test := 'yes'; 
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
          $("#p_companycd").removeAttr("disabled");
          $("#p_xuser").removeAttr("disabled");
          $("#p_gubun").removeAttr("disabled");
          thisForm.p_dml_gubun.value = "1";
          thisForm.submit(); 
          
        }    

        function proc_reset() {
          var thisForm = document.getElementById("form1");
          
          //필수값 체크
          if(!formRquried()){
            return false;  
          }     
                  
          if (!confirm("'||get_fn('초기화하시겠습니까?')||'")) return false;
          $("#p_companycd").removeAttr("disabled");
          $("#p_xuser").removeAttr("disabled");
          $("#p_gubun").removeAttr("disabled");
          thisForm.p_dml_gubun.value = "2";
          thisForm.submit(); 
          
        }    
        
      </script>      
    </head>    
    <body>                
      <form id="form1" name="form1" action="'||v_pkg||'.process" method="post" >
      <input type="hidden" id="p_dml_gubun" name="p_dml_gubun" value="" />
      <input type="hidden" id="p_email" name="p_email" value="'||rec.email||'" />   
      <input type="hidden" id="p_mobile" name="p_mobile" value="'||rec.mobile||'" />   
      <input type="hidden" id="p_jikup" name="p_jikup" value="'||rec.jikup||'" />   
      <input type="hidden" id="p_teamcd" name="p_teamcd" value="'||rec.teamcd||'" />   
      
        <!-- 신규 Form Setting S -->
        <div class="formWrap">
        
          <!--상단타이틀/버튼-->
          <div class="formTop">
            <div class="formTitle">'||get_program_name('SYS',v_pkg,v_lang)||'</div>
            <div class="btnbar">
              <a href="#" class="btn-save buttons" onclick="proc_save(); return false;">'||get_fn('저장')||'</a>&nbsp;
              ');   
              if p_gubun is not null then
              htp.p(' 
                <a href="#" class="btn-save buttons" onclick="proc_reset(); return false;">'||get_fn('비밀번호초기화')||'</a>&nbsp;
              ');   
              end if;
              htp.p('
              <a href="#" class="btn-close buttons" onclick="self.close(); return false;">'||get_fn('닫기')||'</a>
            </div>
          </div>
          
          <!--테이블입력-->
          <div>
            <table width="100%" border="0" cellspacing="0" cellpadding="4">
              <tbody>
              
                <tr>
                  <td class="titletd require">'||get_fn('사업장')||'</td>
                  <td class="inputtd">
                  <select name="p_companycd" id="p_companycd" '||v_disabled||'>
                    '); common.list_company(rec.companycd, v_lang); htp.p('
                  </select>
                  </td>
                  <td class="titletd require">'||get_fn('부서')||'</td>
                  <td class="inputtd">
                  
                  ');   
                  if p_gubun = '0' then   
                  htp.p(' 
                    <input type="text" id="p_teamnm" name="p_teamnm" value="'||get_master_name('XM605', rec.teamcd, '0', common.get_cookie('SYSLANG'),rec.companycd)||'">   
                  ');   
                  else   
                  htp.p(' 
                    <td colspan="3"></td>   
                  ');   
                  end if;   
                  htp.p('  
                  </td>
                </tr>
               
                <tr>
                  <td class="titletd require">'||get_fn('이름')||'</td>
                  <td class="inputtd">
                    <input type="text" id="p_xusernm" name="p_xusernm" value="'||rec.xusernm||'">   
                  </td>
                  </td>
                  <td class="titletd require">'||get_fn('사용자ID')||'</td>
                  <td class="inputtd">
                    <input type="text" id="p_xuser" name="p_xuser" '||v_disabled||' value="'||rec.xuser||'">   
                  </td>
                </tr>
                
                <tr>
                  <td class="titletd require">'||get_fn('구분')||'</td>
                  <td class="inputtd" >
                    '); common.list_catalog('COM','INOUT_GBN',rec.gubun,'select', null, 'p_gubun', 'c', v_test); htp.p('
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
    '); 
  EXCEPTION
    when others then
      show_err('crrec');
  END crrec;
  
PROCEDURE crrec2
  (
    p_companycd in varchar2 default null,
    p_systemcd in varchar2 default null,
    p_gubun in varchar2 default null,
    p_teamcd in varchar2 default null   
  )
  IS
  
    cursor cur_grade is  
      select  *
      from( select  a.*, rownum rn  
            from    c_0030 a  
            where   useyn= 'Y'  
            and     systemcd = nvl(p_systemcd, systemcd)) 
      where rn<= 15
      order by  grade;  
            
    v_check varchar2(20);   
    v_teamcd  varchar2(100);   

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

      data={ rows:[ ');  
          
        declare  
          cursor f1 is  
            select  a.*, b.teamnm  
            from    c_0010 a, xm605 b  
            where   a.TEAMCD = b.teamcd 
            and     a.companycd = b.companycd
            and     nvl(a.companycd, '*') = nvl(p_companycd, nvl(a.companycd, '*'))
            --and     nvl(a.teamcd, '*') = nvl(p_teamcd, nvl(a.teamcd, '*'))
            and     nvl(a.gubun, '*') = nvl(p_gubun, nvl(a.gubun, '*'))
            and     a.useyn = 'Y'
            and     b.useyn = 'Y'
            order by  b.teamnm, a.xusernm, a.xuser;      
              
            v_yn    varchar2(1);  
            v_val   varchar2(50);  
            
        begin  
          v_number := 0;  
          for r in f1 loop  
            if v_number > 0 then  
              htp.p(',');  
            end if;  
            v_number := v_number + 1;  
            v_val :='';  
            htp.p('  
              { id:'||v_number||',  
                data:[  
                "'||r.teamnm||'",  
                "'||r.xusernm||'",  
                "'||r.xuser||'"   
                ');  
            for r1 in cur_grade loop  
              htp.p(',');  
              v_yn := '0';  
              begin  
                select  '1'  
                into    v_yn  
                from    c_0020  
                where   companycd = r.companycd  
                and     xuser = r.xuser  
                and     gubun = r.gubun  
                and     systemcd = r1.systemcd  
                and     grade = r1.grade;  
              exception when others then  
                v_yn := '0';  
              end;  
              htp.p('  
                "'||v_yn||'"  
              ');  
              v_val := v_val||v_yn;  
            end loop;  
            htp.p('  
            ,"'||v_val||'",  
             "'||r.companycd||'",  
             "'||r.gubun||'"
                ]    
            }  
            ');                  
          end loop;  
        end;  
        if v_number = 0 then   
          v_check := null;   
          htp.p('{ id:0, data:[""] } ');   
        end if;    
         
      htp.p('           
      ] }   
   
      var mygrid;   
      function doInitGrid2(){   
        mygrid = new dhtmlXGridObject(''mygrid_container'');
        mygrid.setImagePath("/grid451/skins/web/imgs/dhxgrid_web/");
        var v_header="";  
        var v_width="";  
        var v_align="";  
        var v_types="";  
        var v_sorting="";  
        var v_tooltip="";  
        var v_attheader="";  
        var i = 0;  
        var x = new Array(100);  
          
        x[i]=["팀","80","center","ro","str","false",""];i=i+1;  
        x[i]=["이름","80","center","ro","str","false",""];i=i+1;  
        x[i]=["id","80","center","ro","str","false",""];i=i+1;  
        
        ');  
          declare  
          begin  
            for rec in cur_grade loop  
              htp.p('                      
                x[i]=["'||rec.grade||'","90","center","ra_str","na","false","#master_checkbox"];i=i+1;   
              ');  
            end loop;  
          end;  
        htp.p('    
              
        x[i]=["","0","center","ro","na","false",""];i=i+1;   
        x[i]=["","0","center","ro","na","false",""];i=i+1;   
        x[i]=["","0","center","ro","na","false",""];i=i+1;   
          
        for(j=0;j<i;j++){      
          if(j==0) cm="";  
          else cm=",";        
          v_header=v_header+cm+x[j][0];  
          v_width=v_width+cm+x[j][1];  
          v_align=v_align+cm+x[j][2];  
          v_types=v_types+cm+x[j][3];  
          v_sorting=v_sorting+cm+x[j][4];  
          v_tooltip=v_tooltip+cm+x[j][5];  
          v_attheader=v_attheader+cm+x[j][6];  
        }      
          
        mygrid.setHeader(v_header);  
        mygrid.attachHeader(v_attheader);  
        mygrid.setInitWidths(v_width);  
        mygrid.setColAlign(v_align);  
        mygrid.setColTypes(v_types);      
        mygrid.enableTooltips(v_tooltip);  
        mygrid.setColSorting(v_sorting)// 셀소팅         
        mygrid.enablePaging(true, 20, 5, "pagingArea", true, "recinfoArea");              //페이징 
        mygrid.init();   
        mygrid.setSkin("dhx_web");
        mygrid.setPagingSkin("bricks");    
        mygrid.parse(data,"json");   
        mygrid.splitAt(3);   
      } 
            
      function proc_save() {
        var i,j,cnt=0;   
        var val = "";  
        var row=mygrid.getRowsNum();   
        var col=mygrid.getColumnsNum();  
        var thisForm = document.getElementById("fm");  
        for(i=1;i<=row;i++){     
          var val = "";  
          for(j=3;j<col-3;j++)  {  
            val = val+mygrid.cells(i,j).getValue();  
          }   
                 
          if(mygrid.cells(i,j).getValue()!=val){   
            cnt=cnt+1;   
            $("#fm").append("<input type=''hidden'' name=''p_xuser'' value=''"+mygrid.cells(i,2).getValue()+"''>");   
            $("#fm").append("<input type=''hidden'' name=''p_value'' value=''"+val+"''>");   
            $("#fm").append("<input type=''hidden'' name=''p_companycd'' value=''"+mygrid.cells(i,j+1).getValue()+"''>");   
            $("#fm").append("<input type=''hidden'' name=''p_gubun'' value=''"+mygrid.cells(i,j+2).getValue()+"''>");   
          }   
        }   
        
        if(cnt==0){   
          alert("변경된 내역이 없습니다.");   
          return false;  
        } else{   
          if(confirm("저장하시겠습니까?")){  
          
            ');  
            for rec in cur_grade loop  
              htp.p('  
                $("#fm").append("<input type=''hidden'' name=''p_grade'' value='''||rec.grade||'''>");   
              ');  
            end loop;  
            htp.p('  
            
            thisForm.p_dml_gubun.value="1";   
            thisForm.submit();  
          }   
        }  
      }  
    
      </script>      
    </head> 
    
    <body onload="doInitGrid2();">  
      <div>   
        <table width="100%">  
          <tr>  
            <td class="btnbar">  
              <a href="#" class="btn-save buttons" onclick="proc_save(); return false;">'||get_fn('저장')||'</a>&nbsp;
            </td>  
          </tr>  
        </table>  
      </div>          
      <div id="recinfoArea"></div>    
      <div id="mygrid_container" style="width:100%;height:80%;"></div>  
      <div id="pagingArea"></div>    
      <form id="fm" name="fm"  method="get" action="'||v_pkg||'.process_crrec2">  
        <input type="hidden" id="p_dml_gubun" name="p_dml_gubun" value="" />  
        <input type="hidden" id="p_teamcd" name="p_teamcd" value="'||p_teamcd||'" />  
        <input type="hidden" id="p_gubun" name="p_gubun" value="'||p_gubun||'" />  
        <input type="hidden" id="p_systemcd" name="p_systemcd" value="'||p_systemcd||'" />  
      </form>  
    </body>  
 
    </html>    
    '); 
  EXCEPTION
    when others then
      show_err('crrec');
  END crrec2;

  PROCEDURE process
  (
    p_companycd in varchar2 default null,
    p_teamnm in varchar2 default null,
    p_xusernm in varchar2 default null,
    p_xuser in varchar2 default null,
    p_gubun in varchar2 default null,
    p_useyn in varchar2 default null,
    p_dml_gubun in varchar2 default null,
    p_pass in varchar2 default null,
    p_mobile in varchar2 default null,
    p_jikup in varchar2 default null,
    p_email in varchar2 default null,
    p_teamcd in varchar2 default null    
  )
  IS
  
  BEGIN
    
    if p_dml_gubun = '1' then
      
      begin   
        insert into c_0010 (companycd, gubun, xuser, pass, xusernm, useyn, email, mobile, jikup, teamcd, pymd)   
                    values (p_companycd, p_gubun, p_xuser, p_pass, p_xusernm, p_useyn, p_email, p_mobile, p_jikup, p_teamcd, sysdate); 
                    
        insert into h_0100 (companycd, xuser, jikup_type)   
                    values (p_companycd, p_xuser, p_jikup); 
        exception    
          when dup_val_on_index then   
            begin   
              update  c_0010   
              set     xusernm = p_xusernm,   
                      useyn = p_useyn,   
                      email = p_email,   
                      mobile = p_mobile,   
                      teamcd = p_teamcd,   
                      jikup = p_jikup,  
                      PYMD = sysdate  
              where   companycd = p_companycd   
              and     gubun = p_gubun   
              and     xuser= p_xuser;                 
            exception    
              WHEN others THEN   
                null;    
            end;   
        WHEN others THEN   
          null; 
      end;                          
 
      begin   
        insert into master_language ( tableid, companycd, code, gubun, lang, name, logincomp, loginid, loginymd )
                            values  ('C_0010', p_companycd, p_xuser, p_gubun, common.get_cookie('SYSLANG'), p_xusernm, common.get_cookie('SYSCOMP'),common.get_cookie('SYSID'), sysdate);   
      exception   
        when dup_val_on_index then   
          update  master_language   
          set     name = p_xusernm   
          where   companycd = p_companycd   
          and     tableid = 'C_0010'   
          and     code= p_xuser;   
          when others then   
            null;   
      end;
    
    
      htp.p('
      <script type="text/javascript">
        alert("'||get_fn( '저장되었습니다.')||'");
        opener.location.reload();
        location.href = "'||v_pkg||'.crrec?p_companycd='||p_companycd||'&p_gubun='||p_gubun||'&p_xuser='||p_xuser||'";
      </script>
      ');
    
    elsif p_dml_gubun = '2' then
    
      begin
        update  c_0010   
        set     pass = 'ekp000',
                pymd = sysdate
        where   companycd = p_companycd   
        and     gubun = p_gubun   
        and     xuser= p_xuser;
        
        update  c_0011_new   
        set     pass = 'ekp000',
                pymd = sysdate,
                useyn = 'Y',
                pass_failure = 0
        where   companycd = p_companycd   
        and     gubun = p_gubun   
        and     xuser= p_xuser;
     exception    
        WHEN others THEN   
          null;   
     end;       
    
      htp.p(' 
      <script type="text/javascript"> 
        alert("' ||get_fn( '초기화되었습니다.')|| '"); 
        opener.location.reload();
        location.href = "'||v_pkg||'.crrec?p_companycd='||p_companycd||'&p_gubun='||p_gubun||'&p_xuser='||p_xuser||'";
      </script> 
      ');
        
    end if;
  
  
  EXCEPTION
    when others then 
      show_err('process');
  END process;
 
PROCEDURE process_crrec2
  (
    p_companycd in owa_util.ident_arr,   
    p_gubun     in owa_util.ident_arr,   
    p_xuser     in owa_util.ident_arr,   
    p_grade     in owa_util.ident_arr,  
    p_value     in owa_util.ident_arr, 
    p_teamcd    in varchar2 default null, 
    p_dml_gubun in varchar2 default null,
    p_systemcd  in varchar2 default null
  )
  IS
  
  BEGIN
     
    for i in 1 .. p_xuser.count loop
      
      BEGIN   
        DELETE FROM c_0020   
        WHERE       companycd = p_companycd(i)   
        AND         gubun = p_gubun(i)   
        AND         xuser = p_xuser(i)  
        AND         systemcd = p_systemcd;  
      END;   
      
      for j in 1 .. p_grade.count loop  
        if substr(p_value(i), j,1) = 1 then  
          BEGIN   
            INSERT INTO c_0020    
            ( companycd, gubun, xuser, systemcd, grade, useyn )   
            VALUES   
            ( p_companycd(i), p_gubun(i), p_xuser(i), p_systemcd, p_grade(j), 'Y' );   
            exception  
              when others then  
              show_err;  
          END;   
        end if;  
      end loop;  
      
    end loop;  
  
    htp.p('<script>alert("저장되었습니다.");   
      document.location.href = "'||v_pkg||'.crrec2?p_companycd='||p_companycd(1)||'&p_gubun='||p_gubun(1)||'&p_teamcd='||p_teamcd||'&p_systemcd='||p_systemcd||'";   
    </script>');  

  EXCEPTION
    when others then 
      show_err('process_crrec2');
  END process_crrec2;
  
END COMC0010_221122;

/
