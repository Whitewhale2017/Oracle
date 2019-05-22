CREATE OR REPLACE PROCEDURE proc_init_sapview(blanks nvarchar2, v_pbompkgid varchar2, v_operator nvarchar2)
AS
    v_pbompkgno nvarchar2(100);
    v_SQL_Text varchar(4000);
    v_RowCount number(9);
    v_ErrRowCount number(9);
    v_ErrRaise EXCEPTION;
    v_ErrCode varchar2(20);
    v_ErrMsg varchar2(2000);
    v_ERPState varchar2(2000);
    v_state varchar2(1);
BEGIN

    -- 创建临时表,存放存储过程执行结果反馈消息
    v_SQL_Text:= 'create table ' || BLANKS || ' (FRESULT nvarchar2(20),FROWS nvarchar2(9),fmsg nvarchar2(2000),fmidtablelist nvarchar2(2000))';
    execute immediate v_SQL_Text;

    if v_pbompkgid like 'WK%' THEN
        select count(*), max(t1.no), max(t1.erpstate) into v_rowcount, v_pbompkgno, v_ERPState from wk_pbompkg t1 where t1.id=v_pbompkgid and t1.del = 0;
    else
        select count(*), max(t1.no), max(t1.erpstate) into v_rowcount, v_pbompkgno, v_ERPState from pbompkg t1 where t1.id=v_pbompkgid and t1.del = 0;
    end if;

    IF v_ERPState = '1' THEN
        delete sipm196 where no = v_pbompkgno;
        delete sipm196 where pbompkgid = v_pbompkgid;
        insert into sipm196 (id,pbompkgid,no,syncmsg )
        values ('01_'||SYS_GUID(),v_pbompkgid,v_pbompkgno,'SAP视图初始化失败。已经传SAP成功的数据包不允许再次初始化。');
        v_SQL_Text :=' INSERT INTO ' || BLANKS || ' (fresult, frows, fmsg, fmidtablelist) values(''Failure'', 0, ''SAP视图初始化失败！'', '''')';
        EXECUTE immediate v_SQL_Text;
        commit;
        return;
    END IF;
    
    if v_rowcount > 0 then
        delete sipm196 where no = v_pbompkgno;
        select count(*),max(t1.state) into v_rowcount,v_state from wk_partlib t1 where t1.pbompkgid=v_pbompkgid and del = 0;
        if v_rowcount > 0 and v_state = 'D' then   -- 数据尚未提交
            -- 按PLM传入的大、中、小类名称，生成大、中、小类代号
            update wk_partlib sk
            set (mtart,extwg,matkl) = (select t1.class1no,t1.class2no,t1.class3no from sapi_partclass t1 where sk.mtartname = t1.class1name and sk.extwgname = t1.class2name and sk.matklname = t1.class3name and sk.pbompkgid = v_pbompkgid)
            where exists(select 1 from sapi_partclass t1 where sk.mtartname = t1.class1name and sk.extwgname = t1.class2name and sk.matklname = t1.class3name and sk.pbompkgid = v_pbompkgid);

            -- 修正前端传入数据
            update wk_partlib
            set maktx= replace(maktx,'□','')
                ,tdline= replace(tdline,'□','')
                ,zauth= replace(zauth,'□','')
                ,zbranch= replace(zbranch,'□','')
                ,zcolor= replace(zcolor,'□','')
                ,zmanual= replace(zmanual,'□','')
                ,zpackage= replace(zpackage,'□','')
                ,zpaper= replace(zpaper,'□','')
                ,zrohs= replace(zrohs,'□','')
                ,zsize= replace(zsize,'□','')
                ,ztype= replace(ztype,'□','')
                ,zversion= replace(zversion,'□','')
                ,unit= coalesce(unit,meins)
                ,meins= coalesce(unit,meins)
                ,zind=coalesce(ptype,zind) -- 专用通用
                ,mstae = case when oldno is not null then 'Z1' else null end
                ,mtpos = 'NORM'
            where pbompkgid=v_pbompkgid and del=0;
            commit;

            -- 清空指定数据包SAP视图数据
            proc_init_sapview_clear (blanks, v_pbompkgid, v_pbompkgno, v_operator);

            delete sapitmp_partlib_lssj where pbompkgid = pbompkgid;
            insert into sapitmp_partlib_lssj(pbompkgid,mtart,extwg,matkl,no,werks
                ,id,del, wkaid, msym, designno, bldesignno,name, ver, ename, ptype, creator, ctime, owner, state, smemo
                ,lssjsign
                ,extwgname,matklname,tdline)
            select distinct t1.pbompkgid,t1.mtart,t1.extwg,t1.matkl,t1.no,t1.werks
                ,t1.id,t1.del, t1.wkaid, t1.msym, t1.designno, t1.bldesignno, t1.name, t1.ver, t1.ename, t1.ptype, t1.creator, t1.ctime, t1.owner, t1.state, t1.smemo
                ,0
                ,t1.extwgname,t1.matklname,t1.tdline
            from wk_partlib t1
            left join sapitmp_partlib_lssj t2 on t1.pbompkgid = t2.pbompkgid and t1.no = t2.no and t1.werks = t2.werks
            where t1.pbompkgid = v_pbompkgid and t1.del = 0
               and t2.id is null;

            update sapitmp_partlib_lssj sk
            set lssjsign = 2, vcno = substr(no,1,10)   -- lssjsign = 2表示有VC件历史数据
            where exists (
                select 1
                from sipm190_last t2
                where t2.no NOT like '%X%' AND t2.no NOT like '%M%' AND sk.no LIKE t2.no || '%' and sk.werks = t2.werks and sk.pbompkgid = v_pbompkgid
                );
                
            update sapitmp_partlib_lssj sk
            set lssjsign = 1, vcno=no                  -- lssjsign = 1表示有物料编号本身的历史数据
            where exists (
                select 1
                from sipm190_last t2
                where sk.no = t2.no and sk.werks = t2.werks and sk.pbompkgid = v_pbompkgid
                );
            commit;
    
            -- 从SIPM190_last获取最新传SAP成功的SAP视图数据
            proc_init_sapview_hqlssj(v_pbompkgid, v_pbompkgno, v_operator);
            select count(*) into v_errrowcount from sipm196 t where t.no=v_pbompkgno;
            if v_errrowcount=0 then
                -- 从partlib_mdl获取模板定义的SAP视图数据
                proc_init_sapview_hqmbsj(v_pbompkgid, v_pbompkgno, v_operator);
                select count(*) into v_errrowcount from sipm196 t where t.no=v_pbompkgno;
                if v_errrowcount=0 then
                    -- 从本数据包的SAP视图,创建关系数据
                    proc_init_sapview_cjgxsj(v_pbompkgid, v_pbompkgno, v_operator);
                else
                    v_SQL_Text :=' INSERT INTO ' || BLANKS || ' (fresult, frows,fmsg) values ( ''Failure'', 0,''从模板表格初始化SAP视图失败！'')';
                    execute immediate v_SQL_Text;
                    commit;
                    return;
                end if;
            else
                v_SQL_Text :=' INSERT INTO ' || BLANKS || ' (fresult, frows,fmsg) values ( ''Failure'', 0,''从历史数据初始化SAP视图失败！'')';
                execute immediate v_SQL_Text;
                commit;
                return;
            end if;
            
            -- 用前端传入值,设置:采购长文本
            update WK_SIPM91 sk
            set sk.ztdline1 = (select t1.tdline from wk_partlib t1 where t1.del = 0 and t1.wkaid<>'3' and sk.del = 0 and sk.wkaid<>'3' and sk.pbompkgid = v_pbompkgid and sk.pbompkgid = t1.pbompkgid and sk.no = t1.no and sk.werks = t1.werks)
            where exists(select t1.tdline from wk_partlib t1 where t1.del = 0 and t1.wkaid<>'3' and sk.del = 0 and sk.wkaid<>'3' and sk.pbompkgid = v_pbompkgid and sk.pbompkgid = t1.pbompkgid and sk.no = t1.no and sk.werks = t1.werks);

            -- 用前端传入值,设置:销售长文本
            update WK_SIPM92 sk
            set sk.ztdline2 = (select t1.tdline from wk_partlib t1 where t1.del = 0 and t1.wkaid<>'3' and sk.del = 0 and sk.wkaid<>'3' and sk.pbompkgid = v_pbompkgid and sk.pbompkgid = t1.pbompkgid and sk.no = t1.no and sk.werks = t1.werks)
            where exists(select t1.tdline from wk_partlib t1 where t1.del = 0 and t1.wkaid<>'3' and sk.del = 0 and sk.wkaid<>'3' and sk.pbompkgid = v_pbompkgid and sk.pbompkgid = t1.pbompkgid and sk.no = t1.no and sk.werks = t1.werks);

            -- 用前端传入值,设置:后继物料
            update WK_SIPM94 sk
            set sk.NFMAT = (select t1.NFMAT from wk_partlib t1 where t1.del = 0 and t1.wkaid<>'3' and sk.del = 0 and sk.wkaid<>'3' and sk.pbompkgid = v_pbompkgid and sk.pbompkgid = t1.pbompkgid and sk.no = t1.no and sk.werks = t1.werks)
            where exists(select t1.NFMAT from wk_partlib t1 where t1.del = 0 and t1.wkaid<>'3' and sk.del = 0 and sk.wkaid<>'3' and sk.pbompkgid = v_pbompkgid and sk.pbompkgid = t1.pbompkgid and sk.no = t1.no and sk.werks = t1.werks);

            delete sapitmp_partlib_lssj where pbompkgid = v_pbompkgid;
            commit;

            proc_chk_pbom_partlib(v_pbompkgid, v_pbompkgno, v_operator);
            select count(*) into v_errrowcount from sipm196 t where t.no=v_pbompkgno;
            if v_errrowcount>0 then
                v_sql_text :=' insert into ' || blanks || ' (fresult, frows, fmsg, fmidtablelist) values(''Failure'', 0, ''SAP视图初始化失败。'', '''')';
                execute immediate v_sql_text;
                commit;
                return;
            end if;
            if v_pbompkgid like 'WK%' THEN
                update wk_pbompkg set sdec='工作区数据包SAP视图初始化时间' || to_char(sysdate,'YYYY-MM-DD HH12:MI:SS AM') where id=v_pbompkgid and del = 0;
            else
                update pbompkg set sdec='归档区SAP视图初始化时间' || to_char(sysdate,'YYYY-MM-DD HH12:MI:SS AM') where id=v_pbompkgid and del = 0;
            end if;
            v_SQL_Text :=' INSERT INTO ' || BLANKS || ' (fresult, frows,fmsg) values ( ''Success'', ' || to_char(v_rowcount) || ', ''SAP视图初始化成功。'')';
            execute immediate v_SQL_Text;
            commit;
        else
            insert into sipm196 (id,pbompkgid,no,syncmsg )
            values ('01_'||SYS_GUID(),v_pbompkgid,v_pbompkgno,'SAP视图初始化失败，选定数据包没有需要初始化的发布物料！');
            v_SQL_Text :=' INSERT INTO ' || BLANKS || ' (fresult, frows,fmsg) values ( ''Failure'', ' || to_char(v_rowcount) || ', ''SAP视图初始化失败。'')';
            execute immediate v_SQL_Text;
            commit;
        end if;
    end if;

    return;

