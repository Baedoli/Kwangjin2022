--------------------------------------------------------
--  DDL for Package Body COMC0043
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "PREMIER"."COMC0043" 
is
  procedure control
  is
   
  
  begin
   htp.p('
<!DOCTYPE HTML>
<html lang="ko">
  <head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta charset="UTF-8">
    <title>'||common.get_cookie('SYSTITLE')||'</title> ');
        dbv_grid.print_env_v652;
    htp.p('    
    <style>
    .dhx_layout-cell {
      overflow: auto;
    }
    
    .border_line_gray1{
      border: 1px solid #dfdfdf;
      margin: 1px 3px 3px 5px;
    }
    </style> 
    <body> 
         <script>
         var detailShow = true;
         
         $(function() {
              onLoad();
         });
         
          /* 화면 레이아웃 설정 */
          var layout_rows = {
              rows:[
                {cols:[{id:"a",width:"70%"},{id:"b",width:"330px",gravity:false}], css:"header-background-non-bottom", height:"50px", gravity:false},  
                {cols:[{ css:"grid-padding", id:"d",width:"40%", resizable:true, css:"border_line_gray1", gravity:false}, 
                       { css:"grid-padding", id:"e",width:"60%", resizable:true, css:"border_line_gray1", gravity:false} ] }
              ]
          };
           
          
          /* 검색 폼 설정 */
          var form_search_cols = [ 
            {id: "SYSROOT", name: "SYSROOT", type: "select", label: "'||get_fn('탭')||'", labelInline: true, labelWidth: "70px", width:"350px", gravity: false, options: '); common_dhx6.list_catalog('COM','SYSROOT_NM','N',v_syslang); htp.p(' },
          ]; 
          
          // 상단 좌측 form 객체  
          var form_search_header = new dhx.Form(null, {
            css: "form_search_header",gravity: false,align: "start",
            rows:[{align: "start", dir:"cols", css:"bold", cols: form_search_cols}]
          });
           
          
          /* 검색 버튼 폼 설정 */
          var form_button_header = new dhx.Form(null, {css: "form_search_header", gravity: false, align: "end",
            rows:[{  align: "end", dir:"cols", gravity:true,
                cols: [ 
                        {id:"search_btn", type: "button", value: "'||get_fn('조회')||'" , size: "small", view: "flat", css : "form_header_button_control dhx_search_btn", gravity: false}, 
                      ]
                   },]
          }); 
          
          
          //form 화면 레이아웃 설정
          var form_layout_rows = {
              rows: [
                   {height:"70px", gravity:false,cols:[{id:"a",css:""}]}, //상단  
                   {height:"5px",gravity:false}, //여백
                   {cols:[{id:"b",css:"popup-grid-margin"},]}, //등록 form 
                   {height:"20px",gravity:false}, //여백
                  ]
          };  
               
          //form 화면 버튼 폼 설정(저장)
          var form_header_form_config = {rows: [{
            align:"end",dir: "cols",padding: "2px", 
            cols: [ //{id: "save_btn", type: "button",value: "'||get_fn('저장')||'", size: "small",view: "flat",circle: false, gravity: false,   css: "dhx_save_btn popup-margin-top popup-margin-left"}, 
                    {id: "remove_btn",type: "button",value: "'||get_fn('삭제')||'" ,size: "small",view: "flat",circle: false, gravity: false, submit: true, css: "dhx_remove_btn popup-margin-top popup-margin-left"}
                  ]
            }]};
            
          //팝업 헤더 설정
          var form_header_rows = {
              css:"popup-header-padding",
              rows:[ 
                {cols:[{id:"header_title",css:"popup-header-bottom",width:"50%", gravity:false, html:"※'||get_fn('해당 메뉴 트리에서 즐겨찾기 추가 프로그램을 클릭하세요..')||'",}
                      ,{id:"header_form",css:"popup-header-bottom",width:"50%",gravity:false,} ]}
                ],  
            };
          
          
          // 등록 폼윈도우 설정 
          var form_attach_window_rows = [  
            //hidden값 설정
            //{hidden : true, id: "COMPANYCD", name:"COMPANYCD", type: "input"},
            
            {cols:[ {id: "P_ID", name: "P_ID", type: "select", label: "'||get_fn('ID')||'", labelInline: true, labelWidth: "130px", width:"300px",  options: ');comc0043.list_menu(''); htp.p(' },], gravity: false, height:"40px"},   
            {cols:[ {id: "P_UID", name: "P_UID", type: "select", label: "'||get_fn('UID')||'", labelInline: true, labelWidth: "130px", width:"300px",  options: ');comc0043.list_menu('M'); htp.p(' },], gravity: false, height:"40px"},   
            
            {cols:[ {id: "P_PGM_ORDER", name: "P_PGM_ORDER", type: "input", label: "'||get_fn('Sort No')||'", labelInline: true, labelWidth: "130px", width:"300px", },], gravity: false, height:"40px"}, 
            {cols:[ {id: "P_URL", name: "P_URL", type: "input", label: "'||get_fn('Url')||'", labelInline: true, labelWidth: "130px", width:"300px", },], gravity: false, height:"40px"},
            {cols:[ {id: "P_TARGET", name: "P_TARGET", type: "input", label: "'||get_fn('Target')||'", labelInline: true, labelWidth: "130px", width:"300px", },], gravity: false, height:"40px"}, 
            {cols:[ {id: "P_MODIFIED", name: "P_MODIFIED", type: "checkbox", label: "'||get_fn('Modified')||'", labelInline: true, labelWidth: "130px", width:"300px", }], gravity: false, height:"40px"},   
            {cols:[ {id: "P_USEYN", name: "P_USEYN", type: "checkbox", label: "'||get_fn('일반 출력여부')||'", labelInline: true, labelWidth: "130px", width:"300px", }], gravity: false, height:"40px"},   
            {cols:[ {id: "P_USEYN_SUPPLY", name: "P_USEYN_SUPPLY", type: "checkbox", label: "'||get_fn('업체 출력여부')||'", labelInline: true, labelWidth: "130px", width:"300px", }], gravity: false, height:"40px"},   
            {cols:[ {id: "P_PREMIER_VIEW", name: "P_PREMIER_VIEW", type: "checkbox", label: "'||get_fn('PREMIER only')||'", labelInline: true, labelWidth: "130px", width:"300px", }], gravity: false, height:"40px"},  
            {cols:[ {id: "P_EXPLN", type: "text", label: "'||get_fn('설명')||'", labelInline: true, labelWidth: "130px", width:"300px", value: "■전체출력 / ▲내부출력 / □출력안함(※premier only)" }], gravity: false, height:"40px"},   
          ]; 
               
          var form_regist = new dhx.Form(null, {rows:form_attach_window_rows, padding:0});
          
          
          /* 그리드 설정 */'); 
          htp.p('
           var grid_config = {selection:"row", css:"", htmlEnable: true ,
              columns: [  
                { width:150, id: "SYSTEMCD", 
                  header: [{ text: "'||get_fn('시스템')||'" , css: "dhx_grid_header_align_center bold" }], mark: function(){return "dhx_grid_header_align_center"}, type: "string", resizable:true, editable:true }, 
                { width:400, id: "MEMO", 
                  header: [{ text: "'||get_fn('프로그램')||'" , css: "dhx_grid_header_align_center bold" }], mark: function(){return "dhx_grid_header_align_center"}, type: "string", resizable:true, editable:true }, 
                { width:180, id: "SNO", 
                  header: [{ text: "'||get_fn('정렬순위')||'" , css: "dhx_grid_header_align_center bold" }], mark: function(){return "dhx_grid_header_align_center"}, type: "string", resizable:true, editable:true }, 
              ],
          };
             
          
          var grid = new dhx.Grid(null, grid_config);  
                
          var layout = new dhx.Layout("layout", layout_rows); 
          var form_layout = new dhx.Layout("flayout", form_layout_rows);
          
          const tree = new dhx.Tree("tree", {keyNavigation: true}); //keyNavigation :키보드 조정 가능
            
          /* 초기 레이아웃 및 함수 설정 */
          function onLoad(){
            layout.cell("a").attach(form_search_header); 
            layout.cell("b").attach(form_button_header);  
             
            layout.cell("d").attach(tree); 
              
            /*우측 from layout 설정 (S)*/
            var header_layout = new dhx.Layout(null, form_header_rows);
            var header_form = new dhx.Form(null, form_header_form_config); 
            header_layout.cell("header_form").attach(header_form);
                        
            form_layout.cell("a").attach(header_layout);
            form_layout.cell("b").attach(grid); 
            
            layout.cell("e").attach(form_layout); 
            /*우측 from layout 설정 (E)*/
                 
            //트리 데이터 셋팅
            setTreeData(); 
             
            //조회 버튼 이벤트
            form_button_header.events.on("ButtonClick",eventButtonClickListener);
             
            //fnDetailHidden(); //상세검색 default 닫기
              
            tree.events.on("ItemClick",eventTreeClick);
            grid.events.on("CellClick",eventGridClick);
             
            //클릭이벤트
            header_form.events.on("ButtonClick",eventButtonClick); 
            form_search_header.events.on("Change",eventChangeListener); //값 변경 event
            
            //상세조회
            fnSetData(); 
          } 
          
          var V_ROWKEY = "";
          var V_MEMO = "";
          //그리드 선택
          function eventGridClick(row,column,e){
            V_ROWKEY = row.ROWKEY; 
            V_MEMO = row.MEMO; 
          } 
          
          //트리그리드 선택
          function eventTreeClick(id, e){  
             console.log("id="+id);
             console.log("opened="+tree.data.getItem(id).opened);
               
             var menu = tree.data.getItem(id).opened;
             var tree_nm = tree.data.getItem(id).value;
               
             if(menu != true){
               if(confirm(tree_nm+"'||get_fn('를 추가하시겠습니까?')||'")) {
                send_req(id);
               }       
             }     
          }
          
          /* 데이터 셋팅 */
          function fnSetData(){  
             var url = "'||v_pkg||'.form_data";
             var sysroot = form_search_header.getItem("SYSROOT").getValue();
             console.log("sysroot: " + sysroot);
             var param = {"p_sysroot" : sysroot};
             fnCallAjax(url, param, fncbFormSet);   
          }
              
          function fncbFormSet(data){
                var dataSet = new Object(); //객체 변수로 초기화. 안해주면 json data reading 안됌....
                grid.data.parse(data); 
          }
          
          /* 값 변경 이벤트 */
          function eventChangeListener(id, new_value){
              if(id == "SYSROOT"){ 
                setTreeData();
              }
          }
          
          /* 버튼 클릭 이벤트 */
          function eventButtonClick(id,e){ 
            //저장 
            if(id == "save_btn"){    
                fnSave(); 
            } 
            else if(id == "remove_btn"){
                fndelRow();
            }
          } 
           
          function fndelRow(){
            var url = "'||v_pkg||'.delete_row";
            var param = {"p_rowid": V_ROWKEY}
            
            if(V_ROWKEY != ""){
                if(confirm(V_MEMO+" '||get_fn('를 삭제하시겠습니까?')||'")) { 
                  fnCallAjax(url, param, fnCallBackdel);
                }
            }else{
                alert("'||get_fn('삭제할 행을 선택하세요.')||'");
                return;
            } 
          }
          
          
           function fnCallBackdel(data){
            if(data.return_msg == "success"){
            
              V_ROWKEY = "";
              V_MEMO = "";
              fnSetData();
            }
            else{
              alert("'||get_fn('오류가 발생하였습니다. 관리자에게 문의 바랍니다.')||'");
              return;
            }
          }
           
          
          /* 트리 조회 */
          function setTreeData(){  
            var sysroot = form_search_header.getItem("SYSROOT").getValue(); 
              
            tree.data.removeAll();  
             
            var url = "'||v_pkg||'.query";
            var param = {"p_sysroot":sysroot};  
             
            fnCallAjax(url, param, fnCallBackTree);
          }
          
          /* 트리 데이터 조회 callback function */
          function fnCallBackTree(data){  
            tree.data.parse(data);
          }
          
          /* 저장 */
          function send_req(id){
            var url = "'||v_pkg||'.insert_row";
            var param = {"p_rowid":id}
             
            fnCallAjax(url, param, fnCallBackSave);
          }
          
          function fnCallBackSave(data){
            if(data.return_msg == "success"){
              fnSetData();
            }
            else{
              alert("'||get_fn('오류가 발생하였습니다. 관리자에게 문의 바랍니다.')||'");
              return;
            }
          }
          
          /* 버튼 클릭 이벤트 리스너 */
          function eventButtonClickListener(id,e){  
            //조회
            if(id == "search_btn"){  
                 setTreeData(); 
            }
          } 
           
          /* 트리 조회 */
          function setTreeData2(p_id, p_uid){  
             
            var sysroot = form_search_header.getItem("SYSROOT").getValue(); 
              
            tree.data.removeAll();  
             
            var url = "'||v_pkg||'.query"; 
            
            var param = {"p_id": p_id , "p_uid": p_uid, "p_sysroot" : sysroot}; 
            
            fnCallAjax(url, param, fnCallBackTree);
          } 
           
              
        </script>
      </body>
              
   </head>
   </html>
  ');
  exception
    when others then
      show_err;
  end control; 
  
  procedure form_data (
      p_sysroot in varchar2 default null
  )
  is
    cursor cur is   
         select  '{'||'"SYSTEMCD" : "'||SYSTEMCD||'",
                    "MEMO" : "'||MEMO||'", 
                    "SNO" : "'||SNO||'",  
                    "USEYN" : "'||USEYN||'", 
                    "ROWKEY" : "'||ROWKEY||'"}' 
                 as json_obj
        from(    
              SELECT A.*, ROWID AS ROWKEY
              FROM   C_0043 A
              WHERE A.COMPANYCD = '00' --고정 
              AND   A.GUBUN =COMMON.GET_COOKIE('SYSTYPE')
              AND   A.XUSER = COMMON.GET_COOKIE('SYSID')
              ORDER BY A.SNO
        )
        ;

   type r is table of cur%rowtype index by pls_integer;
   rec r;

  begin
  
    owa_util.mime_header('application/json');

    open cur;
    fetch cur bulk collect into rec; 
    close cur;
     
    if rec.count > 0 then
        htp.p('[');
                    for i in 1 .. rec.count loop
                      htp.p(rec(i).json_obj);
                      
                      if i < rec.count then
                      htp.p(',');
                      end if;
                      
                    end loop; 
        htp.p(']');
    else
        htp.p('[]');
    end if; 
    
    
  exception when others then
     show_err;
  end;  
     
  procedure query (
    p_sysroot in varchar2 default null, 
    p_id       in number default null,
    p_uid      in number default null
  )
  is    
    cursor cur is   
        select  rownum as rowNo, level as level_no, CONNECT_BY_ISLEAF AS LEAF,
                get_unode_cnt(p_sysroot,id_,v_syslang) as icnt, 
                (case when pgm_order = get_unode_last(p_sysroot,uid_,v_syslang) then 'Y' else '' end) as lnode,
                pgm_gb, 
                id_ id, nvl(uid_,-1) uid_,uid_ uid__, decode(nvl(uid_,-1), -1, 
                get_catalog_name('COM','SYSROOT_NM',v_syslang,nvl(p_sysroot,'996')), 
                get_program_name(systemcd,pgmid,v_syslang)) pnm, url, target, 
                systemcd, pgmid, pgm_order, useyn, useyn_supply, premier_view,rowKey
        from (
               select   a.pgm_gb, b.rowid as rowKey,b.id_, uid_, pgm_order, target, url, pgmid, a.systemcd, b.useyn, b.useyn_supply, b.premier_view
               from     c_0040 a, c_0042 b
               where    a.useyn='Y' 
               and      (b.useyn = 'Y'
                        or
                        decode(common.get_cookie('SYSID'),'premier',b.premier_view,'N') ='Y')
               and      a.id_ = b.id_
               and      b.pgm_order is not null
               and      ( (v_systype = '0' and a.id_ not in ('68','817')) or
                          (v_systype = '1' and 1=1)
                        )
        ) a
        start with id_=nvl(decode(p_sysroot,'996',decode(v_systype,'1','68',p_sysroot),p_sysroot),'996')
        connect by prior id_=uid_
        order siblings by pgm_order;
  
    type r02 is table of cur%rowtype index by pls_integer;
    rec r02;
    
    v_u_id varchar2(100);
    v_num number := 0;
    v_num2 number := 0;
    v_num3 number := 0; 
    v_viewyn varchar2(100);
    l_prev_level number := 0;
    l_prev_lnode varchar2(100);
    l_prev_pgmgb varchar2(100);
    l_prev_leaf  varchar2(100);
    
  begin
  
    owa_util.mime_header('application/json');

    open cur;
    fetch cur bulk collect into rec;
    close cur;
    
    if rec.count > 0 then
     
        for i in 1 .. rec.count loop 
          v_viewyn := '';
        
          if i = 1 then
                htp.p('[{');
                htp.p('"value" : "'||rec(i).pnm||'",');
                htp.p('"id" : "'||check_rowid(rec(i).rowKey,'1')||'",'); 
                htp.p('"opened" : true,');  
                htp.p('"items" : [');  
          else
            --menu
            if rec(i).leaf = '0' then 

                if l_prev_lnode = 'Y' then
                  for y in 1..(l_prev_level-rec(i).level_no) loop   
                    htp.p(']}'); 
                    v_num2 := v_num2 - 1;   
                  end loop;    
                  htp.p(',');
                end if;
                
                if l_prev_level = rec(i).level_no and rec(i).icnt = 0 then
                    htp.p('{');
                    htp.p('"value" : "'||rec(i).pnm||'",'); 
                    htp.p('"id" : "'||check_rowid(rec(i).rowKey,'1')||'",');  
                    htp.p('},');  
                else
                    htp.p('{');
                    htp.p('"value" : "'||rec(i).pnm||'",'); 
                    htp.p('"id" : "'||check_rowid(rec(i).rowKey,'1')||'",'); 
                    htp.p('"opened" : true,');  
                    htp.p('"items" : ['); -- a.menu open 
                    v_num2 := v_num2 + 1;
                end if;

            else 
 
              if (nvl(rec(i).lnode,'N') = 'Y' and l_prev_lnode = 'Y') or (l_prev_level > rec(i).level_no and l_prev_lnode = 'Y') then
                 htp.p(']}'); 
                 htp.p(','); 
                 v_num2 := v_num2 - 1;   
              end if;
              
              if rec(i).pgm_gb = 'M' and rec(i).icnt = 0 and l_prev_level = rec(i).level_no then
              htp.p(',');
              end if;
              
              htp.p('{'); 
              htp.p('"value" : "'||rec(i).pnm||'",');
              htp.p('"id" : "'||check_rowid(rec(i).rowKey,'1')||'"');
              htp.p('}'); 
               
              -- 이전 node가 menu 이고 현재 node가 마지막 노드가 아닌경우
              -- 이전 node가 program이고 현재 node가 마지막 노드가 아닌경우 이전 node도 program인 경우 
--              if (l_prev_pgmgb = 'M' and nvl(rec(i).lnode,'N') != 'Y') or (l_prev_pgmgb != 'M' and nvl(rec(i).lnode,'N') != 'Y' and (l_prev_level = rec(i).level_no)) then
              if (l_prev_leaf = '0' and nvl(rec(i).lnode,'N') != 'Y') or (l_prev_leaf != '0' and nvl(rec(i).lnode,'N') != 'Y' and (l_prev_level = rec(i).level_no)) or (l_prev_lnode = 'Y' and nvl(rec(i).lnode,'N') != 'Y') then
                htp.p(',');
              end if;
             
                
            end if;
          end if;
          
          l_prev_level := rec(i).level_no;
          l_prev_lnode := nvl(rec(i).lnode,'N');
          l_prev_pgmgb := rec(i).pgm_gb;
          l_prev_leaf := rec(i).leaf;
          
        end loop;
         
        for y in 1..v_num2 loop   
            htp.p(']');  
            htp.p('}');  
        end loop; 
         
        htp.p(']');
        htp.p('}]');
             
    else
        htp.p('[]');
    end if; 
   
  end;  
  
  procedure list_menu (
    p_obj in varchar2 default null
  )
  is
   v_data varchar2(32767) := ' ';
   v_data2 varchar2(32767) := ' ';
   v_data3 varchar2(32767) := ' ';
   v_data4 varchar2(32767) := ' ';

cursor fnd_cur is         
    select a.*, (select count(useyn) from c_0042 where ID_ = a.id_) cnt
    from c_0040 a    
    where pgm_gb=nvl(p_obj,pgm_gb) 
    order by pgmid
    ;
    
    
    type r01 is table of fnd_cur%rowtype index by pls_integer;
    rec r01;

begin 

    open fnd_cur;
    fetch fnd_cur bulk collect into rec;
    close fnd_cur;
 
    htp.p('[');
    for i in 1 .. rec.count loop
       
        htp.p('{"value" : "'||rec(i).id_||'", "content" : "'||'['||rec(i).pgm_gb||']'||rec(i).pgmid||' '||rec(i).descr||'('||rec(i).cnt||')'||'"}'); 
        
          if i < rec.count then
          htp.p(',');
          end if;
                  
    end loop;  
    htp.p(']');
  
--    htp.p(' ['||v_data||'] ');
    
  end list_menu;
  
   procedure insert_row 
  ( p_rowid in varchar2 default null )
  is
  cursor cur is
  select *
  from   c_0042
  where  rowid = check_rowid(p_rowid,'2');
  
  cursor cur1 ( p_key in number ) is
  select *
  from   c_0040
  where  id_ = p_key;
  
  rec    c_0042%rowtype;
  rec1   c_0040%rowtype;
  
  cursor fnd_max is
  select nvl(max(sno)+10,10)
  from   c_0043
  where  companycd = '00'
  and    gubun = common.get_cookie('SYSTYPE')
  and    xuser = common.get_cookie('SYSID');
  
  v_max_sno number := 10;
  v_row     number := 0;
  begin
  
    open cur;
    fetch cur into rec;
    close cur;
    
    open fnd_max;
    fetch fnd_max into v_max_sno;
    close fnd_max;
    
    open  cur1(rec.id_);
    fetch cur1 into rec1;
    close cur1;
    
    owa_util.mime_header('application/json');
    
    begin
      insert into c_0043
      ( companycd, gubun, xuser, systemcd, pgmid, memo, sno, useyn,
        url, target, id_ )
      values
      /* 사업장은 고정 */
      ('00', common.get_cookie('SYSTYPE'), common.get_cookie('SYSID'),
        rec1.systemcd, rec1.pgmid, rec1.descr, v_max_sno, 'Y',
        rec.url, rec.target, rec1.id_ );
        v_row := sql%rowcount;
        
        htp.p('{"return_msg": "success"}'); 
    exception when others then 
        htp.p('{"return_msg": "fail"}');
    end; 
  
  end;
  
  procedure delete_row 
  ( p_rowid in varchar2 default null )
  is
  v_row     number := 0;
  begin
  
    owa_util.mime_header('application/json');
    begin
      delete from c_0043
      where  rowid = p_rowid;

      
      htp.p('{"return_msg": "success"}'); 
        
      v_row := sql%rowcount;
    exception when others then 
    
      htp.p('{"return_msg": "fail"}');
    end;
     
--htp.p('<input type=''hidden'' id=''p_row_chk'' name=''p_row_chk'' value='''||v_row||'''>');
  
  end;
  
  procedure list_menu2 (
    p_obj in varchar2 default null
  )
  is
   v_data varchar2(32767) := ' ';
   v_data2 varchar2(32767) := ' ';
   v_data3 varchar2(32767) := ' ';
   v_data4 varchar2(32767) := ' ';

cursor fnd_cur is  
--    SELECT  '{'||'"value" : "'||id_||'", "content" : "'||'['||pgm_gb||']'||pgmid||' '||descr||'('||cnt||')'||'"}' as json_obj 
--    from(
--            select a.*, (select count(useyn) from c_0042 where ID_ = a.id_) cnt
--            from c_0040 a    
--            where pgm_gb=nvl(p_obj,pgm_gb)
--    ) a 
--    order by pgmid
--    ;
    
     
    select a.*, (select count(useyn) from c_0042 where ID_ = a.id_) cnt
    from c_0040 a    
    where pgm_gb=nvl(p_obj,pgm_gb) 
    order by pgmid
    ;
    
    
    type r01 is table of fnd_cur%rowtype index by pls_integer;
    rec r01;

begin 
    open fnd_cur;
    fetch fnd_cur bulk collect into rec;
    close fnd_cur;
      
--    if p_type = 'A' then -- 전체
--      v_data := '{'||'"value" : "", "content" : "'||get_fn('전체')||'"},';
--    elsif p_type = 'S' then -- 선택
--      v_data := '{'||'"value" : "", "content" : "'||get_fn('선택하세요.')||'"},';
--    end if;
 
    htp.p('[');
    for i in 1 .. rec.count loop
       
        htp.p('{"value" : "'||rec(i).id_||'", "content" : "'||'['||rec(i).pgm_gb||']'||rec(i).pgmid||' '||rec(i).descr||'('||rec(i).cnt||')'||'"}'); 
        
          if i < rec.count then
          htp.p(',');
          end if;
                  
    end loop;  
    htp.p(']');
  
--    htp.p(' ['||v_data||'] ');
    
  end list_menu2;
  
end comc0043;

/
