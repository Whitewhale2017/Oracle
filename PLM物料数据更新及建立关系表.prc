CREATE OR REPLACE PROCEDURE proc_init_sapview_hqlssj(v_pbompkgid varchar2,v_pbompkgno nvarchar2,v_operator nvarchar2)
AS
    --v_SQL_Text varchar(4000);
    --v_RowCount number(9);
    v_ErrRowCount number(9);
    v_ErrRaise EXCEPTION;
    v_ErrCode varchar2(20);
    v_ErrMsg varchar2(2000);
BEGIN

    insert into sipm190_last_tmp
    select t2.*
    from sipm190_last t2
    where exists(select 1 from sapitmp_partlib_lssj t1
                where t1.vcno = t2.no and t1.werks = t2.werks
                      and t1.pbompkgid = v_pbompkgid and t1.lssjsign in ('1','2'));

    -- ��SIPM190_LAST�б���������SAP�ɹ���SAP��ͼ���ݳ�ʼ��
    -- ���ɲɹ���ͼ
    insert into wk_sipm91 (pbompkgid,partlibid,id,del,wkaid,msym,designno,bldesignno,no,name,ver,ename,ptype,creator,ctime,owner,state,smemo,werks
        ,classnum,classtype,numerator,denominatr,bstme,xchpf,kordb,ekgrp,ztdline1)
    select t1.pbompkgid,t1.id,'WK_01_' || sys_guid(),t1.del,t1.wkaid,t1.msym,t1.designno,t1.bldesignno,t1.no,t1.name,0,t1.ename,t1.ptype,t1.creator,t1.ctime,t1.owner,t1.state,'����ʷ���ݳ�ʼ��',t1.werks
        ,t2.classnum,t2.classtype,t2.numerator,t2.denominatr,t2.bstme,t2.xchpf,t2.kordb,t2.ekgrp,t2.ztdline1
    from sapitmp_partlib_lssj t1
    left join sipm190_last_tmp t2 on t1.vcno = t2.no and t1.werks = t2.werks and coalesce(t2.bstme,t2.xchpf,t2.kordb,t2.ekgrp,t2.ztdline1) is not null -- �ų�ȫ��Ϊ�յĲɹ���ͼ��¼  -- NUMERATOR,DENOMINATR,
    where t1.pbompkgid = v_pbompkgid and t1.lssjsign in ('1','2')
    group by t1.pbompkgid,t1.id,t1.del,t1.wkaid,t1.msym,t1.designno,t1.bldesignno,t1.no,t1.name,0,t1.ename,t1.ptype,t1.creator,t1.ctime,t1.owner,t1.state,t1.werks
        ,t2.classnum,t2.classtype,t2.numerator,t2.denominatr,t2.bstme,t2.xchpf,t2.kordb,t2.ekgrp,t2.ztdline1;

    -- ����������ͼ
    INSERT INTO WK_SIPM92 (pbompkgid,partlibid,id,del,wkaid,msym,designno,bldesignno,no,name,ver,ename,ptype,creator,ctime,owner,state,smemo,werks
    ,vkorg,vtweg,ktgrm,aland,tatyp,taxkm,mtpos1,tragr,ladgr,ztdline2)
    select t1.pbompkgid,t1.id,'WK_01_' || sys_guid(),t1.del,t1.wkaid,t1.msym,t1.designno,t1.bldesignno,t1.no,t1.name,0,t1.ename,t1.ptype,t1.creator,t1.ctime,t1.owner,t1.state,'����ʷ���ݳ�ʼ��',t1.werks
    ,t2.vkorg,t2.vtweg,t2.ktgrm,t2.aland,t2.tatyp,t2.taxkm,t2.mtpos1,t2.tragr,t2.ladgr,t2.ztdline2
    from sapitmp_partlib_lssj t1
    left join sipm190_last_tmp t2 on t1.vcno = t2.no and t1.werks = t2.werks and coalesce(t2.vkorg,t2.vtweg,t2.ktgrm,t2.aland,t2.tatyp,t2.taxkm,t2.mtpos1,t2.tragr,t2.ladgr,t2.ztdline2) is not null  -- �ų�ȫ��Ϊ�յ�������ͼ��¼
    where t1.pbompkgid = v_pbompkgid and t1.lssjsign in ('1','2')
    group by t1.pbompkgid,t1.id,t1.del,t1.wkaid,t1.msym,t1.designno,t1.bldesignno,t1.no,t1.name,0,t1.ename,t1.ptype,t1.creator,t1.ctime,t1.owner,t1.state,t1.werks
        ,t2.vkorg,t2.vtweg,t2.ktgrm,t2.aland,t2.tatyp,t2.taxkm,t2.mtpos1,t2.tragr,t2.ladgr,t2.ztdline2;

    -- ����MRP������ͼ
    INSERT INTO WK_SIPM93 (pbompkgid,partlibid,id,del,wkaid,msym,designno,bldesignno,no,name,ver,ename,ptype,creator,ctime,owner,state,smemo,werks
    ,dismm,dispo,disls,bstrf,bstmi,berid,dispr)
    select t1.pbompkgid,t1.id,'WK_01_' || sys_guid(),t1.del,t1.wkaid,t1.msym,t1.designno,t1.bldesignno,t1.no,t1.name,0,t1.ename,t1.ptype,t1.creator,t1.ctime,t1.owner,t1.state,'����ʷ���ݳ�ʼ��',t1.werks
    ,t2.dismm,t2.dispo,t2.disls,t2.bstrf,t2.bstmi,t2.berid,t2.dispr
    from sapitmp_partlib_lssj t1
    left join sipm190_last_tmp t2 on t1.vcno =t2.no and t1.werks = t2.werks and coalesce(t2.dismm,t2.dispo,t2.disls,t2.berid,t2.dispr) is not null  -- �ų�ȫ��Ϊ�յ�MPR������ͼ��¼ -- t2.dismm,t2.dispo,t2.disls,t2.bstrf,t2.bstmi,
    where t1.pbompkgid = v_pbompkgid and t1.lssjsign in ('1','2')
    group by t1.pbompkgid,t1.id,t1.del,t1.wkaid,t1.msym,t1.designno,t1.bldesignno,t1.no,t1.name,0,t1.ename,t1.ptype,t1.creator,t1.ctime,t1.owner,t1.state,t1.werks
        ,t2.dismm,t2.dispo,t2.disls,t2.bstrf,t2.bstmi,t2.berid,t2.dispr;

    -- ����MRP��ͼ
    INSERT INTO WK_SIPM94 (pbompkgid,partlibid,id,del,wkaid,msym,designno,bldesignno,no,name,ver,ename,ptype,creator,ctime,owner,state,smemo,werks
    ,beskz,sobsl,rgekm,lgfsb,lgpro,dzeit,plifz,webaz,fhori,eisbe,perkz,strgr,vrmod,vint1,vint2,miskz,mtvfp,kzaus,nfmat,sbdkz)
    select t1.pbompkgid,t1.id,'WK_01_' || sys_guid(),t1.del,t1.wkaid,t1.msym,t1.designno,t1.bldesignno,t1.no,t1.name,0,t1.ename,t1.ptype,t1.creator,t1.ctime,t1.owner,t1.state,'����ʷ���ݳ�ʼ��',t1.werks
    ,t2.beskz,t2.sobsl,t2.rgekm,t2.lgfsb,t2.lgpro,t2.dzeit,t2.plifz,t2.webaz,t2.fhori,t2.eisbe,t2.perkz,t2.strgr,t2.vrmod,t2.vint1,t2.vint2,t2.miskz,t2.mtvfp,t2.kzaus,t2. nfmat,t2.sbdkz
    from sapitmp_partlib_lssj t1
    left join sipm190_last_tmp t2 on t1.vcno = t2.no and t1.werks = t2.werks and coalesce(t2.beskz,t2.lgfsb,t2.lgpro,t2.fhori,t2.perkz,t2.mtvfp,t2.sbdkz) is not null  -- �ų�������ȫ��Ϊ�յ�MRP��ͼ��¼;
    where t1.pbompkgid = v_pbompkgid and t1.lssjsign in ('1','2')
    group by t1.pbompkgid,t1.id,t1.del,t1.wkaid,t1.msym,t1.designno,t1.bldesignno,t1.no,t1.name,0,t1.ename,t1.ptype,t1.creator,t1.ctime,t1.owner,t1.state,t1.werks
        ,t2.beskz,t2.sobsl,t2.rgekm,t2.lgfsb,t2.lgpro,t2.dzeit,t2.plifz,t2.webaz,t2.fhori,t2.eisbe,t2.perkz,t2.strgr,t2.vrmod,t2.vint1,t2.vint2,t2.miskz,t2.mtvfp,t2.kzaus,t2. nfmat,t2.sbdkz;

    -- ���ɼƻ���ͼ
    INSERT INTO WK_SIPM95 (pbompkgid,partlibid,id,del,wkaid,msym,designno,bldesignno,no,name,ver,ename,ptype,creator,ctime,owner,state,smemo,werks
    ,fevor,co_prodprf)
    select t1.pbompkgid,t1.id,'WK_01_' || sys_guid(),t1.del,t1.wkaid,t1.msym,t1.designno,t1.bldesignno,t1.no,t1.name,0,t1.ename,t1.ptype,t1.creator,t1.ctime,t1.owner,t1.state,'����ʷ���ݳ�ʼ��',t1.werks
    ,t2.fevor,t2.co_prodprf
    from sapitmp_partlib_lssj t1
    left join sipm190_last_tmp t2 on t1.vcno = t2.no and t1.werks = t2.werks and coalesce(t2.fevor,t2.co_prodprf) is not null  -- �ų�������ȫ��Ϊ�յļƻ���ͼ��¼;
    where t1.pbompkgid = v_pbompkgid and t1.lssjsign in ('1','2')
    group by t1.pbompkgid,t1.id,t1.del,t1.wkaid,t1.msym,t1.designno,t1.bldesignno,t1.no,t1.name,0,t1.ename,t1.ptype,t1.creator,t1.ctime,t1.owner,t1.state,t1.werks
        ,t2.fevor,t2.co_prodprf;

    -- ���ɴ洢��ͼ
    INSERT INTO WK_SIPM96 (pbompkgid,partlibid,id,del,wkaid,msym,designno,bldesignno,no,name,ver,ename,ptype,creator,ctime,owner,state,smemo,werks
    ,mhdrz,mhdhb,loggr,lgnum,ltkze)
    select t1.pbompkgid,t1.id,'WK_01_' || sys_guid(),t1.del,t1.wkaid,t1.msym,t1.designno,t1.bldesignno,t1.no,t1.name,0,t1.ename,t1.ptype,t1.creator,t1.ctime,t1.owner,t1.state,'����ʷ���ݳ�ʼ��',t1.werks
    ,t2.mhdrz,t2.mhdhb,t2.loggr,t2.lgnum,t2.ltkze
    from sapitmp_partlib_lssj t1
    left join sipm190_last_tmp t2 on t1.vcno = t2.no and t1.werks = t2.werks and coalesce(t2.loggr,t2.lgnum,t2.ltkze) is not null  -- �ų�������ȫ��Ϊ�յĴ洢��ͼ��¼;
    where t1.pbompkgid = v_pbompkgid and t1.lssjsign in ('1','2')
    group by t1.pbompkgid,t1.id,t1.del,t1.wkaid,t1.msym,t1.designno,t1.bldesignno,t1.no,t1.name,0,t1.ename,t1.ptype,t1.creator,t1.ctime,t1.owner,t1.state,t1.werks
        ,t2.mhdrz,t2.mhdhb,t2.loggr,t2.lgnum,t2.ltkze;

    -- �����ʿ���ͼ
    INSERT INTO WK_SIPM97 (pbompkgid,partlibid,id,del,wkaid,msym,designno,bldesignno,no,name,ver,ename,ptype,creator,ctime,owner,state,smemo,werks
    ,qmatv,qpart,qmata,ssqss,prfrq)
    select t1.pbompkgid,t1.id,'WK_01_' || sys_guid(),t1.del,t1.wkaid,t1.msym,t1.designno,t1.bldesignno,t1.no,t1.name,0,t1.ename,t1.ptype,t1.creator,t1.ctime,t1.owner,t1.state,'����ʷ���ݳ�ʼ��',t1.werks
    ,t2.qmatv,t2.qpart,t2.qmata,t2.ssqss,t2.prfrq
    from sapitmp_partlib_lssj t1
    left join sipm190_last_tmp t2 on t1.vcno = t2.no and t1.werks = t2.werks and coalesce(t2.qmatv,t2.qpart,t2.qmata,t2.ssqss,t2.ztdline3) is not null  -- �ų�ȫ��Ϊ�յ��ʿ���ͼ��¼
    where t1.pbompkgid = v_pbompkgid and t1.lssjsign in ('1','2')
    group by t1.pbompkgid,t1.id,t1.del,t1.wkaid,t1.msym,t1.designno,t1.bldesignno,t1.no,t1.name,0,t1.ename,t1.ptype,t1.creator,t1.ctime,t1.owner,t1.state,t1.werks
       ,t2.qmatv,t2.qpart,t2.qmata,t2.ssqss,t2.prfrq;

    -- ���ɲ�����ͼ
    INSERT INTO WK_SIPM98 (pbompkgid,partlibid,id,del,wkaid,msym,designno,bldesignno,no,name,ver,ename,ptype,creator,ctime,owner,state,smemo,werks
    ,bklas,eklas,qklas,mlast,peinh,vprsv,losgr,awsls,hrkft,prctr,ekalr,hkmat,sobsk,zplp3,zpld3)
    select t1.pbompkgid,t1.id,'WK_01_' || sys_guid(),t1.del,t1.wkaid,t1.msym,t1.designno,t1.bldesignno,t1.no,t1.name,0,t1.ename,t1.ptype,t1.creator,t1.ctime,t1.owner,t1.state,'����ʷ���ݳ�ʼ��',t1.werks
    ,t2.bklas,t2.eklas,t2.qklas,t2.mlast,t2.peinh,t2.vprsv,t2.losgr,t2.awsls,t2.hrkft,t2.prctr,t2.ekalr,t2.hkmat,t2.sobsk,round(t2.zplp3/t2.peinh,6),t2.zpld3
    from sapitmp_partlib_lssj t1
    left join sipm190_last_tmp t2 on t1.vcno = t2.no and t1.werks = t2.werks and coalesce(t2.bklas,t2.eklas,t2.qklas,t2.mlast,t2.vprsv,t2.awsls,t2.hrkft,t2.prctr,t2.ekalr,t2.hkmat) is not null -- �ų�������ȫ��Ϊ�յĲ�����ͼ��¼; -- PEINH,LOSGR
    where t1.pbompkgid = v_pbompkgid and t1.lssjsign in ('1','2')
    group by t1.pbompkgid,t1.id,t1.del,t1.wkaid,t1.msym,t1.designno,t1.bldesignno,t1.no,t1.name,0,t1.ename,t1.ptype,t1.creator,t1.ctime,t1.owner,t1.state,t1.werks
       ,t2.bklas,t2.eklas,t2.qklas,t2.mlast,t2.peinh,t2.vprsv,t2.losgr,t2.awsls,t2.hrkft,t2.prctr,t2.ekalr,t2.hkmat,t2.sobsk,t2.zplp3,t2.zpld3;

    commit;
    return;
EXCEPTION
    when v_ErrRaise then
        v_ErrCode := to_char(SQLCODE);
        v_ErrMsg := SUBSTR(SQLERRM,1,200);
        rollback;
        insert into sipm196 (id,no,syncmsg )
        values ('01_'||SYS_GUID(),v_pbompkgno,'���������ʾ��SAP��ͼ������������ݳ�ʼ���쳣��������룺' || v_ErrCode || '��������Ϣ��' || v_ErrMsg || '��');
        commit;
    when others then
        v_ErrCode := SQLCODE;
        v_ErrMsg := SUBSTR(SQLERRM,1,200);
        rollback;
        insert into sipm196 (id,no,syncmsg )
        values ('01_'||SYS_GUID(),v_pbompkgno,'���������ʾ��SAP��ͼ������������ݳ�ʼ���쳣��������룺' || v_ErrCode || '��������Ϣ��' || v_ErrMsg || '��');
        commit;
END ;

 
/
