
----------常用--------------
select (select workflowname from workflow_base where id=workflowid)as workflowname,
(select lastname from hrmresource where id=creater)as creatername,
(select subcompanyname from HrmSubCompany where id=(select subcompanyid1 from hrmresource where id=creater))  as companyname,
createdate,lastoperatedate,workflowid,requestid,creater,currentnodetype
from workflow_requestbase w
where w.createdate>='2016-07-01' and w.createdate<'2016-08-01' 
--and creater=1
--order by w.createdate 

select * from workflow_requestbase
select * from workflow_base
select * from workflow_type


----根据流程类型、发起人所属公司按月统计发起流程数量
select
(select typename from workflow_type where id=workflowtype)as workflowtype,
--(select workflowname from workflow_base where id=workflowid)as workflowname,
--t.companyid,
(select subcompanyname from HrmSubCompany where id=t.companyid) as companyname,
count(requestid) as num--,createdate
from
(
select 
(select workflowtype from workflow_base where id=workflowid) as workflowtype,
workflowid,(select id from HrmSubCompany where id=(select subcompanyid1 from hrmresource where id=creater))  as companyid,
createdate,lastoperatedate,requestid,creater
from workflow_requestbase w
where w.createdate>='2016-12-01' and w.createdate<='2016-12-31'
) t
group by workflowtype,companyid--,createdate



----根据流程名、发起人所属公司按月统计发起流程数量
select
(select workflowname from workflow_base where id=workflowid)as workflowname,
(select subcompanyname from HrmSubCompany where id=t.companyid) as companyname,
count(requestid) as num from
(
select (select workflowtype from workflow_base where id=workflowid) as workflowtype,
workflowid,(select id from HrmSubCompany where id=(select subcompanyid1 from hrmresource where id=creater))  as companyid,
createdate,lastoperatedate,requestid,creater
from workflow_requestbase w
where w.createdate>='2016-07-01' and w.createdate<'2016-08-01'
) t
group by workflowid,companyid

----根据发起人所属公司按月统计发起流程数量、归档数量、被退回过流程数量、审批超过15天
select t.companyid,
       (select workflowname from workflow_base where id = workflowid) as 流程名,
       (select subcompanyname from HrmSubCompany where id = t.companyid) as 公司名,
       count(requestid) as 发起,
       sum(case
             when currentnodetype = 3 then
              1
             else
              0s
           end) as 归档,
       sum(case
             when currentnodetype = 3 then
              0
             else
              1
           end) as 未归档,
       sum(case
             when hours >= 15 * 24 then
              1
             else
              0
           end) as 超过15天,
       sum(case
             when thcs = 0 or thcs is null then
              0
             else
              1
           end) as 退回流程数量,
       sum(thcs) as 退回次数
  from (select (select workflowtype from workflow_base where id = workflowid) as workflowtype,
               workflowid,
               (select id
                  from HrmSubCompany
                 where id = (select subcompanyid1
                               from hrmresource
                              where id = creater)) as companyid,
               createdate,
               lastoperatedate,
               requestid,
               creater,
               currentnodetype,
               Datediff('h',w.createdate||' '||w.createtime,w.lastoperatedate||' '||w.lastoperatetime) as hours,
               (select sum(case
                             when logtype = '3' then
                              1
                             else
                              0
                           end)
                  from workflow_requestLog
                 where requestid = w.requestid) as thcs
          from workflow_requestbase w
         where w.createdate >= '2016-01-01'
           and w.createdate < '2016-11-30') t
 group by companyid, workflowid



select * from workflow_requestlog
select datediff('h',createdate||' '||createtime,lastoperatedate||' '||lastoperatetime) from workflow_requestbase;



 
