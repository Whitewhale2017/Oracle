select * from matrixinfo;

select * from MATRIXTABLE_40;

select * from MATRIXTABLE_2;

select a.*,b.BMFZR,b.BMFG from MATRIXTABLE_2 a
inner join v_gn_bm b
  on a.id=b.BM;

update MATRIXTABLE_2 a set bmfzr=(select bmfzr from MATRIXTABLE_40 b where a.id=b.bm)
where a.id in (select bm from MATRIXTABLE_40);

----数据初始化-------
update MATRIXTABLE_2 a set (bmfzr,BMFGLD)=(select bmfzr,BMFG from v_gn_bm b where a.id=b.bm)
where a.id in (select bm from v_gn_bm);

create or replace view v_gn_bm
  as
  select '贵酒云' as jzmc,bm,bmfzr, BMFG from MATRIXTABLE_40
  union all
  select '营销中心' as jzmc,bm,BMFZR,'' as bmfg from MATRIXTABLE_39;

select * from v_gn_bm;

-----监控自定义矩阵表------
create or replace trigger tri_bmjz_jk
  after insert or update
  on matrixtable_40
  begin
    update MATRIXTABLE_2 set BMFZR= :new.bmfzr,bmfgld= :new.bmfg where id = :new.bm;
    update HRMDEPARTMENTDEFINED set bmfz= :new.BMFZR,BMFGLD= :new.BMFG where DEPTID = :new.bm;
  end;

  select * from HRMDEPARTMENTDEFINED;