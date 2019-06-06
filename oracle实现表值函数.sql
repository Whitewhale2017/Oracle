
create table tb1(k number, v varchar2(10));  
 
insert into tb1(k, v) values(100,'aaa');  
insert into tb1(k, v) values(200,'bbb');  
insert into tb1(k, v) values(200,'ccc');  
 
select * from tb1;  
 ------------------------------------------------
create type row_type1 as object(k number, v varchar2(10));  

 
create type table_type1 as table of row_type1;  

------删除类型----

drop type table_type1; --先删除table类型
drop type row_type1; --在删除行类型，否row_type1被table_type1引用，无法删除
 
create or replace function fun1(v_in varchar2)
return table_type1 
pipelined as  
v row_type1;  
begin  
for myrow in (select k, v from tb1 where v=v_in ) loop  
  v := row_type1(myrow.k, myrow.v);  
  pipe row (v);  
end loop;  
return;  
end;  

select * from table(fun1('aaa'));  

---------------------------------------------------------------------------

create type SIPM190_table_type1 as table of SIPM190_row_type1; --第二步；

create or replace function SIPM190_PARTLIB_READ(v_pbompkgid varchar2)
return SIPM190_table_type1 
pipelined as  
res SIPM190_row_type1;  
begin  
for myrow in (
  select id,publishid,sid,syncdataitemno,syncuser
        ,MTART,EXTWG,MATKL,GROES,SPART,OLDNO,NO,MAKTX,TDLINE,ZIND,UNIT,ZVARIANT,ZMAKTX,ZSIZE,ZTYPE,ZCOLOR,ZBRANCH,ZAUTH,ZROHS,ZPACKAGE,ZPAPER,ZVERSION,ZMANUAL,MSTAE,MTPOS,WERKS
        ,CLASSNUM,CLASSTYPE,NUMERATOR,DENOMINATR,BSTME,XCHPF,KORDB,EKGRP,ZTDLINE1
        ,VKORG,VTWEG,KTGRM,ALAND,TATYP,TAXKM,MTPOS1,TRAGR,LADGR,ZTDLINE2
        ,DISMM,DISPO,DISLS,BSTRF,BSTMI,BERID,DISPR
        ,BESKZ,SOBSL,RGEKM,LGFSB,LGPRO,DZEIT,PLIFZ,WEBAZ,FHORI,EISBE,PERKZ,STRGR,VRMOD,VINT1,VINT2,MISKZ,MTVFP,KZAUS,NFMAT,SBDKZ
        ,FEVOR,CO_PRODPRF
        ,MHDRZ,MHDHB,LOGGR,LGNUM,LTKZE
        ,QMATV,QPART,QMATA,SSQSS,ZTDLINE3,PRFRQ
        ,BKLAS,EKLAS,QKLAS,MLAST,PEINH,VPRSV,LOSGR,AWSLS,HRKFT,PRCTR,EKALR,HKMAT,SOBSK,ZPLP3,ZPLD3
        ,ZTIME1,AUSCH
   from sipm190_last
   union all
   SELECT '01_'||SYS_GUID() id ,'01_712D7C16EAEB4504E050A8C0870453D4',t1.id sid,t1.NO,null as username,
        TB.MTART,TB.EXTWG,TB.MATKL,TB.GROES,TB.SPART,TB.OLDNO AS ZBISMT,TB.NO AS MATNR,TB.MAKTX,TB.TDLINE,TB.ZIND,TB.UNIT AS MEINS,
        TB.ZVARIANT,TB.ZMAKTX,TB.ZSIZE,
        TB.ZTYPE,TB.ZCOLOR,TB.ZBRANCH,TB.ZAUTH,TB.ZROHS,TB.ZPACKAGE,TB.ZPAPER,TB.ZVERSION,TB.ZMANUAL,TB.MSTAE,TB.MTPOS,TB.WERKS,
        T1.CLASSNUM,T1.CLASSTYPE,T1.NUMERATOR,T1.DENOMINATR,T1.BSTME,T1.XCHPF,T1.KORDB,T1.EKGRP,TB.TDLINE,
        T2.VKORG,T2.VTWEG,T2.KTGRM,T2.ALAND,T2.TATYP,T2.TAXKM,T2.MTPOS1,T2.TRAGR,T2.LADGR,TB.TDLINE,
        T3.DISMM,T3.DISPO,T3.DISLS,T3.BSTRF,T3.BSTMI,T3.BERID,T3.DISPR,
        T4.BESKZ,T4.SOBSL,T4.RGEKM,T4.LGFSB,T4.LGPRO,T4.DZEIT,T4.PLIFZ,T4.WEBAZ,T4.FHORI,T4.EISBE,T4.PERKZ,T4.STRGR,T4.VRMOD,T4.VINT1
        ,T4.VINT2,T4.MISKZ,T4.MTVFP,T4.KZAUS,T4.NFMAT,T4.SBDKZ,
        T5.FEVOR,T5.CO_PRODPRF,
        T6.MHDRZ,T6.MHDHB,T6.LOGGR,T6.LGNUM,T6.LTKZE,
        T7.QMATV,T7.QPART,T7.QMATA,T7.SSQSS,T7.ZTDLINE3,T7.PRFRQ,
        T8.BKLAS,T8.EKLAS,T8.QKLAS,T8.MLAST,T8.PEINH,T8.VPRSV,T8.LOSGR,T8.AWSLS,T8.HRKFT,T8.PRCTR,T8.EKALR,T8.HKMAT,T8.SOBSK
        ,ROUND(T8.ZPLP3*T8.PEINH,6),T8.ZPLD3,
        null as v_syncbatchno,
        TB.AUSCH
    FROM WK_PARTLIB TB
    LEFT JOIN WK_SIPM91_OBJOF T1O ON TB.ID = T1O.ITEMID1 AND T1O.DEL=0 AND T1O.WKAID<>'3'
    LEFT JOIN WK_SIPM91 T1 ON T1O.ITEMID2 = T1.ID AND T1.DEL=0 AND T1.WKAID<>'3'
    LEFT JOIN WK_SIPM92_OBJOF T2O ON TB.ID = T2O.ITEMID1 AND T2O.DEL=0 AND T2O.WKAID<>'3'
    LEFT JOIN WK_SIPM92 T2 ON T2O.ITEMID2 = T2.ID AND T2.DEL=0 AND T2.WKAID<>'3'
    LEFT JOIN WK_SIPM93_OBJOF T3O ON TB.ID = T3O.ITEMID1 AND T3O.DEL=0 AND T3O.WKAID<>'3'
    LEFT JOIN WK_SIPM93 T3 ON T3O.ITEMID2 = T3.ID AND T3.DEL=0 AND T3.WKAID<>'3'
    LEFT JOIN WK_SIPM94_OBJOF T4O ON TB.ID = T4O.ITEMID1 AND T4O.DEL=0 AND T4O.WKAID<>'3'
    LEFT JOIN WK_SIPM94 T4 ON T4O.ITEMID2 = T4.ID AND T4.DEL=0 AND T4.WKAID<>'3'
    LEFT JOIN WK_SIPM95_OBJOF T5O ON TB.ID = T5O.ITEMID1 AND T5O.DEL=0 AND T5O.WKAID<>'3'
    LEFT JOIN WK_SIPM95 T5 ON T5O.ITEMID2 = T5.ID AND T5.DEL=0 AND T5.WKAID<>'3'
    LEFT JOIN WK_SIPM96_OBJOF T6O ON TB.ID = T6O.ITEMID1 AND T6O.DEL=0 AND T6O.WKAID<>'3'
    LEFT JOIN WK_SIPM96 T6 ON T6O.ITEMID2 = T6.ID AND T6.DEL=0 AND T6.WKAID<>'3'
    LEFT JOIN WK_SIPM97_OBJOF T7O ON TB.ID = T7O.ITEMID1 AND T7O.DEL=0 AND T7O.WKAID<>'3'
    LEFT JOIN WK_SIPM97 T7 ON T7O.ITEMID2 = T7.ID AND T7.DEL=0 AND T7.WKAID<>'3'
    LEFT JOIN WK_SIPM98_OBJOF T8O ON TB.ID = T8O.ITEMID1 AND T8O.DEL=0 AND T8O.WKAID<>'3'
    LEFT JOIN WK_SIPM98 T8 ON T8O.ITEMID2 = T8.ID AND T8.DEL=0 AND T8.WKAID<>'3'
    WHERE TB.DEL=0 AND TB.WKAID<>'3'
        AND TB.PBOMPKGID = '01_712D7C16EAEB4504E050A8C0870453D4'
        AND TB.NO IS NOT NULL
  ) 
  loop  
  res := SIPM190_row_type1(myrow.id,myrow.publishtn,myrow.publishid,myrow.stn,myrow.sid,myrow.syncbatchno,myrow.syncdataitemno,
  myrow.syncuser,myrow.synctime,myrow.syncresult,myrow.syncmsg,myrow.needsyncsign,myrow.fmaterialid,myrow.del,myrow.msym,
  myrow.wkaid,myrow.designno,myrow.bldesignno,myrow.no,myrow.name,myrow.ver,myrow.ptype,myrow.ename,myrow.creator,myrow.ctime,
  myrow.muser,myrow.mtime,myrow.chkusr,myrow.chktime,myrow.duser,myrow.deltime,myrow.alteruser,myrow.owner,myrow.state,
  myrow.smemo,myrow.pbompkgid,myrow.fromid,myrow.mtart,myrow.extwg,myrow.matkl,myrow.groes,myrow.spart,myrow.oldno,myrow.maktx,
  myrow.tdline,myrow.zind,myrow.unit,myrow.zvariant,myrow.zmaktx,myrow.zsize,myrow.ztype,myrow.zcolor,myrow.zbranch,myrow.zauth,
  myrow.zrohs,myrow.zpackage,myrow.zpaper,myrow.zversion,myrow.zmanual,myrow.mstae,myrow.mtpos,myrow.werks,myrow.classnum,
  myrow.classtype,myrow.numerator,myrow.denominatr,myrow.bstme,myrow.xchpf,myrow.kordb,myrow.ekgrp,myrow.ztdline1,myrow.vkorg,
  myrow.vtweg,myrow.ktgrm,myrow.aland,myrow.tatyp,myrow.taxkm,myrow.mtpos1,myrow.tragr,myrow.ladgr,myrow.ztdline2,myrow.dismm,
  myrow.dispo,myrow.disls,myrow.bstrf,myrow.bstmi,myrow.berid,myrow.dispr,myrow.beskz,myrow.sobsl,myrow.rgekm,myrow.lgfsb,
  myrow.lgpro,myrow.dzeit,myrow.plifz,myrow.webaz,myrow.fhori,myrow.eisbe,myrow.perkz,myrow.strgr,myrow.vrmod,myrow.vint1,
  myrow.vint2,myrow.miskz,myrow.mtvfp,myrow.kzaus,myrow.nfmat,myrow.sbdkz,myrow.fevor,myrow.co_prodprf,myrow.mhdrz,myrow.mhdhb,
  myrow.loggr,myrow.lgnum,myrow.ltkze,myrow.qmatv,myrow.qpart,myrow.qmata,myrow.ssqss,myrow.ztdline3,myrow.bklas,myrow.eklas,
  myrow.qklas,myrow.mlast,myrow.peinh,myrow.vprsv,myrow.losgr,myrow.awsls,myrow.hrkft,myrow.prctr,myrow.ekalr,myrow.hkmat,
  myrow.sobsk,myrow.zplp3,myrow.zpld3,myrow.sipm91id,myrow.sipm94id,myrow.sipm95id,myrow.sipm96id,myrow.sipm97id,myrow.sipm98id,
  myrow.ztime1,myrow.zdate,myrow.ztime2,myrow.zmsgtp2,myrow.zmestx,myrow.prfrq,myrow.ausch);
  pipe row (res);  
