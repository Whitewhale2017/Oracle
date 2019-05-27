
--------------创建三个新增对象的数据结构，可参考各自对应的传SAP日志表---------------------
create table SIPM170 as select * from SIPM190 where 1=2; --研发物料

create table BOM7 as select * from BOM10 where 1=2; --研发BOM

create table SIPM171 as select * from SIPM191 where 1=2; --研发工艺路线


----------------
select id,pbompkgid,pno,werks,cno,bnum
from PBOMLIB 
where pbompkgid = '01_6CC16A2F0C98EC28E050A8C08704144E'
order by pno,werks,cno

select * from pbompkg

select id from pbompkg where objtype='SIPM4' and regexp_like(objno,'^[DJP]T')----步骤一：判断研发工单
----------------------------------------------------------------------
create or replace function F_JSPBOMWSERKS(v_pbompkgid in varchar2) ---步骤二：计算PBOM根节点是否存在1001、1002工厂，如果存在则返回工厂号
return varchar2
as
 v_res varchar2(4);
begin
   select werks into v_res from (
        select 
        werks from PBOMLIB a
        where not exists (select 1 from PBOMLIB B where b.pbompkgid = v_pbompkgid and a.pbompkgid = b.pbompkgid and  a.pno = b.cno)
        and a.pbompkgid = v_pbompkgid
        group by pbompkgid,pno,werks
        ) t 
        where t.werks in ('1001','1002')
      ;
   return v_res;
 end; 
 -------------------------------------------------------------------
select no,werks from sipm190_last --- SIPM170
select * from PBOMLIB --- BOM7 用PBOMPKGID检索
select * from PROCESSLIB --- SIPM171 用PBOMPKGID检索
-------------------------------------------------------------------
---步骤三：1、扩展1806---------------------------------------------
select id,cno,werks,pno from sipm190_last where rownum<=10
select id,pbompkgid from partlib where rownum<=10

create or replace procedure proc_expand_1806(v_pbompkgid varchar2)
as
v_werks NVARCHAR2(4) --werks工厂
v_beskz NVARCHAR2(33) --beskz采购类型
v_sbdkz NVARCHAR2(33) --sbdkz 独立集中
v_berid NVARCHAR2(10) --mrp区域
v_dispr NVARCHAR2(10) --DISPR MRP参数文件
v_sobsl NVARCHAR2(33)  --SOBSL特殊采购类型
begin
  -----------------扩展SIPM170--------
  if exists(select 1 from wk_partlib where pbompkgid=v_pbompkgid) then
    begin
       
      end;
    else
      begin
        
    
