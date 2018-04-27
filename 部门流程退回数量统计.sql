select d.departmentname|| '(' || e.subcompanydesc|| ')' as bm, thcs
  from (
        select count(b.requestid) as thcs, c.departmentid, c.subcompanyid1
          from workflow_requestbase a
          left join workflow_requestLog b
            on a.requestid = b.requestid
          left join HrmResource c
            on a.creater = c.id
         Where 1 = 1
           and logtype = '3'
           and a.createdate >= '2014-01-01'
           and a.createdate <= '2018-06-14'
         group by c.departmentid, c.subcompanyid1
         ) a
  left join HrmDepartment d
    on a.departmentid = d.id
  left join HrmSubCompany e
    on a.subcompanyid1 = e.id
  where rownum<=10
  order by thcs desc;
