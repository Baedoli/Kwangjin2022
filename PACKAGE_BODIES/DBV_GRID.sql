--------------------------------------------------------
--  DDL for Package Body DBV_GRID
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "PREMIER"."DBV_GRID" 
IS

  PROCEDURE print_env_v451
  IS
  BEGIN
    HTP.p ('
       <!--

                                                                           _____  _____                                 
                                                                           0000H  #000#                                 
      pggmggmggpgpp,      ;gpgmggmggmgpg   _pqpg       _ggp,  _gmgg#Hggq    MM00#  0NN#&     ,pgpmmpg_  yqggg,      gpqg 
      #0BMMMMM000M&00p    0#0M00MN00QK#0#g  0MB#S      0&Q0` j#N#0#N0M0M#   0#00f  MN&#f   g#N00M000N0g ]NMN0L     KN00& 
      ]M0000~~~~~M0M#00&   &0000     M00M##  RN00#     R&BB$  4M"^^`~00M0M  Q0&00  \0NN0   M0M0M`  B0000  M0#M0     M00M  
      4M0B0&      "NM00M6  M0M#&     _Q0N00  =&MM#    j#M0&          p000M  #N#Q#  #0000  #&0M#     #M00f 4M0N0    #BM0f  
      0M#0M5       Q#N0M&  0B000ppggQNN0NM    #0M06   #0N&      __ppMM&&M#  B0000  #0000  MN0M#mgqpg0NM0   BK&0f   0##F   
      QNNM&-       4#&M0& jN0#00M0M&QN0#g     RM0&S  g0M0S   ,gDN0Q00000MH  0MM0#  0M00# ]00000M#M#MM0MM   4#MN#  4M00    
      B0#NM        0M0MQ6 ]B00MP~~"~~0000#,   ~000&  #00&   N0B0@"~  &M008  MMN0E  0NN#f 40000f             #B0N  0N0k    
      #N0M0      aMM000f  jM00M      ]MM00#    QB00wM00M   ]M0M9     ##M05 ]##0Nt  BK0Nf 400MMg             D00N6#MM#     
      00000ggqgp0MM0N0@   0M00M,___,p000#M&     00000MMf   Q0M0L     00MM  #000#  Q00M0c  000M##mp,_qg      l0000NMN      
      J0000N00N0NMMNNM`    B00MN0#000##00MP      ^M0M#0&    "M#N#0&   0M&0  #0M00  4NNM#   ^Q0N0M000#0@       00N0MKf      
      "^~~""~^~~^"~^       ~~^"~~~~^~"~^`          `~""       "@MM"   `MNM6 "~~~~  "~^~~     `~M#M0M~"`       Q0000&       
                                                                                                           #0N0N        
                                                                                                         y0NM00"        
                                                                                                     ]#0000MNM^         
                                                                                                     0000#M@F           
                                                                     
      Copyright '||to_char(sysdate, 'yyyy')||' DBValley Corp. All rights reserved.
            
      -->
      
      <link rel="icon" type="image/png" href="/resources/images/favicon.ico">
         
      <link rel="stylesheet" type="text/css" href="/grid451/codebase/dhtmlx.css" />
      <link rel="stylesheet" type="text/css" href="/grid451/skins/terrace/dhtmlx.css" />
      <link rel="stylesheet" type="text/css" href="/grid451/skins/skyblue/dhtmlx.css" />
      <link rel="stylesheet" type="text/css" href="/grid451/skins/web/dhtmlx.css" />        
      <script src="/grid451/codebase/dhtmlx.js"></script>

      <link rel="stylesheet" type="text/css" media="screen" href="/include/dbv_eco_rev.css" /> 
      <link rel="stylesheet" type="text/css" href="/include/login/fonts/fontawesome-5.15.3/css/all.css">
           
      <link rel="stylesheet" type="text/css" href="/include/jquery/jquery-ui-latest/css/cupertino/jquery-ui-1.10.0.custom.min.css" />
      <script type="text/javascript" src="/include/jquery/jquery-latest.min.js"></script>
      <script type="text/javascript" src="/include/jquery/jquery-ui-latest/js/jquery-ui-1.10.0.custom.min.js"></script>
      <script type="text/javascript" src="/include/jquery/jquery-ui-latest/js/jquery.ui.datepicker-ko.js"></script>

      <script type="text/javascript" id="dym"></script>
        
      <style>
        html, body {
          width: 100%;
          height: 100%;
          margin: 0px;
          padding: 0px;
          overflow: hidden;
        }
            
        .my_footer {
            padding-top: 9px;
        }
        .text_block {
            //font-family: Roboto, Arial, Helvetica;
            //font-size: 14px;
            //background-color: #ffffff;
            padding: 0px 0px;
            //border: 1px solid #dfdfdf;
        }
            
        .grid_hover {
            background-color:#CFFFD4;
        }
        
        /* Layout setText background */
        .dhxlayout_base_dhx_skyblue .dhxlayout_cont div.dhx_cell_layout div.dhx_cell_hdr {
          background: -webkit-linear-gradient(#f5f5f5,#f5f5f5);
        }
        
        /* Layout dhxcelltop_statusbar background */
        .dhxlayout_base_dhx_skyblue div.dhxcelltop_statusbar div.dhxcont_statusbar{
          background-color: #f5f5f5;
        }

        /* Grid ?????? v_header_style */
        div.gridbox_dhx_web.gridbox table.hdr td {
          text-align: center;
          vertical-align:middle;
        }
        
        /* Grid ?????? ?????? */
        div.gridbox_dhx_web.gridbox table.obj.row20px tr td img {
          display: block;
          display: inline;
        }
            
      </style>

      <script>
        function isValidDate(iY,iM,iD){  //??????????????? ?????? 
            var LD = new Array(31,28,31,30,31,30,31,31,30,31,30,31); 
            var iM = parseInt(iM,10) - 1; 
            var iD = parseInt(iD,10); 
            if((iY%4==0 && iY %100!=0) || iY%400==0){ 
             LD[1]=29; 
            } 
            return(iD >= 1 && iD <= LD[iM]); 
        }
          
        function input_valid(iType,iValue,iNeces,iName,iLen){  //gubun : ????????????(??????(num),??????)(dat)) vl : ??? mand_yn : ????????????   
          if(iValue!="" && iType=="num"){  //????????? ?????? 
              if(isNaN(iValue)){ 
                  alert(iName + "'||get_fn('(???)??? ???????????????. ????????? ???????????? ????????????.')||'"); 
                  return true; 
              }    
          } 
          if(iValue!="" && iType=="yer"){  //????????? ?????? 
              if(isNaN(iValue)){ 
                  alert(iName + "'||get_fn('???(???)4???????????????????????????????????????.')||'"); 
                  return true; 
              }  
              if(iValue.length<4){ 
                  //alert(iName + "?????? 4?????? ???????????? ????????? ????????????."); 
                  alert(iName + "'||get_fn('???(???)4???????????????????????????????????????.')||'"); 
                  return true; 
              }   
          } 
          if(iValue!="" && iType=="dat"){  //????????? ??????     
                
              if(isNaN(iValue)){ 
              //alert(iName + "?????? ????????? ???????????? ????????????."); 
              alert(iName + "'||get_fn('(???)??????????????????.?????????????????????????????????.')||'"); 
              return true; 
              } 
              if(iValue.length<8){ 
                  //alert(iName + "?????? 8?????? ???????????? ????????? ????????????."); 
                  alert(iName + "'||get_fn('??????????????????8????????????????????????????????????.')||'"); 
                  return true; 
              } 
              var iY = iValue.substr(0,4); 
              var iM = iValue.substr(4,2); 
              var iD = iValue.substr(6,2); 
              var cD = iY + iM + iD; 
              if(!isValidDate(iY,iM,iD)){  
                  alert(iName + "'||get_fn('??? ???????????? ?????? ????????? ?????????????????????.')||'(" + cD + ")"); 
                  return true; 
              } 
          } 
          //???????????? ?????? 
          if(iNeces && iValue==""){ 
              alert(iName + "'||get_fn('???(???) ????????????????????????.')||'"); 
              return true; 
          } 
          //?????? ??????  
          //cal_byte(iValue,iLen,"'||get_fn('???????????? ?????? ??????')||'") 
          if(iValue.length > iLen && iLen > 0){ 
              //alert(iName + "???(???) ??????????????? ?????????????????????."); 
              alert(iName + "'||get_fn('???(???)????????????????????????????????????.')||'"); 
              return true; 
          } 
        }
        
        // list_catalog ????????? ??????????????? ??????????????? ?????? ??????
        function getCatalogRelation(p_systemcd, p_catalogcd, p_element_id, p_listvalue_u, p_listvalue, p_all_type) {
          var url = "get_catalog_relation";
          var param = {"p_systemcd": p_systemcd, "p_catalogcd": p_catalogcd, "p_listvalue_u": p_listvalue_u, "p_listvalue": p_listvalue, "p_all_type": p_all_type};
          var v_selected = "";
             
          $.getJSON(url, param, function(returnData, textStatus) {
            $("#"+p_element_id+" option").remove();
            $.each(returnData, function(i) {
              if (returnData[i].optionValue == p_listvalue) {
                v_selected = " selected=\"selected\"";
              }
              else {
                v_selected = "";
              }
                
              $("#"+p_element_id+"").append("<option value=''"+returnData[i].optionValue+"''"+v_selected+">"+returnData[i].optionName+"</option>");
            });
          });
        }
        
        // list_dept ????????? ??????????????? ??????????????? ?????? ??????
            function getTeamList(p_companycd, p_teamcd, p_element_id) {
              var url = "get_team_list";
              var param = {"p_companycd": p_companycd, "p_teamcd": p_teamcd, "p_all_type": "c"};
              $("#"+p_element_id+" option").remove();
              $.getJSON(url, param, function(returnData, textStatus) {
                $.each(returnData, function(i) {
                  $("#"+p_element_id+"").append("<option value=''"+returnData[i].optionValue+"'' "+returnData[i].selected+">"+returnData[i].optionName+"</option>");
                });
              });
            }
         
      $(document).ready(function() {  
         domReady();
      }); 
       
       /* ????????? ?????? ??? ?????? */
      function domReady(){
        //?????? ?????? ???????????? ?????? ?????? (????????? ????????? ???????????? ???????????? ?????????)
        //$("body").on("click",fnMenuHidden);
        $("body, .dhx_cell_layout, .gridbox").on("click",fnMenuHidden);
        TIMER = setInterval(function(){
          if($(".objbox").length > 0){
            clearInterval(TIMER);
            $(".objbox").on("click",fnMenuHidden);
          }
        },50);
      }
      
      function fnMenuHidden(e){
        var paths = window.document.location.href.split("/");
        var pathCnt = paths.length;
        var lastSegment = paths.pop() || paths.pop();
        var doc;
        //console.log(pathCnt);
        if(pathCnt > 4){
          doc = $(parent.parent.document);
          //console.log("1");
          //console.log(doc);
          $(doc).find("#main_layout_container").trigger("click");
            
          try {
            var doc2 = $(parent.parent.parent.document);
            $(doc2).find("#main_layout_container").trigger("click");
          } catch(e) {}
        }else{
          if(lastSegment != "main.do"){
            doc = $(parent.document);
            $(doc).find("#main_layout_container").trigger("click");
          }
        }
      }
        
          
      </script>
  ');
  EXCEPTION 
    when others then
      show_err('print_env_v451');
  END print_env_v451;
  
  PROCEDURE print_env_v652
  IS
  BEGIN
    HTP.p (' 
    <link rel="icon" type="image/png" href="/resources/images/favicon.ico">
     
    <link rel="STYLESHEET" type="text/css" href="/resources/css/font.css">    
    <link rel="STYLESHEET" type="text/css" href="/resources/css/layout_type1.css">    
    <link rel="STYLESHEET" type="text/css" href="/include/fontawesome/css/all.min.css">  
    <link rel="STYLESHEET" type="text/css" href="/include/materialicon/css/materialdesignicons.min.css">    
    <link rel="STYLESHEET" type="text/css" href="/grid652/codebase/suite.css">      
    <link rel="STYLESHEET" type="text/css" href="/resources/css/premier.css" />
    
    <script src="/grid652/codebase/suite.min.js"></script>
    <script src="/grid652/vault/codebase/vault.js"></script> 
    <script src="/include/jquery/jquery-1.11.3.min.js"></script>
    <script type="text/javascript" src="/include/jquery/jquery-1.12.4.min.js"></script>
    <script src="/include/jquery/jquery.loading.min.js"></script> <!-- loading ?????? js -->
    <script src="/js/common/premier_util.js"></script>
                                 
        
      <style>  
      .h3, h3 {
        font-size: 1.75rem;
      } 
      </style>
      
      <script>
        $(function(){
            //side bar ?????? ?????? ????????? ???????????? ??????????????? ?????? ?????? ??????..
            $("html").click(function(e){ 
                  var paths = window.document.location.href.split("/");
                  var pathCnt = paths.length;
                  var lastSegment = paths.pop() || paths.pop();
                  var doc;
                   
                  doc = $(parent.parent.document);
                  $(doc).find("#layout").trigger("click"); //main_layout_container ??? layout
                  
                  ');
                  htp.p('  
            });   
        });
 
        /* call function
          url: ?????? url
          param: ????????????
          cbFnc: ????????????
          ex) fnCallData(url, param, fnCallBackGrid);
        */
          function fnCallData(url, param, cbFnc){
            $("body").loading({ theme: "light", zIndex: 99999 });
            
            $.post(url, param )
              .done(function( data ) { 
                cbFnc(data);
              })
              .fail(function(xhr, status, error) {
                $(":loading").loading("stop");
                alert(error);
              })
              .always(function() {
                $(":loading").loading("stop");
              });
              ;  
          }
          
         function fnCallAjax(url, param, cbFnc){
             
             $("body").loading({ theme: "light", zIndex: 99999 });
            
             $.ajax({
                  type: "POST",
                  url: url,
                  data: param,
                  success: function(data){
                        $(":loading").loading("stop");
                        cbFnc(data);
                  },
                  error: function(XMLHttpRequest, textStatus, errorThrown) {
                     alert("'||get_fn('????????? ?????????????????????.')||' "+errorThrown);
                     $(":loading").loading("stop");
                  }
            });
          }
          
          function fnCallAjax2(url, param, cbFnc){ 
            
             $.ajax({
                  type: "POST",
                  url: url,
                  data: param,
                  success: function(data){ 
                        cbFnc(data);
                  },
                  error: function(XMLHttpRequest, textStatus, errorThrown) {
                     alert("'||get_fn('????????? ?????????????????????.')||' "+errorThrown); 
                  }
            });
          }
           
      </script>
  ');
  EXCEPTION 
    when others then
      show_err('print_env_v652');
  END print_env_v652;
  
  PROCEDURE print_env_rev
    IS
    BEGIN
            
      htp.p('
            
          <!--
                                                                               _____  _____                                 
                                                                               0000H  #000#                                 
          pggmggmggpgpp,      ;gpgmggmggmgpg   _pqpg       _ggp,  _gmgg#Hggq    MM00#  0NN#&     ,pgpmmpg_  yqggg,      gpqg 
          #0BMMMMM000M&00p    0#0M00MN00QK#0#g  0MB#S      0&Q0` j#N#0#N0M0M#   0#00f  MN&#f   g#N00M000N0g ]NMN0L     KN00& 
          ]M0000~~~~~M0M#00&   &0000     M00M##  RN00#     R&BB$  4M"^^`~00M0M  Q0&00  \0NN0   M0M0M`  B0000  M0#M0     M00M  
          4M0B0&      "NM00M6  M0M#&     _Q0N00  =&MM#    j#M0&          p000M  #N#Q#  #0000  #&0M#     #M00f 4M0N0    #BM0f  
          0M#0M5       Q#N0M&  0B000ppggQNN0NM    #0M06   #0N&      __ppMM&&M#  B0000  #0000  MN0M#mgqpg0NM0   BK&0f   0##F   
          QNNM&-       4#&M0& jN0#00M0M&QN0#g     RM0&S  g0M0S   ,gDN0Q00000MH  0MM0#  0M00# ]00000M#M#MM0MM   4#MN#  4M00    
          B0#NM        0M0MQ6 ]B00MP~~"~~0000#,   ~000&  #00&   N0B0@"~  &M008  MMN0E  0NN#f 40000f             #B0N  0N0k    
          #N0M0      aMM000f  jM00M      ]MM00#    QB00wM00M   ]M0M9     ##M05 ]##0Nt  BK0Nf 400MMg             D00N6#MM#     
          00000ggqgp0MM0N0@   0M00M,___,p000#M&     00000MMf   Q0M0L     00MM  #000#  Q00M0c  000M##mp,_qg      l0000NMN      
          J0000N00N0NMMNNM`    B00MN0#000##00MP      ^M0M#0&    "M#N#0&   0M&0  #0M00  4NNM#   ^Q0N0M000#0@       00N0MKf      
          "^~~""~^~~^"~^       ~~^"~~~~^~"~^`          `~""       "@MM"   `MNM6 "~~~~  "~^~~     `~M#M0M~"`       Q0000&       
                                                                                                               #0N0N        
                                                                                                             y0NM00"        
                                                                                                         ]#0000MNM^         
                                                                                                         0000#M@F           
                                                                             
          Copyright '||to_char(sysdate, 'yyyy')||' DBValley Corp. All rights reserved.
                    
          -->
          
          <link rel="icon" type="image/png" href="/resources/images/favicon.ico">

          <!-- ????????? -->
          <link rel="stylesheet" type="text/css" media="screen" href="/grid/dhtmlxGrid/codebase/dhtmlxgrid.css" />
          <link rel="stylesheet" type="text/css" media="screen" href="/grid/dhtmlxGrid/codebase/dhtmlxgrid_skins.css" />
          <link rel="stylesheet" type="text/css" media="screen" href="/grid/dhtmlxGrid/codebase/skins/dhtmlxgrid_dhx_skyblue.css" />
          <link rel="stylesheet" type="text/css" media="print" href="/grid/dhtmlxGrid/codebase/dhtmlxgrid.css" />
          <link rel="stylesheet" type="text/css" media="print" href="/grid/dhtmlxGrid/codebase/dhtmlxgrid_skins.css" />
          <link rel="stylesheet" type="text/css" media="print" href="/grid/dhtmlxGrid/codebase/skins/dhtmlxgrid_dhx_skyblue.css" />
          <link rel="stylesheet" type="text/css" href="/grid/dhtmlxCalendar/codebase/skins/dhtmlxcalendar_dhx_skyblue.css" />
          <link rel="stylesheet" type="text/css" href="/grid/dhtmlxCalendar/codebase/dhtmlxcalendar.css" />
          <link rel="stylesheet" type="text/css" href="/grid/dhtmlxLayout/codebase/dhtmlxlayout.css">
          <link rel="stylesheet" type="text/css" href="/grid/dhtmlxLayout/codebase/skins/dhtmlxlayout_dhx_skyblue.css">
          <link rel="stylesheet" type="text/css" href="/grid/dhtmlxLayout/codebase/skins/dhtmlxlayout_dhx_web.css">
          <link rel="stylesheet" type="text/css" href="/grid/dhtmlxLayout/codebase/skins/dhtmlxlayout_dhx_blue.css">
          <link rel="stylesheet" type="text/css" href="/grid/dhtmlxGrid/codebase/ext/dhtmlxgrid_pgn_bricks.css">
          
          <link rel="stylesheet" type="text/css" href="/grid451/codebase/dhtmlx.css" />
          <link rel="stylesheet" type="text/css" href="/grid451/skins/terrace/dhtmlx.css" />
          <link rel="stylesheet" type="text/css" href="/grid451/skins/web/dhtmlx.css" />        
          <link rel="stylesheet" type="text/css" href="/grid451/skins/skyblue/dhtmlx.css" />
          <script src="/grid451/codebase/dhtmlx.js"></script>
                
          <script src="/grid/dhtmlxLayout/codebase/dhtmlxcommon.js"></script>
          <script src="/grid/dhtmlxLayout/codebase/dhtmlxlayout.js"></script>
          <script src="/grid/dhtmlxLayout/codebase/dhtmlxcontainer.js"></script>
          <script  src="/grid/dhtmlxLayout/codebase/patterns/dhtmlxlayout_pattern4l.js"></script>
          <script  src="/grid/dhtmlxLayout/codebase/patterns/dhtmlxlayout_pattern4f.js"></script>
          <script type="text/javascript" src="/grid/dhtmlxGrid/codebase/dhtmlxcommon.js"></script>
          <script type="text/javascript" src="/grid/dhtmlxCalendar/codebase/dhtmlxcalendar.js"></script>
          <script type="text/javascript" src="/grid/dhtmlxGrid/codebase/dhtmlxgrid.js"></script>
          <script type="text/javascript" src="/grid/dhtmlxGrid/codebase/dhtmlxgridcell.js"></script>
          <script type="text/javascript" src="/grid/dhtmlxGrid/codebase/ext/dhtmlxgrid_json.js"></script>
          <script type="text/javascript" src="/grid/dhtmlxGrid/codebase/ext/dhtmlxgrid_mcol.js"></script>
          <script type="text/javascript" src="/grid/dhtmlxGrid/codebase/ext/dhtmlxgrid_hmenu.js"></script>
          <script type="text/javascript" src="/grid/dhtmlxGrid/codebase/ext/dhtmlxgrid_splt.js"></script>    
          <script type="text/javascript" src="/grid/dhtmlxGrid/codebase/ext/dhtmlxgrid_drag.js"></script>
          <script type="text/javascript" src="/grid/dhtmlxGrid/codebase/ext/dhtmlxgrid_keymap_access.js"></script>
          <script type="text/javascript" src="/grid/dhtmlxGrid/codebase/excells/dhtmlxgrid_excell_link.js"></script>
          <script type="text/javascript" src="/grid/dhtmlxGrid/codebase/ext/dhtmlxgrid_rowspan.js"></script>
          <script type="text/javascript" src="/grid/dhtmlxGrid/codebase/ext/dhtmlxgrid_filter.js"></script>
          <script type="text/javascript" src="/grid/dhtmlxGrid/codebase/ext/dhtmlxgrid_pgn.js"></script> 
          <script type="text/javascript" src="/grid/dhtmlxGrid/codebase/excells/dhtmlxgrid_excell_dhxcalendar.js"></script>
                
          <!-- Tab bar -->
          <link rel="STYLESHEET" type="text/css" href="/grid/dhtmlxTabbar/codebase/dhtmlxtabbar.css">
          <script  src="/grid/dhtmlxTabbar/codebase/dhtmlxcommon.js"></script>
          <script  src="/grid/dhtmlxTabbar/codebase/dhtmlxtabbar.js"></script>
          <script  src="/grid/dhtmlxTabbar/codebase/dhtmlxtabbar_start.js"></script>
                
          <!-- ?????? ????????? -->
          <script  src="/grid/dhtmlxTreeGrid/codebase/dhtmlxtreegrid.js"></script>  
          <script  src="/grid/dhtmlxTreeGrid/codebase/ext/dhtmlxtreegrid_lines.js"></script> 
          <script  src="/log/dtree/dtree.js"></script>
                
          <!--jquery & dbvalley-->
          <link rel="stylesheet" type="text/css" media="screen" href="/include/dbv_eco_rev.css" />
          <link rel="stylesheet" type="text/css" media="print" href="/include/dbv_eco_rev.css" />      
          <link rel="stylesheet" type="text/css" href="/include/jquery/jquery-ui-latest/css/cupertino/jquery-ui-1.10.0.custom.min.css" />
          <script type="text/javascript" src="/include/jquery/jquery-latest.min.js"></script>
          <script type="text/javascript" src="/include/jquery/jquery-ui-latest/js/jquery-ui-1.10.0.custom.min.js"></script>
          <script type="text/javascript" src="/include/jquery/jquery-ui-latest/js/jquery.ui.datepicker-ko.js"></script>
                
          <!--????????????-->
          <script src="/gantt/codebase/dhtmlxgantt.js" type="text/javascript" charset="utf-8"></script>
          <script src="/gantt/codebase/locale/locale_kr.js" charset="utf-8"></script>
          <link rel="stylesheet" href="/gantt/codebase/skins/dhtmlxgantt_skyblue.css" type="text/css" media="screen" title="no title" charset="utf-8">
                
          <!--font-awesome-->
          <link rel="stylesheet" type="text/css" href="/include/login/fonts/fontawesome-5.15.3/css/all.css"> 
            
          <!-- ????????? ????????? -->
          <script type="text/javascript" src="/se/js/HuskyEZCreator.js" charset="utf-8"></script>
                
          <!-- ????????? ????????? -->
          <script src="/grid/dhtmlxGrid/codebase/ext/dhtmlxgrid_srnd.js"></script> 
              
          <style>
            /* Layout setText background */
            .dhxlayout_base_dhx_skyblue .dhxlayout_cont div.dhx_cell_layout div.dhx_cell_hdr {
              background: -webkit-linear-gradient(#f5f5f5,#f5f5f5);
            }
            
            /* Layout dhxcelltop_statusbar background */
            .dhxlayout_base_dhx_skyblue div.dhxcelltop_statusbar div.dhxcont_statusbar{
              background-color: #f5f5f5;
            }

            /* Grid ?????? v_header_style */
            div.gridbox_dhx_web.gridbox table.hdr td {
              text-align: center;
              vertical-align:middle;
            }
            
            /* Grid ?????? ?????? */
            div.gridbox_dhx_web.gridbox table.obj.row20px tr td img {
              display: block;
              display: inline;
            }
          
          </style>  
          <script>
            var g_file_size = 300000000;
            var g_file_cnt = 30;
                  
            <!-- ???????????? ?????? ?????? -->
            function showFileSize() {
                var input, file;

                if (!window.FileReader) {
                    bodyAppend("p", "The file API isn nott supported on this browser yet.");
                    return;
                }

                input = document.getElementById("p_file_name");
                if (!input) {
                    bodyAppend("p", "Um, couldn not find the p_file_name element.");
                }
                else if (!input.files) {
                    bodyAppend("p", "This browser doesn not seem to support the `files` property of file inputs.");
                }
                else if (!input.files[0]) {
                    bodyAppend("p", "Please select a file before clicking ''Load''");
                }
                else {
                    file = input.files[0];
                    //bodyAppend("p", "File " + file.name + " is " + file.size + " bytes in size");
                }
                      
                return file.size;
            }
                  
            <!-- ???????????? ?????? ?????? -->
            function bodyAppend(tagName, innerHTML) {
              //var elm;

              //elm = document.createElement(alert);
              //elm.innerHTML = innerHTML;
              //document.body.appendChild(elm);
                    
              alert(innerHTML);
            }

            function self_close()
            {
              opener.location.reload();
              self.close();
            }
                  
            <!-- javascript.js ?????? ??????-->
                  
            function isValidDate(iY,iM,iD){  //??????????????? ?????? 
                var LD = new Array(31,28,31,30,31,30,31,31,30,31,30,31); 
                var iM = parseInt(iM,10) - 1; 
                var iD = parseInt(iD,10); 
                if((iY%4==0 && iY %100!=0) || iY%400==0){ 
                 LD[1]=29; 
                } 
                return(iD >= 1 && iD <= LD[iM]); 
            }
                  
            // true ??? ???????????? ???????????? 
            /* ------------------------------------------------ 
                iType  - num, dat, yer 
                        num : ?????? 
                        dat : ?????? (8??????) 
                        yer : ?????? (4??????) 
                       
                iValue  - ?????? ??? 
                       
                iNeces  - ?????? ??????(boolean) 
                        true 
                        false 
                       
                iName  - ?????? ?????? 
                       
                iLen  - ?????? 
                        0 : ?????? ?????? 
                        4 : 4??????????????? ?????? ?????? 
                        8 : 8??????????????? ?????? ?????? 
                   
            ------------------------------------------------ */ 
                  
            function input_valid(iType,iValue,iNeces,iName,iLen){  //gubun : ????????????(??????(num),??????)(dat)) vl : ??? mand_yn : ????????????   
              if(iValue!="" && iType=="num"){  //????????? ?????? 
                  if(isNaN(iValue)){ 
                      alert(iName + "'||get_fn('(???)??? ???????????????. ????????? ???????????? ????????????.')||'"); 
                      return true; 
                  }    
              } 
              if(iValue!="" && iType=="yer"){  //????????? ?????? 
                  if(isNaN(iValue)){ 
                      alert(iName + "'||get_fn('???(???)4???????????????????????????????????????.')||'"); 
                      return true; 
                  }  
                  if(iValue.length<4){ 
                      //alert(iName + "?????? 4?????? ???????????? ????????? ????????????."); 
                      alert(iName + "'||get_fn('???(???)4???????????????????????????????????????.')||'"); 
                      return true; 
                  }   
              } 
              if(iValue!="" && iType=="dat"){  //????????? ??????     
                        
                  if(isNaN(iValue)){ 
                  //alert(iName + "?????? ????????? ???????????? ????????????."); 
                  alert(iName + "'||get_fn('(???)??????????????????.?????????????????????????????????.')||'"); 
                  return true; 
                  } 
                  if(iValue.length<8){ 
                      //alert(iName + "?????? 8?????? ???????????? ????????? ????????????."); 
                      alert(iName + "'||get_fn('??????????????????8????????????????????????????????????.')||'"); 
                      return true; 
                  } 
                  var iY = iValue.substr(0,4); 
                  var iM = iValue.substr(4,2); 
                  var iD = iValue.substr(6,2); 
                  var cD = iY + iM + iD; 
                  if(!isValidDate(iY,iM,iD)){  
                      alert(iName + "'||get_fn('??? ???????????? ?????? ????????? ?????????????????????.')||'(" + cD + ")"); 
                      return true; 
                  } 
              } 
              //???????????? ?????? 
              if(iNeces && iValue==""){ 
                  alert(iName + "'||get_fn('???(???) ????????????????????????.')||'"); 
                  return true; 
              } 
              //?????? ??????  
              //cal_byte(iValue,iLen,"'||get_fn('???????????? ?????? ??????')||'") 
              if(iValue.length > iLen && iLen > 0){ 
                  //alert(iName + "???(???) ??????????????? ?????????????????????."); 
                  alert(iName + "'||get_fn('???(???)????????????????????????????????????.')||'"); 
                  return true; 
              } 
            }  
                  
            //textarea ????????? ?????? 
            function cal_byte(ob,bt,field_name) {             
              var aquery = ob.value; 
              var tmpStr; 
              var temp=0; 
              var onechar; 
              var tcount; 
              tcount = 0;             
              tmpStr = new String(aquery); 
              temp = tmpStr.length;             
              for (k=0;k<temp;k++) 
              { 
                onechar = tmpStr.charAt(k); 
                if (escape(onechar) =="%0D") { } else if (escape(onechar).length > 4) { tcount += 2; } else { tcount++; } 
              }
                     
              if(tcount>bt) { 
                reserve = tcount-bt; 
                alert(field_name+"???(???) "+bt+"??????????????? ??????????????? ????????????.\r\n ?????? ???????????? "+reserve+"???????????? ?????????????????????.");          
                  return true; 
              }   
            } 
                  
            //edp_download ?????? ???????????? 
            function open_download(p_file){ 
              var url = "edp_download"; 
              url = url + "?p_file=" + encodeURI(p_file);
              window.open(url);  
            } 
                  
            //edp_download ?????? ???????????? 
            function open_download2(p_file){ 
              var url = "edp_download"; 
              url = url + "?p_file=" + encodeURI(p_file);
              window.open(url);  
            }
                  
            //edp_download ?????? ???????????? 
            function open_download3(p_file){ 
              var url = "edp_download1"; 
              url = url + "?p_file=" + encodeURI(p_file);
              window.open(url);  
            }
                  
                  
            function replaceAll(str, searchStr, replaceStr) {
              while (str.indexOf(searchStr) != -1) {
                str = str.replace(searchStr, replaceStr);
              }

              return str;
            }
                  
            function replaceHTML(str) {
              return str.replace(/</g,"&lt;").replace(/>/g,"&gt;").replace(/\"/g,"&#34;").replace(/\#/g,"&#35;").replace(/\$/g,"&#36;").replace(/\%/g,"&#37;").replace(/&/g,"&#38;").replace(/\''/g,"&#39;").replace(/\+/g,"&#43;").replace(/\//g,"&#47;");
            }
                  
            function replaceHTMLForGrid(str) {
              //.replace(/\#/g,"&#35;").replace(/\"/g,"&#34;").replace(/\$/g,"&#36;").replace(/\%/g,"&#37;").replace(/&/g,"&#38;").replace(/</g,"&lt;").replace(/>/g,"&gt;")
              return str.replace(/\''/g,"&#39;").replace(/\+/g,"&#43;").replace(/\//g,"&#47;");
            }
                  
            // list_catalog ????????? ??????????????? ??????????????? ?????? ??????
            function getCatalogRelation(p_systemcd, p_catalogcd, p_element_id, p_listvalue_u, p_listvalue, p_all_type) {
              var url = "get_catalog_relation";
              var param = {"p_systemcd": p_systemcd, "p_catalogcd": p_catalogcd, "p_listvalue_u": p_listvalue_u, "p_listvalue": p_listvalue, "p_all_type": p_all_type};
              var v_selected = "";
                     
              $.getJSON(url, param, function(returnData, textStatus) {
                $("#"+p_element_id+" option").remove();
                $.each(returnData, function(i) {
                  if (returnData[i].optionValue == p_listvalue) {
                    v_selected = " selected=\"selected\"";
                  }
                  else {
                    v_selected = "";
                  }
                        
                  $("#"+p_element_id+"").append("<option value=''"+returnData[i].optionValue+"''"+v_selected+">"+returnData[i].optionName+"</option>");
                });
              });
            }
                  
            // list_dept ????????? ??????????????? ??????????????? ?????? ??????
            function getTeamList(p_companycd, p_teamcd, p_element_id) {
              var url = "get_team_list";
              var param = {"p_companycd": p_companycd, "p_teamcd": p_teamcd, "p_all_type": "c"};
              $("#"+p_element_id+" option").remove();
              $.getJSON(url, param, function(returnData, textStatus) {
                $.each(returnData, function(i) {
                  $("#"+p_element_id+"").append("<option value=''"+returnData[i].optionValue+"'' "+returnData[i].selected+">"+returnData[i].optionName+"</option>");
                });
              });
            }
                  
            // list_user ????????? ??????????????? ??????????????? ?????? ??????
            function getUserList(p_companycd, p_teamcd, p_xuser, p_element_id) {
              var url = "get_xuser_by_teamcd";
              var param = {"p_companycd": p_companycd, "p_teamcd": p_teamcd, "p_xuser": p_xuser, "p_all_type": "c"};
              $("#"+p_element_id+" option").remove();
              $.getJSON(url, param, function(returnData, textStatus) {
                $.each(returnData, function(i) {
                  $("#"+p_element_id+"").append("<option value=''"+returnData[i].optionValue+"'' "+returnData[i].optionSelected+">"+returnData[i].optionName+"</option>");
                });
              });
            }
                  
            //????????????..????????? ??????????????????
            function digit_check(evt){
              var code = evt.which?evt.which:event.keyCode;
              if(code < 48 || code > 57){
                if (code != 8){
                  return false;
                }
              }
            }
                  
            //progressbar ????????????
            var _SPINNER = null;  // ????????? ?????? ??????
                  
            /* ????????? ????????? */
            function setStartSpinner() {
                         
              var opts = {
                    lines: 13                // The number of lines to draw
                  , length: 18             // The length of each line
                  , width: 12             // The line thickness
                  , radius: 42             // The radius of the inner circle
                  , scale: 1                 // Scales overall size of the spinner
                  , corners: 1             // Corner roundness (0..1)
                  , color: ''#00D8FF''         // #rgb or #rrggbb or array of colors #0088cc
                  , opacity: 0.25         // Opacity of the lines
                  , rotate: 0             // The rotation offset
                  , direction: 1             // 1: clockwise, -1: counterclockwise
                  , speed: 1                 // Rounds per second
                  , trail: 60             // Afterglow percentage
                  , fps: 20                 // Frames per second when using setTimeout() as a fallback for CSS
                  , zIndex: 2e9             // The z-index (defaults to 2000000000)
                  , className: ''spinner''     // The CSS class to assign to the spinner
                  , top: ''46%''             // Top position relative to parent
                  , left: ''41%''             // Left position relative to parent
                  , shadow: false         // Whether to render a shadow
                  , hwaccel: false         // Whether to use hardware acceleration
                  , position: ''absolute''     // Element positioning
                };
                      
              var target = document.getElementById("spinner");
                    
              if (_SPINNER == null) {
                  _SPINNER = new Spinner(opts).spin(target);
              }
            }

            /* ????????? ????????? */
            function setStopSpinner() {  
              if (_SPINNER != null) {
                _SPINNER.stop();
                _SPINNER = null;
              }
            }
            
            /* ?????? */
            function toggle_layer() {
              if($("#approvStatus").css("display") == "none"){
                $("#approvStatus").show();
              }else{
                $("#approvStatus").hide();
              }
            }
            
            function approval_descr(obj) {
              var url = "approval_status_comment?p_doc_id="+obj;  
              newWnd = window.open(url,"approval_status_comment","top=100, left=100, status=yes, resizable=no, scrollbars=yes, width=900, height=600");  
              newWnd.focus();
            }
            
            //class =  required ?????? td??? ???????????? ???????????? ????????????
            function formRquried(){
              val = true;
              
              $(".require").each(function(i){
                text = $(".require").eq(i).html();
                nextTr = $(".require").eq(i).next();
                chdTag = nextTr.find("select");
                
                if(chdTag.length > 0){
                  for(j=0; j < chdTag.length; j++){
                    thisTag = chdTag.eq(j);
                    notClass = thisTag.hasClass("not");
                    disalble = thisTag.prop("disabled");
                    
                    if(thisTag.val() == "" && !notClass && !disalble){
                      alert("[" + text + "]'||get_fn('???(???) ????????????????????????.')||'");
                      $(this).removeClass("inputGreen");
                      $(this).addClass("inputRed");
                      thisTag.focus();
                      val = false;
                      return false;
                    }
                    else{
                      $(this).addClass("inputGreen");
                    }
                  }
                }
                
                chdTag = nextTr.find("textarea");
                if(chdTag.length > 0){
                  for(j=0; j < chdTag.length; j++){
                    thisTag = chdTag.eq(j);
                    notClass = thisTag.hasClass("not");
                    disalble = thisTag.prop("disabled");
                    if(thisTag.val() == "" && !notClass && !disalble){
                      alert("[" + text + "]'||get_fn('???(???) ????????????????????????.')||'");
                      $(this).removeClass("inputGreen");
                      $(this).addClass("inputRed");
                      thisTag.focus();
                      val = false;
                      return false;
                    }else{
                      $(this).addClass("inputGreen");
                    }
                  }
                }
                
                chdTag = nextTr.find("input");
                if(chdTag.length > 0){
                  for(j=0; j < chdTag.length; j++){
                    thisTag = chdTag.eq(j);
                    tagType = thisTag.prop("type");
                    tagName = thisTag.prop("name");
                    notClass = thisTag.hasClass("not");
                    disalble = thisTag.prop("disabled");
                    
                    if(!notClass && !disalble){
                      thisVal = "";
                      if(tagType ==  "text"){
                        thisVal = thisTag.val();
                        if(thisTag.val() == ""){
                          alert("[" + text + "]'||get_fn('???(???) ????????????????????????.')||'");
                          $(this).removeClass("inputGreen");
                          $(this).addClass("inputRed");
                          thisTag.eq(0).focus();
                          val = false;
                          return false;
                        }else{
                          $(this).addClass("inputGreen");
                        }
                      }if(tagType ==  "radio"){
                        thisVal = $("input[name="+tagName+"]").is(":checked");
                        if(!thisVal){
                          alert("[" + text + "]'||get_fn('???(???) ????????????????????????.')||'");
                          $(this).removeClass("inputGreen");
                          $(this).addClass("inputRed");
                          val = false;
                          return false;
                        }else{
                          $(this).addClass("inputGreen");
                        }
                      }if(tagType ==  "checkbox"){
                        thisVal = $("input[name="+tagName+"]").is(":checked");
                        if(!thisVal){
                          alert("[" + text + "]'||get_fn('???(???) ????????????????????????.')||'");
                          $(this).removeClass("inputGreen");
                          $(this).addClass("inputRed");
                          val = false;
                          return false;
                        }else{
                          $(this).addClass("inputGreen");
                        }
                      }
                    }
                  }
                }

              });
 
              return val
            }
                  
            $(function() {
                  
              //???????????? ??????..            
              $("input.qty").css("ime-mode", "disabled").keyup(function() {
                $(this).val( $(this).val().replace(/[^0-9.]/g, "") );
              });
              
              /******* ?????? - S *******/
              
                /* ???????????? ????????? ??? */
                $("#aprvBtn1").show();
                $("#aprvBtn2").hide();
                /*1??? ???????????? ??? 2??? ?????????*/
                $("#aprvBtn1").click(function(){
                  $("#aprvBtn1").hide();
                  $("#aprvBtn2").show();
                });
                /* 2??? ???????????? ??? 1??? ????????? */
                $("#aprvBtn2").click(function(){
                  $("#aprvBtn1").show();
                  $("#aprvBtn2").hide();
                });
                
              /******* ?????? - E *******/
                    
            });
            
            /**
             * ????????? ?????? ?????? ??????
             */
            function popupImageView(obj1, obj2) {
              var url = "common.imageView?p_linktypecd="+obj1+"&p_linkid="+obj2;
              newWnd = window.open(url,"imageView","top=100, left=100, status=yes, resizable=no, scrollbars=yes, width=800, height=700");  
              newWnd.focus();
            }
            
          </script> 

      ');
           
    END print_env_rev;

END DBV_GRID;

/
