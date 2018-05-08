
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
group by workflowid,companyid;

----根据发起人所属公司按月统计发起流程数量、归档数量、被退回过流程数量、审批超过15天
select t.companyid,
       (select WORKFLOW_BASE.workflowname from workflow_base where WORKFLOW_BASE.id = t.workflowid) as 流程名,
       (select HRMSUBCOMPANY.subcompanyname from HrmSubCompany where HRMSUBCOMPANY.id = t.companyid) as 公司名,
       count(t.requestid) as 发起,
       sum(case
             when t.currentnodetype = 3 then
              1
             else
              0
           end) as 归档,
       sum(case
             when t.currentnodetype = 3 then
              0
             else
              1
           end) as 未归档,
       sum(case
             when t.hours >= 15 * 24 then
              1
             else
              0
           end) as 超过15天,
       sum(case
             when t.thcs = 0 or t.thcs is null then
              0
             else
              1
           end) as 退回流程数量,
       sum(t.thcs) as 退回次数
  from (select (select WORKFLOW_BASE.workflowtype from workflow_base where WORKFLOW_BASE.id = w.workflowid) as workflowtype,
               w.workflowid,
               (select HRMSUBCOMPANY.id
                  from HrmSubCompany
                 where HRMSUBCOMPANY.id = (select HRMRESOURCE.subcompanyid1
                               from hrmresource
                              where id = w.creater)) as companyid,
               w.createdate,
               w.lastoperatedate,
               w.requestid,
               w.creater,
               w.currentnodetype,
               Datediff('h',w.createdate||' '||w.createtime,w.lastoperatedate||' '||w.lastoperatetime) as hours,
               (select sum(case
                             when WORKFLOW_REQUESTLOG.logtype = '3' then
                              1
                             else
                              0
                           end)
                  from workflow_requestLog
                 where requestid = w.requestid) as thcs
          from workflow_requestbase w
         where w.createdate >= '2014-01-01'
           and w.createdate <= '2018-11-30') t
 group by t.companyid,t.WORKFLOWID
;


select * from workflow_requestbase;
select datediff('h',createdate||' '||createtime,lastoperatedate||' '||lastoperatetime) from workflow_requestbase;



 
