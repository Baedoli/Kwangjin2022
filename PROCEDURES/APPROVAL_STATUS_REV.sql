--------------------------------------------------------
--  DDL for Procedure APPROVAL_STATUS_REV
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PREMIER"."APPROVAL_STATUS_REV" 
(
  p_doc_id in number default null,
  p_lang in varchar2 default common.get_cookie('SYSLANG')
)
AS
  cursor cur_approval_list_chk is
    select count(*)
    from wf_doc_roles
    where doc_id = p_doc_id
    ;
    
  v_approval_chk number;

  cursor cur_reference is
    select case when p_lang = 'KO' then 
             case when approval_jikck is not null then approval_jikck||' '||approval_nm else approval_nm end
           else approval_nm end as approval_user,
           x.*
    from (
          select get_master_name ('C_0010', a.emp_id, get_systype(a.com_id,a.emp_id), p_lang, a.com_id) as approval_nm,
--                 get_hr_jikck(a.com_id,a.emp_id) as approval_jikck,
                 '' as approval_jikck,
                 case when b.end_date is not null then '열람' else '도착' end approval_sign,
                 case when b.end_date is not null then '' else ' txtLightgray' end approval_css,
                 case when b.end_date is not null then to_char(b.end_date,'yyyy-mm-dd') else '' end as approval_ymd,
                 case when b.end_date is not null then to_char(b.end_date,'hh24:mi:ss') else '' end as approval_time,
                 a.* 
          from wf_doc_roles a, wf_activity b
          where 1=1
          and   a.doc_id = b.doc_id(+)
          and   a.emp_id = b.emp_id(+)
          and   a.doc_id = p_doc_id
          and   a.type_id = 1 
         ) x
    order by x.prior_id
    ;
    
  type r_r is table of cur_reference%rowtype index by pls_integer;
  rec_r r_r;
  
  cursor cur_approval is
    select z.*
    from (
          select 1 flag, 0 as prior_id,
                 case when p_lang = 'KO' then 
                   case when approval_jikck is not null then approval_jikck||' '||approval_nm else approval_nm end
                 else approval_nm end as approval_user,
                 '기안' as approval_sign,
                 '' as approval_css, 
                 to_char(x.start_date,'yyyy-mm-dd') as approval_ymd, 
                 to_char(x.start_date,'hh24:mi:ss') as approval_time, 
                 null as notes
          from (
--                select get_hr_jikck(a.com_id,a.emp_id) as approval_jikck,
                select '' as approval_jikck,
                       get_master_name ('C_0010', a.emp_id, get_systype(a.com_id,a.emp_id), p_lang, a.com_id) as approval_nm, a.*
                from wf_docs a
                where doc_id = p_doc_id
               ) x
          union all
          select 2 flag, x.prior_id,
                 case when p_lang = 'KO' then 
                   case when approval_jikck is not null then approval_jikck||' '||approval_nm else approval_nm end
                 else approval_nm end as approval_user,
                 x.approval_sign, x.approval_css, x.approval_ymd, x.approval_time, x.notes
          from (
                select get_master_name ('C_0010', a.emp_id, get_systype(a.com_id,a.emp_id), p_lang, a.com_id) as approval_nm,
--                       get_hr_jikck(a.com_id,a.emp_id) as approval_jikck,
                       '' as approval_jikck,
                       case when b.end_date is not null then '결재' 
                       else 
                         case when b.start_date is not null then '도착' else '' end  
                       end approval_sign,
                       case when b.end_date is not null then '' 
                       else 
                         case when b.start_date is not null then ' txtLightgray' else '' end  
                       end approval_css,
                       case when b.end_date is not null then 
                         to_char(b.end_date,'yyyy-mm-dd') 
                       else to_char(b.start_date,'yyyy-mm-dd')
                       end as approval_ymd,
                       case when b.end_date is not null then 
                         to_char(b.end_date,'hh24:mi:ss') 
                       else to_char(b.start_date,'hh24:mi:ss') 
                       end as approval_time,
                       b.end_date, b.notes,
                       a.* 
                from wf_doc_roles a, wf_activity b
                where 1=1
                and   a.doc_id = b.doc_id(+)
                and   a.emp_id = b.emp_id(+)
                and   a.doc_id = p_doc_id
                and   a.type_id = 0 
               ) x
         ) z
    order by z.flag, z.prior_id
    ;
    
  type r_a is table of cur_approval%rowtype index by pls_integer;
  rec_a r_a;
    
