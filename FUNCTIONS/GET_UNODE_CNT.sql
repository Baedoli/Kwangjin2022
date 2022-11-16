--------------------------------------------------------
--  DDL for Function GET_UNODE_CNT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "PREMIER"."GET_UNODE_CNT" ( p_sysroot in varchar2, p_id IN VARCHAR2, p_lang in varchar2 )
RETURN VARCHAR2
IS
    cursor fnd_cnt is
    -- 자식노드 갯수
      select count(*)
      from(
              select id_ id, nvl(uid_,-1) uid_,uid_ uid__, 
                     decode(nvl(uid_,-1), -1, get_catalog_name('COM','SYSROOT_NM',p_lang ,p_sysroot), get_program_name(systemcd,pgmid,p_lang)) pnm, 
                     url, target, systemcd, pgmid, pgm_order, useyn, useyn_supply, premier_view,
                     (case when pgm_order = '1' then 'true' end) mnode
              from (
                       select b.id_, uid_, pgm_order, target, url, pgmid, a.systemcd, b.useyn, b.useyn_supply, b.premier_view
                       from   c_0040 a, c_0042 b
                       where  a.useyn = 'Y' 
                       and    (b.useyn = 'Y'
                       or
                       decode('premier','premier',b.premier_view,'N') ='Y')
                       and    a.id_ = b.id_
                       and    b.pgm_order is not null 
                       and      ( (common.get_cookie('systype') = '0' and a.id_ not in ('68','817')) or
                                  (common.get_cookie('systype') = '1' and 1=1)
                                )
                   ) a
              connect by prior id_=uid_
              start with id_= decode(p_sysroot,'996',decode(common.get_cookie('systype'),'1','68',p_sysroot),p_sysroot)
              ORDER SIBLINGS BY pgm_order
      )
      where uid_ = p_id
      ;
    v_cnt number := 0;
BEGIN

    open fnd_cnt;
    fetch fnd_cnt into v_cnt;
    if fnd_cnt%notfound then v_cnt := 0; end if;
    close fnd_cnt;

    return(v_cnt);
    
END GET_UNODE_CNT;

/
