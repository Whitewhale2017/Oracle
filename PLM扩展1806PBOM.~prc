create or replace procedure proc_expand_pbom_1806(v_pbompkgid varchar2,v_operator nvarchar2)
as
v_werks NVARCHAR2(4); --werks工厂
begin    
        v_werks := '1806';
         -----------全局扩展P-BOM---------------
       insert into bom7(id, no, name, ename, pno, bompst, cno, bnum, pbompkgid, bomver, werks, routeno,
       pspnr, zcomplete, emeng, postp, ausch, alpgr, zkey, zposition, sanka, smemo, ztext, plant, bwz, pwlms, cwlms, xncp,creator,owner )
       select '01_'||SYS_GUID() id,t.no, name, ename, pno, bompst, cno, bnum, pbompkgid, bomver, v_werks, routeno,
       pspnr, zcomplete, emeng, postp, ausch, alpgr, zkey, zposition, sanka, smemo, ztext, plant, bwz, pwlms, cwlms, xncp,v_operator,v_operator
       from pbomlib a
       left join (
       select no,werks,BESKZ,sbdkz,sobsl from sipm94
       where not exists(select 1 from wk_sipm94 a where sipm94.no=a.no and sipm94.werks=a.werks) and  werks = '1001'
       union
       select  no,werks,BESKZ,sbdkz,sobsl from sipm190_last
       where not exists(select 1 from wk_sipm94 a where sipm190_last.no=a.no and sipm190_last.werks=a.werks) and  werks = '1001'
       union
       select no,werks,BESKZ,sbdkz,sobsl from wk_sipm94 where werks = '1001'
       ) t
       on t.no=a.pno and t.werks=a.werks
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
     -- dbms_output.put_line(to_char(sysdate,'yyyy-mm-dd hh24:mi:ss'))；
  end;
/
