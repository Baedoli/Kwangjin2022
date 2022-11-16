--------------------------------------------------------
--  DDL for Package Body COMC0042
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "PREMIER"."COMC0042" 
IS
  PROCEDURE control
  (
    p_sysroot in varchar2 default '996',
    p_id_ in varchar2 default null,
    p_uid_ in varchar2 default null
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
        myLayout = new dhtmlXLayoutObject(document.body, "2U","dhx_skyblue");
        myLayout.cells("a").hideHeader();
        myLayout.cells("b").hideHeader();
        myLayout.cells("a").setWidth(350);
        myLayout.setAutoSize("b;a", "a;b");
        dhxTree = myLayout.cells("a").attachTree();
        dhxTree.setImagePath("/grid451/skins/web/imgs/dhxtree_web/");
        dhxTree.enableTreeLines(true);
        dhxTree.setOnClickHandler(tonclick);
        var v_url_a = "'||v_pkg||'.query_a?"+$("#form1").serialize();
        var v_url_b = "'||v_pkg||'.crrec";
        dhxTree.load(v_url_a, openNode, "xml");
        myLayout.cells("b").attachURL(v_url_b);
        attachHeader();
      }
      
      // 저장후 필요.
      function openNode() {
        dhxTree.selectItem('||p_id_||'); 
        dhxTree.focusItem('||p_id_||');
        myLayout.cells("b").attachURL("'||v_pkg||'.crrec?p_id_='||p_id_||'&p_uid_='||p_uid_||'&p_sysroot='||p_sysroot||'"); 
      }
      
      function tonclick(id) { 
        var v_id = "";
        v_id = id.split("_")[0];
        var url = "'||v_pkg||'.crrec?p_id_="+v_id+"&p_uid_="+dhxTree.getUserData(v_id, "uid")+"&p_sysroot='||p_sysroot||'";
        myLayout.cells("b").attachURL(url);
      }
      
      function attachHeader() {
        myLayout.attachHeader("top-header");
      }
      
      function doQuery() {
        document.getElementById("form1").submit();
      }
      
      $(function() {
        doOnLoad();  
        
        $(window).on("resize", function(){
          myLayout.detachHeader();
          attachHeader();
        });
        
        $("#p_sysroot").change(function() {
          doQuery();  
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
          <div class="cTitle"><label for="p_sysroot">'||get_fn('탭')||'</label></div>
          <div class="cInput"> ');
            common.list_catalog('COM','SYSROOT_NM', p_sysroot, 'select', '', 'p_sysroot', 'z', 'yes'); htp.p('
          </div>
        </div>  
      </div>
      <div id="c11">
        <a href="#" onclick="doQuery(); return false;" class="btn-search buttons">'||get_fn('조회')||'</a>
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
    p_sysroot in varchar2 default null
  )
  IS
    cursor cur is   
      select rownum as rowNo, level as levelNo, 
             id_ id, nvl(uid_,-1) uid_,uid_ uid__, 
             decode(nvl(uid_,-1), -1, get_catalog_name('COM','SYSROOT_NM','KO', p_sysroot), get_program_name(systemcd,pgmid,'KO')) pnm, 
             url, target, systemcd, pgmid, pgm_order, useyn
      from (
        select b.id_, uid_, pgm_order, target, url, pgmid, a.systemcd, b.useyn
        from c_0040 a, c_0042 b
        where a.id_ = b.id_
        and a.useyn='Y'      
      ) a
      start with id_= p_sysroot
      connect by prior id_=uid_ 
      order siblings by pgm_order;

    type r02 is table of cur%rowtype index by pls_integer;
    rec r02;

    cursor fnd_check(p_key in number) is   
      select count(1)   
      from c_0042   
      where rownum = 1   
      and uid_ = p_key; 

    v_check number := 0;
    l_prev_level number := 0;
    l_count number := 0;
    v_open varchar2(100);
    v_viewyn varchar2(100);
    v_pgm_nm varchar2(2048) := null;
        
  begin
    open cur;
    fetch cur bulk collect into rec;
    close cur;

    owa_util.mime_header('text/xml', TRUE, 'utf-8');
    
    htp.p('
    <tree id="0">
    ');
    
    l_count := 0;     
      
    for rec in cur loop   
            
      l_count := l_count + 1;    

      v_check := 0;   
        
      open fnd_check(rec.id);   
      fetch fnd_check into v_check;   
      close fnd_check;

      if rec.levelno < l_prev_level then
        for y in rec.levelno..l_prev_level-1 loop 
          htp.p(' </item> ');   
        end loop;   
      end if;   
        
      if rec.levelno = 1 then
        v_open := 'open="1"';
      else
        v_open := null;
      end if;

      if rec.useyn = 'Y' then
        v_viewyn := '■';
      else
        v_viewyn := '□';
      end if;
        
      v_pgm_nm := ch_xml_data(rec.pnm);
           
      htp.p('
        <item text="'||v_viewyn||v_pgm_nm||'('||rec.pgm_order||')" id="'||rec.id||'" '||v_open||'> 
        <userdata name="menu'||l_count||'-1">'||ch_xml_data(rec.url)||'</userdata>
        <userdata name="uid">'||rec.uid_||'</userdata>
      ');

      if v_check = 0 then htp.p('</item>'); end if;
        
        l_prev_level := rec.levelNo;
        
    end loop;     
           
    for y in 1..l_prev_level-1 loop   
      htp.p('</item>');   
    end loop;
      
    htp.p('</tree>');
  EXCEPTION 
    WHEN OTHERS THEN
      SHOW_ERR;
  END query_a;
  
  PROCEDURE crrec
  (
    p_sysroot in varchar2 default null,
    p_id_ in varchar2 default null,
    p_uid_ in varchar2 default null
  )
  IS

    cursor cur is
      select *
      from c_0042
      where id_ = p_id_
      and uid_ = p_uid_;
      
    rec cur%rowtype;
      
    cursor cur_change(p_key in varchar2) is
      select *
      from c_0040
      where pgm_gb = nvl(p_key, pgm_gb)
      order by pgmid;
  
    v_selected varchar2(20);
  
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
              
      });   

      function proc_save() {
        var thisForm = document.getElementById("form1");
        
      
                
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
      <input type="hidden" id="p_sysroot" name="p_sysroot" value="'||p_sysroot||'" />
      <input type="hidden" id="p_dml_gubun" name="p_dml_gubun" value="" />
    
      <!-- 신규 Form Setting S -->
      <div class="formWrap">
      
        <!--상단타이틀/버튼-->
        <div class="formTop">
          <div class="formTitle">'||get_program_name('QMS',v_pkg,v_lang)||'</div>
          <div class="btnbar">
            <a href="#" class="btn-save buttons" onclick="proc_save(); return false;">'||get_fn('저장')||'</a>&nbsp;
            <a href="#" class="btn-delete buttons" onclick="proc_del(); return false;">'||get_fn('삭제')||'</a>&nbsp;
          </div>
        </div>
        
        <!--테이블입력-->
        <div>
          <table width="100%" border="0" cellspacing="0" cellpadding="4">
            <tbody>
            
              <tr>
                <td class="titletd">ID</td>
                <td class="inputtd">
                  <select id="p_id" name="p_id"> ');
                  for rec_change in cur_change(null) loop
                    
                    if rec_change.id_=p_id_ then 
                      v_selected:='selected'; 
                    else 
                      v_selected:=''; 
                    end if; htp.p('
                    
                    <option value="'||rec_change.id_||'" '||v_selected||'>['||rec_change.pgm_gb||']'||rec_change.pgmid||' '||rec_change.descr||'</option> ');
                    
                  end loop; htp.p('
                  </select>
                </td>
              </tr>
              <tr>
                <td class="titletd">UID</td>
                <td class="inputtd">
                  <select id="p_uid" name="p_uid"><option value="" selected></option>');
                  for rec_change in cur_change('M') loop
                  
                    if rec_change.id_=p_uid_ then
                      v_selected:='selected';
                    else
                      v_selected:='';
                    end if; htp.p('
                    
                    <option value="'||rec_change.id_||'" '||v_selected||'>'||rec_change.pgmid||' '||rec_change.descr||'</option>');
                  end loop; htp.p('
                  </select>
                </td>
              </tr>
              <tr>
                <td class="titletd">Sorting Order</td>
                <td class="inputtd">
                  <input type="text" name="p_pgm_order" maxlength="30" class="txtbox" value="'||rec.pgm_order||'">
                </td>
              </tr>
              <tr>
                <td class="titletd">Url</td>
                <td class="inputtd">
                  <input type="text" name="p_url" maxlength="40" class="txtbox" value="'||rec.url||'">
                </td>
              </tr>
              <tr>
                <td class="titletd">Target</td>
                <td class="inputtd">
                  <input type="text" name="p_target" maxlength="40" class="txtbox" value="'||rec.target||'">
                </td>
              </tr>
              <tr>
                <td class="titletd">USE YN</td>
                <td class="inputtd">');
                  common.list_catalog('COM','USEYN', rec.useyn, 'select', '', 'p_useyn', 'z', 'yes'); htp.p('
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

  PROCEDURE process
  (
    p_sysroot in varchar2 default null,
    p_id in number default null,
    p_uid in number default null,
    p_url in varchar2 default null,
    p_target in varchar2 default null,
    p_pgm_order in number default null,
    p_useyn in varchar2 default null,
    p_dml_gubun in varchar2 default null
  )
  IS
  
  BEGIN
    
    if p_dml_gubun = '1' then
    
      begin
      
        insert into c_0042
        ( id_, uid_, url, target, pgm_order, useyn, login_id, login_ymd )
        values
        ( p_id, p_uid, p_url, p_target, p_pgm_order, nvl(p_useyn, 'Y'), v_id, sysdate );
        
      exception
        when dup_val_on_index then
          update c_0042
          set pgm_order = p_pgm_order,
              url = p_url,
              target = p_target,
              useyn = p_useyn,
              login_id = v_id,
              login_ymd = sysdate
          where id_ = p_id
          and uid_ = p_uid;
        
        when others then
            show_err;
      end;
    
      htp.p('
        <script type="text/javascript">  
          parent.location.href="'||v_pkg||'.control?p_sysroot='||p_sysroot||'&p_id_='||p_id||'&p_uid_='||p_uid||'";
        </script>
        ');
    
    elsif p_dml_gubun = '2' then
      
      begin
      
        delete from c_0042
        where id_ = p_id
        and uid_ = p_uid;
          
      exception
        when others then
          show_err;
      end;
    
      htp.p(' 
        <script type="text/javascript"> 
          parent.location.href="'||v_pkg||'.control?p_sysroot='||p_sysroot||'";
        </script> 
      ');
        
    end if;
  
  EXCEPTION
    when others then 
      show_err('process');
  END process;

END COMC0042;

/