BEGIN

  open cur_approval_list_chk;
  fetch cur_approval_list_chk into v_approval_chk;
  if cur_approval_list_chk%notfound then v_approval_chk := 0; end if;
  close cur_approval_list_chk;
  
  if v_approval_chk > 9 then 
    owa_util.redirect_url('APPROVAL_STATUS_LIST?P_DOC_ID='||P_DOC_ID||'');
  end if;
  
  open cur_reference;
  fetch cur_reference bulk collect into rec_r;
  close cur_reference;
  
  open cur_approval;
  fetch cur_approval bulk collect into rec_a;
  close cur_approval;

htp.p('
<!DOCTYPE HTML>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title></title> 
  '); dbv_grid.print_env_rev; htp.p('         
  <script type="text/javascript">           
  </script>  
  <style type="text/css">
    body {
      background:#EFF4F9; 
    }         
  </style>    
</head>    
<body>                
  <div class="approvalWrap">
    <table border="1" cellpadding="0" cellspacing="0" bordercolor="#A7ACB1" style="float:left;">
      <tbody>
        <tr>
          <th rowspan="3">'||get_fn('참 조')||'</th>
          '); 
          if rec_r.count = 0 then 
            htp.p('<td class="approvalName"></td>');
          else
            for i in 1..rec_r.count loop htp.p('
              <td class="approvalName">'||rec_r(i).approval_user||'</td>
            '); 
            end loop; 
          end if;htp.p('
        </tr>
        <tr>
          '); 
          if rec_r.count = 0 then 
            htp.p('<td class="approvalSign"></td>');
          else
            for i in 1..rec_r.count loop htp.p('
            <!-- //sign은 향 후 적용하기..!
            <td><img src="../images/test_sign.png" alt="테스트이미지" class="approvalSign"></td>
            -->
            <td class="approvalSign'||rec_r(i).approval_css||'"><b>'||get_fn(rec_r(i).approval_sign)||'</b></td>
            '); end loop; 
          end if; htp.p('
        </tr>
        <tr>
          ');
          if rec_r.count = 0 then 
            htp.p('<td class="approvalDate"></td>');
          else 
            for i in 1..rec_r.count loop htp.p('
            <td class=" approvalDate'||rec_r(i).approval_css||'">'||rec_r(i).approval_ymd||'<br>'||rec_r(i).approval_time||'</td>
            '); end loop; 
          end if; htp.p('
        </tr>
      </tbody>
    </table>

    <table border="1" cellpadding="0" cellspacing="0" bordercolor="#A7ACB1" style="float:right;">
      <tbody>
        <tr>
          <th rowspan="3">'||get_fn('결 재')||'</th>
          '); 
          if rec_a.count = 0 then
            htp.p('<td class="approvalName"></td>');
          else
            for i in 1..rec_a.count loop htp.p('
            <td class="approvalName">'||rec_a(i).approval_user||'</td>
          '); end loop; 
          end if; htp.p('
        </tr>
        <tr>
          '); 
          if rec_a.count = 0 then
            htp.p('<td class="approvalSign"></td>');
          else
            for i in 1..rec_a.count loop htp.p('
            <!-- //sign은 향 후 적용하기..!
            <td><img src="../images/test_sign.png" alt="테스트이미지" class="approvalSign"></td>
            -->
            <td class="approvalSign'||rec_a(i).approval_css||'"><b>'||get_fn(rec_a(i).approval_sign)||'</b></td>
            '); 
            end loop; 
          end if; htp.p('
        </tr>
        <tr>
          '); 
          if rec_a.count = 0 then
            htp.p('<td class="approvalDate"></td>');
          else
            for i in 1..rec_a.count loop htp.p('
            <td class="approvalDate'||rec_a(i).approval_css||'">'||rec_a(i).approval_ymd||'<br>'||rec_a(i).approval_time||'</td>
            '); 
            end loop; 
          end if; htp.p('
        </tr>
      </tbody>
    </table>
    
  </div>    
</body>    
</html>    
'); 
EXCEPTION
  when others then
    show_err('APPROVAL_STATUS_REV');
END APPROVAL_STATUS_REV;

/