EXCEPTION
    when v_ErrRaise then
        v_ErrCode := to_char(SQLCODE);
        v_ErrMsg := SUBSTR(SQLERRM, 1, 200);
        rollback;
        insert into sipm196 (id,pbompkgid,no,syncmsg )
        values ('01_'||SYS_GUID(),v_pbompkgid,v_pbompkgno,'SAP视图初始化失败。错误代码：' || v_ErrCode || '；错误消息：' || v_ErrMsg || '。');
        v_SQL_Text :=' INSERT INTO ' || BLANKS || ' (fresult, frows, fmsg, fmidtablelist) values(''Failure'', 0, ''SAP视图初始化失败！'', '''')';
        EXECUTE immediate v_SQL_Text;
        commit;
    when others then
        v_ErrCode := SQLCODE;
        v_ErrMsg := SUBSTR(SQLERRM, 1, 200);
        rollback;
        insert into sipm196 (id,pbompkgid,no,syncmsg )
        values ('01_'||SYS_GUID(),v_pbompkgid,v_pbompkgno,'SAP视图初始化失败。错误代码：' || v_ErrCode || '；错误消息：' || v_ErrMsg || '。');
         v_SQL_Text :=' INSERT INTO ' || BLANKS || ' (fresult, frows, fmsg, fmidtablelist) values(''Failure'', ' || to_char(v_rowcount) || ', ''SAP视图初始化失败！'', '''')';
        EXECUTE immediate v_SQL_Text;
        commit;
END ;

 

 

 
/
