-- select * from formtable_main_796; --出差
--
-- select * from formtable_main_795;
--
-- select * from formtable_main_805 a
-- inner join formtable_main_805_dt1 b
-- on  a.id=b.mainid;

create or replace function Jscqsc(startdate varchar2,starttime varchar2,enddate varchar2,endtime varchar2)
  return integer is
  res integer;
  begin
    if startdate is not null and starttime is not null and enddate is not null and endtime is not null then
        select floor((to_date(enddate||' '||endtime,'YYYY-MM-DD HH24:MI')-to_date(startdate||' '||starttime,'YYYY-MM-DD HH24:MI'))*24)into res from dual;
       else
        select 0 into res from dual;
     end if;
    return res;
   end Jscqsc;


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


create or replace view v_kqsjhz
  as
select xm,rq,qdsj,qtsj,Jscqsc(rq,QDSJ,rq,QTSJ) as cqsc,
  case when ((QDSJ is null) or (QDSJ='')) and ((QTSJ is null) or (QTSJ='')) then '缺勤'
        when (QDSJ is null) or (QDSJ='') then '未签到'
        when (QTSJ is null) or (QTSJ='') then '未签退'
        when QDSJ>'09:05' then '迟到'
        when QTSJ<'18:00' then '早退'
          else '正常'
            end as dkqk,
b.REQUESTID as qjlc,b.ksrq as qjksrq,b.jsrq as qjjsr,
c.REQUESTID as cclc,c.ksrq as ccksrq,c.jsrq as ccjsrq,
d.REQUESTID as kqyclc,d.ksrq as ycksrq,d.jsrq as ycjsrq,
  case when b.REQUESTID is not null then b.requestid
       when b.REQUESTID is null and c.REQUESTID is not null then c.REQUESTID
       when b.REQUESTID is  null and c.REQUESTID is null and d.REQUESTID is not null then d.REQUESTID
    else null end as jglc,
    case when b.REQUESTID is not null then '请假'
       when b.REQUESTID is null and c.REQUESTID is not null then '出差'
       when b.REQUESTID is  null and c.REQUESTID is null and d.REQUESTID is not null then '异常考勤'
    else null end as bklx
from uf_kqsj a
left join ECOLOGY.v_kqlc b
on a.xm=b.userid and b.lx='请假' and rq>=b.ksrq and rq<=b.jsrq
left join ECOLOGY.v_kqlc c
on a.xm=c.userid and c.lx='出差' and rq>=c.ksrq and rq<=c.jsrq
left join ECOLOGY.v_kqlc d
on a.xm=d.userid and d.lx='异常考勤' and rq>=d.ksrq and rq<=d.jsrq;

select * from v_kqsjhz;
--最终结果
select xm,rq,qdsj,qtsj,dkqk,
  case when cqsc<9 and qjlc is null and cclc is null and kqyclc is null then '异常'
        else '正常'
    end as CQJG,jglc,ksrq,kssj,jsrq,jssj,bklx
from v_kqsjhz
left join v_kqlc
  on jglc=requestid;

