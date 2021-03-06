----生成日历---------------
SELECT to_date('20190101','yyyymmdd') + level-1 as everyDay from dual 
connect by level <= 
(last_day(to_date('20191201','yyyymmdd')) - to_date('20190101','yyyymmdd') +1);

select last_day(to_date('20191201','yyyymmdd')) from dual;

select (last_day(to_date('20191201','yyyymmdd')) - to_date('20190101','yyyymmdd') +1) from dual;

select to_date('20190101','yyyymmdd')+31 from dual;

-----------------------------------------生成月份----------

select to_char(add_months(start_date, (level - 1)), 'yyyymm') stat_date,
       0 as kw_num
  from (select add_months(trunc(sysdate, 'y'), -12) as start_date,
               add_months(trunc(sysdate, 'y'), 12) as end_date
          from dual)
connect by level < = months_between(end_date, start_date);

SELECT 2020,LPAD(LEVEL,2,0) AS MONTH FROM DUAL
CONNECT BY LEVEL<13
