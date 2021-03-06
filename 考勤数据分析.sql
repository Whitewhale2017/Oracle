select * from HRMSUBCOMPANY
commit;
drop function Jscqsc;

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
select requestid,resourceid as userid,lastname,'请假' as lx,fromdate as ksrq,fromtime as kssj,todate as jsrq,totime as jssj,leavedays*4 as sc,
case NEWLEAVETYPE when 28 then 0
                   when -12 then 1
                   when  -6 then 2
                   when 29 then 3
                   when -13 then 4
                   when 33 then 5
                   when 36 then 6
                   when 34 then 7
                   when 39 then 8
                   when 35 then 9
                   when 40 then 10
                   end
 as sm
--  28 病假 -12带薪病假 -6法定年假 29事假 -13调休 33丧假 36婚假 34哺乳假 39工伤假 35产假及看护假 40司龄年假
--       0       1          2        3      4      5     6      7         8          9           10
from 	Bill_BoHaiLeave a
left join hrmresource b
on a.resourceid=b.id
where b.subcompanyid1 in (922,923,901,921)
union all
select requestid,sqr as userid,lastname,'出差' as lx,sjchksrq as ksrq,sjchkssj as kssj,sjchjsrq as jsrq,sjchjssj as jssj,sjchts*8 as sc,
 case ccfw when 0 then 11 when 1 then 12 end as sm

 ---- 国内出差 国外出差
 ----    11      12
from formtable_main_796 a
left join hrmresource b
on a.sqr=b.id
where b.subcompanyid1 in (922,923,901,921)
union all
select requestid,sqr as userid,lastname,'市内外出' as lx,WCRQ as ksrq,SQKSSJ as kssj,WCRQ as jsrq,SQFHSJ as jssj,8 as sc,13 as sm
--市内外出
--  13
from formtable_main_795 a
left join hrmresource b
on a.sqr=b.id
where b.subcompanyid1 in (922,923,901,921)
union all
select requestid,sqr as userid,lastname,'异常考勤' as lx,b.bkrq as ksrq,b.bkkssj as kssj,b.bkrq as jsrq,b.bksjsj as jssj,8 as sc,
case b.BKLX
when 0 then 14
when 1 then 15
when 2 then 16
when 3 then 17
end as sm
--忘记打卡 迟到/早退（因交通、恶劣天气等原因） 迟到/早退（其他原因） 迟到
--   14      15                                   16              17
from formtable_main_805 a
inner join formtable_main_805_dt1 b
on  a.id=b.mainid
left join hrmresource c
on a.sqr=c.id
where c.subcompanyid1 in (922,923,901,921)
--注意：视图结尾加分号执行即报错ORA-00911
drop view v_kqlc;

-- select * from v_kqlc;

create or replace view v_kqsjhz as
select xm,rq,qdsj,qtsj,Jscqsc(rq,QDSJ,rq,QTSJ) as cqsc,
  case when ((QDSJ is null) or (QDSJ='')) and ((QTSJ is null) or (QTSJ='')) then 0
        when (QDSJ is null) or (QDSJ='') then 1
        when (QTSJ is null) or (QTSJ='') then 2
        when QDSJ>'09:05' then 3
        when QTSJ<'18:00' then 4
          else 5
            end as dkqk,
b.REQUESTID as qjlc,b.ksrq as qjksrq,b.jsrq as qjjsrq,
c.REQUESTID as cclc,c.ksrq as ccksrq,c.jsrq as ccjsrq,
d.REQUESTID as kqyclc,d.ksrq as ycksrq,d.jsrq as ycjsrq,
e.REQUESTID as snwclc,e.ksrq as snwcksrq,e.jsrq as snwcjsrq,
  case when b.REQUESTID is not null then b.requestid
       when b.REQUESTID is null and c.REQUESTID is not null then c.REQUESTID
       when b.REQUESTID is  null and c.REQUESTID is null and e.REQUESTID is not null then e.REQUESTID
       when b.REQUESTID is  null and c.REQUESTID is null and d.REQUESTID is not null  and e.REQUESTID is  null then d.REQUESTID
      else null
      end as jglc,
    case when b.REQUESTID is not null then 0
       when b.REQUESTID is null and c.REQUESTID is not null then 1
       when b.REQUESTID is  null and c.REQUESTID is null and d.REQUESTID is not null and e.REQUESTID is null then 3
       when b.REQUESTID is null and c.REQUESTID is null and e.REQUESTID is not null then 2
    else null end as bklx
from uf_kqsj a
left join v_kqlc b
on a.xm=b.userid and b.lx='请假' and rq>=b.ksrq and rq<=b.jsrq
left join v_kqlc c
on a.xm=c.userid and c.lx='出差' and rq>=c.ksrq and rq<=c.jsrq
left join v_kqlc d
on a.xm=d.userid and d.lx='异常考勤' and rq>=d.ksrq and rq<=d.jsrq
left join v_kqlc e
on a.xm=e.userid and e.lx='市内外出' and rq>=e.ksrq and rq<=e.jsrq --注意：视图结尾加分号执行即报错ORA-00911


drop view v_kqsjhz;

select * from v_kqsjhz where bklx=3
--最终结果
create or replace view v_kqjg as
select xm,rq,qdsj,qtsj,dkqk,
  case when cqsc<9 and qjlc is null and cclc is null and kqyclc is null and snwclc is  null then 0
        else 1
    end as CQJG,jglc,ksrq,kssj,jsrq,jssj,bklx,sm
from v_kqsjhz
left join v_kqlc
  on jglc=requestid and rq>=ksrq and rq <=jsrq

drop view v_kqsjhz;

select * from v_kqjg where bklx is  not null;

select lastname,STARTDATE from hrmresource where STARTDATE>='2018-06-10';

select * from HRMANNUALMANAGEMENT where RESOURCEID = 6305;--年假

update HRMANNUALMANAGEMENT set ANNUALDAYS = 99 where RESOURCEID = (select id from HRMRESOURCE where WORKCODE = '100933') and ANNUALYEAR = 2018;

commit;
--带薪病假
update HRMPSLMANAGEMENT set PSLDAYS = 3 where RESOURCEID in (78,2646,232,2241,141) and PSLYEAR = '2018';

select * from HRMPSLMANAGEMENT where RESOURCEID = 6305;

update HRMPSLMANAGEMENT set PSLDAYS = 22 where RESOURCEID = (select id from HRMRESOURCE where WORKCODE = '100933') and PSLYEAR = 2018;

select id,lastname,workcode,SUBCOMPANYID1 from HRMRESOURCE where lastname like '王阳%';

select * from HRMSUBCOMPANY