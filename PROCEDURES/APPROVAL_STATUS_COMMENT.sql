--------------------------------------------------------
--  DDL for Procedure APPROVAL_STATUS_COMMENT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PREMIER"."APPROVAL_STATUS_COMMENT" 
(
  p_doc_id in number default null,
  p_lang in varchar2 default common.get_cookie('SYSLANG')
)
AS
  cursor cur is
    select z.*
    from (
          select 1 flag, 0 as type_id, 0 as prior_id,  999 as role_id,
                 case when p_lang = 'KO' then 
                   case when approval_jikck is not null then approval_jikck||'  '||approval_nm else approval_nm end
                 else approval_nm end as approval_user,
                 '기안' as approval_sign,
                 to_char(x.start_date,'yyyy-mm-dd hh24:mi:ss') as approval_time, 
                 null as notes
          from (
--                select get_hr_jikck(a.com_id,a.emp_id) as approval_jikck,
                select '' as approval_jikck,
                       get_master_name ('C_0010', a.emp_id, get_systype(a.com_id,a.emp_id), p_lang, a.com_id) as approval_nm, a.*
                from wf_docs a
                where doc_id = p_doc_id
               ) x           
          union all
          select 2 flag, x.type_id, x.prior_id, x.role_id,
                 case when p_lang = 'KO' then 
                   case when approval_jikck is not null then approval_jikck||'  '||approval_nm else approval_nm end
                 else approval_nm end as approval_user,
                 x.approval_sign, x.approval_time, x.notes
          from (
                select get_master_name ('C_0010', a.emp_id, get_systype(a.com_id,a.emp_id), p_lang, a.com_id) as approval_nm,
--                       get_hr_jikck(a.com_id,a.emp_id) as approval_jikck,
                       '' as approval_jikck,
                       case when b.end_date is not null then 
                         case when a.type_id = '1' then '열람' else '결재' end 
                       else 
                         case when b.start_date is not null then '도착' else '' end  
                       end approval_sign,
                       case when b.end_date is not null then 
                         to_char(b.end_date,'yyyy-mm-dd hh24:mi:ss') 
                       else 
                         case when a.type_id = '1' then '' else to_char(b.start_date,'yyyy-mm-dd hh24:mi:ss') end 
                       end as approval_time,
                       b.end_date, b.notes,
                       a.* 
                from wf_doc_roles a, wf_activity b
                where 1=1
                and   a.doc_id = b.doc_id(+)
                and   a.emp_id = b.emp_id(+)
                and   a.doc_id = p_doc_id
               ) x
         ) z
    order by z.flag, z.type_id, z.prior_id
    ;
      
    type r is table of cur%rowtype index by pls_integer;
    rec r;
    
    v_number number := 0 ;
      
BEGIN

  open cur;
  fetch cur bulk collect into rec;
  close cur;

htp.p('
  <!DOCTYPE html">
  <html lang="ko">
    <head>
      <title></title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta http-equiv="Content-Type" content="application/xhtml+xml; charset=utf-8" />  ');
        dbv_grid.print_env_v451;
        htp .p('
        <script type="text/javascript">
        
        var data={ rows:[ ');
        
        v_number := rec.count;
        
        for i in 1 .. v_number loop

          htp .p('
          { id:' ||i|| ',
            data:[
              {value:"'||get_catalog_name('COM','WF_ROLES',p_lang,rec(i).role_id)||'"},
              {value:"'||rec(i).approval_user||'"},
              {value:"'||rec(i).approval_sign||'"},
              {value:"'||rec(i).approval_time||'"},
              {value:"'||return_html_text(rec(i).notes)||'"}
            ]
          } ');
          
          if i < v_number then
            htp .p(',');
          end if;
          
        end loop;
        
        if v_number = 0 then
          htp .p('{ id:1, data:[ "" ] }');
        end if;
        
        htp .p('
          ]
        }
        
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
        
        x[i]=["'||get_fn('구분')||'", "80","center","ro","str","true"];i++;
        x[i]=["'||get_fn('결재자')||'", "120","left","ro","str","true"];i++;
        x[i]=["'||get_fn('결재상태')||'", "80","center","ro","str","true"];i++;
        x[i]=["'||get_fn('결재일자')||'", "140","center","ro","str","true"];i++;
        x[i]=["'||get_fn('결재의견')||'", "*","left","ro","str","true"];i++;
        
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
        mygrid.parse(data, "json");
        //parent.myLayout.cells("a").progressOff();
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
  when others then
    show_err('APPROVAL_STATUS_COMMENT');
END APPROVAL_STATUS_COMMENT;

/