end loop;  
return;  
end;  

select * from table(SIPM190_PARTLIB_READ('01_712D7C16EAEB4504E050A8C0870453D4'));

create type SIPM190_row_type1 as object  ----第一步；
(
  id             VARCHAR2(50),
  publishtn      NVARCHAR2(50),
  publishid      VARCHAR2(50),
  stn            NVARCHAR2(50),
  sid            VARCHAR2(50),
  syncbatchno    NVARCHAR2(50),
  syncdataitemno NVARCHAR2(200),
  syncuser       NVARCHAR2(50),
  synctime       TIMESTAMP(6),
  syncresult     NVARCHAR2(50),
  syncmsg        NVARCHAR2(1000),
  needsyncsign   NVARCHAR2(50),
  fmaterialid    VARCHAR2(50),
  del            NUMBER(1),
  msym           VARCHAR2(1),
  wkaid          VARCHAR2(50),
  designno       VARCHAR2(50),
  bldesignno     VARCHAR2(50),
  no             NVARCHAR2(18),
  name           NVARCHAR2(200),
  ver            NVARCHAR2(10),
  ptype          NVARCHAR2(50),
  ename          NVARCHAR2(200),
  creator        VARCHAR2(50),
  ctime          TIMESTAMP(6),
  muser          VARCHAR2(50),
  mtime          TIMESTAMP(6),
  chkusr         VARCHAR2(50),
  chktime        TIMESTAMP(6),
  duser          VARCHAR2(50),
  deltime        TIMESTAMP(6),
  alteruser      VARCHAR2(50),
  owner          VARCHAR2(100),
  state          VARCHAR2(1),
  smemo          NVARCHAR2(200),
  pbompkgid      NVARCHAR2(50),
  fromid         NVARCHAR2(50),
  mtart          NVARCHAR2(4),
  extwg          NVARCHAR2(18),
  matkl          NVARCHAR2(9),
  groes          NVARCHAR2(32),
  spart          NVARCHAR2(2),
  oldno          NVARCHAR2(100),
  maktx          NVARCHAR2(40),
  tdline         NVARCHAR2(500),
  zind           NVARCHAR2(2),
  unit           NVARCHAR2(3),
  zvariant       NVARCHAR2(18),
  zmaktx         NVARCHAR2(40),
  zsize          NVARCHAR2(100),
  ztype          NVARCHAR2(100),
  zcolor         NVARCHAR2(100),
  zbranch        NVARCHAR2(100),
  zauth          NVARCHAR2(100),
  zrohs          NVARCHAR2(4),
  zpackage       NVARCHAR2(100),
  zpaper         NVARCHAR2(100),
  zversion       NVARCHAR2(100),
  zmanual        NVARCHAR2(100),
  mstae          NVARCHAR2(2),
  mtpos          NVARCHAR2(4),
  werks          NVARCHAR2(4),
  classnum       NVARCHAR2(18),
  classtype      NVARCHAR2(18),
  numerator      NUMBER(5),
  denominatr     NUMBER(5),
  bstme          NVARCHAR2(3),
  xchpf          NVARCHAR2(1),
  kordb          NVARCHAR2(1),
  ekgrp          NVARCHAR2(3),
  ztdline1       NVARCHAR2(500),
  vkorg          NVARCHAR2(4),
  vtweg          NVARCHAR2(2),
  ktgrm          NVARCHAR2(2),
  aland          NVARCHAR2(3),
  tatyp          NVARCHAR2(4),
  taxkm          NVARCHAR2(1),
  mtpos1         NVARCHAR2(4),
  tragr          NVARCHAR2(4),
  ladgr          NVARCHAR2(4),
  ztdline2       NVARCHAR2(500),
  dismm          NVARCHAR2(2),
  dispo          NVARCHAR2(3),
  disls          NVARCHAR2(2),
  bstrf          NUMBER(13),
  bstmi          NUMBER(13),
  berid          NVARCHAR2(10),
  dispr          NVARCHAR2(4),
  beskz          NVARCHAR2(1),
  sobsl          NVARCHAR2(2),
  rgekm          NVARCHAR2(1),
  lgfsb          NVARCHAR2(4),
  lgpro          NVARCHAR2(4),
  dzeit          NUMBER(3),
  plifz          NUMBER(3),
  webaz          NUMBER(3),
  fhori          NVARCHAR2(3),
  eisbe          NUMBER(13),
  perkz          NVARCHAR2(1),
  strgr          NVARCHAR2(2),
  vrmod          NVARCHAR2(1),
  vint1          NUMBER(3),
  vint2          NVARCHAR2(3),
  miskz          NVARCHAR2(1),
  mtvfp          NVARCHAR2(2),
  kzaus          NVARCHAR2(1),
  nfmat          NVARCHAR2(18),
  sbdkz          NVARCHAR2(1),
  fevor          NVARCHAR2(3),
  co_prodprf     NVARCHAR2(6),
  mhdrz          NUMBER(4),
  mhdhb          NUMBER(4),
  loggr          NVARCHAR2(4),
  lgnum          NVARCHAR2(3),
  ltkze          NVARCHAR2(3),
  qmatv          NVARCHAR2(1),
  qpart          NVARCHAR2(8),
  qmata          NVARCHAR2(60),
  ssqss          NVARCHAR2(8),
  ztdline3       NVARCHAR2(132),
  bklas          NVARCHAR2(4),
  eklas          NVARCHAR2(4),
  qklas          NVARCHAR2(4),
  mlast          NVARCHAR2(1),
  peinh          NUMBER(5),
  vprsv          NVARCHAR2(1),
  losgr          NUMBER(13),
  awsls          NVARCHAR2(6),
  hrkft          NVARCHAR2(4),
  prctr          NVARCHAR2(10),
  ekalr          NVARCHAR2(1),
  hkmat          NVARCHAR2(1),
  sobsk          NVARCHAR2(2),
  zplp3          NUMBER(18,6),
  zpld3          NVARCHAR2(8),
  sipm91id       VARCHAR2(50),
  sipm94id       VARCHAR2(50),
  sipm95id       VARCHAR2(50),
  sipm96id       VARCHAR2(50),
  sipm97id       VARCHAR2(50),
  sipm98id       VARCHAR2(50),
  ztime1         NVARCHAR2(50),
  zdate          NVARCHAR2(8),
  ztime2         NVARCHAR2(6),
  zmsgtp2        NVARCHAR2(1),
  zmestx         NVARCHAR2(150),
  prfrq          NUMBER(5),
  ausch          NUMBER(5,2)
)


