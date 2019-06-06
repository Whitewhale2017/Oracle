create or replace procedure proc_expand_processlib_1806(v_pbompkgid varchar2,v_operator nvarchar2)
as
v_werks NVARCHAR2(4); --werks工厂
begin
        v_werks := '1806';
       ----全局扩展工艺路线 步骤一------
       insert into  SIPM171(id, partno
       , prcvno, macht, werks, plantext, zversion, verwe, statu, vornr, arbpl, frdlb, ekorg, matkl, ekgrp, sakto, steus, ltxa1, ltxa2, splim,
       zwnor, zeiwn, bmsch, meinh, umren, umrez, plnme, vgwrt01, vgwrteh01, vgwrt02, vgwrteh02, vgwrt03, vgwrteh03, vgwrt04, vgwrteh04, vgwrt05,
       vgwrteh05, vgwrt06, vgwrteh06,creator,owner)
       select '01_'||SYS_GUID(),partno
       , prcvno, macht, t.werks, plantext, zversion, verwe, statu, vornr, arbpl, frdlb, ekorg, matkl, ekgrp, sakto, steus, ltxa1, ltxa2, splim,
       zwnor, zeiwn, bmsch, meinh, umren, umrez, plnme, vgwrt01, vgwrteh01, vgwrt02, vgwrteh02, vgwrt03, vgwrteh03, vgwrt04, vgwrteh04, vgwrt05,
       vgwrteh05, vgwrt06, vgwrteh06,v_operator,v_operator
       from  processlib a
       left join (
       select no,werks,BESKZ,sbdkz,sobsl from sipm94
       where not exists(select 1 from wk_sipm94 a where sipm94.no=a.no and sipm94.werks=a.werks) and  werks = '1001'
       union
       select  no,werks,BESKZ,sbdkz,sobsl from sipm190_last
       where not exists(select 1 from wk_sipm94 a where sipm190_last.no=a.no and sipm190_last.werks=a.werks) and  werks = '1001'
       union
       select no,werks,BESKZ,sbdkz,sobsl from wk_sipm94 where werks = '1001'
       ) t
        on t.no=a.partno and t.werks=a.werks
        where a.pbompkgid=v_pbompkgid and a.werks='1001' 
       and 
       ((t.beskz='E' and t.sbdkz='1')
       or
       (t.beskz='E' and t.sbdkz='2' and t.sobsl is null)
       or
       (t.beskz='E' and t.sbdkz='2' and t.sobsl='50')
       or
       (t.beskz='X' and t.sbdkz='2' and t.sobsl is null)
       )
       ;
       
 ----全局扩展工艺路线 步骤二------
       insert into  SIPM171(id, partno
       , prcvno, macht, werks, plantext, zversion, verwe, statu, vornr, arbpl, frdlb, ekorg, matkl, ekgrp, sakto, steus, ltxa1, ltxa2, splim,
       zwnor, zeiwn, bmsch, meinh, umren, umrez, plnme, vgwrt01, vgwrteh01, vgwrt02, vgwrteh02, vgwrt03, vgwrteh03, vgwrt04, vgwrteh04, vgwrt05,
       vgwrteh05, vgwrt06, vgwrteh06,creator,owner)
       select '01_'||SYS_GUID(),partno
       , prcvno, macht, t.werks, plantext, zversion, verwe, statu, vornr, arbpl, frdlb, ekorg, matkl, ekgrp, sakto, steus, ltxa1, ltxa2, splim,
       zwnor, zeiwn, bmsch, meinh, umren, umrez, plnme, vgwrt01, vgwrteh01, vgwrt02, vgwrteh02, vgwrt03, vgwrteh03, vgwrt04, vgwrteh04, vgwrt05,
       vgwrteh05, vgwrt06, vgwrteh06,v_operator,v_operator
       from  sipm191_last a
       left join (
       select no,werks,BESKZ,sbdkz,sobsl from sipm94
       where not exists(select 1 from wk_sipm94 a where sipm94.no=a.no and sipm94.werks=a.werks) and  werks = '1001'
       union
       select  no,werks,BESKZ,sbdkz,sobsl from sipm190_last
       where not exists(select 1 from wk_sipm94 a where sipm190_last.no=a.no and sipm190_last.werks=a.werks) and  werks = '1001'
       union
       select no,werks,BESKZ,sbdkz,sobsl from wk_sipm94 where werks = '1001'
       ) t
        on t.no=a.partno and t.werks=a.werks
       where 
       a.werks='1001' 
       and 
       ((t.beskz='E' and t.sbdkz='1')
       or
       (t.beskz='E' and t.sbdkz='2' and t.sobsl is null)
       or
       (t.beskz='E' and t.sbdkz='2' and t.sobsl='50')
       or
       (t.beskz='X' and t.sbdkz='2' and t.sobsl is null)
       )
       and t.no in
             (select pno as matnr from pbomlib where pbompkgid=v_pbompkgid and werks in ('1001','1801') group by pno
              )  and t.no not in (select partno from SIPM171 where pbompkgid = v_pbompkgid);
      -- dbms_output.put_line(to_char(sysdate,'yyyy-mm-dd hh24:mi:ss'));
end;
/
