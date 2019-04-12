select * from SIPM1 where H_NO='DA1940053N'

select * from SIPM3 where H_NO='DA1940053N'

select * from SIPM4 where H_NO like '%1940053%'

select * from SIPM4_OBJOF
--查询ORACLE的历史操作记录
select t.SQL_TEXT, t.FIRST_LOAD_TIME
from v$sqlarea t
 where t.FIRST_LOAD_TIME like '2019-04-0%' and t.SQL_TEXT like '%delete%SIPM4%'
 order by t.FIRST_LOAD_TIME desc
 
 select *
from v$sqlarea t
 where t.FIRST_LOAD_TIME like '2019-04-10%' and t.SQL_TEXT like '%delete%SIPM4%'
 order by t.FIRST_LOAD_TIME desc
