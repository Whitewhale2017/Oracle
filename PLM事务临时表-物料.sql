-- Create table
create global temporary table TEMP_WK_MATLIB
(
  id             VARCHAR2(50) not null,
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
  no             NVARCHAR2(50),
  name           NVARCHAR2(36),
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
  matkl          NVARCHAR2(100),
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
  xchpf          NVARCHAR2(3),
  kordb          NVARCHAR2(3),
  ekgrp          NVARCHAR2(3),
  ztdline1       NVARCHAR2(500),
  vkorg          NVARCHAR2(1000),
  vtweg          NVARCHAR2(200),
  ktgrm          NVARCHAR2(33),
  aland          NVARCHAR2(3),
  tatyp          NVARCHAR2(4),
  taxkm          NVARCHAR2(33),
  mtpos1         NVARCHAR2(4),
  tragr          NVARCHAR2(4),
  ladgr          NVARCHAR2(4),
  ztdline2       NVARCHAR2(500),
  dismm          NVARCHAR2(33),
  dispo          NVARCHAR2(30),
  disls          NVARCHAR2(33),
  bstrf          NUMBER(13),
  bstmi          NUMBER(13),
  berid          NVARCHAR2(1000),
  dispr          NVARCHAR2(1000),
  beskz          NVARCHAR2(33),
  sobsl          NVARCHAR2(33),
  rgekm          NVARCHAR2(33),
  lgfsb          NVARCHAR2(4),
  lgpro          NVARCHAR2(4),
  dzeit          NUMBER(3),
  plifz          NUMBER(3),
  webaz          NUMBER(3),
  fhori          NVARCHAR2(3),
  eisbe          NUMBER(13),
  perkz          NVARCHAR2(33),
  strgr          NVARCHAR2(33),
  vrmod          NVARCHAR2(33),
  vint1          NUMBER(3),
  vint2          NVARCHAR2(3),
  miskz          NVARCHAR2(33),
  mtvfp          NVARCHAR2(33),
  kzaus          NVARCHAR2(33),
  nfmat          NVARCHAR2(33),
  sbdkz          NVARCHAR2(33),
  fevor          NVARCHAR2(30),
  co_prodprf     NVARCHAR2(60),
  mhdrz          NUMBER(4),
  mhdhb          NUMBER(4),
  loggr          NVARCHAR2(4),
  lgnum          NVARCHAR2(3),
  ltkze          NVARCHAR2(3),
  qmatv          NVARCHAR2(33),
  qpart          NVARCHAR2(11),
  qmata          NVARCHAR2(60),
  ssqss          NVARCHAR2(8),
  ztdline3       NVARCHAR2(132),
  bklas          NVARCHAR2(4),
  eklas          NVARCHAR2(4),
  qklas          NVARCHAR2(4),
  mlast          NVARCHAR2(3),
  peinh          NUMBER(5),
  vprsv          NVARCHAR2(33),
  losgr          NUMBER(13),
  awsls          NVARCHAR2(6),
  hrkft          NVARCHAR2(4),
  prctr          NVARCHAR2(10),
  ekalr          NVARCHAR2(33),
  hkmat          NVARCHAR2(33),
  sobsk          NVARCHAR2(33),
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
  ausch          NUMBER(5,2),
  ordernum       NUMBER(9)
)
on commit delete rows;
