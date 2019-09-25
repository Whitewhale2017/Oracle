create or replace procedure proc_expand_processlib_1906_yh(v_pbompkgid varchar2,v_operator nvarchar2)
as
v_werks NVARCHAR2(4); --werks工厂
begin
        v_werks := '1906';
                ------将工作区同pbompkgid的数据插入临时表temp_wk_partlib-------------
        insert into TEMP_WK_PARTLIB(id,publishid,sid,syncdataitemno,syncuser
        ,MTART,EXTWG,MATKL,GROES,SPART,OLDNO,NO,MAKTX,TDLINE,ZIND,UNIT,ZVARIANT,ZMAKTX,ZSIZE,ZTYPE,ZCOLOR,ZBRANCH,ZAUTH,ZROHS,ZPACKAGE,ZPAPER,ZVERSION,
        ZMANUAL,MSTAE,MTPOS,WERKS,CLASSNUM,CLASSTYPE,NUMERATOR,DENOMINATR,BSTME,XCHPF,KORDB,EKGRP,ZTDLINE1,VKORG,VTWEG,KTGRM,ALAND,TATYP,TAXKM,MTPOS1,
        TRAGR,LADGR,ZTDLINE2,DISMM,DISPO,DISLS,BSTRF,BSTMI,BERID,DISPR,BESKZ,SOBSL,RGEKM,LGFSB,LGPRO,DZEIT,PLIFZ,WEBAZ,FHORI,EISBE,PERKZ,STRGR,VRMOD,
        VINT1,VINT2,MISKZ,MTVFP,KZAUS,NFMAT,SBDKZ,FEVOR,CO_PRODPRF
        ,MHDRZ,MHDHB,LOGGR,LGNUM,LTKZE
        ,QMATV,QPART,QMATA,SSQSS,ZTDLINE3,PRFRQ
        ,BKLAS,EKLAS,QKLAS,MLAST,PEINH,VPRSV,LOSGR,AWSLS,HRKFT,PRCTR,EKALR,HKMAT,SOBSK,ZPLP3,ZPLD3
        ,ZTIME1,AUSCH)
        SELECT 'O1_'||SYS_GUID() id,v_pbompkgid,t1.id sid,t1.NO,null as username,
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
       AND TB.PBOMPKGID = v_pbompkgid
       AND TB.NO IS NOT NULL;

      -- dbms_output.put_line('将工作区同pbompkgid的数据插入临时表temp_wk_partlib :'||to_char(sysdate,'yyyy-mm-dd hh24:mi:ss'));
       
       insert into TEMP_WK_MATLIB(id, publishtn, publishid, stn, sid, syncbatchno, syncdataitemno, syncuser, synctime, syncresult, syncmsg, needsyncsign, 
       fmaterialid, del, msym, wkaid, designno, bldesignno, no, name, ver, ptype, ename, creator, ctime, muser, mtime, chkusr, chktime, 
       duser, deltime, alteruser, owner, state, smemo, pbompkgid, fromid, mtart, extwg, matkl, groes, spart, oldno, maktx, tdline, zind, 
       unit, zvariant, zmaktx, zsize, ztype, zcolor, zbranch, zauth, zrohs, zpackage, zpaper, zversion, zmanual, mstae, mtpos, werks, 
       classnum, classtype, numerator, denominatr, bstme, xchpf, kordb, ekgrp, ztdline1, vkorg, vtweg, ktgrm, aland, tatyp, taxkm, mtpos1, 
       tragr, ladgr, ztdline2, dismm, dispo, disls, bstrf, bstmi, berid, dispr, beskz, sobsl, rgekm, lgfsb, lgpro, dzeit, plifz, webaz, fhori, 
       eisbe, perkz, strgr, vrmod, vint1, vint2, miskz, mtvfp, kzaus, nfmat, sbdkz, fevor, co_prodprf, mhdrz, mhdhb, loggr, lgnum, ltkze, qmatv, 
       qpart, qmata, ssqss, ztdline3, bklas, eklas, qklas, mlast, peinh, vprsv, losgr, awsls, hrkft, prctr, ekalr, hkmat, sobsk, zplp3, zpld3, sipm91id, 
       sipm94id, sipm95id, sipm96id, 
        sipm97id, sipm98id, ztime1, zdate, ztime2, zmsgtp2, zmestx, prfrq, ausch, ordernum )
       select id, publishtn, publishid, stn, sid, syncbatchno, syncdataitemno, syncuser, synctime, syncresult, syncmsg, needsyncsign, 
       fmaterialid, del, msym, wkaid, designno, bldesignno, no, name, ver, ptype, ename, creator, ctime, muser, mtime, chkusr, chktime, 
       duser, deltime, alteruser, owner, state, smemo, pbompkgid, fromid, mtart, extwg, matkl, groes, spart, oldno, maktx, tdline, zind, 
       unit, zvariant, zmaktx, zsize, ztype, zcolor, zbranch, zauth, zrohs, zpackage, zpaper, zversion, zmanual, mstae, mtpos, werks, 
       classnum, classtype, numerator, denominatr, bstme, xchpf, kordb, ekgrp, ztdline1, vkorg, vtweg, ktgrm, aland, tatyp, taxkm, mtpos1, 
       tragr, ladgr, ztdline2, dismm, dispo, disls, bstrf, bstmi, berid, dispr, beskz, sobsl, rgekm, lgfsb, lgpro, dzeit, plifz, webaz, fhori, 
       eisbe, perkz, strgr, vrmod, vint1, vint2, miskz, mtvfp, kzaus, nfmat, sbdkz, fevor, co_prodprf, mhdrz, mhdhb, loggr, lgnum, ltkze, qmatv, 
       qpart, qmata, ssqss, ztdline3, bklas, eklas, qklas, mlast, peinh, vprsv, losgr, awsls, hrkft, prctr, ekalr, hkmat, sobsk, zplp3, zpld3, sipm91id, 
       sipm94id, sipm95id, sipm96id, 
        sipm97id, sipm98id, ztime1, zdate, ztime2, zmsgtp2, zmestx, prfrq, ausch, ordernum  from (
        select * from TEMP_WK_PARTLIB
        union
        select a1.* from sipm190_last  a1
        inner join (select * from pbomlib where pbompkgid=v_pbompkgid) t1
        on a1.werks=t1.werks and (a1.no = t1.pno or a1.no = t1.cno)
        and not exists(
        select 1 from (select * from TEMP_WK_PARTLIB) t
        where a1.no=t.no and a1.werks=t.werks)
        ) t;
       ----全局扩展工艺路线 步骤一------
       insert into  SIPM171(id, partno,Pbompkgid
       , prcvno, macht, werks, plantext, zversion, verwe, statu, vornr, arbpl, frdlb, ekorg, matkl, ekgrp, sakto, steus, ltxa1, ltxa2, splim,
       zwnor, zeiwn, bmsch, meinh, umren, umrez, plnme, vgwrt01, vgwrteh01, vgwrt02, vgwrteh02, vgwrt03, vgwrteh03, vgwrt04, vgwrteh04, vgwrt05,
       vgwrteh05, vgwrt06, vgwrteh06,creator,owner)
       select '01_'||SYS_GUID(),partno,v_pbompkgid
       , prcvno, macht, v_werks, plantext, zversion, verwe, statu, vornr, arbpl, frdlb, ekorg, matkl, ekgrp, sakto, steus, ltxa1, ltxa2, splim,
       zwnor, zeiwn, bmsch, meinh, umren, umrez, plnme, vgwrt01, vgwrteh01, vgwrt02, vgwrteh02, vgwrt03, vgwrteh03, vgwrt04, vgwrteh04, vgwrt05,
       vgwrteh05, vgwrt06, vgwrteh06,v_operator,v_operator
       from  processlib a
        inner join 
       (select max(t1.id) id, t1.no, t1.werks, t1.beskz, t1.sobsl,t1.sbdkz
                           from  TEMP_WK_MATLIB t1
                                    where t1.werks in ('1002','1901')
                                    group by t1.no, t1.werks, t1.beskz, t1.sobsl,t1.sbdkz)
                                    
       t
        on t.no=a.partno and t.werks=a.werks
        where a.pbompkgid=v_pbompkgid
       and a.werks='1002'
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
       insert into  SIPM171(id, partno,Pbompkgid
       , prcvno, macht, werks, plantext, zversion, verwe, statu, vornr, arbpl, frdlb, ekorg, matkl, ekgrp, sakto, steus, ltxa1, ltxa2, splim,
       zwnor, zeiwn, bmsch, meinh, umren, umrez, plnme, vgwrt01, vgwrteh01, vgwrt02, vgwrteh02, vgwrt03, vgwrteh03, vgwrt04, vgwrteh04, vgwrt05,
       vgwrteh05, vgwrt06, vgwrteh06,creator,owner)
       select '01_'||SYS_GUID(),partno,v_pbompkgid
       , prcvno, macht, v_werks, plantext, zversion, verwe, statu, vornr, arbpl, frdlb, ekorg, matkl, ekgrp, sakto, steus, ltxa1, ltxa2, splim,
       zwnor, zeiwn, bmsch, meinh, umren, umrez, plnme, vgwrt01, vgwrteh01, vgwrt02, vgwrteh02, vgwrt03, vgwrteh03, vgwrt04, vgwrteh04, vgwrt05,
       vgwrteh05, vgwrt06, vgwrteh06,v_operator,v_operator
       from  sipm191_last a
      inner join 
       (select max(t1.id) id, t1.no, t1.werks, t1.beskz, t1.sobsl,t1.sbdkz
                           from  TEMP_WK_MATLIB t1
                                    where t1.werks in ('1002','1901')
                                    group by t1.no, t1.werks, t1.beskz, t1.sobsl,t1.sbdkz)
                                    
       t
        on t.no=a.partno and t.werks=a.werks
       where
       a.werks='1002'
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
             (select pno as matnr from pbomlib where pbompkgid=v_pbompkgid and werks in ('1002','1901') group by pno
              )
              and t.no not in (select partno from SIPM171 where pbompkgid = v_pbompkgid);

     commit;
      -- dbms_output.put_line(to_char(sysdate,'yyyy-mm-dd hh24:mi:ss'));
end;
/
