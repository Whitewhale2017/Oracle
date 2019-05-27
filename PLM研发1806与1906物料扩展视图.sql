--------PLM研发1806与1906物料扩展视图-----
create or replace view v_sipm190_last_1806 as  ---排除重复的berid
select max(id) id, no, werks, beskz, sobsl,sbdkz 
       from sipm190_last
       where werks in ('1001','1801')
       group by no,mtart, extwg, matkl, groes, spart, oldno, maktx, tdline, zind, unit, zvariant, 
       zmaktx, zsize, ztype, zcolor, zbranch, zauth, zrohs, zpackage, zpaper, zversion, zmanual, mstae, 
       mtpos, werks, classnum, classtype, numerator, denominatr, bstme, xchpf, kordb, ekgrp, ztdline1, vkorg, vtweg, ktgrm, aland, 
       tatyp, taxkm, mtpos1, tragr, ladgr, ztdline2, dismm, dispo, disls, bstrf, bstmi,dispr, beskz, sobsl, rgekm, lgfsb, 
       lgpro, dzeit, plifz, webaz, fhori, eisbe, perkz, strgr, vrmod, vint1, vint2, miskz, mtvfp, kzaus, nfmat, sbdkz, fevor, co_prodprf, 
       mhdrz, mhdhb, loggr, lgnum, ltkze, qmatv, qpart, qmata, ssqss, ztdline3, bklas, eklas, qklas, mlast, peinh, vprsv, losgr, awsls, hrkft, 
       prctr, ekalr, hkmat, sobsk, zplp3, zpld3, ztime1, zdate, ztime2, zmsgtp2, 
       zmestx, prfrq, ausch
   

create or replace view v_sipm190_last_1906 as  ---排除重复的berid
select max(id) id, no, werks, beskz, sobsl,sbdkz
       from sipm190_last
       where werks in ('1002','1901')
       group by no,mtart, extwg, matkl, groes, spart, oldno, maktx, tdline, zind, unit, zvariant, 
       zmaktx, zsize, ztype, zcolor, zbranch, zauth, zrohs, zpackage, zpaper, zversion, zmanual, mstae, 
       mtpos, werks, classnum, classtype, numerator, denominatr, bstme, xchpf, kordb, ekgrp, ztdline1, vkorg, vtweg, ktgrm, aland, 
       tatyp, taxkm, mtpos1, tragr, ladgr, ztdline2, dismm, dispo, disls, bstrf, bstmi,dispr, beskz, sobsl, rgekm, lgfsb, 
       lgpro, dzeit, plifz, webaz, fhori, eisbe, perkz, strgr, vrmod, vint1, vint2, miskz, mtvfp, kzaus, nfmat, sbdkz, fevor, co_prodprf, 
       mhdrz, mhdhb, loggr, lgnum, ltkze, qmatv, qpart, qmata, ssqss, ztdline3, bklas, eklas, qklas, mlast, peinh, vprsv, losgr, awsls, hrkft, 
       prctr, ekalr, hkmat, sobsk, zplp3, zpld3, ztime1, zdate, ztime2, zmsgtp2, 
       zmestx, prfrq, ausch
