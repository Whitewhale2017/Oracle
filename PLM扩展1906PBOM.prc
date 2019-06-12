create or replace procedure proc_expand_pbom_1906(v_pbompkgid varchar2,v_operator nvarchar2)
as
v_werks NVARCHAR2(4); --werks工厂
begin
        v_werks := '1906';
         -----------全局扩展P-BOM---------------
       insert into bom7(id, no, name, ename, pno, bompst, cno, bnum, pbompkgid, bomver, werks, routeno,
       pspnr, zcomplete, emeng, postp, ausch, alpgr, zkey, zposition, sanka, smemo, ztext, plant, bwz, pwlms, cwlms, xncp,creator,owner )
       select '01_'||SYS_GUID() id,t.no, name, ename, pno, bompst, cno, bnum, pbompkgid, bomver, v_werks, routeno,
       pspnr, zcomplete, emeng, postp, ausch, alpgr, zkey, zposition, sanka, smemo, ztext, plant, bwz, pwlms, cwlms, xncp,v_operator,v_operator
       from pbomlib a
       inner join (
        select no,werks,BESKZ,sbdkz,sobsl,nfwerks from sipm170 where pbompkgid=v_pbompkgid
       ) t
       on t.no=a.pno and t.nfwerks=a.werks
       where a.pbompkgid=v_pbompkgid and a.werks='1002'
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
       commit;
     -- dbms_output.put_line(to_char(sysdate,'yyyy-mm-dd hh24:mi:ss'))；
  end;
/
