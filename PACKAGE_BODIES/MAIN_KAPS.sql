--------------------------------------------------------
--  DDL for Package Body MAIN_KAPS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "PREMIER"."MAIN_KAPS" 
IS
  PROCEDURE control  
  ( 
    p_sysroot in varchar2 default '35',
    p_companycd in varchar2 default common.get_cookie('SYSCOMP')
  )
  IS
    cursor cur_lang is
      select listagg('{id: "'||listvalue||'",value: "'||listdescr||'"}',',') within group (order by listorder) as json
      from c_0051
      where systemcd = 'COM'
      and   catalogcd = 'LANGUAGE'
      and   lang = 'KO'
      and   useyn = 'Y'
      ;
      
    v_lang_josn varchar2(1000);
    
    cursor cur_approval is
      select  count(*)
      from (  select  a.*
              from    wf_doc_roles a
              where   not exists ( select 1 from v_complet_doc where doc_id = a.doc_id )
              and     a.com_id = v_syscomp
              and     a.emp_id = v_sysid
              and     'Y' = check_approval_new(a.doc_id, a.prior_id)
              and     'COMPLETE' != a.status
              and     1 != a.prior_id
              union all
              select  a.*
              from    wf_doc_roles a
              where   exists ( select 1 from v_complet_doc where doc_id = a.doc_id )
              and     a.com_id = v_syscomp
              and     a.emp_id = v_sysid
              and     a.type_id = '1'
              and     a.status = 'ACTIVE'       
              and     'COMPLETE' != a.status
              and     1 != a.prior_id
              union all
              select  a.*
              from    wf_doc_roles a
              where   not exists ( select 1 from v_complet_doc where doc_id = a.doc_id )
              and     a.com_id = v_syscomp
              and     a.emp_id = v_sysid
              and     'COMPLETE' != a.status
              and     a.prior_id = ( select min(prior_id) from wf_doc_roles where doc_id = a.doc_id ) ) a, wf_docs b
      where   a.doc_id = b.doc_id
      and     b.status in ( 'SAVED', 'ING', 'FINISH' )
      ;
      
    v_approval_cnt number;
    v_notice_cnt number := 0;
    v_color_focus varchar2(20) := '#EF3E44';
  BEGIN
  
    open cur_lang;
    fetch cur_lang into v_lang_josn;
    if cur_lang%notfound then v_lang_josn := ''; end if;
    close cur_lang;
    
    open cur_approval;
    fetch cur_approval into v_approval_cnt;
    if cur_approval%notfound then v_approval_cnt := 0; end if;
    close cur_approval;
  
  htp.p('<!DOCTYPE html>
  <html>
    <head>
      <meta name="robots" content="noindex, nofollow">    
      <meta charset="utf-8">
      <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
      <title>'||common.title||'</title>
      <link rel="icon" type="image/png" href="/resources/images/favicon.ico"> 
      <link rel="STYLESHEET" type="text/css" href="/grid652/codebase/suite.css"> 
      <link rel="STYLESHEET" type="text/css" href="/resources/css/font.css"> 
      <link rel="STYLESHEET" type="text/css" href="/resources/css/fadeInUp.css"> 
      <link rel="STYLESHEET" type="text/css" href="/resources/css/layout_type1.css"> 
      <link rel="STYLESHEET" type="text/css" href="/include/fontawesome/css/all.min.css"> 
      <link rel="STYLESHEET" type="text/css" href="/include/materialicon/css/materialdesignicons.min.css"> 
      <script src="/grid652/codebase/suite.js"></script> 
      <script type="text/javascript" src="/include/jquery/jquery-1.11.1.min.js"></script> 
      <script type="text/javascript" src="/include/jquery/jquery.loading.min.js"></script> 
      <script src="/js/common/premier_util.js"></script>
      
      <style>
        .main_content .dhx_layout-cell-content{padding: 0;}
        .main_logobar{min-width: 253px;}
        .main_logobar-min{min-width: 43px;}
        .layout_sidebar{min-width: 254px;}
        .mainbar{min-width: 550px;} 
         
        .SIDE_MENU_BG_COLOR{background-color:#232E3D; color:#FFFFFF;}
        .TITLE_BG_COLOR{background-color: #19222D;}
        .header_item .fas{color:#B0B8CD;}
        .header_item{color: #B0B8CD;}  
        .dhx_dataview-item--focus i{color: '||v_color_focus||'!important}  
        .dhx_dataview-item--focus p{color: '||v_color_focus||'!important}  
        .dhx_sidebar-button{color:#FFFFFF;}
        .dhx_sidebar-button__icon{color:#FFFFFF;}
        .dhx_menu-button__caret{color:#FFFFFF!important;}
        
        .menutree{background-color:#232E3D;}
        .menutree .dhx_layout-cell-content{background-color:#232E3D;}
        .menutree .dhx_tree-list-item--selected{background-color : '||v_color_focus||';}
        .menutree .dhx_tree-folder--selected{background-color : '||v_color_focus||';}
        .menutree .dhx_tree-folder--focused:before, .dhx_tree-folder:hover:before, .dhx_tree-list-item--focused:before, .dhx_tree-list-item:hover:before{background-color: '||v_color_focus||'!important;}
        .menutree .dhx_tree-list-item--selected .dhx_tree-list-item__icon{color:#FFFFFF!important;}
        .menutree .dhx_tree-list-item--selected .dhx_tree-list-item__text{color:#FFFFFF!important;}
        .menutree .dhx_tree-folder--selected .dhx_tree-list-item__icon{color:#FFFFFF!important;}
        .menutree .dhx_tree-folder--selected .dhx_tree-list-item__text{color:#FFFFFF!important;}
        .menutree .dhx_tree-folder:hover .dhx_tree-list-item__text{color:#FFFFFF!important;}
        .menutree .dhx_tree-list__item:hover .dhx_tree-list-item__text{color:#FFFFFF!important;}
        .menutree .dhx_tree-folder:hover .dhx_tree-list-item__icon{color:#FFFFFF!important;}
        .menutree .dhx_tree-list__item:hover .dhx_tree-list-item__icon{color:#FFFFFF!important;}
        
        .dhx_menu .dhx_menu-item{background-color:#232E3D;}
        .dhx_menu .dhx_menu-item .dhx_menu-button{color:#FFFFFF;}
        .dhx_menu .dhx_menu-item .dhx_menu-button .dhx_menu-button__icon{color:white;font-weight: lighter;}
        .dhx_menu .dhx_menu-item .dhx_menu-button .dhx_menu-button__text{font-weight: lighter;}
        .dhx_menu .dhx_menu-item .dhx_menu-button--active{background-color : '||v_color_focus||';}
        .dhx_menu-button--active:not(:disabled), .dhx_menu-button:active:not(:disabled), .dhx_menu-button:focus:not(:disabled), .dhx_menu-button:hover:not(:disabled){background-color : '||v_color_focus||';}
        
        .dhx_sidebar-button--active{background-color : '||v_color_focus||';}
        .dhx_sidebar-button--active:hover{background-color : '||v_color_focus||';}
        
        .dhx_menu-button:hover:not(:disabled) .dhx_menu-button__text{color: #FFFFFF;}
        .dhx_menu-button--active:not(:disabled) .dhx_menu-button__text{color: #FFFFFF;}
        
        .dhx_menu-button:hover:not(:disabled) .dhx_menu-button__caret{color: #FFFFFF;}
        .dhx_menu-button--active:not(:disabled)  .dhx_menu-button__caret{color: #FFFFFF!important;}
        
        .dhx_menu-button:hover:not(:disabled) .dhx_menu-button__icon{color: #FFFFFF;}
        .dhx_menu-button--active:not(:disabled) .dhx_menu-button__icon{color: #FFFFFF!important;}
        
        .dhx_sidebar-button--active > .dhx_sidebar-button__text{color: #FFFFFF;}
        .dhx_sidebar-button--active:hover > .dhx_sidebar-button__text{color: #FFFFFF;};
        
        .dhx_sidebar-button--select > .dhx_sidebar-button__icon{color: #FFFFFF!important;}
        .dhx_sidebar-button--active > .dhx_sidebar-button__icon{color: #FFFFFF!important;}
        .dhx_sidebar-button--active:hover > .dhx_sidebar-button__icon{color: #FFFFFF;};
        
        .dhx_sidebar-button--select > .dhx_sidebar-button__caret{color: #FFFFFF!important;}
        .dhx_sidebar-button--active > .dhx_sidebar-button__caret{color: #FFFFFF!important;}
        .dhx_sidebar-button--active:hover > .dhx_sidebar-button__caret{color: #FFFFFF!important;}
        
        .footer_notice a{color: #5E6677!important;}
        .dhx_toolbar__item > .dhx_button > .dhx_button__icon{color: #868E96!important;}
        
        #logo_img {cursor: pointer;}
        #side_toogle_btn {color: #FFFFFF;}
        
        .cursor-pointer{cursor:pointer;}
        .toolbar{border: 0;height: 100%;}
        .toolbar li{text-align: right;}
        .black_content .dhx_sidebar-button__text{color: #19222d;font-weight: bold;}
        
        .dhx_toolbar{background-color: transparent!important;}
        .dhx_dataview{background-color: transparent!important;}
        .dhx_layout-cell--resizeble{overflow-y:auto;}
        
      </style>     
    </head> 
    <body onload="onLoad();">
    <div id="main_layout_container" style="height:100vh"></div>
    <script>    
      var CMPY_TYPE = "'||v_systype||'"; //회사타입 A:사내, B:협력사
      var tabbar_content = [{ id:"dashboard", tab: "Dashboard", css:"panel flex", html:""}];
      var IS_NOTICE = false; //공지사항표시 여부
      
      var HEADER_BG_COLOR = "#FFFFFF"; //HEADER 컬러
      var FOOTER_BG_COLOR = "#F2F2F2"; //FOOTER 컬러
      var LEFT_MENU_TYPE = "A"; //왼쪽 메뉴 타입  A:사이드메뉴, B:트리메뉴
      
      //로고 표시
      var logo_content = "<div style=''display:inline-flex!important; margin-top:24px; margin-left:12px''>";
          logo_content += "<img id=''logo_img'' style=''vertical-align:top; width:100px; margin-left:0rem; margin-right:7.1rem;'' src=''/resources/images/logo.png''>";
          logo_content += "<div class=''cursor-pointer'' style=''margin-top: .2rem; margin-left: .2rem; color: white;font-weight: bold;''><i id=''side_toogle_btn'' class=''fas fa-bars''></i></div>";
          logo_content += "</div>";
        
      //사용자 정보 표시
      var footer_notice_content;
      if(CMPY_TYPE == "0") footer_notice_content = "<a href=''javascript:showEditPopup();''><i class=''fas fa-user''></i>&nbsp;'||get_team_name(v_syscomp,v_teamcd,v_syslang)||' '||get_user_name(v_syscomp,v_sysid,v_syslang)||'</a>";
      else  footer_notice_content = "<a href=''javascript:showEditPopup();''><i class=''fas fa-user''></i>&nbsp; '||get_master_name('C_0010',v_sysid,v_systype,v_syslang,v_syscomp)||'</a>";
      
      //상단 대메뉴 정보 - 사내 
      var header_menu_content = 
      [
        {"menuseq":1004,"upmenuid":0,"menuurl":"'||v_pkg||'.main_body","menulevel":1,"sortnum":10,"menuname":"HOME","menuicon":"<i class=\"fas fa-home\"><\/i>"},
        {"menuseq":1000,"upmenuid":0,"menuurl":null,"menulevel":1,"sortnum":20,"menuname":"SCM","menuicon":"<i class=\"fas fa-truck\"><\/i>"},
        {"menuseq":1001,"upmenuid":0,"menuurl":null,"menulevel":1,"sortnum":30,"menuname":"B2B","menuicon":"<i class=\"fas fa-ship\"><\/i>"},
        {"menuseq":3063,"upmenuid":0,"menuurl":null,"menulevel":1,"sortnum":40,"menuname":"MDM","menuicon":"<i class=\"fas fa-server\"><\/i>"},
        {"menuseq":996,"upmenuid":0,"menuurl":null,"menulevel":1,"sortnum":90,"menuname":"SYS","menuicon":"<i class=\"fas fa-cog\"><\/i>"}
      ];  
       
      //상단 대메뉴 정보 - 협력업체 
      var header_menu_content_supply = 
      [
        {"menuseq":35,"upmenuid":0,"menuurl":"'||v_pkg||'.main_body","menulevel":1,"sortnum":10,"menuname":"QMS","menuicon":"<i class=\"fas fa-award\"><\/i>"},
        {"menuseq":1122,"upmenuid":0,"menuurl":null,"menulevel":1,"sortnum":30,"menuname":"TMS","menuicon":"<i class=\"fas fa-industry\"><\/i>"},
        //{"menuseq":1500,"upmenuid":0,"menuurl":null,"menulevel":1,"sortnum":35,"menuname":"TMS2","menuicon":"<i class=\"fas fa-industry\"><\/i>"},
        {"menuseq":34,"upmenuid":0,"menuurl":null,"menulevel":1,"sortnum":40,"menuname":"NOTICE","menuicon":"<i class=\"fas fa-microphone-alt\"><\/i>"},
        {"menuseq":283,"upmenuid":0,"menuurl":null,"menulevel":1,"sortnum":50,"menuname":"MY","menuicon":"<i class=\"fas fa-user-cog\"><\/i>"}
      ];
      
      var main_rows;
      //왼쪽 사이드 메뉴 설정
      if(LEFT_MENU_TYPE == "A"){
        main_rows = [{  id:"header", css : "header", height  : "65px", gravity : false,
          cols: [{ id : "logo", css : "main_logobar TITLE_BG_COLOR", gravity: false, height: "auto", width: "253px", html : logo_content, }
             , { id : "header_menu", css : "mainbar", html : "", gravity : false, width : "550px", }
             , { id : "header_info", css : "header_info", gravity : true}
          ]
        },
        {  id : "body", gravity : true,
          cols: [{ id : "sidebar", css : "layout_sidebar", html : "", gravity : false, height : "auto", }
              , { id : "content", css : "main_content", html : "", gravity : true, width : "auto", height : "auto", }
              , { id : "bookmark", css : "bookmark bookmark-border-top", html : "", gravity : false, collapsable : true, collapsed : true, header : "Bookmark", }
          ]
        },
        {
          id : "footer", css : "footer", gravity : false, height : "50px",
          cols: [{ id : "footer_notice", css: "footer_notice", html: footer_notice_content, height:"auto" }
             , { id : "footer_info", css: "footer_info", html: "", height:"auto" }
          ]
        }];
      
      }
      //왼쪽 트리 메뉴 설정
      else{
        main_rows = [{  id:"header", css : "header", height : "65px", gravity : false,
          cols: [{ id : "logo", css : "main_logobar TITLE_BG_COLOR", gravity: false, height: "auto", width: "253px", html : logo_content, }
             , { id : "header_menu", css : "mainbar", html : "", gravity : false, width : "550px", }
             , { id : "header_info", css : "header_info", gravity : true}
          ]
        },
        {  id : "body", gravity : true,
          cols: [{ id : "sidebar", css : "menutree menutree-border-top", html : "", gravity : false, width: 253, collapsable : true, collapsed : false,  header : ""}
              , { id : "content", css : "main_content", html : "", gravity : true, width : "auto", height : "auto", }
              , { id : "bookmark", css : "bookmark bookmark-border-top", html : "", gravity : false, collapsable : true, collapsed : true, header : "Bookmark", }
          ]
        },
        {
          id : "footer", css : "footer", gravity : false, height : "50px",
          cols: [{ id : "footer_notice", css: "footer_notice", html: footer_notice_content, height:"auto" }
             , { id : "footer_info", css: "footer_info", html: "", height:"auto" }
          ]
        }];
      }
      
      //메인 레이아웃
      var main_layout = new dhx.Layout("main_layout_container", {rows :main_rows,});
      //왼쪽 메뉴 사이드바
      var menu_sidebar = new dhx.Sidebar(null, {css: "dhx_widget--border_right dhx_widget--bg SIDE_MENU_BG_COLOR ",width: 254});
      //왼쪽 메뉴 트리
      var menu_tree = new dhx.Tree(null,{css:"menu_tree",height:"auto"});
      //북마크 사이드바
      var bookmark_sidebar = new dhx.Sidebar(null, {css: "black_content"});
      //대메뉴 카운트
      var header_data_count = 5;
      //대메뉴 데이터뷰
      var header_menu = new dhx.DataView(null, {itemsInRow: "5",gap: 0, css: "header_dataview",template: header_menu_template});

      //상단우측 툴바 
      var toolbar = new dhx.Toolbar(null, {css: "toolbar"});
      //사내접속 툴바
      var toolbar_data = [ 
        {type: "spacer"},          
        {id: "select_lang",type:"selectButton",value:"'||get_catalog_name('COM','LANGUAGE','KO',v_syslang)||'",items: ['||v_lang_josn||']},
        {id: "approval",icon: "fas fa-file-signature",tooltip: "'||get_fn('결재')||'","type": "button","view": "link","color": "secondary","circle": true},
        {id: "logout",icon: "fas fa-lock",tooltip: "'||get_fn('로그아웃')||'","type": "button","view": "link","color": "secondary","circle": true}
      ];
      
      //협력업체접속 툴바
      var toolbar_data2 = [
        {type: "spacer"},
        {id: "select_lang",type:"selectButton",value:"'||get_catalog_name('COM','LANGUAGE','KO',v_syslang)||'",items: ['||v_lang_josn||']},
        {id: "approval",icon: "fas fa-file-signature",tooltip: "'||get_fn('결재')||'","type": "button","view": "link","color": "secondary","circle": true},
        {id: "logout",icon: "fas fa-lock",tooltip: "'||get_fn('로그아웃')||'","type": "button","view": "link","color": "secondary","circle": true}
      ];
      
      var dashboard_timer;
      var wsocket;
      var header_timer, footer_timer, left_timer;
      
      function setFooterColor(){
        if($(".footer").length > 0){
          clearInterval(footer_timer);
          $(".footer").css("background-color",FOOTER_BG_COLOR);
        }
      }
      
      function setHeaderColor(){
        if($(".mainbar").length > 0 && $(".header_info").length > 0){
          clearInterval(header_timer);
          $(".mainbar").css("background-color",HEADER_BG_COLOR);
          $(".header_info").css("background-color",HEADER_BG_COLOR);
        }
      }
      
      function onLoad(){
        
        if(!isEmpty(FOOTER_BG_COLOR)){
          footer_timer = setInterval(setFooterColor,50);
        }
        
        if(!isEmpty(HEADER_BG_COLOR)){
          header_timer = setInterval(setHeaderColor,50);
        }
          
        $("#logo_img").on("click",function(){
          location.reload();
        });
        
        var mainbar_width = header_data_count*70;
        $(".mainbar").css("min-width",mainbar_width+"px");
        $(".mainbar").css("width",mainbar_width+"px");
        $(".mainbar").css("flex-basis",mainbar_width+"px");

        /* 북마크 메뉴 목록 호출 */
        getBookmarkList();
        
        if(CMPY_TYPE == "1"){
          header_menu.data.parse(header_menu_content_supply);
        }else{
          header_menu.data.parse(header_menu_content);
        }
        main_layout.cell("bookmark").attach(bookmark_sidebar);
        
        if(LEFT_MENU_TYPE == "A"){
          main_layout.cell("sidebar").attach(menu_sidebar);  
        }else{
          main_layout.cell("sidebar").attach(menu_tree);  
        }
            
        main_layout.cell("content").attachHTML("<iframe class=''content_frame'' id=''content_frame'' src='''||v_pkg||'.tabbar''></iframe>");
        main_layout.cell("header_menu").attach(header_menu);
        main_layout.cell("header_info").attach(toolbar);
        
        if(CMPY_TYPE== "0"){
          toolbar.data.parse(toolbar_data);
        }
        else{
          toolbar.data.parse(toolbar_data2);
        }      
        
        //결재
        toolbar.data.getItem("approval").count = "'||v_approval_cnt||'";
        toolbar.paint();
        
        toolbar.events.on("Click",function(id){
          var name = toolbar.valueOf()._activeParents;
          
          //Button
          if(id == "logout"){
            name = "";
            if(confirm("'||get_fn('로그아웃하시겠습니까?')||'")){
              var url = "logout";
              window.location.href = url;
            }
          }else if(id == "approval"){
            name = "";
            var menuid = "285"; //결재대기함
            var menuvalue = "'||get_fn('결재대기함')||'";
            var menuurl = "wfWait.control";
            var content_frame = document.getElementById("content_frame");
            content_frame.contentWindow.addTab(menuid, menuvalue,menuurl, null);
          }
          
          //SelectButton
          if(name == "select_company"){
            var url = "'||v_pkg||'.change_comp?p_companycd="+id;
            window.location.href = url;
          }else if(name == "select_group"){
            var url = "'||v_pkg||'.change_group?p_companycd="+id;
            window.location.href = url;
          }else if(name == "select_lang"){
            var url = "'||v_pkg||'.change_lang?p_lang="+id;
            window.location.href = url;
          }
          
        });

        var sel_index = 0; //상단 대메뉴 선택 순번
        //상단 대메뉴 선택 아이템
        if(CMPY_TYPE == "1"){
          var sel_item = header_menu_content_supply[0];  
        }else{
          var sel_item = header_menu_content[0]; 
        }
        
        //상단메뉴 초기설정
        //if(CMPY_TYPE== "0" && sel_item != null && sel_item.menuurl != null){
        if(sel_item != null && sel_item.menuurl != null){
          var menuname = sel_item.menuname;
          var menuurl = sel_item.menuurl;
          var content_frame = document.getElementById("content_frame");
          
          dashboard_timer = setInterval(function(){
            var content_frame = document.getElementById("content_frame");
            var _contentWindow = null;
            try{
              _contentWindow = content_frame.contentWindow; 
            }catch(e){}
            if(_contentWindow != null && _contentWindow.addTab != null){
              _contentWindow.addTab("dashboard-"+menuname, menuname+" '||get_fn('대시보드')||'", menuurl, null, true);
              clearInterval(dashboard_timer);
            }
          },100);
        }
        
        header_menu.setFocusIndex(sel_index);
        
        //좌측사이드메뉴 초기설정
        getSideMenu();
        
        //상단메뉴 클릭 이벤트
        header_menu.events.on("Click", function(id){
          var item = header_menu.getFocusItem();
          var menuurl = "";
          var menuname = item.menuname;
          if(item.menuurl != null) menuurl = item.menuurl;
          
          /* 대시보드 호출 */
          if(CMPY_TYPE== "0" && !isEmpty(menuurl)){
            var content_frame = document.getElementById("content_frame");
            if(content_frame.contentWindow.addTab == null) return false;
            content_frame.contentWindow.addTab("dashboard-"+menuname, menuname+" '||get_fn('대시보드')||'", menuurl, null, true);  
          }
          
          /* 좌측사이드메뉴 목록 호출 */
          getSideMenu();
          
        });
        
        $("#side_toogle_btn").on("click",function(){
          toggle();
        });
        
        if(LEFT_MENU_TYPE == "A"){
          //좌측사이드메뉴 클릭 이벤트
          menu_sidebar.events.on("Click", function(id,e){
            //좌측사이드메뉴에서 선택한 메뉴 정보 
            var menu = menu_sidebar.data._pull[id];
            var content_frame = document.getElementById("content_frame");
            content_frame.contentWindow.addTab(menu.id, menu.value,menu.menuurl, null);
          });  
        }else{
          menu_tree.events.on("ItemClick", function(id, e){
            var menu = menu_tree.data.getItem(id);
            if(menu.isleaf == 1){
              var content_frame = document.getElementById("content_frame");
              content_frame.contentWindow.addTab(menu.id, menu.value,menu.menuurl, null);  
            }else{
              menu_tree.toggle(id);
            }
          });

        }
        
        //우측사이드메뉴 클릭 이벤트
        bookmark_sidebar.events.on("Click", function(id,e){
          //우측사이드메뉴에서 선택한 메뉴 정보 
          var menu = bookmark_sidebar.data._pull[id];
          var content_frame = document.getElementById("content_frame");
          content_frame.contentWindow.addTab(menu.id, menu.value,menu.menuurl, null);
        });
        
        /** 공지사항 띄울때 필요.
        if(IS_NOTICE){
            setTimeout(function(){
                var flag = getCookie("IS_NOTICE_INVISIBLE"); 
                if(!flag||flag==null){
                    var url = "noticepop_3";
                    var param = {};
                    show_popup(url,"SYS_NOTICE_VIEW_POPUP",470, 400, param);    
                }    
            },500);
        } 
        **/
        
        //22.04.22 공지사항 팝업
        //onPopup();
        
      }
      
      //왼쪽 메뉴 셋팅
      function getSideMenu(){
        if(LEFT_MENU_TYPE == "A"){
          //왼쪽 사이드 메뉴 셋팅
          var menuseq = header_menu.getFocusItem().menuseq;
          menu_sidebar.data.removeAll();
          menu_sidebar.data.load("'||v_pkg||'.get_side_menu?p_sysroot="+menuseq);   
        }else{
          //왼쪽 트리 메뉴 셋팅
          var menuseq = header_menu.getFocusItem().menuseq;
          /** 트리 개발 필요 **/
          var url = "/main/getTreeMenu.json";
          var param = {"p_sysroot":menuseq};
          callAjax(url,param,cbGetTreeMenu,null);  
        }  
      }
      
      //왼쪽 트리 메뉴 셋팅 콜백
      function cbGetTreeMenu(dataSet){
        menu_tree.data.removeAll();
        menu_tree.data.parse(dataSet);
      }
      
      //오른쪽 북마크 메뉴 셋팅
      function getBookmarkList(){
        bookmark_sidebar.data.load("'||v_pkg||'.get_bookmark_menu?");
      }
      
      //툴팁 추가
      function showTooltip(obj){
        
        var tooltipText = "";
        if(obj.id == "header_item_user"){
          tooltipText = "";
        }else if(obj.id == "header_item_logout"){
          tooltipText = "'||get_fn('로그아웃')||'";
        }else if(obj.id == "header_item_sitemap"){
          tooltipText = "";
        }else if(obj.id == "QMS"){
          tooltipText = "Quality Management System";
        }else{
          tooltipText = obj.id;
        }
        dhx.tooltip(tooltipText, {node: obj.id, position: "bottom"});
      }
      
      //좌측사이드메뉴 토글
      function toggle(){
        main_layout.cell("sidebar").toggle();
        menu_sidebar.toggle();
        var width;
        if(LEFT_MENU_TYPE == "A"){
          width = 43;
        }else{
          width = 44;
        }
        
        if($("#logo_img").is(":visible")){
          $("#logo_img").hide();
          main_layout.cell("logo").config.width = width+"px";
          main_layout.paint();  
          $(".main_logobar").addClass("main_logobar-min");
          $(".main_logobar").removeClass("main_logobar");
          
          $(".layout_sidebar").css("min-width","43px");
        }else{
          $("#logo_img").show();
          main_layout.cell("logo").config.width = "auto";
          main_layout.paint();
          $(".main_logobar-min").addClass("main_logobar");
          $(".main_logobar-min").removeClass("main_logobar-min");
          
          $(".layout_sidebar").css("min-width","254px");
        }

      }
      
      //상단메뉴 추가
      function header_menu_template(item) {
        var template = ""  
        template += "<div id=''"+item.menuname+"'' class=''header_item'' onmouseover=''showTooltip(this)''>";
        template += item.menuicon;
        template += "<p>"+item.menuname+"</p>";
        template += "</div>";
        
        return template;
      }
      
      //개인정보 변경 팝업 호출
      function showEditPopup(){
        var url = "password.control?";
        var param = {};
        show_popup(url,"POPUP_EDIT_PRIVACY",1000,600,param);
      }    
      
      function onPopup() {
        if (getCookie("blockPopup") == "done" || '||nvl(v_notice_cnt, 0)||' == 0) {
          return true;
        }else{ // 쿠키값이 없으면 elemnet를 보여준다.
          var page = "noticepop_new"; 
          var newWnd3 = window.open(page, "adfwd", "width=800, height=500, resizable=yes, scrollbars=auto"); 
          newWnd3.focus();
        }
      }  

    </script>
    </body>
  </html>
    ');
  EXCEPTION
    when others then
      show_err('control');
  END control;  
  
  PROCEDURE get_side_menu 
  (
    p_sysroot in varchar2 default null
  )
  IS
    cursor cur is
      WITH connect_by_query as (
        select  a.*, 
                case  when  levelNo <= 2 then  rank() over(partition by levelNo order by rowno) 
                      else  null
                end   as level_order
        from (  select  rownum as rowNo, level as levelNo,
                        id_ id, nvl(uid_,-1) uid_,uid_ uid__, 
                        decode(nvl(uid_,-1), -1, get_catalog_name('COM','SYSROOT_NM',v_syslang,nvl(p_sysroot,'111116')), get_program_name(systemcd,pgmid,v_syslang)) pnm, 
                        url, target, systemcd, pgmid, pgm_order, useyn, useyn_supply, premier_view,
                        connect_by_isleaf as isleaf
                from (  select  b.id_, uid_, pgm_order, target, url, pgmid, a.systemcd, b.useyn, b.useyn_supply, b.premier_view
                        from    c_0040 a, c_0042 b
                        where   a.useyn = 'Y'
                        and  (	b.useyn = 'Y'
                        or		  decode(common.get_cookie('SYSID'),'premier',b.premier_view,'N') ='Y'	)
                        and     a.id_ = b.id_
                        and     b.pgm_order is not null
                        and     ( (v_systype = '0' and a.id_ not in ('68','817')) or
                                  (v_systype = '1' and 1=1)
                                )
                      ) a
--                start with uid_ = nvl(p_sysroot,'10016')
                start with uid_ = decode(p_sysroot,'35',decode(v_systype,'1','68',p_sysroot),p_sysroot)
                connect by prior id_ = uid_
                order siblings by pgm_order ) a
      )
      select  '[' as json_snippet
      from    dual
      union all
      select  *
      from (  select  case  when  rowno = 1 then '{'
                            when  levelno = 1 and uid_ <> decode(p_sysroot,'35',decode(v_systype,'1','68',p_sysroot),p_sysroot) then '{'
                            when  levelno - lag(levelno) over (order by rowno) = 1  then ',"items" : [{' 
                            else  ',{' 
                      end
                      /* "id" 는 중복없이 체번되야 하나 기존업체들은 하나의 p/g으로 여러군데 쓰므로 부모id를 붙여 만듬 */
                      ||' "id": "'||id||uid_||'", "upid": "'||uid_||'", "menulevel": "'||levelno||'", "menuurl": "'||url||'", "sortnum": "'||pgm_order||'", "value": "'||pnm||'","isleaf": "'||isleaf||'", "icon":"'||
--                      ||' "id": "'||id||'", "upid": "'||uid_||'", "menulevel": "'||levelno||'", "menuurl": "'||url||'", "sortnum": "'||pgm_order||'", "value": "'||pnm||'","isleaf": "'||isleaf||'", "icon":"'||
                      case  when  levelno = 1 and isleaf = 0 then
                                  case  when  level_order =  1 then 'mdi mdi-hammer'
                                        when  level_order =  2 then 'mdi mdi-hand'
                                        when  level_order =  3 then 'mdi mdi-human-child'
                                        when  level_order =  4 then 'mdi mdi-shield-search'
                                        when  level_order =  5 then 'mdi mdi-graphql'
                                        when  level_order =  6 then 'mdi mdi-flag'
                                        when  level_order =  7 then 'mdi mdi-access-point'
                                        when  level_order =  8 then 'mdi mdi-book-open-page-variant'
                                        when  level_order =  9 then 'mdi mdi-blinds'
                                        when  level_order = 10 then 'mdi mdi-atlassian'
                                        when  level_order = 11 then 'mdi mdi-wifi-strength-1'
                                        when  level_order = 12 then 'mdi mdi-image-filter-drama'
                                        when  level_order = 13 then 'mdi mdi-database-settings'
                                        else 'mdi mdi-shield-search'
                                  end
                            else  'mdi null'
                      end
                      ||'" '
                      /* when the next level lower (shallower) than the current level, close a "children" array */
                      || 
                      case  when  lead(levelno, 1, 1) over (order by rowno) - levelno <= 0 then '}' || rpad( ' ', 1+ (-2 * (lead(levelno, 1, 1) over (order by rowno) - levelno)), ']}' )
                            else  null 
                      end   as  json_snippet
              from    connect_by_query
							where 	1=1
              and     ( (v_systype = '0' and id not in ('68','817')) or
                        (v_systype = '1' and 1=1)
                      )
              order by  rowNo )
      union all
      select  ']' as json_snippet
      from    dual;

    type r02 is table of cur%rowtype index by pls_integer;
    rec r02;

  BEGIN
  
    owa_util.mime_header('application/json');

    open cur;
    fetch cur bulk collect into rec;
    close cur;
    
    for i in 1 .. rec.count loop
      htp.p(rec(i).json_snippet);
    end loop;
   
  EXCEPTION
    when others then
      show_err('get_side_menu'); 
  END get_side_menu;
  
  PROCEDURE get_bookmark_menu 
  (
    p_sysroot in varchar2 default null
  )
  IS
    cursor cur is
      with connect_by_query as (
      select rownum as rowno, x.*
      from (
            select a.id_ as id, a.url, a.sno, get_program_name(a.systemcd, a.pgmid, v_syslang) as pnm
            from   c_0043 a, c_0040 b
            where 1=1
            and   a.systemcd = b.systemcd
            and   a.pgmid = b.pgmid
            and   a.companycd = '00' --고정
            and   a.gubun = v_systype
            and   a.xuser = v_sysid
            order by a.sno
           ) x
    )
    select  '[' as json_snippet
    from    dual
    union all
    select *
    from ( select case when rowno = 1 then 
                  '{'
                  else 
                  ',{' 
                  end ||'"id": "'||id||'", "menuurl": "'||url||'", "value": "'||pnm||'"'||'}' as json_snippet
           from connect_by_query
         )
    union all
    select ']' as json_snippet
    from dual
    ;

    type r02 is table of cur%rowtype index by pls_integer;
    rec r02;

  BEGIN
  
    owa_util.mime_header('application/json');

    open cur;
    fetch cur bulk collect into rec;
    close cur;
    
    for i in 1 .. rec.count loop
      htp.p(rec(i).json_snippet);
    end loop;
  
  EXCEPTION
    when others then
      show_err('get_bookmark_menu');  
  END get_bookmark_menu;

  PROCEDURE tabbar
  IS
  BEGIN
    htp.p('
<!DOCTYPE html>
<html>
  <head>
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <link rel="STYLESHEET" type="text/css" href="/grid451/codebase/dhtmlx.css" />
    <link rel="STYLESHEET" type="text/css" href="/grid451/skins/terrace/dhtmlx.css" />
    <script type="text/javascript" src="/grid451/codebase/dhtmlx.js"></script>
    <script type="text/javascript" src="/include/jquery/jquery-1.11.1.min.js"></script>
    <style>
      html, body {
        width: 100%;
        height: 100%;
        margin: 0px;
        padding: 0px;
        background-color: white;
        overflow: hidden;
      }
      
      .dhxtabbar_base_dhx_terrace div.dhxtabbar_tabs div.dhxtabbar_tab div.dhxtabbar_tab_text.dhxtabbar_tab_text_close
      {
          padding-right: 33px;
          font-size: 9pt;
      }
      .dhxtabbar_base_dhx_terrace div.dhxtabbar_tabs div.dhxtabbar_tab.dhxtabbar_tab_actv, .dhxtabbar_base_dhx_terrace div.dhxtabbar_tabs div.dhxtabbar_tab.dhxtabbar_tab_actv_dis{
        background-color : #eff4f9;
      }

    </style>
    
    <script>
      var main_layout;
      var main_tabbar;
      function doOnLoad() {
        main_layout = new dhtmlXLayoutObject({
          parent: document.body,
          pattern: "1C",
          skin: "dhx_terrace",
          offsets: {
            top:    0,    
            right:  1,
            bottom: 1,
            left:   1
          }
        });
        main_layout.cells("a").hideHeader();
        main_tabbar = main_layout.cells("a").attachTabbar();
        main_tabbar.setSkin("dhx_terrace");
        
        main_tabbar.enableTabCloseButton(true);         
      }
      
      var tabs_timer;
      function addTab(tab_id, tab_name, url, param, is_refresh){        
        var tabArray = [];
        try{
          tabArray = main_tabbar.getAllTabs();  
        }catch(e){}
        
        var flag = false;
        for(var i=0; i<tabArray.length; i++){
          if(tab_id == tabArray[i]){
            flag =true;
            break;
          }
        }
        if(!flag){
          if(typeof main_tabbar != ''undefined'' && typeof main_tabbar.addTab != ''undefined''){
            main_tabbar.addTab(tab_id,tab_name,null,null,true,true);    
            main_tabbar.tabs(tab_id).attachURL(url,null,param);  
          }else{
            setTimeout(function(){
              main_tabbar.addTab(tab_id,tab_name,null,null,true,true);    
              main_tabbar.tabs(tab_id).attachURL(url,null,param);
            },50);
          }
        }else{
          main_tabbar.cells(tab_id).setText(tab_name);
          main_tabbar.cells(tab_id).setActive();
          if(is_refresh){
            main_tabbar.tabs(tab_id).attachURL(url,null,param);
          }
        }  
      }
      
      /* 활성탭바 삭제 */    
      function removeActiveTab() {
        var actvId = main_tabbar.getActiveTab();
        main_tabbar.tabs(actvId).close(true);
      }
      
    </script>
  </head>
  <body onload="doOnLoad();">
    
  </body>
</html>');
  EXCEPTION
    when others then
      show_err('tabbar');
  END tabbar;
  
  PROCEDURE main_body
  (
    p_companycd in varchar2 default common.get_cookie('SYSCOMP')
  )
  IS
  
  BEGIN
    htp.p('
  
    ');
  EXCEPTION
    when others then
      show_err('main_body');
  END main_body;
  
  PROCEDURE change_lang     
  ( 
    p_lang in varchar2 default null
  )    
  IS  
      
  BEGIN   
  
    owa_util.mime_header('text/html',FALSE);    
    common.set_cookie('SYSLANG',p_lang);    
    owa_util.redirect_url(''||v_pkg||'.control');    
      
  END change_lang; 
  
END main_kaps;

/
