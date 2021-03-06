
--------------创建三个新增对象的数据结构，可参考各自对应的传SAP日志表---------------------
create table SIPM170 as select * from SIPM190 where 1=2; --研发物料

select * from SIPM170;

create table BOM7 as select * from BOM10 where 1=2; --研发BOM

create table SIPM171 as select * from SIPM191 where 1=2; --研发工艺路线

CREATE global temporary TABLE "SSPLM"."TEMP_WK_PARTLIB" 
   (  "ID" VARCHAR2(50) NOT NULL ENABLE, 
  "PUBLISHTN" NVARCHAR2(50), 
  "PUBLISHID" VARCHAR2(50), 
  "STN" NVARCHAR2(50), 
  "SID" VARCHAR2(50), 
  "SYNCBATCHNO" NVARCHAR2(50), 
  "SYNCDATAITEMNO" NVARCHAR2(200), 
  "SYNCUSER" NVARCHAR2(50), 
  "SYNCTIME" TIMESTAMP (6), 
  "SYNCRESULT" NVARCHAR2(50), 
  "SYNCMSG" NVARCHAR2(1000), 
  "NEEDSYNCSIGN" NVARCHAR2(50), 
  "FMATERIALID" VARCHAR2(50), 
  "DEL" NUMBER(1,0), 
  "MSYM" VARCHAR2(1), 
  "WKAID" VARCHAR2(50), 
  "DESIGNNO" VARCHAR2(50), 
  "BLDESIGNNO" VARCHAR2(50), 
  "NO" NVARCHAR2(50), 
  "NAME" NVARCHAR2(36), 
  "VER" NVARCHAR2(10), 
  "PTYPE" NVARCHAR2(50), 
  "ENAME" NVARCHAR2(200), 
  "CREATOR" VARCHAR2(50), 
  "CTIME" TIMESTAMP (6), 
  "MUSER" VARCHAR2(50), 
  "MTIME" TIMESTAMP (6), 
  "CHKUSR" VARCHAR2(50), 
  "CHKTIME" TIMESTAMP (6), 
  "DUSER" VARCHAR2(50), 
  "DELTIME" TIMESTAMP (6), 
  "ALTERUSER" VARCHAR2(50), 
  "OWNER" VARCHAR2(100), 
  "STATE" VARCHAR2(1), 
  "SMEMO" NVARCHAR2(200), 
  "PBOMPKGID" NVARCHAR2(50), 
  "FROMID" NVARCHAR2(50), 
  "MTART" NVARCHAR2(4), 
  "EXTWG" NVARCHAR2(18), 
  "MATKL" NVARCHAR2(100), 
  "GROES" NVARCHAR2(32), 
  "SPART" NVARCHAR2(2), 
  "OLDNO" NVARCHAR2(100), 
  "MAKTX" NVARCHAR2(40), 
  "TDLINE" NVARCHAR2(500), 
  "ZIND" NVARCHAR2(2), 
  "UNIT" NVARCHAR2(3), 
  "ZVARIANT" NVARCHAR2(18), 
  "ZMAKTX" NVARCHAR2(40), 
  "ZSIZE" NVARCHAR2(100), 
  "ZTYPE" NVARCHAR2(100), 
  "ZCOLOR" NVARCHAR2(100), 
  "ZBRANCH" NVARCHAR2(100), 
  "ZAUTH" NVARCHAR2(100), 
  "ZROHS" NVARCHAR2(4), 
  "ZPACKAGE" NVARCHAR2(100), 
  "ZPAPER" NVARCHAR2(100), 
  "ZVERSION" NVARCHAR2(100), 
  "ZMANUAL" NVARCHAR2(100), 
  "MSTAE" NVARCHAR2(2), 
  "MTPOS" NVARCHAR2(4), 
  "WERKS" NVARCHAR2(4), 
  "CLASSNUM" NVARCHAR2(18), 
  "CLASSTYPE" NVARCHAR2(18), 
  "NUMERATOR" NUMBER(5,0), 
  "DENOMINATR" NUMBER(5,0), 
  "BSTME" NVARCHAR2(3), 
  "XCHPF" NVARCHAR2(3), 
  "KORDB" NVARCHAR2(3), 
  "EKGRP" NVARCHAR2(3), 
  "ZTDLINE1" NVARCHAR2(500), 
  "VKORG" NVARCHAR2(1000), 
  "VTWEG" NVARCHAR2(200), 
  "KTGRM" NVARCHAR2(33), 
  "ALAND" NVARCHAR2(3), 
  "TATYP" NVARCHAR2(4), 
  "TAXKM" NVARCHAR2(33), 
  "MTPOS1" NVARCHAR2(4), 
  "TRAGR" NVARCHAR2(4), 
  "LADGR" NVARCHAR2(4), 
  "ZTDLINE2" NVARCHAR2(500), 
  "DISMM" NVARCHAR2(33), 
  "DISPO" NVARCHAR2(30), 
  "DISLS" NVARCHAR2(33), 
  "BSTRF" NUMBER(13,0), 
  "BSTMI" NUMBER(13,0), 
  "BERID" NVARCHAR2(1000), 
  "DISPR" NVARCHAR2(1000), 
  "BESKZ" NVARCHAR2(33), 
  "SOBSL" NVARCHAR2(33), 
  "RGEKM" NVARCHAR2(33), 
  "LGFSB" NVARCHAR2(4), 
  "LGPRO" NVARCHAR2(4), 
  "DZEIT" NUMBER(3,0), 
  "PLIFZ" NUMBER(3,0), 
  "WEBAZ" NUMBER(3,0), 
  "FHORI" NVARCHAR2(3), 
  "EISBE" NUMBER(13,0), 
  "PERKZ" NVARCHAR2(33), 
  "STRGR" NVARCHAR2(33), 
  "VRMOD" NVARCHAR2(33), 
  "VINT1" NUMBER(3,0), 
  "VINT2" NVARCHAR2(3), 
  "MISKZ" NVARCHAR2(33), 
  "MTVFP" NVARCHAR2(33), 
  "KZAUS" NVARCHAR2(33), 
  "NFMAT" NVARCHAR2(33), 
  "SBDKZ" NVARCHAR2(33), 
  "FEVOR" NVARCHAR2(30), 
  "CO_PRODPRF" NVARCHAR2(60), 
  "MHDRZ" NUMBER(4,0), 
  "MHDHB" NUMBER(4,0), 
  "LOGGR" NVARCHAR2(4), 
  "LGNUM" NVARCHAR2(3), 
  "LTKZE" NVARCHAR2(3), 
  "QMATV" NVARCHAR2(33), 
  "QPART" NVARCHAR2(11), 
  "QMATA" NVARCHAR2(60), 
  "SSQSS" NVARCHAR2(8), 
  "ZTDLINE3" NVARCHAR2(132), 
  "BKLAS" NVARCHAR2(4), 
  "EKLAS" NVARCHAR2(4), 
  "QKLAS" NVARCHAR2(4), 
  "MLAST" NVARCHAR2(3), 
  "PEINH" NUMBER(5,0), 
  "VPRSV" NVARCHAR2(33), 
  "LOSGR" NUMBER(13,0), 
  "AWSLS" NVARCHAR2(6), 
  "HRKFT" NVARCHAR2(4), 
  "PRCTR" NVARCHAR2(10), 
  "EKALR" NVARCHAR2(33), 
  "HKMAT" NVARCHAR2(33), 
  "SOBSK" NVARCHAR2(33), 
  "ZPLP3" NUMBER(18,6), 
  "ZPLD3" NVARCHAR2(8), 
  "SIPM91ID" VARCHAR2(50), 
  "SIPM94ID" VARCHAR2(50), 
  "SIPM95ID" VARCHAR2(50), 
  "SIPM96ID" VARCHAR2(50), 
  "SIPM97ID" VARCHAR2(50), 
  "SIPM98ID" VARCHAR2(50), 
  "ZTIME1" NVARCHAR2(50), 
  "ZDATE" NVARCHAR2(8), 
  "ZTIME2" NVARCHAR2(6), 
  "ZMSGTP2" NVARCHAR2(1), 
  "ZMESTX" NVARCHAR2(150), 
  "PRFRQ" NUMBER(5,0), 
  "AUSCH" NUMBER(5,2),
  "ORDERNUM" NUMBER(9)
   )
   on commit delete rows ;---创建事务临时表TEMP_WK_PARTLIB存储工作区某pbompkgid的数据记录
   
   drop table TEMP_WK_PARTLIB;
