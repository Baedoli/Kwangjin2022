--------------------------------------------------------
--  DDL for Package Body COMMON
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "PREMIER"."COMMON" 
IS
  v_selected varchar2(100);
  
  FUNCTION get_cookie
  (
    p_cookie_name VARCHAR2
  )
  RETURN varchar2 IS
    v_cookie owa_cookie.cookie;
  BEGIN
    v_cookie := owa_cookie.get(upper(p_cookie_name));
    return v_cookie.vals(1);
  exception
    when NO_DATA_FOUND then
      return null;
  END get_cookie;
    
  PROCEDURE set_cookie
  (
    p_cookie_name in VARCHAR2,
    p_name in VARCHAR2
  )
  IS
    v_cookie owa_cookie.cookie;
  BEGIN
    v_cookie := owa_cookie.get(upper(p_cookie_name));
    IF (v_cookie.num_vals > 0) THEN
      owa_cookie.remove(upper(p_cookie_name), v_cookie.vals(1));
    END IF;  
      owa_cookie.send(upper(p_cookie_name), p_name);
  END set_cookie;
  
  PROCEDURE list_qc_company_login
  (
    p_companycd in varchar2,
    p_lang in varchar2
  )
  IS
    cursor cur is
      select 1 step, null companycd, null descr
      from dual
      union all
      select 2 step, companycd, decode(p_lang,'KO',descr,descr1) descr
      from xm001_login -- 2018 부서 통합으로 인해 xm001 변동됩 로그인 화면에서는 협력사때문에 기존데이터(백업본) 연동
      where qisgbn = 'Y'
      and   useyn = 'Y'
      order by step, companycd;

    v_row number := 0;
  BEGIN
    for rec in cur loop
      v_row := v_row + 1;
      if p_companycd is null then
         if v_row = 1 then v_selected := '" selected>'; else v_selected := '">'; end if;
      else
         if( rec.companycd = p_companycd) then v_selected := '" selected>'; else v_selected := '">'; end if;
      end if;
      htp.p('<option value="'||rec.companycd||v_selected||rec.descr||'</option>');
    end loop;
  END list_qc_company_login;
  
  PROCEDURE list_company
  (
    p_companycd in varchar2, 
    p_lang      in varchar2
  )
  IS
  
  cursor cur (p_lang in varchar2) is
    select * 
    from (
          select 1 step, null companycd, get_fn('전체') as descr, 0 kpi_order
          from dual
          union all
          select 2 step, a.companycd, b.name as descr, a.kpi_order
          from xm001 a,master_language b
          where 1=1
          and   a.useyn = 'Y'  
          and   a.qisgbn = 'Y' 
          and   a.companycd = b.code 
          and   b.companycd = '00' 
          and   b.lang = p_lang  
          and   b.tableid = 'XM001' 
          and   a.kpi_order is not null
         )
    order by step,kpi_order
    ;

  v_row number := 0;
  
  BEGIN
    for rec in cur(p_lang) loop
      v_row := v_row + 1;
    if p_companycd is null then
       if v_row = 1 then v_selected := '" selected>'; else v_selected := '">'; end if;
    else   
       if( rec.companycd = p_companycd) then v_selected := '" selected>'; else v_selected := '">'; end if;
    end if;  
      htp.p('<option value="'||rec.companycd||v_selected||rec.descr||'</option>');
    end loop;
  END list_company;
  
  PROCEDURE list_catalog_name
  (
    p_systemcd in varchar2, 
    p_catalogcd in varchar2,
    p_listvalue in varchar2,
    p_lang in varchar2
  )
  IS
    cursor cur is
      select 2 step, listvalue, listdescr, listorder
      from c_0051
      where systemcd = p_systemcd
      and   catalogcd = upper(p_catalogcd)
      and   lang = p_lang
      and		useyn = 'Y'
      order by step, listorder;

    v_row number := 0;
    v_lang varchar2(50);
  BEGIN
    for rec in cur loop
      v_row := v_row + 1;
    if p_listvalue is null then
       if v_row = 1 then v_selected := '" selected="selected">'; else v_selected := '">'; end if;
    else   
       if( rec.listvalue = p_listvalue) then v_selected := '" selected="selected">'; else v_selected := '">'; end if;
    end if;  
      htp.p('<option value="'||rec.listvalue||v_selected||rec.listdescr||'</option>');
    end loop;
  END list_catalog_name;  
  
  procedure list_catalog (
    p_systemcd in varchar2, 
    p_catalogcd in varchar2,
    p_listvalue in varchar2,
    p_element_tag in varchar2,
    p_element_type in varchar2,
    p_element_name in varchar2,
    p_all_type in varchar2,
    p_attr in varchar2 default null,
    p_divider in varchar2 default null,
    p_class in varchar2 default null,
    p_check_all in varchar2 default null,
    p_lang in varchar2 default common.get_cookie('SYSLANG')
  )
  is
    cursor cur is
      select  listvalue, return_html_text(listdescr) listdescr, 
              case  when  p_element_tag = 'input' and p_element_type in ( 'checkbox', 'radio' ) then
                          case  when  instr(p_listvalue, listvalue) > 0 then
                                      'checked="checked"'
                                else  null
                          end
                    when  p_element_tag = 'span' then
                          case  when  instr(p_listvalue, listvalue) > 0 then
                                      '&#x25A0;'--  '&#x2611;'
                                else  '&#x25A1;'--  '&#x2610;'
                          end
              else
                    case  when  p_element_tag = 'input'  then
                                case  when  listvalue = p_listvalue  then
                                            'checked="checked"'
                                      else  null
                                end
                          when  p_element_tag = 'select' then
                                case  when  listvalue = p_listvalue  then
                                            'selected="selected"'
                                      else  null
                                end
                          else  null
                    end
              end selected
              --decode(listvalue, p_listvalue, decode(p_element_tag, 'input', 'checked="checked"', 'select', 'selected="selected"'), null) selected
      from    c_0051 a
      where    systemcd = upper(p_systemcd)
      and      catalogcd = upper(p_catalogcd)
      and      lang = upper(p_lang)
      and      useyn = 'Y'
      order by  listorder;

    type r01 is record (
      listvalue c_0051.listvalue%type,
      listdescr c_0051.listdescr%type,
      selected c_0051.listdescr%type
    );
    type r02 is table of r01 index by pls_integer;
    rec r02;

    v_attr varchar2(50) := null;
    v_selected varchar2(30) := null;
    v_class varchar2(30) := null;

  begin

    /*
    p_all_type

    'a'    전체
    'a-'  전체+NVL처리값(@)
    'b'    빈칸
    'c'    선택하세요
    'z'    빈칸없음

    p_attr
    disabled  disabled="disabled"
    readonly  readonly="readonly"
    yes        name= 부분을 표시함 - submit할 때 포함함
    no        name= 부분을 표시하지 않음 - submit할 때 포함하지 않음
    */
    open cur;
    fetch cur bulk collect into rec;
    close cur;

    if lower(p_attr) = 'disabled' then
      v_attr := ' name="'||p_element_name||'" disabled="disabled"';
    elsif lower(p_attr) = 'readonly' then
      v_attr := ' name="'||p_element_name||'" readonly="readonly"';
    elsif lower(p_attr) = 'yes' then
      v_attr := ' name="'||p_element_name||'"';
    elsif lower(p_attr) = 'no' then
      v_attr := null;
    end if;

    if p_class is not null then
      v_class := 'class="'||p_class||'"';
    else
      v_class := null;
    end if;

    if lower(p_element_tag) = 'select' then 
      htp.p('
        <select id="'||p_element_name||'" '||v_attr||' '||v_class||'>
      ');
      if lower(p_all_type) = 'a' then     
        htp.p('          <option value="">'||get_fn('전체')||'</option>');
      elsif substr(lower(p_all_type), 1, 1) = 'a' and length(lower(p_all_type)) > 1 then  --  value는 substr(lower(p_all_type), 2, length(p_all_type))
        htp.p('          <option value="'||substr(lower(p_all_type), 2, length(p_all_type))||'">'||get_fn('전체')||'</option>');
      elsif lower(p_all_type) = 'b' then  --  빈칸
        htp.p('          <option value=""></option>');
      elsif lower(p_all_type) = 'c' then  --  선택하세요
        htp.p('          <option value="">'||get_fn('선택하세요')||'</option>');
      elsif lower(p_all_type) = 'z' then  --  칸 없음
        null;
      end if;
    elsif lower(p_element_tag) = 'input' then 
      if lower(p_all_type) = 'a' then      --  전체
        if p_listvalue is null then
          v_selected := 'checked="checked"';
        else
          v_selected := null;
        end if;

        htp.p('
          <input type="'||p_element_type||'" id="'||p_element_name||'_0" '||v_attr||' value="" '||v_selected||' '||v_class||' /> <label class="label-'||p_element_type||'" for="'||p_element_name||'_0">'||get_fn('전체')||'</label>
        ');
      end if;
    end if;

    for i in 1 .. rec.count loop
      if lower(p_element_tag) = 'input' then 
        if p_element_type = 'checkbox' and p_check_all is not null then
          v_selected := 'checked="checked"';
        else
          v_selected := rec(i).selected;
        end if;
        htp.p('
        <input type="'||p_element_type||'" id="'||p_element_name||'_'||i||'" '||v_attr||' value="'||rec(i).listvalue||'" '||v_selected||'  '||v_class||'/> <label class="label-'||p_element_type||'" for="'||p_element_name||'_'||i||'">'||rec(i).listdescr||'</label>
        ');
      elsif lower(p_element_tag) = 'select' then 
        htp.p('
          <option value="'||rec(i).listvalue||'" '||rec(i).selected||'>'||rec(i).listdescr||'</option>
        ');
      elsif lower(p_element_tag) = 'span' then 
        htp.p('
        <span style="font-family: Gulim; font-size: 14px;">'||rec(i).selected||'</span> <label>'||rec(i).listdescr||'</label>
        ');
       end if;

       -- p_divider를 이용하여 한 줄에 표시되는 수를 지정한다.
       if p_divider is not null and mod(i, p_divider) = 0 then
         htp.p('<br />');
       end if;
    end loop;

    if lower(p_element_tag) = 'select' then 
      htp.p('
        </select>
      ');
    end if;    

  exception
    when others then
      htp.p('
      <span id="err" style="color: #ff0000;">'||sqlerrm||'</span>
      ');
  end list_catalog;
  
  PROCEDURE list_systemcd   
  (
    p_systemcd   in varchar2,
    p_all_type   in varchar2
  )   
  IS   
        cursor cur_search is  
          select  systemcd, systemcd systemnm
          from    c_0005
          where   useyn = 'Y'
          order by  1;
         
        v_selected varchar2(100);

        v_column varchar2(20);   
    BEGIN   
    
      if lower(p_all_type) = 'a' then     
        htp.p('          <option value="">'||get_fn('전체')||'</option>');
      elsif substr(lower(p_all_type), 1, 1) = 'a' and length(lower(p_all_type)) > 1 then  --  value는 substr(lower(p_all_type), 2, length(p_all_type))
        htp.p('          <option value="'||substr(lower(p_all_type), 2, length(p_all_type))||'">'||get_fn('전체')||'</option>');
      elsif lower(p_all_type) = 'b' then  --  빈칸
        htp.p('          <option value=""></option>');
      elsif lower(p_all_type) = 'c' then  --  선택하세요
        htp.p('          <option value="">'||get_fn('선택하세요')||'</option>');
      elsif lower(p_all_type) = 'z' then  --  칸 없음
        null;
      end if;
      
        --htp.p('<option value="">'||get_fn('선택하세요')||'</option>');
      for rec in cur_search loop   
        if (P_SYSTEMCD = rec.systemcd) then v_selected := '" selected>'; else v_selected := '">'; end if;   
        htp.p('<option value="'||rec.systemcd||v_selected||rec.systemnm||'</option>');   
      end loop;
    END;  
    
  PROCEDURE imageView
  (
    p_linktypecd in varchar2 default null,
    p_linkid in varchar2 default null
  )
  IS
  
  BEGIN  
        
    htp.p('
  <!DOCTYPE HTML>
  <html lang="ko">
  <head>
    <meta charset="UTF-8">
    <title>'||common.title||'</title> ');
    dbv_grid.print_env_rev;
    htp.p(' 
    <style type="text/css">
      html, body {
        width: 100%; 
        height: 100%; 
        margin: 0; 
        padding: 0; 
            cursor: pointer; 
            text-align: center; 
            line-height: 0; 
      }
        div { 
          width: 100%; 
          height: 100%; 
          overflow: auto; 
      }
    </style>     
    <script type="text/javascript">   
      function resizeWindow() {               
        self.moveTo(0,0);
        self.resizeTo(screen.availWidth, screen.availHeight);
      }

      $(document).ready(function(){
        $("img").on("load", function () {
          if(this.width > this.height){
            $("img").css("height","auto");
            $("img").css("width","100%");
          }else{
            $("img").css("height","100%");
            $("img").css("width","auto");
          }   
         });
      });
      window.onload = resizeWindow;
    </script>      
  </head>    
  <body>                
    <div id="Container"><img style="height:auto; width:100%;" id="Image" src="'||vault_download(p_linktypecd,p_linkid)||'" alt="" onclick="window.close();" ></div>
  </body>    
  </html>    
    ' ); 
  EXCEPTION
    when others then
      show_err('imageView');
  END imageView;
  
  PROCEDURE save_file_info
  (
    p_attachList in owa_util.vc_arr,
    p_linkid in varchar2 default null
  )
  IS
    v_cnt number;
    v_seq_sys_file number;
  BEGIN
    v_cnt := p_attachList.count;
    for i in 1..v_cnt loop
      v_seq_sys_file := seq_sys_file.nextval;
    
      insert into sys_file_upload (fileseq, filetypecd, filename, tempfilename, linktypecd, linkid
                                  ,contenttype, fullfilename, realfilename, activeflag,create_acc_no,create_date,filecomment, filesize, filepath)
      select v_seq_sys_file, filetypecd, filename, tempfilename, linktypecd, p_linkid
            ,contenttype, fullfilename, realfilename, activeflag, create_acc_no, create_date, filecomment, filesize
            ,get_premier_util || '/file/downloadFile.do?fileseq='||v_seq_sys_file||'&amp;filename='||tempfilename||'&amp;linktypecd='||linktypecd||'&amp;linkid='||urlencoder(p_linkid) filepath
      from sys_file_upload_temp
      where fileseq = p_attachlist(i);
      
      update sys_file_upload_temp 
      set linkid = p_linkid
      where fileseq = p_attachlist(i); 
    end loop;
  EXCEPTION
    when others then
      show_err('save_file_info');
  END save_file_info;
  
  PROCEDURE remove_file_info
  (
    p_linktypecd in varchar2 default null,
    p_linkid in varchar2 default null
  )
  IS
  BEGIN
    /** 임시첨부파일 LINKID 0 처리 **/
    begin
      update sys_file_upload_temp 
      set linkid = '0'
      where linktypecd = p_linktypecd
      and   linkid = p_linkid
      ;
    exception
      when others then
        show_err('SYS_FILE_UPLOAD_TEMP');
    end;
    
    begin
      delete from sys_file_upload
      where linktypecd = p_linktypecd
      and   linkid = p_linkid
      ;
    exception
      when others then
        show_err('SYS_FILE_UPLOAD');
    end;
    
  EXCEPTION
    when others then
      show_err('remove_file_info');
  END;
  
END COMMON;

/