/*        select pno as matnr from pbomlib where pbompkgid=v_pbompkgid and werks in ('1001','1801') group by pno
        union
        select cno as matnr from pbomlib where pbompkgid=v_pbompkgid and werks in ('1001','1801') group by cno*/

        
        --select id,pbompkgid,PUBLISHID,no as matnr,werks,BESKZ,SOBSL,SBDKZ from sipm190_last where rownum<=10 
        ---顺序一：---------------------------
        v_werks := '1806';
        v_beskz := 'E';
        v_sbdkz := '1';
        v_berid := 'NMRP_1806';
        v_dispr := 'SS01';
       insert into SIPM170 (publishtn, publishid, stn, sid, syncbatchno, syncdataitemno, syncuser, synctime, syncresult, syncmsg, 
       needsyncsign, fmaterialid, del, msym, wkaid, designno, bldesignno, no, name, ver, ptype, ename, 
       creator, ctime, muser, mtime, chkusr, chktime, duser, deltime, alteruser, owner, state, smemo, 
       pbompkgid, fromid, mtart, extwg, matkl, groes, spart, oldno, maktx, tdline, zind, unit, zvariant, 
       zmaktx, zsize, ztype, zcolor, zbranch, zauth, zrohs, zpackage, zpaper, zversion, zmanual, mstae, 
       mtpos, werks, classnum, classtype, numerator, denominatr, bstme, xchpf, kordb, ekgrp, ztdline1, vkorg, vtweg, ktgrm, aland, 
       tatyp, taxkm, mtpos1, tragr, ladgr, ztdline2, dismm, dispo, disls, bstrf, bstmi, berid, dispr, beskz, sobsl, rgekm, lgfsb, 
       lgpro, dzeit, plifz, webaz, fhori, eisbe, perkz, strgr, vrmod, vint1, vint2, miskz, mtvfp, kzaus, nfmat, sbdkz, fevor, co_prodprf, 
       mhdrz, mhdhb, loggr, lgnum, ltkze, qmatv, qpart, qmata, ssqss, ztdline3, bklas, eklas, qklas, mlast, peinh, vprsv, losgr, awsls, hrkft, 
       prctr, ekalr, hkmat, sobsk, zplp3, zpld3, sipm91id, sipm94id, sipm95id, sipm96id, sipm97id, sipm98id, ztime1, zdate, ztime2, zmsgtp2, 
       zmestx, prfrq, ausch ) 
       select   publishtn, publishid, stn, sid, syncbatchno, syncdataitemno, syncuser, synctime, syncresult, syncmsg, 
       needsyncsign, fmaterialid, del, msym, wkaid, designno, bldesignno, no, name, ver, ptype, ename, 
       creator, ctime, muser, mtime, chkusr, chktime, duser, deltime, alteruser, owner, state, smemo, 
       v_pbompkgid, fromid, mtart, extwg, matkl, groes, spart, oldno, maktx, tdline, zind, unit, zvariant, 
       zmaktx, zsize, ztype, zcolor, zbranch, zauth, zrohs, zpackage, zpaper, zversion, zmanual, mstae, 
       mtpos, v_werks, classnum, classtype, numerator, denominatr, bstme, xchpf, kordb, ekgrp, ztdline1, vkorg, vtweg, ktgrm, aland, 
       tatyp, taxkm, mtpos1, tragr, ladgr, ztdline2, dismm, dispo, disls, bstrf, bstmi, v_berid, v_dispr, v_beskz, sobsl, rgekm, lgfsb, 
       lgpro, dzeit, plifz, webaz, fhori, eisbe, perkz, strgr, vrmod, vint1, vint2, miskz, mtvfp, kzaus, nfmat, v_sbdkz, fevor, co_prodprf, 
       mhdrz, mhdhb, loggr, lgnum, ltkze, qmatv, qpart, qmata, ssqss, ztdline3, bklas, eklas, qklas, mlast, peinh, vprsv, losgr, awsls, hrkft, 
       prctr, ekalr, hkmat, sobsk, zplp3, zpld3, sipm91id, sipm94id, sipm95id, sipm96id, sipm97id, sipm98id, ztime1, zdate, ztime2, zmsgtp2, 
       zmestx, prfrq, ausch 
       from sipm190_last where id in 
       ( select id from v_sipm190_last_1806 where werks='1001' and beskz='E' and sbdkz='1' and no in 
             (select pno as matnr from pbomlib where pbompkgid=v_pbompkgid and werks in ('1001','1801') group by pno
               union
               select cno as matnr from pbomlib where pbompkgid=v_pbompkgid and werks in ('1001','1801') group by cno
              ) and no not in (select no from SIPM170 where pbompkgid=v_pbompkgid group by no)
        );
        
        
        -----顺序二：-----------------------------------------
        v_werks := '1806';
        v_beskz := 'E';
        v_sbdkz := '1';
        v_berid := 'NMRP_1806';
        v_dispr := 'SS01';
       insert into SIPM170(publishtn, publishid, stn, sid, syncbatchno, syncdataitemno, syncuser, synctime, syncresult, syncmsg, 
       needsyncsign, fmaterialid, del, msym, wkaid, designno, bldesignno, no, name, ver, ptype, ename, 
       creator, ctime, muser, mtime, chkusr, chktime, duser, deltime, alteruser, owner, state, smemo, 
       pbompkgid, fromid, mtart, extwg, matkl, groes, spart, oldno, maktx, tdline, zind, unit, zvariant, 
       zmaktx, zsize, ztype, zcolor, zbranch, zauth, zrohs, zpackage, zpaper, zversion, zmanual, mstae, 
       mtpos, werks, classnum, classtype, numerator, denominatr, bstme, xchpf, kordb, ekgrp, ztdline1, vkorg, vtweg, ktgrm, aland, 
       tatyp, taxkm, mtpos1, tragr, ladgr, ztdline2, dismm, dispo, disls, bstrf, bstmi, berid, dispr, beskz, sobsl, rgekm, lgfsb, 
       lgpro, dzeit, plifz, webaz, fhori, eisbe, perkz, strgr, vrmod, vint1, vint2, miskz, mtvfp, kzaus, nfmat, sbdkz, fevor, co_prodprf, 
       mhdrz, mhdhb, loggr, lgnum, ltkze, qmatv, qpart, qmata, ssqss, ztdline3, bklas, eklas, qklas, mlast, peinh, vprsv, losgr, awsls, hrkft, 
       prctr, ekalr, hkmat, sobsk, zplp3, zpld3, sipm91id, sipm94id, sipm95id, sipm96id, sipm97id, sipm98id, ztime1, zdate, ztime2, zmsgtp2, 
       zmestx, prfrq, ausch ) 
       select   publishtn, publishid, stn, sid, syncbatchno, syncdataitemno, syncuser, synctime, syncresult, syncmsg, 
       needsyncsign, fmaterialid, del, msym, wkaid, designno, bldesignno, no, name, ver, ptype, ename, 
       creator, ctime, muser, mtime, chkusr, chktime, duser, deltime, alteruser, owner, state, smemo, 
       v_pbompkgid, fromid, mtart, extwg, matkl, groes, spart, oldno, maktx, tdline, zind, unit, zvariant, 
       zmaktx, zsize, ztype, zcolor, zbranch, zauth, zrohs, zpackage, zpaper, zversion, zmanual, mstae, 
       mtpos, v_werks, classnum, classtype, numerator, denominatr, bstme, xchpf, kordb, ekgrp, ztdline1, vkorg, vtweg, ktgrm, aland, 
       tatyp, taxkm, mtpos1, tragr, ladgr, ztdline2, dismm, dispo, disls, bstrf, bstmi, v_berid, v_dispr, v_beskz, sobsl, rgekm, lgfsb, 
       lgpro, dzeit, plifz, webaz, fhori, eisbe, perkz, strgr, vrmod, vint1, vint2, miskz, mtvfp, kzaus, nfmat, v_sbdkz, fevor, co_prodprf, 
       mhdrz, mhdhb, loggr, lgnum, ltkze, qmatv, qpart, qmata, ssqss, ztdline3, bklas, eklas, qklas, mlast, peinh, vprsv, losgr, awsls, hrkft, 
       prctr, ekalr, hkmat, sobsk, zplp3, zpld3, sipm91id, sipm94id, sipm95id, sipm96id, sipm97id, sipm98id, ztime1, zdate, ztime2, zmsgtp2, 
       zmestx, prfrq, ausch 
       from sipm190_last where id in 
       ( select id from v_sipm190_last_1806 where werks='1001' and beskz='E' and sbdkz='1' and no in 
             (select pno as matnr from pbomlib where pbompkgid=v_pbompkgid and werks in ('1001','1801') group by pno
               union
               select cno as matnr from pbomlib where pbompkgid=v_pbompkgid and werks in ('1001','1801') group by cno
              ) and no not in (select no from SIPM170 where pbompkgid=v_pbompkgid group by no)
        )
        
        end;
     
end;


---步骤三：2、扩展1906---------------------------------------------


