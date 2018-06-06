select * from formtable_main_796; --出差

select * from formtable_main_795;

select * from formtable_main_805 a
inner join formtable_main_805_dt1 b
on  a.id=b.mainid;

create or replace view v_kqlc as
select requestid,resourceid as userid,lastname,'请假' as lx,fromdate as ksrq,fromtime as kssj,todate as jsrq,totime as jssj,leavedays*4 as sc
from 	Bill_BoHaiLeave a
left join hrmresource b
on a.resourceid=b.id
  where b.subcompanyid1 in (922,923,901)
union all
select requestid,sqr as userid,lastname,'出差' as lx,sjchksrq as ksrq,sjchkssj as kssj,sjchjsrq as jsrq,sjchjssj as jssj,sjchts*8 as sc
from formtable_main_796 a
left join hrmresource b
on a.sqr=b.id
where b.subcompanyid1 in (922,923,901)
union all
select requestid,sqr as userid,lastname,'异常考勤' as lx,b.bkrq as ksrq,b.bkkssj as kssj,b.bkrq as jsrq,b.bksjsj as jssj,8 as sc from formtable_main_805 a
inner join formtable_main_805_dt1 b
on  a.id=b.mainid
left join hrmresource c
on a.sqr=c.id
where c.subcompanyid1 in (922,923,901)
;

select * from v_kqlc where ksrq<='2018-03-31' and ksrq>='2018-03-01';

select xm,rq,qdsj,qtsj,Jscqsc(rq,QDSJ,rq,QTSJ) as yc,
'请假' as qj,b.ksrq as qjksrq,b.jsrq as qjjsr,
'出差'as cc,c.ksrq as ccksrq,c.jsrq as ccjsrq,
  '异常考勤' as kqyc,d.ksrq as ycksrq,d.jsrq as ycjsrq
from uf_kqsj a
left join ECOLOGY.v_kqlc b
on a.xm=b.userid and b.lx='请假' and rq>=b.ksrq and rq<=b.jsrq
left join ECOLOGY.v_kqlc c
on a.xm=c.userid and c.lx='出差' and rq>=c.ksrq and rq<=c.jsrq
left join ECOLOGY.v_kqlc d
on a.xm=d.userid and d.lx='异常考勤' and rq>=d.ksrq and rq<=d.jsrq
where xm='6049';

create or replace function Jscqsc(startdate varchar2(20),starttime varchar2(20),enddate varchar2(20),endtime varchar2(20))
  return integer is
  declare res integer;
  begin
--     if startdate is not null and starttime is not null and enddate is not null and endtime is not null then
--        select floor(to_date(enddate+' '+endtime,'YYYY-MM-DD HH24:MI')-to_date(startdate+' '+starttime,'YYYY-MM-DD HH24:MI')) into res from dual;
--       else
        select 0 into res from dual;
--     end if;
    return res;
   end ;

 select Jscqsc('2018-03-31','09:00','2018-03-31','18:00') into res from dual;

update uf_kqsj set rq=replace(rq,'2018-05','2018-03');
commit;


select * from hrmsubcompany where id in (922,923,901);
