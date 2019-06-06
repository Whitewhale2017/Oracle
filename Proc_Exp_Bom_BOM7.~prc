CREATE OR REPLACE PROCEDURE Proc_Exp_Bom(blanks nvarchar2, v_id nvarchar2, v_objtype nvarchar2, v_interfacelist nvarchar2, v_syncbatchno nvarchar2, v_accid nvarchar2, v_username nvarchar2)
AS
    v_SQL_Text varchar(8000);
    v_MidTableList varchar(4000);
    v_bombatchno varchar(50);   -- BOM批次号
    v_routebatchno varchar(50); -- 工艺路线批次号

    v_ErrRowCount number(9);
    v_ErrRaise EXCEPTION;
    v_ErrCode varchar2(20);
    v_ErrMsg varchar2(2000);
BEGIN
    v_bombatchno := 'B'||v_syncbatchno;
    UPDATE SIPM195 SET ENAME='BOM' WHERE NO=v_syncbatchno;   -- 标记数据包类型

    INSERT INTO BOM10 (ID,PUBLISHTN,PUBLISHID,STN,SID,SYNCBATCHNO,SYNCDATAITEMNO,SYNCUSER
        ,PNO,WERKS,PSPNR,ZCOMPLETE,EMENG,BOMPST,POSTP,CNO,BNUM,AUSCH,ALPGR,ZKEY,ZPOSITION,SMEMO,SANKA
        )
    SELECT '01_'||SYS_GUID(),'PBOMPKG',v_id,'BOM10',T1.ID,V_BOMBATCHNO,T1.NO,V_USERNAME
        ,PNO AS MATNR,WERKS,PSPNR,ZCOMPLETE,EMENG,BOMPST AS POSNR,POSTP,T1.CNO IDNRK,BNUM AS MENGE,AUSCH,ALPGR,ZKEY,ZPOSITION,ZTEXT,SANKA
    FROM PBOMLIB T1
    WHERE T1.DEL=0 --AND T1.WKAID<>'3'
        AND T1.PBOMPKGID = v_id;

    INSERT INTO BOM10 (ID,PUBLISHTN,PUBLISHID,STN,SID,SYNCBATCHNO,SYNCDATAITEMNO,SYNCUSER
        ,PNO,WERKS,PSPNR,ZCOMPLETE,EMENG,BOMPST,POSTP,CNO,BNUM,AUSCH,ALPGR,ZKEY,ZPOSITION,SMEMO,SANKA
        )
    SELECT '01_'||SYS_GUID(),'PBOMPKG',v_id,'BOM10',T1.ID,V_BOMBATCHNO,T1.NO,V_USERNAME
        ,PNO AS MATNR,WERKS,PSPNR,ZCOMPLETE,EMENG,BOMPST AS POSNR,POSTP,T1.CNO IDNRK,BNUM AS MENGE,AUSCH,ALPGR,ZKEY,ZPOSITION,ZTEXT,SANKA
    FROM WK_PBOMLIB T1
    WHERE T1.DEL=0 --AND T1.WKAID<>'3'
        AND T1.PBOMPKGID = v_id;
        ------将扩展1806，1906的数据写到BOM10------------
      INSERT INTO BOM10 (ID,PUBLISHTN,PUBLISHID,STN,SID,SYNCBATCHNO,SYNCDATAITEMNO,SYNCUSER
        ,PNO,WERKS,PSPNR,ZCOMPLETE,EMENG,BOMPST,POSTP,CNO,BNUM,AUSCH,ALPGR,ZKEY,ZPOSITION,SMEMO,SANKA
        )
     SELECT '01_'||SYS_GUID(),'PBOMPKG',v_id,'BOM10',T1.ID,V_BOMBATCHNO,T1.NO,V_USERNAME
        ,PNO AS MATNR,WERKS,PSPNR,ZCOMPLETE,EMENG,BOMPST AS POSNR,POSTP,T1.CNO IDNRK,BNUM AS MENGE,AUSCH,ALPGR,ZKEY,ZPOSITION,ZTEXT,SANKA
     FROM BOM7 T1
     WHERE T1.DEL=0 --AND T1.WKAID<>'3'
     AND T1.PBOMPKGID = v_id;
        

    /*在前面的强制检验算法中已经有了
    insert into sipm196 (id,no,syncdataitemno,syncmsg,pbompkgid,del,wkaid,creator)
    select '01_'||sys_guid(),t1.syncbatchno,t1.pno|| '#'|| t1.werks ,'运算错误提示。母件物料号:' || t1.pno || '疑似未成功同步SAP！',t1.publishid, 0,'21',v_username
    from bom10 t1
    left join sipm94_last t2 on t1.pno  = t2.no and t1.werks = t2.werks and t2.tybj<>'1'
    where t1.syncbatchno=v_bombatchno and t2.id is null
    group by t1.syncbatchno,t1.pno,t1.werks,t1.publishid;

    insert into sipm196 (id,no,syncdataitemno,syncmsg,pbompkgid,del,wkaid,creator)
    select '01_'||sys_guid(),t1.syncbatchno,t1.pno|| '#'|| t1.werks,'运算错误提示。子件物料号:' || t1.cno  ||'疑似未成功同步SAP！',t1.publishid, 0,'21',v_username
    from bom10 t1
    left join sipm94_last t2 on t1.cno  = t2.no and t1.werks = t2.werks and t2.tybj<>'1'
    where t1.syncbatchno=v_bombatchno and t2.id is null
    group by t1.syncbatchno,t1.pno,t1.cno,t1.werks,t1.publishid;
    */

    select count(*) into v_ErrRowCount From sipm196 t where t.no=v_bombatchno;
    if v_ErrRowCount>0 then
        v_SQL_Text :=' INSERT INTO ' || BLANKS || ' (fresult, frows, fmsg, fmidtablelist) values(''Failure'', 0, ''BOM数据准备失败。'', '''')';
    else
        -- 创建物料传输数据临时表
        v_SQL_Text := ' CREATE TABLE ' || ' GT_ITAB_' || v_syncbatchno
            || ' AS '
            || ' SELECT ID,SYNCBATCHNO,SYNCDATAITEMNO,ID AS SIPMID,SYNCBATCHNO AS ZTIME,PNO || ''#'' || WERKS AS BOMID '
            || '     ,PNO AS MATNR,WERKS,PSPNR,ZCOMPLETE,EMENG,BOMPST AS POSNR,POSTP,CNO AS IDNRK,BNUM AS MENGE1,AUSCH,ALPGR,ZKEY,ZPOSITION,SMEMO AS ZTEXT,SANKA '
            || ' FROM BOM10 '
            || ' WHERE SyncBatchNo=''' || v_bombatchno || '''';
        dbms_output.put_line(v_SQL_Text);
        EXECUTE IMMEDIATE v_SQL_Text;
        v_MidTableList := 'GT_ITAB_' || v_syncbatchno;

    /*    v_SQL_Text := ' CREATE TABLE ' || ' GT_ITAB_SK' || v_syncbatchno
            || ' AS '
            || ' SELECT ID,SYNCBATCHNO,SYNCDATAITEMNO,ID AS SIPMID,SYNCBATCHNO AS ZTIME,PNO || ''#'' || WERKS AS BOMID '
            || '     ,PNO AS MATNR,WERKS,PSPNR,ZCOMPLETE,EMENG,BOMPST AS POSNR,POSTP,CNO AS IDNRK,BNUM AS MENGE,AUSCH,ALPGR,ZKEY,ZPOSITION,SMEMO AS ZTEXT,SANKA '
            || ' FROM BOM10 '
            || ' WHERE SyncBatchNo=''' || v_bombatchno || '''';
        EXECUTE IMMEDIATE v_SQL_Text;*/
    /*
        insert into sipm196 (id,no,syncdataitemno,syncmsg )
        select '01_'||SYS_GUID(),t.syncbatchno,t.syncdataitemno,'运算错误提示。数据项:' || t.syncdataitemno ||'的/制造方式/空！'
        from sipm190 t
        where t.syncbatchno=v_bombatchno and t.SOURCE is null;

        insert into sipm196 (id,no,syncdataitemno,syncmsg )
        select '01_'||SYS_GUID(),t.syncbatchno,t.syncdataitemno,'运算错误提示。数据项:' || t.syncdataitemno ||'的/固定损耗率/非数值！'
        from sipm190 t
        where t.syncbatchno=v_bombatchno and not regexp_like(t.RATE, '^{0,9}[[:digit:]]{0,1}[\.]{0,6}[[:digit:]]$');
    */
        -- 写数据准备结果

        v_SQL_Text :=' INSERT INTO ' || BLANKS || ' (fresult, frows,fmsg,fmidtablelist) select ''Success'' as fresult, count(*) as frows, ''BOM数据准备完成。共：'' || to_char(count(*)) || ''行。'' AS fmsg, '''|| v_MidTableList || ''' AS fmidtablelist FROM BOM10 WHERE SyncBatchNo = ''' || v_bombatchno || '''';
    end if;
    EXECUTE immediate v_SQL_Text;
    COMMIT;

    -- RAISE v_ErrRaise;

EXCEPTION
    when v_ErrRaise then
        v_ErrCode := to_char(SQLCODE);
        v_ErrMsg := SUBSTR(SQLERRM, 1, 200);
        rollback;
        insert into sipm196 (id,no,syncmsg,pbompkgid )
        values ('01_'||SYS_GUID(),v_bombatchno,'运算错误提示。BOM数据准备异常。错误代码：' || v_ErrCode || '；错误消息：' || v_ErrMsg || '。',v_id);
        v_SQL_Text :=' INSERT INTO ' || BLANKS || ' (fresult, frows, fmsg, fmidtablelist) values(''Failure'', 0, ''BOM数据准备失败。'', '''')';
        execute immediate v_SQL_Text;
        commit;
    when others then
        v_ErrCode := SQLCODE;
        v_ErrMsg := SUBSTR(SQLERRM, 1, 200);
        rollback;
        insert into sipm196 (id,no,syncmsg,pbompkgid )
        values ('01_'||SYS_GUID(),v_bombatchno,'运算错误提示。BOM数据准备异常。错误代码：' || v_ErrCode || '；错误消息：' || v_ErrMsg || '。',v_id);
        execute immediate v_SQL_Text;
        commit;
END ;


 
/
