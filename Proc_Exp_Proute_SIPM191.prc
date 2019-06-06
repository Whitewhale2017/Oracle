CREATE OR REPLACE PROCEDURE Proc_Exp_Proute(blanks nvarchar2, v_id nvarchar2, v_objtype nvarchar2, v_interfacelist nvarchar2, v_syncbatchno nvarchar2, v_accid nvarchar2, v_username nvarchar2)
AS
    v_SQL_Text varchar(8000);
    v_MidTableList varchar(4000);
    v_routebatchno varchar(50); -- ����·�����κ�
    v_RowCount number(9);
    v_ErrRowCount number(9);
    v_ErrRaise EXCEPTION;
    v_ErrCode varchar2(20);
    v_ErrMsg varchar2(2000);
BEGIN
    v_routebatchno := 'R'||v_syncbatchno;
    UPDATE SIPM195 SET ENAME='PROUTE' WHERE NO=v_syncbatchno;   -- ������ݰ�����
    insert into sipm191 (id,publishtn,publishid,stn,sid,syncbatchno,syncdataitemno,syncuser
        ,partno,werks,zversion,vornr,plantext,verwe,statu,arbpl,frdlb,ekorg,matkl,ekgrp,sakto,steus,ltxa1,ltxa2,splim,zwnor,zeiwn,bmsch,meinh,umren,umrez,plnme,vgwrt01,vgwrteh01,vgwrt02,vgwrteh02,vgwrt03,vgwrteh03,vgwrt04,vgwrteh04,vgwrt05,vgwrteh05,vgwrt06,vgwrteh06
        )
    select '01_'||sys_guid(),'PBOMPKG',v_id,'SIPM191',t1.id,v_routebatchno,t1.no,v_username
        ,partno,werks,zversion,vornr,plantext,verwe,statu,arbpl,frdlb,ekorg,matkl,ekgrp,sakto,steus,ltxa1,ltxa2,splim,zwnor,zeiwn,bmsch,meinh,umren,umrez,plnme,vgwrt01,vgwrteh01,vgwrt02,vgwrteh02,vgwrt03,vgwrteh03,vgwrt04,vgwrteh04,vgwrt05,vgwrteh05,vgwrt06,vgwrteh06
    from processlib t1
    where t1.del=0 and t1.wkaid<>'3'
        and t1.pbompkgid = v_id;

    insert into sipm191 (id,publishtn,publishid,stn,sid,syncbatchno,syncdataitemno,syncuser
        ,partno,werks,zversion,vornr,plantext,verwe,statu,arbpl,frdlb,ekorg,matkl,ekgrp,sakto,steus,ltxa1,ltxa2,splim,zwnor,zeiwn,bmsch,meinh,umren,umrez,plnme,vgwrt01,vgwrteh01,vgwrt02,vgwrteh02,vgwrt03,vgwrteh03,vgwrt04,vgwrteh04,vgwrt05,vgwrteh05,vgwrt06,vgwrteh06
        )
    select '01_'||sys_guid(),'PBOMPKG',v_id,'SIPM191',t1.id,v_routebatchno,t1.no,v_username
        ,partno,werks,zversion,vornr,plantext,verwe,statu,arbpl,frdlb,ekorg,matkl,ekgrp,sakto,steus,ltxa1,ltxa2,splim,zwnor,zeiwn,bmsch,meinh,umren,umrez,plnme,vgwrt01,vgwrteh01,vgwrt02,vgwrteh02,vgwrt03,vgwrteh03,vgwrt04,vgwrteh04,vgwrt05,vgwrteh05,vgwrt06,vgwrteh06
    from wk_processlib t1
    where t1.del=0 and t1.wkaid<>'3'
        and t1.pbompkgid = v_id;
        -------------����չ1806��1906������д��sipm191-------------
     insert into sipm191 (id,publishtn,publishid,stn,sid,syncbatchno,syncdataitemno,syncuser
        ,partno,werks,zversion,vornr,plantext,verwe,statu,arbpl,frdlb,ekorg,matkl,ekgrp,sakto,steus,ltxa1,ltxa2,splim,zwnor,zeiwn,bmsch,meinh,umren,umrez,plnme,vgwrt01,vgwrteh01,vgwrt02,vgwrteh02,vgwrt03,vgwrteh03,vgwrt04,vgwrteh04,vgwrt05,vgwrteh05,vgwrt06,vgwrteh06
        )
    select '01_'||sys_guid(),'PBOMPKG',v_id,'SIPM191',t1.id,v_routebatchno,t1.no,v_username
        ,partno,werks,zversion,vornr,plantext,verwe,statu,arbpl,frdlb,ekorg,matkl,ekgrp,sakto,steus,ltxa1,ltxa2,splim,zwnor,zeiwn,bmsch,meinh,umren,umrez,plnme,vgwrt01,vgwrteh01,vgwrt02,vgwrteh02,vgwrt03,vgwrteh03,vgwrt04,vgwrteh04,vgwrt05,vgwrteh05,vgwrt06,vgwrteh06
    from sipm171 t1
    where t1.del=0 and t1.wkaid<>'3'
        and t1.pbompkgid = v_id;
        
        
        
        

    insert into sipm196 (id,no,syncdataitemno,syncmsg,pbompkgid,del,wkaid,creator)
    select '01_'||sys_guid(),t1.syncbatchno,t1.partno || '#' || t1.werks,'���������ʾ������·����������'|| t1.partno || '#' || t1.werks || '����δ�ɹ�ͬ��SAP��',t1.publishid,0,'21',v_username
    from sipm191 t1
    left join sipm94_last t2 on t1.partno  = t2.no and t1.werks = t2.werks and t2.tybj<>'1'
    where t1.syncbatchno=v_routebatchno and t2.id is null
    group by t1.syncbatchno,t1.partno,t1.werks,t1.publishid;

    -- д����׼�����
    select count(*) into v_ErrRowCount From sipm196 t where t.no=v_routebatchno;
    if v_ErrRowCount>0 then
          DBMS_OUTPUT.put_line('OOOO');
        v_SQL_Text :=' INSERT INTO ' || BLANKS || ' (fresult, frows, fmsg, fmidtablelist) values(''Failure'', 0, ''����·������׼��ʧ��kkk��'', '''')';
    else
        -- �������ϴ���������ʱ��
        v_SQL_Text := ' create table ' || ' T_IN_' || v_syncbatchno
            || ' as '
            || ' select id,syncbatchno,syncdataitemno,id as sipmid,syncbatchno as ztime,partno || ''#'' || werks || ''#'' || zversion as routid '
            || '     ,partno as matnr,werks,zversion,vornr,plantext,verwe,statu,arbpl,frdlb,ekorg,matkl,ekgrp,sakto,steus,ltxa1,ltxa2,splim,zwnor,zeiwn,bmsch,meinh,umren,umrez,plnme,vgwrt01,vgwrteh01,vgwrt02,vgwrteh02,vgwrt03,vgwrteh03,vgwrt04,vgwrteh04,vgwrt05,vgwrteh05,vgwrt06,vgwrteh06 '
            || ' from sipm191 '
            || ' where SyncBatchNo=''' || v_routebatchno || '''';
        execute immediate v_SQL_Text;
        v_RowCount:=sql%rowcount;
        v_MidTableList := 'T_IN_' || v_syncbatchno;

    /*
        insert into sipm196 (id,no,syncdataitemno,syncmsg )
        select '01_'||SYS_GUID(),t.syncbatchno,t.syncdataitemno,'���������ʾ��������:' || t.syncdataitemno ||'��/���췽ʽ/�գ�'
        from sipm190 t
        where t.syncbatchno=v_routebatchno and t.SOURCE is null;

        insert into sipm196 (id,no,syncdataitemno,syncmsg )
        select '01_'||SYS_GUID(),t.syncbatchno,t.syncdataitemno,'���������ʾ��������:' || t.syncdataitemno ||'��/�̶������/����ֵ��'
        from sipm190 t
        where t.syncbatchno=v_routebatchno and not regexp_like(t.RATE, '^{0,9}[[:digit:]]{0,1}[\.]{0,6}[[:digit:]]$');
    */

        v_SQL_Text :=' INSERT INTO ' || BLANKS || ' (fresult, frows,fmsg,fmidtablelist) values( ''Success'', ' || to_char(v_RowCount) || ', ''����·������׼����ɡ�����' || to_char(v_RowCount) || '�С�'', '''|| v_MidTableList || ''')';
    end if;
    EXECUTE immediate v_SQL_Text;
    COMMIT;

    -- RAISE v_ErrRaise;

EXCEPTION
    when v_ErrRaise then
        v_ErrCode := to_char(SQLCODE);
        v_ErrMsg := SUBSTR(SQLERRM, 1, 200);
        rollback;
        insert into sipm196 (id,no,syncmsg,pbompkgid,del,wkaid,creator )
        values ('01_'||SYS_GUID(),v_routebatchno,'���������ʾ������·������׼���쳣��������룺' || v_ErrCode || '��������Ϣ��' || v_ErrMsg || '��',v_id,0,'21',v_username);
        v_SQL_Text :=' INSERT INTO ' || BLANKS || ' (fresult, frows, fmsg, fmidtablelist) values(''Failure'', 0, ''����·������׼��ʧ�ܡ�'', '''')';
        execute immediate v_SQL_Text;
        commit;
    when others then
        v_ErrCode := SQLCODE;
        v_ErrMsg := SUBSTR(SQLERRM, 1, 200);
        rollback;
        insert into sipm196 (id,no,syncmsg,pbompkgid,del,wkaid,creator )
        values ('01_'||SYS_GUID(),v_routebatchno,'���������ʾ������·������׼���쳣��������룺' || v_ErrCode || '��������Ϣ��' || v_ErrMsg || '��',v_id,0,'21',v_username);
        v_SQL_Text :=' INSERT INTO ' || BLANKS || ' (fresult, frows, fmsg, fmidtablelist) values(''Failure'', 0, ''����·������׼��ʧ�ܡ�'', '''')';
        execute immediate v_SQL_Text;
        commit;
END ;


 
/
