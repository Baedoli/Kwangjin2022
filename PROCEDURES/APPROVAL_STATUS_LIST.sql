--------------------------------------------------------
--  DDL for Procedure APPROVAL_STATUS_LIST
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PREMIER"."APPROVAL_STATUS_LIST" 
(
  p_doc_id in number default null,
  p_lang in varchar2 default common.get_cookie('SYSLANG')
)
AS
  cursor cur_reference is
    select case when p_lang = 'KO' then 
             case when approval_jikck is not null then approval_jikck||'  '||approval_nm else approval_nm end
           else approval_nm end as approval_user,
           x.*
    from (
          select get_master_name ('C_0010', a.emp_id, get_systype(a.com_id,a.emp_id), p_lang, a.com_id) as approval_nm,
--                 get_hr_jikck(a.com_id,a.emp_id) as approval_jikck,
                 '' as approval_jikck,
                 case when b.end_date is not null then '열람' else '도착' end approval_sign,
                 case when b.end_date is not null then ' aprv_yellow' else ' aprv_gray' end approval_css,
                 case when b.end_date is not null then 'aprv_date' else '' end approval_css_time,
                 case when b.end_date is not null then to_char(b.end_date,'yyyy.mm.dd') else '' end as approval_ymd,
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
                   case when approval_jikck is not null then approval_jikck||'  '||approval_nm else approval_nm end
                 else approval_nm end as approval_user,
                 '기안' as approval_sign,
                 ' aprv_blue' as approval_css, 
                 '' as approval_css_time,
                 to_char(x.start_date,'yyyy.mm.dd') as approval_ymd, 
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
                   case when approval_jikck is not null then approval_jikck||'  '||approval_nm else approval_nm end
                 else approval_nm end as approval_user,
                 x.approval_sign, x.approval_css, x.approval_css_time, x.approval_ymd, x.approval_time, x.notes
          from (
                select get_master_name ('C_0010', a.emp_id, get_systype(a.com_id,a.emp_id), p_lang, a.com_id) as approval_nm,
--                       get_hr_jikck(a.com_id,a.emp_id) as approval_jikck,
                       '' as approval_jikck,
                       case when b.end_date is not null then '결재' 
                       else 
                         case when b.start_date is not null then '도착' else '' end  
                       end approval_sign,
                       case when b.end_date is not null then ' aprv_green' 
                       else 
                         case when b.start_date is not null then ' aprv_gray' else '' end  
                       end approval_css,
                       case when b.end_date is not null then '' 
                       else 
                         case when b.start_date is not null then ' txtLightgray' else '' end  
                       end approval_css_time,
                       case when b.end_date is not null then 
                         to_char(b.end_date,'yyyy.mm.dd') 
                       else to_char(b.start_date,'yyyy.mm.dd')
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
  <div class="approvalList">
    <!--참조-->
    <div class="aprvBox">
      <div class="aprvTxt aprvTxt1"><span>'||get_fn('참조')||'</span></div>
      <div>
        <ul>
        '); for i in 1..rec_r.count loop htp.p(' 
          <li>
            <span class="aprv_name">'||rec_r(i).approval_user||'</span>
            <span class="'||rec_r(i).approval_css_time||'">'||rec_r(i).approval_ymd||'&nbsp;&nbsp;'||rec_r(i).approval_time||'</span>
            <span class="aprv_state'||rec_r(i).approval_css||'">'||get_fn(rec_r(i).approval_sign)||'</span>
          </li>
        '); end loop; htp.p('
        </ul>
      </div>
    </div>
    <!--결재-->
    <div class="aprvBox">
      <div class="aprvTxt aprvTxt2"><span>'||get_fn('결재')||'</span></div>
      <div>
        <ul>
        '); for i in 1..rec_a.count loop htp.p('
          <li>
            <span class="aprv_name">'||rec_a(i).approval_user||'</span>
            <span class="aprv_date'||rec_a(i).approval_css_time||'">'||rec_a(i).approval_ymd||'&nbsp;&nbsp;'||rec_a(i).approval_time||'</span>
            <span class="aprv_state'||rec_a(i).approval_css||'">'||get_fn(rec_a(i).approval_sign)||'</span>
          </li>
        '); end loop; htp.p('  
        </ul>
      </div>
    </div>
  </div>  
</body>    
</html>    
'); 
EXCEPTION
  when others then
    show_err('APPROVAL_STATUS_LIST');
END APPROVAL_STATUS_LIST;

/