----------------
select id,pbompkgid,pno,werks,cno,bnum
from PBOMLIB 
where pbompkgid = '01_6CC16A2F0C98EC28E050A8C08704144E'
order by pno,werks,cno

select * from pbompkg

select id from pbompkg where objtype='SIPM4' and regexp_like(objno,'^[DJP][YR]')----步骤一：判断研发工单
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
 
 select F_JSPBOMWSERKS('01_6CC16A2F0C98EC28E050A8C08704144E') from dual
 -------------------------------------------------------------------
select no,werks from sipm190_last --- SIPM170
select * from PBOMLIB --- BOM7 用PBOMPKGID检索
select * from PROCESSLIB --- SIPM171 用PBOMPKGID检索
-------------------------------------------------------------------
create or replace procedure proc_expand_main(v_pbompkgid varchar2,v_operator nvarchar2) ----扩展主程序
as 
r_werks NVARCHAR2(4); 
begin
  select F_JSPBOMWSERKS(v_v_pbompkgid) into r_werks from dual;
if exists(select id from pbompkg where objtype='SIPM4' and regexp_like(objno,'^[DJP][YR]') and pbompkgid= v_pbompkgid) then
      if  r_werks ='1001' or  r_werks ='1002' then 
---步骤三：1、扩展1806---------------------------------------------
          proc_expand_1806(v_pbompkgid);
        --proc_expand_1906(v_pbompkgid);
          commit;
          else 
            return;
        end if;
else
          return;
 end if;
end;

---步骤三：2、扩展1906---------------------------------------------


