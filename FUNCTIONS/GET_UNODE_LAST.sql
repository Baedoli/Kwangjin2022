--------------------------------------------------------
--  DDL for Function GET_UNODE_LAST
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "PREMIER"."GET_UNODE_LAST" ( p_sysroot in varchar2, p_uid IN VARCHAR2, p_lang in varchar2 )
RETURN VARCHAR2
IS
    cursor cur is 
        select max(pgm_order) pgm_order
        from(
                select id_ id, nvl(uid_,-1) uid_,uid_ uid__, pgm_gb, CONNECT_BY_ISLEAF AS LEAF,
                       decode(nvl(uid_,-1), -1, get_catalog_name('COM','SYSROOT_NM',p_lang,p_sysroot), get_program_name(systemcd,pgmid,p_lang)) pnm, 
                       url, target, systemcd, pgmid, pgm_order, useyn, --useyn_supply, premier_view
                       GET_UNODE_CNT(p_sysroot,id_,p_lang) as icnt
                from (
                         select a.pgm_gb, b.id_, uid_, pgm_order, target, url, pgmid, a.systemcd, b.useyn, b.useyn_supply, b.premier_view
                         from   c_0040 a, c_0042 b
                         where  a.useyn = 'Y' 
                         and      (b.useyn = 'Y'
                         or
                         decode('premier','premier',b.premier_view,'N') = 'Y')
                         and    a.id_ = b.id_
                         and    b.pgm_order is not null 
                         and      ( (common.get_cookie('systype') = '0' and a.id_ not in ('68','817')) or
                                    (common.get_cookie('systype') = '1' and 1=1)
                                  )
                ) a
                connect by prior id_=uid_
                start with id_= decode(p_sysroot,'996',decode(common.get_cookie('systype'),'1','996',p_sysroot),p_sysroot) 
                ORDER SIBLINGS BY pgm_order
        )
        where pgm_gb = 'P' 
        and   uid_ = p_uid
        ;
    v_1 varchar2(100);
    
BEGIN

    open cur;
    fetch cur into v_1;
    if cur%notfound then v_1 := ''; end if;
    close cur;

    return(v_1);
    
END GET_UNODE_LAST;

/
